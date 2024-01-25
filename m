Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33932C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8488799C;
	Thu, 25 Jan 2024 15:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMajJreQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 307EF8799C; Thu, 25 Jan 2024 15:05:43 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128BF877BC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d71207524dso29393405ad.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706191539; x=1706796339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O2ngYXwY+cKFGpNDkR+ROk1lRTC9/m7Kj3St2IuESVI=;
 b=lMajJreQacs7TiLvEAwObMcDiaThNnmUhHT6UgTL8hyGMbypZPjDlraM1P986sBT0A
 UDSE2rvucdjJuyjTPf18iBcxL8Ah1FWFh8DHENL/81C3LTxdEgtw7UV4bwf4qMKZtuyh
 fqwVce8FQWQNRLyPhcEErduANE+0F0L92Ycai27fCf1qZqk6aF6Atv0IQQsAECWlnugN
 P6TxScwSLvWGk1LyGzjqHtnzIiSXL5VRABmF1Bw5WQ8FffPMOl5KBXBcic1nammdKEqr
 ncZlNabkZT2cfTOrU9WB1i3GMeEVdKzAWFsbJMHAJApRpht7CAv22NIb8nfNVUrMXVgi
 ZKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191539; x=1706796339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2ngYXwY+cKFGpNDkR+ROk1lRTC9/m7Kj3St2IuESVI=;
 b=CcuBYl7/GRppX5fHBzGX18InXaNS2XuQz2Xm2WY35WyzYNTSx/W8IpkZ4YJ1+YE6vD
 oPEIhy7rq/EF1gmzAIWJaWHaHo3tWFE95EXPSnLia6lqXmfUjzCVM/441IRlGl5cN/o7
 75Uxmh1I6F7WDcTC4O+sUTGQua2cIo0hSPYXn4zd1RbcEMXq5CmBEbLH8fFEKCJuQi/v
 CX2Ix3X3jxqXFOpw2HbH3ht/u36YlUpqs+gyMX7dXjPJtIEnj/zTRYfWDzm6mTOGU14a
 1cM+nlfsQBA5u4gOJ+WUSDW+96rmNSG0Hc0MeW+gBmJVt9fK3NeHkz4gw33iaDz0NeOo
 lTtQ==
X-Gm-Message-State: AOJu0YzKzjV4W+HAk3wSCNh6S3OjiLtW2TIh+YNDilLbUsi2HzQdX4wy
 qcNFPAab5AoVjDKxDLTiy9znQ3QKDvWVEl+bBpBVVswJRuNo988K
X-Google-Smtp-Source: AGHT+IHsbr7CoOItIr+LEdK8VkABYPgypFXwrUJCRQxsz1nzKeTtJAUuXi41oHnUTa3pZqCm8ED6mw==
X-Received: by 2002:a17:902:fc8d:b0:1d7:1e5d:ab39 with SMTP id
 mf13-20020a170902fc8d00b001d71e5dab39mr1064455plb.80.1706191538791; 
 Thu, 25 Jan 2024 06:05:38 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a170902ead200b001d705836d0dsm11925699pld.200.2024.01.25.06.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:05:37 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 2/3] driver: rng: Fix SMCCC TRNG crash
Date: Thu, 25 Jan 2024 14:05:01 +0000
Message-Id: <20240125140502.22400-3-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125140502.22400-1-o451686892@gmail.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
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

