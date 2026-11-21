Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996D606A331
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uXF1yv/+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=JEGaE+kX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5123D60698;
	Sat, 21 Nov 2026 18:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDRU7zTDJeU2; Sat, 21 Nov 2026 18:32:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5166B60642
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795285934;
	b=D8LRV+h6DOkID5n4GOhCxq0UEJAxv2dwk1B36G4Ivu7ZqGB+yP/39yJin97GzejAWKIZ
	 HrdnnpTP5E9ch5/VSYK8NGwcetJwsIBeIjXjRxijje2jtJCi5suWrDV3l1q9jTlTRRD2X
	 k70gqe0zlHM8VHZ9M5pcHAD6ayrw76uBKm5YjHy937eN/ZZBPP/megmVuJaxIe8D/WEjA
	 pSpcFkp1YQGNtvi+tuJsuyiqyJOq/NO1I7OWV643xYptaunKpI9vbG3SgKg+PhVNau+dL
	 VAR/pfBwf6eusPqtWnRgTWFmLm8LxMIaAigCc1+i8Q5JfpALp/7gm5p3oseRBmRqr6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795285934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xe7QfoZJqWtc14C8370Ipr7jjAC42kCMe4jZyl50DLo=;
	b=gaYmmi63uOtF0n1zmutPkzQTx98AdHCPw7XfEzYNReOF70g65HAT/dHrXrBN5rpOZQ77
	 2V+IHyS4opXmBFzUUzENj7/Rxg90Hqn8Tov3xI+zdm3SzlRTGY+F/wsJ1yrxfxaZ5Ine3
	 rR52HET16mqc3lhw3wdtuKQkBmH6m0p8Kky/lA3Uu21Hopsy8Vlorbq5COPEnb3j+VZ9d
	 IIUmfcGGvWFxchewfHsPx9RHs7x+3hThm6D0cqfODJdjoPUotHbDp5EjmEdvBFN7sAYyn
	 rcMLv/rXkvQGOqvW0nILe7RJ+HtwREvVJ2gZPEpmetO+PojiOMBSFGxYPXfWYs+cNnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795285934;
	bh=Xe7QfoZJqWtc14C8370Ipr7jjAC42kCMe4jZyl50DLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uXF1yv/+aE/E2j8jygzYUbZFmY/wzLdUgMPqI6RXdoMVe5F5E/rmmMLIOdisge7H0
	 lB6t/3/EEZkcehZgIT3qFLipHohJxW3VJ1zKxk22iMMXTU/r5UCq2cp7EtFHeN1o3y
	 tPRs4+yNcs3PYl6kWAXe6Qu90Q1LNfOeVQC9KARf43cxzVhx1Uw5NC88zmDv3KkrtI
	 fAnwTVGgWDTyhETk6zzgOFuKTb2nEs8OKoyiU0qxRii+2FlS11C3H7YxMwW9wvd015
	 yF/IEa+HOBeATwZMx3ttfGaWBjbLRwgD0WbtGi5ptkncAKCYlevSW8to+UnCRXmYIs
	 L+r8PSdnlxiNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5166B60642;
	Sat, 21 Nov 2026 18:32:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D271499
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8318780F40
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1_JaUs2Q8Qy for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 18:32:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52CA680EEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=JEGaE+kX
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52CA680EEF
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:32:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=JEGaE+kX3DG14NxLcFT4o/BEyKk8CsiK3jTPzrhkjj4bYcg4loL+ffFz7/68Y5wZOLc+Dih3qR7jzm5lben3Go12TRaZRbKru+pcDLHHUZ8dSzKHWEmBpZm+EHvJOhsIXA3DNed2Lt0Lts3WTzjFqUpI6vF1fNLzocdYOcv/5+k=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=Xe7QfoZJqWtc14C8370Ipr7jjAC42kCMe4jZyl50DLo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179528590383558.3376092221456;
 Sat, 21 Nov 2026 10:31:43 -0800 (PST)
Date: Sat, 21 Nov 2026 18:31:20 +0000
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
Message-ID: <awHjeCEz4XVJmLr_@pie>
References: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
 <20261120-b4-k1-emac-v3-1-120679f97b45@gmail.com>
 <awB7rFETr-jVP5_b@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awB7rFETr-jVP5_b@pie>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.275.14
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

On Fri, Nov 20, 2026 at 04:56:12PM +0000, Yao Zi wrote:
> On Fri, Nov 20, 2026 at 02:35:56PM +0800, Zixian Zeng wrote:
> > Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
> > supports RGMII and RMII interfaces, synchronous transmission, and exposes
> > the integrated MDIO controller through the MDIO uclass.
> > 
> > The register definitions, descriptor layout, MDIO protocol, RGMII delay
> > line handling and hardware initialisation sequences are derived from the
> > mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).
> > 
> > Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
> > Tested-by: Dave Klotz <DaveWK225@protonmail.com>
> > Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> >  drivers/net/Kconfig            |   1 +
> >  drivers/net/Makefile           |   1 +
> >  drivers/net/spacemit/Kconfig   |  14 +
> >  drivers/net/spacemit/Makefile  |   3 +
> >  drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 976 insertions(+)

