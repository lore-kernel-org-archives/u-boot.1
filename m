Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DDBE8B37E
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF66683BC8;
	Wed,  4 Feb 2026 01:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lU7HhTeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2D183C2B; Wed,  4 Feb 2026 01:30:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160EE83BC7
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f5Lpx1qm5z9vDJ;
 Wed,  4 Feb 2026 01:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770165017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQKraj2XGoPzFqwQ5lb/614lQEeJUJPYKsc0ZXQtxIA=;
 b=lU7HhTeNmw3nn/5m1VGOUFSvobVjZSFfjvosQv1tc8NMZXkLy4l7Tw3z6raFJEPYCk8Fn8
 in3I5WrVZ93v6zcc5df9NfFc68Ynx2WKHd0qOVJ+jEEyURufcKTle+SE2sLnZZwK3HeobJ
 Diesn3ye7k4mmrO1Jr3ESkM7qgDF88JIAtanNYDA292HlouzR20ZFAEPXyHhPn0plUDeKR
 kV9bpDb/wG7uMuvbmrFmRnY7PF4fNGoMA/22BlFB0Tf+Wzj+voVPf5In1HwdRnJxiIJuOT
 HyCTemJv9nfxlsiE/6CwftCkLM5CwUbaT2MKotJXXn+P6pgdQa+hnkRxqXbaBA==
Message-ID: <4797613a-bc0d-494c-a272-8e1db9fef415@mailbox.org>
Date: Wed, 4 Feb 2026 00:24:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] usb: eth: asix88179: Use a fixed URB buffer size of
 16 KiB
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Khoa Hoang <admin@khoahoang.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-3-jonas@kwiboo.se>
 <b251561f-936f-44be-bd01-eb1d08c0bdfc@mailbox.org>
 <d578ba21-bf07-4c3c-9e76-567f91ccab15@kwiboo.se>
 <050276da-4483-45cf-8252-c5cb2cea44e5@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <050276da-4483-45cf-8252-c5cb2cea44e5@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d59e24e3466c3a1ec83
X-MBO-RS-META: cwdreh5b1wsqmr3xbywo7ed4iioekw6g
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

On 1/30/26 9:13 PM, Jonas Karlman wrote:

Hello Jonas,

>>> Is this a USB controller related problem/limitation ? Maybe the DWC2
>>> driver needs fixing instead, to handler larger buffers ?
>>
>> I accidentally mixed up what host controller was being used, the board in
>> question is using a generic-echi controller not the DWC2 as I stated.
> 
> I dove deeper

Thank you for doing that.

> and it looks like there could be an issue with ehci-hcd
> and handling of short packets, see below debug print that dumps the qTD
> and where it can be seen that the first packet is short and using the
> xfr_bytes - totalbytes of the first qTD with a short packet fixes my
> issue.
> 
>    BOOTP broadcast 4
>    ** asix_send_common(), len 342
>    ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2d520
>    dev=00000000f9f2d520, pipe=c0018303, buffer=00000000f9ee13c0, length=350, req=0000000000000000
>    QH: next=0x1, alt=0x11, token=0x8c00, totalbytes=0, xfr_bytes=0
>    qTD[0]: next=0x1, alt=0x1, token=0x8c00, totalbytes=0, xfr_bytes=350
>    TOKEN=0x8c00
>    Tx: len = 346, actual = 350, err = 0
> 
>    ax88179_eth_recv: first try, len=0
>    ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2d520
>    dev=00000000f9f2d520, pipe=c0010383, buffer=00000000f9f2df00, length=26624, req=0000000000000000
>    QH: next=0x1, alt=0x11, token=0xa7808d00, totalbytes=10112
>    qTD[0]: next=0xf9f2a140, alt=0x1, token=0xbe989d00, totalbytes=16024, xfr_bytes=16384 <<-- SHORT
>    qTD[1]: next=0x1, alt=0x1, token=0xa7808d00, totalbytes=10112, xfr_bytes=10240 <<-- SHORT
>    TOKEN=0xa7808d00
>    ax88179_eth_recv: second try, len=16512
>    ax88179_eth_recv: 2 packets received, pkt header at 112
>    ax88179_eth_recv: return packet of 0 bytes (1 packets left)
>    ax88179_eth_recv: return packet of 0 bytes (0 packets left)
> 
>    ax88179_eth_recv: first try, len=0
>    ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2d520
>    dev=00000000f9f2d520, pipe=c0010383, buffer=00000000f9f2df00, length=26624, req=0000000000000000
>    QH: next=0x1, alt=0x11, token=0x27a08d00, totalbytes=10144
>    qTD[0]: next=0xf9f2a140, alt=0x1, token=0x3e889d00, totalbytes=16008, xfr_bytes=16384 <<-- SHORT
>    qTD[1]: next=0x1, alt=0x1, token=0x27a08d00, totalbytes=10144, xfr_bytes=10240 <<-- SHORT
>    TOKEN=0x27a08d00
>    ax88179_eth_recv: second try, len=16480
>    ax88179_eth_recv: 2 packets received, pkt header at 80
>    ax88179_eth_recv: return packet of 5429 bytes (1 packets left)
>    ax88179_eth_recv: return packet of 4149 bytes (0 packets left)

Could you please share the printing diff ?

Maybe I am missing something, but the transfers above are longer than 20 
kiB ? Also, how does the printout look _after_ the change below was 
applied ?

> The diff below seem to solve my issue even better, aligns the ehci
> transfers to only use one qTD with a 20kb buffer for optimal performance.
> 
> But that is probably still not a good solution, ehci-hcd should probably
> gain proper support for short packet handling and usb_ether_register()
> could start using a 4kb aligned rxbuf to make sure 20kb transfers instead
> of 16kb transfers are used for ehci controllers.
> 
> 
> Maybe I should just drop this patch and address your feedback on
> remaining patches for v2?

Maybe at least a subset of these patches can be picked that way, yes.

> diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> index 69d3073b669a..a04952b5eb74 100644
> --- a/drivers/usb/eth/asix88179.c
> +++ b/drivers/usb/eth/asix88179.c
> @@ -475,7 +475,6 @@ static int asix_init_common(struct ueth_data *dev,
>   	/* RX bulk configuration */
>   	asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
>   
> -	dev_priv->rx_urb_size = (1024 * (tmp[3] + 2));
>   	if (*tmp16 & GMII_PHY_PHYSR_FULL)
>   		mode |= AX_MEDIUM_FULL_DUPLEX;
>   	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> diff --git a/drivers/usb/eth/usb_ether.c b/drivers/usb/eth/usb_ether.c
> index 8bba3e0974e6..02c93b40dd3e 100644
> --- a/drivers/usb/eth/usb_ether.c
> +++ b/drivers/usb/eth/usb_ether.c
> @@ -72,7 +72,7 @@ int usb_ether_register(struct udevice *dev, struct ueth_data *ueth, int rxsize)
>   	}
>   
>   	ueth->rxsize = rxsize;
> -	ueth->rxbuf = memalign(ARCH_DMA_MINALIGN, rxsize);
> +	ueth->rxbuf = memalign(4096, rxsize);

What is your current ARCH_DMA_MINALIGN ?
