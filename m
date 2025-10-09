Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC65CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 17:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFE084582;
	Thu,  9 Oct 2025 19:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TpvD39/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E980984592; Thu,  9 Oct 2025 17:27:04 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055D184461
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 17:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-59f64abbb61so482608137.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760023620; x=1760628420; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVnn++UfG6oanfFGicKyuP/5qV4oRruqpXqmNlbkiSg=;
 b=TpvD39/5pojsLnbQTFgQOjjHJtGdrKeV/8Xjy5nGcLux9diREXIZMdpJGF8MMLWVyE
 eObpX/G9DO9xAdUASDFEeGbeWhH0vSFblIFwtNDJdJElQizg6iWFymWIX/VFdfB4ofsK
 5VT7RPsuKX0WXVlEXBjdNVsCfPlfvXrRVDaT/DdIfZLN5vl5d4D2gLjOC4xyqhJgas79
 zL+kfDhunUHVMEl7+9XJYwXg3qz2yy4SB+GMelGPM8THnvA2LsxGojCKw2LCOndg9JII
 Zj9Qk6d46UjlGPsTIS5UbfCtcxMOp6IP4D9k0jLgrmB9MamThtgLLDaD6KzNk9mqQpe5
 xRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023620; x=1760628420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZVnn++UfG6oanfFGicKyuP/5qV4oRruqpXqmNlbkiSg=;
 b=gEHwGQKC8+Kes9cPpPKyx+48MN4Gg+zq11Jxog2Wrgx1Y2qasUcjjglvyGRM3LuEKY
 j29bJJCLqdt8ZQYd7kCa1dMeiBuAQR231B5Or1LOJ4f5D5sqXUZLhJOq8i+vMroKu0TU
 X2LiVpnQm36XJh6lgZcrzy+VVFephrvPOA2Jr6fTZZVHmpfdEcZyY7Y1dsFhIqoSICJc
 0ST8aqypzLaF66iBab2TU9U1efu+rN0pZwdhhVqxteiMiB7iO7kiRJ5SD0GeloOA+7TQ
 XTmQ0iXwE7IRCbepc3p3PiqW2dawItn/fCgkgD9+quw9Veq0zSjGS0Mkte/zK+cNRxTZ
 HciQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVotwgKv3H1gk3g2myl/m0rSAt/OZ3o74YKV/cU34kmCRr2X8lvLoAzLHu/hVswGdGxnoR7nbo=@lists.denx.de
X-Gm-Message-State: AOJu0YxY0e4CFsCZaMSestpLybsYM+qMKtno4De4z6RjcWVCuNikZMNG
 d+0nwZd1N2qo8vlvu+/b3IHFMQLfxv4QXJ+FuJ4fRRr3zsZSQFbJPbkLVlAFy1+do9Tp0Gd0cbQ
 dESHRrGt8Ukdg0tl7ki+HUe1GevEh6L8=
X-Gm-Gg: ASbGnctLgbIbji+yLAsvzZlZQhbed+xPqKvYrChGjRjgxLySBbEDgH1gHmjYSyfWbJ6
 UrKPZq41xPax1brA+RVCveIHPU3NQemg6xIylz8LyG/VtsjA9fwO2kB6eLjRr/NamEAUXWHOmtm
 sflG03xjWRrBVfx+uyHsjagfRtedmqEF86tkuhFMZ49KSa/bHofW8+uG0qRgFjimtN4zGveJLvL
 W9IzG70jMCMdDr/C3Bzm7xYfp0tF0UHO+60UNOJ63A=