[...]

> > +static int k1_emac_send(struct udevice *dev, void *packet, int length)
> > +{
> > +	struct k1_emac_priv *priv = dev_get_priv(dev);
> > +	unsigned int index = priv->tx_index;
> > +	struct k1_emac_desc *desc = k1_desc_at(priv->tx_desc, index);
> > +	u8 *buffer = k1_tx_buf_at(priv, index);
> > +	ulong start;
> > +
> > +	if (length <= 0 || length > K1_DMA_BUF_SIZE)
> > +		return -EMSGSIZE;
> > +
> > +	k1_desc_invalidate(desc);
> > +	if (desc->status & K1_TX_DESC_OWN)
> > +		return -EBUSY;
> > +
> > +	memcpy(buffer, packet, length);
> > +	flush_dcache_range((ulong)buffer,
> > +			   ALIGN((ulong)buffer + length, ARCH_DMA_MINALIGN));
> > +
> > +	/* Clear stale state before handing the descriptor to DMA. */
> > +	writel(K1_DMA_STATUS_TX_DESC_UNAVAILABLE, priv->base + K1_DMA_STATUS);
> > +	/* Complete the W1C write before asking the DMA engine to resume. */
> > +	readl(priv->base + K1_DMA_STATUS);
> > +
> > +	desc->buffer_addr1 = priv->tx_buf_dma[index];
> > +	desc->buffer_addr2 = 0;
> > +	desc->control = FIELD_PREP(K1_TX_DESC_BUFFER_SIZE, length) |
> > +			K1_TX_DESC_FIRST | K1_TX_DESC_LAST;
> > +	if (index == K1_TX_DESC_COUNT - 1)
> > +		desc->control |= K1_TX_DESC_END_RING;
> > +	desc->status = K1_TX_DESC_OWN;
> > +	/* Complete descriptor stores before cleaning its cache line. */
> > +	mb();
> 
> Probably redundant barrier since RISC-V guarantees order between
> overlapping stores...

I think I shouldn't review this in such a hurry. Quoting the
specification,

> For cache-block management instructions, the resulting invalidate,
> clean, and flush operations behave as stores in the PPO rules subject
> to one additional overlapping address rule.

Stores to the descriptor before the mb() overlap with the flush after
it, thus should be naturally ordered.

[...]

> > +static int k1_emac_recv(struct udevice *dev, int flags, uchar **packetp)
> > +{
> > +	struct k1_emac_priv *priv = dev_get_priv(dev);
> > +	struct k1_emac_desc *desc;
> > +	u32 status, length;
> > +	u8 *buffer;
> > +	unsigned int checked = 0;
> > +
> > +	if (priv->rx_pending)
> > +		return -EBUSY;
> > +
> > +	while (checked++ < K1_RX_DESC_COUNT) {
> > +		desc = k1_desc_at(priv->rx_desc, priv->rx_index);
> > +		k1_desc_invalidate(desc);
> > +		status = desc->status;
> > +		if (status & K1_RX_DESC_OWN)
> > +			return -EAGAIN;
> > +
> > +		length = FIELD_GET(K1_RX_DESC_FRAME_LEN, status);
> > +		if ((status & (K1_RX_DESC_FIRST | K1_RX_DESC_LAST)) ==
> > +		    (K1_RX_DESC_FIRST | K1_RX_DESC_LAST) &&
> > +		    !(status & K1_RX_DESC_ERRORS) && length > ETH_FCS_LEN &&
> > +		    length <= K1_DMA_BUF_SIZE) {
> > +			buffer = k1_rx_buf_at(priv, priv->rx_index);
> > +			k1_buffer_invalidate(buffer);
> > +			/* Complete invalidation before exposing the received frame. */
> > +			mb();
> 
> RISC-V guarantees that cache management operations couldn't be reordered
> with later stores,

Here's a typo, s/stores/loads/. Cache management operations indeed
couldn't be re-ordered with later overlapping stores, but here only
order between cache management operations and later loads matters, since
it's a RX buffer.

> > Specifically, if a precedes b in program order, then a will precede b
> > in the global memory order if:
> >	a is an invalidate, clean, or flush, b is a load, and a and b
> >	access overlapping memory addresses
> 
> Thus this mb() is redundant. Any access to buffer must be ordered after
> this invalidation.

This explanation is correct though.

[...]

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
