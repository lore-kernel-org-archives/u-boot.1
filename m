Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95AACAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F4883106;
	Mon,  8 Sep 2025 13:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xMi9gqbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A587809A5; Mon,  8 Sep 2025 13:31:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1302182C84
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ad681so5813742a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331104; x=1757935904; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/XmBYbsnZNuDAkpIPP4YOuurzMBTWZPPPkyb94xar88=;
 b=xMi9gqbZhlMHeBQgO9slP9JdgH7xJ3HSjhq3kjbENbw1FkkIlRXwQkImhEuKiym9pr
 mbfREgIh+U7ruMqlvZ3+nGNjKmIGXSl/gUHmQsxnpNtRCie8fpVqdsywbMaw5LcAYPRg
 u8u8bI51DieJGY2CBUcuBug8Y9vrMjdh1j12PgU/TiRBIbZg79bf6Zip8g2bcx0zFcDp
 2IkhPJX69aiNoSGDgejz0tm4ZwICELaNQjfwfmfLZAaekbt9i858WAaRro0jt0ZPPt3/
 AtOT8UkI/PuerwwQRdKcnkjhfy9KuRYVZ914oXBZwrVBlfDT+VvNwMVxdYJTIVu2KClL
 BPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331104; x=1757935904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XmBYbsnZNuDAkpIPP4YOuurzMBTWZPPPkyb94xar88=;
 b=Gftv+yZpOujXa94KKO5S3c5GkhPhAZgvZNRKuitRBtplDAADES3+lRqU+U8waVjvsS
 kRizcivwbCGwXn3Tj5zLBsr7vfz/sGSRNtL6XZMlQYnJdDMteQ/t5d+7N9GkJ7cYBj17
 KXRSeNqcqKw59KscN5xHi+ofEB/Wc8GpIqjsP4OjFB5OX8gEvrWbMh7OvnndweKtM8ul
 7XnoE4J9fonW/uh3/b/vwE9ERdV/Gxxe0NKV2jpQTxPnqk9xSjpIHIA24Bs5uWD8IVRD
 5po+srew0yGUYJcqNCWohTOALMFTUdpr23Co9AfRmxJ6zMClO4wka6YCizfcD1FJtOVg
 /ePw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKEU1Ia+uozzj0OVGdg9nmjCrvM6VeFwYpIbAce+W+GQVZ44hJ7ff6/N9elCI0d97YrM3kLus=@lists.denx.de
X-Gm-Message-State: AOJu0YwEf59avxBoNWdjsqWhOPpD6D5uUDhLHWYS5euYDe6xjjmiKRAL
 1q065+bX07jLBJaTuEnzaZ4h0BnTGkqC7W/FV29rWe8Y1cGiFom5FKPU7sd5qqnFmhA=
X-Gm-Gg: ASbGnctUVljPA5BkscjmvoJcBNJo8Q+Y8SCUfVCVaeDdZK6JJ+HQxB7apvqyx20KNc6
 GJNaXgLCabVLbb5cA122aEWBGEYH2FFGLvqi8EmboSlAAQljhYWudNZYpWk2W062pnbtIan3FEN
 a1EOm8BvG23iKKTj6O6lEQZMBQCaIfGd4JxOjtLkBjra5Jw+031dG+KVMPHOQHZMOt80dM7HgVh
 L+xGfp9AEB5ImbPVRUly82s5RGHwgoFS06kiZIg1rYxKqb5Reoq3Xd5culH+aOQVhmW4vfF15pw
 abWUGdo6KvhYpFYPQaz/tuBMOH2YSqktpsVJFStItuqpjZa/XRnsFzNMU83+nSbR7djahS0s55h
 YgKNUuEtscZdtiPQ6Zxfc4Qm22I7TS09YjjEGB/ESks3V
X-Google-Smtp-Source: AGHT+IHRlwcebEUoyUJ+GHezfx1krBeohzmcvSmcDtypx0XScnx93NdBVeJg7r/4NZeSuuK4O/GAwg==
X-Received: by 2002:a05:6402:23d5:b0:628:e8e3:ada with SMTP id
 4fb4d7f45d1cf-628e8e30dc7mr2225166a12.27.1757331103936; 
 Mon, 08 Sep 2025 04:31:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bb7sm21251501a12.13.2025.09.08.04.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:31:43 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 08 Sep 2025 13:31:21 +0200
Subject: [PATCH v2 1/6] board: dragonboard410c: Drop now unneeded
 bootph-all for console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-db410c-autoboot-fixes-v2-1-316ed98e0143@linaro.org>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

This is applied for all devices upstream in Linux now (when using the
console-specific pinctrl templates).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm/dts/apq8016-sbc-u-boot.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
index 26d4506815ea28cc667d3fbb211bfef33b43d013..de77a31cf1152e869c7c2bcc6433772ffb01591c 100644
--- a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
+++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
@@ -9,12 +9,3 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
-
-/*
- * When running as a first-stage bootloader, we need to re-configure the UART pins
- * because SBL de-initialises them. Indicate that the UART pins should be configured
- * during all boot stages.
- */
-&blsp_uart2_console_default {
-	bootph-all;
-};

-- 
2.50.1

