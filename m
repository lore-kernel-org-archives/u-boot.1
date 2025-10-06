Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3329CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651F183D6C;
	Mon,  6 Oct 2025 22:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iM+am1WA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F12E83DB6; Mon,  6 Oct 2025 22:38:39 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD20083D6C
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6399706fd3cso2814535a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783116; x=1760387916; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKaAaAVZhwKssY6SO9WJHhpVc0Q8DXJ15EzEDdVXoEo=;
 b=iM+am1WAtGkDsxcxaKGrOI0X1uJ0Ouf7Twd9BOkv6A4DmPoXhA2IBRRWtqf8jMCOH5
 LIWu++x+FQCDwo/W+SexvlieBOrHEoJOxfKniLrx+l/HRid4Dl05KbvDj27M5uF4uuC9
 gCG5PplHlEKCiwZZonwk6OkwUtz1c09CCmxIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783116; x=1760387916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKaAaAVZhwKssY6SO9WJHhpVc0Q8DXJ15EzEDdVXoEo=;
 b=OAb/KOg2BZMAOgFG97EszkextOWCps74rrOCGs2fifxfMM/YKQ0WFegre3lZIG3sHd
 aDLTWeJ51/LMkdf+nD7jJGyR4un3/hr+SgDgu0Uu3eref3Gq8VA7ekE+/FOye9NEzB+i
 D6qoPFRf/XqB5WvfoZa1QTHHu5gPWCjnNr5wzFTrkfJRHXf8BzsF2RcYOTpkXrwHeh39
 RsNU6W4q2IkRjjdTmmtGhOGS6vK0vC1aRqTQbEvAMVW9M8zFuizvn6UxtunJVHIiRjJg
 MOEZ2fp7kl9jUBndA4Rh8Pk4EpHqxm+VoA4hk0E3WoFyREGYtbpSKPEnjgV9WKimU8FO
 DSBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbrkrvKZGx58jjc4P//gLMGlP97O9TDsOkTah9DRFRwTquJr3ZJejMH64b8NBNRdkmGRkISK8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3LeGOLAVNbZN3wbOxoSF9LcendXf8m6qwbffyaBn/WQ897yDU
 g1R/RhCvNTnZQ5Tj8P2LbxyGDQcSOZDOQ7BSfXO6P8uVIb7EybBZtWDP5cy81t9FuEvOx+0dJWl
 IniOxKVCnMv/J0yKycMs+tctWUCwZT58YyPLtJoNV
X-Gm-Gg: ASbGncv53sRHfTxt50i+0LPf7oCTUGQYCWdhBUMGP2TzJt8F3FnZ4T4KmE3m6Ch63Ec
 N0gAgySs2GZeYJQlzI7zguiay2veUSUTgQyYJDDsZUeHmmgznu9n0MouS6SARILq7gdkdF7f+Hy
 /IxHtj5rAQns9UfWZd54Q/QuKmfcCOWqDcCkyavLEKZBtIYM7lsSJ4NDH60zrg/kS58GqTztYBK
 pwN5YlDnzUy6iyxrqBepcliSGdXgskeNxOaFy7HKtc=
X-Google-Smtp-Source: AGHT+IFCPnJdpyS0/fZFND7c4rjGgEiMH1iaoKM3p3aUGugiR2wa9UaEYEEvSNPCAtDKFLiEpkAqHVda4fW0dnLcJRs=
X-Received: by 2002:a05:6402:40c4:b0:638:305a:f056 with SMTP id
 4fb4d7f45d1cf-639348d7267mr14447500a12.12.1759783116116; Mon, 06 Oct 2025
 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org> <873484jt3u.fsf@kernel.org>
 <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
 <CADgMGSu1es4dex1u=6ai4WEBK2Loo2RAZdONRf07AqTWhZL8mQ@mail.gmail.com>
 <CADgMGSu7n+85gzdescBJd27WKvwryhtvXzY4MX3BWR=oLsLyhA@mail.gmail.com>
In-Reply-To: <CADgMGSu7n+85gzdescBJd27WKvwryhtvXzY4MX3BWR=oLsLyhA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:38:19 -0600
X-Gm-Features: AS18NWAxbK-wUYUQwWuDBbhdIfTytgFX8dU9NS-FQDgX5AO-GUM840p_dzD7Bls
Message-ID: <CAFLszTg9pwt7p45hE-z+bLM-RNofCouYA-jtXDw7RP+HbFQ3Jw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: george chan <gchan9527@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi George,

