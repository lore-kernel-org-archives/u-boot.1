Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398C9C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 10:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA86883CD;
	Tue, 25 Jun 2024 12:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="iHCg8Mxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BE687B1A; Tue, 25 Jun 2024 12:04:04 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954408844C
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 12:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3dd106e5-32da-11ef-903b-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3dd106e5-32da-11ef-903b-005056992ed3;
 Tue, 25 Jun 2024 12:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=uGf1boZkH9HOq8IoMkY1Y4TXbdJ5a8VJo5A6XTMeod8=;
 b=iHCg8MxkxGVqTw2X8/kBqgWydFlgt/t4AFSwWX/EbFQsTrJEpXbm8Vc737gzA2YfzbQdDi8kp9EgR
 fPOKRWF7cetQAVeYIJzFhBlsPKi1MCsC9iie1wBt6f28wcH/QCK2Kc7PVbOHRJoHfEeqpzyQdxBeZZ
 ppPRzNopcXKNYyfBlp3ODx+sWMxFqMJ8kJEIwnwys5U8z9W7f8+nwvD/MMUxseu6XN7qJCxcazlNYk
 ogiDaTSatPuEFn2OltLdh1aHqlf8WjbJCZvKyFS9F4OXJwMZN5/sTsUOtI8KKK3DT/AXadDtPscoIn
 8iVc6FNP6c+uZOH2uhM2Ll5QfoLwitg==
X-KPN-MID: 33|2TgO8UXJMMeGIYqgye2go1rtZrxnHMAjIOAChLEM4WFGznab8XZHfAjMdu4WWn0
 wJy2lb2ZEpAHGuRssvx9e98lUthlovC484zfTdGYGdKI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tjqyFUJpo6buLqMeDP4sdI8ztGLbLu+McWYL2/K7MBMzJ/gvtHCQm5GcRN7qQTG
 PC0CmpV1yoYUXh45JATLnvA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 3e467cc7-32da-11ef-8b56-00505699b758;
 Tue, 25 Jun 2024 12:04:00 +0200 (CEST)
Date: Tue, 25 Jun 2024 12:04:00 +0200
Message-Id: <87r0cl1gq7.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: etienne.duble@imag.fr, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, joe.hershberger@ni.com,
 ycliang@andestech.com, minda.chen@starfivetech.com,
 rfried.dev@gmail.com, sumit.garg@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <8224b226-49ba-4a6a-a736-3c0dfee0aa57@kwiboo.se> (message from
 Jonas Karlman on Tue, 25 Jun 2024 10:29:48 +0200)
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
References: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
 <2b902244-0688-432b-bd04-061a083a0fbd@imag.fr>
 <8224b226-49ba-4a6a-a736-3c0dfee0aa57@kwiboo.se>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> Date: Tue, 25 Jun 2024 10:29:48 +0200
> From: Jonas Karlman <jonas@kwiboo.se>

Hi Jonas,

> Hi Etienne,
> 
> On 2024-06-25 08:47, Etienne Dublé wrote:
> > Hi Quentin,
> > 
> > Le 24/06/2024 à 15:15, Quentin Schulz a écrit :
> >> Hi Etienne,
> >>
> >> On 6/24/24 2:40 PM, ETIENNE DUBLE wrote:
> >>> One of the PCI ranges was wrong in this device tree.
> >>> When testing with a FriendlyElec Nanopi R5C board, the
> >>> 2nd ethernet interface (labelled "wan") was not working
> >>> in u-boot because of that.
> >>>
> >>> With the correct value (found in FriendlyElec's downstream
> >>> u-boot repository), this 2nd ethernet interface now works.
> >>>
> >>> Signed-off-by: Etienne Dublé <etienne.duble@imag.fr>
> >>> ---
> >>>
> >>>   dts/upstream/src/arm64/rockchip/rk3568.dtsi | 2 +-
> >>
> >> dts/upstream is only for patches coming from **merged** Linux kernel 
> >> (i.e. releases or -rc releases or master branch from Linus Torvalds).
> >>
> >> We do not accept U-Boot-only patches in dts/upstream.
> >>
> >> Please submit the patch to the Linux kernel first and it will 
> >> eventually make it to that directory either via a 
> >> dts/update-dts-subtree.sh pull or dts/update-dts-subtree.sh pick. 
> >> Depending on maintainer's opinion, fixing the range in 
> >> arch/arm/dts/rk3568-u-boot.dtsi could be an option, but we really need 
> >> the patch sent to upstream Linux kernel community first.
> >>
> >> c.f. https://www.kernel.org/doc/html/v6.5/process/submitting-patches.html
> > 
> > I see, I will look at it.
> > In version 2 of the series I will remove this second patch and just 
> > mention that we are waiting for this problem to be fixed upstream, in 
> > the cover letter.
> 
> I do not understand the need for such/this patch. The changed address is
> the internal io address that is shared with the pci controller and
> devices.
> 
> Do you have any issue in linux or is it only in U-Boot?, I suspect this
> change is only a workaround to an issue only found in U-Boot.

I do see similar issues on OpenBSD, where some configurations of the
outbound address translation windows work fine and others don't.  It
does seem to depend on the PCIe device, but the only configuration
that seems to work for everything is when the translation of the mmio
windows is 1:1.  So for OpenBSD we build U-Boot with a pacthed device
tree.  The downside of using a 1:1 translation for mmio is that this
reduces the size of the 32-bit PCI mmio address space.

Now I can't rule out that there are bugs in the OpenBSD driver for the
RK3568 PCIe controller, but the driver seems to work fine on other
PCIe controllers derived from the Synopsis DesignWare stuff.

Etienne's diff isn't using 1:1 translation though.  It just makes sure
the lower 32 bits of the address are translated 1:1.  I'll see if I
can retest OpenBSD with such a setup.

> The rtl8169 driver or pci system of U-Boot may be of fault and should
> probably be fixed instead of changing io addresses to work around issues
> in software. E.g rtl8169 has a static ioaddr that is shared between all
> drivers, something that may cause issues.
> 
> Regards,
> Jonas
> 
> > 
> > Cheers,
> > Etienne
> > 
> 
> 
