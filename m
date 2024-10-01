Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8FDCE7D06
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 09:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB38C8910B;
	Tue,  1 Oct 2024 11:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QA+dx5xF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3234589168; Tue,  1 Oct 2024 11:51:17 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B626D8910B
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 11:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c718bb04a3so6982588a12.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727776274; x=1728381074;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2f2Az5CRLkAKLzJRW6OEjfLDsSt61YN49LX9gY7knw=;
 b=QA+dx5xFDH6QpN48Gb3d0I8eKc+Bfg2QAMZ+BkOerr8bc/u4nj0v/2U2u9hzK3Htw9
 0M+DE5QULUuiqzN+tqDL2vtZN8stxjnA7UAj/qKotn0mGcHmYtIHZzSrL3KDOapDCANO
 3Dd47bIhsjAX/CpWfvBN8YE0RABB+UVPIlGNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727776274; x=1728381074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2f2Az5CRLkAKLzJRW6OEjfLDsSt61YN49LX9gY7knw=;
 b=sXTZlXq7mbIXgnAzzmHrI3GzDsPdU7RyT4cEPajCGaNCSEDoksPu6uB74/gquItm5U
 V/OB0Y0oEa8/iFP1piapc6FPBTQerRVuRZ0Ks/glhmzi5dnya+vq+cKVZzXsImIG9xCD
 WfLrgpQMg7iVV8FpahZdnJa61zfaQB75OyFlnYvA5qDrr9Yy8/1f+fPuHRUqZx2WWKhQ
 XhiPOBUQoPTzhssEwEdArID6zIMV34xzIsaBj5IwVukFY0jRYchEh1gCk9Dg3yhEaZyd
 ZNaTuklyCRBbrqzuE6sJbY2UiXFsFtbx1yD0h1UTsdzZwk+ugxNz7cMmzKaa9LEESX+A
 LDPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkU41PuIA6qY1kTme5SvUNEYKzeWs8UqXIPQWWcYBlrc92PvZbm4hO3t0q/R6iuwy712zn3pw=@lists.denx.de
X-Gm-Message-State: AOJu0YxwU5KADrlBVvVEFqtqy2Z3prg49/4Y/XFKDCSArIg4W5aU4+Qk
 O3nqM9uxdQMO0uKc+C46thC+tdGuGJwuWN1Oh+/FBB2LYMLSmRQlm9qsuxhiHmZvcfjWqk0K/cc
 DPZElE0qzs6AcHsfbcxvgx4cqh7QAbgm0GL5Gfw==
X-Google-Smtp-Source: AGHT+IEBT7Z/4QTqA1NaTeeRipmLE2FuMvyYW2KPjtAZZg9JuUDkXf6ehP1KGrdvp9upptELQQ8YZEJ60Tthini9I9E=
X-Received: by 2002:a05:6402:440a:b0:5c8:9f3e:e57 with SMTP id
 4fb4d7f45d1cf-5c89f3e0eeamr3672655a12.18.1727776273653; Tue, 01 Oct 2024
 02:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
 <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
 <CAOf5uwm13jyOb0M9Xvx_bO1RpXhDcWqKBC-4fhZGo61Q5cjnjw@mail.gmail.com>
 <3cb57821-30f0-6aa0-2dec-313381b1350a@denx.de>
 <9ce14505-6c37-f2e8-4b5d-44f1a55f0393@denx.de>
 <20241001102908.39b2d3a6@xps-13>
 <CAOf5uwn8vhozjtMqXmWL=3Jaf05UhV7cnGn15Ywj07-PmwW_9w@mail.gmail.com>
 <20241001105057.2992e124@xps-13>
 <a91171dd-a2f2-8df7-5b11-4a35a227ef2e@denx.de>
In-Reply-To: <a91171dd-a2f2-8df7-5b11-4a35a227ef2e@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 1 Oct 2024 11:50:59 +0200
Message-ID: <CAOf5uwkw-NcSq6NDROsUJVfCTdYZcshxFyUJRW9Q-f1wcKmz=w@mail.gmail.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
To: hs@denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com, 
 Ye Li <ye.li@nxp.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all

On Tue, Oct 1, 2024 at 10:59=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Miquel,
>
> On 01.10.24 10:50, Miquel Raynal wrote:
> > Hi Michael,
> >
> > michael@amarulasolutions.com wrote on Tue, 1 Oct 2024 10:33:56 +0200:
> >
> >> Hi Miguel
> >>
> >> On Tue, Oct 1, 2024 at 10:29=E2=80=AFAM Miquel Raynal <miquel.raynal@b=
ootlin.com> wrote:
> >>>
> >>> Hi Heiko,
> >>>
> >>>
> >>>>>>> Hmm.. unfortunately ... I had applied your 2 clock patches, which
> >>>>>>> fixed a problem with enabling parent clocks ... but they broke bo=
oting
> >>>>>>> on a carrier which has fec ethernet! After "Net: " output the boa=
rd hang...
> >>>>>>>
> >>>>>>> I reverted your 2 clock patches and it bootet again ... so there =
is
> >>>>>>> a problem ... try to get some more time to look into...
> >>>>>>>
> >>>>>>
> >>>>>> We have a fec, but we had I think two patches more on it. I forget=
 to
