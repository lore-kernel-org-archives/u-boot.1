Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0284E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753FF80328;
	Thu, 19 Dec 2024 16:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PjN73w1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5A28021A; Thu, 19 Dec 2024 16:09:50 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E508022B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso164482966b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620988; x=1735225788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t7RE8VdBFULq8tVx8npaBlecrrHy497yE5Vnu4XvXVU=;
 b=PjN73w1TYCYyMMgnKfMnY0W9cszSkpQ9uAVed3gy5gFPj3gFhQBG077P0fFkg2rmz/
 z0I/SRJRF/6r0nxruaczbBccbMNHjNB12lx39Cr5KaLsAAIx9t7Wx09u1f+K+6ih+KOJ
 4WIH+97FFgrwbxd3dsl8nWSaSI33IMFnDGitU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620988; x=1735225788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7RE8VdBFULq8tVx8npaBlecrrHy497yE5Vnu4XvXVU=;
 b=Yl6aypm4n1wrATtrXEIaO55SjBGmvJrdgkMvFocytU3Uq2Pk2nJYLfCtx3Ahw4VJrP
 o3pyv7g3mQUhaSCorJWyb9vO1CWSvvaECcDU62iu8O2EvT0PGG34BMZu/FPw9NxwK0cT
 eWJ0jj/nizGRsBaca6rPoWS8QZAzwczJ3p6uorSlyMDvodP/6WOhHagD/y78s8z6oSaz
 blbS7+aBJMgAwve3XtVS/whrDnQW43t7fMViepbOq1nNWe9rig52ekn5K0PWEgieF9gP
 hbWsB7LpDeShaacdfhv4SgMX7UaNoxfa38UwqtTkfv5VP7UcHklvk2oA+8zBYsj+R/cA
 +mpQ==
X-Gm-Message-State: AOJu0Yxxt2oVFk/TDE9L57bmVJ6lkMM2XHKS7MODTEgl6CgQa/e3VOfV
 JyGNWMn2HTyemhrTYxNBkumq2txWhyhro/NZfolj4iUhnfJzcog+H+li68y/PsXpWzLKprN2TdU
 mU8BEZ0psIzhkjj5KtjlVVT9OxBHLQFrcf9GC
X-Gm-Gg: ASbGnctLO/Xwz9bqKMiST3JbUyMsZqJ4gX0mpkN+fS2QT7sGsudV3e9HbX3z+9EmZPG
 MGUe1tIo+gL1HNvQiK4QFpyjBTbsJkFUfEaHT4xw=
X-Google-Smtp-Source: AGHT+IHRFNR0IGFzVD2Xq7fZGB9ak2ySzq6zBkQuRzf7O9bX0GUy5ErusSG3Ndz+9GLuR+PuwUEmI9/QLUc74uGV644=
X-Received: by 2002:a17:907:9491:b0:aa6:7d82:5413 with SMTP id
 a640c23a62f3a-aabf47f755emr564328866b.34.1734620987492; Thu, 19 Dec 2024
 07:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-10-sjg@chromium.org>
 <20240710061528.4afx6lcsdsbookug@uda0497581>
 <CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com>
 <20240716044215.axz24dmwv4v5m5wo@uda0497581>
 <20241219091611.piznhvwqdoiax3yl@uda0497581>
In-Reply-To: <20241219091611.piznhvwqdoiax3yl@uda0497581>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:09:36 -0700
Message-ID: <CAFLszTiEZYoo+=+MJg7sgN93k144zEi18A5_Hk+J3sce00g+=w@mail.gmail.com>
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
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

Hi Manorit,

On Thu, 19 Dec 2024 at 02:16, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 10:12-20240716, Manorit Chawdhry wrote:
> > Hi Simon,
> >
> > On 10:39-20240711, Simon Glass wrote:
> > > Hi Manorit,
> > >
> > > On Wed, 10 Jul 2024 at 07:15, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 09:36-20231217, Simon Glass wrote:
> > > > > The existing bootph binding is defined such that properties in a
> > > > > subnode are also implied in the supernode also, as in this example:
> > > > >
> > > > >    buttons {
> > > > >       /* bootph,pre-ram is implied by btn1 */
> > > > >       compatible = "gpio-keys";
> > > > >
> > > > >       btn1 {
> > > > >          bootph,pre-ram;
> > > > >          gpios = <&gpio_a 3 0>;
> > > > >          label = "button1";
> > > > >          linux,code = <BTN_1>;
> > > > >       };
> > > > >
> > > > > Provide an option to implement this in fdtgrep.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Coming back to this patch as am facing some issues with the bootph-all
> > > > propagation to the parent nodes [0]. We have a dmsc/sms node in our
> > > > devices and it is a parent node of k3_pds, k3_clks, k3_reset.
> > > >
> > > > During U-boot proper we are initializing the serial console and during
> > > > that time we have to make some calls to our Device manager for clocks
> > > > and power domains. With the DT modelling, the clocks and power domains
> > > > come under the device manager node ( dmsc/sms ) but interestingly that
> > > > driver is not getting probed while putting bootph-all in the child
> > > > nodes. Do you know anything about this? I thought putting it in child
> > > > node will propagate it to the parent nodes as well so it'll be probed as
> > > > well. We are having to put bootph-all explicitely in the dmsc/sms node
> > > > for it to work.
> > >
> > > Yes, that is because fdtgrep is only used with the SPL DT. The U-Boot
> > > one is used unmodified by U-Boot and it does not check parents for
> > > such properties (neither does SPL, but fdtgrep has logic to imply
> > > these properties internally).
> > >
> > > The easiest way to fix this would probably be to process the DT in
> > > Binman for insertion into the final image, since Binman already does
> > > lots of other DT processing.
> > >
> > > If you like, you could create an issue for it [1]. If you want to have
> > > a crack at fixing it, I could provide some pointers.
> >
> > I am not sure if I'll be able to focus on this now but feel free to give
> > your pointers, might help anyone else as well if they want to take a
> > look at it.
>
> Would you be able to give some pointers?

Can we first just be clear on the problem? Is it that before
relocation, devices are not bound because the bootph tag is not there?
Can you update your issue with a bit more info?

If so, then there are two options I can think of:

1. Update dm_scan_fdt_node() / lists_bind_fdt() so that it scans
children before relocation, even when a parent does not have the
required bootph tag. But it only binds the parent if any of its
children have the tag. This should be possible and I suspect the
performance would be OK.

2. Update binman so that it adds tags into the devicetree when it sees
that they are implied in a parent. This would avoid code changes in
U-Boot, and perhaps be a bit faster.

> Also I was wondering why do we
> even need to process the DT in binman, why isn't the parent node probed
> by default in this flow, is there some use case like that where the
> child needs to be probed but not the parent before it or is it some
> other bug?

Basically, Rob Herring wanted to have child tags implied in the
parent. This was the 'deal' under which the bootph stuff went into the
schema. U-Boot has never supported this previously, of course and we
have had to add the tags manually in the parent, when any child needs
it. But anyway Rob's idea seemed reasonable to me since it is actually
a pain to add these tags in parents, particular when there are several
levels of hierarchy, e.g. an soc node, etc.

So I then implemented this in fdtgrep, thinking that this was the end
of the story, but as you have found (if I have this right), it is not.

>
> >
> > Meanwhile I will open a issue as you mentioned for tracking this, trying
> > to register on the URL that you provided. Thanks!
>
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21

> > > [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues
> > >
> > >
> > > >
> > > > [0]: https://lore.kernel.org/linux-arm-kernel/20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com/T/#t
> > > >
> > > > Regards,
> > > > Manorit

Regards,
Simon
