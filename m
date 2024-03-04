Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D6C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0473487FAE;
	Mon,  4 Mar 2024 15:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOJKQ1kN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7314D87F92; Mon,  4 Mar 2024 15:43:15 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932D787FA9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso38227945ad.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563388; x=1710168188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V9B66oKheLZECYu8R4q13CZZkJRH/+q6HouwoF0reSE=;
 b=WOJKQ1kNzCFxGnlQ+JgSuiOnHGEzygfvdLDTQjDBPu2wk0Tksa1srJOibEEru03lHt
 6uIsalng6p2rX0GM4pCbb3U8G5M5yZdS369Ey8Pn2eVkdPpiT9tm56AP8ZSwuk4wOYUn
 Nm5oEUDHFdKsyQaqSRLU5bd2JkINWI+RAWwPTBsFKwbRgqLiwCeKA1aBn0jp6XRN0/ee
 oo6lNf9J6GMX+SnKfbdPFXSe6Fcikid6wXZGrS8gU+S7WdlqtB085qd2GC/Y+xr/LWBE
 fJQenL5t9+IQNe8TeAf1exlJSpPnfAxubTPTyPPkhwoxwkHXSISwSQEQizSVT0z/rXu6
 W6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563388; x=1710168188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9B66oKheLZECYu8R4q13CZZkJRH/+q6HouwoF0reSE=;
 b=LlqZ4Tw7n4AMR1wsocCRtYEOwDiHGZrjDxnlTTN7LQ9s4+/cQx8lfupNKr0CNdtyZP
 ZKCH3i32OKD4INW9kQv6qQY1TI4QYTUWrPSOxEgM8EsTk1gWmFupKNv7b40hgAoo6R48
 Q1xfobl1FA/yIpVWEw73wLieoWzQ2HFVDs1EzldgRIx09DhOdQGx/E6JmezCo5lQqp5/
 Y/BiDy+xV7D8UrMaA6UDB5hVYRMjbL9TqNVS0RyYQhtlcQH2HQ+XEhWHdfD9vgmpUXgV
 3nrulRrEymzbbJUJfP9Zou+Elh8eG/n38mFH/ZV6Fbg4ziIt2S5z3NuyzOGzUyKsNFjE
 McRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuNBxr/as+XrpUkHahjAUUGPWruIY/oyjl2Zv4RRmD1ite51yeZFkqBXVfLIf6E9iXel+eo9sCji5HvudYH5DkN/bGjA==
X-Gm-Message-State: AOJu0YwXZZKdf1/KTp9nJ+gYN9IIDtzwrPcTAueHCN6a3ZwjkZIFD1bf
 1mVip39pNQX81FmQBplehdwQlAJfkJ+RPJgoNlBZJK7vb5lz/Nwn
X-Google-Smtp-Source: AGHT+IEEM2VTEpx5ngWF36rWr526kWzgpCAP31yE3X02hp+oLXcEeWyPTG2AMbgZFqDcl7QtYUSWMQ==
X-Received: by 2002:a17:903:2409:b0:1dc:a605:5435 with SMTP id
 e9-20020a170903240900b001dca6055435mr9750422plo.31.1709563388165; 
 Mon, 04 Mar 2024 06:43:08 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001dc8923a2c4sm8629529plb.294.2024.03.04.06.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:43:07 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v4 2/3] driver: rng: Fix SMCCC TRNG crash
Date: Mon,  4 Mar 2024 14:42:41 +0000
Message-Id: <20240304144242.11666-3-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304144242.11666-1-o451686892@gmail.com>
References: <20240304144242.11666-1-o451686892@gmail.com>
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

Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
binding.

Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
v3: add Fixes tag
---
 drivers/rng/smccc_trng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
index 3a4bb33941..3087cb991a 100644
--- a/drivers/rng/smccc_trng.c
+++ b/drivers/rng/smccc_trng.c
@@ -166,7 +166,7 @@ static int smccc_trng_probe(struct udevice *dev)
 	struct smccc_trng_priv *priv = dev_get_priv(dev);
 	struct arm_smccc_res res;
 
-	if (!(smccc_trng_is_supported(smccc->invoke_fn)))
+	if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))
 		return -ENODEV;
 
 	/* At least one of 64bit and 32bit interfaces is available */
-- 
2.40.1

