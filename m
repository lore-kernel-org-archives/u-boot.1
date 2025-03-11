Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266DEC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CEE81D99;
	Tue, 11 Mar 2025 14:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="adrJyM5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F0180805; Tue, 11 Mar 2025 11:33:23 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E6581875
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e033c2f106so5819777a12.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689169; x=1742293969;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/V8SocsB1abB1Wz/EoXjDzJPHO/k9SQOjhz/n63i/kw=;
 b=adrJyM5D80QShuGc2785aKkU2CeP8A5QRpC51aNt0RRCjBdQKY3T6psR6aIa9w0H3x
 J5Wd3eS3hVZZOXwO/L4qmuSbkq2nAfmOq7jR1vumx+LRSIqQrt/MlZ0CsoMDwL8ObTAQ
 pQPwAfHNwoMq06Kej5vzg5NaCd0fE4hokH2bkyJydFgSnyv7I5ok5VN8F00yX2yp5JaD
 p9KJfaBLLyiB3Gwrfw9BM4EnxDqSDAHR1brZMwDgvA4UxRUJqfcyagRBhra/xEULScq+
 JVDAX6lAKK1KGX6iyddLchc8KByPFGTqEJQhEKJsa0XuDO7YxvINHLoOElQDrfNjLD4q
 GqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689169; x=1742293969;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/V8SocsB1abB1Wz/EoXjDzJPHO/k9SQOjhz/n63i/kw=;
 b=fk9XdLUpR0tMQWTIAJryhBggt0Fu3uvYZzDovZpA3Bjy032XilT8KJB5e2W/e99sHx
 i8VHuvLPSbYZBqvc7n9Vh0nT0DixJKU2GP/8rm7sTy1YG9N4RSkXIaGu4zfvKXEFF0vF
 Q5U3G/YwjKzCATKHcOV/X91uCrnm+iAxJcjI4CWSHfL/afLeyDNrFsoN9C1+RUIZDJFf
 jmOaLWgET3gQXpjC1wlusPLlP8xVRL2mK3eb+SrS37bW5UHVkkE7K88CWFpgndtsdALm
 gZNZ2iOO08Um/lI2UnKFkb2HKCUNQKb2HlYkDbbFXFgfyemmiUS3yWaqUMb1NcNz4RPX
 O9Eg==
X-Gm-Message-State: AOJu0YypadCE+2Pg0zccA+A3FLrabYObBbCmxYUgzomGOeSehUnliEQ+
 nblhCLHWfWDQPrehM0Gr08a3HNOGQP/T5lyZY8YNFC2sKGCFKh5SiURtYOEqn8U53QUiguYnfWx
 c
X-Gm-Gg: ASbGncu8AOMZpIZe/2AJhISfe+xP5jxuBPYEaBpYYgEzzrBnNBQAfGjiRORjOrPXkL5
 5Q3zGA4Y9W2Q+2LO5xE6ZCd56vFVclmjL+JFlmpkHy3lPMeKJMBy9lrul7Ah4wYUYQAPXHnG+qT
 IXYrG4+75I06PJpQZwuVenes8sAtiw5Cx8vOQQZNYdRc1mHoVwIEw6Cn9pVGF908IPElmD9RwKy
 HTgCeKqCOOAO8i7voCKDwgE9S4ivU++GhdAB4gh1XGSStctMiCg7WhiTbrR2+UFhoRVHP33elz0
 maQNHZxHi40f9g+oHr9Sf3E7Zyp/uqz4yWzR1upD
X-Google-Smtp-Source: AGHT+IHksE92J+J7huqyW6FX8wA3Jx+tWU4x8zTj09JIaNHQzUWYwSdzq8oHC5ZQdayLLlDgyANskw==
X-Received: by 2002:a05:6402:13d4:b0:5e5:b4c3:8e28 with SMTP id
 4fb4d7f45d1cf-5e5e24b87b2mr43942219a12.27.1741689168653; 
 Tue, 11 Mar 2025 03:32:48 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac28f73445dsm420050266b.144.2025.03.11.03.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:48 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:41 +0100
Subject: [PATCH 02/19] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-2-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kSVHYEpa7RC5o8yb9lKmA+sLf+90TlejipOzJv0OlxM=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCHz+M6XgxfqSkLnz+Xs/KbW/YNNeU7GqotMpaa5ec
 1Ep1yejjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiYSKMDPd2zbretWlDRqYP
 c/pa04M+pkG3pBQ/hDfrcl9dLf+rIJnhv8MamRrd+6d4gr0Wh0/L5PN17c0SvfWrxK/uxkfDp09
 e8AMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

There is one new symbol to enable support to resume from IO+DDR where
the SoC is turned off and DDR is in self-refresh.

The other symbol is the address of a memory region to be used to store
meta data. This has to be the same address as is used by the firmware.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a3ac490f677429b851b4b4b3d6753ef6997884c9..1e6deb3b9cf1c5a8091a88d8c825ebdbb681424a 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -150,6 +150,15 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_IODDR
+	bool "Enable IO+DDR Low Power Mode support"
+	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
+	default n
+	help
+	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
+	  resume from IO+DDR is detected, metadata in the DDR is used to
+	  restore TIFS and resume DM.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1

-- 
2.47.2

