Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE17BEB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA49C8675B;
	Mon, 14 Aug 2023 23:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613ED8696D; Mon, 14 Aug 2023 23:06:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 70A3B80750
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C784F1FB;
 Mon, 14 Aug 2023 14:07:03 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E58D3F64C;
 Mon, 14 Aug 2023 14:06:20 -0700 (PDT)
Date: Mon, 14 Aug 2023 22:05:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH 1/3] sunxi: psci: clean away preprocessor macros
Message-ID: <20230814220521.364addff@slackpad.lan>
In-Reply-To: <1af2d8fe-0516-e67d-15b8-71248ac80fa3@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-2-CFSworks@gmail.com>
 <20230814173714.61bd09a2@donnerap.manchester.arm.com>
 <1af2d8fe-0516-e67d-15b8-71248ac80fa3@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Mon, 14 Aug 2023 12:10:25 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

> Hi Andre,
> 
> On 8/14/23 10:37, Andre Przywara wrote:
> > So I think we can get rid of this:
> > - GEN_H6 never compiles this code here, as both H6 and H616 are arm64.  
> 
> Easy!
> 
> > - We can define SUNXI_PRCM_BASE for NCAT2, I believe Samuel once
> > mentioned that the D1/T113 does have such a block, actually.  
> 
> Will you be taking care of this in v2 of your T113s series, or should I 
> be adding it (in which case I'll need to know the location of the block)?

Yes, I will add this to the header file, either defined as 0, or to its
actual address.
 
> > - The non-existing cpu_pwr_clamp member should go away when you switch to
> > a BASE_ADDR + REG_OFFSET approach, I think.  
> 
> Less easy, but still can do.
> 
> > Shouldn't that be the opposite? In the existing code, sun6i and H3 DO
> > program the clamp (see the "-" section above).  
> 
> And sun7i and R40, as well.

Yes, but you handle both above explicitly.

> It appears I simply read the #if 
> defined(...) mess backwards. I'll fix that for v2. As a bonus, this 
> lends itself to a rather nice refactoring of sunxi_cpu_set_power() where 
> I can have the if block only determine the pwroff/clamp addresses, and 
> have a single tail-call to sunxi_power_switch() at the bottom. Since the 
> latter function is so simple, I may as well just inline it into 
> sunxi_cpu_set_power() (which I suspect might be more readable).

Yes, any further simplification is welcome, and probably somewhat
rewarding in this case ;-)

Cheers,
Andre