On Sun, 5 Oct 2025 at 09:41, george chan <gchan9527@gmail.com> wrote:
>
>
>
> =E5=9C=A8 2025=E5=B9=B410=E6=9C=885=E6=97=A5=E9=80=B1=E6=97=A5 00:35=EF=
=BC=8Cgeorge chan <gchan9527@gmail.com> =E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> Hi Simon and Mattijs,
>>
>> Thx for feedback. Just in case the discussion drift to other direction, =
do let me have a chance to put some background info here.
>>
>> there are ways for pre-set env variable and its value. Firstly external =
env file and loaded by uboot, like, runtime handling; and another type is b=
uild time embed env file into uboot body.
>>
>> maybe in chromeos case first stage boot loader will pass along bootinfo =
struct to uboot and treat as preset defaults.
>>
>> so in either case uboot can have right to choose the preset from (by dis=
able external env file, secured/trusted boot?), and then either follow the =
bootinfo struct preset value and/or concat and/or overrite with uboot=E2=80=
=99s own embedded env value at boot time, and then runtime modify.
>>
>> This behavior maybe enable or disable by kconfig. but in secured boot co=
ntext point of view, env file kind of thing, might have potential design wi=
se conflict. And this is not within my scope.
>>
>> in some other use case like simulation of vendor bootloader behavior to =
have a build time preset default value, this is within my scope. and thats =
why i decided to put those preset into env file and embeded.
>>
>> let me reply below inline.
>>
>> =E5=9C=A8 2025=E5=B9=B410=E6=9C=882=E6=97=A5=E9=80=B1=E5=9B=9B 00:22=EF=
=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
>>>
>>> Hi Mattijs, George,
>>>
>>> On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
>>> <mkorpershoek@kernel.org> wrote:
>>> >
>>> > Hi Simon,
>>> >
>>> > Now that you are back, could you please have a look at ...
>>> >
>>> > On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <mkorpershoek@kern=
el.org> wrote:
>>> >
>>> > > Hi George,
>>> > >
>>> > > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com> wr=
ote:
>>> > >
>>> > >> Hi Mattijs,
>>> > >>
>>> > >> Thx for reply.
>>> > >>
>>> > >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:=
05=EF=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=
=EF=BC=9A
>>> > >>
>>> > >>> Hi George,
>>> > >>>
>>> > >>> Thank you for the patch.
>>> > >>>
>>> > >> ...
>>> > >>
>>> > >>>
>>> > >>> > -     ret =3D env_set("bootargs", cmdline);
>>> > >>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>>> > >>>
>>> > >>> I don't think it can be done this way. bootm_boot_start() is used=
 in the
>>> > >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
>>> > >>>
>>> > >>
>>> > >> I got your point. I have 3 ideas come out.
>>> > >>
>>> > >> (1) The logic purposely empty the env bootargs, either developer d=
on't use
>>> > >> env bootargs or those use cases touched bootargs in some early ste=
p. And
>>> > >> then wanna disregard previous u-boot bootmeth operation, and empty=
 bootargs
>>> > >> for that ongoing bootmeth stage...well that's not congruent behavi=
or; I
>>> > >> have a gut feeling this is a bug or band-aid anyway, it closed the=
 door for
>>> > >
>>> > > Simon, is it *intentional* that override the bootargs variable in
>>> > > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
>>> > >
>>> > > Shouldn't we get the bootargs from the environment, and append cmdl=
ine
>>> > > to the existing bootargs instead ?
>>>
>>> The way U-Boot operates today, bootargs defines the entire cmdline,
>>> not just part of it. So if you use 'env set bootargs ..' you are
>>> changing the entire cmdline passed to Linux, etc.
>>
>>
>> This is runtime change. My test case in fastboot path, it get bootargs w=
iped and filling in with something from boot img. That might share same pro=
cedure with other boot method like chromeos do. Wipe env default each time =
in fastboot (when fail) might be a secure-wise handling.
>>
>> And I feel it is a critical entry point logic like a central hub, and lo=
oking good to decide uboot behavior here. By kconfig whatever? Again, out o=
f my scope.
>>
>>>
>>> With ChromeOS, after 'bootflow read', the cmdline can be edited using
>>> 'bootflow cmdline set' etc., which also changes bootargs. But in
>>> general ChromeOS provides the whole Linux cmdline to U-Boot.
>>
>>
>> this is also runtime change. And as a side note, if by doing bootflow se=
lect, should env bootargs gets overrided or appended? This is a bigger arch=
-wise question worth at least a public paper. and I might not go into this =
depth.
>>
>>>
>>> If you are wanting to append, I suggest writing a new function, or
>>
>>
>> yeah agreed. I do more appreciate and feel it really lower project manag=
ement/test cost.
>>
>>> perhaps adding a 'bool append' arg to bootm_boot_start(), if all the
>>> other code is useful for Android.
>>
>>
>> A more simpler method is to create bootm_boot_start_ex(kernel_cmd_line, =
vendor_cmd_line) as
>>  I proposed to complement with
>>  bootm_boot_start(cmdline) or even add one layer of abstract, called fro=
m bootm_boot_start(), make vendor_cmd_line param as null. As can preserve t=
he old logic and behavior.
>>
>> So build time env preset value, and runtime value override decision can =
live in this new function, or elsewhere; but is not within my scope.
>
>
> Tr/Dr I wrote a proof of concept code here:
>
> https://github.com/99degree/u-boot/compare/before_tag...reboot-mode?expan=
d=3D1

