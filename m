Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D2C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7810482F6D;
	Fri, 13 Jun 2025 19:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cM6UXFi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0495082F5E; Fri, 13 Jun 2025 19:23:23 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C878382E5A
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so20240365e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835400; x=1750440200; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/vYxbDIgk96hwG6Vn3Ph5VZeA6hDqdQiYm/iF9xRmyc=;
 b=cM6UXFi3r3si/Yb16hslqegzjFdALrT/R7NUAGpnO7TIBEb8itYXN22bjf7fd/uD0l
 biLFWSV0F64pwZakS8nlgd4W7DgJxjVcvyqFlNDK6ub5wslt6eiLywswjz5mA8xbaSzq
 /pnpjDcm3rzNARuTCFMRx8o0LsRhwqPfdKyLlttgER7ZVzFBokgHWhYukHohsML+u41t
 TvxaAD/GOfglcq5YdLp1uxf8xzB/WzxhR66cCYBfbgOK87tE61m6VTqilJb0rBq4jKLS
 0uG4Z8RCF38/qXOGVC5PCBd+yDt29mIwqwN24PGA1qpRMWK4MSU9e7zfqXwynttVin3c
 gtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835400; x=1750440200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vYxbDIgk96hwG6Vn3Ph5VZeA6hDqdQiYm/iF9xRmyc=;
 b=uhqLp51/d3C5bMmO9TFaiBIIp1ZKDz5wUTvEQ2rX5bV9qZ1sHOSfgX3oqflGgQZiNB
 GPRCsO7UFv3m2+17m8Ji4E+63LMVJv9mA3ayewOV+mkn1eQ5zg722nCAoCL69Em1kT02
 smKIPqdDXT3B81z6UzkSU6y2caJ8OWlRdyLh+FcErBFL//YzsmgdoUjSSzIo7HEm0cj/
 qq5PEGO6qeltWiuQlBVGgiBh7pcWJziXpJ3domn3BMQnD69RlhTPASeMb0AnCqn7i3B2
 UT4J0rZ6cQLMrQ2oe1SQY/DD1KVEX3W3Mqjc3YwDunoLmOqA5yjEmXSBPLexKiA1JXrc
 O/4Q==
X-Gm-Message-State: AOJu0Yxs7kwUMScZ+cN0jL4VgwHBxDXi9do0zcCIm3+D6pYXd5dOGiAX
 C3m4a9G3CjTGGLy7wSTqQhNLjy/S2jQFY5p/IF7lG4oNCoqVsI9QEbTDPu6fndlR7wc=
X-Gm-Gg: ASbGncv5Wn1g5uZQhxusFoSVGtbzS3DU7KyHw1yXAH+n+FmPASprykJ+k0Fho+4AJjC
 OsPna9axGTTkbODxHoZoIOKDEru5rQMts2QelgNmThjWizBzG5HhIlN/Ko/PLAMwSvBYbkAGX6L
 pze8ApTqF2B4IzPmWqQrC6OvjiPVXKifvO73kZMx9CNjZrtKkPw3Z2W53rLy6a5UISy8ePRPsUp
 l4Urka36c/8nQAEZjFUCftQdpLxSM05CpcAUmEtMvgfC6YmUTPeh9oyhMMtkMyUURSErGWZo2/T
 j4sM7GbkXIJVv1de1YELw/sOa/ma51HmPdGAFFQbXZpSfBfCzemjpgf3cmcZr9yZghK/
X-Google-Smtp-Source: AGHT+IFho3+qCRkbyB1tXH7gbgqIj9b/0rZ72h1sWfB8dwLkv6/HQhBuRFvhCySsQhc2K858U3QcjA==
X-Received: by 2002:a05:600c:4f44:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-4533ca2edc1mr5661205e9.0.1749835400243; 
 Fri, 13 Jun 2025 10:23:20 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:19 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:10 +0200
Subject: [PATCH v4 6/8] configs: qualcomm: use fragments for debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-6-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF57eCJ9iRblYLcNJE0h0X6UI47D/TTEO54Xw
 NS2JwvWUAmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeewAKCRAFgzErGV9k
 ttAREACN5rfczaHur1wB1FxJDQDf628K2HIBbQfJwbpgGHIQp/6RiECyAPb43ia5m2RSsxGcNul
 bSlU39IFi1KnW/9tMHB+f+ji4DuyaLmbq1mt+o0wWcAJtv1JCRoo2jiOu2umqh/z8X3mOjZnBK8
 ylAyjE6AziDSKlMiLoJLPlBGdzTaAvqsnr2KYbxLx1pMrMVaswXE29sVn5ZL2R56y9PZ2q+dVi2
 QRLAde1huPPrwkY4hKylLv1BxS2gKDvUd/qgWXD6d7H02rRFQ1wxNr1dU0+vnD3/uxuQe14gQAG
 Pem2w+SmxyK7hw0EMSpOUcosPds+u1hs97/IFaxI3SPiUIazL43C4IlaLUvHRffqkGRIEtLKT9k
 vdDiZ65w88ZDessz7VTtU4lnJQde3Sj506FXetOv7mMNlugLyVLZfE2PCvnDcexzr4r+3aLz/lN
 t1N+x9+bv+k5xfk+bAtmdzdsJuvi4t6YFIvBv36yoP34F3dg7cUf1EtLJgztCYkcm+XvTJuPMfp
 oI7x/tyFKgpltwumNbqUPh+ik1RhLah0EzBLN24veFymtnsjfdvtS4Xg6N9TN0qJ+n4IDM9Q0Mt
 UnzoOIiWwH+OrxpF9gUWIkIkfbCNW5VgcPmKT2GzAEAgI+/XPu66jlXOSYwhio4RF+3k9UNp9k1
 cIGR3NP2CyV4kBw==
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

