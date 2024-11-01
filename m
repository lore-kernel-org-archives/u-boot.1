Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7898E6B242
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2488892C0;
	Fri,  1 Nov 2024 11:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="TUhDHztj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="U38nrTr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5176188DF4; Fri,  1 Nov 2024 11:17:51 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E10788CD9
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 153732540126;
 Fri,  1 Nov 2024 06:17:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 01 Nov 2024 06:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730456267;
 x=1730542667; bh=5OrufsEAlTPUoatIATZERWrft5OlcA78+yDZI3KYFqw=; b=
 TUhDHztjqTh9GCuCkkNigtSyCPpyTHrFBN3kf2T7YtaKGytW59dgQijMS6PLvZsy
 BwGQcDa/lTtoaj4iNfmlzihPWSKLOcu2X1MLAMG2Bh8rO7D+SXOFhnCK3K8AIO7Z
 Q6p+7cPwQiAvvBGpwgmgMLCg70Xm26Q0ITGM+dczHvyQWr/Zv8E0qhQW09m6LAVx
 jmJijw8eSn645jCDd1UU3vYv1VO6nknL7pGOoo8Ias6hFpCs4mghs2Baucp3xppc
 r3Epw40vaPG7hq0EFa+4K6sLGGbOXucvgkbj3DkLnWzDfhDgPRfTAD+D7QIxOBk5
 eKK4QmD82q/WORNCbcUBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730456267; x=
 1730542667; bh=5OrufsEAlTPUoatIATZERWrft5OlcA78+yDZI3KYFqw=; b=U
 38nrTr25xuWvVW5q2a1v6Sf35p9rPpZz58w0jMDfhjIurCcEW7R0CNipuNIoRRml
 C/E3DbSGP5K7v+O74zWi8ZwAHKR569UEhyKoadbHeiKR3kgWXANKGPcvuNWRNd+J
 Isstt9t141ZGoe8MHDCzN397ku4jzJWuZ1eMU6+6YrCdrI1eQ7kPxn4FU65TlvUU
 +oQHG2wO1Ub7oR8QnxSJsDD4Q2fDFc4G7J+cKNhCXnF1V9eYV4qe6X/oBXuNyHl+
 VkijucMgZ+nj3ML5TY/9E6qXYgCh9iyqUFJ4jxwReGeLPgGX6DKfi0dEhcojUDOc
 7SAur/pAP6h17+FPUkTPw==
X-ME-Sender: <xms:y6okZ7QtFo7am9qMnOrl7354WiURVR3ogjnjleRxuL8ra9BFCOiQfQ>
 <xme:y6okZ8xJZ-7YQjjclEr9fMbeowPtETTcJ2-RR1208a57ahJpitmoecLHR0qzJFjJH
 G-pkylSqRq1fQNElkg>
X-ME-Received: <xmr:y6okZw0MuDXE24ByKi8gc-fAl-OTVWdjrxne6cp6RSnlTAVf2-nJicNPJlk94LFl0SrDVPj7FJGGssAacuiPciKgQMVT47GCf7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeehheeileduffehteeihfdvtdelffdutdeludduiedutedv
 feffheekhefgtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprh
 gtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehs
 uhhghhhoshhhrdhgrghnuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhjghestg
 hhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghn
 gidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:y6okZ7A7EOH3UmdWnOadLqVVCtP__S0h6IahuP1TmtokjOK_i_wk9A>
 <xmx:y6okZ0hODUz1lSY029i2YgZXFLQtyv_Gm8z3NNRJ0soDFrDrj0YngA>
 <xmx:y6okZ_qgRXHWwWxeHi6edcHFVzMpbf-FIqLHhLVhLYoT8lFJpKaRiQ>
 <xmx:y6okZ_i3W27qx24HaQM6OrF3r7FiskIreM8njSdM7dSCoxt-4t-nwg>
 <xmx:y6okZ_Vn-iCkKv1AiyQ14nAwCzGmctiG4dUcvmS9i1q5zzAfJo4ch-AV>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 06:17:47 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 01 Nov 2024 11:15:53 +0100
Subject: [PATCH 3/4] lmb: Add basic io_lmb functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-io_lmb_apple_dart_iommu-v1-3-fe4b9a74d47c@jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5122; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=B5uHMfxE/tr99M5ru4qGKJGovq53Z4s3rkhBo8Sne8s=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVVeHmD8LC/96+LPD9yH57v54vPadus6w/WvhL7E2Hc
 F2345tHHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACbClMXwv2jH84QWE1GhfJF1
 HpmTOrKmHrf4uzd/9cGYz6ceHuTWdmP4K9si2nuy7lxm6swP6k3WOtsjVzJtfOPrWRJxYzKTZAI
 rDwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

