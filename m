Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F763F433CF
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 22:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E2D84105;
	Thu, 16 Apr 2026 00:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PzWMpceZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yb+1+4Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87C98412A; Thu, 16 Apr 2026 00:38:39 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C6B83936
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fwwzJ6msLz9tnh;
 Thu, 16 Apr 2026 00:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776292717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFFQ7r3q5oPqBRKsX2s+l/OkkYDQ13ANvDS9cJt7w14=;
 b=PzWMpceZl9AfpYFLJv+IB3KNNLdzQ/tyguhFs+6jblWNXISQKxaEbFiN0bfUJgrVpiD222
 5p1Qw6VjMWEYkJ+sBjCk4VAK9JULuhP0LQjYed0Rv5nF1MG+/D7JBcK+R2aKN8cq6CNk+s
 gklV7gSLVwjD6jGaYnzLAbi5CmSNwbAJwfqAaaMXPa0USVWvE+/ZJml4ESE9GZCjL/M397
 23pcelYGMbDYD0KR2ngDFYsryaEkRiy0fwuCthyZ0EY3y/ydxEOhLjF8kdnkkYraR4trFR
 S3IGpg1v8/P7UQBkPEbbL5KY4FFer3OdjT7RpiGBh2W4BPjJvc9l1twebC/6nw==
Message-ID: <aaa1648f-7aa0-4a76-b21f-3566bf40f528@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776292714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFFQ7r3q5oPqBRKsX2s+l/OkkYDQ13ANvDS9cJt7w14=;
 b=Yb+1+4DwQOmAvIkgZrjvwH6krgyjOd4rhmXcq/suDLhgLHca4/o0N33My3XUuR9QJCBdnI
 QJyIbO0/8xpx4Cn/AgPfJwmISacw4Z+SMZF7r1Y6yrXMkZ4UBv0HzvsAc1GIKqpheFlRxM
 HVKn4ciX3ae25lT291HRUMCVH+ONLLtZjQFDl8XMNzs+JrZJYRHgUJFSYbgBuZKb1u6PKg
 RleKwuscJ1+ECTVipDdwCe/r0D+4bYBMffvgfIKl8oQzDtQGiRlgNXw1VE9P19+VRnqa6U
 ntjmkImVN/xqwAG/Ugvzwb8QQd2KLvSjllLXU54v4BYV98esc6YxfNhReA/dGw==
Date: Thu, 16 Apr 2026 00:38:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: renesas: add support for RZ/G2L SoC
To: Michele Bisogno <micbis.openwrt@gmail.com>, u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev,
 jh80.chung@samsung.com, peng.fan@nxp.com, lukma@denx.de,
 mkorpershoek@kernel.org, trini@konsulko.com
References: <20260415172113.273702-1-micbis.openwrt@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260415172113.273702-1-micbis.openwrt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ybd5i5xiaug6w6nxzda4yyjc9c7dpqso
X-MBO-RS-ID: 85afc05bdec3373c85e
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

On 4/15/26 7:21 PM, Michele Bisogno wrote:
> Support the Renesas RZ/G2L (r9a07g044) USBHS IP by addressing
> platform-specific reset, glue logic, and FIFO access requirements.
> 
> - regulator: rzg2l: Implement CON_CTRL manual connectivity notification.
>    By setting SEL_CONNECT and CONNECT_1, the UTM+ core is notified of
>    connection status in peripheral mode.
> - gadget: common: Add "renesas,rzg2l-usbhs" compatible and support
>    reset deassertion. Fix a re-entrancy bug by calling usb_del_gadget_udc()
>    in the remove callback to prevent stale UDC list entries.
> - gadget: fifo: Refactor PIO push/pop logic to handle trailing bytes
>    using iowrite8/ioread8. This ensures correct data alignment on
>    RZ/G2L and simplifies the data transfer loop.
> 
> Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
> ---
>   .../power/regulator/rzg2l-usbphy-regulator.c  | 10 ++++++--

Regulator change should be a separate patch please.

>   drivers/usb/gadget/rcar/common.c              | 15 ++++++++++++
>   drivers/usb/gadget/rcar/fifo.c                | 23 +++++++++++--------
drivers/usb/gadget/rcar is pulled from Linux 1b4861e32e46 ("Linux 
6.9.3") , but none of these changes in this patch are even in Linux 
next. Is there at least a submitted Linux kernel patch which adds these 
matching changes ? I would very much like to keep the USBHS drivers 
synchronized between U-Boot and Linux.

The addition of RZ/G2L into USBHS driver in Linux was much simpler:

https://lore.kernel.org/r/20240319105356.87287-5-biju.das.jz@bp.renesas.com
