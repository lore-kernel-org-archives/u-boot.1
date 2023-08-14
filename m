Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68391C04A94
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE5A865B6;
	Mon, 14 Aug 2023 19:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NVQeYazy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2321D833BF; Mon, 14 Aug 2023 19:40:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1BBB865B6
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso37902365e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692034798; x=1692639598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4NsdhtSnD7TM5nh+kpin9JMtiAHmtNscIH8kbhYLUQ=;
 b=NVQeYazyZWaGa4yAx1jniTR9IY4h57PECfo14uKFCLVnervJw8VHZZPcLmWmevPvlG
 eASbtkCnr7kJEZx3JV4wvdKMB/jTj0b+BBBirXLmQvma3mVFD+r9s84um7RCUCdlXVA8
 m6/nuL9QY1DS0GZ069NVFIXi4K/zn9vCgbt276pGzOy2js0dUkiOxqNmKcgB/Hj27bBN
 i3yaOFEYhsU33aMkfIN5eIqHr39Esv7dNhftsMIo6vfb1Z+eKEPOjyJxE/GupSsiij4N
 XGWINy42UuQ1RuVSYNO3gwNNep5PFkvQToCaTaswZk5mOuCEnwB7REIkiPaiy07M2na0
 u5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692034798; x=1692639598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4NsdhtSnD7TM5nh+kpin9JMtiAHmtNscIH8kbhYLUQ=;
 b=NpGuID+SPt6XB1MBYQwCW1DsTeKvB2pMQkhKFycEbYY0kE0wNF5YOlQBbzYOUYgi+z
 HJAXnS45SyfZsEpu98ME6TAKguNyfF+wx/rdHxGbTTdLJU8z/5pAyS2zTG/oRzQBu/Dk
 N5RVGdSCVsU/YURG/H4Tt6N+mK3boZ0KQsAF6Ie/q/kmp4nfHMRjljsdtNqlo4TY5VMg
 zJSUQ2d7cLnu0fQ3FuM2bIWYgAC2tkqeuL17PHmNmHD6sz1WiIZFUGT8NOYKDKXa2jcG
 whe2GBwRgrVozs3zsSgHgmSx5d9WZC2nz5zjiFu6G26lQVdMwFuNtUWjI2d9XlFwDBtQ
 Ts9g==
X-Gm-Message-State: AOJu0YwpPy43AXpIlCllx7A0//f+ubLV2zWAAW5+Hy5ZnrsGkfAYrGEd
 DKjiuxRXcl/XSJN5z2wN2UHkhjc3x3g=
X-Google-Smtp-Source: AGHT+IHkjLfFxvaAYt2agWGihXKJviEIUMQkyo+7oEFc3iDVveRPjmFS4GW6/OZcY5GzLbejJtGgkA==
X-Received: by 2002:a05:600c:214d:b0:3fe:179a:9eee with SMTP id
 v13-20020a05600c214d00b003fe179a9eeemr7891076wml.30.1692034798186; 
 Mon, 14 Aug 2023 10:39:58 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm15002406wmi.16.2023.08.14.10.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:39:57 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 1/4] arm: qemu: Enable Bochs video support
Date: Mon, 14 Aug 2023 20:39:41 +0300
Message-Id: <20230814173944.288356-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814173944.288356-1-alpernebiyasak@gmail.com>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
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

Commit 716161663ec49 ("riscv: qemu: Enable Bochs video support") enables
a video console for QEMU RISC-V virtual machines using an emulated Bochs
VGA card. Similarly, enable it for ARM virtual machines as well.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
---

Changes in v2:
- Add tag: "Reviewed-by: Bin Meng <bmeng@tinylab.org>"

 arch/arm/Kconfig                      | 4 ++++
 board/emulation/qemu-arm/qemu-arm.env | 3 +++
 doc/board/emulation/qemu-arm.rst      | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97c25b4f146d..0d4654fb9dfc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1036,6 +1036,10 @@ config ARCH_QEMU
 	imply DM_RTC
 	imply RTC_PL031
 	imply OF_HAS_PRIOR_STAGE
+	imply VIDEO
+	imply VIDEO_BOCHS
+	imply SYS_WHITE_ON_BLACK
+	imply SYS_CONSOLE_IS_IN_ENV
 
 config ARCH_RMOBILE
 	bool "Renesas ARM SoCs"
diff --git a/board/emulation/qemu-arm/qemu-arm.env b/board/emulation/qemu-arm/qemu-arm.env
index e658d5ee7d63..86a99a2e8713 100644
--- a/board/emulation/qemu-arm/qemu-arm.env
+++ b/board/emulation/qemu-arm/qemu-arm.env
@@ -2,6 +2,9 @@
 
 /* environment for qemu-arm and qemu-arm64 */
 
+stdin=serial
+stdout=serial,vidconsole
+stderr=serial,vidconsole
 fdt_high=0xffffffff
 initrd_high=0xffffffff
 fdt_addr=0x40000000
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index b42d924cc66a..1108fe5f8184 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -67,6 +67,10 @@ Additional persistent U-Boot environment support can be added as follows:
 Additional peripherals that have been tested to work in both U-Boot and Linux
 can be enabled with the following command line parameters:
 
+- To add a video console, remove "-nographic" and add e.g.::
+
+    -serial stdio -device VGA
+
 - To add a Serial ATA disk via an Intel ICH9 AHCI controller, pass e.g.::
 
     -drive if=none,file=disk.img,format=raw,id=mydisk \
-- 
2.40.1

