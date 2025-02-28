Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238C2C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F683810EA;
	Fri, 28 Feb 2025 12:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QXiQ1xUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3DD810EB; Fri, 28 Feb 2025 12:37:17 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160FD80FF0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso866969241.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 03:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740742634; x=1741347434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VgwAh3dZS4OgEg/I9ABIvUlx+vw7zF2IIx7GIftQqn8=;
 b=QXiQ1xUoRR/TuoCmy4NLPZEoiEWb0LE9sWHED52s9v8p18N+wl1E4Qg8lrQlGAaDOq
 b6sBELNWCEsIQPrVLUsIXeF7BhGP+z8IQPABwUaKkv0lRGilaKwXK7m2/bmIBNov+BcQ
 T19lYFldYJZEIXncRhdHFvlcUSOThV6SoU4PGEFYCD5EQQjUuxHSEeF4qztl2Mc47rmM
 cmWbVnQC7Z2mqxps0W+aY5T81R5m5P6QuJb4klraCz1iKiWdfg5oG4SIBvUMFkmT9XxJ
 d66ri+mHJVy2WICe+s6rSTGGjUN6082V5m9H0NmVKtZKyhe2w8V19qEIRpj78+ykEz1P
 tJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740742634; x=1741347434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VgwAh3dZS4OgEg/I9ABIvUlx+vw7zF2IIx7GIftQqn8=;
 b=cUwyIlWJSHv9DgiVBi+kjBOk+PixJKpCYOw3tl8PEhloI6N2xiV3UUGenI9rvJiesp
 vCM1PTsmprOire88NKQKHSBJoZSv23fG3Rh2yccNIczL5DxmPgPrdFJYQwz/fcN6PaMb
 KirfZPFkxeaWeobMSdu6mQCIS0H48fFchqw8+EB9zH5xui6jBEi801Pe+S4y9teqbMRp
 9kUKfP+sJSOlpX9ejEtw/NgQhv9fxCaMvxmynLyTEdF6Jlm7SBRrENzVHJyjMym5sloI
 I7gb/4hlnBmmUfq8FAzfKFhOYMNuPePA4PRGOcAbR7DdwP9it9l9AOQPPjellpMdVyQw
 2zVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBh2/1ioUZRk4AmUp8LFBLAN/BpwpiYrctCNtLOzNyUxFluBvIzdPkyZ5Y92/Q7BV5K0PLYp8=@lists.denx.de
X-Gm-Message-State: AOJu0YzKXxgyXsZdIqLa+88iTQdGyC14wesVUTpg0JOsmz8NAZkZfozi
 HwQgjs60qOWhmqp+XUtuA9jp0dawLclqQp4o9pIJ5nJPhLR7OJYOWCpPUSKkn9eiEmQG2f5etaM
 NDJCQgoVDMH4CuxVbHJWuV1OcuNq9jQ/0a+0IEg==
X-Gm-Gg: ASbGncuZhd/O3CFn9BsviQIiQuvw2siC05xS5hxq0YyPK0ZNrA6/Mkt1pIKXCoa7y6p
 4D6460u3Kq+nstej6rT0TyWf2XF7vaE9omAamp95IBHOsQ14fkCaIBhJx6JTuFzcqP2f9VWnmWz
 5RyC/TAzcQ3A==
X-Google-Smtp-Source: AGHT+IHN2iXU38GsCxMKgCm8a9XaaqnwHJxuaoUmfXJwmLIFQ7dnUeI5amOfZANnV1Zc3BSixDcbbNXdt38tzxv+jvw=
X-Received: by 2002:a05:6102:440b:b0:4bb:dfd8:418f with SMTP id
 ada2fe7eead31-4c044f481c5mr1748241137.23.1740742633779; Fri, 28 Feb 2025
 03:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
 <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
 <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
 <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
 <CAFA6WYNw86eNNfBh6+omtuVFBDVzAPyU79B0s2eYfPY7U1exEA@mail.gmail.com>
 <d75a8b80-8029-4bf0-9c7c-7c72054bbdf3@linaro.org>
