Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2477C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1093C830F6;
	Tue, 29 Jul 2025 18:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OfzHn4JQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B975182B20; Tue, 29 Jul 2025 18:16:20 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CD082E34
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so36658385e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805778; x=1754410578; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fBUTi6GOgt7qwEyiYxk0zTn2wKBTHSWLet6EOrQdUEQ=;
 b=OfzHn4JQYnJ2iquNjCRoXdoSitKqJVGkDXUHO0Q4dOwG511fQ9IK3EuEu11Cjcp6Uf
 AZAsZImZV87uBUtKB0RujJtxfI5R7HKEPOWtHDWsv+xTdrk6h3dWqs8JB7Xtl0TR/rIV
 YxjzJsFR/aLAhK0Q4n+QuZ7LN2O4gyExavus5FqmHqwm93a4sKxyZP5fdI2ITr/pTE/H
 e0z1bGwb2RtYqXe1C/Ah7ZRczgToeZhPbo6EWUVPe8Pvc7O47av+7lbo+bGMQDUXGbKj
 I2YRYSFjwOxY7oF+hMeCO1CsUrP3Qo0hh9M7DdFLKqRnFd//lEyyEl5KYtW/XOEiZypN
 e3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805778; x=1754410578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBUTi6GOgt7qwEyiYxk0zTn2wKBTHSWLet6EOrQdUEQ=;
 b=v7PwUeXByFv8hSIAJvBYjc0dvxfdnKzgSBmum99BWMSZlQgrRqRYZDZRfE9nBNZ4fv
 kzPruIpiLor/WAt/RD7dyUiK9AKLlC6m3mXpFemTbad+kXpzP5HukPwz2g24PNeTG1TN
 7VKjxjLU4+DBsfpg1gOKHzJSaFxANE9yLy7r4xk8kTJpMki3ubzuSzveX6+aBuxfBSpz
 dMxQpASYE1ke7k6IoiyfCQWplS5xPXTx6Dbc1GKYi3ALoIMvDPGYrw2E9OCzzvI/aIh/
 TQn4lywWeQoVgcMGjpPM5iB81UCoFaFMyOw1uURCiP4qrVztvtiB56gdyLnztDVfW9/W
 YlIg==
X-Gm-Message-State: AOJu0Yz4XQa72aubXpyiG1RQZfEY+d4P0dwVJpYCFvxKxE24SsNDTG5j
 MRHnc1a9xea87ocESq+raHNTnhiO4pwCXUjfwmC9r8eoRF7+N3q0JWHCXqvP76U/YxY=
X-Gm-Gg: ASbGncv2/+sJgyfGs2vkAhHxLD0E5AnY9l9jiWgqEo05TZv80Kw6JMB82zvNLRR/Xr1
 nDqjP1YGfiorPpsB1qiA5C8fHzPG6o2yb4UIn7J4zmXYOKVZfhfM8o83WWUFOhoNDlPBJ4K8Pvc
 sNssAm6Axa9463puZdoJhembmXm8r5PKqPNAMf1SeQxqa1eiCdJvzTmr6xZC2zDfJMNitbNbPSA
 mqNjSRv58vM3nSGER7Vk0cl7U0aq3Fmezh8YRQIt9bkWNw4AqGGRSBCCw+rpgNn3fUo+1PdK/ky
 PFRMr3B26JlhLo0krWLTRqBik/hJiBgAE7hEyLB0e1P3wnadckGdozk3GRSwD7b6vfzqbxeoFO8
 cs5bF3cyrJcNgQ8wqUpBrBpbtyq7OlvDojxukGNzW1W1Kz+1yE04=
X-Google-Smtp-Source: AGHT+IGqkUpPyMzmIhbaH7zW8/dkqvDoqLI+wGoM3USm7mondy4gH/iIXsUi/YAblkLstOHllTEsOQ==
X-Received: by 2002:a05:600c:3e8f:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-45892bc022bmr3717745e9.18.1753805778217; 
 Tue, 29 Jul 2025 09:16:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5da136sm29993275e9.23.2025.07.29.09.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:16:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 29 Jul 2025 17:16:16 +0100
Subject: [PATCH 1/2] mmc: gen_atmel_mci: Remove duplicate checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-gen_atmel_mci-v1-1-ea0fddf587a0@linaro.org>
References: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
In-Reply-To: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
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

Remove duplicate checks on status from mci_data_read and mci_data_write
which are guaranteed to be true as exiting the above do..while loop
above requires that to be so.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/gen_atmel_mci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/gen_atmel_mci.c b/drivers/mmc/gen_atmel_mci.c
index 6a531fa0961..62aa6b3cb0b 100644
--- a/drivers/mmc/gen_atmel_mci.c
+++ b/drivers/mmc/gen_atmel_mci.c
@@ -206,10 +206,9 @@ static u32 mci_data_read(atmel_mci_t *mci, u32* data, u32 error_flags)
 			goto io_fail;
 	} while (!(status & MMCI_BIT(RXRDY)));
 
-	if (status & MMCI_BIT(RXRDY)) {
-		*data = readl(&mci->rdr);
-		status = 0;
-	}
+	*data = readl(&mci->rdr);
+	status = 0;
+
 io_fail:
 	return status;
 }
@@ -225,10 +224,9 @@ static u32 mci_data_write(atmel_mci_t *mci, u32* data, u32 error_flags)
 			goto io_fail;
 	} while (!(status & MMCI_BIT(TXRDY)));
 
-	if (status & MMCI_BIT(TXRDY)) {
-		writel(*data, &mci->tdr);
-		status = 0;
-	}
+	writel(*data, &mci->tdr);
+	status = 0;
+
 io_fail:
 	return status;
 }

-- 
2.39.5

