Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F178C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 13:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC59680BA8;
	Wed, 23 Apr 2025 15:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gIyuiAUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D196980FDA; Wed, 23 Apr 2025 15:05:58 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B443803DF
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 15:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1058688866b.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745413555; x=1746018355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pONad4W47YgH/NBOO5ftMONELQq6vVaWTq2YdYCZvKE=;
 b=gIyuiAUzmrdcGJFWoPvWCW3sgw6SPrGLCi0xwM4xcr+LiUcEpy4wg03Yyin5YtTfBW
 UT9QrnEtMVsH+ft+I6TqIQgPZNyqtbcy3uugUjzAHvFDbDWf067Kl6ivY/L303gW4ngD
 gCeYdqfQjTOSWUUbW+ZttEixGsqEw4evr0alo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745413555; x=1746018355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pONad4W47YgH/NBOO5ftMONELQq6vVaWTq2YdYCZvKE=;
 b=v1/ojj8N3cWaQ092F+PnA3l2DuV2wMOijoAw66pxnb+N83T1r5AS8EWIlkHbsnCk/g
 Yw17IRK0S6I52u1ziQzCBGynjhNCfZlEMe5Mc6sXRnNf9qTaeu9AS+FlYKCgEEvsILna
 uH44a9oxaYcGcPscstFlHnBhqh18h1PjX8cxwEIHl4TOiAf20pNO5wqawvWrO+yhRWnP
 7yuIEtsplkpBoZhRIcxJlpe9xElahd1e9pGa2pq61DXtJffN7XV47WzY8BRN+pFY3/GM
 FTpNZ8+q/v6HqlcP06bOP6pLiOyvbid/FjV8t7vHatO1FJXqGuo31ATdPrhH2BjY9xpy
 X86Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsPUtviPJg6pqk95zENfce7FIe7FU6nbkZ0DMQOP82G5DHF54jzGrVJ0KPUTaBtIxJWcKKYxs=@lists.denx.de
X-Gm-Message-State: AOJu0YxjYPHxnKewaAQ3e7TJDv/CMXvde3Y2av6CzGxliwc3a1UFb2Hz
 A86I2wVluwqyY0ouAGxRl/KOndX3T4r2a/J3c8iRrellh+zwoGh23kZXGlSmZkdefSqD50wcfNO
 +y5xxFMgya/iDucbt87e14TwZfpcrVwi47MDV
X-Gm-Gg: ASbGnctXs/nh8ecAbFR74jGzA3Lku160CQnmmPR2wUKOG4v7hGUPd8A5XDQOAhYCTDH
 F4Z9Qw/gynh4Jjplr6TbhBd8nx2O/oEbAESfM6M+/VEO18xaGlq2vICGpNNGAgQreKKCNdnVajb
 0BNBXG3/gA309YK46gLYIhXvbUtnJOU7cHqw==
X-Google-Smtp-Source: AGHT+IFguhYjjLF0jeRiAgVQppZL64XFZD16Mgu+0FUcY+jcBbncB+03ErctJV6Yv2ajJUuCfcyrZFPneYfaWfcGmms=
X-Received: by 2002:a17:907:1b17:b0:acb:3f1d:ca7e with SMTP id
 a640c23a62f3a-acb74af0066mr1421545966b.8.1745413555154; Wed, 23 Apr 2025
 06:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <87a587fja8.fsf@kernel.org>
 <CAFLszTiThPOHm+D=Zts9QP0mm4dYHE=kAqS1LAnfF1MLmc=QEg@mail.gmail.com>
 <874iyff3pz.fsf@kernel.org>
In-Reply-To: <874iyff3pz.fsf@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 07:05:43 -0600
X-Gm-Features: ATxdqUHKSUpnK2zvMbs9bkM--h-dFECRasFYFcQQSPYxNloKqWqHE-XHV1xGRgA
Message-ID: <CAFLszTia74jHUx0VrESU2J_w092_M8rsLwNR2fmuHp+e4JX49w@mail.gmail.com>
Subject: Re: Maintenance of Python tools
To: Mattijs Korpershoek <mkorpershoek@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi Mattijs,

On Wed, 23 Apr 2025 at 06:43, Mattijs Korpershoek
<mkorpershoek@redhat.com> wrote:
>
> Hi Simon,
>
> On mer., avril 23, 2025 at 06:28, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Mattijs,
> >
> > On Wed, 23 Apr 2025 at 01:07, Mattijs Korpershoek
> > <mkorpershoek@kernel.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On mar., avril 22, 2025 at 17:39, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> > Hi,
> >> >
> >> > Tom has indicated that he would like Patman to move out of his tree. I
> >> > suggested on another thread[1] that I maintain it in my 'sjg' tree, so
> >> > here is a new thread to discuss this.
> >> >
> >> > I have already done this for the qemu/efi/coreboot scripts as Tom has
> >> > NAK'ed patches for those.
> >> >
> >> > For the other tools there is going to be quite a bit of churn, as I
> >> > would like to resolve most of the many Python warnings.
> >> >
> >> > Given the shared source between the tools, it would be easier for me
> >> > to do the same for buildman, binman and qconfig. I am thinking that I
> >> > might try a move to allow Gitlab pull-requests for reviews on these as
> >> > well as the mailing list, if that is useful.
> >> >
> >> > For tools which need to sync back to Tom's tree (i.e. not patman), I
> >> > or Tom could do a pull request every now and then, omitting any
> >> > changes that relate to pylint.
> >> >
> >> > Please let me know your thoughts. The timing is good as I am going to
> >> > be sending out a new Patman feature in the next few weeks and it is a
> >> > few thousand more lines of code.
> >>
> >> I have a preference for binman staying in the U-Boot upstream (Tom's)
> >> tree. AFAIK, binman is used by the CI and is also very useful for composing
> >> "complex" bootloader images (For example for the TI k3 architecture).
> >> I don't know a good replacement of binman and I'm afraid that people
> >> will go back to ad-hoc scripts if binman gets removed from the tree :(
> >>
> >> On the other hand, patman is a workflow tool that's not (I think) that
> >> specific to U-Boot and is (to me) replaceable by b4.
> >>
> >> I understand that code sharing makes it more difficult to only move
> >> buildman out of upstream, but in a perfect world, I'd like binman to
> >> stay in upstream.
> >
> > Just to clarify this, I'm not suggesting removing binman. It's just
> > the maintenance and development of new features that I'm referring to.
> > We would still sync source back to Tom's tree.
>
> Got it, thanks.
>
> Wouldn't moving the binman development out of upstream reduce
> contributions/visibility?
> Or do you think that proposing alternative development process (like
> Gitlab merge requests) would attract more folks?

I'm not sure, which is why I am asking about it here, to get feedback.
I like patches on the mailing list myself, but perhaps others don't?

>
> What would be the policy for development/syncing back to upstream?
>
> What happens if binman evolves in a way that's not aligned/practical for
> upstream (Tom's tree) ?
>
> Would that mean that we would have to maintain a fork in upstream?

My thinking here is that U-Boot would simply use binman / buildman as
they are, similar to how dts-upstream (91MB), lwip (9MB) and mbedtls
(48MB) work. But yes, if Tom decides that Binman (3MB) / Buildman
(700KB) / other tools (small) have hared off in an undesirable
direction, then it would be tricky.

Regards,
Simon

> >> > [1] https://lore.kernel.org/u-boot/CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com/
>
