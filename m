Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50673F3380C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D437684105;
	Tue, 17 Mar 2026 08:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q25IXKtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 920A2840CC; Tue, 17 Mar 2026 08:43:59 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E587840CC
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso665952d50.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 00:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773733435; cv=none;
 d=google.com; s=arc-20240605;
 b=hq5Qnv/8proVhYzAzb/1CB7e5WLuGGq1iC1u31Nd300gm9CXglDf2ZQwTdNWPeb5G/
 l2k/FkGOK+ATGLlALeFDzMVOjz98MmYeBRym9MKcwo03D+KxcMe9cse4F40AiqlKLbE8
 hXSTYA0IV4UywKYYcTHN4nLTM1sG5lmRN0cR7RiOiJHT7Qb/+E4Jwts91uELkayKT+V1
 HjdGecXPPTmjT47590bJPgJCV0mkwsk3Nff2HtUZ5x6uO5znw1p6smHfZNwDujwSAiLJ
 XgalDZ880YQ4BBj34IvZfS0pHe295yXucw2YsaJNTaNONxFAfUuzhE8h0HGzvQAcYFBG
 KFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sm/Ay57S+6hNiGJYLc4S4frsaa0jdUIYxyg21h4/Dvw=;
 fh=3hA+Clqkd60dDRtGqETRQmOiemDWgBXsxhM1WdK/pGo=;
 b=MzeQJiqkkLGZqrjmBI8TLd3fb9+K2H/t8yNklvg/Pos7MDD1tNrPpPw0WduUyXFX/R
 CGu7UbXiN8kPtr9osooNk/woJSJ1Q4bYTfs0d7z4lHYN5wbGsP8faA9X78rHXhBhNxHI
 +BaQqpelXjVukLLiLxZ9Plf/c754VZdVTTe8HXKHlclQh5DJIUsxH4T8+S5OR44Xyl1r
 naN2QXZ2QJ+hYvk93tnbrXVf5PAdqeygYUX+XZ+ljrDfAG1dXlXFiV9JasUb09MjKl/x
 cSLlWSd1NUnySpSViz8UAKYkwViJwEojE+0oXaCohGCUmlfJHDeyrrYViE8M6ZgiWJoR
 AwpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773733435; x=1774338235; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sm/Ay57S+6hNiGJYLc4S4frsaa0jdUIYxyg21h4/Dvw=;
 b=q25IXKtQJb2eUWYH919b5fuPnDJT9BJTerW3+c8vEEg7DoofnQJ639rqdSx/pnFXxG
 Kenrd1ZhXJe9cJzaxRkIbdSeSLUDppGH7W6iVFbUdwEQFiaQHvgkCVk/HwVHQLJDm3Ux
 vMVC/UQkFdG+VVsG4Uaswmd9gykQZpVoNeFQ0W3gYm162DuqUbApJ3QZu2t8I3TGNcJJ
 +HFrb81KZLlTGHNHAg4WBYCxjPk5CW+jG4vt3IoCZ7nIYK7aInJKd9LBWTy89+Wn9Xvx
 ATCTrtDg7HHsTCtyGyDelhU0EPAzSS8CcKMFaouLOPPP8OOWrqIouzNyOfDFKYrFz4Kj
 3W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773733435; x=1774338235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sm/Ay57S+6hNiGJYLc4S4frsaa0jdUIYxyg21h4/Dvw=;
 b=bN5hObMtsMtc70CxV7EdOee7pmCnMR7p0WFmhhU/34igJXPWRJroWGif031kZagC6+
 4x79HNLl2+zZt5By/kXbGgc/1rCBFfZW169cRXTNg7CtJXlZ0blgFW4LaEihwy7/ImZq
 BD07d0nzpgudePFGnWAH36xDRQZLXzncxUfQNBF16sSEX8Y2dKbDwv6RnGCYZVMyPmfu
 +Oetg4ZvhFokPqWjSLo+XhPV6NB/1qqfM1emQJ8frwBXL3Sb7Gv5MmyxdGS8D7sgxN/o
 7W1UfhjFGJ6OGkEpYkOZQyWQuYHIC6iLB/AQjuuyXSm+0rJGG+BdcmdE+eztkCEspdvX
 rG6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+UZIxCorblw0aUntXAPlPRJDxz61ZMbudOpQx0KQfqjH+rM4/RA/XcDgoL6qO/jvDyOz9WoA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi++C+Ue+BqdlhjqcGGvMu4wOlrV9TVy95UwmDN4vbhCk3HySc
 iQERrXc+b+/4Z3ulO7VUVN8byV99gImiU6PBrVxbnXsUEWf0EBNvU5UTWjluaGD9arV4Nx90eq4
 GezCVLP2eQOnU6ElXX+RluiXPVmfuWbW8ikhm65htRQ==
