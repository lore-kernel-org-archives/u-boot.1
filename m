Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D527CAC5B0
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 00:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9CC807B1;
	Sun,  5 Oct 2025 02:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FW+ZXgst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2005683775; Sat,  4 Oct 2025 18:35:56 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF1883816
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 18:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-50f8bf5c518so2802919137.3
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759595752; x=1760200552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6iBr4+Ye42yLn7hIQdYcuvphidWPF8rgluvLz6Rmkr4=;
 b=FW+ZXgstnsW6bKAvu2dgvfyV1zz2bJvxFZOzz84iJxkq+NN6/HmkSUIn8/+XXQS2+G
 z1ekKNje810d8qwqmDAr6wUx4FzzryYTWvpDMb4aEbI4Yt9DTrIP3MKcxwjXSJs7EEFb
 +PG0GK6hCVg7eD7tcgAu56xWfZuhFxE13m0e1Sn3trT9iDU2Ja2HGUYiYvmtoTBJVVoG
 YX5vgYUHgZ7NgHN3Zsrq/45LvWNggS3UQNXfAgxFRjlhiS8meDYj7Ersg24SARgLNxx9
 xnCHsoOGQlrewaZwHCuZ0QjsPKDhEQocRj7jkdGka8trI4oKhbAUSKJJxw1WCugy3A9a
 C4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759595752; x=1760200552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iBr4+Ye42yLn7hIQdYcuvphidWPF8rgluvLz6Rmkr4=;
 b=iM7ZuhZBI+p+L63vNzo984mXPR9phH3WXXkE4KgNxS2zyi5BKECYHaYR4Y7P4rsgu1
 QkYLAxmV9LWiCMYHIIuRczIvhxitTwVZ7kaKfzn222Wu45lkMIntnOwUNn5HS/U0J9fw
 rNxbJ5aVd38shI7A5O379DKYIrVsIl+GvcminIlqSn6oQzq5fRFzsNggwCwLRhA6ldv9
 DE5xBlGxMTYFgbMSUSxUxRIGcxL/P9/2ZUitw5rr0p8ZJxr9it3u4ArDkp+F82LA8blf
 aLQ3NXVqAtOsVGyKfgTdXXLIUWblTQej1hjtTcx09/ONNS9kEk/7JKHRnFjBsrJ3zyjU
 BIHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe4G4TGIKs2CGlWKKDBGS0Xxvlo4aPV7DvWy2MQWxRTEDOfwjSbqndoSS0RQmJCcgHoOwA0T4=@lists.denx.de
X-Gm-Message-State: AOJu0YwVi7131f4GNCIw4bd6fQ3w3W1y/BY3eViup0F46uE8cxucblMH
 4MqpH7oFeoJIZikipkxl3WVr7vwrMljOGLYf1vdrMA8WyBufB8B9rMhAn2h9Qn1KGolKPenfJCn
 eZIrzX5raKvVJRMXFU3Wjdbsi2T4cDk0=
X-Gm-Gg: ASbGncs2nNeo1aarUHE/uL0LrBehlUxfneDjIs6oLTGXsOf549Erwqr6xwCfC0UgBpP
 FUgfmcw5QeGHFSWaCfKNA+4hdajXhBBMUGOWaTQA/IQAUAUiH4Syvoh8q6FvMC8rsHxLts/wYjF
 KU74If7P/mMflD5+ImeWusmLziXk6El0PSnrLuiZ4OjyLwEPAwh/TzjdFDU0iDyjb+63tlSDEu/
 ztQySsXjlNhobypwyGbuZ7cP8QREo79
X-Google-Smtp-Source: AGHT+IF/b4f8ec/tFb33u1z9q2yyyGSDI6HlH1IwOiqWP0X8KZFBz47B89V1QlO7xWhjZZgwBz5NkUgZZZ7NFPqDhVA=
X-Received: by 2002:a05:6102:952:b0:529:bfd2:382a with SMTP id
 ada2fe7eead31-5d41d1344bamr2924973137.32.1759595751812; Sat, 04 Oct 2025
 09:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org> <873484jt3u.fsf@kernel.org>
 <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
