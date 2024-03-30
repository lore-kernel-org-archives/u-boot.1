Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C82CD128E
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 11:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2540587FC1;
	Sat, 30 Mar 2024 12:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZ0YXFjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D9888019; Sat, 30 Mar 2024 12:11:29 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E25587DCC
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d717603aa5so17150341fa.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711797086; x=1712401886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wZ2lnECPWSfbIBOjVFcSoERYmH2nYr8KqYSlyxFT/vs=;
 b=hZ0YXFjpDBuFQNgvA4jEocyOHywYbnaR0M/+QqgCqx/9iatlV/kYpBYjyOh5Lelc+O
 xh9pgccPfcfg6pAci1Mfwugb3exi4pcRz0l54jUjtXREQgr1BY2ZvVC1x40xjVZI8xiR
 yFPhBLO6+Ue461tpEXWGMGwyq16c0EdI7yIPC7u7gDTi9Hx5Z2CFVGrwqN7oS6o0H7PW
 Xgh7IjaaGoYFrTAHIbjjb5GgYbW06kT+YKWf/3u2NbkxDM0rzy0tmp+x1kRP0s1ZkP8z
 4ROJ1E/hRsAosNjwH0lF7O4GaPmQpTkO1agau93wySiMNBtvJ1EetX39XnJin4uNYxJT
 J3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711797086; x=1712401886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZ2lnECPWSfbIBOjVFcSoERYmH2nYr8KqYSlyxFT/vs=;
 b=pv8Fy0oAiSb5QnCha+euHK4HQgPsprFPrUoTzRUEuXTf4h07akD4NIN+5s+UeusS2X
 dowNf2UOlFNM2eAX58tRnSaKdcTSAK0XHTUo+b17vjml01DewytGtAxEwzPmg3dGYEW/
 LgcZK1e15VsMonveL+nXcKuMISmgLLUuJYyg/g3ISmy28paaDC6YduCbqA0GXjkQVsRk
 PlHXuzj1FqsQfrn3/zShOiVgo7821m8pk24mcjYko1zFdkWOLf+5+LyRvzZT7eDUEHDf
 yjMqrWzCy9KGWOwt3SqRcCnvL6e/vlgaDKdXMc8L718KYR9/CC3j5ff/xfw8q+oE+RA9
 ONew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgNFI2+U0HiRKmntIsTwtTR/H0XLGKcb3fMo/o6Eja8zpt4CfI8Kq2v4pxlnXAAhbuhyfssJ4+/6xLXUdlgLZKbZ3J/g==
X-Gm-Message-State: AOJu0YzTHp+SqrlnIQKtYTII+gqgsd5gwCTxL/bHYMuQ11lJJgqcGRo9
 z1EddMwloflw6vJBWZ41LZIbfR6nxKUhtoiganVOxrbbTMKeQri+
X-Google-Smtp-Source: AGHT+IEqNtyDp3T4P0ZDlJmGt9QuQaN5QwyR48JWHpHnn0iiznpwCO6i/T8SE9/9vUcJLD4iQXMDlA==
X-Received: by 2002:ac2:414e:0:b0:512:cc50:c3e0 with SMTP id
 c14-20020ac2414e000000b00512cc50c3e0mr2918411lfi.52.1711797086217; 
 Sat, 30 Mar 2024 04:11:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru.
 [109.252.14.191]) by smtp.gmail.com with ESMTPSA id
 o15-20020a198c0f000000b00515ac340c4asm891922lfd.179.2024.03.30.04.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 04:11:25 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] lib: add missing line breaks in debug messages
Date: Sat, 30 Mar 2024 14:11:21 +0300
Message-Id: <20240330111121.5935-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Add missing line breaks to improve debug log readability.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 lib/rsa/rsa-verify.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 1007b6979a..d3b4f71d6b 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -342,7 +342,7 @@ static int rsa_verify_key(struct image_sign_info *info,
 		return -EINVAL;
 	}
 
-	debug("Checksum algorithm: %s", checksum->name);
+	debug("Checksum algorithm: %s\n", checksum->name);
 
 	/* Sanity check for stack size */
 	if (sig_len > RSA_MAX_SIG_BITS / 8) {
@@ -444,13 +444,13 @@ static int rsa_verify_with_keynode(struct image_sign_info *info,
 	const char *algo;
 
 	if (node < 0) {
-		debug("%s: Skipping invalid node", __func__);
+		debug("%s: Skipping invalid node\n", __func__);
 		return -EBADF;
 	}
 
 	algo = fdt_getprop(blob, node, "algo", NULL);
 	if (strcmp(info->name, algo)) {
-		debug("%s: Wrong algo: have %s, expected %s", __func__,
+		debug("%s: Wrong algo: have %s, expected %s\n", __func__,
 		      info->name, algo);
 		return -EFAULT;
 	}
@@ -470,7 +470,7 @@ static int rsa_verify_with_keynode(struct image_sign_info *info,
 	prop.rr = fdt_getprop(blob, node, "rsa,r-squared", NULL);
 
 	if (!prop.num_bits || !prop.modulus || !prop.rr) {
-		debug("%s: Missing RSA key info", __func__);
+		debug("%s: Missing RSA key info\n", __func__);
 		return -EFAULT;
 	}
 
-- 
2.39.2

