Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75014C71130
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08BE4831D3;
	Mon,  7 Jul 2025 22:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMDI8XQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4352831C2; Mon,  7 Jul 2025 18:54:08 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC188318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 18:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ld.adecy@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453749af004so16562465e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751907246; x=1752512046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ode0YuFIqPHwUpcPwlFqcplX+H+gCLhL7GUnTQe5KlM=;
 b=JMDI8XQk56WeobSJmdyxl1RyO97OgadvheOsjecz+xalUBE1DMbpRydUq6smU4fNG9
 O0JtmmQP0mam2lW0smYK1pMeCrCmORNasrsLrSG4aamx7ICPxv3S1BbOQgppLpqQjpgc
 xL0pQoy1ONFmDpoAWrTKvvxi6Hrw4dSUbxAnwZ6275YIUSS3YIFxV7+l3lz63Tls8P02
 M3m8jhSkrRFoGrSPXymQbh1MIz+r5PNu3bbDzQUbHTa+DhsMDKnM+qYxCJoOI0a73GOB
 WdN0WUgot+rgJoHrLW2WL5Kdna3kbW2JVTUEDAj8oUBq2nCm58HZHeKxU6EEkFFKEN0d
 cAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751907246; x=1752512046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ode0YuFIqPHwUpcPwlFqcplX+H+gCLhL7GUnTQe5KlM=;
 b=fXX+M1xZnR5oA89pl/wgv9AMeamegNqmCqIOdtqnmcBWQ6/DArqRxPsG20WAKv9/E/
 Cc4aP/jPRDBzFz4PEjS7cO8FomZtNxpmXq8dGD5/PfZjpo0IaKYLfVmPPDi+NkacjYCW
 YKPy6IXBd9CHN0pa0TpjMeGDfTE/hn+cQxeTq3MEoBMIUOq3pRPibAxijB7LP9t8A/Py
 ESkcGO9pfP543kKiX0upWYzY+RmRwvBJnAizkADz4FWsvz72n35QilvP5EWrYk+dt0jP
 DPazgJ8H1YzUUXsbaGbzyVfVbGMrF/pdk8ZHXlBnBP8sAK0285uBbCFXEqVvwDPrdP7q
 9qgA==
X-Gm-Message-State: AOJu0YzgVXqNR6bgkqjYA1/pHlqYcRgruhzOghPgssHQSDCWWC7cwAsI
 I20bcLbL/nfOd2oYm1ScQj+RKsfibrLGMlFDVTlbVyjQwhnFxMEPAbtH8L2nVa1t
X-Gm-Gg: ASbGncsy5znE3wmJwQzNafIRJkFeui5ZYzNVjX1Fpy2GKVjSfqCW20ZFoESulvRyFsi
 PQnu7UwTOpiI24rfVoC6v31uRwmEpVLa5yynRetQ2LIKogkdMn7mGVLe/qAClImyUTIwopIxArr
 jdzMRkBJWcS75h4Wvx6CIA1s8nigYfYcphVM0lk1Fa9eRYTbyGE8aVaOpFVh2EplTRl4tWhsVAJ
 GkmK1AphGoG1bsMRl6e4mqxeDtCmZ5jRuqn0pqXFtYq+KC3MA4CalXm0Jv+wm5RIH+Sa85XMsg3
 t8sNnO/jhBYmTnrjcQP2Ltw9EmQwptBvg8eEP2sqakvNQ5IoppxF/kD/TrPH87FjWl2JOzCxwTl
 mEWPvIgpRFCO+T/GssTU9tHOsBRcnaAuV1rRg5w5MsrIGBEyvsbiHvyWEtWzU
X-Google-Smtp-Source: AGHT+IHw6cl3lkEh37osRtP30fjQeqLZM6KMrMga1461iZ3fkVfZ4NEl2t3ldmuodNSWVDHcv7NOsg==
X-Received: by 2002:a05:600c:6819:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-454ccc5661dmr3171285e9.5.1751907245760; 
 Mon, 07 Jul 2025 09:54:05 -0700 (PDT)
Received: from zgw.local.lan (abordeaux-256-1-90-105.w90-11.abo.wanadoo.fr.
 [90.11.209.105]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969409sm148180395e9.4.2025.07.07.09.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 09:54:05 -0700 (PDT)
From: Lucas Dietrich <ld.adecy@gmail.com>
X-Google-Original-From: Lucas Dietrich <lucas.dietrich.git@proton.me>
To: u-boot@lists.denx.de
Cc: mr.nuke.me@gmail.com,
	Lucas Dietrich <lucas.dietrich.git@proton.me>
Subject: [PATCH] ecdsa: fix segfault in mkimage when "-r" option is not set
Date: Mon,  7 Jul 2025 17:55:50 +0200
Message-Id: <20250707155550.310829-1-lucas.dietrich.git@proton.me>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Jul 2025 22:10:23 +0200
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

Fix a segmentation fault in the ECDSA signing logic of `mkimage`
that occurs when the "-r" option is not specified.

This reproduces the logic in `lib/rsa/rsa-sign.c` by checking if
`info->require_keys` is non-null before passing it to
`fdt_setprop_string()`.

Signed-off-by: Lucas Dietrich <lucas.dietrich.git@proton.me>
---
 lib/ecdsa/ecdsa-libcrypto.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index f0095e9dbcf..f48df2b870f 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -345,10 +345,12 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	if (ret < 0)
 		return ret;
 
-	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
-				 info->require_keys);
-	if (ret < 0)
-		return ret;
+	if (info->require_keys) {
+		ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
+					 info->require_keys);
+		if (ret < 0)
+			return ret;
+	}
 
 	return key_node;
 }
-- 
2.39.5

