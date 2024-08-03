Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7751C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E57588CA8;
	Sat,  3 Aug 2024 18:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701718;
	bh=dmyw9puy3FvYeMCRCrZN4373CES4AGVW+YwOKlllASQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zmG/9YW1r4sD0Tu82i9bqaUDItLyonQwxKKIZK+FNUuk9J08yUatm5vwz+RKrs9du
	 efkm5zHGt1FnLpr9LcZp4fmxOEBKYF0/pBWCKCooDEBsy7kyaoG43GjoJWOlw3iOMk
	 U4CfYWOtqL+MUFbpdV1m8NVSm8X+wz4NeFOsvmOPTazNzCUAtMoqqXL8DfKUyg2Rix
	 J87SlBp6jxfQ+URxODUnvqKdRRbmDudB+UV9aT2iU0j81X1kwPVqAwoUylyyCRQSuY
	 0upMD9Pso1IRbDmvRm8BjJ0faPAf1iMejYOK+rLRFps2e2Aqa9cnOcLQDTL4xJZSWk
	 Qhu3eIETd887g==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DB6AB88C8F;
 Sat,  3 Aug 2024 18:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701715;
 bh=dmyw9puy3FvYeMCRCrZN4373CES4AGVW+YwOKlllASQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=acL7lCWf2KGgrAjIjaosrFM2eUPIm+WSsYiqb82oz/5BFp1ryRbSQyChh9qcIPz1H
 GRe7MxRtsAU/UrZ7dfGx5RtsMlAVJyx3P8KPei5VmsrqYklyqUPNcddSPTvtLjMij5
 Rzd4l7nbrkJytsbD4x1CGUrGaDWRwiyC4RWIIsU5hLpnnFvc0dVOcNGS96sd89TAxC
 QGOBIWBLIZ/VCUsDnG5vm3aw8KmcWwUQnf06W70RA6pIEBmYOh9FA4RN7dK6WtOz0J
 HK8gdowfR482hWHLhh0gULftN9F9T5T2wOclUtB2ARhkMBYllVpRWj9qKqyG6TZtDf
 3zyhJN1dH1OLQ==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] board: igep003x: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:06 +0200
Message-Id: <20240803161513.486062-4-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Javier Martínez Canillas <javier@dowhile0.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/am335x_igep003x_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index ddffd4f46f..25fa7818fa 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -76,7 +76,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD=y
-- 
2.25.1

