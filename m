Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89BAFEC0F6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4069B8352B;
	Tue, 24 Mar 2026 20:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="nanAUq5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1284283952; Tue, 24 Mar 2026 20:03:08 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA76807C0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 164c281c-27b4-11f1-89dd-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 164c281c-27b4-11f1-89dd-00505699b430;
 Tue, 24 Mar 2026 20:03:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=KZO4TfexP628XLbWs8UKFttXSaPkez0IRYs4qL51jaE=;
 b=nanAUq5RL+eRCSIyHkQWDw3u5Vrsqp2mlKfHeCJ2vJkWqUbmt8SkK4RMGMzCneODob9kF3sIq5LCY
 /VGJQf8UIX6AEYw/InewBAE9in6IsMB2pKhohfwguJ0CTpsPYQAyyPZqd5dj2MnZEKoAhO9/VEFAQQ
 aC7/aqm/hU+kAdwQlpihGUof5IXSN30saRf/MrJHBCP0DbmPgxspSfq4v6+JaVAFGNBUgCHolOhx4p
 cfU5UeKD/2EQbX57YzT2MK9MokrniHY6dL8XnB8rpjmBTN6wBj8gs/tU+bAvsZZxStS9UEUPXmuDFK
 +4FrN98ID7PnuYcI0/Htp8sVUXCE0Aw==
X-KPN-MID: 33|b43U3bWdh8/hTWtrqxita+9qwbNaw03MXVqZgS1xeMhhMXRulyC9YHToPG0UBUf
 K4Ub78QqUrWGQEYb43zd8+w==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TLBwVrnIMzLl8rE1pe8dZ4zacB+4rTyA7zQFUUyZ/+efWBCsgXLeR1ItisQcoZi
 u/pF//xuIhkrhYI1acOl1Aw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 15c5ab17-27b4-11f1-8d40-00505699b758;
 Tue, 24 Mar 2026 20:03:04 +0100 (CET)
Date: Tue, 24 Mar 2026 20:03:03 +0100
Message-Id: <87fr5paw48.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: marek.vasut@mailbox.org, xypron.glpk@gmx.de, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, yuya.hamamachi.sx@renesas.com,
 andrew.goodbody@linaro.org, holger.brunck@hitachienergy.com,
 jonas@kwiboo.se, kettenis@openbsd.org,
 semen.protsenko@linaro.org, sughosh.ganu@linaro.org, trini@konsulko.com
In-Reply-To: <bdc10c1d-0235-4b07-a62a-004d61643f9a@linaro.org> (message from
 Casey Connolly on Tue, 24 Mar 2026 13:10:04 +0100)
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <6f12cae7-1dd3-4367-83d0-d35624dbfa4d@linaro.org>
 <6e74bf04-c05a-4628-8f50-b6d55a2af285@mailbox.org>
 <bdc10c1d-0235-4b07-a62a-004d61643f9a@linaro.org>
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

> Date: Tue, 24 Mar 2026 13:10:04 +0100
> From: Casey Connolly <casey.connolly@linaro.org>

Hi Casey,

> On 09/02/2026 21:44, Marek Vasut wrote:
> > On 2/9/26 7:45 PM, Casey Connolly wrote:
> > 
> > Hello Casey,
> > 
> >>> Which means, before we can really start switching boards to relocate to
> >>> 64bit space, we need to find all these remaining 32bit limitation sites
> >>> and fix them first. And to do that, we would need some way to force
> >>> allocation from 32bit space for drivers which need that ... do we
> >>> already have such a thing ? I couldn't find anything.
> >>
> >> For some (non-upstream) Qualcomm drivers we have just used lmb with
> >> LMB_ALLOC_MAX and passed in 4GB as the max address, it would be nice to
> >> have a wrapper function for this.
> >>
> >> Maybe this would just cause a whole bunch of other issues but perhaps it
> >> would be easiest to have a config option to place the malloc arena in
> >> 32-bit memory rather than always directly below U-Boot? Then again I
> >> imagine this is something that has been bikeshed in the past...
> > 
> > Are those qualcomm devices suffering from 32bit DMA limitation too ?
> 
> Yeah, this is how we handle allocating the framebuffer for
> not-yet-upstream display support.
> 
> Would it be possible to use SMMU TLBs to allow (most) 32-bit-only
> peripherals to access 64-bit addresses?

On Apple systems the IOMMU (DART) is used for USB controllers (PCI &
non-PCI).  There is an API to map/unmap addresses in U-Boot.  But only
the xhci driver uses it.

> >> *casey grumbles something about making relocation optional and merging
> >> the f/r init sequences for most boards*
> > 
> > Can you try CONFIG_SKIP_RELOCATE for your use case ?
> 
> That works fine, I'm mostly frustrated with the whole pre-reloc FDT
> scanning/DM init, lack of dcache, etc... So pretty unrelated issues heh.
> 
> -- 
> // Casey (she/her)
> 
> 
