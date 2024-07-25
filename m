Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDDCC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9530087876;
	Thu, 25 Jul 2024 15:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KajGlmkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EEE88100; Thu, 25 Jul 2024 15:58:48 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98C488005
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso5165139f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915924; x=1722520724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jA8VuDCpru8Rx5PCfnkHZeIZFni9PnGGtPIg+SsUSWQ=;
 b=KajGlmkEfhcYtUAkJWcBnVsR/5fbgvJQapTndCgah/4awS4if8MW3jRQ6FEWzBl5xt
 3ppfHmwrd/xXNzrm/jMoryhSvkJGc4t7fUgRgpjO2Ld55mQrYPJik9bIkKXrGij3Weap
 xCu70RXunv6+QQe1x9pPnfa6C2V3yHKNM+3nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915924; x=1722520724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jA8VuDCpru8Rx5PCfnkHZeIZFni9PnGGtPIg+SsUSWQ=;
 b=DBAqgNzSh5pqQprIu8CdrPPZAdaUU/RNaYQS9vyOg0r660iRPnCxCJxVZGnCOMABAz
 O351Y30EFnbUAgJruN4vx5n4BNGgJ+v/YE3FhkFde69I4ZV2ziOiYNl7NSehfOXyaNAe
 aOyP7RBeyW3HU8rrJTyJ/B7gV3Qx2fWwafb1TltN9eX07eKk9DGx3ba/ezDo39mLNTK+
 t5H77RtysUs93envquZGpTe5vM5P5fIq4XueG6gZ7WBYRxoVEyJ4PWcyUtIVNorOafZC
 g2ktA1P9IDoaegi0N7LmaOYOfljAqBdEcQl0lixRG0wr/kU9PrCh4NWCUfypFW8zDfQM
 xZOQ==
X-Gm-Message-State: AOJu0YzsDm5qCVXmdP4VqqtGXnUWslm/k6l7XXQZtAyNLxIAs48+kfcO
 vhGANy5cV1qzt0lM3Ff8lsO6GiSKDGrrsCjc12lg/2dnkGivSdTifjC/rXJmTg+atuuJX47E9kk
 =
X-Google-Smtp-Source: AGHT+IHt/5oY8VW2oyYREaKAH9DlMoxXn5rpSMhr2BdzxeON8Uh7myrPicngOh/MftDOJhKs5SPmeQ==
X-Received: by 2002:a05:6e02:1547:b0:375:bb80:d78e with SMTP id
 e9e14a558f8ab-39a21932a78mr23899165ab.6.1721915924056; 
 Thu, 25 Jul 2024 06:58:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 2/6] efi: Convert device_path allocation to use malloc()
Date: Thu, 25 Jul 2024 07:56:25 -0600
Message-Id: <20240725135629.3505072-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
References: <20240725135629.3505072-1-sjg@chromium.org>
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

Currently this calls efi_alloc() which reserves a page for each
allocation and this can overwrite memory that will be used for reading
images.

Switch the code to use malloc(), as with other parts of EFI, such as
efi_add_protocol().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_device_path.c         | 43 ++++++++++++------------
 lib/efi_loader/efi_device_path_to_text.c |  2 +-
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 0f684590f22..47038e8e585 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -262,7 +262,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 	if (!dp)
 		return NULL;
 
-	ndp = efi_alloc(sz);
+	ndp = malloc(sz);
 	if (!ndp)
 		return NULL;
 	memcpy(ndp, dp, sz);
@@ -315,7 +315,7 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 			end_size = 2 * sizeof(END);
 		else
 			end_size = sizeof(END);
-		p = efi_alloc(sz1 + sz2 + end_size);
+		p = malloc(sz1 + sz2 + end_size);
 		if (!p)
 			return NULL;
 		ret = p;
