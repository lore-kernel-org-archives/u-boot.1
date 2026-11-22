Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33190606A33C
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NzLzBt46;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=UJZ1vexL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09E336060E;
	Sun, 22 Nov 2026 17:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CzooS05jxp-0; Sun, 22 Nov 2026 17:11:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E72BE60608
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795367487;
	b=bDuw82OHv3gytCbcOIs7CsMwqiRDkttLhqAeuIS5HJcpmvXd5slAmb6QGpFVvT70S4Yx
	 m9mkNG4SwR4B7DPF3F1owK4kra2G7NWQzZQaQCd48GIwlkvilPrAJEAvwhufWT5r80FUt
	 u+UCsorussJmBTJ2zz9RlD8BOE5O+JSrgYvodvG0BDDhmw3kO34GENC0qF13wQwbuyVih
	 RbGWxAuphHAqurLVBZMES/21QE8mO6kvvukLu8Y1RJ6ZPsnZYxB0epI/9nUT0OLUPawms
	 riBudynSKXr2fCrnu4CxMdN9OB8L/OT9V0FNxwKMW2facO1IRxPS2UpD6OwkcTpIErQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+8Rmq/Pz9mXkOys2CNUxOfKQs0DltZe0Vip1mq3QiLo=;
	b=m/mhrVYRmTQ0mB5/NPAHt2fNMWnCAeMKS1omJ4Wropq0bGdCP31niN+ArGpXxXtFnVr5
	 72+B3SKvYHBVa3inaq5vtu7PpNunOCdDqaoW+lA2QVuFQesWIfuAfvj+LNR8FF3dHBDoY
	 1glFntgzP1vEzK420IkmsxxFllFHFHH3JiA7Xl8r4gyt15g0rgXBzxyCSsWJGdggFk4Qk
	 SGsoVlOXJPOub7tjYYud4pTQuLXP5cHmKn5R23MBB2hYGRnJUJa8BQx8cF5Rx89Izdly2
	 3+Mi1qlljCh3aOyrx4KUMbaIgVvMVNOu/6xogCwASaxYTq6H7UgiqCW+LKWOS5mLCyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795367487;
	bh=+8Rmq/Pz9mXkOys2CNUxOfKQs0DltZe0Vip1mq3QiLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NzLzBt46WouNzHpNwpXmTNn4U9fujJR5TbM5ZTLkrorOnyTjULc4KDysfTohrNJU5
	 mBV0Tpf0ERgWzt56nFh31Vx/aUoeJGRVAUBBIbxqVt4qZR8DlU46HIA+2jAuNEMbJT
	 vFN3cbJ36afxLfE3lvPFhddBE89dUGQIseSx9L1V5Jbt9K0inZrZIm4E089cSI9ER6
	 Dh/FdYfX+xdmRcqXfTvPdrVV7glKEn8auv5geJL04U2r+J2XOYUQNovOLnGP+2XMmZ
	 2gPPs0+SQ/h4sswvu5uao/7DxgXWKSYE0OBFyt74d0uu/Qn6/Mjz9fb/LEVf+k0u8z
	 XOedV8tLjkc+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E72BE60608;
	Sun, 22 Nov 2026 17:11:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DFB5260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 17:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53C8680D17
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 17:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6iJmYdvqxC0I for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 17:11:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ED0280D05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=UJZ1vexL
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1ED0280D05
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 17:11:23 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=UJZ1vexL/HQ0OsjfrQrfLod7FPqezdCqgSLrbtQiTpxdNpwkiSAJ0ajj76//dh/UpN42p59TtQCMDnRE8o72M5g3ZYeRAuBfKzFfnMn2IXKn3wQEIVVy7q6/LhykNo5JhMcFdVG52bvMQSgT1K/Y11x9Idncuv/+7AezmV47i4Q=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=+8Rmq/Pz9mXkOys2CNUxOfKQs0DltZe0Vip1mq3QiLo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795367456981367.1085007658331;
 Sun, 22 Nov 2026 09:10:56 -0800 (PST)