In-Reply-To: <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
From: george chan <gchan9527@gmail.com>
Date: Sun, 5 Oct 2025 00:35:40 +0800
X-Gm-Features: AS18NWC9G81-hgKkBIZ6vURm3tyZY9GDPxOW8VFJdg17VYwJtbPo1iWAG2Izh5M
Message-ID: <CADgMGSu1es4dex1u=6ai4WEBK2Loo2RAZdONRf07AqTWhZL8mQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Sun, 05 Oct 2025 02:20:11 +0200
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

Thx for feedback. Just in case the discussion drift to other direction, do
let me have a chance to put some background info here.

there are ways for pre-set env variable and its value. Firstly external env
file and loaded by uboot, like, runtime handling; and another type is build
time embed env file into uboot body.

maybe in chromeos case first stage boot loader will pass along bootinfo
struct to uboot and treat as preset defaults.

so in either case uboot can have right to choose the preset from (by
disable external env file, secured/trusted boot?), and then either follow
the bootinfo struct preset value and/or concat and/or overrite with uboot=
=E2=80=99s
own embedded env value at boot time, and then runtime modify.

This behavior maybe enable or disable by kconfig. but in secured boot
context point of view, env file kind of thing, might have potential design
wise conflict. And this is not within my scope.

in some other use case like simulation of vendor bootloader behavior to
have a build time preset default value, this is within my scope. and thats
why i decided to put those preset into env file and embeded.

let me reply below inline.

=E5=9C=A8 2025=E5=B9=B410=E6=9C=882=E6=97=A5=E9=80=B1=E5=9B=9B 00:22=EF=BC=
=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi Mattijs, George,
>
> On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
> >
> > Hi Simon,
> >
> > Now that you are back, could you please have a look at ...
> >
> > On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <
> mkorpershoek@kernel.org> wrote:
> >
> > > Hi George,
> > >
> > > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com>
> wrote:
> > >
> > >> Hi Mattijs,
> > >>
> > >> Thx for reply.
> > >>
> > >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:05=
=EF=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org>
> =E5=AF=AB=E9=81=93=EF=BC=9A
> > >>
> > >>> Hi George,
> > >>>
> > >>> Thank you for the patch.
> > >>>
> > >> ...
> > >>
> > >>>
> > >>> > -     ret =3D env_set("bootargs", cmdline);
> > >>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> > >>>
> > >>> I don't think it can be done this way. bootm_boot_start() is used i=
n
> the
> > >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
> > >>>
> > >>
> > >> I got your point. I have 3 ideas come out.
> > >>
> > >> (1) The logic purposely empty the env bootargs, either developer
> don't use
> > >> env bootargs or those use cases touched bootargs in some early step.
> And
> > >> then wanna disregard previous u-boot bootmeth operation, and empty
> bootargs
> > >> for that ongoing bootmeth stage...well that's not congruent behavior=
;
> I
> > >> have a gut feeling this is a bug or band-aid anyway, it closed the
> door for
> > >
> > > Simon, is it *intentional* that override the bootargs variable in
> > > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
> > >
> > > Shouldn't we get the bootargs from the environment, and append cmdlin=
e
> > > to the existing bootargs instead ?
>
> The way U-Boot operates today, bootargs defines the entire cmdline,
> not just part of it. So if you use 'env set bootargs ..' you are
> changing the entire cmdline passed to Linux, etc.
>

This is runtime change. My test case in fastboot path, it get bootargs
wiped and filling in with something from boot img. That might share same
procedure with other boot method like chromeos do. Wipe env default each
time in fastboot (when fail) might be a secure-wise handling.

And I feel it is a critical entry point logic like a central hub, and
looking good to decide uboot behavior here. By kconfig whatever? Again, out
of my scope.


> With ChromeOS, after 'bootflow read', the cmdline can be edited using
> 'bootflow cmdline set' etc., which also changes bootargs. But in
> general ChromeOS provides the whole Linux cmdline to U-Boot.
>

this is also runtime change. And as a side note, if by doing bootflow
select, should env bootargs gets overrided or appended? This is a bigger
arch-wise question worth at least a public paper. and I might not go into
this depth.


> If you are wanting to append, I suggest writing a new function, or
>

yeah agreed. I do more appreciate and feel it really lower project
management/test cost.

perhaps adding a 'bool append' arg to bootm_boot_start(), if all the
> other code is useful for Android.
>

