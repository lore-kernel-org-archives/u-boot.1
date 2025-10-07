Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56729CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 23:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CA18397A;
	Wed,  8 Oct 2025 01:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0CwFznu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC83683919; Tue,  7 Oct 2025 18:03:25 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659D383655
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 18:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7abc631ae5cso4688725a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759853001; x=1760457801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s7uRANuhaHGZZvZYh4nTwWUMua0sXjobH7E0/p9cjjM=;
 b=e0CwFznuwcSei8Ch7anDRV/Ho+HJWSt+9ZPwUqFxYFfuOf1026mUWV8sFgN4gi8WYD
 xpRf2qYK8ng4o0WpCPmeqkBvV5mfqGKX+rJyCAXcPWR4JnmhzrEYozhuvfepn89hsFZ8
 u8kZ81AlIjuctPE6oz9WS9IcYrcCcgIl02Rw9N66s8dWOpIQCkMxi1ytwVGqAZWnSpNT
 E31jv/lSxvMSmIYivAMSnmNLEMjjVU+ohO8+/tmIXX90smDVHLBjgRxDGw7Cxya25CmX
 hMGGpawTx0v5ley7JJt8j+CiX5cOoICT1VmP0uQxuJ+pcet8qUS4qeekKqFidqaA1JbH
 dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759853001; x=1760457801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7uRANuhaHGZZvZYh4nTwWUMua0sXjobH7E0/p9cjjM=;
 b=W0Daca1jLd7zBZsA3gCLNd4+6OcqEIRN2llCPiMV7ewXrPdBNRSs97tjBjocI/8M53
 nThtrSvfhzoX8iYDTy5fW2T1LP8Rjuq5hdmAylP+e1wgKbD6Ju0P+SxT8vrKjXe7m6rC
 IoO+UDVVH2jfojLKxhNh/5W2bpUfhiwC9+SG+NCppIgy+/c0A0a1dUop2Nz5Gc/dQIo5
 N07RENE3Ums3gwtcZYV/jHuXbPypK3d9BDatNY28SJUEO/QyM4fwmtGG8/4Qar3GCesY
 4Z97al504xmyzpWShaH1wp/ZC8KrP1BpEbQ2+zIVU08nWhathDQo7lJ8ZFqX3niHQusj
 73lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU85SWb6qDZ8jXZmLkoYza5EamRBBSTPAWPn3r0NwuVQde0PbAnYQTO7G1QCp8z5f6hwX05Ex8=@lists.denx.de
X-Gm-Message-State: AOJu0YyjSnshgxiWiIu7Q3Fn4tsUFOoia33tCwDVuWqILewNWW+sd4eY
 6UmJCiy1NAZpldfyUgnJeE6lqCpSlKKjqOjdLWQCXfmbcor8wHhuz/HlbgwNWFKh8L5uiNXrYNW
 M4PGwirt2HgXg8HVuUZi2guqYCEHUkes=
X-Gm-Gg: ASbGncv+9DDIFKMxWw1vihXTBKK4Zej5e84PFbS2yzfshVLZfO4GSJoqRJcCiVLhU49
 Mm9DOyKVSp486kn+70yjZzK9L0L/TAxqwcMHIZ1Bu+WM0WFKAJFkWni3BYJsUgw/CMXqe1GNWe7
 7+HGQ86AZm6iuU7+K84Xziy31tL05azJZUIHh3WhGW0y6wQbDEJpbBg8sGxoNKzJ1dmVV7DyRsi
 WaZ84HsiZRoMUmH5/4Nq4AKeI0wtaqa
X-Google-Smtp-Source: AGHT+IEfEdpuZN4aB/q6lxoOV/yPxnOYobmImU6KNZzdxKYyhXDizPyjW07ifP5Jhe3zIUjcncIGG2Pgbz2CcV0OVA4=
X-Received: by 2002:a05:6830:3817:b0:7a6:c26e:1f7a with SMTP id
 46e09a7af769-7c0df71e920mr190310a34.13.1759853000633; Tue, 07 Oct 2025
 09:03:20 -0700 (PDT)
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
In-Reply-To: <CAFLszTg9pwt7p45hE-z+bLM-RNofCouYA-jtXDw7RP+HbFQ3Jw@mail.gmail.com>
From: george chan <gchan9527@gmail.com>
Date: Wed, 8 Oct 2025 00:03:08 +0800
X-Gm-Features: AS18NWD0SJw2visq6VXS24mDGRsTWYjo2UWXB3G8IAS-h43XO9l4jiaETl7csyg
Message-ID: <CADgMGSuH21te1Mqy3Z0C8R6seoUHLffvLyuVY-ukVtKHi3GVOA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Wed, 08 Oct 2025 01:50:35 +0200
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

