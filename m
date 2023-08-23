Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70932EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C41864D7;
	Wed, 23 Aug 2023 15:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cA1aQcdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37988864CA; Wed, 23 Aug 2023 15:42:22 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1168386384
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7923483bb68so93219639f.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798138; x=1693402938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lObI5ZKqIT1tGt4agNhIBVjMBHpgx/oHQalW7JV7QFE=;
 b=cA1aQcdp4GFPNCwbT1InxOL+mTNfprFpLygQk47IhLQtLzDXY5AGZPCUQU/ub6gMDo
 owiRvVlyd/4/eo80Fmz7yeHFgp1JVf3SRj+o29YsDM98ZL3DQKdf7zbgqCMDiCJODS41
 eWxeJkiLhJkDxDuXZ1YStYK4yK1uLC0x+6Bqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798138; x=1693402938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lObI5ZKqIT1tGt4agNhIBVjMBHpgx/oHQalW7JV7QFE=;
 b=cM4+a1kdvQKOp9KWHHi35b5kayi6IAZHkiysC8dI65JkZyIlkX+XXzWBPzKPtz9d2u
 7Guh4cFdb/bxGuhj1m9XOY/sl94NC7eHbj1l87LNuZJDTNs1oSh4ZTBt/TSyoMOXcgF9
 2uOcwgeu9RosD/IN9WOzXgi0xFGO39lo6HDXI+GW10xY2kfJq9Wp9jFCghpnU9e9iGqa
 W386WD1klk4pt0IaWg/hTJkoOeGxdlO2nEwa1czweLjC3H13Lcw39qTA2SGPcAQ9f8Ye
 jyR+JJYNzM4tuOXmrCnkNwtXA3HXrniHp80IXQvXNEB0sx4wMCPbGahGN5uhTKnJZjSm
 fsgQ==
X-Gm-Message-State: AOJu0Yyboe5yCLZhjdDmJkG/TZ4UADYYA1kCVfHROPRGvMuf3UC1LNN7
 T4VT+gqHnHgWICfEP5o5bI1cUSCPPSdLR/QcBVw=
X-Google-Smtp-Source: AGHT+IFzbJJmU6IPeloc1ri7NuDEamyo8IhkcthNi/nr0kq2Vz6rqIYElw9u2gi8RepA/RyWqXiygA==
X-Received: by 2002:a5e:9806:0:b0:790:fab3:2047 with SMTP id
 s6-20020a5e9806000000b00790fab32047mr2948277ioj.4.1692798138671; 
 Wed, 23 Aug 2023 06:42:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 2/7] lmb: Tidy up structure access
Date: Wed, 23 Aug 2023 07:41:58 -0600
Message-ID: <20230823134209.1450567-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823134209.1450567-1-sjg@chromium.org>
References: <20230823134209.1450567-1-sjg@chromium.org>
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

In some cases it helps to define a local variable pointing to the
structure being accessed. This avoids lots of repeated code.

There is no need to individually assign each struct member, so use a
structure assignment instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index ae1969893f00..8b9a611c5216 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -23,20 +23,19 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static void lmb_dump_region(struct lmb_region *rgn, char *name)
 {
-	unsigned long long base, size, end;
-	enum lmb_flags flags;
 	int i;
 
 	printf(" %s.cnt = 0x%lx / max = 0x%lx\n", name, rgn->cnt, rgn->max);
 
 	for (i = 0; i < rgn->cnt; i++) {
-		base = rgn->region[i].base;
-		size = rgn->region[i].size;
-		end = base + size - 1;
-		flags = rgn->region[i].flags;
+		struct lmb_property *prop = &rgn->region[i];
+		unsigned long long end;
+
+		end = prop->base + prop->size - 1;
 
 		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
-		       name, i, base, end, size, flags);
+		       name, i, (unsigned long long)prop->base, end,
+		       (unsigned long long)prop->size, prop->flags);
 	}
 }
 
@@ -89,11 +88,8 @@ static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 {
 	unsigned long i;
 
-	for (i = r; i < rgn->cnt - 1; i++) {
-		rgn->region[i].base = rgn->region[i + 1].base;
-		rgn->region[i].size = rgn->region[i + 1].size;
-		rgn->region[i].flags = rgn->region[i + 1].flags;
-	}
+	for (i = r; i < rgn->cnt - 1; i++)
+		rgn->region[i] = rgn->region[i + 1];
 	rgn->cnt--;
 }
 
@@ -122,6 +118,7 @@ void lmb_init(struct lmb *lmb)
 
 void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
 {
+	struct bd_info *bd = gd->bd;
 	ulong bank_end;
 	int bank;
 
@@ -135,12 +132,10 @@ void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
 	/* adjust sp by 4K to be safe */
 	sp -= align;
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (!gd->bd->bi_dram[bank].size ||
-		    sp < gd->bd->bi_dram[bank].start)
+		if (!bd->bi_dram[bank].size || sp < bd->bi_dram[bank].start)
 			continue;
 		/* Watch out for RAM at end of address space! */
-		bank_end = gd->bd->bi_dram[bank].start +
-			gd->bd->bi_dram[bank].size - 1;
+		bank_end = bd->bi_dram[bank].start + bd->bi_dram[bank].size - 1;
 		if (sp > bank_end)
 			continue;
 		if (bank_end > end)
@@ -244,9 +239,11 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 
 	/* First try and coalesce this LMB with another. */
 	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
-		phys_size_t rgnflags = rgn->region[i].flags;
+		struct lmb_property *prop = &rgn->region[i];
+
+		phys_addr_t rgnbase = prop->base;
+		phys_size_t rgnsize = prop->size;
+		phys_size_t rgnflags = prop->flags;
 		phys_addr_t end = base + size - 1;
 		phys_addr_t rgnend = rgnbase + rgnsize - 1;
 
@@ -262,14 +259,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		if (adjacent > 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].base -= size;
-			rgn->region[i].size += size;
+			prop->base -= size;
+			prop->size += size;
 			coalesced++;
 			break;
 		} else if (adjacent < 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].size += size;
+			prop->size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
@@ -293,9 +290,7 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = rgn->cnt-1; i >= 0; i--) {
 		if (base < rgn->region[i].base) {
-			rgn->region[i + 1].base = rgn->region[i].base;
-			rgn->region[i + 1].size = rgn->region[i].size;
-			rgn->region[i + 1].flags = rgn->region[i].flags;
+			rgn->region[i + 1] = rgn->region[i];
 		} else {
 			rgn->region[i + 1].base = base;
 			rgn->region[i + 1].size = size;
@@ -535,10 +530,11 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
 	int i;
 
 	for (i = 0; i < lmb->reserved.cnt; i++) {
-		phys_addr_t upper = lmb->reserved.region[i].base +
-			lmb->reserved.region[i].size - 1;
-		if ((addr >= lmb->reserved.region[i].base) && (addr <= upper))
-			return (lmb->reserved.region[i].flags & flags) == flags;
+		struct lmb_property *prop = &lmb->reserved.region[i];
+		phys_addr_t upper = prop->base + prop->size - 1;
+
+		if (addr >= prop->base && addr <= upper)
+			return (prop->flags & flags) == flags;
 	}
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

