Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F3C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 09:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3874874D9;
	Wed, 13 Dec 2023 10:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIEUUlCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0CE871AA; Wed, 13 Dec 2023 10:23:52 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E43F86D12
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54f4b31494fso10404873a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 01:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702459429; x=1703064229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/iYb+fd1YE9uF6Pe3ERw0fdvuw4VPF3afyK0BMmtnCY=;
 b=SIEUUlCd7+TObsFrXEb/hZhs/Z12WuDqALWXRo4/u2dDORyLNAYkXnBaXbxsR/8E10
 5TjybFbettWnzdjJWxStMfJQNtzK79+4KoE9rx/pl58tR5M83V9l50kbqwZOgAIMU4Ik
 Q9lLWZK4gtKcQI/6o2hWriJdeq4MO5sprV9ePUPMaiukzsUGqZWb11EC7GFsf8FiUFNK
 cTHt2xekvNB55YmKJCHfSXldiY3Jeiq5cm1Odrk6dX6PpBkNjA17NbpsJsw5as8m0lsj
 QrEBUYhtA8h4a4l9zoYUh2NC9dCNJ5Y6MzRfayi6fvqlF3ZzJQU2I1kWNUjoJ4JmfkBU
 BwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702459429; x=1703064229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/iYb+fd1YE9uF6Pe3ERw0fdvuw4VPF3afyK0BMmtnCY=;
 b=em5aeiPtsbhoV4Z/gQjksvFJ5tbRN3yuIFw+ke5iMTmox+zGetvLEpj6R7xSCC+qiI
 Oa/zmHjXOedTzLkXcqHIAwlXdOuZZf4RBVJeW/rX9oRy8axhpITAGrV8NDxm9EA8t/8S
 Yqx66OqbmeKtd0EIiMwXhOdbVH4qTaZX2pqyQ7lbOnsF/rYjFm3pEeVlCuiI1bx6rcuz
 tuF84CkMl7q3wvRS+KBLbJpO1iYTYBl0GxTyZmphTZHYYWzfXYX5Mljn0zR2C0Y4HysR
 yAQKhdXR8pHIFNjhZCt0nTAWbT72heVmXjjY9Fsgap7+e6vvDsrhZYHxD4fQszgUT7xi
 h0RA==
X-Gm-Message-State: AOJu0YzdnUbna9iM4eKLTHNYUMG5K3HH623u3s4SNs7giezmhoudDOBs
 cRaB5VgmeNZ9dAoUngwdvs/xwx42pgM=
X-Google-Smtp-Source: AGHT+IH1Q+crZ+orR7pK2CtMJgTqSD1VWGpfxX3VzohdSVlEKkKYkUkqY0rMy4oDPxoTTD32TWtZ2g==
X-Received: by 2002:a50:f617:0:b0:552:2412:af7a with SMTP id
 c23-20020a50f617000000b005522412af7amr520992edn.15.1702459429195; 
 Wed, 13 Dec 2023 01:23:49 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 cf5-20020a0564020b8500b005521741b8f3sm412201edb.29.2023.12.13.01.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 01:23:48 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] fw_env: rename variables holding env data content
Date: Wed, 13 Dec 2023 10:23:44 +0100
Message-Id: <20231213092344.17024-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Rename "addr0" and "addr1" to "buf0" and "buf1" accordingly. Name "addr"
suggests that variable contains a numeric value being some kind of
address. Name "buf" is de facto a standard name for pointer to allocated
memory for reading data to.

While at it drop redundant checks for NULL before calling free().

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index bf8b7ba304..0347e9d15a 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1416,11 +1416,11 @@ int fw_env_open(struct env_opts *opts)
 {
 	int crc0, crc0_ok;
 	unsigned char flag0;
-	void *addr0 = NULL;
+	void *buf0 = NULL;
 
 	int crc1, crc1_ok;
 	unsigned char flag1;
-	void *addr1 = NULL;
+	void *buf1 = NULL;
 
 	int ret;
 
@@ -1430,8 +1430,8 @@ int fw_env_open(struct env_opts *opts)
 	if (parse_config(opts))	/* should fill envdevices */
 		return -EINVAL;
 
-	addr0 = calloc(1, CUR_ENVSIZE);
-	if (addr0 == NULL) {
+	buf0 = calloc(1, CUR_ENVSIZE);
+	if (buf0 == NULL) {
 		fprintf(stderr,
 			"Not enough memory for environment (%ld bytes)\n",
 			CUR_ENVSIZE);
@@ -1440,13 +1440,13 @@ int fw_env_open(struct env_opts *opts)
 	}
 
 	dev_current = 0;
-	if (flash_io(O_RDONLY, addr0, CUR_ENVSIZE)) {
+	if (flash_io(O_RDONLY, buf0, CUR_ENVSIZE)) {
 		ret = -EIO;
 		goto open_cleanup;
 	}
 
 	if (!have_redund_env) {
-		struct env_image_single *single = addr0;
+		struct env_image_single *single = buf0;
 
 		crc0 = crc32(0, (uint8_t *)single->data, ENV_SIZE);
 		crc0_ok = (crc0 == single->crc);
@@ -1458,12 +1458,12 @@ int fw_env_open(struct env_opts *opts)
 			environment.dirty = 1;
 		}
 
-		environment.image = addr0;
+		environment.image = buf0;
 		environment.crc = &single->crc;
 		environment.flags = NULL;
 		environment.data = single->data;
 	} else {
-		struct env_image_redundant *redundant0 = addr0;
+		struct env_image_redundant *redundant0 = buf0;
 		struct env_image_redundant *redundant1;
 
 		crc0 = crc32(0, (uint8_t *)redundant0->data, ENV_SIZE);
@@ -1472,17 +1472,17 @@ int fw_env_open(struct env_opts *opts)
 		flag0 = redundant0->flags;
 
 		dev_current = 1;
-		addr1 = calloc(1, CUR_ENVSIZE);
-		if (addr1 == NULL) {
+		buf1 = calloc(1, CUR_ENVSIZE);
+		if (buf1 == NULL) {
 			fprintf(stderr,
 				"Not enough memory for environment (%ld bytes)\n",
 				CUR_ENVSIZE);
 			ret = -ENOMEM;
 			goto open_cleanup;
 		}
-		redundant1 = addr1;
+		redundant1 = buf1;
 
-		if (flash_io(O_RDONLY, addr1, CUR_ENVSIZE)) {
+		if (flash_io(O_RDONLY, buf1, CUR_ENVSIZE)) {
 			ret = -EIO;
 			goto open_cleanup;
 		}
@@ -1571,17 +1571,17 @@ int fw_env_open(struct env_opts *opts)
 		 * flags before writing out
 		 */
 		if (dev_current) {
-			environment.image = addr1;
+			environment.image = buf1;
 			environment.crc = &redundant1->crc;
 			environment.flags = &redundant1->flags;
 			environment.data = redundant1->data;
-			free(addr0);
+			free(buf0);
 		} else {
-			environment.image = addr0;
+			environment.image = buf0;
 			environment.crc = &redundant0->crc;
 			environment.flags = &redundant0->flags;
 			environment.data = redundant0->data;
-			free(addr1);
+			free(buf1);
 		}
 #ifdef DEBUG
 		fprintf(stderr, "Selected env in %s\n", DEVNAME(dev_current));
@@ -1590,11 +1590,8 @@ int fw_env_open(struct env_opts *opts)
 	return 0;
 
  open_cleanup:
-	if (addr0)
-		free(addr0);
-
-	if (addr1)
-		free(addr1);
+	free(buf0);
+	free(buf1);
 
 	return ret;
 }
-- 
2.35.3

