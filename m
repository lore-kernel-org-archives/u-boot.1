Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1CFE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F6E80488;
	Wed,  1 Jan 2025 23:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WGkbN3/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D660180317; Wed,  1 Jan 2025 23:13:08 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE45980606
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so154416135ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769583; x=1736374383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEYX+eAc1f1ic6XHOW0lqC2+yCfKmuif6T7etbgdE48=;
 b=WGkbN3/8jdLM6HI2HXQdvYzX+5V6J7cM3VaLdKNaRVFrwWEulBd0ZsICBXx7B59NK1
 Pe+lxnSN4eY0mqXBzoeP8HhZEfH0q2yfilwxDFtZvMn/1ciHGRcFqGAz4CM2heE3J4Hl
 h/pPRth/rx+/2PPIUEj4ARtgBLLix9tdqhZMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769583; x=1736374383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEYX+eAc1f1ic6XHOW0lqC2+yCfKmuif6T7etbgdE48=;
 b=TUPAA2FeBOm3kHtZSXiAB1WU3wC7ggILVAyvGFtbGKE7LMf8mpoObuLYt+6LVoA16I
 k7HWM1Apo/hqA8VL8pdb9q5jb/yPuEBWv6h5W/85kOnXAw8eEdoOtbg2jb8fdhItTOYg
 g0+/Y9oS/hsRY0iTAgYtA4DoFboeojeyqk/DcPRu0+cfZb8yUfHLUDY6GjLyG6DxErGx
 i4NOlvyWAQhF0HKAMFIxCTTrHsv3V0wXITeFPY5YY99cMzqnWfGkuPCxtas0ZlF0J3Sq
 kkjEMaH71wCWZgtQUgZPqkBksh4E8ZhTmaAv2G8R4HCbfxV8t13hgs0+CPdiM6NKY0qV
 ZgRw==
X-Gm-Message-State: AOJu0YxpbRvcDQ2Sx7AaFkhmo/v3/Ap7XhedxAnWwQ2asmttBx+L2ySy
 ympr7u9hYcEAH/Zgnv6kO2s2+WkpWz33CxcdUGpzq8SHYHCnA0lJ0fRkXOTRdMad9RsydkSsr3g
 =
X-Gm-Gg: ASbGncu2ukMnU3M4cr4iRoQUVpdt+LRaunu0tUb3Q+4p1PO7s38mHwYaJW+fv0W92MT
 xPEEPOC9klaky3eQBPwU1rqYz1a84gqXrskjeIo3Uzj1DED7uRFmZY8kUas0gTLqs+IJaX1tijB
 IluAuuYE0XcL6RprB4MRibkX8UFTlpzc6ZvDwPmf+NB7kKV3HMeoH0uOfxmsY237xSNWNNqzJB4
 cuIIyfvcU3cAA2r8uUqtZ8EmZc/gGKGMU3NV9SVJmPwNCkxwubdULw=
X-Google-Smtp-Source: AGHT+IFHEGXkcZT1qswFrA54YbGY2OGqX1WQA1pzeV5mnrcIHhLDQyb6Y0XJV4JBVOaQe/UPYkC8og==
X-Received: by 2002:a05:6a00:6103:b0:72a:b292:1e96 with SMTP id
 d2e1a72fcca58-72ab2921ec7mr72647522b3a.12.1735769582966; 
 Wed, 01 Jan 2025 14:13:02 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/67] upl: Update add_upl_memres() to use write_mem_node()
Date: Thu,  2 Jan 2025 11:09:10 +1300
Message-ID: <20250101221003.1944600-25-sjg@chromium.org>
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

Use this new helper function to simplify add_upl_memmap()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 3f38d533c4a..25ec6992573 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -425,26 +425,14 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 	for (i = 0; i < upl->memres.count; i++) {
 		const struct upl_memres *memres = alist_get(&upl->memres, i,
 							struct upl_memres);
-		char buf[memres->region.count * sizeof(64) * 2];
-		const struct memregion *first;
-		char name[26];
-		int ret, len;
 		ofnode node;
 
-		if (!memres->region.count) {
-			log_debug("Memory %d has no regions\n", i);
-			return log_msg_ret("reg", -EINVAL);
-		}
-		first = alist_get(&memres->region, 0, struct memregion);
-		sprintf(name, "%s@0x%lx", memres->name, first->base);
-		ret = ofnode_add_subnode(mem_node, name, &node);
+		ret = write_mem_node(upl, mem_node, &memres->region,
+				     memres->name, &node);
 		if (ret)
-			return log_msg_ret("memres", ret);
+			return log_msg_ret("umr", ret);
 
-		len = buffer_addr_size(upl, buf, sizeof(buf),
-				       memres->region.count, &memres->region);
-		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
-		if (!ret && memres->no_map)
+		if (memres->no_map)
 			ret = ofnode_write_bool(node, UPLP_NO_MAP,
 						memres->no_map);
 		if (ret)
-- 
2.43.0

