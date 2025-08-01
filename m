Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF336C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 10:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DE883A35;
	Fri,  1 Aug 2025 12:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u4891Gzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9E683A35; Fri,  1 Aug 2025 12:39:20 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635C183A15
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 12:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso10942905e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754044755; x=1754649555; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IPaPh1HFLHZTAToX7xAAy/lrHcqrQWr9wonZ3cDj6rU=;
 b=u4891GzmqgO3uS40qsgjUEA/2OYoK8mY63Uoy496rwWQ0WESVJ1XDcohj5GZWPFeOW
 nTH3jU19GCOVAHOooT21liLn5h1zmhgSU0T/Uj6l7Eb98X4JEY5vCXgIYyFfXNKlo3RH
 3mv18HUJRuwgj31m2naGggOiFkUkhb4oK32Smb8xCkknXg5/CnCMcvW3D85G7PrZe6Zb
 D809ScFBpuUCd+9JML0O7MzutMqfUTlp9zWYUM9Ttrz5X3r6+8uS+k725RVkEJQYO5iY
 jfYS2PFvEQhLxL9UW36+FO5PEdRHklomXMQ9B5Q1N3TIppUD1shVQvrTN3XvAMSRsZkO
 1Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754044755; x=1754649555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPaPh1HFLHZTAToX7xAAy/lrHcqrQWr9wonZ3cDj6rU=;
 b=kgGLPMpNniXMojreVHafMyHObASNMHfYzA9MUd1WEZA0AQvsM8Stnltuz0fgMkfKbo
 VnDmXJmkZd81s1QpezA+Ydk3RtAmWXiX7BW2SxtQUZs4EaB+eNyRwwNvxJy+NIGS11y5
 CfsNHvSxkvDCSeJVnpjDSZjHkVqyAc8dYwKS78IAF1GcMJa8wEACuDeNJuDw539kNC3I
 kP98Tq1IkErBsWOKLtCZSfRRFRZvKjvTuQsECXfJFcVcpdOhmTchY/+W4JxfnKusCMW1
 /B1Ce1+5kavpZydUASauc/OfIqmSI7N8yLqm3lPsC2mATaJ3I5Mn/LWw7nj4UXleEGh0
 PJ0A==
X-Gm-Message-State: AOJu0YwGFRQPK7Cl2R7uI8teCURKkc9xdpoS42jm1n/wbYrNT/Bi811P
 HLDvC1uVcjKq9Yg+c3xVqpEBLhxsVKeS5kXwWmt9yvBSLgjxQLYOF9+1jj6dm77JY+0L7xdJYj5
 ZCTMbeVA=
X-Gm-Gg: ASbGncuYAVb3TcDGyYcXzOcixufmrpfJzFU9Z2woGKPk4S1eaTJfQvjO6WvKecW0WpP
 KT+yYKK3RZAcRuApbQpm7p7fCsMZN1/nU0Gbp/A5aUbxxXCsXeTr7SavKZUGSRlmFO6LrAzXGeZ
 dPjtwgz22SUghKNwQfRE42han0a/TEEz/6BK5suzmzwqKOiBnUOwaRwdvIxdYu//zMiUeNO0OSn
 jNiqpCfDBAJJTHWRsAj0Cl9+9auP4XA4VcYGILhj6nVbOEKjMn1cv8a8lFQiMQ5YYCovVPaCy2Q
 xLO2OZ+VlK53Ki/MS3GsBxzkJDnZr9vJlR2EW/XAbKVylsmfbBPNMHgn73r6cNuECf3IhV5Ls+7
 BhVDt8qddnRGLdiCk7O6t2+xcImKyaSwb0Mpg2+F1q5q/rl+O99o=
X-Google-Smtp-Source: AGHT+IE5Jcd7wN5QRudH9LV956/03dqi1T38fDe1ywuIP2/PiTEFSooddnfYklC9kLGsp0879LZ5aQ==
X-Received: by 2002:a05:6000:18a8:b0:3b6:c88:7b74 with SMTP id
 ffacd0b85a97d-3b7950127abmr9618707f8f.59.1754044755177; 
 Fri, 01 Aug 2025 03:39:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edf5638sm59830275e9.4.2025.08.01.03.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 03:39:14 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 11:39:14 +0100
Subject: [PATCH 2/3] mtd: rawnand: stm32_fmc2: Ensure to return error code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_nand_raw2-v1-2-bdabdeb35b46@linaro.org>
References: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

In stm32_fmc2_nfc_probe there are 3 error returns that do not set the
error code before returning which could lead to the error being silently
ignored. Just return -EINVAL in each case.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 083ea4c5a74..d1c88643c98 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -942,21 +942,21 @@ static int stm32_fmc2_nfc_probe(struct udevice *dev)
 		addr = dev_read_addr_index(dev, mem_region);
 		if (addr == FDT_ADDR_T_NONE) {
 			dev_err(dev, "Resource data_base not found for cs%d", chip_cs);
-			return ret;
+			return -EINVAL;
 		}
 		nfc->data_base[chip_cs] = addr;
 
 		addr = dev_read_addr_index(dev, mem_region + 1);
 		if (addr == FDT_ADDR_T_NONE) {
 			dev_err(dev, "Resource cmd_base not found for cs%d", chip_cs);
-			return ret;
+			return -EINVAL;
 		}
 		nfc->cmd_base[chip_cs] = addr;
 
 		addr = dev_read_addr_index(dev, mem_region + 2);
 		if (addr == FDT_ADDR_T_NONE) {
 			dev_err(dev, "Resource addr_base not found for cs%d", chip_cs);
-			return ret;
+			return -EINVAL;
 		}
 		nfc->addr_base[chip_cs] = addr;
 	}

-- 
2.39.5

