Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0AEE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 09:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 718418021D;
	Thu, 19 Dec 2024 10:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eTDMYVyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D758022B; Thu, 19 Dec 2024 10:16:20 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824A28021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ9GC4q288617
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 19 Dec 2024 03:16:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734599772;
 bh=CyeyT8tleLOJpproCrvvUTzw5BHMkJcqnyfd5jstATc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=eTDMYVywF69utDdv/mAHANUZnaTxEQrtFimw/B/j7lJjTqVl2M68rDHt0DX+YH4lU
 P+d/CEhsXK1vYrE3+yVxfmay87gihDWUZslBNA2u7aF9U+zoRT+vZyeRB/4HtdOI/v
 KZ6cCIX73wEwghNNcWL/vUhRx1UVUt9AijVCvIog=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ9GCLv125617;
 Thu, 19 Dec 2024 03:16:12 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 03:16:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 03:16:12 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ9GBAS019112;
 Thu, 19 Dec 2024 03:16:12 -0600
Date: Thu, 19 Dec 2024 14:46:11 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
Message-ID: <20241219091611.piznhvwqdoiax3yl@uda0497581>
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-10-sjg@chromium.org>
 <20240710061528.4afx6lcsdsbookug@uda0497581>
 <CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com>
 <20240716044215.axz24dmwv4v5m5wo@uda0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716044215.axz24dmwv4v5m5wo@uda0497581>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Simon,

On 10:12-20240716, Manorit Chawdhry wrote:
> Hi Simon,
> 
> On 10:39-20240711, Simon Glass wrote:
> > Hi Manorit,
> > 
> > On Wed, 10 Jul 2024 at 07:15, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 09:36-20231217, Simon Glass wrote:
> > > > The existing bootph binding is defined such that properties in a
> > > > subnode are also implied in the supernode also, as in this example:
> > > >
> > > >    buttons {
> > > >       /* bootph,pre-ram is implied by btn1 */
> > > >       compatible = "gpio-keys";
> > > >
> > > >       btn1 {
> > > >          bootph,pre-ram;
> > > >          gpios = <&gpio_a 3 0>;
> > > >          label = "button1";
> > > >          linux,code = <BTN_1>;
> > > >       };
> > > >
> > > > Provide an option to implement this in fdtgrep.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Coming back to this patch as am facing some issues with the bootph-all
> > > propagation to the parent nodes [0]. We have a dmsc/sms node in our
> > > devices and it is a parent node of k3_pds, k3_clks, k3_reset.
> > >
> > > During U-boot proper we are initializing the serial console and during
> > > that time we have to make some calls to our Device manager for clocks
> > > and power domains. With the DT modelling, the clocks and power domains
> > > come under the device manager node ( dmsc/sms ) but interestingly that
> > > driver is not getting probed while putting bootph-all in the child
> > > nodes. Do you know anything about this? I thought putting it in child
> > > node will propagate it to the parent nodes as well so it'll be probed as
> > > well. We are having to put bootph-all explicitely in the dmsc/sms node
> > > for it to work.
> > 
> > Yes, that is because fdtgrep is only used with the SPL DT. The U-Boot
> > one is used unmodified by U-Boot and it does not check parents for
> > such properties (neither does SPL, but fdtgrep has logic to imply
> > these properties internally).
> > 
> > The easiest way to fix this would probably be to process the DT in
> > Binman for insertion into the final image, since Binman already does
> > lots of other DT processing.
> > 
> > If you like, you could create an issue for it [1]. If you want to have
> > a crack at fixing it, I could provide some pointers.
> 
> I am not sure if I'll be able to focus on this now but feel free to give
> your pointers, might help anyone else as well if they want to take a
> look at it.

Would you be able to give some pointers? Also I was wondering why do we
even need to process the DT in binman, why isn't the parent node probed
by default in this flow, is there some use case like that where the
child needs to be probed but not the parent before it or is it some
other bug?

> 
> Meanwhile I will open a issue as you mentioned for tracking this, trying
> to register on the URL that you provided. Thanks!

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21

Regards,
Manorit

> 
> Regards,
> Manorit
> 
> > 
> > Regards,
> > Simon
> > 
> > [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues
> > 
> > 
> > >
> > > [0]: https://lore.kernel.org/linux-arm-kernel/20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com/T/#t
> > >
> > > Regards,
> > > Manorit
