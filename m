Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A207FC5AC67
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E5674092C;
	Fri,  7 Aug 2026 01:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxVjIvge4q7f; Fri,  7 Aug 2026 01:50:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2546D40911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067441;
	bh=UjrQYEMZ6nzOkGNX33fkqTMgcGrum7FFWzTx0TJk/AA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=q7pshvzxAiS/nMg5JuKEzYxE49wgmq86GrH8yvpt7dbg0gLBhBPUQ0NBmTx8H5eqz
	 h7l6SSs2oyxhyUp/QyOlVZr/w27zO/PHxzsFP7BiFe6AOLuVqmdgWSU67q6w9CDTbh
	 p7kVHAUbyatYPBpndSl8OaRZ0o8EOWYgPQzBEuCV1DAHi+yJqm060biI+X3d30e2f8
	 PL8qDHhRsursrKDEBs0Axc9E8TrzQrusChF5ndA7z/AW4CXSBNwnEg6L7P40yWeJ6d
	 17Bppkgvo7lhaM0kmkZ2XF29ozZQZy2fqKu+JyYczPzVaHDp1F9TvC6hkHhw9LmIaM
	 Rw8547SWNQCfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2546D40911;
	Fri,  7 Aug 2026 01:50:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5005392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B28260848
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZ10DE7j8n-T for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:29:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 709176083A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 709176083A
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 709176083A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:48 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-51c0cea8883so12382111cf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786051787; x=1786656587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UjrQYEMZ6nzOkGNX33fkqTMgcGrum7FFWzTx0TJk/AA=;
 b=ha7y53MRz7EZvVf5EQ1BQ8+U53pl0rN2GGKB8lKBmqlGg3YYAJzhOo7SIWfqhEh8A3
 chuY/nHzU0vfq5RiZjFXN5Xk1iU9x4k/XTRTSCo1dHfcG44yrOXl8w3JeeyX6tBYX2Pq
 q2srBp6MFlG7oxpGVxR1UF6HjM5wLKDGceigRNF4xLpWoKVk/soPtlrXMoBbnsKdgwZE
 kAXEGTlmmtRs5DxFNBBVDIVEeVQQ1YYclu0ilvUdNjQxyS0weM7jGkv3W1bHx9RDafc+
 WkI7hISqVktrIyMDwqnxDMjArxIrzHNjT8/drV8rgTVcM4p87Ds98Fz1yQHIaGHbXsfv
 ChYQ==
X-Gm-Message-State: AOJu0YxntuKvCuooaP1jcrwwRFyCdr8VU/VEsN6WUs9NdnH+CQfgSDF+
 GxhiFriOWWpeJ3KgXI9zW1ZqucJq0DDNQ3LBblxtoWBB6arR6zAHtw23S5A+iMl66LBhsDPNx3l
 BFmx5va60g/4i
X-Gm-Gg: AR+sD11M8auXL0s/8lLAdzQEAzhgx2WQosK+nx8rd/j7Nl+7vB4rUvZitU+3vDxxV9b
 WC/dBM5NcjcJiN4IoNSP7/nYtaVV0E9NJmAM8yBmJRC3M6gFJVD3xaA/Y0bUxdmzS3si5ereNbN
 l1fFSt4WXoMrqK3PEBLd759Z4axhtFIFjWgl5koU/Fi3WZG++bWiq3q6MbVuLwYnoWpmmFM05qF
 uzA6MBGqKLgFw+h33orhg2TJPQztL2GACJKy8fgB1Cz0bD9Vto+Z/+1HGs/v2AvJuRJrnodsITT
 ex07DzjRd0hN27j0EFj3o+cjhZTE+IlPizRgnRFj+XRzJjfc+67VD0FM3LCovl1CDRM6FRPE1N0
 fUgywQPyBAaPa0ZRn3NVNxhOuHERJHo3YfAjB+4dEusNdEZiNH5JrnD46JmfpM38rCo/bfi+BJ0
 muSIvy7Old3LWOdcZPryqz5F44s2RcawGo8Zsw50fw2hH62M5InRMVAtGU59/6LVy+XDw6fc/L3
 pFftkmck0cAF+gZ
X-Received: by 2002:a05:622a:4cc6:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52cfaedbcb5mr110741441cf.2.1786051786944; 
 Thu, 06 Aug 2026 14:29:46 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c207b4fffcdsm2071466b.46.2026.08.06.14.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:29:46 -0700 (PDT)
