Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04487C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596488756E;
	Wed,  6 Dec 2023 10:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uFTAbp7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3444B8756E; Wed,  6 Dec 2023 10:04:28 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C58A86EEE
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3334254cfa3so262314f8f.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 01:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701853465; x=1702458265; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P+1/0oUjz5rluJhR9RmqMC8xOdhAin3fsn5Iyog2y8c=;
 b=uFTAbp7wAZdD4N/m7V9ee5UOtKPn7LPYt+Bl5JDqXkJGak7Uxt1j79HTelGVBqv54G
 XmCOhHrEDl1GCQd6T9qTLzxXV2qFKfn86vixDH7N6+KKaZAuII5IqZyWJY7oZjgGHjG7
 wbwn+O/XT1uV+eSG45TS3bWwDAmjrJyB5ERXE7ux2oV8kJ6PiGq65d7KABvmmXOyvbDG
 mARNR5Jj9i5qVW3qqGVW+A5fGa14qg8p30qshiLrproXyUVHsMFuR2wF+wDfKWf072QF
 3v4P0A4rUX+ta1OUTxomwDqsZXBZxsSze9rBzOXMaQwi9xIn/z7ieHngvJf2ZT2amIk0
 S46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701853465; x=1702458265;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+1/0oUjz5rluJhR9RmqMC8xOdhAin3fsn5Iyog2y8c=;
 b=J4cc75kOxFAiF0vVoVFSHFuJvg0+jcZyep6QxA5MMSwJv0BpBPR/K8SCFH1FQCG1FY
 VKHsJw3ZAh7HuRvJJrbc811epMfP0Kp62+d+4wvz0jNN3vl0avgHbPjCjcRENhCDXte8
 gn2poNEGiKPdsoVL0ta/u68tpi078hk2uVFZKtlcCZ7SfKHbFy6SY9UJnS+uIUmkdWu9
 qb2SjsPtEWCHpArlgQzUNIMmd3pn8vGbRVJv931cVOGL6X826dHo6INehhNPMh+UA0Mu
 e/BULnGHt9/Uj3N00JSSmDJef7m/yAD0vketatlw6Xv2tVEyKHV/ZHdJQF/Uk+SHiIgb
 4BDA==
X-Gm-Message-State: AOJu0YwGtZ52jIZ9P8akXaMUQtw8IgGD+rkwzBHbDeZJHLQTYYV8AboB
 TUZP8BMLvaQEZ6eIj8/JwQkhjQ==
X-Google-Smtp-Source: AGHT+IH6UZ6fmBx3WT/fEHQpSNnffMtr8r3z85mCMC6cjF8XVc2xQiy24DScww8nDJycO89IPZ4CFQ==
X-Received: by 2002:adf:f250:0:b0:333:2fd7:9602 with SMTP id
 b16-20020adff250000000b003332fd79602mr279648wrp.61.1701853465615; 
 Wed, 06 Dec 2023 01:04:25 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:f855:6075:9365:8b70])
 by smtp.gmail.com with ESMTPSA id
 f9-20020adff8c9000000b003333d2c6420sm10682031wrq.74.2023.12.06.01.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 01:04:25 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 06 Dec 2023 10:04:21 +0100
Subject: [PATCH] configs: meson: enable missing DM_USB_GADGET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-u-boot-m2s-fix-usb-gadget-v1-1-1c4c66cd10f3@linaro.org>
X-B4-Tracking: v=1; b=H4sIABQ5cGUC/x2MQQqAMAzAviI9W9g6EPEr4mFqnT3oZFURhn93e
 AwkyaCchBW6KkPiW1TiXsDWFUyr3wOjzIWBDDlLpsELxxhP3EhxkQcvHTH4OfCJk3emZWsdUQu
 lPxIX43/3w/t+SBi3VGsAAAA=
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ORIDsnMm4F8KEoPrXWijjF8CkW7NnOxxAsMmhYyoUOg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlcDkWvt2bDJou8o/2uAP9JbfYjo5d3c0S+5XkO
 LvNxOG9RV6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXA5FgAKCRB33NvayMhJ
 0XTxD/0WoDTtAoX4kn7qcPmi7W9kx7jG6rAeC95VtfZASss1si1XEIUegPmzFbteHl5RznWbbiD
 62pRHYJnf+rIcNVPP0F9M5KiVWENJgUazjkjhVuqs4soAIa254IKf+In5htnrscHywkGGB/bLLj
 q3PCCLI97N6HYfqvJBhG16kmJVE21/zg/FOFB4AWAA4lqxs65aCKN/JygCZn1o0Eph0O8yH3mqd
 yei2/NVxGkmDWvkq9QQ/O7CBzWmFd6/2CLU154LxMIOJqfqM1OnR6MaCdhFAtExZsOv+1hYN2HF
 ahAuZClCuQ9znLX7++wohTaNiv19pfH/rWdFGhGjs8yEOyd8Fzy5LrrQavIfhFxJgVpmvp5Hbn8
 eveoHcNI5VD5oIyg+OsKs73ockza/XiKY+q3gGR0OHZi4ZFNzUUq8iw80NKeFYtGQ1dcdoEdsbq
 bXZvdtINFZJTDu6hdcUv5FZznX1CK9ChYUGGE285WtsxbmMYeaYoMhFVwqENLtizLURrfr5mRLh
 Rzr3oHl6wZEepQIwIwqLSyIlt3ROtySIAPIbaMWzDTPF33aMfuYQgLLrgRDFwvLTriyeXVRsFDT
 WzuDtGRSUCzkoZlEzslCxwyoajbO30u+tcGqMviDPLute7MdLZ6FsGix0eruh24DYYYdEOvKPSs
 iFFZiTEpdF3W1VA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Since commit b96640cbfb ("ARM: meson: g12a: switch dwc2 otg to DM")
and commit e327e2affd ("ARM: meson: switch AXG & GX dwc2 otg to DM")
Amlogic boards now requires DM_USB_GADGET to have USB Gadget to work.

Add it to the boards configs as returned by:
$ grep -L DM_USB_GADGET $(grep -l CONFIG_USB_GADGET $(grep -l MESON configs/*))

Fixes: b96640cbfb ("ARM: meson: g12a: switch dwc2 otg to DM")
Fixes: e327e2affd ("ARM: meson: switch AXG & GX dwc2 otg to DM")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/bananapi-m2-pro_defconfig | 1 +
 configs/bananapi-m2s_defconfig    | 1 +
 configs/libretech-cc_v2_defconfig | 1 +
 configs/odroid-go-ultra_defconfig | 1 +
 configs/radxa-zero2_defconfig     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 2a3958b0fd..755bccb4a7 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -56,6 +56,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index 405ce3a93a..af8daced62 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -61,6 +61,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index ba74b241ab..b1c267a791 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -66,6 +66,7 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MESON_SPIFC=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index bc0bf9b896..49d628b76a 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -63,6 +63,7 @@ CONFIG_MESON_SERIAL=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index e9415762ff..b795681b3f 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -52,6 +52,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y

---
base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
change-id: 20231206-u-boot-m2s-fix-usb-gadget-ca308e113228

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