A more simpler method is to create bootm_boot_start_ex(kernel_cmd_line,
vendor_cmd_line) as
 I proposed to complement with
 bootm_boot_start(cmdline) or even add one layer of abstract, called from
bootm_boot_start(), make vendor_cmd_line param as null. As can preserve the
old logic and behavior.

So build time env preset value, and runtime value override decision can
live in this new function, or elsewhere; but is not within my scope.

So I leave it as a open-end question here. Once you had decided then feel
free to let me know and I can do one extra round patch. Thank again for
feedback.

George


> >
> > ... this question ?
> >
> > We are wondering why bootm_boot_start() overrides the bootargs variable
> > instead of appending cmdline to the existing bootargs instead.
> >
> > >
> > >
> > >> people (potentially abootimg) inject needed boot param between
> bootmeth
> > >> stage. Perhaps, either clean up bootargs before bootmeth load stage,
> or add
> > >> kconfig to check and enable this logic, a better representation.
> > >>
> > >> (2) One more thing, the vendor_boot cmdline is not handle neither in
> > >> original logic nor in url from you provided. So I can say the url on=
e
> is
> > >> not capable for extended with Android boot img version > 2 since
> > >> vendor_boot cmdline not handled.
> > >
> > > What do you mean by the vendor_boot cmdline is not handled?
> > >
> > > When parsing the vendor_boot image, we go through
> > > android_vendor_boot_image_v3_v4_parse_hdr()
> > >
> > > That function copies the vendor_boot cmdline with:
> > >
> > >       data->kcmdline_extra =3D hdr->cmdline;
> > >
> > > (to the struct andr_image_data).
> > >
> > > Later on, in android_image_get_kernel(), this gets copied to the
> > > bootargs:
> > >
> > >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> > >               if (*newbootargs) /* If there is something in
> newbootargs, a space is needed */
> > >                       strcat(newbootargs, " ");
> > >               strcat(newbootargs, img_data.kcmdline_extra);
> > >       }
> > >
> > >       env_set("bootargs", newbootargs);
> > >
> > >>
> > >> (3) I don't think it is very much different between your mentioned
> url with
> > >> my patch. There is nothing advanced, but just existing code logic
> reuse and
> > >> that logic handled vendor_cmdline in other path. I prefer code logic
> reuse.
> > >
> > > The difference is that in the patch I've linked is that we only chang=
e
> > > Android specific boot behaviour. So less risk to impact ChromeOS.
> > >
> > >>
> > >> And I believe above are not the important thing....
> > >>
> > >>>
> > >>> Changing this would potentially break ChromeOS boot behaviour so I'=
d
> > >>> prefer to find another solution.
> > >>>
> > >>> I know that TI has a downstream patch that changes bootmeth_android=
.c
> > >>> instead:
> > >>>
> > >>>
> > >>>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.04=
-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
> > >>
> > >>
> > >> ...
> > >>
> > >>
> > >>> Would that work for you?
> > >>>
> > >>>
> > >> Well, the one from url also fine with me.
> > >>
> > >> The important thing is here. So as to ease the change with "minimal
> impact"
> > >> gets in. I can add one extra check to maintain original behavior in
> case
> > >> people have concern of breakage. Code example as below:
> > >>
> > >> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
> > >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> > >> + else
> > >>       ret =3D env_set("bootargs", cmdline);
> > >>
> > >> This logic eliminated the concern, but it also limited those
> potential use
> > >> cases for Android boot header version > 2, unless the newly introduc=
ed
> > >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
> > >
> > > I'm not sure about why this is better, as from what I understand we
> > > handle vendor_boot cmdline properly already.
> > >
> > > Can you provide me with a test case or some example commands that sho=
w
> > > that vendor_boot cmdline is not handled properly?
> > >
> > >>
> > >> Or this one with good extendible.
> > >> + /* Clean up bootargs purposely */
> > >> + if (IS_ENABLED(SOME_FLAG))
> > >> +    env_set("bootargs", "");
> > >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> > >>
> > >> Either way. I prefer first one and can blindly apply without afford.=
 I
> > >> leave the idea above to people more concern with it. Please let me
> know
> > >> your decision, I can provide one more revision later.
> > >
> > > I'm sorry there is so much back and forth on this series. I hope we c=
an
> > > come to a common agreement and get something merged.
>
> Regards,
> Simon
>
