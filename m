Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668B4D63938
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CC689684;
	Wed, 20 Nov 2024 14:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B658967C; Wed, 20 Nov 2024 14:13:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4DF598969E
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 750D31480;
 Wed, 20 Nov 2024 05:14:01 -0800 (PST)
Received: from e130802.arm.com (e130802.arm.com [10.1.32.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96A7E3F66E;
 Wed, 20 Nov 2024 05:13:30 -0800 (PST)
Date: Wed, 20 Nov 2024 13:13:23 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/8] arm_ffa: Add FFA_MEM_SHARE and FFA_MEM_RECLAIM support
Message-ID: <20241120131323.GA36998@e130802.arm.com>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
 <20241107153311.GA240434@e130802.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107153311.GA240434@e130802.arm.com>
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

Hi Tom,

I'm happy to address your review comments and make the patchset
meets your expectations.

Please feel free to give a feedback and I'll be addressing that ASAP.

Cheers
Abdellatif

On Thu, Nov 07, 2024 at 03:33:11PM +0000, Abdellatif El Khlifi wrote:
> Hi Simon, Tom,
> 
> > Add to the FF-A bus FFA_MEM_SHARE and FFA_MEM_RECLAIM ABIs.
> > 
> > These FF-A ABIs are for memory management. They are used for sharing
> > memory between U-Boot and secure world.
> > 
> > FFA_MEM_SHARE starts a transaction to grant access to a memory region
> > to one or more Borrowers (aka Secure Partitions or endpoints).
> > FFA_MEM_RECLAIM restores exclusive access to a memory region back to
> > its Owner (U-Boot).
> > 
> > For more details about these ABIs please refer to the FF-A v1.0
> > specification [1]. For more details about FF-A in U-Boot please
> > refer to the readme [2].
> > 
> > This work is based on the implementation in Linux kernel [3].
> > 
> > This work is provided with sandbox support (emulation and test cases).
> > 
> > [1]: https://developer.arm.com/documentation/den0077/a/?lang=en
> > [2]: doc/arch/arm64.ffa.rst
> > [3]: commit cc2195fe536c28e192df5d07e6dd277af36814b4
> >      Files: drivers/firmware/arm_ffa/driver.c , include/linux/arm_ffa.h
> > 
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Achin Gupta <achin.gupta@arm.com>
> > Cc: Drew Reed <Drew.Reed@arm.com>
> > Cc: Hugues Kamba Mpiana <Hugues.KambaMpiana@arm.com>
> > 
> > Cheers,
> > Abdellatif
> > 
> > Abdellatif El Khlifi (8):
> >   arm_ffa: Add NULL pointer check to the driver operations
> >   arm_ffa: Add FFA_MEM_SHARE support
> >   arm_ffa: Add FFA_MEM_RECLAIM support
> >   arm_ffa: sandbox: Replace the emulator error log with debug log
> >   arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
> >   arm_ffa: sandbox: Add FFA_MEM_SHARE tests
> >   arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
> >   arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
> > 
> 
> A gentle reminder please. Your comments are welcome.
> 
> Cheers,
> Abdellatif
