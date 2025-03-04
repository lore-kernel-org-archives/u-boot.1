Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFA3C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F216F81879;
	Tue,  4 Mar 2025 13:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jRBB5HWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB8180F96; Tue,  4 Mar 2025 06:19:14 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B8780805
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 06:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 283A85C4CFB;
 Tue,  4 Mar 2025 05:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B21EC4CEE5;
 Tue,  4 Mar 2025 05:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741065549;
 bh=C7NiRIP+6WC93vJHwVNa9y4eIUcN3c5doXlRhQuxuqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jRBB5HWfTUirOeORvTDVvVsK6z1zRdypPwAN8ESKRxgXKmm9klF9o8UGPJKasU28+
 OQz4JjzZb7WZCm0R5aFBEcYKfXCHYP33hXoStOJf7Hm/tC4g7uQMFYzsQCP5C5aS8w
 ZJXgcXDm+Fp/NqjhLiGUqEZ7KqfE0BLK/R9VE5uAb0sO8a48lQ6X2lTmIBWcpMXIYY
 G7lFz0wsrlEnHbEt0cgYtrFMO/UbLGrxGInrbHCnpS2sIsU6KcydUeBerBoUmPrPhh
 Ia8Fay/MQzSVYr9IbR6w7Gt7YAn61xRoGLbe4BhLWE4GRmtPVwJix6KsfJnq8+nxSo
 E4/ri8dE/PcQQ==
Date: Tue, 4 Mar 2025 10:48:59 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Manikandan.M@microchip.com
Cc: sumit.garg@linaro.org, eugen.hristev@linaro.org, lukma@denx.de,
 seanga2@gmail.com, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, caleb.connolly@linaro.org,
 andre.przywara@arm.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, Nicolas.Ferre@microchip.com,
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Message-ID: <Z8aNQ7R2ZarwsJCj@sumit-X1>
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
 <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
 <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
 <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
 <CAFA6WYNw86eNNfBh6+omtuVFBDVzAPyU79B0s2eYfPY7U1exEA@mail.gmail.com>
 <d75a8b80-8029-4bf0-9c7c-7c72054bbdf3@linaro.org>
 <CAFA6WYOZCWSMu8MOAaBR1_M64vzopAFxew=2VhcvY=0PHDUz4w@mail.gmail.com>
 <afc3ff33-81b5-4728-9f00-1dac02dd8fad@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc3ff33-81b5-4728-9f00-1dac02dd8fad@microchip.com>
X-Mailman-Approved-At: Tue, 04 Mar 2025 13:58:09 +0100
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

