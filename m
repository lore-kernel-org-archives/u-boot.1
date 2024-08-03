Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E38C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 14:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1938B8870E;
	Sat,  3 Aug 2024 16:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dh8LHRW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01D688C8F; Sat,  3 Aug 2024 16:57:34 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A6A8865D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 16:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6F05FCE0018;
 Sat,  3 Aug 2024 14:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FA8C4AF0A;
 Sat,  3 Aug 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722697049;
 bh=bDUW469/wb3A1lhifoYs9ydl3AwN9ovQaCAsc05Ti0k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Dh8LHRW8EygSiXdXGRfNW1QRl/WynNvTDeAGZINY43BwX5KOMQhjuOSQRqtGr2BRr
 ZA91jXSY11kIXFKbfelEYm/8vozqTLjTezYXX8Rg7Vgc5bWEYXeBnm3NndvaFOLv4K
 HxpBixjNOLUkaK9ke+wmSTqyo2rH+BRdgpWyD5wcI5x1MTRwmf4NoBTg77KNAyM/XO
 ePXHks9cQHJXcler/hML/cPMgjieNoVrGaPLEfEWwSP2rc2aD19DDeLC03Ge+Esp3w
 VOXBqrv9n4Yz3bQUzPMwKx1xhVM4sFKvoO5/inetNhj/6Ryyk9QjCqS+WAMswAVrDS
 jZH4st0KiGVlw==
Message-ID: <8f110881-d9f1-40a7-9d1e-0f03bb5152c3@kernel.org>
Date: Sat, 3 Aug 2024 17:57:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: raw: omap_gpmc: Check return value of
 gpmc_nand_init
To: Vignesh Raghavendra <vigneshr@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: William Zhang <william.zhang@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, s-k6@ti.com
References: <20240731145855.3122166-1-vigneshr@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240731145855.3122166-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 31/07/2024 17:58, Vignesh Raghavendra wrote:
> If the function is called with no NAND device attached, then this
> function can return error value, proceeding further ignoring the same
> can cause system crash. This is seen when "mtd list" is run with no NAND
> addon cards connected.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>