Date: Thu, 06 Aug 2026 22:29:21 +0100
Subject: [PATCH v2 3/4] spl: fit: Harden external-data offset and size
 arithmetic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-fit-ext-data-hardening-v2-3-b181cac15c29@binarly.io>
References: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
In-Reply-To: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786051774; l=11614;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=81KHaq8AIwsQVtKUuabN3Q2A2ZKedSqDjBAJwQ9TokA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOYiWUsNZ0uCJ1GcHYLLT19cdh9DOgRSYqEaTJRpSUqY6XRsU/6KalCZK+gWN5bL1UdgKxC9kGF
 L9iRp7fsXWAY=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786051787; x=1786656587;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UjrQYEMZ6nzOkGNX33fkqTMgcGrum7FFWzTx0TJk/AA=;
 b=aj0fXAZdrpCnSrfsbhhP6jOJK8JRLtLOXLGW//mb4NSxNsEnd5BVaDE7hFbpIxuXjY
 lYSBJFsNrtRmlDqXWcNEOFA/hV77ADeeTs196QPM1xRBBXkYuPaVMC9mm9JuHe4KakrO
 txcVtdxMx3/9IGRw4IrvQdpF65shOQ4BXr1Q+PsdUq0JctmZJYEtOIbQ/p2Zsf9mAILQ
 7e2h3SOJZtAv9kmPC60zMPpifD4hr3R80mhe4NpCI5dgxi0Qztot+IxmI3Ui347M769A
 HB1lPTV8SC6HsRgzRC5sFuyHiEnn3EWvAWZqfBw5LvcJxPYR00tnBuNTxIKNSiGYRSO+
 FzWQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=binarly.io header.i=@binarly.io
 header.a=rsa-sha256 header.s=google header.b=aj0fXAZd
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anton Ivanov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anton Ivanov <anton@binarly.io>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The data-offset, data-position and data-size FIT properties are
excluded from the configuration signature, so they are attacker
controlled even when signature verification succeeds. The offset and
size arithmetic in load_simple_fit() can wrap on hostile values:

 - adding the external-data base offset to data-offset can wrap past
   UINT32_MAX,
 - get_aligned_image_size() adds the block-alignment overhead and
   rounds up to the block length, which can wrap past ULONG_MAX,
 - adding the FIT's device offset to the aligned external-data offset
   can wrap past ULONG_MAX.

Make get_aligned_image_size() return the aligned size through an out
parameter and fail with -EOVERFLOW when the computation would wrap,
check the two offset additions explicitly, and compare the
block-aligned size (the amount info->read() actually transfers)
against max_size before reading. Do the same for the FIT header read
in spl_simple_fit_read().

Signed-off-by: Anton Ivanov <anton@binarly.io>

---
Code size impact of this patch alone (buildman -S, gcc 13.3), measured
on arm and aarch64: 387 of the 413 boards that build spl_fit.c. All of
the impact is in SPL; U-Boot proper is unchanged:

  CONFIG_SPL_LOAD_BLOCK=y: text +72..+112, rodata +141 (all +209..+253)
  CONFIG_SPL_LOAD_BLOCK=n: text       +32, rodata  +86 (all       +118)

Without SPL_LOAD_BLOCK, spl_get_bl_len() is a compile-time 1, so the
block-alignment overflow checks in get_aligned_image_size() fold away
along with two of the new messages. Where present, the growth is in
load_simple_fit() and in spl_simple_fit_read(). The rodata is the new
printf() strings, so most of the growth is diagnostics rather than
logic - happy to change them to log_debug() if that is preferred for
SPL.
---
 common/spl/spl_fit.c  | 98 +++++++++++++++++++++++++++++----------------------
 test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 43 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 9b16f91cc6f..9b0bee25b8b 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -175,22 +175,32 @@ static int spl_fit_get_image_node(const struct spl_fit_info *ctx,
 	return node;
 }
 
-static int get_aligned_image_offset(struct spl_load_info *info, int offset)
+static u32 get_aligned_image_offset(struct spl_load_info *info, u32 offset)
 {
 	return ALIGN_DOWN(offset, spl_get_bl_len(info));
 }
 