X-Google-Smtp-Source: AGHT+IH7b6DkN78zqKaSfB2zkEXy8Q61Sxb3c9WhDkf1gSamgcq172kuSzHVUy38Fx1L8z/VZ1+bRuWYG53+6x1DDRc=
X-Received: by 2002:a67:e704:0:b0:52a:320b:5742 with SMTP id
 ada2fe7eead31-5d5e2358620mr3648245137.18.1760023619653; Thu, 09 Oct 2025
 08:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org> <873484jt3u.fsf@kernel.org>
 <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
 <CADgMGSu1es4dex1u=6ai4WEBK2Loo2RAZdONRf07AqTWhZL8mQ@mail.gmail.com>
 <CADgMGSu7n+85gzdescBJd27WKvwryhtvXzY4MX3BWR=oLsLyhA@mail.gmail.com>
 <CAFLszTg9pwt7p45hE-z+bLM-RNofCouYA-jtXDw7RP+HbFQ3Jw@mail.gmail.com>
 <CADgMGSuH21te1Mqy3Z0C8R6seoUHLffvLyuVY-ukVtKHi3GVOA@mail.gmail.com>
 <875xcow8d9.fsf@kernel.org>
In-Reply-To: <875xcow8d9.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Thu, 9 Oct 2025 23:26:47 +0800
X-Gm-Features: AS18NWCR_93BLnLsN1dFQ9ssQQLVvX9vRSDOLRHlGx3j6eG0YDYyZas0cuppLTE
Message-ID: <CADgMGSt6BCPvqcd5z_qOJHJ_S9hsfdb3gVb3pS5MaRf8oBfyEg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Thu, 09 Oct 2025 19:07:04 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon and Mattijs,