X-Gm-Gg: ATEYQzxOspc0MX7HN5q0hma+upxBPPs5FivCxWo+oj03/lL2bUPEVK5gshg7Bl6lrPA
 YkHdzCwZurtdhepE+s2jmMRM+NFCRG3wqDQ/75zmscgmuy3+QIea9MGiSB/0mdfSCBd3p9s2XB6
 nzZJ5R7ZadD8SBCooA7zZUtzsarci6yYGJ3W6gcvnNDSbunYCVFBGmczMuhNYV0Neds8fdluNvL
 hoMdBCJwsVNjtG7l0jSC5J9C5Ix88wQfXTocuxPoX2SzdXd37FnlahHWZCO7gVf2K2BT2OLhYMD
 lKwK/ztM74U7W6Alfv02sal5LP+pYvVjHu5waD130kZ/DO9hBzgLH+I3UBwsD756TG8VpvEgTaX
 EfQT3KtPwU9MPBojcsogHqBeAQBvN/jI7YNrJSefBUAnfGsPzNkmUKVyaJxI+NdQHhjVDy6tuQR
 inmLBsTIb8GsslFyf/eH3/L2v1xD30vTAKZrQ9bKu0Ta6mf5et1KXDB3Xel9z37EpE1SD0a7vee
 JZcNCSdF6pJ6EAeAa4URTEcDGA+FRBXg4ifTYx836BAhsphVEXZerp8T3SA7+zg4V9R9RsiqhG/
 5+NpdOds5ez51QSDaoyUM8l2aflpkzJQYOR0fMiLXMaS
X-Received: by 2002:a05:690e:1d0:b0:64c:a815:513e with SMTP id
 956f58d0204a3-64e889f439dmr1352414d50.3.1773733434898; Tue, 17 Mar 2026
 00:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
 <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
 <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
 <CAFLszTgdogHiTDpuwCiu3k1yA=x2-z3GxeMgj69qbpJK-s18Wg@mail.gmail.com>
 <65bb681d-b66e-42e0-b848-fa132e6255d3@amd.com>
In-Reply-To: <65bb681d-b66e-42e0-b848-fa132e6255d3@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Mar 2026 09:43:18 +0200
X-Gm-Features: AaiRm52ZPxpr8TDSGJKAFxzoG11BciOtWgQ3-qdJc2wIMTZfrqxa61ZghB8XdiY
Message-ID: <CAC_iWj+c0xSeGXdB7gCXcZneF+nbORPV3i_i6S_FeUvw=PFK0w@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, git@amd.com, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal

On Mon, 16 Mar 2026 at 09:45, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Heinrich and Ilias,
>
> On 3/16/26 03:43, Simon Glass wrote:
> > Hi,
> >
> > On Fri, 13 Mar 2026 at 09:50, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 3/13/26 16:47, Peter Robinson wrote:
> >>> On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
> >>> <ilias.apalodimas@linaro.org> wrote:
> >>>>
> >>>> Hi Michal
> >>>>
> >>>> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>
> >>>>> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
> >>>>> introduced efi_console_set_ansi() to suppress ANSI escape sequences
> >>>>> during unit tests. Extend this mechanism to be runtime-configurable via
> >>>>> the 'no_ansi' U-Boot environment variable.
> >>>>>
> >>>>> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
> >>>>> at the start of efi_setup_console_size(). This prevents
> >>>>> query_console_serial() from sending ANSI escape sequences to the
> >>>>> terminal, using default 25x80 dimensions instead. This is useful for
> >>>>> platforms where the serial console cannot handle ANSI queries.
> >>>>
> >>>> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
> >>>> It really means don't use ANSI queries to detect the console.  So
> >>>> before creating an ABI to the cmd line should we really call it
> >>>> "no_ansi" or perhaps "no_detect" and in the future clean up the
> >>>> variable names as well?
> >>>
> >>> I wonder whether this should be a Kconfig option too, a maker of a
> >>> device likely knows when this is an issue on their device and
> >>> explicitly enabling it via a config as opposed to an environment
> >>> variable would likely be useful when there's a menu enabled and the
> >>> shell possibly disabled?
> >>
> >> There are a lot of Kconfig options and variable which can aligned it.
> >> It means we can create Kconfig option for it but likely we should also have
> >> variable way as common way in uboot.
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > It might also be worth reconsidering this old patch:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-5-sjg@chromium.org/
> > https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-11-sjg@chromium.org/
> > https://patchwork.ozlabs.org/project/uboot/patch/20240902011825.746421-11-sjg@chromium.org/
>
> We have met with this problem on real HW last year and based on it we created
> this internal patch.
> https://github.com/Xilinx/u-boot-xlnx/commit/29b1330570543056188e5c065f1ea1be064b3a4b
>
> And we also send it out
> https://lore.kernel.org/all/SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com/
>
> That's why I would like to get clear guidance which way you want to go and how
> things should be changed. If you are fine with having variable/Kconfig symbol to
> disable it, then I am happy to create a patch for it.

Ok thinking about it again I think Peter has a point. Having a runtime
option would make sense if the feature would work at some point. Is
there a case that you would want to enable ANSI sequences? Otherwise
we can just turn this into a Kconfig.

>
>  From my perspective this is unwanted feature and I would like to fix it clearly
> to make sure that I don't need to handle that origin one line incorrect fix in
> our u-boot tree.
>
> Thanks,
> Michal
>