-static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
+static u32 get_aligned_image_overhead(struct spl_load_info *info, u32 offset)
 {
 	return offset & (spl_get_bl_len(info) - 1);
 }
 
-static int get_aligned_image_size(struct spl_load_info *info, int data_size,
-				  int offset)
+static int get_aligned_image_size(struct spl_load_info *info, ulong data_size,
+				  u32 offset, ulong *aligned_size)
 {
-	data_size = data_size + get_aligned_image_overhead(info, offset);
+	u32 overhead = get_aligned_image_overhead(info, offset);
 
-	return ALIGN(data_size, spl_get_bl_len(info));
+	if (data_size > ULONG_MAX - overhead)
+		return -EOVERFLOW;
+	data_size += overhead;
+
+	if (data_size > ULONG_MAX - (spl_get_bl_len(info) - 1))
+		return -EOVERFLOW;
+	data_size = ALIGN(data_size, spl_get_bl_len(info));
+
+	*aligned_size = data_size;
+
+	return 0;
 }
 
 /**
@@ -223,17 +233,16 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	ulong load_addr;
 	void *load_ptr;
 	void *src;
-	ulong overhead;
 	uint8_t image_comp = -1, type = -1;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
+	int ret;
 
 	log_debug("starting\n");
 	if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
 	    xpl_get_phase(info) != IH_PHASE_NONE) {
 		enum image_phase_t phase;
-		int ret;
 
 		ret = fit_image_get_phase(fit, node, &phase);
 		/* if the image is for any phase, let's use it */
