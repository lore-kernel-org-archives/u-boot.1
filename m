Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1ECC49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE71188CD0;
	Sat,  3 Aug 2024 18:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701719;
	bh=LsYpGBH2H4ayXlkf5uOgn3CbSsO5slUp7rweN8s/QUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uv1pwdjq8e2fqOngCuLNifiCjBssIoRk3PbVgpUFvM7jJ9li2+ty6tqYKzM47MHs7
	 RYGy71r+CrZy52k+Rs5gbxo/p7z4kDwTl7kZzgSdDOWQKCdMXiwYrqMiGK80effLCD
	 6I0zC/tJYOVY5uwHUNCm8naP1Eh0kimE6fvxIYYhgMKrwcFq2lcHgteIry86F6Z2Mn
	 iddZ5L6//g/fDorRzwAEHWbbcMquOrQ4rlqUsIA7gYwX/n+mtQZ5Be/7gVqAUC9k2x
	 N1VimwlmmEqYFFX+qTZgsJEVgv4QxgrMwKj9GepKwWgJ+i4yo29KyVAKvNqq3qrovE
	 XHnXxwIpaeAAw==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9385688CA1;
 Sat,  3 Aug 2024 18:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701715;
 bh=LsYpGBH2H4ayXlkf5uOgn3CbSsO5slUp7rweN8s/QUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uUn7qlfA2dufJ4MVzkniw9ZRDzP3JI2oW1ayprEHMWlehCOw8bbfp1B1dF74T9Ck0
 DKjjw7kY5up8D0QcJIsFvLa9/NBLP5NEvW7OwSvMRbm3it/a/uWyGH+rUrXOmvI4Eb
 ZdyubSlOq1Tr28J9+jRBrWP2oD9vWtvtM6cQgVzt7Ct38FYEpvvARq2jHOJNQKGs2T
 Uu87zDUbnnh+HYz7vVpvOMFVpgSPqMJ32clrzbE8tSo4UAsYaRmgidi0FFtHMA8lzB
 cW5aZ4CLHzS2sZUdgmjBPAmFlqfwtm1DI2w2Yo45OUxzvge1YoV+gCtxwDiUNdFgjW
 w8HTNFOuAQ/WQ==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] board: rut: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:08 +0200
Message-Id: <20240803161513.486062-6-agust@denx.de>
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
Cc: Enrico Leto <enrico.leto@siemens.com>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/rut_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index 7e78f1d649..fb57565e06 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -90,7 +90,7 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 # CONFIG_SPL_DM_MMC is not set
 CONFIG_MMC_OMAP_HS=y
-- 
2.25.1

