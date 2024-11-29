Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA6D70DFA
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 00:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778E589678;
	Fri, 29 Nov 2024 01:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732839266;
	bh=2l1dVSzofJdWYVQlcdVJVMrQqJa4NuDwIUPpE0RI3tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJz9WDUl8ecI2LyWc5b6k4z67zcTUqp8pX/2TMt5dL7kxW2FBT1oWieIQlQ43KGHa
	 1rYp9EWfZbamdlWARsbb+fDRKJE4DtQYZ33snLKYQmULHr6XJGzPNEserzHu3P4scK
	 gMjJg7LdNrFt4lAPseFyUYYIsFQGPT4SwlqR38gsjnZmWnvPO58YJWNtYOKV66Mj4M
	 H87/z3hgNYdo0ewtEQG5qizXq32st847eF1+R1ZQ6Ii1BsnSmYwumAzFWfm8Brb1Wi
	 TPFnAUrpHEMS9+6W3t7EmEr3b3FRsURMfg0rbBuSj56KEzRE3WIe4nvwERY+Ei5OvF
	 Y5+oT9tPmACfA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 329B58949D;
 Fri, 29 Nov 2024 01:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732839264;
 bh=2l1dVSzofJdWYVQlcdVJVMrQqJa4NuDwIUPpE0RI3tU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0SUaqMbaijgali2EA/3laFAiN/kXm7PqOaC6D4CzoGcLhoRxiLTQruQLLxQt7PBB6
 xk7FbIxAObS/EdaPaAJcH0OgdSSo+v414J37WfGNyT/rWHim6BniDdKMA6ChYaQBUw
 7bHdk7OmLDJ9Sthtnwr8pbnzIo2NdlgVKCaxXXooTfOvP7P7YiGP7XjYmzJT4SlimC
 vVMjq2+TrErYFz66LUx46wSlCdYk59sDEb3PZZSLueh860AR/KVMaC66QVoXQkqHsD
 x2L+2OW89mQW2llpDD9ITwjtyzwq0DZHeqMXi47ksUQ+hTJNUuZfsU+BE9os9gRlE3
 N9csVFaopytuA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] ARM: imx: Perform plain boot in altbootcmd on Data
 Modul i.MX8M Mini/Plus eDM SBC
Date: Fri, 29 Nov 2024 01:13:55 +0100
Message-ID: <20241129001409.218850-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129001409.218850-1-marex@denx.de>
References: <20241129001409.218850-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The current A/B switching preparatory altbootcmd is confusing
to users, replace it with plain 'run bootcmd' which can be
replaced by proper A/B switching altbootcmd when the matching
updater is added on top of the platform. By default, keep the
boot counter incrementing, but do not do any A/B partition
switching.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.01
---
V2: No change
---
 include/configs/imx8mm_data_modul_edm_sbc.h | 2 +-
 include/configs/imx8mp_data_modul_edm_sbc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/configs/imx8mm_data_modul_edm_sbc.h
index d323f84ac7a..57ecb5e2190 100644
--- a/include/configs/imx8mm_data_modul_edm_sbc.h
+++ b/include/configs/imx8mm_data_modul_edm_sbc.h
@@ -34,7 +34,7 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 #define CFG_EXTRA_ENV_SETTINGS						\
-	"altbootcmd=setenv devpart 2 && run bootcmd ; reset\0"		\
+	"altbootcmd=run bootcmd\0"					\
 	"bootlimit=3\0"							\
 	"devtype=mmc\0"							\
 	"devpart=1\0"							\
diff --git a/include/configs/imx8mp_data_modul_edm_sbc.h b/include/configs/imx8mp_data_modul_edm_sbc.h
index f953847ce05..de5bdd30e18 100644
--- a/include/configs/imx8mp_data_modul_edm_sbc.h
+++ b/include/configs/imx8mp_data_modul_edm_sbc.h
@@ -24,7 +24,7 @@
 #define FEC_QUIRK_ENET_MAC
 
 #define CFG_EXTRA_ENV_SETTINGS						\
-	"altbootcmd=setenv devpart 2 && run bootcmd ; reset\0"		\
+	"altbootcmd=run bootcmd\0"					\
 	"bootlimit=3\0"							\
 	"devtype=mmc\0"							\
 	"devpart=1\0"							\
-- 
2.45.2

