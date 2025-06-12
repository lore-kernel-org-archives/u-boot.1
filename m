Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB4FC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FA782C79;
	Thu, 12 Jun 2025 16:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m9f/Xrnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0747682CD2; Thu, 12 Jun 2025 16:16:52 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F1D82CB8
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so12293245e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737808; x=1750342608; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/vYxbDIgk96hwG6Vn3Ph5VZeA6hDqdQiYm/iF9xRmyc=;
 b=m9f/Xrnx8NkmQVIBZc+5wkxaQ73qLXu2KC8xLh1Pk58tZikZb92Wg06bYX3o6YjmHg
 ge0TSkBeeWEtoyxXzHJIc7TeEdDFwPDOazUvgREXutjwIK4SMquFuv1zSbC/VrHXbee/
 ok18bgVdtbNDaU/6RxzyvehA31xg6vN2UJNjpKhoDoevw+vS+4WY/4rtad6QcviHpVLz
 Jhg6LJbWDC4IoNnaOmlxEbvkIZ56MObq4/+Ft+dQSLMqaYMVQ0dIf3gMB505G27eSHY1
 XGKuERwmazejSjDaSTLDc7wtcJ1PUeIQnOn7d28D5o9yqzObmNVr+3ejIVozxIBraYPf
 xAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737808; x=1750342608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vYxbDIgk96hwG6Vn3Ph5VZeA6hDqdQiYm/iF9xRmyc=;
 b=AYmHd3Goyq67Qsp1Wgpo5pOCRQLOl+05r8+Z9cwJAxCtK9TW1SeUl+uJ22NJYl7Dyi
 INIjy5XEW50W7XQvYF/HHDN7LMslSvBduLI1VaGP7L/VZQR5CXY7PRRCSu+aAu2DZ9zE
 8eV1syxJ4f2/n2w4R5iQ0wHdxFALaRwzRJLjE9tAxHb38SOLHt5mw3+bMJtWfpUnnG09
 ZijZ22imEo2rLJhrROhzbxUQKwAeaPaC9Jya0UNHgaBX+KLO0QLW1T6DSmgWmJnxUXWM
 AsjuWK9Bv/mqfWlQIqi7DE2WFS44Bhqc6ltTLez6Tx7WsCy0lDG3zICtuHPXNUuOuBIp
 W3WQ==
X-Gm-Message-State: AOJu0Yyy5hdux2rqmaRVAc2blpwcUXDcdGrOX7wB/xy2CicKOIMehFY8
 dMl/lJbie4S6+Am964O1MlXZaecbFwTKcxDrgAPsqPKYQR8vtnS2HaBlA96jW29RqjJgpZqgyKi
 rLcZd
X-Gm-Gg: ASbGncvzzkLN0BSqECDd8sJW3+4y86rIpQ3i21PeOux+cdLQLffrRivmTg8ZiJincdE
 OLNRVA673tZA3G4K4JW31B8Dy+ZriSrSyAvW3EW+9SszS9ydqeDLn6TMMpDafnxah2tmXHQbkDI
 /59SvWN6FhTqHsRVTcroSenY5/rTX/Sqs/w4cX6EGDiecEYKFgL3S7gAuSN+bJcLykJcBBPL+fK
 JTatWnhmBCCVW/je4v5Sxu8Co3UahUikctcaBKNLtbAoQOJM80Vz5VS0+fpJt/lTtPduibrlziv
 vwo8rnqJMk6dsLOb6jClkNWox/FkuZWrTFvHmtUdX9ue4vuAfLaLbXT2Z+fdQm4ExY48gsLLQnp
 TlmbRRXg=
X-Google-Smtp-Source: AGHT+IGWorE88Ysr+VneVLVswyIJ1scErit9uzdC7v//kM8Rq9as9Jq1ydxGu3dTs9X1LchRuNTkTA==
X-Received: by 2002:a05:6000:2285:b0:3a5:5149:ed1a with SMTP id
 ffacd0b85a97d-3a567a37ac8mr37628f8f.59.1749737808419; 
 Thu, 12 Jun 2025 07:16:48 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:47 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 12 Jun 2025 16:16:41 +0200
Subject: [PATCH v3 5/7] configs: qualcomm: use fragments for debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-5-76f34cf216e2@linaro.org>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=tPcPJXKRrvrpNdWhOjIGBp62PGpeFxFg0BqPUSSotss=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFH77ztl+8Fz6nrCBtd1dI776L6dtEQnkhA2
 46rZGFpQ72JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRwAKCRAFgzErGV9k
 tlI0EACj0Fq/REhvg6hXvkhfwAlHNVcJ7RGotJTgVYSOsofQ5UCAUNvGBWTaNICAPvEYrlg/+A7
 KcCamoPISTVEckMgXlW6SDdIJ8Uo9WXukiC2SS+/J2wR4evBjN+nwfwM/A8nF5rRzy8h+C74y4q
 C6Zyedoh8oBoLEP8Cml4/+EZ9pP2ghEbWOlmCxvnPNh8uBhIvYNULPSRZfg1p91/oQQqQcktJP/
 nBC8UrkuY/fVkQh65ueieedk6xKHn2RY6euF23mhGEGs15tdL9ayV6e/QgNyrfs+f6LyVk8HGX1
 4M69oJmF+rDtlSpjNucKz8EN3Jg/sI63rd3y7e1IapH/vX/I1fVtBTKZIflf4mqwWdFBVR5y7C9
 LhLweTw6rXfvc8HSKQkyRyKPQiI0MdDaNWGqdnxFOJHd3855gXR7/MUe4NGI6PkBTRhMGL2NrcM
 dAjN14xF8eMdFnGn63835LOqVaIhBhcDcO2vLdazOUc23HBWJuuqXE6YS0z9UPEkVujmyz1J4LY
 OQaGo5o9qEUA8DKdfS4Tt72vIrOjFxzrNF5ium3CbdmiNWMEPeeBJYKWQQ5UadSQe+OVShEiD0y
 zxGSLJoi3Ffd9Otv7C0HrdDc9aOz2j+CJXxmgYFvob08I/U1+zV8ZqCTJxezrXvHa+1UIiteqbu
 gx8i5n5nkzFfjPw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

The QCM6490 and QCS9100 targets always enable debug UART, but this is
not really optimal for typical users.

Move these debug UART options to config fragments so that they aren't
enabled by default.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 board/qualcomm/debug-qcm6490.config | 5 +++++
 board/qualcomm/debug-qcs9100.config | 5 +++++
 configs/qcm6490_defconfig           | 6 ------
 configs/qcs9100_defconfig           | 6 ------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/board/qualcomm/debug-qcm6490.config b/board/qualcomm/debug-qcm6490.config
new file mode 100644
index 0000000000000000000000000000000000000000..9ea54758794ef9d2f698cb4026da44be2360147a
--- /dev/null
+++ b/board/qualcomm/debug-qcm6490.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x994000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/board/qualcomm/debug-qcs9100.config b/board/qualcomm/debug-qcs9100.config
new file mode 100644
index 0000000000000000000000000000000000000000..8ca042b440d100e9583ff9504f1b0e67a491dfcf
--- /dev/null
+++ b/board/qualcomm/debug-qcs9100.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xA8C000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43..54eb5dedaecb7a82c26a4bd7f5d1807ca6d4201c 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,14 +7,8 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0x994000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d2539803143c8b770b6b28e8dc52b1d5846..4ceeba63ec12cebbc2124eb256a255450500152f 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,14 +4,8 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0xA8C000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 

-- 
2.49.0