@@ -273,13 +282,19 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
-		log_debug("read offset %x = offset from fit %lx\n",
-			  offset, (ulong)offset + ctx->ext_data_offset);
+		/* The resulting offset cannot exceed UINT32_MAX */
+		if (ctx->ext_data_offset > UINT32_MAX - offset) {
+			printf("Invalid external data offset: %u\n", offset);
+			return -EINVAL;
+		}
+		log_debug("read offset %x = offset from fit %x\n", offset,
+			  (u32)(offset + ctx->ext_data_offset));
 		offset += ctx->ext_data_offset;
 		external_data = true;
 	}
 
 	if (external_data) {
+		u32 aligned_offset;
 		ulong read_offset;
 		void *src_ptr;
 
@@ -300,16 +315,26 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		 * controlled even after fit_config_verify() succeeds. The
 		 * image hash is only verified after the device read below, so
 		 * an oversized value has to be rejected here.
-		 *
-		 * Bail out before get_aligned_image_size() runs on a hostile
-		 * len: that helper does its arithmetic in int and would
-		 * invoke signed-integer overflow on a value close to or above
-		 * INT_MAX. The block-aligned check further down is the
-		 * mathematically binding one, since size is len rounded up to
-		 * the device block length.
 		 */
-		if ((ulong)len > max_size)
-			goto too_big;
+		ret = get_aligned_image_size(info, len, offset, &size);
+		if (ret) {
+			printf("Invalid external data size: %u\n", len);
+			return ret;
+		}
+
+		if (size > max_size) {
+			printf("Image too large: aligned size %lu, max %lu (data-size %u)\n",
+			       size, max_size, len);
+			return -EFBIG;
+		}
+
+		aligned_offset = get_aligned_image_offset(info, offset);
+		if (aligned_offset > ULONG_MAX - fit_offset) {
+			printf("Invalid aligned external data offset: %u\n",
+			       aligned_offset);
+			return -EINVAL;
+		}
+		read_offset = fit_offset + aligned_offset;
 
 		if (spl_decompression_enabled() &&
 		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
@@ -318,19 +343,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
 		length = len;
 
-		overhead = get_aligned_image_overhead(info, offset);
-		size = get_aligned_image_size(info, length, offset);
-		read_offset = fit_offset + get_aligned_image_offset(info,
-							    offset);
-
-		/*
-		 * info->read() transfers the block-aligned size into the
-		 * destination, so this is the bound that actually matters;
-		 * len was rejected above only to keep this computation safe.
-		 */
-		if (size > max_size)
-			goto too_big;
-
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
@@ -339,7 +351,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 
 		debug("External data: dst=%p, offset=%x, size=%lx\n",
 		      src_ptr, offset, (unsigned long)length);
-		src = src_ptr + overhead;
+		src = src_ptr + get_aligned_image_overhead(info, offset);
 	} else {
 		/* Embedded data */
 		if (fit_image_get_emb_data(fit, node, &data, &length)) {
@@ -401,11 +413,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	upl_add_image(fit, node, load_addr, length);
 
 	return 0;
-
-too_big:
-	printf("%s: FIT image too large (data-size %u, max %lu)\n",
-	       __func__, (u32)len, max_size);
-	return -EFBIG;
 }
 
 static bool os_takes_devicetree(uint8_t os)
@@ -737,8 +744,9 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 			       struct spl_load_info *info, ulong offset,
 			       const void *fit_header)
 {
-	unsigned long count, size;
+	unsigned long aligned_size, count, size;
 	void *buf;
+	int ret;
 
 	/*
 	 * For FIT with external data, figure out where the external images
@@ -756,8 +764,12 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 * For FIT with data embedded, data is loaded as part of FIT image.
 	 * For FIT with external data, data is not loaded in this step.
 	 */
-	size = get_aligned_image_size(info, size, 0);
-	buf = board_spl_fit_buffer_addr(size, size, 1);
+	ret = get_aligned_image_size(info, size, 0, &aligned_size);
+	if (ret) {
+		printf("Invalid FIT size: %lu\n", size);
+		return ret;
+	}
+	buf = board_spl_fit_buffer_addr(aligned_size, aligned_size, 1);
 	if (!buf) {
 		/*
 		 * We assume that none of the board will ever use 0x0 as a
@@ -767,7 +779,7 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 		return -EIO;
 	}
 
-	count = info->read(info, offset, size, buf);
+	count = info->read(info, offset, aligned_size, buf);
 	if (!count) {
 		/*
 		 * FIT could not be read. This means we should free the
@@ -800,7 +812,7 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 
 	ctx->fit = buf;
 	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
-	      offset, size, buf, count);
+	      offset, aligned_size, buf, count);
 
 	return 0;
 }
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 49bfce15c08..557362ba113 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -426,6 +426,63 @@ static int spl_test_fit_external_oversize(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_fit_external_oversize, 0);
 
+/*
+ * A data-offset which wraps past UINT32_MAX once the external-data base
+ * offset is added must be rejected before it is used as a read offset.
+ */
+static int spl_test_fit_data_offset_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0xffffffff, 1,
+				  spl_test_read, 0, -EINVAL);
+}
+SPL_TEST(spl_test_fit_data_offset_overflow, 0);
+
+/*
+ * A data-size whose block-aligned read size wraps past ULONG_MAX must be
+ * rejected. Since data-size is a 32-bit property, the wrap is only reachable
+ * when ulong is 32 bits wide, so skip the test on other targets.
+ */
+static int spl_test_fit_data_size_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL) || sizeof(ulong) != 4)
+		return -EAGAIN;
+
+	return check_fit_ext_prop(uts, FIT_DATA_SIZE_PROP, 0xffffffff, 2,
+				  spl_test_read, 0, -EOVERFLOW);
+}
+SPL_TEST(spl_test_fit_data_size_overflow, 0);
+
+/* Device offset the reader pretends the FIT was loaded from */
+static ulong spl_test_fit_offset;
+
+static ulong spl_test_read_fit_offset(struct spl_load_info *load, ulong sector,
+				      ulong count, void *buf)
+{
+	return spl_test_read(load, sector - spl_test_fit_offset, count, buf);
+}
+
+/*
+ * An aligned external-data offset which wraps past ULONG_MAX once the FIT's
+ * offset on the device is added must be rejected before it is used as a read
+ * offset.
+ */
+static int spl_test_fit_read_offset_overflow(struct unit_test_state *uts)
+{
+	if (!image_supported(FIT_EXTERNAL))
+		return -EAGAIN;
+
+	/* So that ULONG_MAX - fit_offset < the aligned external-data offset */
+	spl_test_fit_offset = ULONG_MAX - 0xfff;
+
+	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0x1000, 1,
+				  spl_test_read_fit_offset, spl_test_fit_offset,
+				  -EINVAL);
+}
+SPL_TEST(spl_test_fit_read_offset_overflow, 0);
+
 /*
  * LZMA is too complex to generate on the fly, so let's use some data I put in
  * the oven^H^H^H^H compressed earlier

-- 
2.55.0

