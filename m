Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F351BD3C93F
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 06:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9662892A2;
	Mon, 21 Oct 2024 08:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="AGmOIk+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA17885F4; Mon, 21 Oct 2024 08:03:43 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE12885F4
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86206148AB4F; Mon, 21 Oct 2024 08:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1729490620; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=chvajl/mO/FkfiKjAId+lu7FbgPY3/fqjISpk8XAcMs=;
 b=AGmOIk+5RRUqH90YPh/jc4UKMCW2YMfBgseONyaY7nWSg+asDOXZtJusgqIhbPBGn+yZZN
 ibbriHNG2v7xFOblc3Qiadar9jjSLfvzlBEWE80SUs59MXPW/ErxSuX2YILpf7Oa2WJXWJ
 4Ph8DzJC3xLaSrkDmWZu80+oPvdhCdmyUp19WaIe/L99dvnvTTYVhnpSrd9+R+DGJyTUc2
 S/LFBU/yJs85Xd9hb+Qm8lqtxw5ioblhJRJlKi9b7MAZ2aEsYNa+8QAECM6EMesRo+wIhC
 KVqJ14Z68ynPjcoXw5T3GpJcNaY5QzjkeMbm4AAlVBjWxKKUBQx8m3WNXidAyQ==
Date: Mon, 21 Oct 2024 08:03:35 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de,
 John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
Mail-Followup-To: Benedikt Spranger <b.spranger@linutronix.de>,
 u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018161908.3f6a13eb@mitra>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Benedikt,

Am Fri, Oct 18, 2024 at 04:19:08PM +0200 schrieb Benedikt Spranger:
> On Fri, 18 Oct 2024 15:11:20 +0200
> Alexander Dahl <ada@thorsis.com> wrote:
> 
> Hello Alexander,
> 
> > Am Fri, Oct 18, 2024 at 10:30:00AM +0200 schrieb Benedikt Spranger:
> > > OK, you might say the nand_atmel NAND driver is obsolete, but it
> > > was the only solution to get booting from NAND running. The new DM
> > > based NAND driver refused to do anything usefull, so I dropped it
> > > after spending a couple of days debugging it:
> > 
> > Strange.  I have at least three different boards with SAMA5D27
> > successfully booting from NAND flash with the new DM based driver
> > (unfortunately none of them upstreamed, which also won't change in the
> > foreseeable future, sorry).
> OK.
>  
> > Do you use at91bootstrap as 2nd level bootloader like me or something
> > else?
> I use the U-Boot SPL. There is no UBI support in at91boostrap. There
> were some attemps, but...
> No interest at the at91bootstrap side.

Yeah, been there.  Wanted at91bootstrap to boot from SPI-NOR which is
_not_ Quad-SPI, and the feature request was closed with "if you wanna
do it by yourself, ask our support for help". :-/

> > For me it was basically getting the dts for U-Boot correct, but
> > I got that running with all U-Boot releases since 2023.04 up to
> > 2024.10.  Could you share some more detail?
> I face all the trouble in SPL. And since the SPL is the essential part
> here (UBI support) I gave up at one point. I simply couldn't any
> usefull read data from the NAND flash, but all 0.

You can not store bootstrap or SPL in UBI, it must sit in first sector
of raw NAND, I suppose that's how you load SPL?  Did you try
reading/writing raw NAND from there?  I'm not familiar with SPL, does
it consider dts?  I could share my dts parts if that helps you.

(What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
at91bootstrap loads U-Boot from raw NAND at some offset like 0x20000,
U-Boot (proper) loads everything else from UBI.)

Greets
Alex
