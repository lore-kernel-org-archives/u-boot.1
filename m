Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58F6C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 12:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C462E83330;
	Thu, 17 Jul 2025 14:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o2u9S5Va";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10C48334F; Thu, 17 Jul 2025 14:05:07 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC9C83323
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 14:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so521086f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752753905; x=1753358705; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=edIOk89F63yw/OG3BYR4Lka7V9EOP5Xv2XumqCpScjU=;
 b=o2u9S5Va884uD4EYddggNG4wIuQAYsoC2746ENKz23YJZWJHYjhThR/Ni1JSwYke88
 p4kZA+THaRQfObTWMAUV1qbi0BETldjGLr5gHDMV7i2WGhlAsySCpbWc4mD6vXPAxsN+
 AuFyiX/803P3Xj2d/kTRE8Rxh5ZcXDJiYEo4kFoBWJiXWtP0fjVSNaOl1du2ckNLtudh
 qIqRV3GGvRxpuuvmjPKu1TF8jGWtTAiSBG+jFoWhRZIeWViiM4hBq2km4v3ZMViOp82c
 GKoFvoYEraqUGr/yZwtYgUupx21+6lU6WvSVGaQmDSYSzZTyzdgQIAohs6RH3Z71+heC
 k9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752753905; x=1753358705;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=edIOk89F63yw/OG3BYR4Lka7V9EOP5Xv2XumqCpScjU=;
 b=lBZl1Dve1GcMUdtub0EU8tkaFolDDIWtD97HprAkNVvhX9Nx7xhuzBIRI3uZP+boHW
 nnpyIwcmgrBlBAYz+yfxE8aJGVyyfHOo/rJfusWtKG7NMi9pe6Q0hT4ONH5/PbgJTSHE
 yapMh+FuHTYmiUJelvYK66EwKqjTc/s5DESgj9pGkLzoQPUpcd9X1SfBr04mgN2W31nf
 QYP9B3H8P8tDHlCjXuebQTBFq7zLyKzfDrYhliLRMOPvngyNmlDRDGo/2LCUOJipTAMn
 Har9OPKDWW8rNK9gnHiUV/dwvl9qMj7A+uwdnmFrpkIKxNkAvO2vh8M/Nid9U3eFP6iz
 CxPA==
X-Gm-Message-State: AOJu0Yzc14f1Ru5+Va6FdvAx21+ZtVVvelzdmfnMPNbsDpJ+iiYVNUVQ
 urJdLVWfMX/LBh+9YrIMNzNQq9aRdyPUersG+GrVHe0wHuSEAZ4oJhvv1jvg3y4cEh8=
X-Gm-Gg: ASbGncuF+q5E1Vxikl0DlrUGYX5puxKYEu2xmfJ1nyX4AttArHn98248PJrVWS/RqEp
 84mHytWpEGbbk6p7s1uHQeJPtHE7MWvMlCmotk3TaeNiG2ijNTD0Gf4dbVrMngeIG/CQUKUXioW
 1iz9G7fKRCfYXfn4mhsWJ43TOalLtSIhdzWRC60wKqPMYT+4nLG9k3TTa6cETWY+Zji4anBdUmv
 ABYeJ7aZ5gROAEzaxdaXR1RE0ShRDqaRlxHosfVWygNTlZ4vBV4SBpyLI1zKA6ntd5Z08oINwhU
 +zzak/GRSWJ+Xann0HzfKVfEimkN8avQQbZRsAZz+EaeSVd49YeaiyAVZRZv8L3G9a8EbE9wjnI
 K43LZusXat/+5RdYng93GyKKQoReZqAl5fJ1YldAAOrhL5GkOi4g=
X-Google-Smtp-Source: AGHT+IHPFvOGVp5a2A7RjMYcA6Pq7P7eWkgXcl43lgLIjH1anFHTxwK6MrslSKRDh17exxRVdZ+GJA==
X-Received: by 2002:a05:6000:21c7:b0:3a4:dc42:a0c3 with SMTP id
 ffacd0b85a97d-3b60dd8f441mr4173906f8f.56.1752753900115; 
 Thu, 17 Jul 2025 05:05:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14e82sm20730510f8f.71.2025.07.17.05.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 05:04:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 17 Jul 2025 13:04:58 +0100