In-Reply-To: <d75a8b80-8029-4bf0-9c7c-7c72054bbdf3@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 28 Feb 2025 17:07:02 +0530
X-Gm-Features: AQ5f1JrL0hXBDFWYWvXN1EOzKRv7_R6WIDEtOMDDHJTWYREpY4G5MzhsQJQP_VA
Message-ID: <CAFA6WYOZCWSMu8MOAaBR1_M64vzopAFxew=2VhcvY=0PHDUz4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Manikandan.M@microchip.com, lukma@denx.de, seanga2@gmail.com, 
 kever.yang@rock-chips.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 festevam@denx.de, Oliver.Gaskell@analog.com, aford173@gmail.com, 
 prasad.kummari@amd.com, caleb.connolly@linaro.org, andre.przywara@arm.com, 
 neil.armstrong@linaro.org, mibodhi@gmail.com, Nicolas.Ferre@microchip.com, 
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 28 Feb 2025 at 16:45, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>
>
>
> On 2/28/25 12:58, Sumit Garg wrote:
> > On Fri, 28 Feb 2025 at 15:20, <Manikandan.M@microchip.com> wrote:
> >>
> >> Hi Eugen,
> >>
> >> On 27/02/25 7:48 pm, Eugen Hristev wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On 2/27/25 12:37, Manikandan.M@microchip.com wrote:
> >>>> Hi Sumit,
> >>>>
> >>>> On 27/02/25 3:14 pm, Sumit Garg wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>
> >>>>> On Thu, 27 Feb 2025 at 15:06, Manikandan Muralidharan
> >>>>> <manikandan.m@microchip.com> wrote:
> >>>>>>
> >>>>>> Add PMC clock definitions for MCK and UTMI which will be required
> >>>>>> for the sam9x7 OF_upstream DT since the clock framework is not in
> >>>>>> sync with Linux and also include this header in 'clock/at91.h' file
> >>>>>
> >>>>> You should rather drop these local DT bindings headers which will
> >>>>> allow dts/upstream/include/dt-bindings/clock/at91.h to be included
> >>>>> automatically.
> >>>> Other SoC DTs where OF_UPSTREAM migration is not added yet, depends on
> >>>> the local DT bindings header, dropping this will lead to issues with
> >>>> compilation.
> >>>> We can drop this altogether when we sync the u-boot clock framework with
> >>>> Linux.
> >>>>>
> >>>>> -Sumit
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >>>>>> ---
> >>>>>>    include/dt-bindings/clk/at91.h   | 3 +++
> >>>>>>    include/dt-bindings/clock/at91.h | 2 ++
> >>>>>>    2 files changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> >>>>>> index a178b94157b..016c6e0c620 100644
> >>>>>> --- a/include/dt-bindings/clk/at91.h
> >>>>>> +++ b/include/dt-bindings/clk/at91.h
> >>>>>> @@ -24,4 +24,7 @@
> >>>>>>    #define USB_UTMI2              1
> >>>>>>    #define USB_UTMI3              2
> >>>>>>
> >>>>>> +#define PMC_MCK                        1
> >>>>>> +#define PMC_UTMI               2
> >>>
> >>> Where in the patch series do you need these defines ?
> >>>
> >>>>>> +
> >>>>>>    #endif
> >>>>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> >>>>>> index ab3ee241d10..7235b3ba01e 100644
> >>>>>> --- a/include/dt-bindings/clock/at91.h
> >>>>>> +++ b/include/dt-bindings/clock/at91.h
> >>>>>> @@ -6,6 +6,8 @@
> >>>>>>     * Licensed under GPLv2 or later.
> >>>>>>     */
> >>>>>>
> >>>>>> +#include <dt-bindings/clk/at91.h>
> >>>>>> +
> >>>
> >>> I find this odd to include one at91.h in another at91.h
> >>>
> >>> Let's consider to remove one of these files in the future, and have just
> >>> one that is identical with the bindings one from Linux
> >>>
> >>> Meanwhile, let's see where do you need the PMC_*
> >> The PMC_MCK and PMC_UTMI are defined in the dts/upstream sam9x7 SoC DT.
> >> since during compilation the clock/at91.h from u-boot is used and to
> >> resolve the syntax issues I had to declare them in clk/at91.h and
> >> include the header in clock/at91.h
>
> I don't understand this. So , compiling sam9x7 upstream DT with upstream
> at91.h should work.
> Do you have issues with sam9x7-u-boot.dtsi that fails build ?
>
> >>
> >> if we drop the clock/at91.h from u-boot, the sam9x75 will pass using the
> >> includes from upstream Linux but will break other SoC that has not
> >> migrated to OF_UPSTREAM yet.
>
> So you need to include clock/at91.h from upstream for sam9x75 and the
> other at91.h for older SoC.
> Does that work ?

The way it works currently is you can have a single clock/at91.h
available where preference is currently given to local U-Boot copy
(for backwards compatibility) over what is available in upstream DT.
So can't have different versions of clock/at91.h available.

>
> >>
> >> Or we can align u-boot's clock/at91.h with Linux and drop clk/at91.h,
> >> replace it with clock/at91.h in drivers and DT.
> >> Please let me know if that works.
> >
> > I would rather favor the U-Boot drivers and DT to directly use
> > dts/upstream/include/dt-bindings/clock/at91.h instead and drop local
> > DT bindings import. It then becomes easier for other SoCs to migrate
> > to OF_UPSTREAM too.
>
> Sumit,
>
> The problem is that there are two at91.h with different definitions for
> the same macros. (I know... legacy reasons..)
> The drivers have to be reworked to cope with the new values. Meanwhile I
> would say that at least the new SoCs should use the right macros/bindings

Since the drivers are also common for both new and older SoCs, it's
rather better to adapt them to common bindings rather than supporting
2 different versions of clock/at91.h. If you want to do that as part
of this series or later will be based on your preference.

-Sumit

>
> >
> > -Sumit
> >
> >>>
> >>>>>>    #ifndef _DT_BINDINGS_CLK_AT91_H
> >>>>>>    #define _DT_BINDINGS_CLK_AT91_H
> >>>>>>
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>>
> >>>>
> >>>
> >>
> >> --
> >> Thanks and Regards,
> >> Manikandan M.
> >>
>
