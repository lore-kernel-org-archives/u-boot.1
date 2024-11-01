Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD85FE6B240
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B43888F4A;
	Fri,  1 Nov 2024 11:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="JcBoVK2U";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="C66uFMDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C30F892DE; Fri,  1 Nov 2024 11:17:53 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38019889EB
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 0F667114011A;
 Fri,  1 Nov 2024 06:17:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 01 Nov 2024 06:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730456269;
 x=1730542669; bh=n7nXeDgB4StCvrOsF3kD+lrkSkisJnObEGeXylfjRjM=; b=
 JcBoVK2UZZON/q3jOWZkI0w0e+IcQ5fs7hD9dtWjtLJ1OFIQnup9hRrfAt9598tU
 xrAcjiDP1aiWCiGB+J7r1UMEyM00e2euODRD4cKRCqlcG2E49+m8qs77zZFZPdol
 omHx+6S0STLONkKNCH0lrZudQsafnvCwipNwuDbZY+PZHDkmCOBtS7qwJOo1/RQr
 MGDhDvgCLLT8ZrgU+ZPSt5GyUEJ3mkSOatTuHYdLupGVWaPzQ1e3IxzRYhMD9HLK
 iVpqyMDHO/I4KkgWl7l/ekwjUFjn8Vxp9V1YeU0Wd86smhcp/MxPmpqYMFln5gMS
 P8X+IzGiJbj91YoChR2qWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730456269; x=
 1730542669; bh=n7nXeDgB4StCvrOsF3kD+lrkSkisJnObEGeXylfjRjM=; b=C
 66uFMDH9Zdj7XHVzlnH7OrGsFXKBy9NWXgeX3nTybY5+//wK3t3OqayFalvBUapx
 ZclwMzgs9ktZXMCB6CTGllIkZPJAlYnCejz91zhdw08vlyd6n6w5L0DDkgVv+Y/d
 NZBRvo/Ft3dkCGlAQpi6T4wOacQrwah1OoHDvhMCz9KPgnunK1imGsHMkRFDTegT
 /a77pVluI6YGIIqzEp44pIuNPRr6/Y5HTNASfHmoqSCCJwNMSOeM4hni3g7HE96q
 u7n994H1KiRP7hnjq42fElQrRuBVlI1/fVS9llEzrdPDztAbzOl6gMYbFq0G4IiR
 DzJNwyxgCBIFvfgUbKcAQ==
X-ME-Sender: <xms:zaokZyRorenbf7k6Fx4uPZLhsqwkeS3zNVLt3dbbJwYXcAr3vB9u5w>
 <xme:zaokZ3zLi8vY0QUqhjXIuo892yXG0mOjkkg5t3o6MfW6s3_hVKOvi0uGXL9C546Vs
 rJQOCfEiRYdpKslg4I>
X-ME-Received: <xmr:zaokZ_1jB1lTOsN5G8oTVBtHNxNiIeyyU3ivjWwQOEGOf4AR855nlbJdreB9nW0CB_HXED-zNEs6dv_WzppdkOBw8l2WPfppM1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeehheeileduffehteeihfdvtdelffdutdeludduiedutedv
 feffheekhefgtedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprh
 gtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehs
 uhhghhhoshhhrdhgrghnuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhjghestg
 hhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghn
 gidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:zaokZ-BMGmSxzCXnj8OdWS1gPqBJsaquWImk8LwlICfC-CJru6TdQw>
 <xmx:zaokZ7i_B5uaMdGdQtgqx_iqpmU_Z-wL1Wb7hknl4y3Tgm8UVe0hNA>
 <xmx:zaokZ6qNEscguET4UpRrENebV3x47VHbjQFGmwMHvminWp2Kp8mPBA>
 <xmx:zaokZ-ieguWLB6mCl_DhEarFQAbHUCFZ8BetgBboAz8qfusMjIJmkg>
 <xmx:zaokZ2UelQvjKsarw8lmGfSVupCAVS6cr9pY9h4_BFElT3Uuxga-CPSf>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 06:17:49 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 01 Nov 2024 11:15:54 +0100
Subject: [PATCH 4/4] iommu: apple: Manage IOVA separately from global LMB
 mem map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-io_lmb_apple_dart_iommu-v1-4-fe4b9a74d47c@jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2529; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=X2rDQ9k2ydrN8XT+JFpIiZ5Z3OUNrHNd6cW3kN3mx1w=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVVeFCCvkVJ2SCL6bc+bdVcWt++oezyzQXRTIKyx5MM
 e3P/fCpo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwERmOjEy9G0+lJiVulv4Zbnm
 hamfgw7NVjhuv1lsQX7jC/eV27JstRgZ7knZ533yOL6pX2l/7rrHcluT1fov3J0eqtphZZ0WU63
 HAAA=
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
 drivers/iommu/apple_dart.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 611ac7cd6deb4fccd45ccfe8cbb9b3e36e2af753..dfcc85c123441d6291d75898675fce7c1a9dfcc7 100644
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

-- 
2.47.0