Subject: [PATCH] fs: exfat: Remove unused label code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-exfat_label-v1-1-e15f28fd6c6b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOnmeGgC/x2NUQqDMBAFryL73UBMFalXKaVs7Isu2Fh2pQji3
 Rv7OQzD7GRQgVFf7aT4ismSC9SXioaJ8wgnr8IUfGh9V3cOW+L1OXPE7GJqOPkGHG5XKkVkg4v
 KeZjO5s22Qk/xUSTZ/pv74zh+wUsswnYAAAA=
To: Tom Rini <trini@konsulko.com>
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

Smatch reported a possible buffer overflow in exfat_set_label but it
turns out that this code is unused so just remove the function as well
as exfat_get_label that is also unused and the helper static find_label.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/exfat/exfat.h |  2 --
 fs/exfat/node.c  | 54 ------------------------------------------------------
 2 files changed, 56 deletions(-)

diff --git a/fs/exfat/exfat.h b/fs/exfat/exfat.h
index ca6f22b9d58..19d6a70c48c 100644
--- a/fs/exfat/exfat.h
+++ b/fs/exfat/exfat.h
@@ -237,8 +237,6 @@ int exfat_rename(struct exfat* ef, const char* old_path, const char* new_path);
 void exfat_utimes(struct exfat_node* node, const struct timespec tv[2]);
 void exfat_update_atime(struct exfat_node* node);
 void exfat_update_mtime(struct exfat_node* node);
-const char* exfat_get_label(struct exfat* ef);
-int exfat_set_label(struct exfat* ef, const char* label);
 
 int exfat_soil_super_block(const struct exfat* ef);
 int exfat_mount(struct exfat* ef, const char* spec, const char* options);
diff --git a/fs/exfat/node.c b/fs/exfat/node.c
index 88b1357189c..2e2fae7935f 100644
--- a/fs/exfat/node.c
+++ b/fs/exfat/node.c
@@ -1187,57 +1187,3 @@ void exfat_update_mtime(struct exfat_node* node)
 	node->mtime = time(NULL);
 	node->is_dirty = true;
 }
-
-const char* exfat_get_label(struct exfat* ef)
-{
-	return ef->label;
-}
-
-static int find_label(struct exfat* ef, off_t* offset)
-{
-	struct exfat_entry entry;
-	int rc;
-
-	for (*offset = 0; ; *offset += sizeof(entry))
-	{
-		rc = read_entries(ef, ef->root, &entry, 1, *offset);
-		if (rc != 0)
-			return rc;
-
-		if (entry.type == EXFAT_ENTRY_LABEL)
-			return 0;
-	}
-}
-
-int exfat_set_label(struct exfat* ef, const char* label)
-{
-	le16_t label_utf16[EXFAT_ENAME_MAX + 1];
-	int rc;
-	off_t offset;
-	struct exfat_entry_label entry;
-
-	memset(label_utf16, 0, sizeof(label_utf16));
-	rc = exfat_utf8_to_utf16(label_utf16, label, EXFAT_ENAME_MAX + 1,
-			strlen(label));
-	if (rc != 0)
-		return rc;
-
-	rc = find_label(ef, &offset);
-	if (rc == -ENOENT)
-		rc = find_slot(ef, ef->root, &offset, 1);
-	if (rc != 0)
-		return rc;
-
-	entry.type = EXFAT_ENTRY_LABEL;
-	entry.length = exfat_utf16_length(label_utf16);
-	memcpy(entry.name, label_utf16, sizeof(entry.name));
-	if (entry.length == 0)
-		entry.type ^= EXFAT_ENTRY_VALID;
-
-	rc = write_entries(ef, ef->root, (struct exfat_entry*) &entry, 1, offset);
-	if (rc != 0)
-		return rc;
-
-	strcpy(ef->label, label);
-	return 0;
-}

---
base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
change-id: 20250717-exfat_label-bf4af04ea293

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