Hi Simon,

Thx for feedback.


=E5=9C=A8 2025=E5=B9=B410=E6=9C=887=E6=97=A5=E9=80=B1=E4=BA=8C 04:38=EF=BC=
=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi George,
>
> On Sun, 5 Oct 2025 at 09:41, george chan <gchan9527@gmail.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2025=E5=B9=B410=E6=9C=885=E6=97=A5=E9=80=B1=E6=97=A5 00:35=EF=
=BC=8Cgeorge chan <gchan9527@gmail.com> =E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Hi Simon and Mattijs,
> >>
> >> Thx for feedback. Just in case the discussion drift to other direction=
,
> do let me have a chance to put some background info here.
> >>
> >> there are ways for pre-set env variable and its value. Firstly externa=
l
> env file and loaded by uboot, like, runtime handling; and another type is
> build time embed env file into uboot body.
> >>
> >> maybe in chromeos case first stage boot loader will pass along bootinf=
o
> struct to uboot and treat as preset defaults.
> >>
> >> so in either case uboot can have right to choose the preset from (by
> disable external env file, secured/trusted boot?), and then either follow
> the bootinfo struct preset value and/or concat and/or overrite with uboot=
=E2=80=99s
> own embedded env value at boot time, and then runtime modify.
> >>
> >> This behavior maybe enable or disable by kconfig. but in secured boot
> context point of view, env file kind of thing, might have potential desig=
n
> wise conflict. And this is not within my scope.
> >>
> >> in some other use case like simulation of vendor bootloader behavior t=
o
> have a build time preset default value, this is within my scope. and that=
s
> why i decided to put those preset into env file and embeded.
> >>
> >> let me reply below inline.
> >>
> >> =E5=9C=A8 2025=E5=B9=B410=E6=9C=882=E6=97=A5=E9=80=B1=E5=9B=9B 00:22=
=EF=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
> >>>
> >>> Hi Mattijs, George,
> >>>
> >>> On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
> >>> <mkorpershoek@kernel.org> wrote:
> >>> >
> >>> > Hi Simon,
> >>> >
> >>> > Now that you are back, could you please have a look at ...
> >>> >
> >>> > On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <
> mkorpershoek@kernel.org> wrote:
> >>> >
> >>> > > Hi George,
> >>> > >
> >>> > > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com>
> wrote:
> >>> > >
> >>> > >> Hi Mattijs,
> >>> > >>
> >>> > >> Thx for reply.
> >>> > >>
> >>> > >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 1=
7:05=EF=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org>
> =E5=AF=AB=E9=81=93=EF=BC=9A
> >>> > >>
> >>> > >>> Hi George,
> >>> > >>>
> >>> > >>> Thank you for the patch.
> >>> > >>>
> >>> > >> ...
> >>> > >>
> >>> > >>>
> >>> > >>> > -     ret =3D env_set("bootargs", cmdline);
> >>> > >>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL=
);
> >>> > >>>
> >>> > >>> I don't think it can be done this way. bootm_boot_start() is
> used in the
> >>> > >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
> >>> > >>>
> >>> > >>
> >>> > >> I got your point. I have 3 ideas come out.
> >>> > >>
> >>> > >> (1) The logic purposely empty the env bootargs, either developer
> don't use
> >>> > >> env bootargs or those use cases touched bootargs in some early
> step. And
> >>> > >> then wanna disregard previous u-boot bootmeth operation, and
> empty bootargs
> >>> > >> for that ongoing bootmeth stage...well that's not congruent
> behavior; I
> >>> > >> have a gut feeling this is a bug or band-aid anyway, it closed
> the door for
> >>> > >
> >>> > > Simon, is it *intentional* that override the bootargs variable in
> >>> > > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
> >>> > >
> >>> > > Shouldn't we get the bootargs from the environment, and append
> cmdline
> >>> > > to the existing bootargs instead ?
> >>>
> >>> The way U-Boot operates today, bootargs defines the entire cmdline,
> >>> not just part of it. So if you use 'env set bootargs ..' you are
> >>> changing the entire cmdline passed to Linux, etc.
> >>
> >>
> >> This is runtime change. My test case in fastboot path, it get bootargs
> wiped and filling in with something from boot img. That might share same
> procedure with other boot method like chromeos do. Wipe env default each
> time in fastboot (when fail) might be a secure-wise handling.
> >>
> >> And I feel it is a critical entry point logic like a central hub, and
> looking good to decide uboot behavior here. By kconfig whatever? Again, o=
ut
> of my scope.
> >>
> >>>
> >>> With ChromeOS, after 'bootflow read', the cmdline can be edited using
> >>> 'bootflow cmdline set' etc., which also changes bootargs. But in
> >>> general ChromeOS provides the whole Linux cmdline to U-Boot.
> >>
> >>
> >> this is also runtime change. And as a side note, if by doing bootflow
> select, should env bootargs gets overrided or appended? This is a bigger
> arch-wise question worth at least a public paper. and I might not go into
> this depth.
> >>
> >>>
> >>> If you are wanting to append, I suggest writing a new function, or
> >>
> >>
> >> yeah agreed. I do more appreciate and feel it really lower project
> management/test cost.
> >>
> >>> perhaps adding a 'bool append' arg to bootm_boot_start(), if all the
> >>> other code is useful for Android.
> >>
> >>
> >> A more simpler method is to create bootm_boot_start_ex(kernel_cmd_line=
,
> vendor_cmd_line) as
> >>  I proposed to complement with
> >>  bootm_boot_start(cmdline) or even add one layer of abstract, called
> from bootm_boot_start(), make vendor_cmd_line param as null. As can
> preserve the old logic and behavior.
> >>
> >> So build time env preset value, and runtime value override decision ca=
n
> live in this new function, or elsewhere; but is not within my scope.
> >
> >
> > Tr/Dr I wrote a proof of concept code here:
> >
> >
> https://github.com/99degree/u-boot/compare/before_tag...reboot-mode?expan=
d=3D1
>
> This thread is a bit confusing now, but it seems you have written a
>

