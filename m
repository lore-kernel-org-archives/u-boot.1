Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50445C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 15:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B072184BED;
	Thu, 16 Jul 2026 17:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="lGQsxU7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF0284C23; Thu, 16 Jul 2026 17:18:00 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A906284BDC
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 17:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=65092eaa9=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784215077; x=1815751077;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Xhx0wl5OQjgAf2wULVLIs9fqA+IG40e9INoI2BmrKGg=;
 b=lGQsxU7Hlo++oXrhOgDG+pcZ8mqStUu82Lk2uRrdmoLCDpejhVLxWdPT
 ED6eEeS29lLxodni/MvSVhORoDbZtLvOvf4ZGFZ/qpJjiDiEznbLB37ap
 9g1o+yaknQmhU0pA/NOiXSlBQJLxh75zvXAtczmCZQ2JtCFSvVXsF/GcA
 hYHjiyBI04Fqmwlu99QrdrMFTNShtPI4uL+yVW9ahfUPhJw/Unp5cVt1K
 57z6sUS4FokafWalOWUXDTeM6VGjGwyWrI5uszQa4gI7wgy9CgMSrGIe7
 pxM/ZhZ7oWIxMHHCLegmO33N3CQ2mqxp0qXzu5llhOG0HrNrm6jsOQo2i Q==;
X-CSE-ConnectionGUID: psDOgDVoSZeuzETsYZ9mQw==
X-CSE-MsgGUID: tg7byaX1Tpa6IuTzZsd4XA==
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="227877604"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Jul 2026 08:17:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 16 Jul 2026 08:17:55 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 16 Jul 2026 08:17:55 -0700
Date: Thu, 16 Jul 2026 08:17:53 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>,
 <anup.patel@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] riscv: Add generic SBI MPXY interface and MPXY command
Message-ID: <alj2IeRu5emA2amQ@bby-cbu-swbuild03.eng.microchip.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <alZvl61jiQ0Wlvl2@bby-cbu-swbuild03.eng.microchip.com>
 <CAFR3w36bcmGtSMLwt2NBKh7OQ_AW_7dPJfYrqc0=KpGC6LwnUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFR3w36bcmGtSMLwt2NBKh7OQ_AW_7dPJfYrqc0=KpGC6LwnUg@mail.gmail.com>
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

On Thu, Jul 16, 2026 at 08:15:42AM +0530, Rahul Pathak wrote:
> On Tue, Jul 14, 2026 at 10:49 PM Charles Perry
> <charles.perry@microchip.com> wrote:
> >
> > On Thu, Jul 09, 2026 at 11:26:01PM +0530, Rahul Pathak wrote:
> > > This patch series adds a generic SBI MPXY extension
> > > implementation which provides an interface to interact
> > > with platform via supported message protocol (eg. RPMI)
> > >
> > > It also adds a mpxy command which uses the generic
> > > SBI MPXY interface and provides cli support to
> > > interact with supported message protocol. Currently
> > > it supports RISC-V RPMI message protocol.
> >
> > Hello Rahul,
> >
> > I'm happy to see that you're interested in RPMI support in U-Boot.
> >
> > Can you share with us the context in which you developed those patches?
> > i.e., what hardware are you using and how is the "mpxy" command used.
> >
> > Is "mpxy" mostly just for debugging or is it expected that a bootscript
> > would initialize the platform with calls to "mpxy"?
> >
> Hi Charles,
> 
> I have used QEMU RISC-V Virt platform (with OpenSBI + librpmi
> providing the RPMI firmware side) for its development, and in terms of
> use cases its both actually which you outlined - debugging and
> configuration.
> 
> Debugging is the pretty obvious usecase where mpxy command allows
> anyone to access message protocol in case of RPMI, it lets you
> access any custom service group implemented without changing u-boot.
> 
> Boot time tweaking of any attribute or any platform state changes via
> scripts is also possible as you mentioned. The configuration can be
> board specific and expressed in uboot environment scripts instead of
> compiled in driver code.

Most people will want the later, i.e. compiled code.

That doesn't mean you need to modify all the drivers being used on your
machine because U-Boot already has an abstraction layers for clocks,
power-domains, resets, and other which are relevant to RPMI.

If you make a driver that implements the clock, power-domain, etc. API and
implement it so that it delegates to RPMI, you can leverage the existing
drivers and you don't have to add "mpxy" commands to your bootscript. Need
to use the network? you call "tftpboot" which calls your network device
driver which calls your clock driver which calls your RPMI driver. Need to
use the NOR? you call "mtd" and the same magic happens.

I posted an implementation of this, please have a look at it:

https://lore.kernel.org/all/20260708215200.1331416-1-charles.perry@microchip.com/

If you want, we can combine our two patchsets into something that takes
the best of both.

I can take your patch that adds the "mpxy" command and add it to my
patchset with a few adjustments.

Thanks,
Charles
