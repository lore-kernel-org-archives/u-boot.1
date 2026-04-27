Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C68AFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B6883693;
	Mon, 27 Apr 2026 14:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nU53+Rre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F0D83C14; Mon, 27 Apr 2026 14:28:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BAF7D80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0E41684;
 Mon, 27 Apr 2026 05:28:34 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C85F3F62B;
 Mon, 27 Apr 2026 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777292919; bh=z5gq/jb4vicBy5iKKfDDzs7vwwvszWSRTqsh3169Uhw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nU53+RreUAJvyCiBKpbyN1ZNVXCJ3NWWhRGX1J8o1K22LPi/82Cc42hpytavvXbFn
 nZofrNG14gNRuCSi1uAa92AUElKAm5ZKZfXdPS78qf+K+VY009HxnccHv6nniM05a8
 jsMYxLRkgEFHZlgsmWw7/kBTMJuQdWAdnJlUC3m0=
Message-ID: <fb530fbd-6dac-4f37-8447-dc15e9b0b0fd@arm.com>
Date: Mon, 27 Apr 2026 14:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mtd: rawnand: sunxi: Fix user data length for H6
To: Richard Genoud <richard.genoud@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260327140508.3680105-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Dario, Michael,

are you going to take those patches eventually, or are they supposed to 
go through the sunxi tree? Somehow patchwork put this on my plate, but 
MAINTAINERS says it's yours.

I will have a final look at those patches, but I think they are fine 
since their counterparts passed the kernel reviews ;-)

Cheers,
Andre

On 3/27/26 15:05, Richard Genoud wrote:
> This series introduces the correct usage of user data length for
> H6/H616.
> If the older SoCs must use a fixed value of 4 user data bytes for each
> ECC step, the H6 can have a different value for each step.
> 
> In the first round, the behavior was kept as the one used by A10.
> But we have multiple choices:
> - do like A10 like before (and not use all OOB)
> - do like the vendor kernel (different from A10, but not using all OOB)
> - use the whole OOB for user data bytes
> 
> In this second round, the third approach is implemented.
> 
> All patches but the 4th are code cleaning.
> The 4th patch enables using a variable user data length for H6/H616
> along with maximizing it.
> 
> A similar series has been accepted for Linux:
> https://lore.kernel.org/lkml/20260317142437.580204-1-richard.genoud@bootlin.com/
> 
> Changes from v1:
> - gather reviewed-by
> - clean sunxi_nand_chip_init()
> - use all possible remaining OOB space for user data bytes
> 
> Richard Genoud (5):
>    mtd: rawnand: sunxi: Replace hard coded value by a define
>    mtd: rawnand: sunxi: make the code mode self-explanatory
>    mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
>    mtd: rawnand: sunxi: introduce variable user data length
>    mtd: nand: raw: sunxi_spl: remove user data length reset
> 
>   drivers/mtd/nand/raw/sunxi_nand.c     | 292 +++++++++++++++++++-------
>   drivers/mtd/nand/raw/sunxi_nand.h     |   3 +
>   drivers/mtd/nand/raw/sunxi_nand_spl.c | 129 +++++++++---
>   3 files changed, 324 insertions(+), 100 deletions(-)
> 
> 
> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da

