Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027B606A332
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jXM8oQ2y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=mz2PcIdV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38E5560776;
	Fri, 20 Nov 2026 16:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJkOPirKOPo3; Fri, 20 Nov 2026 16:57:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD4B36069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795193821;
	b=NQ8EFUYLqLXYLVpgt6Cn6qzj0f5/s49bAXBPKc/aB5lM+pK2qGNS7lUH8mYVzq92WIE9
	 5x3y+hSWY1ayw4UKf8lyN8GsRqnnafVClbg6F6MeZuhKeKym0CVcDWPCgGwnorZXdkpoT
	 zA/SpYw5SXndr7JiC4pPmeV+o7g3H+lMhpHcG936INHh+OmBIxN0K7y0+WRpSxba0j0zT
	 i/xYtIT1oNcRJejF7kdJE2ZoZoAYishLLy4skDLAVI8EnQ+Uk0vqrEP7re06L6JhN7PvH
	 PwVPpGcx/JYK4koM1eCiM+VrhLFZyMMWU/OeBU3SMWaOXoIqrOl3hvbe5co9WdH/48g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795193821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jCoHcTA4UeUApcWjTc0/4X0VNX1ckgIL+rbBH+zyG8Y=;
	b=b0mdh3dD/+swnane3E2XSCTyxHW3+4lzoCPp9k1aL7L9gohAqDssDOmd6y36dzCqvViE
	 wikwouS3/riqkgCXoMoe5295G/dqa4J/TMWTBVHuuUVxJW97ulL23pMK+y2YnGYaQxixF
	 ++WWrN8RgIcIojezb8qbi0gagbj54ELQRjW4aQAN52DEiJHhWB8SZjCubDw2/0wnXtnwh
	 rpQlPY2G6ZUlGxa8B1oJx5wVsFbyGnU2VdaQ9oiOzsSM9hSrcPPSuaI+lkIKpbsvAfG5q
	 Qg2jMxKuuqVj2J/XxT8f2EXIsXV6apb5WihjIBxnq7d/mr4BXCCb9T2Jtdbw7pzsetA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=mz2PcIdV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795193821;
	bh=jCoHcTA4UeUApcWjTc0/4X0VNX1ckgIL+rbBH+zyG8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXM8oQ2yydS2yJErWl5XjHu7MByhr1L+0wqfGddaz1E0eN3VmBnRR/J3KAl5hbTX/
	 ZLgcywOCC7jW9VEAGWUFtsu2mhucZWZ68ZMYKiEFLdWRJ921jSJNuRXgaN71fUo/ch
	 DTuW2eQyEs9eF6pky3FsaPyMBwlFiyARBtdbHr/Gm5NBCLL27o1JzOXGtbMjn2lmSI
	 RP8y3Hf0RAvFIw2wKDh7y8rakpOQvA8SLTVnCI5vTtDYjS0PW/fp+sTp+8pybYGTNw
	 ujPQ/RzJwMA7oDNOQHhdkgRXGLiHsc7wcFSDTRQs7/V6tNLvGzZsjMdHtnuypatxUS
	 LPjv4n3ycsTKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD4B36069A;
	Fri, 20 Nov 2026 16:57:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15AEC1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 079B36069A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dwKvg56o9RH for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89CBF60698
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=mz2PcIdV
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89CBF60698
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:56:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=mz2PcIdVunr6vKsrf5wPF4j+tz1GuxWACN42tJC8THcS+jrFPoA4NtWJShrzwGszVZSVbypgV7xzKJQyptP9BFCobIGmx9SjStOTvePzzP2yPU4h13KmbW0ro1MEkxqDeNvogt24vIhLAyEMzDmHEyom+PVX8fPHeJPGH4b5UEk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=jCoHcTA4UeUApcWjTc0/4X0VNX1ckgIL+rbBH+zyG8Y=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179519378846339.5724023861701;
 Fri, 20 Nov 2026 08:56:28 -0800 (PST)
