Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487EEE8FDAC
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 19:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FBD83AA4;
	Fri, 26 Dec 2025 20:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="JS2vPeuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94BFE83AAB; Fri, 26 Dec 2025 20:34:20 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8E283A8D
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 20:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1766777485;
 bh=W4BVwNUxjbQSuwh8MWFJ88xbfn0RQ6wO35g/U5Gyc9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JS2vPeuhdqQmGRQF0WEAp03KWeXdHj8DwR0ptJCURiTwDt9DEaRlSLwE/JnENjy4b
 Yjp0GIM9pJQ1gIZdlZZ4SqOp33i3sNq4Ji+V7g1SBcDRKn5ey8q6Viz1yscosi/8cT
 I1VAdeCvTa+G0IsO8FhyhMawR5FstOM6kdq8pSOhRIXcURTvVKjZlabUJZLrhqxCtl
 2N/GbX96OvOnvI0gDoK0ybxjwSrnkPMwJp6rTy4Lx1BuVSWixtTIXYWCaYqco7utgK
 SWHpEtELuf2WLtle6mVtVFX3yef6Hhos5eQ6MCsNVdcpWDsP1W/+gAG7kSwuYjP/hS
 RJTf5v2Zz09iw==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A6FE1B22155A;
 Fri, 26 Dec 2025 20:31:23 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 4/5] configs: starfive: Add Orange Pi RV to visionfive2
Date: Fri, 26 Dec 2025 11:30:05 -0800
Message-ID: <20251226193034.181659-5-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251226193034.181659-1-e@freeshell.de>
References: <20251226193034.181659-1-e@freeshell.de>
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

Add Orange Pi RV to visionfive2 CONFIG_OF_LIST
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index a754134a313..7c957cc0ea1 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.50.0

