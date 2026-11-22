Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05213606A330
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O7JP+SDX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=WDdYl0wT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B608680E2D;
	Sun, 22 Nov 2026 08:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7MwmSfwF5io; Sun, 22 Nov 2026 08:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7BA0580E35
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795335109;
	b=QlVnoaBvnal91rOk96Cv01JVHGC0jMBgxMkXeD8LaYqS/rCnPHM0emen4Xa8sz+78ob6
	 R1SBCvYfDiYOrJbMbF0XF4u2Y/23KT1l2/PVWKCMANZfP2do2QWJ88XjSSQ9Ds34J0VoG
	 tQzHUFfrqzMcJupE6jrP5edwe6Q1zdFqghCywt0dHPlaubNkUxHFdy5o3EeS0O1Gx5E3T
	 +5+pC+pJbDmg3rcd//a2CEqymMFugeV3zS0ZyDl9SBWTnZkAJZsj9UkCG2//by6aZbhyG
	 yrjct/AcAcCvaB7WVhk+HvxwkqvDIzbCaRqGAqr13RntFGdIDLP2YnC0Ys6dkMHJTNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795335109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gATTT7zQx4lED79g/E22Nx9SMdcC8qbsbCsa+R3UVUQ=;
	b=QkNFu23S0uDAtLAXy13C1KBzuPx7XP5vWmcXhG5HH41/lUKVfUQhMZ43OU8SsOxtRoXN
	 dmjKMdQtS7WuF/hdBxcu2aa3aKo18BcNl/mIVF5KS/zEKzjfIq7tgnroXc2e1s91Qzym2
	 C3E+nOpUqQW6GBLDTpO8zeH4EQ9sCnaUa1VzYx5FN8JS+az+R2pFG4sztLZDGojhxCy43
	 VLwabh09idu1/n7PPel9b767Ch9m+m9pZYeraVf6FOnssU7/+F5i3hps8ltR8EaC2EwNM
	 Rk7O4RrGDEP3onmeYlt5DIas4F9HPVq5BOErnotuTrB+/+DzdrPhlimfsL40zV82MDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=WDdYl0wT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795335109;
	bh=gATTT7zQx4lED79g/E22Nx9SMdcC8qbsbCsa+R3UVUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O7JP+SDX+RItARZuFUmuhvhviOXjM1LMP1a+wchyY5Ot4qUL/OB3HmbVHQ52kVvHc
	 P/baJIqqDnzcW+BybqSI38q2UtFmDQZRPWV2vguVpCha5zxv8LNYi7KE1hLbKEAafZ
	 TnoGhAuUpLegeFIEYLbSuiYQ2/EfcEsNxhcJ2ahKTsB1kqShYzBQuTrKNYG/AnOwDw
	 hVVbZLoVa05X89N2aiKGXWLB9HxnZHsyKdV8XLoku2VcK8G93cYWKhVcxn1gCLeJq3
	 uIsjy6nKhMUVMzuru3S63JFLGXDSK50mWjcPN+BaGkGp03+R2rf6qSnuKQz5f4dhbs
	 97NE08K6tbXdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BA0580E35;
	Sun, 22 Nov 2026 08:11:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCBFF759
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 08:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A24B280E35
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 08:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5j3Q51XuFQOS for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 08:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C34D80E2D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.54
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.54;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=WDdYl0wT
Received: from sender5-op-o15.zoho.com (sender5-of-o54.zoho.com
 [165.173.182.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C34D80E2D
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 08:11:45 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=WDdYl0wTj3R9tiC5qmhXkLutX3bvEVGWbZSWftaJvTdoVNBBv8QXXNYLsjx0hpqBsniSmgfXT/WFQxpUNzbXti8u42ZKIbTqPIzwb1W6UAEpol28MB8gHvQxhOWGUitF4sYYXtdFy6qyKbEt5644aiX3rk+/7m3Mpb0lCBZScTk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=gATTT7zQx4lED79g/E22Nx9SMdcC8qbsbCsa+R3UVUQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795335081737212.6650543715723;
 Sun, 22 Nov 2026 00:11:21 -0800 (PST)
Date: Sun, 22 Nov 2026 08:10:15 +0000
From: Yao Zi <me@ziyao.cc>
To: Zixian Zeng <sycamoremoon376@gmail.com>, Yao Zi <me@ziyao.cc>,
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
 Dave Klotz <DaveWK225@protonmail.com>
Subject: Re: [PATCH v3 1/2] net: spacemit: k1: add Ethernet MAC driver
Message-ID: <awKjZ70AfaHI0-ky@pie>
References: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
 <20261120-b4-k1-emac-v3-1-120679f97b45@gmail.com>
 <awB7rFETr-jVP5_b@pie>
 <724e1af0-d163-412d-8f23-d019fb6f7ced@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <724e1af0-d163-412d-8f23-d019fb6f7ced@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.322.99
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 02:23:56PM +0800, Zixian Zeng wrote:
> Hi, Yao Zi,
> 
> Thank you for the detailed review and the follow-up clarifications. I
> went through both replies against the RISC-V CMO and RVWMO specifications,
> the U-Boot cache/MMIO implementations, and the Linux K1 driver used as the
> reference for this port.
> 
> On 2026/11/21 00:56, Yao Zi wrote:
> > On Fri, Nov 20, 2026 at 02:35:56PM +0800, Zixian Zeng wrote:
> > > Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
> > > supports RGMII and RMII interfaces, synchronous transmission, and exposes
> > > the integrated MDIO controller through the MDIO uclass.
> > > 
> > > The register definitions, descriptor layout, MDIO protocol, RGMII delay
> > > line handling and hardware initialisation sequences are derived from the
> > > mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).
> > > 
> > > Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
> > > Tested-by: Dave Klotz <DaveWK225@protonmail.com>
> > > Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
> > > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > > ---
> > >   drivers/net/Kconfig            |   1 +
> > >   drivers/net/Makefile           |   1 +
> > >   drivers/net/spacemit/Kconfig   |  14 +
> > >   drivers/net/spacemit/Makefile  |   3 +
> > >   drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
> > >   5 files changed, 976 insertions(+)

[...]

> > > +static void k1_emac_prepare_rx(struct k1_emac_priv *priv, unsigned int index)
> > > +{
> > > +	struct k1_emac_desc *desc = k1_desc_at(priv->rx_desc, index);
> > > +	u8 *buffer = k1_rx_buf_at(priv, index);
> > > +
> > > +	k1_buffer_flush(buffer);
> > 
> > Does flushing the RX buffer really make a difference on the hardware's
> > behavior?
> 
> The purpose is to prevent dirty CPU cache lines from a previous use from
> being written back over a later DMA receive.
> 
> The buffer is passed directly to the U-Boot network stack before
> free_pkt(). In particular, ping_receive() modifies the received Ethernet,
> IP and ICMP headers in place when answering an ICMP echo request, before
> copying the reply to a TX buffer. Consequently, an RX buffer can contain
> dirty cache lines when it is recycled.
> 
> If cache maintenance is omitted before returning the buffer,
> the following sequence of events may occur:
> 
> 1. The CPU modifies an old packet A, leaving the updated content A′ in a "dirty" cache line.
> 2. The driver hands the buffer over to the DMA, which then writes a new packet B into memory.
> 3. The CPU’s dirty cache line is subsequently evicted, causing A′ to be written back to the same memory location.
> 4. Part of the new packet B is overwritten.

Oh, this makes sense. Please replace flush with a clean though.

> The Linux RISC-V DMA implementation at the reference commit also performs
> a clean for DMA_FROM_DEVICE before device ownership, followed by an
> invalidate when ownership returns to the CPU. The Linux K1 driver's
> dma_map_single(..., DMA_FROM_DEVICE) provides that preparation implicitly.
> 
> I therefore plan to retain the pre-DMA buffer maintenance and add a short
> comment explaining the dirty-line case. The current flush supplies the
> required clean as well as invalidation.
> 
> > > +	desc->control = FIELD_PREP(K1_RX_DESC_BUFFER_SIZE, K1_DMA_BUF_SIZE);
> > > +	if (index == K1_RX_DESC_COUNT - 1)
> > > +		desc->control |= K1_RX_DESC_END_RING;
> > > +	desc->buffer_addr1 = priv->rx_buf_dma[index];
> > > +	desc->buffer_addr2 = 0;
> > > +	desc->status = K1_RX_DESC_OWN;
> > > +}
> > > +
> > > +static void k1_emac_advance_rx(struct k1_emac_priv *priv)
> > > +{
> > > +	unsigned int index = priv->rx_index;
> > > +	unsigned int first;
> > > +
> > > +	/*
> > > +	 * Multiple 16-byte descriptors share a cache line. Do not clean that
> > > +	 * line while DMA may still be updating another descriptor in it. Return
> > > +	 * descriptors to DMA only after the complete cache-line-sized group has
> > > +	 * been consumed.
> > > +	 */
> > > +	if (!((index + 1) % K1_DESCS_PER_CACHELINE)) {
> > > +		first = index + 1 - K1_DESCS_PER_CACHELINE;
> > > +		for (; first <= index; first++)
> > > +			k1_emac_prepare_rx(priv, first);
> > > +
> > > +		/* Complete descriptor stores before cleaning the cache line. */
> > > +		mb();
> > > +		k1_desc_flush(k1_desc_at(priv->rx_desc, index));
> > > +		writel(1, priv->base + K1_DMA_RX_POLL_DEMAND);
> > > +	}
> > > +
> > > +	priv->rx_index = (index + 1) % K1_RX_DESC_COUNT;
> > > +}

[...]

> > > +static int k1_emac_send(struct udevice *dev, void *packet, int length)
> > > +{
> > > +	struct k1_emac_priv *priv = dev_get_priv(dev);
> > > +	unsigned int index = priv->tx_index;
> > > +	struct k1_emac_desc *desc = k1_desc_at(priv->tx_desc, index);
> > > +	u8 *buffer = k1_tx_buf_at(priv, index);
> > > +	ulong start;
> > > +
> > > +	if (length <= 0 || length > K1_DMA_BUF_SIZE)
> > > +		return -EMSGSIZE;
> > > +
> > > +	k1_desc_invalidate(desc);
> > > +	if (desc->status & K1_TX_DESC_OWN)
> > > +		return -EBUSY;
> > > +
> > > +	memcpy(buffer, packet, length);
> > > +	flush_dcache_range((ulong)buffer,
> > > +			   ALIGN((ulong)buffer + length, ARCH_DMA_MINALIGN));
> > > +
> > > +	/* Clear stale state before handing the descriptor to DMA. */
> > > +	writel(K1_DMA_STATUS_TX_DESC_UNAVAILABLE, priv->base + K1_DMA_STATUS);
> > > +	/* Complete the W1C write before asking the DMA engine to resume. */
> > > +	readl(priv->base + K1_DMA_STATUS);
> > > +
> > > +	desc->buffer_addr1 = priv->tx_buf_dma[index];
> > > +	desc->buffer_addr2 = 0;
> > > +	desc->control = FIELD_PREP(K1_TX_DESC_BUFFER_SIZE, length) |
> > > +			K1_TX_DESC_FIRST | K1_TX_DESC_LAST;
> > > +	if (index == K1_TX_DESC_COUNT - 1)
> > > +		desc->control |= K1_TX_DESC_END_RING;
> > > +	desc->status = K1_TX_DESC_OWN;
> > > +	/* Complete descriptor stores before cleaning its cache line. */
> > > +	mb();
> > 
> > Probably redundant barrier since RISC-V guarantees order between
> > overlapping stores...
> 
> Thank you for supplying the precise PPO rule in your follow-up. I agree
> that the descriptor stores and their overlapping flush do not themselves
> require an intervening barrier.
> 
> But after I checked linux k1-emac source code and documents,
> I noticed another similar thing which has different purpose:
> Links:
> https://docs.kernel.org/core-api/dma-api-howto.html#types-of-dma-mappings
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/spacemit/k1_emac.c?h=v7.4-rc3#n917

Did you quote the wrong line? This link points to emac_change_mtu().
I assume you're referring to the dma_wmb() at line 790.

The dma_wmb() in the Linux driver serves for different purpose. On Linux
side, a new packet could be queued at any time, even the DMA engine is
still working and probably accessing the ring, so it's importatnt to
ensure TX_DESC_OWN could only be observed by the engine after other
fields in the descriptor has been set up.

But for U-Boot, the situation seems different. Packet are transmitted
strictly one by one, and since you disable the AUTOPOLL feature and
poll for the DMA engine to stop (K1_DMA_STATUS_TX_DESC_UNAVAILABLE) when
transmitting, the engine is always stopped, never polling the descriptor
ring during setup of the descriptor, until a write to
K1_DMA_TX_POLL_DEMAND wakes it up.

Since K1_DMA_TX_POLL_DEMAND is written with writel(), which ensures
the descriptor setup (including K1_TX_DESC_OWN bit) becomes visible to
the EMAC before waking the engine up, this shouldn't cause any problems.

> Be a bit more conservative, I prepare move it before the OWN store
> to order the other descriptor fields before publishing ownership to DMA.
> just as what drivers/net/dwc_eth_qos.c +1121 did

The case in K1's EMAC and dwc_eth_qos.c are different. It seems
dwc_eth_qos' DMA engine keeps polling the ring when no descriptor is
available, while in which case K1's stops.

> > > +	k1_desc_flush(desc);
> > > +	writel(1, priv->base + K1_DMA_TX_POLL_DEMAND);
> > > +
> > > +	start = get_timer(0);
> > > +	do {
> > 
> > The could would be simpler if you use a loop simply bounded by retry
> > counts.
> 
> A retry-bounded loop would work if the intended limit is a number of
> attempts. However, I prefer to retain an elapsed-time timeout here, thanks.

Why? The code would look simpler with the change, like

	for (; retry < K1_TX_TIMEOUT_MS / 10; retry++) {
		/* ... */
		udelay(10);
	}

> > > +		k1_desc_invalidate(desc);
> > > +		/*
> > > +		 * OWN is cleared before transmission finishes. Descriptor
> > > +		 * unavailable is raised after DMA completes the packet and moves
> > > +		 * to the next CPU-owned descriptor.
> > > +		 */
> > > +		if (!(desc->status & K1_TX_DESC_OWN) &&
> > > +		    (readl(priv->base + K1_DMA_STATUS) &
> > > +		     K1_DMA_STATUS_TX_DESC_UNAVAILABLE)) {
> > > +			priv->tx_index = (index + 1) % K1_TX_DESC_COUNT;
> > > +			return 0;
> > > +		}
> > > +		udelay(10);
> > > +	} while (get_timer(start) <= K1_TX_TIMEOUT_MS);

[...]

> Best regards,
> Zixian

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