Date: Fri, 20 Nov 2026 16:56:12 +0000
From: Yao Zi <me@ziyao.cc>
To: Zixian Zeng <sycamoremoon376@gmail.com>,
 u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, E Shattow <e@freeshell.de>,
 Dave Klotz <DaveWK225@protonmail.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 1/2] net: spacemit: k1: add Ethernet MAC driver
Message-ID: <awB7rFETr-jVP5_b@pie>
References: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
 <20261120-b4-k1-emac-v3-1-120679f97b45@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-b4-k1-emac-v3-1-120679f97b45@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.181.54
X-ZohoMailClient: External
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

On Fri, Nov 20, 2026 at 02:35:56PM +0800, Zixian Zeng wrote:
> Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
> supports RGMII and RMII interfaces, synchronous transmission, and exposes
> the integrated MDIO controller through the MDIO uclass.
> 
> The register definitions, descriptor layout, MDIO protocol, RGMII delay
> line handling and hardware initialisation sequences are derived from the
> mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).
> 
> Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
> Tested-by: Dave Klotz <DaveWK225@protonmail.com>
> Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  drivers/net/Kconfig            |   1 +
>  drivers/net/Makefile           |   1 +
>  drivers/net/spacemit/Kconfig   |  14 +
>  drivers/net/spacemit/Makefile  |   3 +
>  drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 976 insertions(+)

...

> diff --git a/drivers/net/spacemit/k1_emac.c b/drivers/net/spacemit/k1_emac.c
> new file mode 100644
> index 00000000000..67baaade97e
> --- /dev/null
> +++ b/drivers/net/spacemit/k1_emac.c
> @@ -0,0 +1,957 @@
> +	struct regmap *apmu;
> +	u32 apmu_offset;
> +	phy_interface_t interface;
> +	u32 max_speed;
> +	u32 tx_delay_code;
> +	u32 rx_delay_code;
> +	struct clk clk;
> +	struct reset_ctl reset;
> +	struct phy_device *phy;
> +	struct k1_emac_desc *tx_desc;
> +	struct k1_emac_desc *rx_desc;
> +	u8 *tx_buf;
> +	u8 *rx_buf;
> +	u32 tx_desc_dma;
> +	u32 rx_desc_dma;
> +	u32 tx_buf_dma[K1_TX_DESC_COUNT];
> +	u32 rx_buf_dma[K1_RX_DESC_COUNT];
> +	u32 tx_index;
> +	u32 rx_index;
> +	char mdio_name[MDIO_NAME_LEN];
> +	bool rx_pending;
> +	bool clk_enabled;
> +	bool reset_deasserted;
> +};
> +
> +static inline struct k1_emac_desc *k1_desc_at(struct k1_emac_desc *ring,
> +					      unsigned int index)
> +{
> +	return &ring[index];
> +}

Honestly saying, I don't think this function helps readability much,
please consider removing it.

> +static inline u8 *k1_rx_buf_at(struct k1_emac_priv *priv, unsigned int index)
> +{
> +	return priv->rx_buf + index * K1_DMA_BUF_SIZE;
> +}
> +
> +static inline u8 *k1_tx_buf_at(struct k1_emac_priv *priv, unsigned int index)
> +{
> +	return priv->tx_buf + index * K1_DMA_BUF_SIZE;
> +}
> +
> +static void k1_desc_flush(struct k1_emac_desc *desc)
> +{
> +	ulong start = ALIGN_DOWN((ulong)desc, ARCH_DMA_MINALIGN);
> +
> +	flush_dcache_range(start, start + ARCH_DMA_MINALIGN);
> +	/* Complete the clean before notifying the DMA engine. */
> +	mb();

I suspect this barrier is redundant. Per the RISC-V unprivileged
specification,

> Additionally, invalidate, clean, and flush operations are classified
> as W or O (depending on the physical memory attributes for the
> corresponding physical addresses) for the purposes of predecessor and
> successor sets in FENCE instructions.

So cache management operations should be naturally ordered with the
writel() to DMA_RX/TX_POLL_DEMAND, which carries an __iowmb(), i.e.,
fence ow, ow.

> +}
> +
> +static void k1_desc_invalidate(struct k1_emac_desc *desc)
> +{
> +	ulong start = ALIGN_DOWN((ulong)desc, ARCH_DMA_MINALIGN);
> +
> +	invalidate_dcache_range(start, start + ARCH_DMA_MINALIGN);
> +	/* Complete the invalidation before inspecting DMA-written fields. */
> +	mb();

So is this barrier.

> +}

