Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4708CF397E
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5550D83FC5;
	Wed, 19 Nov 2025 18:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bPu86hae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B542F80077; Wed, 19 Nov 2025 18:34:49 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF2D8391B
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dBTBY6mMPz9sc0;
 Wed, 19 Nov 2025 18:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763573686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvLJG9bHXDO7n/KSr194viW9j2HWS/Ubjn6vEBbegc0=;
 b=bPu86haeMIIXzli0ego4HxW/JUX37Yx/lpMHJ5cOFRx1eKvB0iPjakQ78HwFeakt838kbi
 XAxzAikKc9V15OZ1J56cSmSazEjudyzpS7sk5Qia4pFoKDT0f0cKrxXl/vW+a2EhNbWTDu
 wer0OUHavISERhY9VP47wrFXXSipWqw6aMSXjFtotCS37S6tufz50MGEbUzwuI565Fw+65
 Q0Oe73LAcvegDbShoeuXn1c2UoYxNOOjJv4wSGpOzafiQ6PkLUS2n0a5xrOVCGfeb3RNRx
 evBIY1nn652qt4vYAt3kGPzxXyaCjpby2ociPpObHWPdqycgrF5hYtbEDFQTaw==
Message-ID: <b1ba3fcb-bb51-4da8-bef4-b228ebea140c@mailbox.org>
Date: Wed, 19 Nov 2025 17:33:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] pico-imx8mq: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251119145037.842213-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251119145037.842213-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 31d16ddbe3ef282dcf2
X-MBO-RS-META: pe8m448qi3p4i31c51zqhufj1oexcupq
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

On 11/19/25 3:50 PM, Tom Rini wrote:
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

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

This fdt_high won't be missed, thank you very much.
