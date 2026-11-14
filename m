Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204D606A330
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d/16Reak
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17BD76077C;
	Sat, 14 Nov 2026 00:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NuiyH6iZhUlE; Sat, 14 Nov 2026 00:11:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20AEC606EA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615093;
	b=fpBWiYZUwgkxuKuvbH0iJCXPtNax7geFkqKfkc4IbkofNhChIZCEj3ilKjgutIQWsv7Z
	 Mbc0Iw/aNmjB/iZCrdnEufdoIQepwnySGPEr7agWllVuGz3JgGotu/DGfr1GZUi687+L7
	 v74pjC7wzsXffk146q7mTBcSEsZohIyDerQJ6fNTgq5zaXuIExhk82khq/WZuvl34SsWf
	 cHFDmChleHRw1OtQkdV8rV9MgfTPfoT25r41+E3GqYVA5kJmjyXSJEbqKvhCVVbbf1zcR
	 57O3YpJFe40Dytm4pNP7JIpbWtflABb2rsqetMe0w19S4XZTFy5FwqKWDmU0RXn4c+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XyY41mdS6lYN3K3r4071h1u24qmjuG2RddANyMPikuw=;
	b=luxOUk0l62sQ0PmEO9pPxwxGYr32K7GlxLDHusf5+oD4hNlWoAb8Nps1jb9khQGyAM05
	 vbB/O6Z07WL+hrRuoY2cDh8gFYw+El5nLhhjVxg28UECS6gWVbzHmqnJGEf14M+W6KPML
	 bZhKmqM5pE4Of1rYVVmfi58FMpfec6JgojTZjUrrHtanYxzlSjUpdP1//KVziLI3RZDp1
	 Oa3PdOAbWtKEghtf91wa63rGvxr5HTB1FaiYylrMBb+vXxAcYpM7cXmZ2AM6rKu2DLeLA
	 TtJPezvZ1OqF++4u4H8Q5Wn209BTcOC3aA2hpDbHy0aldvxuTlrW9yhLmzlL497ttdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615093;
	bh=XyY41mdS6lYN3K3r4071h1u24qmjuG2RddANyMPikuw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/16ReakjfzNE/0LUjZNs/OJqLfm3QsrPWrYz65pbYh8w/uE51cak1qngvibm2vYW
	 pBk4g+WTa67WCaliggSKXDQa59nl0JQ/7nxfXoFS6klYEGP9IoJTpevsGVJToBZU5d
	 4CILimYIr2Y+zMdQnctMmdQlxoWXLjAL5/uV6OaYXehNtET+SS2faL5qpJ93xE26yn
	 3+Bmj3lIFnCplU2L+t7bqoBfhhVZqgZCr41MqHxYmTi1tBXxPuMxYaU4GJ1YM1CgDS
	 I8fAVSk3KpXcXcFvUyzxALJrdN2NlIcMSCpbd60Kl/wmVoUpgC/h59RGsFmvNfVcgv
	 jP6eD+EG7P4sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20AEC606EA;
	Sat, 14 Nov 2026 00:11:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B6D428C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89C5540269
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSq9NhUqxjKC for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:11:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AFA934025F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFA934025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:30 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1MW-00000000053-0eHn;
 Sat, 14 Nov 2026 00:11:20 +0000
Date: Sat, 14 Nov 2026 00:11:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 4/9] boot: imagemap: Preserve mappings when an extend fails
Message-ID: <ba37599719c79518fedceb1c696327f6a5eab7af.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extending a region releases its reservation before allocating and
reading the larger range. A failure leaves the old mapping pointing at
unreserved memory, which cleanup may free again after another user
has allocated it.

Keep the original reservation until the read succeeds, reserving the
added space or a new block first. Update the mapping after success.

Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c | 143 +++++++++++++++++++++++++++++-------------------
 1 file changed, 87 insertions(+), 56 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index d46c1430fb7..0e3fbd0934a 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -208,6 +208,82 @@ static int imagemap_read_exact(struct spl_load_info *info, loff_t off,
 	return 0;
 }
 