=E5=9C=A8 2025=E5=B9=B410=E6=9C=889=E6=97=A5=E9=80=B1=E5=9B=9B 20:46=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi George,
>
> On Wed, Oct 08, 2025 at 00:03, george chan <gchan9527@gmail.com> wrote:
>
> > Hi Simon,
> >
> > Thx for feedback.
> >
> >
> > =E5=9C=A8 2025=E5=B9=B410=E6=9C=887=E6=97=A5=E9=80=B1=E4=BA=8C 04:38=EF=
=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >> Hi George,
> >>
> >> On Sun, 5 Oct 2025 at 09:41, george chan <gchan9527@gmail.com> wrote:
> >> >
> >> >
> >> >
> >> > =E5=9C=A8 2025=E5=B9=B410=E6=9C=885=E6=97=A5=E9=80=B1=E6=97=A5 00:35=
=EF=BC=8Cgeorge chan <gchan9527@gmail.com> =E5=AF=AB=E9=81=93=EF=BC=9A
> >> >>
> >> >> Hi Simon and Mattijs,
> >> >>
> >> >> Thx for feedback. Just in case the discussion drift to other
> direction,
> >> do let me have a chance to put some background info here.
> >> >>
> >> >> there are ways for pre-set env variable and its value. Firstly
> external
> >> env file and loaded by uboot, like, runtime handling; and another type
> is
> >> build time embed env file into uboot body.
> >> >>
> >> >> maybe in chromeos case first stage boot loader will pass along
> bootinfo
> >> struct to uboot and treat as preset defaults.
> >> >>
> >> >> so in either case uboot can have right to choose the preset from (b=
y
> >> disable external env file, secured/trusted boot?), and then either
> follow
> >> the bootinfo struct preset value and/or concat and/or overrite with
> uboot=E2=80=99s
> >> own embedded env value at boot time, and then runtime modify.
> >> >>
> >> >> This behavior maybe enable or disable by kconfig. but in secured bo=
ot
> >> context point of view, env file kind of thing, might have potential
> design
> >> wise conflict. And this is not within my scope.
> >> >>
> >> >> in some other use case like simulation of vendor bootloader behavio=
r
> to
> >> have a build time preset default value, this is within my scope. and
> thats
> >> why i decided to put those preset into env file and embeded.
> >> >>
> >> >> let me reply below inline.
> >> >>
> >> >> =E5=9C=A8 2025=E5=B9=B410=E6=9C=882=E6=97=A5=E9=80=B1=E5=9B=9B 00:2=
2=EF=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
> >> >>>
> >> >>> Hi Mattijs, George,
> >> >>>
> >> >>> On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
> >> >>> <mkorpershoek@kernel.org> wrote:
> >> >>> >
> >> >>> > Hi Simon,
> >> >>> >
> >> >>> > Now that you are back, could you please have a look at ...
> >> >>> >
> >> >>> > On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <
> >> mkorpershoek@kernel.org> wrote:
> >> >>> >
> >> >>> > > Hi George,
> >> >>> > >
> >> >>> > > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.co=
m
> >
> >> wrote:
> >> >>> > >
> >> >>> > >> Hi Mattijs,
> >> >>> > >>
> >> >>> > >> Thx for reply.
> >> >>> > >>
> >> >>> > >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=
=89 17:05=EF=BC=8CMattijs Korpershoek <
> mkorpershoek@kernel.org>
> >> =E5=AF=AB=E9=81=93=EF=BC=9A
> >> >>> > >>
> >> >>> > >>> Hi George,
> >> >>> > >>>
> >> >>> > >>> Thank you for the patch.
> >> >>> > >>>
> >> >>> > >> ...
> >> >>> > >>
> >> >>> > >>>
> >> >>> > >>> > -     ret =3D env_set("bootargs", cmdline);
> >> >>> > >>> > +     ret =3D android_image_modify_bootargs_env(cmdline,
> NULL);
> >> >>> > >>>
> >> >>> > >>> I don't think it can be done this way. bootm_boot_start() is
> >> used in the
> >> >>> > >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
> >> >>> > >>>
> >> >>> > >>
> >> >>> > >> I got your point. I have 3 ideas come out.
> >> >>> > >>
> >> >>> > >> (1) The logic purposely empty the env bootargs, either
> developer
> >> don't use
> >> >>> > >> env bootargs or those use cases touched bootargs in some earl=
y
> >> step. And
> >> >>> > >> then wanna disregard previous u-boot bootmeth operation, and
> >> empty bootargs
> >> >>> > >> for that ongoing bootmeth stage...well that's not congruent
> >> behavior; I
> >> >>> > >> have a gut feeling this is a bug or band-aid anyway, it close=
d
> >> the door for
> >> >>> > >
> >> >>> > > Simon, is it *intentional* that override the bootargs variable
> in
> >> >>> > > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
> >> >>> > >
> >> >>> > > Shouldn't we get the bootargs from the environment, and append
> >> cmdline
> >> >>> > > to the existing bootargs instead ?
> >> >>>
> >> >>> The way U-Boot operates today, bootargs defines the entire cmdline=
,
> >> >>> not just part of it. So if you use 'env set bootargs ..' you are
> >> >>> changing the entire cmdline passed to Linux, etc.
> >> >>
> >> >>
> >> >> This is runtime change. My test case in fastboot path, it get
> bootargs
> >> wiped and filling in with something from boot img. That might share sa=
me
> >> procedure with other boot method like chromeos do. Wipe env default ea=
ch
> >> time in fastboot (when fail) might be a secure-wise handling.
> >> >>
> >> >> And I feel it is a critical entry point logic like a central hub, a=
nd
> >> looking good to decide uboot behavior here. By kconfig whatever? Again=
,
> out
> >> of my scope.
> >> >>
> >> >>>
> >> >>> With ChromeOS, after 'bootflow read', the cmdline can be edited
> using
> >> >>> 'bootflow cmdline set' etc., which also changes bootargs. But in
> >> >>> general ChromeOS provides the whole Linux cmdline to U-Boot.
> >> >>
> >> >>
> >> >> this is also runtime change. And as a side note, if by doing bootfl=
ow
> >> select, should env bootargs gets overrided or appended? This is a bigg=
er
> >> arch-wise question worth at least a public paper. and I might not go
> into
> >> this depth.
> >> >>
> >> >>>
> >> >>> If you are wanting to append, I suggest writing a new function, or
> >> >>
> >> >>
> >> >> yeah agreed. I do more appreciate and feel it really lower project
> >> management/test cost.
> >> >>
> >> >>> perhaps adding a 'bool append' arg to bootm_boot_start(), if all t=
he
> >> >>> other code is useful for Android.
> >> >>
> >> >>
> >> >> A more simpler method is to create
> bootm_boot_start_ex(kernel_cmd_line,
> >> vendor_cmd_line) as
> >> >>  I proposed to complement with
> >> >>  bootm_boot_start(cmdline) or even add one layer of abstract, calle=
d
> >> from bootm_boot_start(), make vendor_cmd_line param as null. As can
> >> preserve the old logic and behavior.
> >> >>
> >> >> So build time env preset value, and runtime value override decision
> can
> >> live in this new function, or elsewhere; but is not within my scope.
> >> >
> >> >
> >> > Tr/Dr I wrote a proof of concept code here:
> >> >
> >> >
> >>
> https://github.com/99degree/u-boot/compare/before_tag...reboot-mode?expan=
d=3D1
> >>
> >> This thread is a bit confusing now, but it seems you have written a
> >>
> >
> > I am sorry but I had to prove my patch is necessary and correctnessly a=
nd
> > also limit the scope of the patch. Thanks for your understand.
> >
> > new function and that is fine with me, as it won't affect ChromeOS.
> >>
> >
> > There is no new function at all. I am sorry to put more info here again
> to
> > let related code to be clear for every audience here.
> >
> > As you may notice function bootm_modify_bootargs_env() is a renamed and
> > move to bootm.c which is split/extracted from existing function
> > android_image_get_kernel()
> >
> > And bootm_boot_start_ex() is split from
> > bootm_boot_start() with your suggested enable param.
> >
> > I am afraid if you or other reviewer might wonder why move to bootm.c a=
nd
> > here is the reason.
> >
> > Supposed with below 2 code paths:
> >
> > Boot->bootflow->bootmeth_android->bootm
> > Boot->fastboot->do_bootm->bootm
> >
> > I believe android_image_get_kernel is living around within
> bootmeth_android
> > stage so first two patch has taken care of. But fastboot path is not.
> that
> > might be the reason above two path need separate special handling for.
> >
> > So as to code reuse with fastboot path then those code had to move to
> bootm
> > layer.
>
> Initially, I did not understand that you were wanting to support both
> "fastboot boot" and booting via bootmeth_android.
>
> Things make more sense now. Please send a new series so that Simon and I
> can review. Thanks again for your patience!
>

