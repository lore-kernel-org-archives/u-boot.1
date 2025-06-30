Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB5CC8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5694F82E35;
	Mon, 30 Jun 2025 12:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D4l9Otfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB7482EA2; Mon, 30 Jun 2025 12:23:54 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FFA82E35
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so1170958f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751279022; x=1751883822; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0yH8hq4r1OsZy9cdS4BVtAAJQpTz8ifZUZ5tk/omoc=;
 b=D4l9Otfg9iWJ98Y2aEJp8Dm59LivrnA8sMjO7dR0NstTk34kd3XmBySbEX554fq5Zu
 6W9C0HN9dF9Ap2OsnJ93F3MM7uIinW99LMgx3uV06tnsZjN21RhscJQO3gw7ous1KHsr
 go2mtx28kmsoxORCFaCdimNy1JG8YWd1gMHC88k3cI198QR1TF8FMm5eSmgAJccdPXiU
 3J13ptZ8V8+E3zrYdsD0QttSbknbJmfZBz/96e2scH9tAaoznt1/eNAFqDTDRvP7J7cQ
 X07R9CR1ZDNEgSf4SIeY2VVASxZq3y4UcERvRHxSBZSLEiKCxETPg4FWi6lC92GBnwd1
 O32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279022; x=1751883822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0yH8hq4r1OsZy9cdS4BVtAAJQpTz8ifZUZ5tk/omoc=;
 b=iMYzE1YdAl9y4rn7gJV/VjrhTTJNSUXLewgMWe2JCtkpmMyjDqxfKOME45RO8Jdq9Q
 hVdGth9D/1gmxrwyUu2Cpd1nudZ/rNiAmvFHepC0wpDA6ZAHD5NyOt39Wr31/7oJXCiA
 CMccK4pTpjasToQYioU+H1O5Syw1++snsYDt99EMlnLrjO3KO7niXSHe5zBkqBgOdySH
 l0Lr5414gxEv7CGhfgzqoXwZC61FcrhEYOtd9fThHtw2RhViK8xvKUeu/rCiOaWvB6h0
 Yq08A7AehBqua5/SlQhXnYnT+BgAfHEpZlbF/wUfaWVXJNLemHC6X2t8GUFXDrZKxZ4v
 D+Mw==
X-Gm-Message-State: AOJu0YzdsPl1Yf+5vNTR2AoAyL4hk/1ll1TxJUJ3aGr4/f07XNCLDv7b
 VCgwoltz5DmJolI2CqCGfAyPq9m3HL1uD1OMUXp7Vpn2e1RXDE0Bs/nBsjrnTL86UPA=
X-Gm-Gg: ASbGncuWqV0oyhnWLZ19zCmC0gkvrDo2vblLGuiG5oUJvJu72Irf2s2Im87NRm4GpRN
 sKFCA6IqPmE6zK/fGEqnOt4XGBVhY9+iSHriN587lMZ2VJ4yT32SZrBzZGkNaDDTk/i9yxcAPn1
 3xdu61gxXHAXMVKEnnbrwIkPRB9K3q9ffV9oo5CLvDNL5xIYHRwz/e+ip06NNvWyv+PDJCkONW4
 9f/FqHMI1XdO7FNHZnW6WDRJJcOFG6lqwR7QpVZz5CII7TV/51PdpvL5/QSE1LpjR3+6berBzYg
 cVMvP/D6I/9n2bExLJtzY4IBvbMQTkC9mU40j09K6UxkF4Sh8ZSwYekjkprAkEzPv5PR4P6Y8uk
 lklxhqRdHKhbSW1c=
X-Google-Smtp-Source: AGHT+IFR50CdP3oUpmMfnPhdIy7veFcKJZYG2Moh1QQ4g/sE30/j31gDk0RseHFWhvS7fI2mqE2DgA==
X-Received: by 2002:a05:6000:2a81:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3a8fec79a1dmr9322935f8f.45.1751279022194; 
 Mon, 30 Jun 2025 03:23:42 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm10114085f8f.54.2025.06.30.03.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:23:41 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 30 Jun 2025 11:23:40 +0100
Subject: [PATCH v3 2/2] tpm: Make use of TPM2_ALG_INVAL from enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-tpm_enum-v3-2-9ef117f6a7e4@linaro.org>
References: <20250625-tpm_enum-v3-0-9ef117f6a7e4@linaro.org>
In-Reply-To: <20250625-tpm_enum-v3-0-9ef117f6a7e4@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>
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

Now that the enum includes TPM2_ALG_INVAL, use that name in the
code.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/tpm-v2.c | 6 +++---
 lib/tpm-v2.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index a62862e94f9..346e21d27bb 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -113,7 +113,7 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 	if (argc == 4) {
 		algo = tpm2_name_to_algorithm(argv[3]);
-		if (algo < 0)
+		if (algo == TPM2_ALG_INVAL)
 			return CMD_RET_FAILURE;
 	}
 	algo_len = tpm2_algorithm_to_len(algo);
@@ -157,7 +157,7 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 	if (argc == 4) {
 		algo = tpm2_name_to_algorithm(argv[3]);
-		if (algo < 0)
+		if (algo == TPM2_ALG_INVAL)
 			return CMD_RET_FAILURE;
 	}
 	algo_len = tpm2_algorithm_to_len(algo);
@@ -288,7 +288,7 @@ static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 
 	algo = tpm2_name_to_algorithm(argv[1]);
-	if (algo == -EINVAL)
+	if (algo == TPM2_ALG_INVAL)
 		return CMD_RET_USAGE;
 
 	ret = get_tpm(&dev);
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 9ca7933c094..5b21c57ae42 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -1141,7 +1141,7 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
 	}
 	printf("%s: unsupported algorithm %s\n", __func__, name);
 
-	return -EINVAL;
+	return TPM2_ALG_INVAL;
 }
 
 const char *tpm2_algorithm_name(enum tpm2_algorithms algo)

-- 
2.39.5

