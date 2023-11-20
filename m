Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B64CC2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 20:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9035D87582;
	Mon, 20 Nov 2023 21:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e/cxB4na";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CCA8744B; Mon, 20 Nov 2023 21:16:14 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EA18756F
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 21:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b2ea7cc821so3098035b6e.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700511371; x=1701116171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=foHonOICjYjIcac7Qw2x/CJwCGCuQbhK9ujt81YaTFE=;
 b=e/cxB4nae0L9qhTFLCHpYa3Tyu65ynA5VspMj/ecpVh0ann+VfFUAcRd7aCtr4gJAB
 g4OFYGHAt2E5x3vXAnU5Th0Vu5eI6b2/LM0DdQHNbExN/lmbsEtTNy381us+H1wXoQaa
 E7XnU1VqYSaNZJ4AR77AZAuwYLnXu1TVSp1nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700511371; x=1701116171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=foHonOICjYjIcac7Qw2x/CJwCGCuQbhK9ujt81YaTFE=;
 b=HPUTSzSNe1ChHaQdFw3dM4ujDoDhoSi/SoxV/ppZTQZR7ilEcCQmr9lJSQJujXU5va
 JBahVlcR16MRv+/tPYEMwpGS+o2aC31WeJAbhR6yBx25ATGX/QH8bIiC9SXG2216Qxyr
 RW70nZaV5qUiPZPMF+pk5IaAObmigniJ9lGA+8xJloInnJOH0zZSbi7Gz+nu3bjVE/T8
 8zNQJh0yvUwvzaWMRl0SusJPFoZ1x/yprmyifBXFabYS93I527KEfFwwbTY+GKkM9h7W
 ViXtrDlx4oiknWNhktK4bkQH2s0dMQAch0r7B3N6UWUL4AadLdmNBveTaW1kZRosDDLm
 LUQw==
X-Gm-Message-State: AOJu0YzCzDhsAFAWJr2WjuvxfTfVJU1aLmdBk6UU4kSxtrdwNmw4HuhH
 /QQlhB7OSh57gcN65Ba/VNHXwNmxe+h20juTa6vbPg==
X-Google-Smtp-Source: AGHT+IFywLHlPAU2dDWnzg/WTwN0foFy7KCrvqBOagrb/Oyq+hCpiRXzZyjzK+lU1S5ytoOZ4nzUQQ==
X-Received: by 2002:a05:6808:1201:b0:3ae:1351:d0f with SMTP id
 a1-20020a056808120100b003ae13510d0fmr3712587oil.22.1700511370902; 
 Mon, 20 Nov 2023 12:16:10 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com.
 [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
 by smtp.gmail.com with ESMTPSA id
 az44-20020a05620a172c00b00777611164c5sm2899840qkb.106.2023.11.20.12.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 12:16:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH] libretech-cc: Populate SMBIOS information
Date: Mon, 20 Nov 2023 15:16:09 -0500
Message-Id: <20231120201609.619598-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
eventually display this information

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Posting this as this was the easiest platform for me to test some SMBIOS
related patches on and I needed to populate the nodes so I could check
things in dmidecode once Linux was up.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io
---
 .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  | 23 +++++++++++++++++++
 configs/libretech-cc_defconfig                |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
index 39270ea71c8b..e56cd67a9d91 100644
--- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
@@ -5,3 +5,26 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
+
+/ {
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = "libre.computer";
+				product = "Le Potato";
+			};
+
+			baseboard {
+				manufacturer = "libre.computer";
+				product = "Le Potato";
+			};
+
+			chassis {
+				manufacturer = "libre.computer";
+				product = "Le Potato";
+			};
+		};
+	};
+};
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index baa9b1b3dbc5..24a46f50d0d9 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -55,6 +55,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.34.1

