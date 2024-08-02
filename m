Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4918C3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 10:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35EC2882B7;
	Fri,  2 Aug 2024 12:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l4c1McY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41166885F4; Fri,  2 Aug 2024 12:38:54 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B329586BF1
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 12:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-820f7c6eaa5so1918910241.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722595130; x=1723199930; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RDHPfh6tPBcFp7l0KXVV8Df7TbXGYqfSXJslIDmdUBY=;
 b=l4c1McY/X8lUAyCyPf6cJf99+8pLzLzFI6YQ8egx6TalEcL2L5pOa0rPqCLNda3Ct6
 UWS5aJw/wPo0JXd+zUGhDncZmQNPDdZuFXLZQLD/bNcE52IZKxsm5kQvzLdFRgp4sSYM
 UExz+mr7CPKOgYa6CrfBBcsDc5l6Iw7ic9MrZwZl/S+7mRfSdZPiQYhasPfGCEj7W63c
 OCEhfTz8e+U4yPQKsDHXvErsGENpkgLvJPoY9BX6/bfwUZIU8loj5q8JNyeDt7Z8sSfq
 fwQvNcphPXYwTwjMnkA2ohv3Nuq8m41nH8ymKLB3mrmn5P1S4owRk0E5haDVZGTUk9Rz
 eVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722595130; x=1723199930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDHPfh6tPBcFp7l0KXVV8Df7TbXGYqfSXJslIDmdUBY=;
 b=Ntt7Xw0Hvrm0669ujXzG0WnxZ72Ttf3pfEeX59Ecj45X6tJwMg6+9+hKRUono9s6MC
 pbdfw7mAIGUqvHWeQoJkug0uQisNwOBzNo4smLlv3I7o3uKSmTs5o5M8GdgQFUtfrJcU
 FEDrLd6QIVNc+RTulV/GZUZLHz29qscs+GDCKwoKYkOaOFgyWU9oe4GOrtrs503QLFin
 f7jK1oESblO/Z+5k+VdbBs2kew/7RBPR8C6sukQ2/NId3aMkYY2qYgBN4Rth8wzr0zIq
 CFTvCVwL7eDfGwSt+96oCGjWf0HCNOU1keFlkEe33kHHgJDpg2KSpOsMdIUZtRu9+PC8
 CjNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXHsL/AlwPqgn0TdQcv/Bm6VfAz649KnGwZzInqte87FcpcrgGQSx+GMRfKk868JhWShesdLAwrfC0NxFF8OrBv7otXw==
X-Gm-Message-State: AOJu0Ywhzr3o6i+EfXxMqAIJfiLYAavASJDc3oosmwC39fMCdYthfzO9
 +0cWueUPkyNmq82yfk56+oBjiaaxRH7vsvvyzSHv8jHGDV8Yoh/g+UF1vNKc1fIMYxHoTmIkLSd
 ht02m3sa86vAAI4nX3R0khrJNRyly9sd77jaRww==
X-Google-Smtp-Source: AGHT+IFZhPtRfDrEgUx/rXThJ5RPiKHK8SenbGtXJj5Bt/TftuSlWSojdX0TrdPb+weI/QgocKTIY4Q0TrR5Dh6ZLpg=
X-Received: by 2002:a05:6102:41aa:b0:493:d4e7:4ea7 with SMTP id
 ada2fe7eead31-4945beafdc4mr4099372137.19.1722595130437; Fri, 02 Aug 2024
 03:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-10-macroalpha82@gmail.com>
 <CAFA6WYP7fnswZ4BHtqd+nKT7MZeBrKgocQf-WpJ7-HqjBOaFvQ@mail.gmail.com>
 <20240802105719.0dab15cb@donnerap.manchester.arm.com>
In-Reply-To: <20240802105719.0dab15cb@donnerap.manchester.arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Aug 2024 16:08:39 +0530
Message-ID: <CAFA6WYMqYx-sEYTKcNPDbqYii_67YVUq1xnKKRjH+F7FjOMacw@mail.gmail.com>
Subject: Re: [PATCH 9/9] sunxi: Add support for Anbernic RG35XX-2024
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 sjg@chromium.org, 
 jernej.skrabec@gmail.com, neil.armstrong@linaro.org, hdegoede@redhat.com, 
 jagan@amarulasolutions.com, trini@konsulko.com, ryan@testtoast.com, 
 Chris Morgan <macromorgan@hotmail.com>
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

Hi Andre,

On Fri, 2 Aug 2024 at 15:27, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Fri, 2 Aug 2024 12:24:56 +0530
> Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Sumit,
>
> > Hi Chris,
> >
> > On Fri, 2 Aug 2024 at 04:29, Chris Morgan <macroalpha82@gmail.com> wrote:
> > >
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > > The Anbernic RG35XX series of devices are based around an Allwinner
> > > H700 SoC with 1GB of RAM, 2 SD cards, and multiple input buttons.
> > >
> > > This bootloader has been tested on the Anbernic RG35XX-2024 and
> > > RG35XX-H, but should be suitable for the entire lineup of H700 based
> > > devices.
> > >
> > > A future series of updates will add board selection logic to identify
> > > and load the correct device tree automatically, and will switch to
> > > utilizing a mainline device tree.
> >
> > I can already see the upstream DT subtree containing DTS for this board as:
> >
> > ./dts/upstream/src/arm64/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> >
> > Are there any major differences that won't allow you to switch to
> > OF_UPSTREAM for this board?
>
> In this case there are no differences between the DT in the kernel repo
> and what we put in U-Boot. The main reason for me holding back the switch
> to OF_UPSTREAM for the H616 was indeed the rather slow update cadence,
> which somewhat slows down upstreaming of new boards like this. Doing this
> separately gives us a bit more control and freedom to take DT patches
> early, for instance when they appear in some Linux -rc1, or even before
> that (linux-next).
> I explained my position in more detail here:
> https://lore.kernel.org/u-boot/191A0F66-E2AE-4D1B-ACBE-E411E135BB61@arm.com/
>

I can see the reasoning, thanks.

> I think Tom partly convinced me that regular updates together with
> cherry-picking should solve most of those problems, so I will probably do
> the switch for the next cycle.
>

Glad to hear that. Cherry-picking has been working really well for
Rockchip platforms [1] [2] [3] as the changes appear in Linux -rc1.
Also, it pretty much avoids maintainers to review the DT changes
unless there are some bits added via *-u-boot.dtsi.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=417233
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=417377
[3] https://patchwork.ozlabs.org/project/uboot/list/?series=417353

-Sumit
