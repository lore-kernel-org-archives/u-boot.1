Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1126FC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBFA980E4E;
	Mon, 24 Aug 2026 19:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8Rm8wAx6iD7; Mon, 24 Aug 2026 19:04:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598244;
	bh=5k5S8GXkO7tzETdG1j8Iti9z6btQdpSjZSSVFf9LwUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mNW2n1nOhCCvZXiWe3W7zpFUGScS5SgVuajbwfrm/f5f39ch7rd+Ya0kUiA2kawcX
	 Hk0rZOVYl8VBHSDYF5fwKZ8J8t+Z/1lLtCbZh90yzO/N2o/ujvghsQ2SkiOYkygxDv
	 2We6CK6h4++AvXKDVGre7WNQ3WeraRmPQyw7IJwVApQhk7bVodqFAM8E1ZJQFxYuP8
	 8iZY010eBhUaUxMgmNDYNTsdLl+8289gI3I7x+NKY04297rLzQ6Hxd+XwApeV7aOEc
	 rlHH752hQSrNY3nlVizBA0nEhlYZWJPkjHGJG5AHTYItJAGblS1yp751vwPc8cvWFO
	 xv7pXJqPnbmxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3022580E52;
	Mon, 24 Aug 2026 19:04:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D00934E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02FE6405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMTKHgb7MvL3 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:31:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=O9FvKrwB
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2844B4059B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:05 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso1231566b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596263; x=1788201063;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5k5S8GXkO7tzETdG1j8Iti9z6btQdpSjZSSVFf9LwUs=;
 b=O9FvKrwBDvNzZLtF7b0pb9UwRMjsE332xZJ/WeSYEiNI8f0GUJYo40On7W5ChG0lcU
 QYIgvhH33Ma9BvXCC9xUICjNV57STHyxdOV/u17HcMyNic3Uv/mfd9PyR67J9aFgQu50
 yhcFA/HcZ/DLdUZUu9DgPzLeH5jCFsKJwncWpTE92PtNn3FjCSmKiBKD/wAdTyITZ7aC
 9Gj+c6Pk3/vQS8InzW5zbeTjv8exkgCLfnRVEkKUjg4UxgOfUhFoU8wYlpehS4LUtHCg
 4KZhjyObisOIZTGvEerZ//yKYOY6eS9DYBjuYMu67PmiqpE6EISFHU2AJyMCSFncMtdR
 S4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596263; x=1788201063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5k5S8GXkO7tzETdG1j8Iti9z6btQdpSjZSSVFf9LwUs=;
 b=Gyb9kUYnorUH4UT0sVtsNFhjcl8dSW/CdS3lnlF8Vl12uA8ltiUSx/kg+tMA6OwFLe
 +2ULJ4qjh5R2Avo8YpkmAVn59Nit5zGn9XkjT3w4jYAEy7vURuNw7P/HNw5NbWSZxQWp
 2FJyNPyOU1x8VvabhNX3tUpqvWdWyUXZpuSC5BKLsFoZscnRmH+fdzcloV+/OJ9tbrUX
 Z0k+peGV2DXBrdcc6U1FgGgly2sVFTJL94jmJ5hBwfJSV2rbNL6tD+8xb3E/FLC5O5g0
 rTvBoeRNduOw6QwyHlQ4TsCRxg3JDEigvUqrQpjcHMS/LUMKsf694qQUOsnKFNdxj0AK
 uyvw==
X-Gm-Message-State: AFuF++nka9Q92hKDRtp7PsQbMheQ8uKQdFHIuTk4IQPn84tK1o6WbMEC
 gPuemv3c3sK5tE4YU+0cdXKyymOh1CglQmeRPENoiR8gmy+EGTSJckVp
X-Gm-Gg: AR+sD10dOVHbQJWQhOZNy58N7vHrlJi/3OBduJkqK07nJGB4MRARry5DPEXK3GKqjTN
 8zaDqTEkE3SKngd7byQnzTHYdaIt+cJysnwBUb06ai12bTF9gEJQ52cGk3cUQAWVeUwTdhnoAnW
 kfoZTjDj28fmovXB7LPFvMTX4J3NBbFFccmiiGrvjKtrDp0NwxSzGI7yn46srmuhB0KnJwqCepw
 gYo5L99HGy9pRJc3nxMbTu6XuBhUXe+vF9BR54RMYZRJKPzym/tIHUiqS+g16JgnFWz/F/mutzH
 eesuMRRv3sGeDnm5OmY9clmAfn2M/zHxybalzJtEtCxFAwkQ6HhIKZLQUIOTetfe3yGOON1+OKT
 gvreh0x2bGVdZsD9C0u2/Riz2Wkg1S7ltRbGr0FcZUoU53t53GpRSdTi0p7jEpaIyE/aChQsHRL
 xZwNVNpDUFXE5SA3OdvGkkkcubSE+o03XYLgbJwsyST+w=
X-Received: by 2002:a17:906:7949:b0:c20:a243:9a52 with SMTP id
 a640c23a62f3a-c24e28a5d48mr88382266b.0.1787596263244; 
 Mon, 24 Aug 2026 11:31:03 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:31:02 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 6/6] toradex: smarc-imx95: enable DWC3 USB controller
 support
Date: Mon, 24 Aug 2026 20:29:14 +0200
Message-ID: <20260824183048.419198-7-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824183048.419198-1-eichest@gmail.com>
References: <20260824183048.419198-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 19:03:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The iMX95 USB controller is DWC3-based, but the DWC3 core/glue driver
was never enabled for this board, therefore enable CONFIG_USB_DWC3,
CONFIG_USB_XHCI_DWC3 and CONFIG_USB_DWC3_GENERIC to enable support for
USB in U-Boot for the Toradex SMARC iMX95.

Remove the dwc3 nodes from the U-Boot device tree to keep them enabled
now that the driver is there.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 8 --------
 configs/toradex-smarc-imx95_defconfig            | 4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
index e4eda61e5c4..d9fe4abe877 100644
--- a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -88,14 +88,6 @@
 	/delete-property/power-domains;
 };
 
-&usb3 {
-	status = "disabled";
-};
-
-&usb3_dwc3 {
-	status = "disabled";
-};
-
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 9abadb0ed1a..5b687f9bb3d 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -166,7 +166,11 @@ CONFIG_SPI=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
-- 
2.55.0

