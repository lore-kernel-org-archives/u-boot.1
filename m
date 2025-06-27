Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED857C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97F682F46;
	Fri, 27 Jun 2025 11:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Af9VvPCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5474982F4E; Fri, 27 Jun 2025 11:37:40 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082C182F46
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so11761925e9.3
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751017049; x=1751621849; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VQxNtThQ/+i1BwUPG4tjRBDksd07BiXbMIY7+cxIGiU=;
 b=Af9VvPCuN2tZmA2mtnsLQB0cxagowGjskigGwrSmn6nx+RjXaj3BXqtpbJIClDy5Wy
 IuZrbQIL8LuBM0dLONMTdgBG62uvTXl1hfGCYWHTKHUP3/JRL5hVVCX3lqix8JLHb+6w
 poPIjMEfd/aGbNFHcAmR6jLoX51+i9WcBsl12mmXPz0nOuZm7rv9LCiyDKJOTDYahNxq
 NVi/uVnSYaaAE5XKVZMsrZgi7ILB2aLxfjZqY3n8VSRRF388biU5x2jJRlJfZtXOP1no
 ogjD4eEEpNoC1YXWQ4+Vrf4tt/JbZ4o2Y0J259SEI2MmLXCnEK+nWmEaFbuf/d6o/VaW
 Q9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751017049; x=1751621849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQxNtThQ/+i1BwUPG4tjRBDksd07BiXbMIY7+cxIGiU=;
 b=hKQeIqzB4spZIpiqGA4r7kT4CGx1xIaCEyRGh4ozbWZ9CSZfNuZuUSLEuu2Fogz8J+
 xylq504I/HYY8B/0oXEe4CEpUkBCyOEs5etJXwx8PriIVNXcvaRu+3PGSqF3KZVMP/8H
 xMy+AB71/o5y2ZV944upCm1wNuC85dUuvUlp8OxrPjHrSGzdfYlWY9XLWgbSdQvy7mRA
 5wC2l23Huik6t16+YOzgDf+W55pLXzeiLvjKyBLpMBREgf4Zlv5oYNQL1XfvvLBR4wx5
 yy5ZTSUZcwUE+CMHzrje7qoRZRis20DwFsWe+BEcm0xcrprpju1Tw+u6H7JuCsaARQZ5
 z+sA==
X-Gm-Message-State: AOJu0Yz+WgIF+r51tlr8GiYRUwWYR39ZGsufU2xBEjV5CszHKeg+1Awd
 QOPLAcgcOwd3aKLWq7fDnJTM78HTujnlbEcM6iVd8rSkGThOzaTbMcWg3Ew3nR+reo/wdWH7zvi
 k56UUH+P7tw==
X-Gm-Gg: ASbGnctlBvfjEScw7jc4ATXx6RXqxWeR2mIyaqnVYspV1Fnpy/UUCBIFeMXaJZARCWv
 qsn1Puhru9UA0UCmfoek8LoEmM7lWkf1CFTN8dIqSho2sDdKrUowVZMJ15ASejzBCaUVxn51pYa
 rCy8sdxJddrhtTUISlu3NL/eYSsjQBBt5e+fKlzHwpmZ4C9QIVJcWigW28hocTlDR+gsSk4sL3+
 miWV2i54QwKTIl9BSVdW5C5o6FsfTn4nYoM6GWd6cbJZzzktL3B1kXaHROkbuIkcHT+9zQa/HjD
 bUPsn+8KATqDmpGfkPzoiMya3MXLE7mqnIT5tG5VIYhx0FRKh6HmShZDIii/UYmhiBA/F88lmcW
 8na05G94EiPufULSIPCQmBsgg
X-Google-Smtp-Source: AGHT+IEYiR9VYAjwqKUnHBrT8Ymvjh1TIY/iN+qLPQhGGksOgsS7UbH/cEJKnQM5yHl82TY3JgxQ7g==
X-Received: by 2002:a05:6000:248a:b0:3a4:c9d4:2fb2 with SMTP id
 ffacd0b85a97d-3a8ff149554mr2071877f8f.46.1751017049359; 
 Fri, 27 Jun 2025 02:37:29 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:c61f:677:c14a:b7e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e9d1csm2234958f8f.13.2025.06.27.02.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 02:37:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 27 Jun 2025 10:37:27 +0100
Subject: [PATCH v2 2/2] tpm: Make use of TPM2_ALG_INVAL from enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-tpm_enum-v2-2-ea3f84f6b639@linaro.org>
References: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
In-Reply-To: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
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

