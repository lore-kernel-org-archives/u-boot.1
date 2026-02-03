Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE1BE8B37E
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7993A83B55;
	Wed,  4 Feb 2026 01:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nMNduJdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF1A83B85; Wed,  4 Feb 2026 01:30:16 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589DD83B03
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f5Lpr38gdz9tN7;
 Wed,  4 Feb 2026 01:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770165012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLlMTc4aoMQW3MCRY1gGUjTPtonw5fnfeAuq8FiyCcI=;
 b=nMNduJdduf3FV0IYGwM5DSt/L3Eh8ujl7CdocHXkOmEzra4fc4/y5JD+HXkGbVuBCk3tx6
 4/Heu2S//SbRD8ofPYB38Rx84HQvqYFea6/D/i1oCviHf2XjVpefh9f1VEr9u+Qo2Lt53+
 S4UumD2U4fI3BKvd6e9837qK+pzBwu1ek6bzTOzrhyz1Qbzkx3aMhU8Sm7CMPhElzUgpKd
 J9Ezhesy36I1zRZT2C0LICDzwv4KkGTSviLiH8yNlsRwyCqAQ+miRQfqAFC50mq3vdCcTI
 Bzsb1uBRD0sHpVyBrvTW2KbGpYKJv98+e7gc6nTvnpUy59xdJOCgl11bpUMclg==
Message-ID: <c59d8903-780a-42b1-b69e-b0227cb91380@mailbox.org>
Date: Tue, 3 Feb 2026 23:49:29 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d578ba21-bf07-4c3c-9e76-567f91ccab15@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6a3b995bd4340c978b5
X-MBO-RS-META: x6jjoj4794d1bjbpgww9ndn58cajrb9c
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

On 1/30/26 11:54 AM, Jonas Karlman wrote:

Hello Jonas,

>>> Change to use a fixed URB buffer size of 16 KiB to fix use of Ethernet,
>>
>> Why 16 kiB and not something else ?
> 
> Using anything larger than 16 KiB resulted in issues, and a datasheet
> for the older AX88772 prior to the D revision mention default 16 KiB for
> "Maximum Frame Burst transfer on USB bus" so 16 KiB seemed like a safe
> size to use for newer revisions, and this also made it possible to use
> fragmented packets up to just below 16 KiB.

Please include this information in the commit message.

>> Is this a USB controller related problem/limitation ? Maybe the DWC2
>> driver needs fixing instead, to handler larger buffers ?
> 
> I accidentally mixed up what host controller was being used, the board in
> question is using a generic-echi controller not the DWC2 as I stated.
> 
> Below follow some debug prints, what can be observed is that when
> length=26624 is returned from ehci_submit_bulk_msg the ax88179_eth_recv
> will return len >16 KiB and that result in the rx_hdr at the end of
> the returned buffer being bogus data, e.g. for following:
> 
>    BOOTP broadcast 1
>    ** asix_send_common(), len 342
>    ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
>    dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=350, req=0000000000000000
>    TOKEN=0x80008c00
>    Tx: len = 346, actual = 350, err = 0
> 
>    ax88179_eth_recv: first try, len=0
>    ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
>    dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
>    TOKEN=0xa7808d00
>    ax88179_eth_recv: second try, len=16512
>    ax88179_eth_recv: 2 packets received, pkt header at 112
>    ax88179_eth_recv: return packet of 106 bytes (1 packets left)
>    ax88179_eth_recv: return packet of 0 bytes (0 packets left)
> 
> The buffers returned from the AX88179 contains something like:
> 
>   <packet data N><N+1>... <packet header N><N+1>... <RX HDR>
> 
> Above the "2 packets received, pkt header at 112" seem to indicate that
> the pkt header is in the middle of the packet data, in other instances
> the rx_hdr seem to indicate that the buffer contains  thousands of
> packets, i.e. the rx_hdr is likely bogus when more than 16 KiB is
> returned from ehci_submit_bulk_msg.
Is this maybe some wrap-around ? 16 kiB x4 is 65536 , which is 16bit limit.
