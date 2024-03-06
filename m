Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEAFC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 11:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370BE87971;
	Wed,  6 Mar 2024 12:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UUPnDeL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991DA87D14; Wed,  6 Mar 2024 12:50:41 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F5DE87971
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 12:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7dacc916452so412932241.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709725838; x=1710330638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=avVw+SYz4Cz4D5/4rU9RdRUd9z44EKyH65+rtiTyBgU=;
 b=UUPnDeL8FmMuuyeY2dyHv+js7i9VvBdxMHwIRiXGiuhEu3T6UepJ6ytcCDjh+LAbiU
 F6JWBnJkLyiZ9iKNvaYNFwykBmZoEEiUUrdCXiMcwCXDxYyVPF7ToJMAGbza9+G6BUpY
 G5rhVzcqNyBUP0bhjb9aosrH7HbKo93tHw9CWn6wsQ8b6/RLLPKBCKEVkTjQTsQnsABf
 jANKNK2xGK/NdPnZKIf8xYHByKLCoAGPVZ91xae5K2FQvXJl0vIn2BLiVrgnyYCOTljr
 4luFzo3oavSocbhffr/xSr+72kW4NdREYV3iSKeUw5UsRRPdUNlJaQmer2mh6fu0uXEt
 7e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709725838; x=1710330638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avVw+SYz4Cz4D5/4rU9RdRUd9z44EKyH65+rtiTyBgU=;
 b=A1i2Gkf1/WLxDaZj6O/4CEPx30acsnuO/HtgqLqTDdwXl9oQGPhwyCkAt9RXkTdkP3
 FKs++rT84Inj4LUzhjxCaDZ+9Bn4PmDPYyx6qLF2keCnOg2zNH+cpKT8syQyj6IMUtKa
 JHghn3W1W/elCBVPtgmEpyo1ZYKHaBhM3Xc8vlS7MJxRI2qdn1pcKWhnaPs3QlIfciM+
 QcZi8iU6kZ0ZrP8W4Jyi7/AUIjq8BjRMi0/ytLcrH5rB6i3ekSoOTWsNL8Eg4ONVVCH+
 +rIGEOn9mxp1dpc1O0kXdytguc9CaSMtcC8gAQ2yhfk859CR8j0uyXuSJEcy3r3yTcMk
 oRJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW//m7w/F0ExjxlyAwyvKGNcOMjraWwhVcWV1jAJbCI7Jjw1Os3VpByrqd57/HghSHIruhEvZ07AH8plxYNqZX20ZucWw==
X-Gm-Message-State: AOJu0YxzC0zQWmRZT6YLleK8EiZkpoU5W2mdIQshidBt46dmNSYvCMXW
 mqQHIgccK14sTdZtFHYywn02URWqWVYyqBdXnnBQRZxFahXPRLpdz14++8hS6Oz3Njh5R3vWVFx
 r84GMfzxnJfTeKZQ676AmPDrlwCzX0cgYzYclnw==
X-Google-Smtp-Source: AGHT+IGVTQG1s5FJTEq6ZeRIUwHJwdS6lBBcWnP4fV7N7VjXPtel8Jt+UFNrPv0yYoEiXgUgt/Z+g7t8wWp9uMq2QsY=
X-Received: by 2002:a67:ffda:0:b0:471:2478:71fd with SMTP id
 w26-20020a67ffda000000b00471247871fdmr3797529vsq.33.1709725830271; Wed, 06
 Mar 2024 03:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
 <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
 <CAFA6WYNHkU2xp+6_+K0JoOpVrAP3ryS2zs+Q2L6Wb+TTVL+mWg@mail.gmail.com>
 <f0cf0576-bf5d-48f4-98ff-adf553d71657@linaro.org>
In-Reply-To: <f0cf0576-bf5d-48f4-98ff-adf553d71657@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 17:20:19 +0530
Message-ID: <CAFA6WYMaf_vvCHdi-QGmicq4R0ejOcMPU1D63WU+Znh4+maSTA@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
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