[...]

> +static int k1_emac_dma32(struct udevice *dev, void *ptr, size_t size,
> +			 u32 *address)
> +{
> +	dma_addr_t dma = dev_phys_to_bus(dev, virt_to_phys(ptr));
> +
> +	/* Both the start and the last byte must fit the 32-bit window. */
> +	if (upper_32_bits(dma) || upper_32_bits(dma + size - 1)) {
> +		dev_err(dev, "DMA range %#llx-%#llx is outside the 32-bit window\n",
> +			(unsigned long long)dma,
> +			(unsigned long long)(dma + size - 1));
> +		return -ERANGE;
> +	}
> +
> +	*address = lower_32_bits(dma);
> +	return 0;
> +}

This is technically correct, but I doubt whether we should do such
carefully validation for each allocation...

I suggest selecting LMB_LIMIT_DMA_BELOW_RAW_TOP to make the DMA
capability limitation clear instead, but it depends on you.

[...]

> +static int k1_emac_hw_init(struct k1_emac_priv *priv)
> +{
> +	u32 config;
> +	int ret;
> +
> +	writel(0, priv->base + K1_MAC_INTERRUPT_ENABLE);
> +	writel(0, priv->base + K1_DMA_INTERRUPT_ENABLE);
> +	writel(0, priv->base + K1_MAC_RX_CONTROL);
> +	writel(0, priv->base + K1_MAC_TX_CONTROL);
> +	writel(0, priv->base + K1_DMA_CONTROL);
> +
> +	ret = regmap_update_bits(priv->apmu,
> +				 priv->apmu_offset + K1_APMU_EMAC_CTRL,
> +				 K1_APMU_AXI_SINGLE_ID, K1_APMU_AXI_SINGLE_ID);
> +	if (ret)
> +		return ret;

Since this syscon is backed by MMIO, I don't think there's any need to
check for errors returned by it. This applies for other places in the
patch, too.

[...]

> +static void k1_emac_prepare_rx(struct k1_emac_priv *priv, unsigned int index)
> +{
> +	struct k1_emac_desc *desc = k1_desc_at(priv->rx_desc, index);
> +	u8 *buffer = k1_rx_buf_at(priv, index);
> +
> +	k1_buffer_flush(buffer);

Does flushing the RX buffer really make a difference on the hardware's
behavior?

> +	desc->control = FIELD_PREP(K1_RX_DESC_BUFFER_SIZE, K1_DMA_BUF_SIZE);
> +	if (index == K1_RX_DESC_COUNT - 1)
> +		desc->control |= K1_RX_DESC_END_RING;
> +	desc->buffer_addr1 = priv->rx_buf_dma[index];
> +	desc->buffer_addr2 = 0;
> +	desc->status = K1_RX_DESC_OWN;
> +}
> +
> +static void k1_emac_advance_rx(struct k1_emac_priv *priv)
> +{
> +	unsigned int index = priv->rx_index;
> +	unsigned int first;
> +
> +	/*
> +	 * Multiple 16-byte descriptors share a cache line. Do not clean that
> +	 * line while DMA may still be updating another descriptor in it. Return
> +	 * descriptors to DMA only after the complete cache-line-sized group has
> +	 * been consumed.
> +	 */
> +	if (!((index + 1) % K1_DESCS_PER_CACHELINE)) {
> +		first = index + 1 - K1_DESCS_PER_CACHELINE;
> +		for (; first <= index; first++)
> +			k1_emac_prepare_rx(priv, first);
> +
> +		/* Complete descriptor stores before cleaning the cache line. */
> +		mb();
> +		k1_desc_flush(k1_desc_at(priv->rx_desc, index));
> +		writel(1, priv->base + K1_DMA_RX_POLL_DEMAND);
> +	}
> +
> +	priv->rx_index = (index + 1) % K1_RX_DESC_COUNT;
> +}
> +
> +static void k1_emac_init_rings(struct k1_emac_priv *priv)
> +{
> +	struct k1_emac_desc *desc;
> +	unsigned int i;
> +
> +	memset(priv->tx_desc, 0, K1_TX_DESC_ALLOC_SIZE);
> +	memset(priv->rx_desc, 0, K1_RX_DESC_ALLOC_SIZE);
> +	memset(priv->tx_buf, 0, K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
> +	memset(priv->rx_buf, 0, K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);
> +	flush_dcache_range((ulong)priv->tx_buf,
> +			   (ulong)priv->tx_buf +
> +			   K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
> +	flush_dcache_range((ulong)priv->rx_buf,
> +			   (ulong)priv->rx_buf + K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);

Like k1_emac_prepare_rx()'s case, are these two memset() and flushes
really useful? Does the initial buffer content visible to the NIC really
affect its behavior?

> +	for (i = 0; i < K1_TX_DESC_COUNT; i++) {
> +		desc = k1_desc_at(priv->tx_desc, i);
> +		if (i == K1_TX_DESC_COUNT - 1)
> +			desc->control = K1_TX_DESC_END_RING;
> +		desc->buffer_addr1 = priv->tx_buf_dma[i];
> +	}
> +	flush_dcache_range((ulong)priv->tx_desc,
> +			   (ulong)priv->tx_desc + K1_TX_DESC_ALLOC_SIZE);
> +
> +	for (i = 0; i < K1_RX_DESC_COUNT; i++)
> +		k1_emac_prepare_rx(priv, i);
> +	/* Complete all descriptor stores before handing the ring to DMA. */
> +	mb();
> +
> +	flush_dcache_range((ulong)priv->rx_desc,
> +			   (ulong)priv->rx_desc + K1_RX_DESC_ALLOC_SIZE);
> +	/* Complete the clean before programming the DMA descriptor base. */
> +	mb();

Are these two barriers() really necessary? At the point
where k1_emac_init_rings() is called from k1_emac_start(), we haven't
even set the ring addresses to the DMA engine. And setting so with
writel() implies a fence wo, wo barrier, so it's impossible for the
engine to observe the ring address before writes to the ring.

> +	priv->tx_index = 0;
> +	priv->rx_index = 0;
> +	priv->rx_pending = false;
> +}

[...]

> +static int k1_emac_send(struct udevice *dev, void *packet, int length)
> +{
> +	struct k1_emac_priv *priv = dev_get_priv(dev);
> +	unsigned int index = priv->tx_index;
> +	struct k1_emac_desc *desc = k1_desc_at(priv->tx_desc, index);
> +	u8 *buffer = k1_tx_buf_at(priv, index);
> +	ulong start;
> +
> +	if (length <= 0 || length > K1_DMA_BUF_SIZE)
> +		return -EMSGSIZE;
> +
> +	k1_desc_invalidate(desc);
> +	if (desc->status & K1_TX_DESC_OWN)
> +		return -EBUSY;
> +
> +	memcpy(buffer, packet, length);
> +	flush_dcache_range((ulong)buffer,
> +			   ALIGN((ulong)buffer + length, ARCH_DMA_MINALIGN));
> +
> +	/* Clear stale state before handing the descriptor to DMA. */
> +	writel(K1_DMA_STATUS_TX_DESC_UNAVAILABLE, priv->base + K1_DMA_STATUS);
> +	/* Complete the W1C write before asking the DMA engine to resume. */
> +	readl(priv->base + K1_DMA_STATUS);
> +
> +	desc->buffer_addr1 = priv->tx_buf_dma[index];
> +	desc->buffer_addr2 = 0;
> +	desc->control = FIELD_PREP(K1_TX_DESC_BUFFER_SIZE, length) |
> +			K1_TX_DESC_FIRST | K1_TX_DESC_LAST;
> +	if (index == K1_TX_DESC_COUNT - 1)
> +		desc->control |= K1_TX_DESC_END_RING;
> +	desc->status = K1_TX_DESC_OWN;
> +	/* Complete descriptor stores before cleaning its cache line. */
> +	mb();

Probably redundant barrier since RISC-V guarantees order between
overlapping stores...

> +	k1_desc_flush(desc);
> +	writel(1, priv->base + K1_DMA_TX_POLL_DEMAND);
> +
> +	start = get_timer(0);
> +	do {

The could would be simpler if you use a loop simply bounded by retry
counts.

> +		k1_desc_invalidate(desc);
> +		/*
> +		 * OWN is cleared before transmission finishes. Descriptor
> +		 * unavailable is raised after DMA completes the packet and moves
> +		 * to the next CPU-owned descriptor.
> +		 */
> +		if (!(desc->status & K1_TX_DESC_OWN) &&
> +		    (readl(priv->base + K1_DMA_STATUS) &
> +		     K1_DMA_STATUS_TX_DESC_UNAVAILABLE)) {
> +			priv->tx_index = (index + 1) % K1_TX_DESC_COUNT;
> +			return 0;
> +		}
> +		udelay(10);
> +	} while (get_timer(start) <= K1_TX_TIMEOUT_MS);

[...]

> +static int k1_emac_recv(struct udevice *dev, int flags, uchar **packetp)
> +{
> +	struct k1_emac_priv *priv = dev_get_priv(dev);
> +	struct k1_emac_desc *desc;
> +	u32 status, length;
> +	u8 *buffer;
> +	unsigned int checked = 0;
> +
> +	if (priv->rx_pending)
> +		return -EBUSY;
> +
> +	while (checked++ < K1_RX_DESC_COUNT) {
> +		desc = k1_desc_at(priv->rx_desc, priv->rx_index);
> +		k1_desc_invalidate(desc);
> +		status = desc->status;
> +		if (status & K1_RX_DESC_OWN)
> +			return -EAGAIN;
> +
> +		length = FIELD_GET(K1_RX_DESC_FRAME_LEN, status);
> +		if ((status & (K1_RX_DESC_FIRST | K1_RX_DESC_LAST)) ==
> +		    (K1_RX_DESC_FIRST | K1_RX_DESC_LAST) &&
> +		    !(status & K1_RX_DESC_ERRORS) && length > ETH_FCS_LEN &&
> +		    length <= K1_DMA_BUF_SIZE) {
> +			buffer = k1_rx_buf_at(priv, priv->rx_index);
> +			k1_buffer_invalidate(buffer);
> +			/* Complete invalidation before exposing the received frame. */
> +			mb();

RISC-V guarantees that cache management operations couldn't be reordered
with later stores,

> Specifically, if a precedes b in program order, then a will precede b
> in the global memory order if:
>	a is an invalidate, clean, or flush, b is a load, and a and b
>	access overlapping memory addresses

Thus this mb() is redundant. Any access to buffer must be ordered after
this invalidation.

[...]

> +static void k1_emac_stop(struct udevice *dev)
> +{
> +	struct k1_emac_priv *priv = dev_get_priv(dev);
> +
> +	writel(0, priv->base + K1_MAC_INTERRUPT_ENABLE);
> +	writel(0, priv->base + K1_DMA_INTERRUPT_ENABLE);

What's the point of resetting interrupt enable bits here? They have been
cleared in k1_emac_hw_init(), and I don't think there's anything turning
it back on automatically.

> +	writel(0, priv->base + K1_DMA_CONTROL);
> +	writel(0, priv->base + K1_MAC_RX_CONTROL);
> +	writel(0, priv->base + K1_MAC_TX_CONTROL);
> +	priv->rx_pending = false;
> +	phy_shutdown(priv->phy);
> +}

[...]

> +static int k1_emac_of_to_plat(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct k1_emac_priv *priv = dev_get_priv(dev);
> +	ofnode node;
> +	bool mdio_bound = false;
> +	int ret;
> +
> +	pdata->iobase = dev_read_addr(dev);
> +	if (pdata->iobase == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	pdata->phy_interface = dev_read_phy_mode(dev);
> +	switch (pdata->phy_interface) {
> +	case PHY_INTERFACE_MODE_RMII:
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		break;
> +	default:
> +		return -EINVAL;

Or -EOPNOTSUPP? I think this is more appropriate.

[...]

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
