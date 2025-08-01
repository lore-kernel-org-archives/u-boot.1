Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB36C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 09:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0645A83A2B;
	Fri,  1 Aug 2025 11:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XzBLr711";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C4683A26; Fri,  1 Aug 2025 11:54:14 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65FC83A07
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 11:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b785a69454so370110f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754042047; x=1754646847; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q4F8yv5pqp2tlhQBZyeq8OMBZjyTHRRw5FfZgRH4LVs=;
 b=XzBLr711WTunVWmem2qNzfalyjJtVpCoD0xrg381ZK8EIKmo4P86V9rRyw+zdAiGO0
 +ENsR7hJnx8dloeeHBPXmNf3Xs6BBsmajclAEJ6ruBYyqLp5iIFeg+cg9gqE8HFj63qs
 DNElUCq4SDUDe5HHalyZqVpcYbyJZVqwrw1ZRqWXCNq/dmBoHHupy17QCOhlKIxvhTA9
 nSY8nBZvbDwg5ysTZJGKjYYKjNqV8FtauAH9XL+sK/+P+jmz5+kP81pGPuNBIhzvSRPZ
 mOb/RP6CTfBaIufMCui7gRA7PmbIsMTiSsJPQKKKb91WXT9E/W6kLorg2zrSlnb8Uvt+
 Dv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754042047; x=1754646847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4F8yv5pqp2tlhQBZyeq8OMBZjyTHRRw5FfZgRH4LVs=;
 b=Xq7IlhIz1wASn7peJMwEGm8xy5yqDMk6yPFaB60vD+Gl3OBFVgi0OT9RQaAJRvps33
 7E1MBRylmyQWmWS79eQya4pBGizkzNHlLB+2STSurSn053FLLV8LrND9FqTwj5ALl3++
 7GJp1LdFNVfiaIeWiv/W0bbag0h5pbEoBd0vbt2XklXFIFKG4qa+UPWmuIqrxwat+6UM
 8nOADPVZ8wgRd/OlQMfgp8b58AUiYENTTa7TsEzKPfO8gYybVxLoBnUbvZVfHzG2E+Ut
 PchuhiY9nNsPGnTy70EbwEt/ZNAGbTM/vR/0hvJkvI382r9KaJw7YIsKwRVk6zz9+Yzt
 6M6A==
X-Gm-Message-State: AOJu0Yzz68RCn8GrHLkFhWgTsT+FsHNCKt8UbZPJONvkKsJUfskqQRKY
 59AmNPSiAtjquZyNdJg/b6eAnAmi1Jzs+aIs/1JaUZbpzouhlTPxm63zmfI96mNJd8E=
X-Gm-Gg: ASbGncvv8vPVWoH4u6pId/iOV+53d5WHA0lERqYD3bb6T6pv1q6br0R1gXDSZPDiqOf
 4S1kdme2YnqTrB6VMbST59vfLQ6AtTDxKWVYa3f5a7pxhDPo6UVn5M2+SWFnUQOyHWbwc+36OBm
 CIOeAOty+eR+SYGlOLJIyFl/dcCJOeTk9lb31dD8Hrbce2ivOm2NDVntTU5j//ryHWx74g32ae4
 3YXb6tz9Afqu7Y9RSLj1jeaTUi+ZnGnJP/IMTXbbX5OhyU+v+y37LNalG9nSuqnkyGYIeak9rWC
 E5XrIxthfjDT2J34ooux71+xB6FOqSVxcgQRExbk1yA5UDbnk4ayXmrESbDWJh2GhqN5sUOodHp
 Atlj41MwbN2DCcig3vdK9lYqt/eVxNAy6ufZ/jpDAHMDQQs7YvL0=
X-Google-Smtp-Source: AGHT+IHcLzSKJsUnso6G7bMFn8rW/EHtB5ih1vZlBBT2bPyR1JOyPaxxpCZHeFoLDHpHv+pXmFjzng==
X-Received: by 2002:a05:6000:2485:b0:3b7:895c:1562 with SMTP id
 ffacd0b85a97d-3b794fc1a60mr8991578f8f.11.1754042047043; 
 Fri, 01 Aug 2025 02:54:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eba17sm95280515e9.24.2025.08.01.02.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 02:54:06 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 10:54:05 +0100
Subject: [PATCH 2/3] mtd: rawnand: denali: Remove always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_nand_raw-v1-2-80c316f5bb99@linaro.org>
References: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
To: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In denali_wait_for_irq the code will either return from inside the while
loop or exit with time_left being 0. The following test for time_left
being 0 is guranteed to be true so remove the test and the following
unreachable code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/denali.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index b2401116689..39cb641e0b3 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -173,13 +173,9 @@ static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
 		time_left--;
 	}
 
-	if (!time_left) {
-		dev_err(denali->dev, "timeout while waiting for irq 0x%x\n",
-			irq_mask);
-		return 0;
-	}
-
-	return denali->irq_status;
+	dev_err(denali->dev, "timeout while waiting for irq 0x%x\n",
+		irq_mask);
+	return 0;
 }
 
 static uint32_t denali_check_irq(struct denali_nand_info *denali)

-- 
2.39.5