+/**
+ * imagemap_extend() - Grow a region this device allocated
+ *
+ * The region keeps its reservation and its record until the larger one
+ * is reserved and read, so a failure leaves the existing mapping valid.
+ *
+ * @priv:	The imagemap uclass data
+ * @r:		Region to grow, with lmb_reserved set
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes wanted from @img_offset
+ * Return: pointer to the data at @img_offset, or ERR_PTR on failure
+ */
+static void *imagemap_extend(struct imagemap_priv *priv,
+			     struct imagemap_region *r, loff_t img_offset,
+			     ulong size)
+{
+	phys_size_t old_alloc = ALIGN(r->size, ARCH_DMA_MINALIGN);
+	ulong bl_len = spl_get_bl_len(&priv->info);
+	ulong overhead = img_offset & (bl_len - 1);
+	ulong read_size = ALIGN(size + overhead, bl_len);
+	phys_addr_t old_addr = map_to_sysmem(r->ram);
+	phys_size_t alloc_size, tail_size;
+	phys_addr_t addr, tail;
+	void *base;
+	int ret;
+
+	alloc_size = ALIGN(read_size, ARCH_DMA_MINALIGN);
+	tail_size = alloc_size - old_alloc;
+	tail = old_addr + old_alloc;
+
+	ret = 0;
+	if (tail_size)
+		ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &tail, tail_size,
+				    LMB_NONE);
+	if (!ret) {
+		base = map_sysmem(old_addr, alloc_size);
+		ret = spl_load_region(&priv->info, r->img_offset + r->size,
+				      read_size - r->size,
+				      (char *)base + r->size);
+		if (ret < 0) {
+			if (tail_size)
+				lmb_free(tail, tail_size, LMB_NONE);
+			goto err_read;
+		}
+		r->size = read_size;
+
+		return base + overhead;
+	}
+
+	if (lmb_alloc_mem(LMB_MEM_ALLOC_ANY, ARCH_DMA_MINALIGN, &addr,
+			  alloc_size, LMB_NONE)) {
+		log_err("imagemap: LMB alloc failed (0x%lx bytes)\n",
+			(ulong)alloc_size);
+		return ERR_PTR(-ENOMEM);
+	}
+	base = map_sysmem(addr, alloc_size);
+
+	ret = spl_load_region(&priv->info, img_offset, size, base);
+	if (ret < 0) {
+		lmb_free(addr, alloc_size, LMB_NONE);
+		goto err_read;
+	}
+
+	lmb_free(old_addr, old_alloc, LMB_NONE);
+	r->size = read_size;
+	r->ram = base;
+
+	return base + overhead;
+
+err_read:
+	log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
+		(unsigned long long)img_offset, size, ret);
+
+	return ERR_PTR(ret);
+}
+
 void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 {
 	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
@@ -215,10 +291,8 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 	ulong overhead = img_offset & (bl_len - 1);
 	loff_t base_off = img_offset - overhead;
 	ulong read_size = ALIGN(size + overhead, bl_len);
-	phys_addr_t old_addr;
 	phys_addr_t addr;
 	phys_size_t alloc_size;
-	ulong old_size;
 	void *base;
 	int ret;
 	struct imagemap_region *r;
@@ -231,62 +305,19 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
 
 	alloc_size = ALIGN(read_size, ARCH_DMA_MINALIGN);
 
-	/*
-	 * Extend a block-aligned region at the same base offset to the
-	 * larger size, re-reading the full range from storage.
-	 */
 	alist_for_each(r, &priv->regions) {
-		if (r->img_offset == base_off && r->size < read_size) {
-			/*
-			 * Only a region this device allocated may be resized;
-			 * one recorded by imagemap_map_to() lives at an address
-			 * the caller chose and owns.
-			 */
-			if (!r->lmb_reserved)
-				break;
-
-			old_size = r->size;
-			old_addr = map_to_sysmem(r->ram);
-			addr = old_addr;
-
-			lmb_free(addr, ALIGN(old_size, ARCH_DMA_MINALIGN),
-				 LMB_NONE);
+		if (r->img_offset != base_off || r->size >= read_size)
+			continue;
 
-			/* Try to re-reserve at the same address with new size */
-			if (lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
-					  alloc_size, LMB_NONE)) {
-				/* In-place extend failed, allocate elsewhere */
-				if (lmb_alloc_mem(LMB_MEM_ALLOC_ANY,
-						  ARCH_DMA_MINALIGN,
-						  &addr, alloc_size,
-						  LMB_NONE)) {
-					log_err("imagemap: LMB alloc failed (0x%lx bytes)\n",
-						(ulong)alloc_size);
-					return ERR_PTR(-ENOMEM);
-				}
-			}
-			base = map_sysmem(addr, alloc_size);
-
-			if (addr == old_addr)
-				ret = spl_load_region(&priv->info,
-						      base_off + old_size,
-						      read_size - old_size,
-						      (char *)base + old_size);
-			else
-				ret = spl_load_region(&priv->info, img_offset,
-						      size, base);
-			if (ret < 0) {
-				log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
-					(unsigned long long)img_offset, size, ret);
-				lmb_free(addr, alloc_size, LMB_NONE);
-				return ERR_PTR(ret);
-			}
-			r->size = read_size;
-			r->ram = base;
-			r->lmb_reserved = true;
-
-			return base + overhead;
-		}
+		/*
+		 * Only a region this device allocated may be resized;
+		 * one recorded by imagemap_map_to() lives at an address
+		 * the caller chose and owns.
+		 */
+		if (!r->lmb_reserved)
+			break;
+
+		return imagemap_extend(priv, r, img_offset, size);
 	}
 
 	/* New region - allocate from LMB */
-- 
2.56.0