> >>>>>> answer Marek
> >>>>>> about them because I don't have my board now and because he is
> >>>>>> partially right (or maybe right).
> >>>>>> Anyway when we boot we could have and we have clocks that are enab=
led
> >>>>>> by bootrom or SPL that
> >>>>>> we need to declare as enable like PLL2/PLL3 those clocks are parts=
 or
> >>>>>> could be part of reparent so,
> >>>>>> you need to have a reference counter on them that allow to not dis=
able
> >>>>>> during the down chain disable
> >>>>>> and up chain enable. I think that what happens to your ethernet it=
's
> >>>>>> that you disable some clock that is
> >>>>>> critical to the board to survive. I had a patch merged by Tom that
> >>>>>
> >>>>> Yep, thats what I think too! If you access registers in a block for
> >>>>> which the clock is not enabled ... it just hang...
> >>>>>
> >>>>>> prints the clock name so if you enable
> >>>>>> the debug of the clock you will find that your board stops working
> >>>>>> during one of this reparinting.
> >>>>>
> >>>>> I currently work on 2024.07... will rebase if 2024.10 is out...
> >>>>>
> >>>>> Ah, you mean:
> >>>>>
> >>>>> commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08
> >>>>> Author: Michael Trimarchi <michael@amarulasolutions.com>
> >>>>> Date:   Tue Jul 9 08:28:13 2024 +0200
> >>>>>
> >>>>>       clk: clk-uclass: Print clk name in clk_enable/clk_disable
> >>>>>
> >>>>>       Print clk name in clk_enable and clk_disable. Make sense to k=
now
> >>>>>       what clock get disabled/enabled before a system crash or syst=
em
> >>>>>       hang.
> >>>>>
> >>>>>       Signed-off-by: Michael Trimarchi <michael@amarulasolutions.co=
m>
> >>>>>
> >>>>> I have the same change when I debug :-P
> >>>>>
> >>>>> IIRC I did not see the clock names ... but I will recheck!
> >>>>
> >>>> I see with your patch the clock names, so fine... and see [1]
> >>>>
> >>>> Hmm... I am on imx8mp, and I think the changes the patchset do in
> >>>>
> >>>> "clk: imx8mn: Prevent clock critical path from disabling during repa=
rent and set_rate"
> >>>>
> >>>> are in clk-imx8mp already ...
> >>>>
> >>>> Ported the patch from patchset
> >>>>
> >>>> "[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3=
 as enabled"
> >>>>
> >>>> to imx8mp [2] and fec ethernet works again for me on imx8mp!
> >>>>
> >>>> Could you add this if you post a v2 ?
> >>>
> >>> TBH I don't feel like the below change is the correct one, it is too
> >>> specific. The clock core is recursive and thus should handle the
> >>> reparenting situations gracefully.
> >>>
> >>> I posted a series that is targeting the LVDS output on imx8mp. You
> >>> should probably consider checking these patches as well if you work
> >>> on imx8mp as well. I also had similar breakages with Ethernet which
> >>> happened during the assigned-clocks handling. This patch, which is mo=
re
> >>> future and platform agnostic, fixed it:
> >>>
> >>> https://lore.kernel.org/u-boot/20240910101344.110633-3-miquel.raynal@=
bootlin.com/
> >>>
> >>
> >> The clock patches are not specific at all. You need to have it working
> >> for the parent for each component.
> >
> > The diff shown by Heiko is explicitly enabling PLLs by naming them in
> > the iMX driver. This is not the correct approach. The problem of
> > having non-enabled new parents is global. Parent clocks should be
> > enabled before changing muxes, and this should be enforced
> > by the clock core/uclass, not the SoC drivers.
>
> Okay, valid argument.
>
> >
> >> This is a standard way to do it and nothing magic compared to other
> >> implementations.
> >
> > No, naming PLLs explicitly is not the correct approach.
> >
> >> I don't see
> >> in your series any addressing or reparent clock or take in account
> >> that a clock should be enable before
> >> reparenting.
> >
> > That's exactly the link above, whose diff is pasted here for reference:
> >
> > @@ -595,6 +595,10 @@ int clk_set_parent(struct clk *clk, struct clk *pa=
rent)
> >       if (!ops->set_parent)
> >               return -ENOSYS;
> >
> > +     ret =3D clk_enable(parent);
> > +     if (ret)
> > +             return ret;
>
> As I said before, I had *exact* the same patch and thought I made a big
> hack :-P
>
> But I wonder ... if this a generic "problem", why nobody had yet problems
> with it...

I think that a generic approach that takes into account the reparent
is more valuable, then
this. If a clock is enabled by another stage and we don't aware about
it we need to mark
as enabled. I think that this force of enable it's just a short path
that does not solve the generic
problem. I really tried to abstract what is really implemented in
other OS on the same topic.
I don't want to have a discussion about who should merge first.

Michael

>
> Thanks!
>
> bye,
> Heiko
>
> >>> My series is complimentary, even though there are some overlaps that =
we
> >>> need to merge.
> >>
> >> The only collision I can see from your series is that you re-write the
> >> imx approach of power domain.
> >> Can you please expand here a bit your point?
> >
> > Well, that's what I'd call an overlap :) There are also similar changes
> > in the clock core IIRC. Well, there is a bit of merging that needs to
> > happen I guess, but if you don't think there is any then my series can
> > enter as-is (once the comments addressed, ofc).
> >
> > Thanks,
> > Miqu=C3=A8l
> >
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de


--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
