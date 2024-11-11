Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD35BD12D7B
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 06:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF1F8921A;
	Mon, 11 Nov 2024 07:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1cCWhYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDBB8921A; Mon, 11 Nov 2024 07:56:50 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7C28921A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 07:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0B0E45C593E;
 Mon, 11 Nov 2024 06:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D963C4CED9;
 Mon, 11 Nov 2024 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731308206;
 bh=PeHXes+y5s1AbmiG9t2pcr41FQgJzfLa3JOFiZGVK6w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=T1cCWhYfXSukYHEJ2DZzDd95WsTPzSXZMxBrFAQvGRrVQaQ8TZ8Drfq4iQTfib+5P
 iZ7Mtq/mWb7tL51Ufvdhug40jZhqq9D02ncvcmSQPnr0WskLwZTBP9lXE2bINBCSss
 iqpBfr2FslgB13zvkVk6M3navVWMhznpGYQB9lRdC6TcuVu8LRhxXnr5//GxJqoiW3
 2MFzkq1VU2aWpX7FEdH3dEn/j6ITG8buAxaOCyXzrwcHeQKRCLbpq1tBB/w1bPIUkV
 X9tQnDwZs/5OnZGnSWPgEUXJ5KALgdV2SuZ12h9lYLdqZk0fKUMUFrDvm3zQ1E6G7u
 6Uda3Ap0JPIGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 24F78D12D7C;
 Mon, 11 Nov 2024 06:56:46 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Mon, 11 Nov 2024 07:56:34 +0100
Subject: [PATCH v3 4/4] iommu: apple: Manage IOVA separately from global
 LMB mem map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-io_lmb_apple_dart_iommu-v3-4-32c05da51d72@jannau.net>
References: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
In-Reply-To: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=08kZAPvA4oNAZQc/Pg50HxtG4DgEYxQOQYIzZTgD1O4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTDVWu61SyDNL93xEet/rzr/fN3Kvd/WugIhd8+ab6N2
 +/02RUNHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZSbcnwT28701q/O0dyVRam
 2atccLis4zNJ99dCmxid3xzZmRKXjzAyLJHP9zstoMF3f+b7pzeXlO38tavmHdtatfQpov9i+kM
 M+QE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

There is no overlap between the IOVA space managed by the iommu (here
the 32-bit address space) and physical RAM on Apple silicon systems. The
RAM starts at 0x10_0000_0000 or 0x100_0000_0000 so it's not possible to
manage the IOVA with the global memory LMB and use 1:1 translation.
In addition each device has its own iommu and does not need to share the
address space with all other devices. This should not be problem for
u-boot's limited use and hardware support.
Restore the private per instance LMB IOVA map.

Fixes: ed17a33fed2 ("lmb: make LMB memory map persistent and global")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple_dart.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 611ac7cd6deb4fccd45ccfe8cbb9b3e36e2af753..3e9e7819e517b8fe62b9e429b7a8ca3eca29741d 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -73,6 +73,8 @@ struct apple_dart_priv {
 	u64 *l1, *l2;
 	int bypass, shift;
 
+	struct lmb io_lmb;
+
 	dma_addr_t dvabase;
 	dma_addr_t dvaend;
 
@@ -123,7 +125,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
 	off = (phys_addr_t)addr - paddr;
 	psize = ALIGN(size + off, DART_PAGE_SIZE);
 
-	dva = lmb_alloc(psize, DART_PAGE_SIZE);
+	dva = io_lmb_alloc(&priv->io_lmb, psize, DART_PAGE_SIZE);
 
 	idx = dva / DART_PAGE_SIZE;
 	for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
@@ -159,7 +161,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
 			   (unsigned long)&priv->l2[idx + i]);
 	priv->flush_tlb(priv);
 
-	lmb_free(dva, psize);
+	io_lmb_free(&priv->io_lmb, dva, psize);
 }
 
 static struct iommu_ops apple_dart_ops = {
@@ -173,7 +175,7 @@ static int apple_dart_probe(struct udevice *dev)
 	dma_addr_t addr;
 	phys_addr_t l2;
 	int ntte, nl1, nl2;
-	int sid, i;
+	int ret, sid, i;
 	u32 params2, params4;
 
 	priv->base = dev_read_addr_ptr(dev);
@@ -212,7 +214,13 @@ static int apple_dart_probe(struct udevice *dev)
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
 
-	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
+	ret = io_lmb_setup(&priv->io_lmb);
+	if (ret)
+		return ret;
+	ret = io_lmb_add(&priv->io_lmb, priv->dvabase,
+			 priv->dvaend - priv->dvabase);
+	if (ret)
+		return -EINVAL;
 
 	/* Disable translations. */
 	for (sid = 0; sid < priv->nsid; sid++)
@@ -294,6 +302,8 @@ static int apple_dart_remove(struct udevice *dev)
 	}
 	priv->flush_tlb(priv);
 
+	io_lmb_teardown(&priv->io_lmb);
+
 	return 0;
 }
 

-- 
2.47.0


