Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7EAE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5215803F0;
	Wed, 11 Dec 2024 19:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dNp8rFg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF27B8023A; Wed, 11 Dec 2024 14:53:45 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CBE801CE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so441755f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733925223; x=1734530023;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WT7pkcdlVNl78BMqhJO2Go5kicUSxt/MPuX7n3EztWA=;
 b=dNp8rFg6gJ6Affaui1JxdloIJTJqrQ6BlzO87vD1pyitf69S/n6AhI0TrdLecw5u85
 yfW/Y4G+QSir5DKFn6v3gduRSVVL3NEB0olbGdjO+rHg4uHwZ7HgUuRf1/cgqCYEehM8
 btuvF/AF2oA++JdK0KnOeWA4bGVd0wBllgxQflVoe7Km7+8QCPwlcJfpyH+2wzb94fGo
 shI9oGZmsJMkSH8IfaZxpBdVHB+69xs1ICFn/A0bWYMxKJvCRS/TXM1ymU8ZRoExcLQQ
 Bnjggwv83h9DI1u3wxs7W5roDctRDthUac8ZZzY1GJnsUqbQK5p9G8dD+SrLnzY2kzYF
 WHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925223; x=1734530023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WT7pkcdlVNl78BMqhJO2Go5kicUSxt/MPuX7n3EztWA=;
 b=S72c0nNmsVEXzWuMiFpypLIcZ/g0thSw9sGXJFxN1SZzYUfj5h8g4qBN4W2hRXQfIc
 mgB5QjDpBwkluX09L4G8aLD/C06tApOOcQbKcXcrfeEnrLY/9Aqb1i2zLW+NqaGYWUFr
 AbdkqTArWEl997PAN66QB4pYoGYC52VGZkfU7MchR41X4RlRV/97yAAj8JBCaicVGYuk
 jOMAtC8yMAif3CpePYfHT5RHqq06SIs+p3/x5Wg+WU5HAwQU8ef6voXZIfMd2EtFlT7c
 yyZReoWVFHuWa52pF/ozZA8PYSDBdHWWGh8TxdSaZWQExsg3CD7y3JCfVda7rg0QmC0R
 OOjQ==
X-Gm-Message-State: AOJu0Yx8H+ovmqYfQHy0/cMme0epFw/BzWHPe9gcS+dofrkTMOjGXHWO
 RlXVXAxYHjmkZrlQ5JwbudNerKYX3oNEfqgjfa5oLNC/rLN8/bM7FPHfz7vZLnE/XHReiWWxSlw
 C
X-Gm-Gg: ASbGnctQMXf+wijGsH/WeTrTHIRJbd0wHwqMfC2MA9JJve0DmOyW115xnvbLuuKJ/TD
 9Q1O+4EYukm0eyVPNAVjymvykyxZapKDhRxBx+8N+5ZzbPmxhF4PgIYuYSBQ/f2j8ECOmYW4Ojb
 4czljP4LpJDh8BJy6DSkjyCzeQAhrewX5BFNjCvaKYwGwSE0cddLtwDpyXPn2Debu4QBFbBPKAA
 EPFlG6bDnKKi0MOC5vbfA0phEpgBggGJYkyQvSWSE9foOUYq8hDOvg=
X-Google-Smtp-Source: AGHT+IHoHwV2srs0wbMtJlVRHnxsNCQJsfTnwqGO6U+aB1euTalHueScu/pLa/y2ZkbhOscL/dWQBA==
X-Received: by 2002:a5d:47a1:0:b0:386:4570:ee3d with SMTP id
 ffacd0b85a97d-3864dee42c8mr1834851f8f.24.1733925222948; 
 Wed, 11 Dec 2024 05:53:42 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:1b92:49fd:8154:d517])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521845sm1316013f8f.106.2024.12.11.05.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:53:42 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Wed, 11 Dec 2024 14:53:26 +0100
Subject: [PATCH 3/4] boot: android: rework bootargs concatenation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-bootargs-concatenation-v1-3-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733925217; l=1993;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=ecxHS5NoAFpqRdOqL5PhvnwUfI0V8x+8t9yIHLuQyiM=;
 b=/+tyNOoKA48kE9EF9RDxLTLmrPeY/gZK7OqW2DpTRsp41ai/DG59gr6R+1HQZ807yXNP83ao4
 M+cITpLx9V0CJDWreRr20rnfpA8o3apwStbk8J59hn/bk+wx6RRCPYJ
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
X-Mailman-Approved-At: Wed, 11 Dec 2024 19:54:12 +0100
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

Rework the bootargs concatenation allocating more accurately
the length that is needed.
Do not forget an extra byte for the null termination byte as,
in some cases, the allocation was 1 byte short.

Fixes: 86f4695b ("image: Fix Android boot image support")
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 boot/image-android.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 362a5c7435a3a8bcf7b674b96e31069a91a892b5..ed72a5c30424a453c1800bc61edbe8f33b31b341 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -289,7 +289,7 @@ int android_image_get_kernel(const void *hdr,
 	int len = 0;
 	if (*img_data.kcmdline) {
 		printf("Kernel command line: %s\n", img_data.kcmdline);
-		len += strlen(img_data.kcmdline);
+		len += strlen(img_data.kcmdline) + 1; /* Extra space character needed */
 	}
 
 	if (*img_data.kcmdline_extra) {
@@ -299,28 +299,28 @@ int android_image_get_kernel(const void *hdr,
 
 	char *bootargs = env_get("bootargs");
 	if (bootargs)
-		len += strlen(bootargs);
+		len += strlen(bootargs) + 1; /* Extra space character needed */
 
-	char *newbootargs = malloc(len + 2);
+	char *newbootargs = malloc(len + 1); /* +1 for the '\0' */
 	if (!newbootargs) {
 		puts("Error: malloc in android_image_get_kernel failed!\n");
 		return -ENOMEM;
 	}
-	*newbootargs = '\0';
+	*newbootargs = '\0'; /* set to NULL in case no components below are present */
 
 	if (bootargs) {
 		strcpy(newbootargs, bootargs);
 		strcat(newbootargs, " ");
 	}
 
-	if (*img_data.kcmdline)
+	if (*img_data.kcmdline) {
 		strcat(newbootargs, img_data.kcmdline);
-
-	if (*img_data.kcmdline_extra) {
 		strcat(newbootargs, " ");
-		strcat(newbootargs, img_data.kcmdline_extra);
 	}
 
+	if (*img_data.kcmdline_extra)
+		strcat(newbootargs, img_data.kcmdline_extra);
+
 	env_set("bootargs", newbootargs);
 	free(newbootargs);
 

-- 
2.34.1

