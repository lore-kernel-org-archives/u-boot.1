Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76AACA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C1986852;
	Fri,  1 Sep 2023 03:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XjYGkGv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A21380750; Fri,  1 Sep 2023 03:14:23 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2248682B
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7928dc54896so52651439f.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530857; x=1694135657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wp7FzBapgobWTEInbS9wj0Jre/twJhccNaxdqsOKzD8=;
 b=XjYGkGv5mVmgGCGcTuFmAD7TQ0s2jzRABHi3Nh9AIKUwu9M0Q91RHfbaMJwcAYNx1L
 f/oc+xnQbBYWJblpJdTyLKr5LVkz+FznOC1HlrC/tjaV2kAQTLYWIdOcHAxZ7XWpdJGR
 QJQLP4Qf6SS9BUJstU+2PhZPNq50w7bFsmPyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530857; x=1694135657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wp7FzBapgobWTEInbS9wj0Jre/twJhccNaxdqsOKzD8=;
 b=IszKyK7bbLZyJnnMZNGa7QuthqeMElbEAejbsRN9ND6hvtUTSdPhQn/SMcLL1+j8EI
 W0t7pE/6xaCP9aigiALqCwgsq4OPEjFbcyOime+JkPzMpDyl+fpfeo0w0d5I329dMCKj
 4AyXG/HlS3gXNnYU98zWv2VZmgrlkuctkY1oLCNNnfQNeycRIRRgTI7gGvHfmt17kgEc
 wzbNBMVnrPeyg9yp4uBCt2V02+p5u72RIZt0ll9F73a9CVqpHo8eWE1CIeOuTrYN93dG
 4qbeTFLsdhgkjWgQ2dMyiU/6g+lPe1QjzgG19tybld4N0yXsp31QTqZ9K/PXJscLKqjy
 qxBA==
X-Gm-Message-State: AOJu0Yxg2OwBwwhQAUMgVWTXI5xGbwehEqjkJznDaQUkFCk8GJQ+R8i5
 h65mYe3k9gIrpaHEZxc20Xw+tk0Rp651akCOp3s=
X-Google-Smtp-Source: AGHT+IHIvLtHnim+HsChBkysCNXogA9mdhmuqWCWgcT0fITMBdWMBONeseODlvQfN6kCggr5OS4RIg==
X-Received: by 2002:a05:6e02:f45:b0:34d:f0b4:787a with SMTP id
 y5-20020a056e020f4500b0034df0b4787amr1127995ilj.15.1693530857387; 
 Thu, 31 Aug 2023 18:14:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 09/14] lmb: Tidy up structure access
Date: Thu, 31 Aug 2023 19:13:47 -0600
Message-ID: <20230901011357.2482203-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901011357.2482203-1-sjg@chromium.org>
References: <20230901011357.2482203-1-sjg@chromium.org>
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

(no changes since v1)

 lib/lmb.c | 58 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 0b03cc4d1c23..862b1cd04953 100644
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
-		base = rgn->area[i].base;
-		size = rgn->area[i].size;
-		end = base + size - 1;
-		flags = rgn->area[i].flags;
+		struct lmb_area *area = &rgn->area[i];
+		unsigned long long end;
+
+		end = area->base + area->size - 1;
 
 		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
-		       name, i, base, end, size, flags);
+		       name, i, (unsigned long long)area->base, end,
+		       (unsigned long long)area->size, area->flags);
 	}
 }
 
@@ -88,11 +87,8 @@ static void lmb_remove_area(struct lmb_region *rgn, unsigned long area)
 {
 	unsigned long i;
 
-	for (i = area; i < rgn->cnt - 1; i++) {
-		rgn->area[i].base = rgn->area[i + 1].base;
-		rgn->area[i].size = rgn->area[i + 1].size;
-		rgn->area[i].flags = rgn->area[i + 1].flags;
-	}
+	for (i = area; i < rgn->cnt - 1; i++)
+		rgn->area[i] = rgn->area[i + 1];
 	rgn->cnt--;
 }
 
@@ -120,6 +116,7 @@ void lmb_init(struct lmb *lmb)
 
 void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
 {
+	struct bd_info *bd = gd->bd;
 	ulong bank_end;
 	int bank;
 
@@ -133,12 +130,10 @@ void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
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
@@ -242,13 +237,15 @@ static long lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 
 	/* First try and coalesce this LMB with another. */
 	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t abase = rgn->area[i].base;
-		phys_size_t asize = rgn->area[i].size;
-		phys_size_t aflags = rgn->area[i].flags;
+		struct lmb_area *area = &rgn->area[i];
+
+		phys_addr_t abase = area->base;
+		phys_size_t asize = area->size;
+		phys_size_t aflags = area->flags;
 		phys_addr_t end = base + size - 1;
-		phys_addr_t rgnend = abase + asize - 1;
+		phys_addr_t aend = abase + asize - 1;
 
-		if (abase <= base && end <= rgnend) {
+		if (abase <= base && end <= aend) {
 			if (flags == aflags)
 				/* Already have this area, so we're done */
 				return 0;
@@ -260,14 +257,14 @@ static long lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 		if (adjacent > 0) {
 			if (flags != aflags)
 				break;
-			rgn->area[i].base -= size;
-			rgn->area[i].size += size;
+			area->base -= size;
+			area->size += size;
 			coalesced++;
 			break;
 		} else if (adjacent < 0) {
 			if (flags != aflags)
 				break;
-			rgn->area[i].size += size;
+			area->size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, abase, asize)) {
@@ -291,9 +288,7 @@ static long lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = rgn->cnt-1; i >= 0; i--) {
 		if (base < rgn->area[i].base) {
-			rgn->area[i + 1].base = rgn->area[i].base;
-			rgn->area[i + 1].size = rgn->area[i].size;
-			rgn->area[i + 1].flags = rgn->area[i].flags;
+			rgn->area[i + 1] = rgn->area[i];
 		} else {
 			rgn->area[i + 1].base = base;
 			rgn->area[i + 1].size = size;
@@ -533,10 +528,11 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
 	int i;
 
 	for (i = 0; i < lmb->reserved.cnt; i++) {
-		phys_addr_t upper = lmb->reserved.area[i].base +
-			lmb->reserved.area[i].size - 1;
-		if (addr >= lmb->reserved.area[i].base && addr <= upper)
-			return (lmb->reserved.area[i].flags & flags) == flags;
+		struct lmb_area *area = &lmb->reserved.area[i];
+		phys_addr_t upper = area->base + area->size - 1;
+
+		if (addr >= area->base && addr <= upper)
+			return (area->flags & flags) == flags;
 	}
 
 	return 0;
-- 
2.42.0.283.g2d96d420d3-goog

