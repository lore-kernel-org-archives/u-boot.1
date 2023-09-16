Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36830CD37B7
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 08:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C63862B6;
	Sat, 16 Sep 2023 10:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DJc4RHyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4CD864D7; Sat, 16 Sep 2023 10:23:49 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE3F86290
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 10:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso32650215e9.1
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694852627; x=1695457427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=SZNeA/n5BLBh9MFeKSb7P7kJHnSKo7n+M1NYBCHIGCk=;
 b=DJc4RHyMc4LKDHgwx5eMpg7zRs12TI8MQLDZ1CgeOX17XijhrAmsPd+Et1jcxb6BFs
 Lwii7JRYMpq7fG/yu59FXMuTBTVV4bf6dMHldKRMNtsU4JzWE9KucGYBpky3EXvdSbjx
 uWs6o3JPqw0NEh2gEhoZkmSj6DXfEMxsjCPjvdSk7Pk0MhDgWK/qN5M69268XomWfAKG
 R05dcUNbRwpeUz1VpbZUP1bOSi2fV5uWCvDA7AFNRAkR3S0W3dGE5Y/USSZZG8MLDsPB
 u+5qCfmwdD3U3t09MMtA/NtjLONqOHWKJfKosrxWZtUmgr+nnBD0Ex6OSdaYe3MqWWsR
 tAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694852627; x=1695457427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZNeA/n5BLBh9MFeKSb7P7kJHnSKo7n+M1NYBCHIGCk=;
 b=kLCvfoftCwJ5h8X9JF0mxqLF3Ds5LLfiuUe5G/DMYSmEK2Hqd0AwRS//130AniT+UU
 UFQ6/jaDryLxye6ikIMQZ2LsmoDsjQbQ9vnecCDEWxJFNwsFDCXxrEZMb3d4gGMEhWUI
 ic1H/W9X8tTQZR2NLynzrP8WjNKF3xWMjjxt0zyb3ATxmfBdEy+kAdK3ra881275ZL1E
 rjsgbsE381GIJJJ758ZU8YtdoAaTlfJ7GMmpEvihOsG7w9QF3IMkZz8iVdx+GgmjQ8QZ
 VdIN+QG0QwQeb+XxbKJi1yqUcnaIe/PNU5hznCjgo5uKbQJRfEyuyVjpl8RfbA+VoGRo
 nfgA==
X-Gm-Message-State: AOJu0YyeW15jqSiku9g2/UfYf7O/TltZYgN6i4+kVgOJvD2d6WOcu1JR
 rx1awTvVjA3VScQcvnIM06wkjM2GOCU=
X-Google-Smtp-Source: AGHT+IEWFaXNOhp+MRk1wF6Esl4AGNjcbqXxWwUX8UEh9PfsadaCWtHvrDtvGYichP5q3lgfdmg7qw==
X-Received: by 2002:a05:600c:2299:b0:400:419c:bbde with SMTP id
 25-20020a05600c229900b00400419cbbdemr3620040wmf.18.1694852626962; 
 Sat, 16 Sep 2023 01:23:46 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.172.204])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a1c4b05000000b0040303a9965asm9542507wma.40.2023.09.16.01.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:23:46 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 2/4] image: fit: Improve functions description comments
Date: Sat, 16 Sep 2023 10:23:44 +0200
Message-Id: <20230916082344.583308-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Load and entry addresses are returned in ulong variables, which are
32 or 64 bit depending on architecture. Specify that on failure these
functions do not set memory pointed by load / entry argument: this
detail is relavant for correct functions usage.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 boot/image-fit.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3cc556b727..7e87a513e7 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -869,10 +869,11 @@ static int fit_image_get_address(const void *fit, int noffset, char *name,
  * fit_image_get_load() - get load addr property for given component image node
  * @fit: pointer to the FIT format image header
  * @noffset: component image node offset
- * @load: pointer to the uint32_t, will hold load address
+ * @load: pointer to ulong, will hold load address
  *
  * fit_image_get_load() finds load address property in a given component
  * image node. If the property is found, its value is returned to the caller.
+ * Otherwise, on failure, *load will be left untouched.
  *
  * returns:
  *     0, on success
@@ -887,14 +888,11 @@ int fit_image_get_load(const void *fit, int noffset, ulong *load)
  * fit_image_get_entry() - get entry point address property
  * @fit: pointer to the FIT format image header
  * @noffset: component image node offset
- * @entry: pointer to the uint32_t, will hold entry point address
- *
- * This gets the entry point address property for a given component image
- * node.
+ * @entry: pointer to ulong, will hold entry point address
  *
  * fit_image_get_entry() finds entry point address property in a given
- * component image node.  If the property is found, its value is returned
- * to the caller.
+ * component image node. If the property is found, its value is returned
+ * to the caller. Otherwise, on failure, *entry will be left untouched.
  *
  * returns:
  *     0, on success
-- 
2.34.1