Thanks for feedback. if you have other detail wanted to share or have in
next round, please let me know. I planed to have next submission mid/end
next week. If you feel comfortable with GitHub code diff, please take a
closer look and I can make modification accordingly.

Regards,
George

>
>
> >
> > And my understanding each stage is isolated, and depends on env as a ki=
nd
> > of api to link up each stage. Then I believe the patch is now a clean
> > solution. Anyway welcome to jot a mail if there are suggestions, if any
> > doubt, please jot a mail too.
> >
> > Thanks,
> > George
> >
> >
> >>
> >> >
> >> >
> >> >>
> >> >> So I leave it as a open-end question here. Once you had decided the=
n
> >> feel free to let me know and I can do one extra round patch. Thank aga=
in
> >> for feedback.
> >> >>
> >> >> George
> >> >>
> >> >>>
> >> >>> >
> >> >>> > ... this question ?
> >> >>> >
> >> >>> > We are wondering why bootm_boot_start() overrides the bootargs
> >> variable
> >> >>> > instead of appending cmdline to the existing bootargs instead.
> >> >>> >
> >> >>> > >
> >> >>> > >
> >> >>> > >> people (potentially abootimg) inject needed boot param betwee=
n
> >> bootmeth
> >> >>> > >> stage. Perhaps, either clean up bootargs before bootmeth load
> >> stage, or add
> >> >>> > >> kconfig to check and enable this logic, a better
> representation.
> >> >>> > >>
> >> >>> > >> (2) One more thing, the vendor_boot cmdline is not handle
> neither
> >> in
> >> >>> > >> original logic nor in url from you provided. So I can say the
> url
> >> one is
> >> >>> > >> not capable for extended with Android boot img version > 2
> since
> >> >>> > >> vendor_boot cmdline not handled.
> >> >>> > >
> >> >>> > > What do you mean by the vendor_boot cmdline is not handled?
> >> >>> > >
> >> >>> > > When parsing the vendor_boot image, we go through
> >> >>> > > android_vendor_boot_image_v3_v4_parse_hdr()
> >> >>> > >
> >> >>> > > That function copies the vendor_boot cmdline with:
> >> >>> > >
> >> >>> > >       data->kcmdline_extra =3D hdr->cmdline;
> >> >>> > >
> >> >>> > > (to the struct andr_image_data).
> >> >>> > >
> >> >>> > > Later on, in android_image_get_kernel(), this gets copied to t=
he
> >> >>> > > bootargs:
> >> >>> > >
> >> >>> > >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra)=
 {
> >> >>> > >               if (*newbootargs) /* If there is something in
> >> newbootargs, a space is needed */
> >> >>> > >                       strcat(newbootargs, " ");
> >> >>> > >               strcat(newbootargs, img_data.kcmdline_extra);
> >> >>> > >       }
> >> >>> > >
> >> >>> > >       env_set("bootargs", newbootargs);
> >> >>> > >
> >> >>> > >>
> >> >>> > >> (3) I don't think it is very much different between your
> >> mentioned url with
> >> >>> > >> my patch. There is nothing advanced, but just existing code
> logic
> >> reuse and
> >> >>> > >> that logic handled vendor_cmdline in other path. I prefer cod=
e
> >> logic reuse.
> >> >>> > >
> >> >>> > > The difference is that in the patch I've linked is that we onl=
y
> >> change
> >> >>> > > Android specific boot behaviour. So less risk to impact
> ChromeOS.
> >> >>> > >
> >> >>> > >>
> >> >>> > >> And I believe above are not the important thing....
> >> >>> > >>
> >> >>> > >>>
> >> >>> > >>> Changing this would potentially break ChromeOS boot behaviou=
r
> so
> >> I'd
> >> >>> > >>> prefer to find another solution.
> >> >>> > >>>
> >> >>> > >>> I know that TI has a downstream patch that changes
> >> bootmeth_android.c
> >> >>> > >>> instead:
> >> >>> > >>>
> >> >>> > >>>
> >> >>> > >>>
> >>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.04=
-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
> >> >>> > >>
> >> >>> > >>
> >> >>> > >> ...
> >> >>> > >>
> >> >>> > >>
> >> >>> > >>> Would that work for you?
> >> >>> > >>>
> >> >>> > >>>
> >> >>> > >> Well, the one from url also fine with me.
> >> >>> > >>
> >> >>> > >> The important thing is here. So as to ease the change with
> >> "minimal impact"
> >> >>> > >> gets in. I can add one extra check to maintain original
> behavior
> >> in case
> >> >>> > >> people have concern of breakage. Code example as below:
> >> >>> > >>
> >> >>> > >> + If
> (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
> >> >>> > >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >> >>> > >> + else
> >> >>> > >>       ret =3D env_set("bootargs", cmdline);
> >> >>> > >>
> >> >>> > >> This logic eliminated the concern, but it also limited those
> >> potential use
> >> >>> > >> cases for Android boot header version > 2, unless the newly
> >> introduced
> >> >>> > >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
> >> >>> > >
> >> >>> > > I'm not sure about why this is better, as from what I
> understand we
> >> >>> > > handle vendor_boot cmdline properly already.
> >> >>> > >
> >> >>> > > Can you provide me with a test case or some example commands
> that
> >> show
> >> >>> > > that vendor_boot cmdline is not handled properly?
> >> >>> > >
> >> >>> > >>
> >> >>> > >> Or this one with good extendible.
> >> >>> > >> + /* Clean up bootargs purposely */
> >> >>> > >> + if (IS_ENABLED(SOME_FLAG))
> >> >>> > >> +    env_set("bootargs", "");
> >> >>> > >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >> >>> > >>
> >> >>> > >> Either way. I prefer first one and can blindly apply without
> >> afford. I
> >> >>> > >> leave the idea above to people more concern with it. Please l=
et
> >> me know
> >> >>> > >> your decision, I can provide one more revision later.
> >> >>> > >
> >> >>> > > I'm sorry there is so much back and forth on this series. I ho=
pe
> >> we can
> >> >>> > > come to a common agreement and get something merged.
> >>
> >> Regards,
> >> Simon
> >>
>
