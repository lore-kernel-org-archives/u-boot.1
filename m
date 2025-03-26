Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6ADC36010
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E2081D4F;
	Wed, 26 Mar 2025 18:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aXlHLQx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536AB81E0F; Wed, 26 Mar 2025 18:40:55 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C6D8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso1303115e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743010852; x=1743615652; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/M8+IwIFnueosg9Qbss0JZ6cxYxWUWZrlrSkwMiWNEk=;
 b=aXlHLQx+OeHZbi/U0v+7quM1hM6tTThkRt/SM68FL0ixvtsUaGTpR6+n8quxf8cPsg
 vpEv+EUzsBUfoCwYwlNH+TrGccBJwrzvhS+LgcrJIBDGAf4LJmxOsIw5Gxax6rFouXjy
 gvzyTqNxsJL/xSOq50UA/pM2kdQL24GxScimTMILzDxUupqD5NQJYF2EbUwPiX4Aegd+
 4rFY5Vr8UAUZCT6Ums46tulxlJIeXXljMq/5EjwUt/acXvTeH6givMQnMlZmWZBUcJuo
 WCr7RtcN0IQhF8Y3vqfOO5hMOdbLRmvdKR0XxOqrsImRhg++Pr00FuCEllbpIe89KTDV
 +6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743010852; x=1743615652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/M8+IwIFnueosg9Qbss0JZ6cxYxWUWZrlrSkwMiWNEk=;
 b=IUvqfMkQeo/OFLvlXwQ3Nq9A6B/f9ZBqjc6BunR4mr9wW8r5hXtikF6lkNdp1xsAxn
 Jw9vsBC6E8hPW7cRrQbGZpGUuMXYxQwc4BBjRmoD32qh8PLxyTVbjGAXcq6yZSMmRT6e
 +Iz6jswvqkMdD/yzQalZDF55KDh3wS7TC9gEMJ4et6YIGUb3pOvaG+Uhq1rpqDIk8eVv
 PM3VcWSkxN7SRymUkb/yIAwkz0eCPFqnXubejhsfuLuFX6E2lpXoXV7WGvj7BYTP8kLa
 oSr0dPuoOrYrHZcD161E4bpzw47tiK7eZzxvBvdsi5qvRR0zfu2R68tdBw2tiFqaU4Ql
 /RMQ==
X-Gm-Message-State: AOJu0YynXbt8TZLvzo/S5khLh9/MD1vetbstQVi4uIcbxhLLMTOTwsgD
 kdt7R89YA9k2sj1pF1VCsKJo5qbXai3A8YaCT8tFr266lzYu3aINh7gcf059rHo=
X-Gm-Gg: ASbGnctqreFThipJV5Uv0Dzj9qx6hIDaXN3hbNVmlfIguoOaUbx0nQLI8TFLsP48UPw
 Q6YIF0XoEK7UsbsnanhVJz1zJtUsAdBFyPS+fPn4MQLi3QKhJ9f3r9jRdGrikxYPww1r3yhgn6m
 Fl87I16c8fLGjuOm8Abr6yfgCt3BKEjMyHgoPa4peOh/LCLa+w+7ndcyPkG4R9UgWKDVMUuhEFM
 FoTrVZBfY7An5z/FgckiXHVZRPX/3GJgsc8u90/h6kp47Sk3TKfz+V18YhSDbYwcBsXHFx9yYfk
 A/ZfVveDrGbuwT02Z2Q2zQxFIdJq1TTKnQtzJ1QXzwk4ovhgyi5iLmz0hrM8r+2cs9RbL+IkcAD
 HFmMPXqva/s/f
X-Google-Smtp-Source: AGHT+IH0kQ7bJYOyFXd3HmcoX/hLxklKg7IS8q/1HXEhI9AliP9T+0W2JM8YKd+DtHahMj+VQCIFcA==
X-Received: by 2002:a05:600c:3ba1:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-43d84fb5ffdmr3067505e9.13.1743010851799; 
 Wed, 26 Mar 2025 10:40:51 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm17397321f8f.9.2025.03.26.10.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 10:40:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 18:40:37 +0100
Subject: [PATCH 4/4] qcom_defconfig: enable capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-b4-qcom-capsule-update-improvements-v1-4-afe2e3696675@linaro.org>
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=iiab1HPuYzTXM++3qjgPKtZihNh3fLq1nY5j9vhpGPA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn5DwcOMLthsyuhyHfx84dwWWuU2LWLI+1UM+Tl
 HDdE6HBndGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Q8HAAKCRAFgzErGV9k
 tki6D/0RhGyaH6QofOVC47F0FRXRWFm5LZdCDD2eFjLTiYY8cbJZ1DUASCQMmioMno7KD7l9tkd
 lu7eKv3OgOzdHNlg7vajpOE2lAnKzrM3HsCkKB7wWsC+SoLLZN2HVbbPbj1CCFZPhhxMdGUg5AD
 ox/WDqlOBSakdjLuVJ1Esdh/NEV5AMgBYdhBICxIbW+whN0FiyBf7FcOtX+Ws54VISMzarshqrG
 jc1tY3ax8GXDKz7Gwe/qXgKpwZy3imh6HQNF0XJl2f8vwkA3aI/Iuh5GS49DVjO1Qbp/iR7HI3C
 YlzoocECIFOzRIEedFA7EiYc+AeEY5L4DpYQw42qqR5EAqE8DpDdMIP6pBrk74W849lpy5pAWVe
 KXrEmc4zGJz0ERg4RPCV/F0q37ogG9Iu8ViWdmORKEzEJn4Oav+NFy3NpbkSlbSHTHTA0sc9ml9
 DuiCBGXnR/3dVy1Bk2NPDchcZWOtD2ddBysyCxoikqu53rJSgbEW8H0GjQoBSilBy/m45H9fxbg
 iBq+6ScVBG9oSK80UTZknnzW8Wp/EqIYtc8KTCmG6wuwJsvNvt1h1aCtrXO6mUAUqTS1xxSwHAS
 i1puxy/HIbleC8BcRXuASrScAo4Z5uEnAZbG7QZmPZQSU+jB0DyzLEIOAtLsh7vtQmtTNxtKxDR
 +A+wjo/yLXI4uWQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

We can now correctly identify which partition U-Boot is flashed to
between uefi, xbl, and boot (including A/B support) so enable capsule
update support for all boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcm6490_defconfig | 6 ------
 configs/qcom_defconfig    | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index ba26924da161b1c4b5378955185f314b05cb1006..5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -18,10 +18,4 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
-
-# Enable capsule updates
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_IGNORE_OSINDICATIONS=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ba4d38d100e053e3708ee2623bf3530787b6b94f..d69185f3c2f0452e6757b785a023cf612bfa3839 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -5,8 +5,11 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y

-- 
2.49.0

