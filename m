Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399B1E8FDA1
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 07:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF6284228;
	Fri, 26 Dec 2025 08:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ieWpgj3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8354D84241; Fri, 26 Dec 2025 08:27:53 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49AF84212
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 08:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 910746000A;
 Fri, 26 Dec 2025 07:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87401C4CEF7;
 Fri, 26 Dec 2025 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766734068;
 bh=mVyEa/oX4sRBX9t6QULUZN4ECCufIbzpLFQA3djS1uo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ieWpgj3nVvl+t4cn9Qw74I6xHEMKqXn0KzAteukW0l8tY3tfJGNFjXIXh2glM7sOz
 d3lHlxnw75UdhtMvS1K3h+O50PCm/wdevoX60fJLyC7e5crh8izy1921hf78ErLI/o
 NSatC5Ho4Yr15g9jajCa962DKv2lvHIHK9KXh/p+qukuhbpEVLoPjsnX9PHndzY7Ok
 6UkiL8IO5snSQMi07ZdAOcYQ0AF5Jl1BISVnDEC1YuUhi5diRzmEfU/zZdFulfbaiy
 xpXYiA9MlkF3mHXZJQLMksSGFekr0/Vl0vEEjamk7YVX/vFD6WmMmOLLz0ZR6iX9lo
 KLia0zrvOz3XA==
Date: Fri, 26 Dec 2025 12:57:35 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 peng.fan@nxp.com, alif.zakuan.yuslaimi@altera.com,
 kory.maincent@bootlin.com, sjg@chromium.org,
 jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 2/7] drivers: usb: dwc3: Add delay after core soft reset
Message-ID: <aU4457bE6qsGoC9p@sumit-xelite>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com>
 <aUpbSgCIdKgtoSyT@sumit-xelite>
 <bfba5df8-9694-4ae4-b378-1a9bd81d11fa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfba5df8-9694-4ae4-b378-1a9bd81d11fa@oss.qualcomm.com>
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

On Wed, Dec 24, 2025 at 11:26:12AM +0530, Balaji Selvanathan wrote:
> 
> On 12/23/2025 2:35 PM, Sumit Garg wrote:
> > On Mon, Nov 24, 2025 at 09:24:58PM +0530, Balaji Selvanathan wrote:
> > > Add a 100 ms delay after clearing the core soft reset bit to ensure
> > > the DWC3 controller has sufficient time to complete its reset
> > > sequence before subsequent register accesses.
> > > 
> > > Without this delay, USB initialization can fail on some Qualcomm
> > > platforms, particularly when using super-speed capable PHYs like
> > > the QMP USB3-DP Combo PHY on SC7280/QCM6490.
> > > 
> > > The change is taken from following upstream Linux implementation:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/core.c?id=f88359e1588b85cf0e8209ab7d6620085f3441d9
> > If I understand correctly the kernel change here especially following
> > comment:
> > 
> > 	/*
> > 	 * Wait for internal clocks to synchronized. DWC_usb31 and
> > 	 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
> > 	 * keep it consistent across different IPs, let's wait up to
> > 	 * 100ms before clearing GCTL.CORESOFTRESET.
> > 	 */
> > 
> > the delay is required before clearing GCTL.CORESOFTRESET and not after
> > which your change seems to do. Also, here we aren't doing any role
> > switch too, right?
> 
> Hi Sumit,
> 
> You're correct about the Linux implementation. However, in U-Boot's case,
> the context is different:
> 
> 1. Linux: The delay is during role switching in dwc3_set_mode(), where only
> GCTL.CORESOFTRESET is toggled.
> 
> 2. U-Boot: The delay is in dwc3_core_soft_reset() during initial boot, which
> has a more complex sequence:
> 
>    - Sets GCTL.CORESOFTRESET
>    - Asserts PHY resets (USB2/USB3)
>    - Waits 100ms
>    - Clears PHY resets
>    - Waits 100ms (for PHY stabilization)
>    - Clears GCTL.CORESOFTRESET
> The additional delay after clearing the reset bit is needed in U-Boot to
> ensure the controller is fully operational before subsequent register
> accesses, particularly for super-speed PHYs on QCM6490/SC7280. Otherwise,
> fastboot mode is not working sometimes (stability issue).
>

I would rather suggest you to explore following kernel driver init
sequence:

dwc3_core_init() ->
  dwc3_core_soft_reset()

and see if you can have a better explanation for the delay requirement
here similar to following quote:

        /*
         * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
         * is cleared, we must wait at least 50ms before accessing the PHY
         * domain (synchronization delay).
         */
        if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
                msleep(50);

> Would you be okay with adding this delay after clearing GCTL.CORESOFTRESET?

Adding random delays in the common code may have impact on boot times
for all the platforms. We really should understand the root cause here
in case if this delay requirement is specific to a particular DWC
controller version or not?

And since your problem relates to DWC controller operating in device
mode, so you should focus on the gaps you see with corresponding kernel
driver device mode init sequence. As the kernel driver has been well
supported on Qcom platforms with adb working fine in user-space.

-Sumit

> 
> Regards,
> 
> Balaji
> 
> > 
> > -Sumit
> > 
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > > ---
> > > v2:
> > > - Gave correct commit id for linux implementation
> > > ---
> > >   drivers/usb/dwc3/core.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 847fa1f82c3..ff0bca0dd8e 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
> > >   	reg &= ~DWC3_GCTL_CORESOFTRESET;
> > >   	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > > +	mdelay(100);
> > > +
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.34.1
> > > 
