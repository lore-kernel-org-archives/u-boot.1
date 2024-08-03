Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8859C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A00888CF3;
	Sat,  3 Aug 2024 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701721;
	bh=1qUgfmQk0Eo6g9iSVXJPPQ1Sl9EPgDbkbfFfDsKb1JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q+5i8QOeg34oNy5RlVtyeBc2p3xZopXFXarwxcVf+l8GuEMKWPAeQtk9Lj9YZvxU7
	 3kxk/zu7zTN8CJfC8LplY5pjwy1v6nLre6/FGw7X5GpAime+5ZK+3O8wISAp4j+xyI
	 A3kO1M5h8pcngw+dhVKzB9KfyWbGkfjpkIPwoSEJIuoBYRUI8y+IE/v08kHrmLEfj0
	 7cDsfrOmsbLExht51TreuetnZSKgrbaUzlxCqyU+WnHlh1VEd1G0TeL+B432q0chom
	 wy7wv0Qdb4Y/kMpwWtd4wHKeuPHLzRpsp5Z/9MnW2rGdRhprhWoH4AJIi2iZq3i5MU
	 xVxzD6zmxOJhA==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A59D588C8C;
 Sat,  3 Aug 2024 18:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701716;
 bh=1qUgfmQk0Eo6g9iSVXJPPQ1Sl9EPgDbkbfFfDsKb1JQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WyvomUkLUwMprb1s6mXdyJ5SupyoIh++TL5laIu0kS3a7+5q+EtygJ9ZenwDw8iRm
 JDZ2WApZOM05K/1yn9q/YC6c+YSWTJekem6Q0aQYB1UocvwOjRzoVeQCwYNMc9VGx+
 j35kCQUPcxAe+ENkObxuS7RuAieqY/vJbbzFDDYwajzb49uOA+bdNK5eGEp9t/cGmA
 X9vPVh/NKk/Jw8vmNfK8izVpWK6mT8JAfV7eglrfcehqx7+g/+9sjhFRa+2BVJbQQR
 5uc3RkXjC4/5fhItgxbxIbJfbcKnqdUuguL42KQtmcIcIaFB5oQeyr5UG/sMld7zjp
 INIoEF0dUzxpA==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Alison Wang <alison.wang@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] board: vf610twr: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:13 +0200
Message-Id: <20240803161513.486062-11-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
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

Conversion to DM_I2C is mandatory, enable DM_I2C
to disable board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Alison Wang <alison.wang@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/vf610twr_defconfig      | 2 +-
 configs/vf610twr_nand_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/vf610twr_defconfig b/configs/vf610twr_defconfig
index af889ec903..7713454136 100644
--- a/configs/vf610twr_defconfig
+++ b/configs/vf610twr_defconfig
@@ -47,7 +47,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_ESDHC_IMX=y
 CONFIG_MTD=y
diff --git a/configs/vf610twr_nand_defconfig b/configs/vf610twr_nand_defconfig
index c50afc4bec..2cef898863 100644
--- a/configs/vf610twr_nand_defconfig
+++ b/configs/vf610twr_nand_defconfig
@@ -48,7 +48,7 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_ESDHC_IMX=y
 CONFIG_MTD=y
-- 
2.25.1

