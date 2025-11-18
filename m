Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB64CEE350
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F92835B3;
	Tue, 18 Nov 2025 21:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KybXpP6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BE683693; Tue, 18 Nov 2025 21:07:22 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A79C832AD
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d9wcz2Zq1z9sxb;
 Tue, 18 Nov 2025 21:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763496435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpTs8KLCx+8Q9L2rLXZB/975TagWd4oYEtggxdbzZCM=;
 b=KybXpP6V4tHqOU1vyI9XMdw44qLbm78vgRriTURvsFEAqONsGf9Mg5a+oKfJwHf7jF+VGL
 JH4kiqy0PafZEpIGNfmNTmirUhw9LVVoevo4NW8tI64WWz2Q2F53sTzmlOTK1Wyoe+/z+a
 ouymuKClVcxTm3ImlGIHXTEFOLD/GHSSw0h0Eupkg03Vrqh8s1VwiCJuC3ZMFZNY13DmdJ
 5ScFh6wPNJU/u/AJz20XAj1rGW/wH0f2j1QqtmRJbtw7N/UoN4fTtEoSFmMdYABqzW6Opb
 L2P9kFtSiAQJ83zrIahCR7T+JgoLSDGksYyJ6dVaIg944WxTyajguEepYKuSTQ==
Message-ID: <a39d032a-d9c0-42e6-8481-20278d6eb389@mailbox.org>
Date: Tue, 18 Nov 2025 21:07:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] novena: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251118180427.591409-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251118180427.591409-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: iqd9hufqymar8z98w1t6oeuw6zs9af6y
X-MBO-RS-ID: ce9056898cac5a4184c
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

On 11/18/25 7:04 PM, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
> 
> Cc: Marek Vasut <marek.vasut@mailbox.org>
Acked-by: Marek Vasut <marek.vasut@mailbox.org>
