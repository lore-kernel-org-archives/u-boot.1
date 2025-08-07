Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF40CC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7C28459A;
	Thu,  7 Aug 2025 16:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NrHm6uqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9368458C; Thu,  7 Aug 2025 16:29:09 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE06C8457D
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so927743f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754576944; x=1755181744; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SpHruOmtOIU0vU/XwbF7ciM7WeouPuaq8g5dF2b3Ajg=;
 b=NrHm6uqcFbb9oIqteKM6evBxYM1wrm7ATX5QPOD3vysKMVpbvKwAmcjLOXo+QAwoJf
 90voRyLn+m7cNpvNDCJ6guaJQZdNeUwfh/OwUwG2dn9qn4fwLV8T64DnNAYnj7e0PHHg
 41Yx89NY4jBk74gjz1svpFck8JmyQ+w2R7R4njAAE02Z4DdehCJZjQ8bOTT9EGGCZDpU
 s/DQFB23qUrsEs5N5cpEMTPhNru4d6p3+99TUAzNEpYQvJv5QGLvox2nWSoQnvJykksy
 HYxhaURYUA57tPMIoRhzyOOWwGbD/euw7V6e0pXzGzOtLiA+G3MLinUQ2GACEArx9EX9
 CM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754576944; x=1755181744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpHruOmtOIU0vU/XwbF7ciM7WeouPuaq8g5dF2b3Ajg=;
 b=GO4LSB4719yjt7UJjKPyK7ApmRk3FWpozpWojWhpMk1zCojhSG/gTUA//A+dDe7sq+
 JyiCDR6DXAHh1dTDYwcmg86YI9eadv7UDG5v1UQ0rjPCkR09pMxBUPBDwakYU8DoqC1y
 jbgFchI4s/Uliygu2JlIymUzMGmwNmyHXnMAd4BwPq3+dzZ7o9HADgVJB37BFnu3F41C
 +u44imureuPJp2j97776Qfvs55vA7nm4n0AaDcA2hL2dVgsocdZDMkiPfeZ/aH5381XA
 KQ0MMJWh8iCh0PtOUOAv2W2PdfWmZkxPH4JrGP/vWKbu8nd7PT53ZFdxXruLdpFA/l55
 83vA==
X-Gm-Message-State: AOJu0YyHEdvUaHesN8uCWa0WP7dIITtxpjc3xntLDZ4t1bpTVeUt3ia7
 T16xhnL8ozbVKa6FjNFzFyttE/+XIMzgUQG9YlMui/1AcbtWGqXtYZ85gNskJtukMWI=
X-Gm-Gg: ASbGnctVVv26h71v1ks5RRyQ76P7pTXac66vZSIDw8SSFYlCHxKPF/GDLhVS5JckRfi
 R7w+XU3ZPgCVmwNSxMR8ToCTjm9lcnNsQzS3q4NByHRQXB6Th4J6ljjQa52T/5AXN8SmjHIAX9/
 OnHs/5PAsj5+UJ51833vJ7Q66mLSa+T7JVFEedKYvsi6GMOqKT/wXVY+tyy2JPg4ZOcIm9RDe12
 dlLGE78vNd53lU2hBSVopTAGT2gcrVkBBezoNuv21ZhyMunNAOwliJnYP0q3egWIkF6Hh2eb9rM
 7VBr4950HIaY8xDLb8kI7Yus1/VM1e0tastYbfOOzUmKEZd2TBvFXGxR7U/FHkK8ou413+b7DvG
 rdhBYNvrWvP83mQOAtvr+O1oRhsWKB+EVHmJNcxDIPIpbxpmvSxsT1kqiWGZVHQ==
X-Google-Smtp-Source: AGHT+IFF7yqA18um4UqN6779u+RSiOF0Xm1ss06HjGG7CsQ4s76mrvxqas3ELE42v1Db89rvmWB4YA==
X-Received: by 2002:a05:6000:2081:b0:3b8:d893:5234 with SMTP id
 ffacd0b85a97d-3b8f4923cf8mr6270972f8f.47.1754576944225; 
 Thu, 07 Aug 2025 07:29:04 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm27349027f8f.44.2025.08.07.07.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:29:03 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 15:28:58 +0100
Subject: [PATCH 2/2] power: power_i2c: ret is uninitialised if not DM_I2C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-power_misc-v1-2-2ac672f15461@linaro.org>
References: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
In-Reply-To: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

In pmic_reg_read ret is only assigned to inside #if
CONFIG_IS_ENABLED(DM_I2C) so move the test and return ret inside as well
and also guard the declaration of ret with CONFIG_IS_ENABLED(DM_I2C) to
prevent a warning about an unused variable.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/power_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_i2c.c b/drivers/power/power_i2c.c
index c2fc1c6b42f..58289ecce67 100644
--- a/drivers/power/power_i2c.c
+++ b/drivers/power/power_i2c.c
@@ -75,7 +75,7 @@ int pmic_reg_read(struct pmic *p, u32 reg, u32 *val)
 {
 	unsigned char buf[4] = { 0 };
 	u32 ret_val = 0;
-	int ret;
+	int __maybe_unused ret;
 
 	if (check_reg(p, reg))
 		return -EINVAL;
@@ -91,9 +91,9 @@ int pmic_reg_read(struct pmic *p, u32 reg, u32 *val)
 		return -ENXIO;
 	}
 	ret = dm_i2c_read(dev, reg, buf, pmic_i2c_tx_num);
-#endif
 	if (ret)
 		return ret;
+#endif
 
 	switch (pmic_i2c_tx_num) {
 	case 3:

-- 
2.39.5

