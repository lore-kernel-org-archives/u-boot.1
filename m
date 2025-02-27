Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EE6C1B0FF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DE1811E1;
	Thu, 27 Feb 2025 17:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QkD4DJut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6EF81111; Thu, 27 Feb 2025 17:09:39 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6421811C1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f31f7732dso775139f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672576; x=1741277376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWF+fxiOoeOpBYzE4LlCi86ujBamhNHaAWVHdIZG6gA=;
 b=QkD4DJutRRFhaLJ7wPjw+CCF4XOP2GvWo4xadzquV7M9MqOhfAAXbAyshUMZBNPMho
 xXE+Wdo8r3x1qm2tJLkisYLn/t6IwTaMAWMWl07uCm7VoRgHMjjl7EEaXHHWQTA/FXKO
 12rU3Bai0HFSL3iO5dd4Czebarq9XN845VMNNqzUrxU+sm/lkX1qI3iAv/1371myHMS6
 b1MD0ZRX7SEYnQZvbm3qo4tKhIApbltw3DVh8EaYAePOanw6z2/+6sgWylz52XGwzw/K
 EobA9/RL+PT5Y3VXQkc1r8Gb9XFaBMpwjdQo95drS9OIEd/kcLEB9LGtqTsCRmInnUdX
 Kn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672576; x=1741277376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWF+fxiOoeOpBYzE4LlCi86ujBamhNHaAWVHdIZG6gA=;
 b=jFZaAz/h7U5BrybNSfZ03ukpG2Q4LqqKPc148GC+E2K/lB9Ew9XTPdYOc0I34Jhkbp
 Dw9mZd42qyIQQcd63g9rSzhr5idMiqBIII3hTx6UISYhipPFKt3wXV7aE5zFkrGh6AnV
 /pJd7aG7uYBC8s2VDoLBHD0et7UeSpHCy7g+Ltpxp4RrnvFm1qH+qygrPvomEeareHxn
 kzRpsjj8W6M4hyn0U9hTgWh+iiCBy/TLvVvITh++aEYZ6tdngWOY7K3e4g+rn++dQdVZ
 U+bk4NQYr/A54nek4FAuM1lYQ+WL7euQmu8clTd+SQNAwIJQk3vinEbJry2Mbmo3TNDI
 WZtw==
X-Gm-Message-State: AOJu0YzMai21bhxDizBcUP6MA3Y3l4al5W+xKfOIkGwJgOGNyGtLZP0C
 wJYxcUUwPZRlvid6jH1fCKG86qbwoOGPL7zlttdgFJDjGD15jlULG1wh+u8dsHxSDY/FGUV8cSZ
 284g=
X-Gm-Gg: ASbGncvuxZvCCREwl7pOcrZfEMeabdvSB4cMVrvHNaxsivrEoeUO2fLptzlyf2CcJiF
 MoKwY6bWMf4Y/wTnAsG2mq6cABwUOrbRQbU3+caJZEUT0qK8VNmN1H1iGmiEZkPuyLaxpTXLMUJ
 C10Q1zKqN5smSaggdaIs11HhPRZzZR92CRiJGkQZxq0sDiEy5ef9YmEIR+/gxFSPDKWJVi2YHv2
 ErzO7AX3bjJ3bqc5Km0TIzMOpqbA6/+oOvBEYOf6ocKHyGU+eeWeGYR2kkjbu77ezt0EuM4T/hV
 Cxz0uE8b/1xRCrVWss2w/o95W2+GynRc17Y=
X-Google-Smtp-Source: AGHT+IFQaSPaI38zOo/PDqwOrLpJCoOpHoYWUaACDkbtWVvTaGzcqilHEn8NTeK9AMgh4z8uJz/n5Q==
X-Received: by 2002:a05:6000:4594:b0:390:e535:8740 with SMTP id
 ffacd0b85a97d-390e535884fmr2047090f8f.14.1740672575936; 
 Thu, 27 Feb 2025 08:09:35 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b925sm59506795e9.7.2025.02.27.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:09:35 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/5] configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT
 and MBEDTLS_LIB_X509_PEM
Date: Thu, 27 Feb 2025 17:09:05 +0100
Message-ID: <328b4225800ab778089f095019fcd4b75e872a37.1740672437.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
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

Enable the "wget cacert" command as well as support for parsing X509
certificates in PEM format.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index 754c770c33f..f48c132743c 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -8,3 +8,5 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
+CONFIG_WGET_CACERT=y
+CONFIG_MBEDTLS_LIB_X509_PEM=y
-- 
2.43.0

