Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2423AC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33833807C4;
	Fri, 21 Feb 2025 18:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740157677;
	bh=SzWgQ3KyFJAn0EAvShIhM8ZRguSYoUHJSZcd+GrPRFI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tuMT6vSwzrfBntvDoK1Q+wy2cveg8c4LASrZEopvoxj8ESab2CtvJCl79i6p7JaUz
	 QA/TIsImPyEm/gwQSypD8lgbBYgIsyJKz4EZABmHXANlSlo2DzERRZOHnLEazt1DIA
	 Hl4F/BQHth/nuZckdGhsxV+POdh34JFi4Gte3wyUje8bplZxoFANCXlmEXfl6XmJDF
	 dxnSLR6QFEbLE/ENRY7gKS3ZCcbsD2W1QEFFItxhbQJBNUpst2CM6jMXyjah+G0SNJ
	 Asup70VWadd27Jrc00v6SqUML2GC2P6KZrtmOpBRlMGHEvCvfZyoaVBNvca5geBY+y
	 fL6ZLiOsa56iw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A6580F67; Fri, 21 Feb 2025 18:07:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F61806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XohussWm"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 46BCA10382D37; Fri, 21 Feb 2025 18:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740157673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SzWgQ3KyFJAn0EAvShIhM8ZRguSYoUHJSZcd+GrPRFI=;
 b=XohussWmBcX7RjF5X3Pxoe53SQyjDexWISBQ+O7snTakOqYLcInZo1upkWhGDHItV1OrAr
 frF/crMu2+MyS7y44UnIQAd6w0wFqVBLUiHT8MrJr/5CKE+5TK+KOAQ4mmAmZPwFIQrCRz
 TYMaADMyKK1zGhEv8u+/bpo0VUXu9bpouvdJj0cwnDLqUtQr5JDQAobrUC0diS2G0eLlOh
 88AAxLVBh+V2+wH0QsExYRCESPFAnZESx3yTw0FxUQLZVCGkVagv5E3hJTN+C8OoeaThAI
 zs/0WloJ7H7fuOdaywjrwgxs/7qx5Cz/990RNL68mrMMTOhBt/wTKY8PX3FhCw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on Data
 Modul i.MX8M Mini eDM SBC
Date: Fri, 21 Feb 2025 18:07:16 +0100
Message-ID: <20250221170738.184822-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The environment is missing quotes for string variable, add them.

Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/imx8mm_data_modul_edm_sbc_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index debaa7cb5aa..ef1d73c2f73 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -37,4 +37,4 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
-CONFIG_BOOTCOUNT_ALTBOOTCMD=run bootcmd
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
-- 
2.47.2