These functions can be used with struct lmb pointers and will be used to
manage IOVA space in the apple_dart iommu driver. This restores part of
the pointer base struct lmb API from before commit ed17a33fed29 ("lmb:
make LMB memory map persistent and global").
io_lmb_add() and io_lmb_free() can trivially reuse exisiting lmb
functions. io_lmb_setup() is separate for unique error log messages.
io_lmb_alloc() is a simplified copy of _lmb_alloc_base() since the
later has unused features and internal use of the global LMB memory map.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/lmb.h | 47 +++++++++++++++++++++++++++++++++++++
 lib/lmb.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/lmb.h b/include/lmb.h
index 2201d6f2b67bb605dbff015fa2a6a008b780c57a..9cb3ba8289e10ab92bea135d248580e44880e3e2 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -156,6 +156,53 @@ static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
 	return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
 }
 
+/**
+ * io_lmb_setup() - Initialize LMB struct
+ * @lmb: IO LMB to initialize
+ *
+ * Add the IOVA space [base, base + size] to be managed by io_lmb.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int io_lmb_setup(struct lmb *io_lmb);
+
+/**
+ * io_lmb_add() - Add an IOVA range for allocations
+ * @io_lmb: LMB to add the space to
+ * @base: Base Address of region to add
+ * @size: Size of the region to add
+ *
+ * Add the IOVA space [base, base + size] to be managed by io_lmb.
+ *
+ * Returns: 0 if the region addition was successful, -1 on failure
+ */
+long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
+
+/**
+ * io_lmb_alloc() - Allocate specified IO memory address with specified alignment
+ * @io_lmb: LMB to alloc from
+ * @size: Size of the region requested
+ * @align: Required address and size alignment
+ *
+ * Allocate a region of IO memory. The base parameter is used to specify the
+ * base address of the requested region.
+ *
+ * Return: base IO address on success, 0 on error
+ */
+phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
+
+/**
+ * io_lmb_free() - Free up a region of IOVA space
+ * @io_lmb: LMB to return the IO address space to
+ * @base: Base Address of region to be freed
+ * @size: Size of the region to be freed
+ *
+ * Free up a region of IOVA space.
+ *
+ * Return: 0 if successful, -1 on failure
+ */
+long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index 2ce91f7521cfe58577b092fdaea8004b17f0eeff..cbf1ee0df93a9cb0cfea571a4caebae09646595e 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -351,6 +351,80 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 	return addr & ~(size - 1);
 }
 
+/*
+ * IOVA LMB memory maps using lmb pointers instead of the global LMB memory map.
+ */
+
+int io_lmb_setup(struct lmb *io_lmb)
+{
+	int ret;
+
+	ret = alist_init(&io_lmb->free_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB free IOVA\n");
+		return -ENOMEM;
+	}
+
+	ret = alist_init(&io_lmb->used_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB used IOVA\n");
+		return -ENOMEM;
+	}
+
+	io_lmb->test = false;
+
+	return 0;
+}
+
+long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
+{
+	return lmb_add_region_flags(&io_lmb->free_mem, base, size, LMB_NONE);
+}
+
+/* derived and simplified from _lmb_alloc_base() */
+phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
+{
+	long i, rgn;
+	phys_addr_t base = 0;
+	phys_addr_t res_base;
+	struct lmb_region *lmb_used = io_lmb->used_mem.data;
+	struct lmb_region *lmb_memory = io_lmb->free_mem.data;
+
+	for (i = io_lmb->free_mem.count - 1; i >= 0; i--) {
+		phys_addr_t lmbbase = lmb_memory[i].base;
+		phys_size_t lmbsize = lmb_memory[i].size;
+
+		if (lmbsize < size)
+			continue;
+		base = lmb_align_down(lmbbase + lmbsize - size, align);
+
+		while (base && lmbbase <= base) {
+			rgn = lmb_overlaps_region(&io_lmb->used_mem, base, size);
+			if (rgn < 0) {
+				/* This area isn't reserved, take it */
+				if (lmb_add_region_flags(&io_lmb->used_mem, base,
+							 size, LMB_NONE) < 0)
+					return 0;
+
+				return base;
+			}
+
+			res_base = lmb_used[rgn].base;
+			if (res_base < size)
+				break;
+			base = lmb_align_down(res_base - size, align);
+		}
+	}
+	return 0;
+}
+
+long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
+{
+	return _lmb_free(&io_lmb->used_mem, base, size);
+}
+
 /*
  * Low level LMB functions are used to manage IOVA memory maps for the Apple
  * dart iommu. They must not access the global LMB memory map.

-- 
2.47.0