I am sorry but I had to prove my patch is necessary and correctnessly and
also limit the scope of the patch. Thanks for your understand.

new function and that is fine with me, as it won't affect ChromeOS.
>

There is no new function at all. I am sorry to put more info here again to
let related code to be clear for every audience here.

As you may notice function bootm_modify_bootargs_env() is a renamed and
move to bootm.c which is split/extracted from existing function
android_image_get_kernel()

And bootm_boot_start_ex() is split from
bootm_boot_start() with your suggested enable param.

I am afraid if you or other reviewer might wonder why move to bootm.c and
here is the reason.

Supposed with below 2 code paths:

Boot->bootflow->bootmeth_android->bootm
Boot->fastboot->do_bootm->bootm

I believe android_image_get_kernel is living around within bootmeth_android
stage so first two patch has taken care of. But fastboot path is not. that
might be the reason above two path need separate special handling for.

So as to code reuse with fastboot path then those code had to move to bootm
layer.

And my understanding each stage is isolated, and depends on env as a kind
of api to link up each stage. Then I believe the patch is now a clean
solution. Anyway welcome to jot a mail if there are suggestions, if any
doubt, please jot a mail too.

Thanks,
George


>
> >
> >
> >>
> >> So I leave it as a open-end question here. Once you had decided then
> feel free to let me know and I can do one extra round patch. Thank again
> for feedback.
> >>
> >> George
> >>
> >>>
> >>> >
> >>> > ... this question ?
> >>> >
> >>> > We are wondering why bootm_boot_start() overrides the bootargs
> variable
> >>> > instead of appending cmdline to the existing bootargs instead.
> >>> >
> >>> > >
> >>> > >
> >>> > >> people (potentially abootimg) inject needed boot param between
> bootmeth
> >>> > >> stage. Perhaps, either clean up bootargs before bootmeth load
> stage, or add
> >>> > >> kconfig to check and enable this logic, a better representation.
> >>> > >>
> >>> > >> (2) One more thing, the vendor_boot cmdline is not handle neithe=
r
> in
> >>> > >> original logic nor in url from you provided. So I can say the ur=
l
> one is
> >>> > >> not capable for extended with Android boot img version > 2 since
> >>> > >> vendor_boot cmdline not handled.
> >>> > >
> >>> > > What do you mean by the vendor_boot cmdline is not handled?
> >>> > >
> >>> > > When parsing the vendor_boot image, we go through
> >>> > > android_vendor_boot_image_v3_v4_parse_hdr()
> >>> > >
> >>> > > That function copies the vendor_boot cmdline with:
> >>> > >
> >>> > >       data->kcmdline_extra =3D hdr->cmdline;
> >>> > >
> >>> > > (to the struct andr_image_data).
> >>> > >
> >>> > > Later on, in android_image_get_kernel(), this gets copied to the
> >>> > > bootargs:
> >>> > >
> >>> > >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> >>> > >               if (*newbootargs) /* If there is something in
> newbootargs, a space is needed */
> >>> > >                       strcat(newbootargs, " ");
> >>> > >               strcat(newbootargs, img_data.kcmdline_extra);
> >>> > >       }
> >>> > >
> >>> > >       env_set("bootargs", newbootargs);
> >>> > >
> >>> > >>
> >>> > >> (3) I don't think it is very much different between your
> mentioned url with
> >>> > >> my patch. There is nothing advanced, but just existing code logi=
c
> reuse and
> >>> > >> that logic handled vendor_cmdline in other path. I prefer code
> logic reuse.
> >>> > >
> >>> > > The difference is that in the patch I've linked is that we only
> change
> >>> > > Android specific boot behaviour. So less risk to impact ChromeOS.
> >>> > >
> >>> > >>
> >>> > >> And I believe above are not the important thing....
> >>> > >>
> >>> > >>>
> >>> > >>> Changing this would potentially break ChromeOS boot behaviour s=
o
> I'd
> >>> > >>> prefer to find another solution.
> >>> > >>>
> >>> > >>> I know that TI has a downstream patch that changes
> bootmeth_android.c
> >>> > >>> instead:
> >>> > >>>
> >>> > >>>
> >>> > >>>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.04=
-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
> >>> > >>
> >>> > >>
> >>> > >> ...
> >>> > >>
> >>> > >>
> >>> > >>> Would that work for you?
> >>> > >>>
> >>> > >>>
> >>> > >> Well, the one from url also fine with me.
> >>> > >>
> >>> > >> The important thing is here. So as to ease the change with
> "minimal impact"
> >>> > >> gets in. I can add one extra check to maintain original behavior
> in case
> >>> > >> people have concern of breakage. Code example as below:
> >>> > >>
> >>> > >> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)=
)
> >>> > >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >>> > >> + else
> >>> > >>       ret =3D env_set("bootargs", cmdline);
> >>> > >>
> >>> > >> This logic eliminated the concern, but it also limited those
> potential use
> >>> > >> cases for Android boot header version > 2, unless the newly
> introduced
> >>> > >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
> >>> > >
> >>> > > I'm not sure about why this is better, as from what I understand =
we
> >>> > > handle vendor_boot cmdline properly already.
> >>> > >
> >>> > > Can you provide me with a test case or some example commands that
> show
> >>> > > that vendor_boot cmdline is not handled properly?
> >>> > >
> >>> > >>
> >>> > >> Or this one with good extendible.
> >>> > >> + /* Clean up bootargs purposely */
> >>> > >> + if (IS_ENABLED(SOME_FLAG))
> >>> > >> +    env_set("bootargs", "");
> >>> > >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >>> > >>
> >>> > >> Either way. I prefer first one and can blindly apply without
> afford. I
> >>> > >> leave the idea above to people more concern with it. Please let
> me know
> >>> > >> your decision, I can provide one more revision later.
> >>> > >
> >>> > > I'm sorry there is so much back and forth on this series. I hope
> we can
> >>> > > come to a common agreement and get something merged.
>
> Regards,
> Simon
>
