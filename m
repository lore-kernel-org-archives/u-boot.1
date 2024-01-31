Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B306BC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1F987C46;
	Wed, 31 Jan 2024 12:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7i3Z2Qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56688785E; Wed, 31 Jan 2024 12:12:46 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8288B87B5D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 12:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8bc1caf00so3160817a12.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706699563; x=1707304363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aW+wjG9PWWLR8L3CEL3R1/dz5QwV89p/ESCCJ1sEK8Q=;
 b=L7i3Z2QdxMbpdCm3wT5ew16vzXqIhhsg+01gSCgc6arp5twUYp4uYmLLPO9uJhMqXR
 AZ3sMhYF76X0JSaQGMr1axLOi8TBijjGollAVov7o4119Pjax9o9Qla2RV86JoU9ykvz
 U6khEEVp416z1TvZoQVhwT7fIloDwiIdj/wOo39KtY575EDIwMLOxwt7LLtiqKkvt+fv
 P8dv/vxbbFlY2fqi+Da3HpOlAi+tfR5o9jjLovWeEWfEK207QJJBblrUesBZMPdeOhE5
 6IGMCldA9rsQktqzn/thVxzkuVXU2R/0RVFvNDX2ZYItgkOeqgoFG6uIFDpBuEtSfyMU
 ZUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706699563; x=1707304363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aW+wjG9PWWLR8L3CEL3R1/dz5QwV89p/ESCCJ1sEK8Q=;
 b=DZZ5ZbUoNTAql6wIp7kYGgX4SlHIimJhxMciR+vYP/vhfezKvb+agevcXHUKPrVSz+
 4JUqXBh/N4p8e88Qx6SckmfvTrWZCRLytyVbKY0PlQAXeJEnaoD0zawrXOngQ5nvUhn5
 swq2ydLuYIlFjxZ+bzfgNJXeoqNgMQAIiFx44GrZ0tY2LePx0UoB8uadf84G6aNLqbgL
 wugVgYEjO2F6DrMjVQIY4+cSRP3MXouXHnR8IELVPahLKueR3Ux5wudX+mmgrIhwQyo3
 K+NAscI+B7WGqRFszXjB9Af7keSgy9GeceBp3vg2PyZ7gFO9lBzFglEKCGQknpZHCRZL
 VmiQ==
X-Gm-Message-State: AOJu0Ywxq1vfUgCFmovuHuEm2uiZlur6IicWNA6Y0onjLjT4bYDefFCD
 I0H1wb6iMBA+vhiR1RRaybkmvUhgFl/b3VuEIprkELu8WsNI6VYf
X-Google-Smtp-Source: AGHT+IE0Sx1I5/eHF57EriN41BB+FfRY0K/1Xa4nuWKQZiBhKkCRbqiohjSmBjNS8jcJilwDBSW7mA==
X-Received: by 2002:a05:6a20:5d89:b0:19c:9a25:bdea with SMTP id
 km9-20020a056a205d8900b0019c9a25bdeamr997627pzb.59.1706699562184; 
 Wed, 31 Jan 2024 03:12:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXfFRkvMJUusymNfURTa6qnsi3qhTRt+YUNXiyn1W3aBvS5Rcsa/Nsmlk4BU50OEgeNo/fXGR902ZQgYSng2WoDFg/e/HqE1U3rURhJYa5kZisWVdWynru5RsUUEf5Zty+/DypZJ9UXpt7ZeZyxdJ9waSwPNg92I9LvJvvd3Witg8ZZn0WBn2Mh/aCXaqJO+t6FVl5MQa12jhDGZNoNr3+Tp1jeasHHi8ZAuscdSLiXSSksacqJvK7LfGUElzJCPsY3tjJIr2ZWlKtfiHVBSQNcvbcvKXjsOtYL1ZD0VrOPd7eb1dOjyk9gSfFNP+6FC7efdeiaQ6TYIwsstw==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a62f201000000b006ddc03c425bsm9535007pfh.180.2024.01.31.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 03:12:41 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/3] driver: rng: Fix SMCCC TRNG crash
Date: Wed, 31 Jan 2024 11:12:16 +0000
Message-Id: <20240131111217.30124-3-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131111217.30124-1-o451686892@gmail.com>
References: <20240131111217.30124-1-o451686892@gmail.com>
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

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
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
2.39.2

