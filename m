Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20CEE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FED8934C;
	Thu,  5 Dec 2024 10:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Ywmuto0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D4489435; Thu,  5 Dec 2024 10:36:44 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BB7890D5
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id D82562062C;
 Thu,  5 Dec 2024 10:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1733391401;
 bh=Ov5EJnTguuqR6Ky1EY7xTiB+g8rACDRPt8e8LuFfIOg=; h=From:To:Subject;
 b=Ywmuto0pnLoVZe9+7QPMF5hRuX49NhysaGw+UO9CtPZiPqklK6D8v7bllP5St93jS
 MZeH87W9Aph2gHF//rCJ2SRCBvzSpAuZHIADtD6WAJrS9ddnEyiPD8kaPmZV8nRylE
 mal43ttVxXhLTqK6ON3HG7wHUg2PNvRUkoU7lPmsUlxUzrQnG0ZL0P5/0r9YMfYD0r
 y+Lp0jz32dzNQ5biAAiSOKBkCimq1EXXKcU06Il9e4cUkh1Ezr89GFElql2MaUGyWN
 wy5fSbE0ywJrwWT/q/N3B7RbdvBJUJpFPqBzOeZA0ABlV7MX2kO4eDW93m3oj0HVtz
 OzTbouDDpd79g==
Date: Thu, 5 Dec 2024 10:36:36 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v2] verdin-am62: fix FASTBOOT_BUF_ADDR and
 FASTBOOT_BUF_SIZE
Message-ID: <20241205093636.GA16759@francesco-nb>
References: <20241203123302.298188-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203123302.298188-1-hiagofranco@gmail.com>
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

On Tue, Dec 03, 2024 at 09:33:02AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> The current value of CONFIG_FASTBOOT_BUF_ADDR is incorrect for hardware
> with 512MB and 1GB of RAM. The RAM address ranges for these devices are:
> 
> - 512MB:
>   - Start: 0x80000000
>   - End:   0xA0000000
> - 1GB:
>   - Start: 0x80000000
>   - End:   0xC0000000
> 
> The current buffer address makes fastboot downloads work only on
> hardware with 2GB of RAM.
> 
> To fix this issue:
> 1. Lower CONFIG_FASTBOOT_BUF_ADDR to 0x88200000. This makes the buffer
>    to be equal ot CONFIG_SYS_LOAD_ADDR, which is a safe address to
>    download files using fastboot.
> 
> 2. Reduce the size of the download buffer to 128MB, avoiding overlaps
>    with RAMDISK_ADDR_R. This is a good enough value for individual
>    downloads.
> 
> These changes make fastboot downloads work with 512MB and 1GB devices.
> 
> Fixes: defe30a78b76 ("verdin-am62: add DFU, USB and UUU fastboot support")
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

