Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D05C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 15:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA479831F5;
	Fri, 18 Apr 2025 17:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jqG04Jl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47AB83205; Fri, 18 Apr 2025 17:39:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A782383121
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 17:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4721D3F2B1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744990783;
 bh=0IczIQ/ivnflisGIxb7o0uyrxNp3frXCazl0DLKxL4s=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=jqG04Jl1YT7pOarugjgVtf9tbvEJjmpA/GvkTpFA8CcNRRowEWTFiTSrn2kn4Eqfk
 xwh2p+iMXnqGUl04IjDTB9fli5RoQKEjVS39KmtqwVVAS/8H/DII1x8j7RUgrrb3+B
 Kh+vOq5qod7cZZl1ptXK+zs/otodqEO7lFRD7Ho3iPdwpOOwiJUIRoSszT5riw6sez
 fmiI1wvHA6RXsvA6uFaPy5YWtCYo4eCbJJ5Js12u/1OCF0oVmvHfcCWFs+B/aExY4O
 NLXm8GuHYM+HXlWDg1k54sddpjhjw2b4tfmd3a/Cva3HvR1nyyJ1zS693bERhLz/LF
 k5bbWMn14WdTg==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3054210ce06so2566922a91.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 08:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744990782; x=1745595582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0IczIQ/ivnflisGIxb7o0uyrxNp3frXCazl0DLKxL4s=;
 b=obWB9IbgXRGDSLLQXJoenFeL3tkFrZvclQax78CLIcX/W86nTKx+lee5Jxn5TlCAfn
 jheCEKx013RYoOj8ge3oGhQuLcZqzaQokF5ihLryk+Qs0qVxKnj7HajrSFlnrKz2dXDC
 bL46a9aeTt0vOiNoQ7Xd6IQI+4qma5/LP7cfafk4drIa2f+AV6X+IgCQEobC2dIeQvG5
 XSC89d0DriST3ILhC7xRffZLEZu/wxEIZt0JvPP5+6vBTcPb9PyMTf76zuRdNFTW3BC5
 Wofohdf/6o/UgHp4NeMpK2scf+bnSacwmB5d3zMlLmBuxMvRLPYAfhAKqDQcAenj5EeH
 tRlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY02y/5jbRaqum9x9Q8oyrOagjQXtKwKy2WlbBeiEvo7tmdP0VKWMobuRJiwgAzJII476iuWE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyrpqx/qh/KsitOvRnfC91wWOab84nzt5nnixxtNBbvA2HxQJrC
 hPLtveYz4tWJPq3727mwPTO7jWtK1DhdA6q49l1ync35NArUfAGOcBni8FTBGC+NLfn/fq8ma1L
 5ROQzOEmO7cjmA4wJqoENlB05SwJ3B9nudFiXxqFTYMMdG5JfWCDACggwzFLvoHvMSHes2nGLSf
 S193/TltwK9cK1qwuhuPJ6iorDihWp82zp7LlRvYIUag==
X-Gm-Gg: ASbGncs7ZcPBM7FaGZ3jm73mW2IBRBeJxCXhrbdrBU4dBOxzL0iC6fB4HB8XLy26vNs
 j9qicUlkTofbLKaOZ7JF832dZN+2BOz6s7nYSvZgiLwNPo+UbNSqkSSPPuyIVNeaeSg==
X-Received: by 2002:a17:90b:582b:b0:305:2d68:8d57 with SMTP id
 98e67ed59e1d1-3087bb3f2b8mr4672292a91.5.1744990781803; 
 Fri, 18 Apr 2025 08:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeFFzzhcY8jz5RU73Ihml02Lh3FmFetD687omlncEUAgn+r11qYZHJpUnacBWR9ii17cAe+gwprdLezUcZIQQ=
X-Received: by 2002:a17:90b:582b:b0:305:2d68:8d57 with SMTP id
 98e67ed59e1d1-3087bb3f2b8mr4672268a91.5.1744990781474; Fri, 18 Apr 2025
 08:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <3148f171-8bf5-4412-97d4-684c6c456499@cherry.de>
 <CAM=mAOm1SC_SjkC6AYr4T4ThjAMCTF89wz4SVuwOYaN5vj2H5Q@mail.gmail.com>
 <ed09ef74-2723-4add-8d16-a5ffb4bd8ac4@cherry.de>
In-Reply-To: <ed09ef74-2723-4add-8d16-a5ffb4bd8ac4@cherry.de>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 18 Apr 2025 17:39:31 +0200
X-Gm-Features: ATxdqUHjRzlj8snl91J8SsNMfWtEchG2LotTX8y6Z0_g7Byckmx986KinV1olmo
Message-ID: <CAM=mAO=grtkK1chRFZz=A2T0czQ6JKNV=Pz4j+O1ojY2TOuiOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Quentin Schulz <quentin.schulz@cherry.de> schrieb am Fr., 18. Apr. 2025,
16:33:

> Hi Heinrich,
>
> On 4/18/25 4:17 PM, Heinrich Schuchardt wrote:
> > Quentin Schulz <quentin.schulz@cherry.de> schrieb am Fr., 18. Apr. 2025,
> > 15:52:
> >
> >> Hi Simon,
> >>
> >> On 4/18/25 1:39 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de
> >
> >> wrote:
> >>>>
> >>>> Hi Heinrich,
> >>>>
> >>>> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> >>>>> Currently we are no able to build with configuration fragments in our
> >> CI.
> >>>>> With this patch buildman gets a new argument --fragments for passing
> a
> >>>>> comma separated list of configuration fragments to add to the board
> >>>>> defconfigs, e.g.
> >>>>>
> >>>>>        tools/buildman/buildman \
> >>>>>        -o build \
> >>>>>        -k qemu-riscv64_smode \
> >>>>>        --fragments acpi.config
> >>>>>
> >>>>
> >>>> What about using:
> >>>>
> >>>> --fragment acpi.config --fragment fragment2.config
> >>
> >
> > Why should we type so much?
> >
> > --fragments fragment1.config,fragment2.config is shorter.
> >
> >
>
> What was suggested by Simon after is:
>
> --fragment acpi --fragment fragment2
>
> vs
>
> --fragments acpi.config,fragment2.config
>
> Shorter :) (until we have more fragments, and then the added --fragment
> is an issue :)
>
> But also because I like to use argparse features instead of reinventing
> the wheel, but that's also not a big issue :)
>
> >>> Another idea would be to also allow specifying the fragment name
> >>> without the '.config' suffix. Less to type.
> >>>
> >
> >
> > We can follow all those ideas in future patches. But first let us see the
>
> No, this is user interface, we want to change it as little as possible.
> I don't think it makes sense to support --fragments
> fragment.config,fragment2.config now to then switch to --fragment
> fragment --fragment fragment2 later on, if that's what we want.
>
> Cheers,
> Quentin


Why do want to type more? I don't.

Best regards

Heinrich

>
