Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA24CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83036882B0;
	Sun, 31 Mar 2024 23:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H8GKdBHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5568587C82; Sun, 31 Mar 2024 22:03:39 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6639D87F74
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d6ff0422a2so49190961fa.2
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915417; x=1712520217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEbE/13KyoJaJ/y0cMWxB2voFqYX1/3jewfTlMW2E5Y=;
 b=H8GKdBHcRYmy/N2GYThFcIZuOt4B52ze5tpypZFFm5Cyt8YHiernEP1KUllWhmE/jn
 XGdc4SyW+9mwmMLpiJHUG9+twNNIF3POYrPkuxWWwfEY3HOOJdHCGhaDQd2m7QsscxW4
 3RwzOO8qDYGq6YYvZd1Rao6v15dMJqzy6+SDiNx8BT+G8rFx/ejNAZlXBlw0HvExkulp
 ZXUmYk3QLqavNBp5p8X8yHUrGpId7K3VFT1qjjXdXIMfN8bUPloEKZd1s9+dHMaK6RH6
 qX9tXFTSTGSy0mx53WtlzaDEHFekR6HjQJBXZaLE+Xwqd2qO8rLkjVQDYb+/Imfpz7Oc
 iJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915417; x=1712520217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEbE/13KyoJaJ/y0cMWxB2voFqYX1/3jewfTlMW2E5Y=;
 b=FHKLGgWzO33W2qKE1d2AUQX7yIP6FE2LtyowEuXPP82Phxc+koIGEebteHT8l0HoQ8
 +c8MGQSE/DwDXEkrTcxq+MDILYevZ0DvX/SAOeCXtyRuSoX93J2jBfKOLXB+niNA92yJ
 vRLQg34t2KnABCFNwm6pSQFl7s3ghraIkUbtntyIcyKvc7JB8Qfblubo+iWSq0QIfesW
 4srM4PwnN8Sf9j+3KCaHQNwKY9hQCyekK1yaIIp3eGUXdJ+rn5ywV+MIs77UtvgElRQP
 KpbtQM7zzHKKuUPd6itX54MRszan6RcW7WipvcOWx7itAnCkJ3Mn/PsgaS/Six0Kvsu2
 CbBg==
X-Gm-Message-State: AOJu0Yyttwrzr3ciG/h5bdR6w5fL0pxYBSKpAadJF+JW6jvJuMG8ggwE
 s3nG2WK1YIPsuI42eqa7uCnR9Anci66Ul/SHOMi2epLwlgc7o1AG
X-Google-Smtp-Source: AGHT+IFfq/Waisn/BjCT64FeoOnAF0nhcKKvbQHAslPduFlhgWCoJOLh+YfY0Iy42z7nQNI9Yx1lgA==
X-Received: by 2002:ac2:5f1a:0:b0:513:a05d:7e9a with SMTP id
 26-20020ac25f1a000000b00513a05d7e9amr4577840lfq.45.1711915416482; 
 Sun, 31 Mar 2024 13:03:36 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:35 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 5/9] mcheck: support memalign
Date: Sun, 31 Mar 2024 23:03:23 +0300
Message-Id: <20240331200327.29141-6-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/dlmalloc.c        |  7 ++++++-
 common/mcheck_core.inc.h | 20 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 8de15d7193..73c04af2a3 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -2265,7 +2265,12 @@ Void_t *rEALLOc(Void_t *oldmem, size_t bytes)
 
 Void_t *mEMALIGn(size_t alignment, size_t bytes)
 {
-	return NULL;
+	size_t fullsz = mcheck_memalign_prehook(alignment, bytes);
+	void *p = mEMALIGn_impl(alignment, fullsz);
+
+	if (!p)
+		return p;
+	return mcheck_memalign_posthook(alignment, p, bytes);
 }
 
 // pvALLOc, vALLOc - redirect to mEMALIGn, defined here, so they need no wrapping.
diff --git a/common/mcheck_core.inc.h b/common/mcheck_core.inc.h
index 6f26ef00d9..b038bb0539 100644
--- a/common/mcheck_core.inc.h
+++ b/common/mcheck_core.inc.h
@@ -69,6 +69,7 @@ typedef struct {
 } mcheck_canary;
 struct mcheck_hdr {
 	size_t size; /* Exact size requested by user.  */
+	size_t aln_skip; /* Ignored bytes, before the mcheck_hdr, to fulfill alignment */
 	mcheck_canary canary; /* Magic number to check header integrity.  */
 };
 
@@ -104,6 +105,7 @@ static inline size_t allign_size_up(size_t sz, size_t grain)
 }
 
 #define mcheck_allign_customer_size(SZ) allign_size_up(SZ, sizeof(mcheck_elem))
+#define mcheck_evaluate_memalign_prefix_size(ALIGN) allign_size_up(sizeof(struct mcheck_hdr), ALIGN)
 
 static enum mcheck_status mcheck_OnNok(enum mcheck_status status)
 {
@@ -156,7 +158,8 @@ static void *mcheck_free_helper(void *ptr, int clean_content)
 
 	if (clean_content)
 		mcheck_flood(ptr, FREEFLOOD, mcheck_allign_customer_size(hdr->size));
-	return hdr;
+
+	return (char *)hdr - hdr->aln_skip;
 }
 
 static void *mcheck_free_prehook(void *ptr) { return mcheck_free_helper(ptr, CLEAN_CONTENT); }
@@ -171,10 +174,13 @@ static size_t mcheck_alloc_prehook(size_t sz)
 static void *mcheck_allocated_helper(void *altoghether_ptr, size_t customer_sz,
 				     size_t alignment, int clean_content)
 {
-	struct mcheck_hdr *hdr = (struct mcheck_hdr *)altoghether_ptr;
+	const size_t slop = alignment ?
+		mcheck_evaluate_memalign_prefix_size(alignment) - sizeof(struct mcheck_hdr) : 0;
+	struct mcheck_hdr *hdr = (struct mcheck_hdr *)((char *)altoghether_ptr + slop);
 	int i;
 
 	hdr->size = customer_sz;
+	hdr->aln_skip = slop;
 	for (i = 0; i < CANARY_DEPTH; ++i)
 		hdr->canary.elems[i] = MAGICWORD;
 
@@ -204,6 +210,16 @@ static void *mcheck_alloc_noclean_posthook(void *altoghether_ptr, size_t custome
 	return mcheck_allocated_helper(altoghether_ptr, customer_sz, ANY_ALIGNMENT, KEEP_CONTENT);
 }
 
+static size_t mcheck_memalign_prehook(size_t alig, size_t sz)
+{
+	return mcheck_evaluate_memalign_prefix_size(alig) + sz + sizeof(mcheck_canary);
+}
+
+static void *mcheck_memalign_posthook(size_t alignment, void *altoghether_ptr, size_t customer_sz)
+{
+	return mcheck_allocated_helper(altoghether_ptr, customer_sz, alignment, CLEAN_CONTENT);
+}
+
 static enum mcheck_status mcheck_mprobe(void *ptr)
 {
 	struct mcheck_hdr *hdr = &((struct mcheck_hdr *)ptr)[-1];
-- 
2.25.1