@@ -347,7 +347,7 @@ struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
 		ret = efi_dp_dup(dp);
 	} else if (!dp) {
 		size_t sz = node->length;
-		void *p = efi_alloc(sz + sizeof(END));
+		void *p = malloc(sz + sizeof(END));
 		if (!p)
 			return NULL;
 		memcpy(p, node, sz);
@@ -356,7 +356,7 @@ struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
 	} else {
 		/* both dp and node are non-null */
 		size_t sz = efi_dp_size(dp);
-		void *p = efi_alloc(sz + node->length + sizeof(END));
+		void *p = malloc(sz + node->length + sizeof(END));
 		if (!p)
 			return NULL;
 		memcpy(p, dp, sz);
@@ -377,7 +377,7 @@ struct efi_device_path *efi_dp_create_device_node(const u8 type,
 	if (length < sizeof(struct efi_device_path))
 		return NULL;
 
-	ret = efi_alloc(length);
+	ret = malloc(length);
 	if (!ret)
 		return ret;
 	ret->type = type;
@@ -399,7 +399,7 @@ struct efi_device_path *efi_dp_append_instance(
 		return efi_dp_dup(dpi);
 	sz = efi_dp_size(dp);
 	szi = efi_dp_instance_size(dpi);
-	p = efi_alloc(sz + szi + 2 * sizeof(END));
+	p = malloc(sz + szi + 2 * sizeof(END));
 	if (!p)
 		return NULL;
 	ret = p;
@@ -424,7 +424,7 @@ struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path **dp,
 	if (!dp || !*dp)
 		return NULL;
 	sz = efi_dp_instance_size(*dp);
-	p = efi_alloc(sz + sizeof(END));
+	p = malloc(sz + sizeof(END));
 	if (!p)
 		return NULL;
 	memcpy(p, *dp, sz + sizeof(END));
@@ -825,11 +825,11 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part)
 {
 	void *buf, *start;
 
-	start = buf = efi_alloc(dp_part_size(desc, part) + sizeof(END));
-	if (!buf)
+	start = malloc(dp_part_size(desc, part) + sizeof(END));
+	if (!start)
 		return NULL;
 
-	buf = dp_part_fill(buf, desc, part);
+	buf = dp_part_fill(start, desc, part);
 
 	*((struct efi_device_path *)buf) = END;
 
@@ -852,7 +852,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part)
 		dpsize = sizeof(struct efi_device_path_cdrom_path);
 	else
 		dpsize = sizeof(struct efi_device_path_hard_drive_path);
-	buf = efi_alloc(dpsize);
+	buf = malloc(dpsize);
 
 	if (buf)
 		dp_part_node(buf, desc, part);
@@ -912,7 +912,7 @@ struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 	if (fpsize > U16_MAX)
 		return NULL;
 
-	buf = efi_alloc(dpsize + fpsize + sizeof(END));
+	buf = malloc(dpsize + fpsize + sizeof(END));
 	if (!buf)
 		return NULL;
 
@@ -940,7 +940,7 @@ struct efi_device_path *efi_dp_from_uart(void)
 	struct efi_device_path_uart *uart;
 	size_t dpsize = dp_size(dm_root()) + sizeof(*uart) + sizeof(END);
 
-	buf = efi_alloc(dpsize);
+	buf = malloc(dpsize);
 	if (!buf)
 		return NULL;
 	pos = dp_fill(buf, dm_root());
@@ -963,11 +963,11 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 
 	dpsize += dp_size(eth_get_dev());
 
-	start = buf = efi_alloc(dpsize + sizeof(END));
-	if (!buf)
+	start = malloc(dpsize + sizeof(END));
+	if (!start)
 		return NULL;
 
-	buf = dp_fill(buf, eth_get_dev());
+	buf = dp_fill(start, eth_get_dev());
 
 	*((struct efi_device_path *)buf) = END;
 
@@ -980,22 +980,21 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t end_address)
 {
 	struct efi_device_path_memory *mdp;
-	void *buf, *start;
+	void *start;
 
-	start = buf = efi_alloc(sizeof(*mdp) + sizeof(END));
-	if (!buf)
+	start = malloc(sizeof(*mdp) + sizeof(END));
+	if (!start)
 		return NULL;
 
-	mdp = buf;
+	mdp = start;
 	mdp->dp.type = DEVICE_PATH_TYPE_HARDWARE_DEVICE;
 	mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
 	mdp->dp.length = sizeof(*mdp);
 	mdp->memory_type = memory_type;
 	mdp->start_address = start_address;
 	mdp->end_address = end_address;
-	buf = &mdp[1];
 
-	*((struct efi_device_path *)buf) = END;
+	*((struct efi_device_path *)&mdp[1]) = END;
 
 	return start;
 }
diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 0c7b30a26e7..4192581ac45 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -33,7 +33,7 @@ static u16 *efi_str_to_u16(char *str)
 	u16 *out, *dst;
 
 	len = sizeof(u16) * (utf8_utf16_strlen(str) + 1);
-	out = efi_alloc(len);
+	out = malloc(len);
 	if (!out)
 		return NULL;
 	dst = out;
-- 
2.34.1