On Mon, Mar 03, 2025 at 10:26:15AM +0000, Manikandan.M@microchip.com wrote:
> Hi Eugen and Sumit,
> 
> On 28/02/25 5:07 pm, Sumit Garg wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, 28 Feb 2025 at 16:45, Eugen Hristev <eugen.hristev@linaro.org> wrote:
> >>
> >>
> >>
> >> On 2/28/25 12:58, Sumit Garg wrote:
> >>> On Fri, 28 Feb 2025 at 15:20, <Manikandan.M@microchip.com> wrote:
> >>>>
> >>>> Hi Eugen,
> >>>>
> >>>> On 27/02/25 7:48 pm, Eugen Hristev wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>
> >>>>> On 2/27/25 12:37, Manikandan.M@microchip.com wrote:
> >>>>>> Hi Sumit,
> >>>>>>
> >>>>>> On 27/02/25 3:14 pm, Sumit Garg wrote:
> >>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>>>
> >>>>>>> On Thu, 27 Feb 2025 at 15:06, Manikandan Muralidharan
> >>>>>>> <manikandan.m@microchip.com> wrote:
> >>>>>>>>
> >>>>>>>> Add PMC clock definitions for MCK and UTMI which will be required
> >>>>>>>> for the sam9x7 OF_upstream DT since the clock framework is not in
> >>>>>>>> sync with Linux and also include this header in 'clock/at91.h' file
> >>>>>>>
> >>>>>>> You should rather drop these local DT bindings headers which will
> >>>>>>> allow dts/upstream/include/dt-bindings/clock/at91.h to be included
> >>>>>>> automatically.
> >>>>>> Other SoC DTs where OF_UPSTREAM migration is not added yet, depends on
> >>>>>> the local DT bindings header, dropping this will lead to issues with
> >>>>>> compilation.
> >>>>>> We can drop this altogether when we sync the u-boot clock framework with
> >>>>>> Linux.
> >>>>>>>
> >>>>>>> -Sumit
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >>>>>>>> ---
> >>>>>>>>     include/dt-bindings/clk/at91.h   | 3 +++
> >>>>>>>>     include/dt-bindings/clock/at91.h | 2 ++
> >>>>>>>>     2 files changed, 5 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> >>>>>>>> index a178b94157b..016c6e0c620 100644
> >>>>>>>> --- a/include/dt-bindings/clk/at91.h
> >>>>>>>> +++ b/include/dt-bindings/clk/at91.h
> >>>>>>>> @@ -24,4 +24,7 @@
> >>>>>>>>     #define USB_UTMI2              1
> >>>>>>>>     #define USB_UTMI3              2
> >>>>>>>>
> >>>>>>>> +#define PMC_MCK                        1
> >>>>>>>> +#define PMC_UTMI               2
> >>>>>
> >>>>> Where in the patch series do you need these defines ?
> >>>>>
> >>>>>>>> +
> >>>>>>>>     #endif
> >>>>>>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> >>>>>>>> index ab3ee241d10..7235b3ba01e 100644
> >>>>>>>> --- a/include/dt-bindings/clock/at91.h
> >>>>>>>> +++ b/include/dt-bindings/clock/at91.h
> >>>>>>>> @@ -6,6 +6,8 @@
> >>>>>>>>      * Licensed under GPLv2 or later.
> >>>>>>>>      */
> >>>>>>>>
> >>>>>>>> +#include <dt-bindings/clk/at91.h>
> >>>>>>>> +
> >>>>>
> >>>>> I find this odd to include one at91.h in another at91.h
> >>>>>
> >>>>> Let's consider to remove one of these files in the future, and have just
> >>>>> one that is identical with the bindings one from Linux
> >>>>>
> >>>>> Meanwhile, let's see where do you need the PMC_*
> >>>> The PMC_MCK and PMC_UTMI are defined in the dts/upstream sam9x7 SoC DT.
> >>>> since during compilation the clock/at91.h from u-boot is used and to
> >>>> resolve the syntax issues I had to declare them in clk/at91.h and
> >>>> include the header in clock/at91.h
> >>
> >> I don't understand this. So , compiling sam9x7 upstream DT with upstream
> >> at91.h should work.
> >> Do you have issues with sam9x7-u-boot.dtsi that fails build ?
> >>
> >>>>
> >>>> if we drop the clock/at91.h from u-boot, the sam9x75 will pass using the
> >>>> includes from upstream Linux but will break other SoC that has not
> >>>> migrated to OF_UPSTREAM yet.
> >>
> >> So you need to include clock/at91.h from upstream for sam9x75 and the
> >> other at91.h for older SoC.
> >> Does that work ?
> > 
> > The way it works currently is you can have a single clock/at91.h
> > available where preference is currently given to local U-Boot copy
> > (for backwards compatibility) over what is available in upstream DT.
> > So can't have different versions of clock/at91.h available.
> > 
> >>
> >>>>
> >>>> Or we can align u-boot's clock/at91.h with Linux and drop clk/at91.h,
> >>>> replace it with clock/at91.h in drivers and DT.
> >>>> Please let me know if that works.
> >>>
> >>> I would rather favor the U-Boot drivers and DT to directly use
> >>> dts/upstream/include/dt-bindings/clock/at91.h instead and drop local
> >>> DT bindings import. It then becomes easier for other SoCs to migrate
> >>> to OF_UPSTREAM too.
> >>
> >> Sumit,
> >>
> >> The problem is that there are two at91.h with different definitions for
> >> the same macros. (I know... legacy reasons..)
> >> The drivers have to be reworked to cope with the new values. Meanwhile I
> >> would say that at least the new SoCs should use the right macros/bindings
> > 
> > Since the drivers are also common for both new and older SoCs, it's
> > rather better to adapt them to common bindings rather than supporting
> > 2 different versions of clock/at91.h. If you want to do that as part
> > of this series or later will be based on your preference.
> 
> To ensure consistency and compatibility with upstream, I'll rename the 
> local clock/at91.h to clock/at91-pmc-status.h in U-Boot and update the 
> relevant legacy SoC Device Trees to reflect this change.
> This will allow the new sam9x7 SoC DT and driver to utilize the standard 
> upstream dt-bindings/clock/at91.h without modifications.
> We shall later refine at91-pmc-status.h during clock synchronization 
> with Linux.
> Please let me know if this sounds good
>

Sounds reasonable to me.

-Sumit
