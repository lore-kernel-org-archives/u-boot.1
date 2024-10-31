Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF1BE68966
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 09:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA198928E;
	Thu, 31 Oct 2024 10:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FUpiZwbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041F789262; Thu, 31 Oct 2024 10:35:39 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E1889291
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joel.stan@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cbb1cf324so6068075ad.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730367334; x=1730972134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=+afli2R0U1OarvTSG/XQ3jnISIV6waxoT9NVG5yU02g=;
 b=FUpiZwbXS3wJiON+WWPsm7ynVTCj5FjtJDqWQj3G53SHPn4FwZq/3p4Y48WV2midUu
 DebgK1akcz/bY1qhDl61COKeKzEyDVIpyrSPbUxcPKDaop5cMUMprLsfQkTkjdTzQ3RB
 E7KEN1/52/7X+HQVtF/HFbdAUWtZyEatjtry9RHS7mzs/lLieOostq7gAyEkGypwCpzV
 TeB7bzudNOR4Rp57ji/IcFyFt4y67/d+PrD3ZlNUyoB9ngKzYddyYwO/V2UnDpEYYjnB
 bOg+FBLSRIyS383S8wdWbBsSJef/TGK6HVIaVMsCt5B55MYSOsqNVKl0XQnYQNnKm4IJ
 AhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730367334; x=1730972134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+afli2R0U1OarvTSG/XQ3jnISIV6waxoT9NVG5yU02g=;
 b=dI+3mTYn/Z7e1NmrnadXHywhogw2s/3TLPMopxO3/9+hT6u2Hg1qp1qlqZxAXj39Z9
 M68OMOE73JBtbtEnyCw72Dk7seilRypzpGgmAIzJOoTY2LXWz2ka4E2e+Si4ZQT/laau
 U6xhFM0Wy4zAetK51zxj/Y+BDzXn8QZ9Y9/nEiAlZkdTmNbhe5kyinXkGLdi4IVe3rsj
 5qzbWqczK1dO6mTBf+9uca7YBLkDJWWp0oZS7WFp+IeBNxd3H807sdDzLmTdmg+IXC7M
 9Qq7TQsklkh8F6SirmdkYiNm9f5PqmRO2Ya7v22LS0XJKSd0J8ikFiRR/pO74YTWErw0
 ZbZg==
X-Gm-Message-State: AOJu0Yzds7Ms4VJsLuv+5EMRUSyw2sJEG8+o3svQ08WzmTh1w+oUe5RF
 lzjCajVZtAKjmIv8weI1D/dne37bN6pvBr1XSMmM+zfxnrZaftP8tEwDgw==
X-Google-Smtp-Source: AGHT+IExU3YJPaO6ILA4YAlZhGdFt634xczyZGihZ6b3RVqYfnmD+PvTPXUqvxVw10YPdTs4lPM+8w==
X-Received: by 2002:a17:903:2b03:b0:20c:5e86:9b68 with SMTP id
 d9443c01a7336-210c68a1a99mr285116075ad.4.1730367334170; 
 Thu, 31 Oct 2024 02:35:34 -0700 (PDT)
Received: from prometheus.lan ([45.124.203.18])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057087cfsm6536895ad.87.2024.10.31.02.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 02:35:33 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: u-boot@lists.denx.de
Cc: Massimo Pegorer <massimo.pegorer@vimar.com>
Subject: [RFC PATCH] mkimage: Allow -o to set hash algorithm in auto mode
Date: Thu, 31 Oct 2024 20:05:10 +1030
Message-ID: <20241031093511.148082-1-joel@jms.id.au>
X-Mailer: git-send-email 2.45.2
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

Users would like to be able to create a FIT with hashed images using
using a given algorithm in auto mode. Allow them to use the existing -o
option for this.

In commit b93a65209c4a ("mkimage: fit: Support signed configurations in
'auto' FITs"), the examples lead me to believe this was already the
behavior, however -o only affects auto-conf mode.

The change in this commit does not affect the auto-conf behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
RFC. This is useful in testing that the hash infrastructure is working.
If there's no appetite for changing the mkimage behaviour then I
understand.

---
 tools/fit_image.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 0fccfbb4ebda..b3b0283eca83 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -217,6 +217,12 @@ static void fit_add_hash_or_sign(struct image_tool_params *params, void *fdt,
 	const char *hash_algo = "crc32";
 	bool do_hash = false;
 	bool do_sign = false;
+	char *algo_name = NULL;
+
+	if (params->algo_name) {
+		algo_name = strdup(params->algo_name);
+		hash_algo = strtok(algo_name, ",");
+	}
 
 	switch (params->auto_fit) {
 	case AF_OFF:
@@ -254,6 +260,9 @@ static void fit_add_hash_or_sign(struct image_tool_params *params, void *fdt,
 		fdt_property_string(fdt, FIT_KEY_HINT, params->keyname);
 		fdt_end_node(fdt);
 	}
+
+	if (algo_name)
+		free(algo_name);
 }
 
 /**
-- 
2.45.2

