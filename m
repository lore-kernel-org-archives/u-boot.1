Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E9AC77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5236E82E86;
	Tue, 24 Jun 2025 10:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dcMGM9Ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446BF82DA1; Tue, 24 Jun 2025 10:45:38 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 531A282C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453426170b6so36021885e9.1
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754736; x=1751359536; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MHlto/AzWDARsnl3YbHqWIdVih1FRZCx7W2pWMX+Sf0=;
 b=dcMGM9ApDm+8oL7AmByCLfXTIgu9fmkKDoSkL3mJL7b5zp9J2FCiYn+5KVjlGNi14d
 pEUbmZWxMh17AwbJdSGP8+YsLf/UaM6DvqoYJVeIwEN7vNV8NB4GCqGVf6Xg1iW64ESe
 Sp9rpPdF7eQyQsiy/jFrVS6PrnQF0EZNqMWPS/6hz6BdMBlzlIHbqkB3BuIAqg4M7LtD
 l9+ocVv2WoE7lD/ZGjv0Ja1Vz5wUBLW5T19nScy2jLfevQHylCaQ2T+ypu6VOsXZCu2/
 7UCdttnM69C28DqrDGbFHNHGZANmTB6DYupduQeRPup2USej1eBzIWCWR5V7UJngJzPt
 oi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754736; x=1751359536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHlto/AzWDARsnl3YbHqWIdVih1FRZCx7W2pWMX+Sf0=;
 b=M3wqOFOftasTLeFmZQ8zdaoiWIzHSm+jmMTBau+P0rpMa8qeezJEa/2+nZgg8oso2P
 densJGbVgPCFlvp/R0Y1/sN6zYpX4NnzLQ8qDrjj2UnCnbeIgXXPJB8i8b1U1cTgzEOm
 CiiKaLQftxl4woF6lG0g806SemdpAsgU680oTw3L8x+EbZrwqlNMdACfHkkVViMq5tJV
 wfudjPWS8gpcus0bPA6KVojCs473N6axujjqwORKa4lvFzdoaaOkcuaZRgNDoI+emOfn
 xk1gnD3DpxLFyYf+UEDcl3FIAMz7NxsTgFLjz/yLoVJRt+M6a16WTbeMhZoNUMyxyyrP
 i6Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpAWUh4m/GmHatU/HdOk+XYMAuPoA/Ls3wlgwDMvD2SEXl1Fc5O0DLzd+oMH8N4awpvHw7Dck=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+GxobzT67fZGvfgqUmAvgeyG83deKp4gD2MNdIPlGFn/O8D5l
 GsyAXGCUCoHejIWy/WOixDA20C2QWSb+69Bxq5hal2unSFmrmR6BdVyq1wQhOKYgdUU=
X-Gm-Gg: ASbGnctUVAy8imnm5TO2cWrrmHGzXKv5tzY8kFBptY4RSP8GL0aFC8VmUnisMzWGiOV
 mC/CfzxrJPd1w1N672qm53s+8QsdW3hisRv9t9/mMMiCU8RbcutrbaaverkecemBx5Q2LmmcO5V
 mf5BsD5NScCXrI4qppb3wUAb0n7slzUnZ5XHcEjcyjK6yJUncx52uVgjxVXtQPGoMtrYribsSss
 Yt1oYe0dkoNl6VccSPViLC3kKS9pOdKuFHouJZy2YgRQUPlv9t3DG6CsNwoHT1DAnEyhU22bw78
 7OYJ2KXomdmnN5VNxq7WHhRGJQLTHiK++Z8yESp6LlT3rrswke/4BcZjoBsx1B0W0hpFLZGpIMQ
 =
X-Google-Smtp-Source: AGHT+IFDRhvWb4DhzhcNN/NtFRprPCKJMtIAqT8IcQrp0gszU+uNcPMcObcN8eg8PVk5fRtkLZqgSQ==
X-Received: by 2002:a5d:64e6:0:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3a6e71ff6aamr2165998f8f.15.1750754735726; 
 Tue, 24 Jun 2025 01:45:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:35 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:18 +0200
Subject: [PATCH 05/10] board: dragonboard410c: Drop now unneeded bootph-all
 for console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-5-d96c97ae41d1@linaro.org>
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
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
index c8a46ed14483f6939e7a666b2b279c803476ac63..de77a31cf1152e869c7c2bcc6433772ffb01591c 100644
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
-&blsp_uart2_default {
-	bootph-all;
-};

-- 
2.49.0

