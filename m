Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1F4CA1005
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 01:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B0A833BF;
	Wed,  3 Sep 2025 03:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QMNfkRmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC37F833D0; Wed,  3 Sep 2025 03:51:00 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F37833D0
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 03:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cGlv41xvpz9srK;
 Wed,  3 Sep 2025 03:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756864256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UXXJqy8KJ+6ehSbjJSWcXWsF/RYM8fgkIomTF9NZuY=;
 b=QMNfkRmhbw5oYN03rhedO0zM0iyYzXi6lACwkrONp7ot2HxKIL2gs/f9Z+Vp8nXC4NG2Wk
 cPJMBGO32Ydq+HZaLPsVY956RyMhxwsc+nq+Gv79gwjfi9GIWCvVGJLpBRi2fo0ouu2OP8
 ZDRTdTqj8peUxRRcKLswV82pEgolDxWuiZs+1uzHlv3KQiNeskd3DhtZfyVi5dJP8y+bWa
 QiNQpjKvq6mxD9ot4m0znvSx6ITgIUR3DBpbLHMvgcNbVyQEtGRIigdlJ5BC/7jGsL1eYT
 Fz2PwhfZhr0/uo4Mtl9s2M0ERbArp2aBtng+32rHoaMoy0oqmF8XDAbwNwbbig==
Message-ID: <ce02cba9-8e6f-431e-b57c-83a0a175d5ee@mailbox.org>
Date: Wed, 3 Sep 2025 03:46:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] usb: gadget: bcm_udc_otg: Remove unused driver
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20250806145601.1664563-1-trini@konsulko.com>
 <20250806145601.1664563-3-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806145601.1664563-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 24f74a0fbfb1a656e28
X-MBO-RS-META: ynmofhozj8qcbt81uzj58yyofaj5de4q
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

On 8/6/25 4:55 PM, Tom Rini wrote:
> This driver is unused. Remove it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>   drivers/usb/gadget/Kconfig           |  5 ---
>   drivers/usb/gadget/Makefile          |  1 -
>   drivers/usb/gadget/bcm_udc_otg.h     | 19 ----------
>   drivers/usb/gadget/bcm_udc_otg_phy.c | 54 ----------------------------
Please update the commit message and indicate this was used by now 
removed bcm28155_ap board, removed in 0f6807e77b07 ("arm: Remove 
bcm28155_ap board")

