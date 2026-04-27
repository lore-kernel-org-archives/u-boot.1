Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A94FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC5083AA9;
	Mon, 27 Apr 2026 15:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HOTCGjvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7514883C14; Mon, 27 Apr 2026 15:47:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0108080433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A02AB1684;
 Mon, 27 Apr 2026 06:47:43 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4E233F763;
 Mon, 27 Apr 2026 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777297669; bh=sAcRz+s3VxC9fd5JEExM2aP/iGSA30kK6d0brEQHyjA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HOTCGjvktW2ZGTkIMMhQczavzTSioHMm9krf+a1MqWK4vGDeU0ncuyv4fpmR8Y0ln
 hoWkzEbaEouSm64oTduC+a7mb+CYt2GP3P6yo3jtEZGiqMhekeBF+ESA4b97+hTG6C
 XmKINObFsYx4A9A8TNbMABHImVS9uAXWGvizlav4=
Message-ID: <86b9f145-e94d-44f7-b8d5-8ced07f478d9@arm.com>
Date: Mon, 27 Apr 2026 15:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mtd: rawnand: sunxi: Fix user data length for H6
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <fb530fbd-6dac-4f37-8447-dc15e9b0b0fd@arm.com>
 <CAOf5uwkUXrsX6w_1LYiLK+f5HFsefx3t6Qp5urxEu_N-15KZ7g@mail.gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAOf5uwkUXrsX6w_1LYiLK+f5HFsefx3t6Qp5urxEu_N-15KZ7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Michael,

On 4/27/26 14:31, Michael Nazzareno Trimarchi wrote:
> Hi Andre
> 
> On Mon, Apr 27, 2026 at 2:28 PM Andre Przywara <andre.przywara@arm.com 
> <mailto:andre.przywara@arm.com>> wrote:
> 
>     Dario, Michael,
> 
>     are you going to take those patches eventually, or are they supposed to
>     go through the sunxi tree? Somehow patchwork put this on my plate, but
>     MAINTAINERS says it's yours.
> 
>     I will have a final look at those patches, but I think they are fine
>     since their counterparts passed the kernel reviews ;-)
> 
> 
> Company projects are stressing me out. I will check today with Dario

Sorry to hear that! I can easily take care of this series, if you are 
fine with that. It would touch only those sunxi specific files anyway.

Cheers,
Andre

> Michael
> 
>     Cheers,
>     Andre
> 
>     On 3/27/26 15:05, Richard Genoud wrote:
>      > This series introduces the correct usage of user data length for
>      > H6/H616.
>      > If the older SoCs must use a fixed value of 4 user data bytes for
>     each
>      > ECC step, the H6 can have a different value for each step.
>      >
>      > In the first round, the behavior was kept as the one used by A10.
>      > But we have multiple choices:
>      > - do like A10 like before (and not use all OOB)
>      > - do like the vendor kernel (different from A10, but not using
>     all OOB)
>      > - use the whole OOB for user data bytes
>      >
>      > In this second round, the third approach is implemented.
>      >
>      > All patches but the 4th are code cleaning.
>      > The 4th patch enables using a variable user data length for H6/H616
>      > along with maximizing it.
>      >
>      > A similar series has been accepted for Linux:
>      > https://lore.kernel.org/lkml/20260317142437.580204-1-
>     richard.genoud@bootlin.com/ <https://lore.kernel.org/
>     lkml/20260317142437.580204-1-richard.genoud@bootlin.com/>
>      >
>      > Changes from v1:
>      > - gather reviewed-by
>      > - clean sunxi_nand_chip_init()
>      > - use all possible remaining OOB space for user data bytes
>      >
>      > Richard Genoud (5):
>      >    mtd: rawnand: sunxi: Replace hard coded value by a define
>      >    mtd: rawnand: sunxi: make the code mode self-explanatory
>      >    mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
>      >    mtd: rawnand: sunxi: introduce variable user data length
>      >    mtd: nand: raw: sunxi_spl: remove user data length reset
>      >
>      >   drivers/mtd/nand/raw/sunxi_nand.c     | 292 ++++++++++++++++++
>     +-------
>      >   drivers/mtd/nand/raw/sunxi_nand.h     |   3 +
>      >   drivers/mtd/nand/raw/sunxi_nand_spl.c | 129 +++++++++---
>      >   3 files changed, 324 insertions(+), 100 deletions(-)
>      >
>      >
>      > base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
> 
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com <mailto:michael@amarulasolutions.com>
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com <mailto:info@amarulasolutions.com>
> www.amarulasolutions.com <http://www.amarulasolutions.com>