On Tue, 5 Mar 2024 at 19:45, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> [trimmed CC list a bit as this is getting offtopic for the original thread]
>
> On 05/03/2024 13:14, Sumit Garg wrote:
> > On Tue, 5 Mar 2024 at 18:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 05/03/2024 12:35, Sumit Garg wrote:
> >>> Hi Caleb,
> >>>
> >>> On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> >>>> all the devicetree files for a given vendor to be compiled. This is
> >>>> useful for Qualcomm in particular as most boards are supported by a
> >>>> single U-Boot build just provided with a different DT.
> >>>>
> >>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> ---
> >>>>  dts/Kconfig          | 24 ++++++++++++++++++++++++
> >>>>  scripts/Makefile.dts | 17 ++++++++++++++++-
> >>>>  2 files changed, 40 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/dts/Kconfig b/dts/Kconfig
> >>>> index b9b6367154ef..67d9dc489856 100644
> >>>> --- a/dts/Kconfig
> >>>> +++ b/dts/Kconfig
> >>>> @@ -100,8 +100,32 @@ config OF_UPSTREAM
> >>>>           However, newer boards whose devicetree source files haven't landed in
> >>>>           the dts/upstream subtree, they can override this option to have the
> >>>>           DT build from existing U-Boot tree location instead.
> >>>>
> >>>> +config OF_UPSTREAM_BUILD_VENDOR
> >>>> +       bool "Build all devicetree files for a particular vendor"
> >>>> +       depends on OF_UPSTREAM
> >>>> +       help
> >>>> +         Enable building all devicetree files for a particular vendor. This
> >>>
> >>> Do we really want to build all the DTBs even if many of those aren't
> >>> supported by U-Boot at all? I would have rather added Makefile targets
> >>> for boards which really supports a single defconfig eg.
> >>> qcom_defconfig.
> >>
> >> Yes, for the 4 Qualcomm SoCs currently supported there are 51 dts
> >> targets that ought to be able to run U-Boot to some extent
> >
> > Have you tested U-Boot on all of them? IMO, it would be good to make
> > people aware about supported boards via listing their DTs at least.
>
> Well the "ideal" goal is that every SoC in upstream is supported. All of
> the changes I've introduced so far work towards that end, so this is
> just another step in that direction. Obviously it's a lofty one, but I
> see no reason to intentionally make things harder for ourselves by
> gatekeeping what DTB files we build.
>
> I have additional features planned that help here, and plenty more
> ideas... But I can confirm that most of the phones (which are pretty
> much identical to the reference boards) do indeed "just work" provided
> the SoC is supported.
>
> It makes sense to use board/qualcomm/<soc-codename>/MAINTAINERS for this
> imo, there we can reference the specific dts files so device maintainers
> can be CC'd if there are relevant changes when deviceree-rebasing is
> updated.
>
> I would like to update the Qualcomm docs to describe the general
> approach here and help guide new contributors. But (as is hopefully
> obvious by this email) I'm still very much learning as I go. What do you
> think?

I am still not convinced that we should be building all the DTBs if
all of them aren't supported. The docs are there to help people about
what they have built rather than the opposite being what you have
built isn't currently supported.

However, I will let others chime in too. Maybe I am missing something.

-Sumit

> >
> >>
> >> $ ls -l dts/upstream/src/arm6/qcom/{msm8916,sdm845,msm8996,qcs404}*.dts\
> >>         | wc -l
> >> 51
> >>
> >
> > qcom_defconfig currently only supports sdm845 and qcs404.
> >
> >> What do you mean by a "makefile target"? Like copying
> >> arch/arm64/boot/dts/qcom/Makefile from Linux? I guess my concern here
> >> would be keeping it in sync, and introducing additional busywork when
> >> porting.
> >
> > See following diff:
> >
> > diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
> > index 9a8f6aa35846..ecc15021cb08 100644
> > --- a/dts/upstream/src/arm64/Makefile
> > +++ b/dts/upstream/src/arm64/Makefile
> > @@ -2,6 +2,10 @@
> >
> >  include $(srctree)/scripts/Makefile.dts
> >
> > +dtb-$(CONFIG_ARCH_SNAPDRAGON) += qcom/sdm845-db845c.dtb \
> > +       qcom/sdm845-samsung-starqltechn.dtb \
> > +       qcom/qcs404-evb-4000.dtb
> > +
> >  targets += $(dtb-y)
> >
> >>
> >> We do have a lot of Qualcomm DTS files, it takes maybe 10 seconds to
> >> compile them all on my machine, but that's only once. With incremental
> >> builds this becomes largely irrelevant.
> >
> > Maybe someone cares about build time too but that's not my primary
> > concern. We shouldn't be giving the false impression that all the DTs
> > present in the vendor directory are supported by U-Boot.
> >
> > -Sumit
>
> --
> // Caleb (they/them)
