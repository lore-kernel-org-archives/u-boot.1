Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59787C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9841D88CC4;
	Sat,  3 Aug 2024 18:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701718;
	bh=5XOUL5Xh22HFhOqCCw7UgobMSxVqXeYnuY0sEPB+Xas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gnqd8UEBUeZSk2N/YorgDRXOT7rZfhXS8TYxsztsN8NTd2aoa7nxyHD2knPBEawmy
	 m13PWfw0wf6wiFaHboJoZKEsmnRpzrJ8oYDug816F8PkhFmbJoPNQ6OGHbnKkgYjNw
	 7kigQD/mUvhgJsA1VSMrUuZMzV86pwuBed2PauJs1WGfBrTVovFFDlYTXGlwSGLRer
	 4xu4Cx8Gew4NE0+A4T2DPoeZTAWCOn0gebPszViRog8Ku3Z4aW3FyQwpQDw/fnpXsq
	 Se+tY8SES2m5j5Mm7gHD0PMIbiGUXLfcGiwE0AaF4t8FGuSY7+gDd75HxVi1opPPJA
	 und4cSJ81YKEQ==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 596BD88CA0;
 Sat,  3 Aug 2024 18:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701715;
 bh=5XOUL5Xh22HFhOqCCw7UgobMSxVqXeYnuY0sEPB+Xas=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nEWVhBbtx4XlwChzbp1IcUNR8cW/DRXZ8be2fLUriCkB8yp627oYjNipqr9hfa5G5
 Oc74DB71FrVR+DrZ18lODgqYdCCYX3/eABiDso3dPNqJ7XX5K/tW/5tSpKtJEqNBtW
 oImc3Oo5/o5kpZkeUSqmr6baXas83VlYVgTYEizVfpT4DlhIMBlEtNg8DTrU+k/9VI
 7cxUnt4iCL8QRIxe8Y/5NTuneThXREZPhZYtznQi2v126bFZHo7fxYIyh2kiq/yWCw
 vEekNG+yvgBczPqB3DHm86wjsN2dzoLT3BzFMPI/EGLB9V7BZ6MgI0QFK3WMK/g7/Z
 /e9EZKI3Ghrkw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/11] board: sl50: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:07 +0200
Message-Id: <20240803161513.486062-5-agust@denx.de>
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/am335x_sl50_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 88122bd052..158458f532 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -66,7 +66,7 @@ CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
-- 
2.25.1

