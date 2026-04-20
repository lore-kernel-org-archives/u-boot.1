Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82D3F5A8CE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8391E8431E;
	Tue, 21 Apr 2026 02:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SqGptAt1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d1TwRccn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DB384337; Tue, 21 Apr 2026 02:48:20 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71B784198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g03cc4FJtz9tpN;
 Tue, 21 Apr 2026 02:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoaSZbsAXynu8zEj6gnCSvekj6dTOsFpf5FtAlIffBw=;
 b=SqGptAt18degHwQSTUkg3pmXFpyqhaZ2RYjjj6rBG0thwFqXlZIWtfhydE21PmP3CdQr1L
 LFly7E5IjwhP27MclwHFIcHqtGixQZhejBe8lxHgCLT6DTyPTZAcqNSa38yCaNtTLAqZnl
 1p+EQ2cdgZaxEwbpeguHwhz6mxxeydszH7eA2M6RNSODZxSZyPF85aSNimmND6Kfg3CAvt
 R0qIEEugFcnxAHb9c0uRHhxtvv47mjZCWatsn+74CKyFOdI8sTCaWw03Pp8RuZzekdb7RK
 xPybCoOrQLrBuMZmW0di+xVp2yKDS+TO951UevtYt4Ho/fNYJg1LgZr4OBT8zg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=d1TwRccn;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5aaaf387-f48b-4fe0-8461-7c3f05e27fe2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoaSZbsAXynu8zEj6gnCSvekj6dTOsFpf5FtAlIffBw=;
 b=d1TwRccnJfYdHDv0cK+3rzGYN9C2NN7IR0+XG4kp6/tWoGs7JSvppUvIUTYlt1X8jvC0hJ
 9c7xB0VLSd1Wm799TFsgZRehkEmXg5yKr1Mb9asQzfCs3rR3kvL+Iafyl4DxRwPDDcwQVE
 PeMXmK+tTOnMwpBjx6piQV/f3m22+YBkHQPDGODH2fI3tSlpgd1cOF3tlJtsHT/2NBB/ER
 BHefMfUp7R5kughqU5AgrrEDapco8Z/7uRscQHEktYR9tZE6vOJ2jTG9k9CDtnWpoQeue+
 9vEZxA/LuPM4mcIvqDQs0dLjXWsdK2viLgiHwfn02GFWUTEKj2XCOB7E1XXavA==
Date: Tue, 21 Apr 2026 01:15:45 +0200
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] usb: gadget: renesas: add support for RZ/G2L SoC
To: Michele Bisogno <micbis.openwrt@gmail.com>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, paul@pbarker.dev,
 jh80.chung@samsung.com, peng.fan@nxp.com, lukma@denx.de,
 mkorpershoek@kernel.org, trini@konsulko.com
References: <20260415172113.273702-1-micbis.openwrt@gmail.com>
 <aaa1648f-7aa0-4a76-b21f-3566bf40f528@mailbox.org>
 <CAP8xZ6mEb8A8epx+j_f=NS80hdOD7MvzzuUHDb3R70WgXioBjw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP8xZ6mEb8A8epx+j_f=NS80hdOD7MvzzuUHDb3R70WgXioBjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: p5zrhftjyna66xmuo7crfqyw1xmisbkj
X-MBO-RS-ID: 7627dceba75c288e024
X-Rspamd-Queue-Id: 4g03cc4FJtz9tpN
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

On 4/16/26 4:14 PM, Michele Bisogno wrote:

Hello Michele,

> Thank you for the review and the link to the Linux implementation.
> 
>> Regulator change should be a separate patch please.
> 
> I agree. I will split the regulator changes into a separate patch
> for the v2 series to keep the subsystem changes distinct.
> 
>> drivers/usb/gadget/rcar is pulled from Linux 1b4861e32e46...
>> but none of these changes in this patch are even in Linux next.
> 
> The RZ/G2L support in Linux relies heavily on DMA for data transfers.
> In U-Boot, we are primarily using the PIO path. The refactoring
> in fifo.c (switching to ioread8/iowrite8) was found to be necessary
> to handle trailing bytes and alignment specifically for the RZ/G2L
> bus when DMA is not active.

If Linux also contains the PIO code, it would also benefit from matching 
improvement, right ?

> Additionally, the usb_del_gadget_udc() change in common.c addresses
> a re-entrancy bug unique to U-Boot's gadget lifecycle. Without
> this, the UDC list becomes stale, causing the board to crash if
> a command like 'ums' is executed more than once.

This should be a separate bugfix patch.

>> The addition of RZ/G2L into USBHS driver in Linux was much simpler
> 
> I agree that moving the RZ/G2L specifics in common.c to a platform
> dependent file (similar to Linux) would be the cleaner long-term
> architecture. However, doing so would require a much more invasive
> refactoring of the existing driver structure. I opted for these
> minimal changes to maintain stability for existing R-Car Gen3
> users while enabling RZ/G2L support.
> 
> I will prepare a v2 series with the patches split as requested.

Ideally, let's try to keep the Linux and U-Boot driver code base 
synchronized as much as possible.

Thank you !
