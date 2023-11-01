Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6221DC4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B76386EF1;
	Wed,  1 Nov 2023 13:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8AF87479; Wed,  1 Nov 2023 13:57:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DE8AB86EF1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084952F4;
 Wed,  1 Nov 2023 05:57:55 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 966D73F64C;
 Wed,  1 Nov 2023 05:57:12 -0700 (PDT)
Date: Wed, 1 Nov 2023 12:57:09 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marek Vasut <marex@denx.de>
Cc: Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de, Jagan Teki
 <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 0/2] sunxi, usb: Clean up SRAM initialization code
Message-ID: <20231101125709.581b9fe9@donnerap.manchester.arm.com>
In-Reply-To: <20230615190701.327852-1-CFSworks@gmail.com>
References: <20230615190701.327852-1-CFSworks@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 15 Jun 2023 13:06:59 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Marek,

I just saw that you were not CC:ed on this one. Both patches are fine from
my point of view.
Do you want to take them through the USB tree, or shall I do it via the
sunxi tree?
And shall I take future musb-new/sunxi.c patches in general, if you have
approved them? They are typically ports of quirks from the kernel, and new
compatible strings, maybe.

Cheers,
Andre

> Only change from v4 is that I reworded the commit message in 2/2 not to mention
> the TODO comment block that I removed in v3.
> 
> Cheers,
> Sam
> 
> Sam Edwards (2):
>   usb: musb-new: sunxi: only perform SRAM initialization when necessary
>   usb: musb-new: sunxi: clarify the purpose of SRAM initialization
> 
>  drivers/usb/musb-new/sunxi.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 

