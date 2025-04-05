Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7E6C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 13:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B5C81FEE;
	Sat,  5 Apr 2025 15:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F958215B; Sat,  5 Apr 2025 15:04:38 +0200 (CEST)
Received: from smtp.gentoo.org (smtp.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 448D181FAA
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 15:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.48.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 5CD6A34325F;
 Sat, 05 Apr 2025 13:04:33 +0000 (UTC)
Date: Sat, 5 Apr 2025 13:04:29 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 00/34] sunxi: clock refactoring and Allwinner A523 support
Message-ID: <20250405130429-GYA9988@gentoo>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250405024433-GYA8928@gentoo>
 <20250405133248.62927bff@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405133248.62927bff@minigeek.lan>
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

Hi Andre:

On 13:32 Sat 05 Apr     , Andre Przywara wrote:
> On Sat, 5 Apr 2025 02:44:33 +0000
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> Hi,
> 
> > On 11:35 Sun 23 Mar     , Andre Przywara wrote:
> > > This series introduces support for the Allwinner A523 SoC family. The
> > > same die is used in different packages: the A523, A527, T527, and H728:
> > > they connect a different set of peripherals to the pins, or enable extra
> > > goodies like an NPU. From a U-Boot perspective those chips do not differ
> > > much, all the differences are described in the board DT files.
> > > These patches are not the most refined at the moment, but I hope that
> > > people start reviewing them, so we can merge the ones that are ready,
> > > to reduce their number.
...
> > is ATF loading address correct, 0x54000 here? which seems override sp address?
> 
> Yes, that's the correct address. Which SP would it collide with, anyway?
> 
> So in summary you did everything right, and the SPL is returning to FEL
> with DRAM initialised, which is the biggest hurdle.
> Just use the correct A523 TF-A branch and build target.
>
right, with correct ATF, I'm able to boot into uboot console
also, emmc works on radxa a5e board (same change with avaota-a1)..

thanks
-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
