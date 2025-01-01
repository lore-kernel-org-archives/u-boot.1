Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BDBE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92B080713;
	Wed,  1 Jan 2025 23:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ewH1hZ/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0868070D; Wed,  1 Jan 2025 23:23:03 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1897880379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso136704295ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770179; x=1736374979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LZGvZIAUX76qQrKukHq9Xmdje2ka70lRDPgZ2LwsXA=;
 b=ewH1hZ/kLUW6PSA6RSuJfnWCkdZN6+9jR9g5TFKOyEE0UXV5YIrPe+nsb9mie2K/fz
 FnNdlVvuoeCOWu4pG8Mdth3vms1bqwMG2hVHCYtomE9kxSRKahdg3TNGg8jJv+mNfWNV
 TLoNTsLUeYBFGvbNIaHD9lTuILpV2lsCOdDmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770179; x=1736374979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LZGvZIAUX76qQrKukHq9Xmdje2ka70lRDPgZ2LwsXA=;
 b=Nh1rQlhFgBGGJeBtMArFRzKj+3kue574qRpujJhJFnv+oQZVx9r6Cpa+7Rfls7gADv
 /DzbjZNX+zRImYNaIfw9jof+4uEul1vFLkKIehfLJNg51EUBP/wj5+v1WYGjWBPNBSYU
 0UfL/mQaRFmaOjWpZZIU0FozDz578zKD9ykErOIXv11YKfzq3BB4uO0DEejOctH8VmvO
 QZFaNisdJYR3+BhN348svMTpJwFFKTR3i7pp8ZW37MDr1Q5YHExhJDMog8OAE9UJ3ZM+
 Ssw3U8Ho4HQFdHUH8ezThwkxBOQJzLj37D2iQBpzgaG5QyU2VTQ1lAY90Exf7C7e0ep6
 DUjQ==
X-Gm-Message-State: AOJu0YyL0U3unZ4CKHhp2rJE3BByPMRtX9QyZ3UyEvRZS1ANHKp+0aDZ
 r1vmpehqh7jz7dP8M8HQf4cbxlWT/ffm/aSVRW5/JHhLuJIlAD7h76N3OL9h7AFOgYeqT9XvBA8
 =
X-Gm-Gg: ASbGnctG+8kIe5BZWHmT2w0/c8EAIvdmT/HH9Q8OjHignwhiLoCdko29aT1iFJHnkH+
 C8ybWnyOt2cdd7gizJZtokEHhmowiSWk+L92b3AcKpYjRsHfoosk81cu+mwykkmGnpdzvPNLyGx
 txCzMXQZHjoO8TM+ECn6ldPExRRYHN2wZF/Fee4jI3nCaPGQmlRTPTWLm5ZcIdIBOkynL44CWdT
 2W5Si2TjjROYG4NUtgoJjHuKxmDozjQXFBNqzOB9tFBbwKX8Ji3QCc=
X-Google-Smtp-Source: AGHT+IH8/G1dmdb1kg5YGH57rzO31lL6YrHcxkRXCIgmI04cBHAYdG54Vck+WSdu0d6Cv3qjTVfWTg==
X-Received: by 2002:a05:6a20:8411:b0:1e2:88b:4f1b with SMTP id
 adf61e73a8af0-1e5e081c5a1mr71083914637.39.1735770179132; 
 Wed, 01 Jan 2025 14:22:59 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 56/67] upl: Make use of alist_for_each()
Date: Thu,  2 Jan 2025 11:09:42 +1300
Message-ID: <20250101221003.1944600-57-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This is more convenient than a for() loop, so update upl_write to use
this new feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 4b4232af6e5..ec1f5daac92 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -255,9 +255,10 @@ static int add_upl_params(const struct upl *upl, ofnode options)
  */
 static int add_upl_images(const struct upl *upl, ofnode options)
 {
+	const struct upl_image *img;
 	char name[40];
 	ofnode node;
-	int ret, i;
+	int ret;
 
 	snprintf(name, sizeof(name), UPLN_UPL_IMAGES "@%llx", upl->fit.base);
 	ret = ofnode_add_subnode(options, name, &node);
@@ -284,14 +285,12 @@ static int add_upl_images(const struct upl *upl, ofnode options)
 	if (ret)
 		return log_msg_ret("upi", ret);
 
-	for (i = 0; i < upl->image.count; i++) {
-		const struct upl_image *img;
+	alist_for_each(img, &upl->image) {
 		char buf[sizeof(u64) * 4];
 		ofnode subnode;
 		char name[30];
 		int len;
 
-		img = alist_get(&upl->image, i, struct upl_image);
 		snprintf(name, sizeof(name), UPLN_IMAGE "@%llx", img->reg.base);
 		ret = ofnode_add_subnode(node, name, &subnode);
 		if (ret)
@@ -371,11 +370,9 @@ static int write_mem_node(const struct upl *upl, ofnode parent,
  */
 static int add_upl_memory(const struct upl *upl, ofnode root)
 {
-	int i;
+	const struct upl_mem *mem;
 
-	for (i = 0; i < upl->mem.count; i++) {
-		const struct upl_mem *mem = alist_get(&upl->mem, i,
-						      struct upl_mem);
+	alist_for_each(mem, &upl->mem) {
 		ofnode node;
 		int ret;
 
@@ -403,8 +400,9 @@ static int add_upl_memory(const struct upl *upl, ofnode root)
  */
 static int add_upl_memmap(const struct upl *upl, ofnode root)
 {
+	const struct upl_memmap *memmap;
 	ofnode mem_node;
-	int i, ret;
+	int ret;
 
 	if (!upl->memmap.count)
 		return 0;
@@ -412,9 +410,7 @@ static int add_upl_memmap(const struct upl *upl, ofnode root)
 	if (ret)
 		return log_msg_ret("img", ret);
 
-	for (i = 0; i < upl->memmap.count; i++) {
-		const struct upl_memmap *memmap = alist_get(&upl->memmap, i,
-							struct upl_memmap);
+	alist_for_each(memmap, &upl->memmap) {
 		ofnode node;
 
 		ret = write_mem_node(upl, mem_node, &memmap->region,
@@ -443,8 +439,9 @@ static int add_upl_memmap(const struct upl *upl, ofnode root)
 static int add_upl_memres(const struct upl *upl, ofnode root,
 			  bool skip_existing)
 {
+	const struct upl_memres *memres;
 	ofnode mem_node;
-	int i, ret;
+	int ret;
 
 	if (!upl->memres.count)
 		return 0;
@@ -458,9 +455,7 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 	if (ret)
 		return log_msg_ret("im2", ret);
 
-	for (i = 0; i < upl->memres.count; i++) {
-		const struct upl_memres *memres = alist_get(&upl->memres, i,
-							struct upl_memres);
+	alist_for_each(memres, &upl->memres) {
 		ofnode node;
 
 		ret = write_mem_node(upl, mem_node, &memres->region,
-- 
2.43.0

