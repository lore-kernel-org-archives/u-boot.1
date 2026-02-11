Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7B6EA8125
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 10:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FDE82BF2;
	Wed, 11 Feb 2026 11:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF43B83CE3; Wed, 11 Feb 2026 11:12:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 65B5E80FA1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 11:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B8D339;
 Wed, 11 Feb 2026 02:12:19 -0800 (PST)
Received: from localhost (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A07343F632;
 Wed, 11 Feb 2026 02:12:24 -0800 (PST)
Date: Wed, 11 Feb 2026 15:42:21 +0530
From: Sughosh Ganu <sughosh.ganu@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 thomas.petazzoni@bootlin.com, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to be
 enabled
Message-ID: <aYxWBRTdktKn8DRt@a079122.arm.com>
References: <20260114095654.736511-1-kory.maincent@bootlin.com>
 <20260114144918.GC3416603@bill-the-cat>
 <20260206151945.4448af9d@kmaincent-XPS-13-7390>
 <CAC_iWj+XZ46w859tFJc4FSEX-AOUGgmbwe=1dyU8-bPG7+R3+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWj+XZ46w859tFJc4FSEX-AOUGgmbwe=1dyU8-bPG7+R3+g@mail.gmail.com>
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

On Wed, Feb 11, 2026 at 11:04:17AM +0200, Ilias Apalodimas wrote:
> Hi Kory
> 
> On Fri, 6 Feb 2026 at 16:19, Kory Maincent <kory.maincent@bootlin.com> wrote:
> >
> > On Wed, 14 Jan 2026 08:49:18 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Wed, Jan 14, 2026 at 10:56:53AM +0100, Kory Maincent wrote:
> > >
> > > > Change the Kconfig from a "choice" to a conditional block, allowing
> > > > multiple FWU metadata storage drivers to be selected simultaneously
> > > > instead of being mutually exclusive.
> > > >
> > > > This enables systems with FWU metadata on different storage types
> > > > (e.g., both GPT-partitioned block devices and MTD devices) to have
> > > > both drivers compiled in. The board can then select the appropriate
> > > > driver at runtime based on the devicetree description.
> > > >
> > > > The change converts FWU_MDATA to a menuconfig and replaces the
> > > > "choice/endchoice" block with "if FWU_MDATA/endif", making
> > > > FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.
> > > >
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > >
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > Hello,
> >
> > Any news on this patch? Does something prevent it to be merged?
> 
> I cc'ed Sughosh which maintains fwu. I can send a PR if we get an ACK

Apologies for the delay. I will get back on this by tomorrow. Thanks.

-sughosh

> 
> Thanks
> /Ilias
> >
> > Regards,
> > --
> > Köry Maincent, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