This thread is a bit confusing now, but it seems you have written a
new function and that is fine with me, as it won't affect ChromeOS.


>
>
>>
>> So I leave it as a open-end question here. Once you had decided then fee=
l free to let me know and I can do one extra round patch. Thank again for f=
eedback.
>>
>> George
>>
>>>
>>> >
>>> > ... this question ?
>>> >
>>> > We are wondering why bootm_boot_start() overrides the bootargs variab=
le
>>> > instead of appending cmdline to the existing bootargs instead.
>>> >
>>> > >
>>> > >
>>> > >> people (potentially abootimg) inject needed boot param between boo=
tmeth
>>> > >> stage. Perhaps, either clean up bootargs before bootmeth load stag=
e, or add
>>> > >> kconfig to check and enable this logic, a better representation.
>>> > >>
>>> > >> (2) One more thing, the vendor_boot cmdline is not handle neither =
in
>>> > >> original logic nor in url from you provided. So I can say the url =
one is
>>> > >> not capable for extended with Android boot img version > 2 since
>>> > >> vendor_boot cmdline not handled.
>>> > >
>>> > > What do you mean by the vendor_boot cmdline is not handled?
>>> > >
>>> > > When parsing the vendor_boot image, we go through
>>> > > android_vendor_boot_image_v3_v4_parse_hdr()
>>> > >
>>> > > That function copies the vendor_boot cmdline with:
>>> > >
>>> > >       data->kcmdline_extra =3D hdr->cmdline;
>>> > >
>>> > > (to the struct andr_image_data).
>>> > >
>>> > > Later on, in android_image_get_kernel(), this gets copied to the
>>> > > bootargs:
>>> > >
>>> > >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>>> > >               if (*newbootargs) /* If there is something in newboot=
args, a space is needed */
>>> > >                       strcat(newbootargs, " ");
>>> > >               strcat(newbootargs, img_data.kcmdline_extra);
>>> > >       }
>>> > >
>>> > >       env_set("bootargs", newbootargs);
>>> > >
>>> > >>
>>> > >> (3) I don't think it is very much different between your mentioned=
 url with
>>> > >> my patch. There is nothing advanced, but just existing code logic =
reuse and
>>> > >> that logic handled vendor_cmdline in other path. I prefer code log=
ic reuse.
>>> > >
>>> > > The difference is that in the patch I've linked is that we only cha=
nge
>>> > > Android specific boot behaviour. So less risk to impact ChromeOS.
>>> > >
>>> > >>
>>> > >> And I believe above are not the important thing....
>>> > >>
>>> > >>>
>>> > >>> Changing this would potentially break ChromeOS boot behaviour so =
I'd
>>> > >>> prefer to find another solution.
>>> > >>>
>>> > >>> I know that TI has a downstream patch that changes bootmeth_andro=
id.c
>>> > >>> instead:
>>> > >>>
>>> > >>>
>>> > >>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot=
-2024.04-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
>>> > >>
>>> > >>
>>> > >> ...
>>> > >>
>>> > >>
>>> > >>> Would that work for you?
>>> > >>>
>>> > >>>
>>> > >> Well, the one from url also fine with me.
>>> > >>
>>> > >> The important thing is here. So as to ease the change with "minima=
l impact"
>>> > >> gets in. I can add one extra check to maintain original behavior i=
n case
>>> > >> people have concern of breakage. Code example as below:
>>> > >>
>>> > >> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
>>> > >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>>> > >> + else
>>> > >>       ret =3D env_set("bootargs", cmdline);
>>> > >>
>>> > >> This logic eliminated the concern, but it also limited those poten=
tial use
>>> > >> cases for Android boot header version > 2, unless the newly introd=
uced
>>> > >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
>>> > >
>>> > > I'm not sure about why this is better, as from what I understand we
>>> > > handle vendor_boot cmdline properly already.
>>> > >
>>> > > Can you provide me with a test case or some example commands that s=
how
>>> > > that vendor_boot cmdline is not handled properly?
>>> > >
>>> > >>
>>> > >> Or this one with good extendible.
>>> > >> + /* Clean up bootargs purposely */
>>> > >> + if (IS_ENABLED(SOME_FLAG))
>>> > >> +    env_set("bootargs", "");
>>> > >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>>> > >>
>>> > >> Either way. I prefer first one and can blindly apply without affor=
d. I
>>> > >> leave the idea above to people more concern with it. Please let me=
 know
>>> > >> your decision, I can provide one more revision later.
>>> > >
>>> > > I'm sorry there is so much back and forth on this series. I hope we=
 can
>>> > > come to a common agreement and get something merged.

Regards,
Simon