Date: Sun, 22 Nov 2026 17:10:44 +0000
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
Message-ID: <awMiFGmDtjhuZ9zx@pie>
References: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
 <20261120-b4-k1-emac-v3-1-120679f97b45@gmail.com>
 <awB7rFETr-jVP5_b@pie>
 <724e1af0-d163-412d-8f23-d019fb6f7ced@gmail.com>
 <awKjZ70AfaHI0-ky@pie>
 <3e0188b3-6191-4ebc-924e-e76807a11241@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e0188b3-6191-4ebc-924e-e76807a11241@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.348.19
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 08:37:30PM +0800, Zixian Zeng wrote:
> Hi Yao Zi,
> 
> On 2026/11/22 16:10, Yao Zi wrote:
> > On Sun, Nov 22, 2026 at 02:23:56PM +0800, Zixian Zeng wrote:
> > > Hi, Yao Zi,
> > > 
> > > Thank you for the detailed review and the follow-up clarifications. I
> > > went through both replies against the RISC-V CMO and RVWMO specifications,
> > > the U-Boot cache/MMIO implementations, and the Linux K1 driver used as the
> > > reference for this port.
> > > 
> > > On 2026/11/21 00:56, Yao Zi wrote:
> > > > On Fri, Nov 20, 2026 at 02:35:56PM +0800, Zixian Zeng wrote:
> > > > > Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
> > > > > supports RGMII and RMII interfaces, synchronous transmission, and exposes
> > > > > the integrated MDIO controller through the MDIO uclass.
> > > > > 
> > > > > The register definitions, descriptor layout, MDIO protocol, RGMII delay
> > > > > line handling and hardware initialisation sequences are derived from the
> > > > > mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).
> > > > > 
> > > > > Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
> > > > > Tested-by: Dave Klotz <DaveWK225@protonmail.com>
> > > > > Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
> > > > > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > > > > ---
> > > > >    drivers/net/Kconfig            |   1 +
> > > > >    drivers/net/Makefile           |   1 +
> > > > >    drivers/net/spacemit/Kconfig   |  14 +
> > > > >    drivers/net/spacemit/Makefile  |   3 +
> > > > >    drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
> > > > >    5 files changed, 976 insertions(+)
> > 
> > [...]
> > 
> > > > > +static void k1_emac_prepare_rx(struct k1_emac_priv *priv, unsigned int index)
> > > > > +{
> > > > > +	struct k1_emac_desc *desc = k1_desc_at(priv->rx_desc, index);
> > > > > +	u8 *buffer = k1_rx_buf_at(priv, index);
> > > > > +
> > > > > +	k1_buffer_flush(buffer);
> > > > 
> > > > Does flushing the RX buffer really make a difference on the hardware's
> > > > behavior?
> > > 
> > > The purpose is to prevent dirty CPU cache lines from a previous use from
> > > being written back over a later DMA receive.
> > > 
> > > The buffer is passed directly to the U-Boot network stack before
> > > free_pkt(). In particular, ping_receive() modifies the received Ethernet,
> > > IP and ICMP headers in place when answering an ICMP echo request, before
> > > copying the reply to a TX buffer. Consequently, an RX buffer can contain
> > > dirty cache lines when it is recycled.
> > > 
> > > If cache maintenance is omitted before returning the buffer,
> > > the following sequence of events may occur:
> > > 
> > > 1. The CPU modifies an old packet A, leaving the updated content A′ in a "dirty" cache line.
> > > 2. The driver hands the buffer over to the DMA, which then writes a new packet B into memory.
> > > 3. The CPU’s dirty cache line is subsequently evicted, causing A′ to be written back to the same memory location.
> > > 4. Part of the new packet B is overwritten.
> > 
> > Oh, this makes sense. Please replace flush with a clean though.
> 
> OK, do you mean using a clean-only cache operation here, or just renaming
> the helper from k1_buffer_flush() to k1_buffer_flush() to reflect its purpose?
> The current RISC-V implementation does not expose a public range clean API.

Oops, I didn't realize this when writing this comment. Then it's okay to
keep the code as-is, with a comment added to explain its purpose.

> > > The Linux RISC-V DMA implementation at the reference commit also performs
> > > a clean for DMA_FROM_DEVICE before device ownership, followed by an
> > > invalidate when ownership returns to the CPU. The Linux K1 driver's
> > > dma_map_single(..., DMA_FROM_DEVICE) provides that preparation implicitly.
> > > 
> > > I therefore plan to retain the pre-DMA buffer maintenance and add a short
> > > comment explaining the dirty-line case. The current flush supplies the
> > > required clean as well as invalidation.
> > > 
> > > > > +	desc->control = FIELD_PREP(K1_RX_DESC_BUFFER_SIZE, K1_DMA_BUF_SIZE);
> > > > > +	if (index == K1_RX_DESC_COUNT - 1)
> > > > > +		desc->control |= K1_RX_DESC_END_RING;
> > > > > +	desc->buffer_addr1 = priv->rx_buf_dma[index];
> > > > > +	desc->buffer_addr2 = 0;
> > > > > +	desc->status = K1_RX_DESC_OWN;
> > > > > +}

[...]

> > > > > +	k1_desc_flush(desc);
> > > > > +	writel(1, priv->base + K1_DMA_TX_POLL_DEMAND);
> > > > > +
> > > > > +	start = get_timer(0);
> > > > > +	do {
> > > > 
> > > > The could would be simpler if you use a loop simply bounded by retry
> > > > counts.
> > > 
> > > A retry-bounded loop would work if the intended limit is a number of
> > > attempts. However, I prefer to retain an elapsed-time timeout here, thanks.
> > 
> > Why? The code would look simpler with the change, like
> > 
> > 	for (; retry < K1_TX_TIMEOUT_MS / 10; retry++) {
> > 		/* ... */
> > 		udelay(10);
> > 	}
> 
> Just a preference :-) I will switch to a retry-bounded loop in next revision.
> With udelay(10), I will calculate the retry limit as K1_TX_TIMEOUT_MS * 1000 / 10,
> which converting ms to us.

Just FYI, we have USEC_PER_MSEC, which makes the code's purpose more
explicit.

> > > > > +		k1_desc_invalidate(desc);
> > > > > +		/*
> > > > > +		 * OWN is cleared before transmission finishes. Descriptor
> > > > > +		 * unavailable is raised after DMA completes the packet and moves
> > > > > +		 * to the next CPU-owned descriptor.
> > > > > +		 */
> > > > > +		if (!(desc->status & K1_TX_DESC_OWN) &&
> > > > > +		    (readl(priv->base + K1_DMA_STATUS) &
> > > > > +		     K1_DMA_STATUS_TX_DESC_UNAVAILABLE)) {
> > > > > +			priv->tx_index = (index + 1) % K1_TX_DESC_COUNT;
> > > > > +			return 0;
> > > > > +		}
> > > > > +		udelay(10);
> > > > > +	} while (get_timer(start) <= K1_TX_TIMEOUT_MS);
> > 
> > [...]
> > 
> 
> Best regards,
> Zixian
> 

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
