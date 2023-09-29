Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02671E71D4F
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 15:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2470686EAA;
	Fri, 29 Sep 2023 17:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dl9DYfmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875EA86EC3; Fri, 29 Sep 2023 17:15:21 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452F78684C
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 17:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53639fb0ba4so2766861a12.0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696000519; x=1696605319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pfnus9xpd+X/eHfXpcevoJhsazoei1Vt6hEiAg4AnMc=;
 b=Dl9DYfmmHYQKLZOlZYxABNt6MOT9g64m0X4SgEtWcoXyX8xSb0gfyKtLTiIiMcPVjM
 xf36X0gq/zjZBbNnBasXU8t1RojVpfHy1BCWhGLHHRelzlyu440PkuUqgl/q+PK/sg/j
 c4dY32Uqr2Ees/pXJJvuGMK4lswbYgWfGVkZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696000519; x=1696605319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfnus9xpd+X/eHfXpcevoJhsazoei1Vt6hEiAg4AnMc=;
 b=Rbn0J6jeBQk3/xaqeqFcr4WiTMtJGv/eSOZ7WwGPMBuBlNAg4bp8rTJys+FvWO41Cp
 YqGBpphSsb5xEKCxOPnUjLk8K5EO/rTqJk4wPBqn5+o/wN22HrVsX/OrWkhQ2gfpe3jx
 pa7Ol1wbFXvMVgib1Lq9RVg6LmLjTIQ0S/3pNWwmmvoKAf6eU6A3kpyajwYwYNneWcFu
 l1KAfOhdW97LItsfVRORWoqDWB56S5YspmD8KeYJt7EVj2y2s75OdPZE8s3RIkkhR3K5
 P4hsK2KLorEi/5UcxDgIJnw471cjaF6pUDUzf0G8bMUvZMOGrfvr1L+YFdfAxCxKMSbf
 AVlQ==
X-Gm-Message-State: AOJu0YyDMRSyxI6oX4OZA1bcIxLvRa1ogskOEmSLyE3DlZGJ42yyYmJc
 SxpoXlbQxdV3zKObn//YwlxL1BMIfPWQA3vYheBVr4xDCs3tUhLXlWc=
X-Google-Smtp-Source: AGHT+IELV2GDB0n37XflEalrUzmG5xgaS6sktHLqdGyAQaSjpeMwstbswL31evo+EQeBQQFTnXy6s7SA5wm82CUJHA4=
X-Received: by 2002:a05:6402:1851:b0:522:c1b1:8cb0 with SMTP id
 v17-20020a056402185100b00522c1b18cb0mr4041093edy.33.1696000518470; Fri, 29
 Sep 2023 08:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <9658c219-1de8-3bdf-3beb-0c1e2a128569@prevas.dk>
 <20230425200932.GM1134230@bill-the-cat>
 <c3c94614-9916-7316-e009-04ddbdc205bc@prevas.dk>
 <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
In-Reply-To: <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Sep 2023 09:15:00 -0600
Message-ID: <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Rasmus,

On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 25/09/2023 20.19, Tom Rini wrote:
> > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> >>> On 03/05/2023 16.54, Tom Rini wrote:
> >>
> >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> >>>> defconfig missing one from OF_LIST but including it in the its file, so
> >>>> the above is the patch we need.
> >>>>
> >>
> >> Hi Tom
> >>
> >> Can I persuade you to try something like
> >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
> >> again, but leaving the .dtbo targets in there?
> >>
> >> I could send a patch, but it's entirely mechanical, and not really meant
> >> for being applied until we know if there's more to be cleaned up.
> >
> > So what ended up being the problem I think is the case Simon pointed out
> > where we do take the output from "make all" and concatenate one of the
> > dtbs that was generated with u-boot.img or so, and it works.  But maybe
> > that should just list all of the valid DTBs that it needs in the
> > defconfig to start with? I don't quite know, it was a case I hadn't
> > considered at the time.
> >
>
> Re-reading the thread, I can't see where that was mentioned.
>
> But yes, if some boards (still) need that, and have more than one
> possible .dtb, the board can't set an OF_LIST different from the default
> consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> SPL_LOAD_FIT || MULTI_DTB_FIT.
>
> How do we figure out if such boards even exist?

Honestly at this point I've forgotten what this is all about.

Perhaps the easiest approach is to create a new Kconfig to control
whether a board-level .dtsi is included in the list of wildcard
searches. Then you can enable it for your board without affecting
others.

Regards,
Simon
