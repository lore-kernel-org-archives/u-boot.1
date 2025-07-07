Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A40BC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0818304D;
	Mon,  7 Jul 2025 13:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t4+bP8aC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A7C8305C; Mon,  7 Jul 2025 13:24:31 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118CA83046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae3be3eabd8so604625466b.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751887468; x=1752492268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lR6Ayd1IgBqKV+yRyAsWynoLhC88EK7Y8+B7GYl+6ZA=;
 b=t4+bP8aC4Cjy8WKu4oEZtfZa3I5Xxa1a9rhkRswiHKHL53ESQTzghaGvW5+tri46XJ
 3HkVXpAra2lx3Q9ve7Xt+OuzI+7s+9WOzN6xcv7Fa3vsuDvkSDFq8ltbgY93JcQ3E2oV
 HK8O+iptPogAoLmS2Ug8ia1pbmE7pAbKx7ZR+/IQlL2dMBWsBbyhnaQZBMN5qgIwhw3q
 Ab9SNC2MG6FKtGbvAP1URLLlhF1FQDev7hco3KrPKidPgl0xI+3Y53yB7nsoh8kLXSKY
 9LHQa1JSR/C1NTMnK4LFwkuTPvPvs286SVLhLlg8ZYbZTdH/qBV3X/sUcRKcPHypOhNJ
 t0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751887468; x=1752492268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lR6Ayd1IgBqKV+yRyAsWynoLhC88EK7Y8+B7GYl+6ZA=;
 b=HV5h+fysm4pAlAc5rwjxt/qYuKCmM9gkx3CrAf34lCuUqlIo2z2lgyoQwwjCzcPSuw
 t80bS40Rl4OcOptOtFgr8MHmHC1En61EkbQXUsmD7ZQqFWfDD9wFh/AjnlLGaPRBwhxT
 fn8ExmKeBYbi7U6tZg7cBl6KQQO5KTQMrYmA88b7b/kPg6IXybkf0X6eTWg/+9dSu7vE
 W5a2Wqn+23iIlrJhv8w5Xxf4cflSHsGAjAcwSxMQZuZNzKinDoS8cw80ivyglRSQJoWH
 vkr3cDg1yIiav20yXPSiexCaZkG2hLxkhqCVP5fig4sWr9n1fmASsFORNq4baPaXKB66
 W6lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQU8KzUCkJS4ywde+Csfz/yEEHK8Qj5E8pbuyINii8Nj5EB9y6rI1HPJmn0yK3qZzu0UzS3TY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8SqIR7qcKordbRjCoYQUxPROzsZGJqO9zJOSXm3VT/61ePPAe
 Q2mZ0cK8cN8Net7vNIxeonen3ZN9maq+2NTBKF72PYoSSlWjiqpqhaKeDkWIKYbbttI=
X-Gm-Gg: ASbGncsSX6IY2uCrA9UkuNwMg9elCNUlKoAQdf5t1l8U+5RM/jDO6a53p+zkYonmNX0
 r4bNpUcxsDHWsU5nkAMsujxJVKcJO1oAOclJzrbvCpqdr+MYNP+cGZKvbwG5HgSHZ0Ls9eL5IT4
 UdmqIa/Epu1u+tTrnPT1WIFiKOCXy8+Sw8aBx/vFOMZJIf5H1pxHpYzQsE/BxPOWCaeWe+9QIKg
 Vw2YnPQ5Z7bqvLvzprvI+o/vqKP7205w+o2vQy3eRmaMfunX+QuOB46/iUg/AOLNCqeBeOTFkbG
 zjA4pY2YP+49pwRdf4oVgaoj3LnZmgmGmYG/TWcPW4Np2ex40hvk9IrKKaE2Rzmj5nljPoeTbZB
 EFtIaJ0ptecbdqBuQ7tVkrg==
X-Google-Smtp-Source: AGHT+IHHWjqPs//+bCYAkHPytnM5sVrN29+e/IZt/xuE04BtpHXgD59pJnfiNtUTD+9a9sHQOz9uzw==
X-Received: by 2002:a17:907:9711:b0:ad8:adf3:7d6d with SMTP id
 a640c23a62f3a-ae3f9cecbadmr1153756066b.21.1751887468418; 
 Mon, 07 Jul 2025 04:24:28 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f46sm680718966b.5.2025.07.07.04.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 04:24:27 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] tools: bmp_logo: Mark local functions with static
Date: Mon,  7 Jul 2025 14:24:17 +0300
Message-ID: <20250707112419.103724-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

These functions are only used locally. Enabling -Wmissing-prototypes triggers
a warning. Mark them as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/bmp_logo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/bmp_logo.c b/tools/bmp_logo.c
index 74fcadca63e1..40213b7887f9 100644
--- a/tools/bmp_logo.c
+++ b/tools/bmp_logo.c
@@ -15,7 +15,7 @@ typedef struct bitmap_s {		/* bitmap description */
 
 #define DEFAULT_CMAP_SIZE	16	/* size of default color map	*/
 
-void usage(const char *prog)
+static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage: %s [--gen-info|--gen-data|--gen-bmp] file\n",
 		prog);
@@ -24,7 +24,7 @@ void usage(const char *prog)
 /*
  * Neutralize little endians.
  */
-uint16_t le_short(uint16_t x)
+static uint16_t le_short(uint16_t x)
 {
     uint16_t val;
     uint8_t *p = (uint8_t *)(&x);
@@ -35,14 +35,14 @@ uint16_t le_short(uint16_t x)
     return val;
 }
 
-void skip_bytes (FILE *fp, int n)
+static void skip_bytes(FILE *fp, int n)
 {
 	while (n-- > 0)
 		fgetc (fp);
 }
 
 __attribute__ ((__noreturn__))
-int error (char * msg, FILE *fp)
+static int error(char *msg, FILE *fp)
 {
 	fprintf (stderr, "ERROR: %s\n", msg);
 
@@ -51,7 +51,7 @@ int error (char * msg, FILE *fp)
 	exit (EXIT_FAILURE);
 }
 
-void gen_info(bitmap_t *b, uint16_t n_colors)
+static void gen_info(bitmap_t *b, uint16_t n_colors)
 {
 	printf("/*\n"
 		" * Automatically generated by \"tools/bmp_logo\"\n"
-- 
2.43.0

