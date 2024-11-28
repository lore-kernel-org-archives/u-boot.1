Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F2D6D25A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 03:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F19C89846;
	Thu, 28 Nov 2024 04:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732764404;
	bh=lLdqeO0yHKPpOsMJdimmWBtvqO+UPWePs8yc5ptOLrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eEVrRjeoymCyEhHY5CZTMO5mInqrNBBSilP5nR1aAQbK5IRu+hbtImYiChkv2lqgP
	 dmZD87El6Di621fw3RmPYNkaRx2gY0ZbKaBl9j0rbbEWSBNrZXnRat08aJcXl0onAp
	 CbnMG+XmIWQceWsFXwuxOJELnJ3F0W2HXbaoYM4ycphttRvOJVTSyeLt/lQDbzJx9G
	 jF4kGo1wfye+82onAPNExMoTWmlnAORrKQGucNNpSLPDXmDOx2tSQEMmH6oMbbntxf
	 cc/0F7s4TuFcwegp1MQRzvrttTVHyCsVuvuegiUA6MNnn+XhMOF0jpow2sy1k0HB3n
	 YYS1E+Ezskvyw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 63641897F3;
 Thu, 28 Nov 2024 04:26:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732764402;
 bh=lLdqeO0yHKPpOsMJdimmWBtvqO+UPWePs8yc5ptOLrE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PL1SPd8+cjFyP/e8YNjm15ecNtghuNjybNUR4GCQ0mpGW5mlebElvf3VIDk6rm7OO
 HlaJwt+Y6mqtEanCOreus9OWEV+7eWMLFXHKxH+CDQvdsaDLucXtJiqdMVEmi15aQU
 1+QVQPf6PD3PRBKvuclFXqm75gxg7o/8vrj4+pCA3MJ0+Wz0igjykKdpE+0RSfEpWZ
 DkQ5UC2cgPnLtSv+vymM1MPdMaprxaNz0iQl4OCkNeIMQ1CtPNXVUjxLVQGcUVdHZx
 42lIjD8wfRtAzb5vD9a7kBBs+jCpgAXmBfJbhH/XgtsbfeWYRVlEfwVAnob/LTXx0b
 u3c21qBV/i3hg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] ARM: imx: Perform plain boot in altbootcmd on Data Modul
 i.MX8M Mini/Plus eDM SBC
Date: Thu, 28 Nov 2024 04:25:25 +0100
Message-ID: <20241128032623.269459-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128032623.269459-1-marex@denx.de>
References: <20241128032623.269459-1-marex@denx.de>
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

