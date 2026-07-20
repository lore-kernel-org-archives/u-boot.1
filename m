Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB68C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F4C84A3A;
	Mon, 20 Jul 2026 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="WFOTrqYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DF383E76; Mon, 20 Jul 2026 11:53:10 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BABF846B0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.bright@imd-tec.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so12834485e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784541188; x=1785145988; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B1Gy8I0NJGgs7U0z/gZHwRrao4YqObY34KVAANIEaQ8=;
 b=WFOTrqYVEJCOEIO85hloOrS42zNPNijHGSm3uqDlH7CnbmlYHMD+Tbrn0VfP8rutXV
 ay2apkcdyhJdGWRDp0is67dHQh6Wnzu65xwrbXUeoHPNa3BMce5GIc59nFSM5V37GrFZ
 wrSg8A1lNnvc4hVHsPEir1+rMMaxetiiIvoHa8UIQUaLYDI3/2Nuj8reYu//peGZjoBv
 4fBsGJl6QV6j4ND+LFKgiJbKx1Zwd9lz/FFnY46lrvuTT4l2qN2BFV0xvP/t96bLOk7f
 1rnJYQY6NQrAlTXXFq33xCw1X1e5CpX73TVmHJ0NNCGYtj5oZ7PsJiQrKifWw6376lS8
 d/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784541188; x=1785145988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1Gy8I0NJGgs7U0z/gZHwRrao4YqObY34KVAANIEaQ8=;
 b=CLV+hFS+X6rmQyL4DIxbN96Kk71Wed5G/TyqOJsRbkJrjUlS0+o7Ba98VGSf+pOzYO
 tvniA9Z06Z1kYFbnv1yinvNGrFFzwRSyIuUuQX4+ypGO7Qv5nsEqF/FiIRNlbT1smoFX
 1fpKj1rDBdNld8KOUJGS+jMo2ubMuNSJfO8s4LGOupqOq78cWfub6YN9Vv615e3IEFwt
 WldGQ4z6xFS0kVhW8yCWPOzKIFfHacsECd+PoK1hJcGXjliFyi67N1MI5hhWDXQ+9fhR
 AXteK+XkWwcP5USD1GC0cSUiHP8BqKqRZTcQq15YrWDZDEZ5b/gWNQ1U23FwgfRJjNR8
 HtBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYgYAdUFsYiGRfUsNuxnSuUvJ+Gk5GNV+KFpOi0X74Pifh1PhEf2hTfUoiRA0xYQOIJIhGnIk=@lists.denx.de
X-Gm-Message-State: AOJu0YzMJekLF2b0iC9wbAbnhZCoh3l/Jo7wxyT/j6dey3bVCBKk1MjC
 S8X1/8Fm0OrQc5H0T7nQE0yyLY4TUiBF2+mmxiR5oR3kIY7rKrMH4lEwpKoNAxV52jE=
X-Gm-Gg: AfdE7cnekdiTK3M5vCq3UK8Jnd51h6Eha1Kpq8wYbKKntKWJtkA6313oqE0EtWcPfc8
 j5+5Xt0GMHUBlYhYBIpJRrdo2sqOmdLQjpcwx5c3DWY3qsP5ol9gn0wTEfhhzNqDhlmSUGZWv9x
 yq3kR0X5oOn1XbcEggtEef7DNRiLxlMw3kP6MLDCT0r27/NBh0U8haIkZ1GF1DkBCtcrbtdex6V
 kyw9Xi2X6itOSdLMRD2OYUP/UC8STdtLe2jSuKs5bfhPeF+6qSvg2ldBx3JzQ74cblOcOimBeP2
 O8Os2i9oi5QjR4NjAeefjj7sTKwfSvDToezmBK5qELkwcCOmFlw2SGognyL/x6HyHZ0H32HOEok
 l8N0e5tETyTDpsGO7NDBPx0Sp5fd4XX3pORKUMEd/yfs3w1R/Le/YRR/Y/clL8iCLYL7F/zfUkH
 h8RFQ4DHG9XUed89rgcRI+Lh+iQWxL5SR0fLb6fTj/zFTuokTz+THXxCLvc6DTNy6EMbLpKA==
X-Received: by 2002:a7b:ca51:0:b0:493:e686:6134 with SMTP id
 5b1f17b1804b1-4954288e0ffmr143240505e9.7.1784541187967; 
 Mon, 20 Jul 2026 02:53:07 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm32537104f8f.11.2026.07.20.02.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 02:53:07 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 20 Jul 2026 10:52:13 +0100
Subject: [PATCH 3/3] configs: add sm8550_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-sm8550-hdk-v1-3-84f077937303@imd-tec.com>
References: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
In-Reply-To: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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

Introduce a defconfig for SM8550 based boards.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 configs/qcom_sm8550_defconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..0c4e028998b
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,20 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of SM8550 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi_a" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa9c000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xaf000000
+CONFIG_REMAKE_ELF=y
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_OF_EMBED=y

-- 
2.43.0

