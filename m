Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D0CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A278394A;
	Wed,  8 Oct 2025 14:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XbZDGX9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42AA83A79; Wed,  8 Oct 2025 14:51:38 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692588393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-634b774f135so13072367a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759927896; x=1760532696; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eb5ufmybX9a9LHxLmAvWnEpLLVYpQbabQ/60XnQPBHQ=;
 b=XbZDGX9nN33gWvr+cLwZ8Lm+j+Fadwf6buCnyi/VjqSZMF5xqxcDFGphAPZpnX9WRJ
 Qea8hS59Ogb2VJ3QWyZ1FJm0fn7FKMnJDfzUUOef2wu/ntK42437OyS979mbU3a1yHWs
 aUmF5iEuKzrpjpORhbbHDRjbfBdraDTNaqyBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759927896; x=1760532696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eb5ufmybX9a9LHxLmAvWnEpLLVYpQbabQ/60XnQPBHQ=;
 b=o4O4Cs370M+AJojPjQ6A8QukEe9vhzaDRA91POPvJINZaGzK9hBOGGnDuFrRfuh6YA
 Gst8W9Kc69xk6AW62J/UHZhcqfV999ddcM9bD9OdgFbKs9a+hZh6ZQv1lW7APVgKIn+T
 ADm0LneAV99sd3+vvbUcc0+5qeW3R3UhBDrEU1zdFSvH54F6xld0Rw5scKBBMpiK60gh
 mrcdIahWTnhQ0fytXrfgmTTPt030F8fHr/lZWJ92w/KzEEFpDIWwH5zubmhrzJq6iH38
 Q3cdNFYW5ebP24K3ISvOHUdylYFpI5rjqt7IfycOefGtW+xHLxXPBXeTNx/bkhVSUqkU
 6agw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjMGYipldOLmOh5TyBSH24HUveSuKj8PA1SumKbJzKp067ApmR75x/WLVmp+HhNGj4GNhCgPA=@lists.denx.de
X-Gm-Message-State: AOJu0YxFh8dhmd1TJiWZ619zzCSfyWEgxeKj+sC1KGljjKwPZhci+xyf
 pZBRr3AwJ2y4G52cn5Fli6fbDXxzB36vz4gemfiX4TD899GEhYMEEquulab/KRTad8pcq2fiYUY
 F0kmkLEQAWMYy3k8exdtCtNTxCm8ISuwNVgXkbEDx
X-Gm-Gg: ASbGncsKHQvbnHlp8MKs8TpvGqx7cLEuAiH/elvMSwCyBf4L2xOn0u8m+bwBG66rRir
 cR8sJh1L7RLcGAGBwoWiGJz+qHzBjLfO/sRevI+AZ9oxbfy9PFEuTYsJ78gntaoU2WZ96bs9R1w
 lHip/OLqF/6EKICwJ0Tsj30x7iN+gnhBepecvdjwtZG42fqdD9qjSV9qLcQDFtmFVaxUDOfYsvA
 WC9/ibmGOvwFraxXG9HD3LHp6Namw==
X-Google-Smtp-Source: AGHT+IH6vqXtbvsslyBnOqvtn9r9JdXNkNYGhacjP1n3fnMKM/wt02k+UT2ZutDXc754Pp4r9wFYSVUW70fDoaMr9as=
X-Received: by 2002:a05:6402:2808:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-639d5c5e6bamr3056197a12.32.1759927895634; Wed, 08 Oct 2025
 05:51:35 -0700 (PDT)
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
In-Reply-To: <CADgMGSuH21te1Mqy3Z0C8R6seoUHLffvLyuVY-ukVtKHi3GVOA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 06:51:23 -0600
X-Gm-Features: AS18NWASWEHkCEj4R_45S3MnEOU5EfCxov6nd-U61qGbTdzU-JIRyp4EifcJK2c
Message-ID: <CAFLszTgCKUmXh1DsdbUU3qHoLc59muyb8mN13+cB22FtrxJYKw@mail.gmail.com>
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

On Tue, 7 Oct 2025 at 10:03, george chan <gchan9527@gmail.com> wrote:
>
> Hi Simon,
>
> Thx for feedback.
>
>
> =E5=9C=A8 2025=E5=B9=B410=E6=9C=887=E6=97=A5=E9=80=B1=E4=BA=8C 04:38=EF=
=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> Hi George,
>>
>> On Sun, 5 Oct 2025 at 09:41, george chan <gchan9527@gmail.com> wrote:
>> >
>> >
>> >
>> > =E5=9C=A8 2025=E5=B9=B410=E6=9C=885=E6=97=A5=E9=80=B1=E6=97=A5 00:35=
=EF=BC=8Cgeorge chan <gchan9527@gmail.com> =E5=AF=AB=E9=81=93=EF=BC=9A
>> >>
>> >> Hi Simon and Mattijs,
>> >>
>> >> Thx for feedback. Just in case the discussion drift to other directio=
n, do let me have a chance to put some background info here.
>> >>
>> >> there are ways for pre-set env variable and its value. Firstly extern=
al env file and loaded by uboot, like, runtime handling; and another type i=
s build time embed env file into uboot body.
>> >>
>> >> maybe in chromeos case first stage boot loader will pass along bootin=
fo struct to uboot and treat as preset defaults.
>> >>
>> >> so in either case uboot can have right to choose the preset from (by =
disable external env file, secured/trusted boot?), and then either follow t=
he bootinfo struct preset value and/or concat and/or overrite with uboot=E2=
=80=99s own embedded env value at boot time, and then runtime modify.
>> >>
>> >> This behavior maybe enable or disable by kconfig. but in secured boot=
 context point of view, env file kind of thing, might have potential design=
 wise conflict. And this is not within my scope.
>> >>
>> >> in some other use case like simulation of vendor bootloader behavior =
to have a build time preset default value, this is within my scope. and tha=
ts why i decided to put those preset into env file and embeded.
>> >>
>> >> let me reply below inline.
>> >>
>> >> =E5=9C=A8 2025=E5=B9=B410=E6=9C=882=E6=97=A5=E9=80=B1=E5=9B=9B 00:22=
=EF=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
>> >>>
>> >>> Hi Mattijs, George,
>> >>>
>> >>> On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
>> >>> <mkorpershoek@kernel.org> wrote:
>> >>> >
>> >>> > Hi Simon,
>> >>> >
>> >>> > Now that you are back, could you please have a look at ...
>> >>> >
>> >>> > On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <mkorpershoek@k=
ernel.org> wrote:
>> >>> >
>> >>> > > Hi George,
>> >>> > >
>> >>> > > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com>=
 wrote:
>> >>> > >
>> >>> > >> Hi Mattijs,
>> >>> > >>
>> >>> > >> Thx for reply.
>> >>> > >>
>> >>> > >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 =
17:05=EF=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=
=93=EF=BC=9A
>> >>> > >>
>> >>> > >>> Hi George,
>> >>> > >>>
>> >>> > >>> Thank you for the patch.
>> >>> > >>>
>> >>> > >> ...
>> >>> > >>
>> >>> > >>>
>> >>> > >>> > -     ret =3D env_set("bootargs", cmdline);
>> >>> > >>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NUL=
L);
>> >>> > >>>
>> >>> > >>> I don't think it can be done this way. bootm_boot_start() is u=
sed in the
>> >>> > >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
>> >>> > >>>
>> >>> > >>
>> >>> > >> I got your point. I have 3 ideas come out.
>> >>> > >>
>> >>> > >> (1) The logic purposely empty the env bootargs, either develope=
r don't use
>> >>> > >> env bootargs or those use cases touched bootargs in some early =
step. And
>> >>> > >> then wanna disregard previous u-boot bootmeth operation, and em=
pty bootargs
>> >>> > >> for that ongoing bootmeth stage...well that's not congruent beh=
avior; I
>> >>> > >> have a gut feeling this is a bug or band-aid anyway, it closed =
the door for
>> >>> > >
>> >>> > > Simon, is it *intentional* that override the bootargs variable i=
n
>> >>> > > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
>> >>> > >
>> >>> > > Shouldn't we get the bootargs from the environment, and append c=
mdline
>> >>> > > to the existing bootargs instead ?
>> >>>
>> >>> The way U-Boot operates today, bootargs defines the entire cmdline,
>> >>> not just part of it. So if you use 'env set bootargs ..' you are
>> >>> changing the entire cmdline passed to Linux, etc.
>> >>
>> >>
>> >> This is runtime change. My test case in fastboot path, it get bootarg=
s wiped and filling in with something from boot img. That might share same =
procedure with other boot method like chromeos do. Wipe env default each ti=
me in fastboot (when fail) might be a secure-wise handling.
>> >>
>> >> And I feel it is a critical entry point logic like a central hub, and=
 looking good to decide uboot behavior here. By kconfig whatever? Again, ou=
t of my scope.
>> >>
>> >>>
>> >>> With ChromeOS, after 'bootflow read', the cmdline can be edited usin=
g
>> >>> 'bootflow cmdline set' etc., which also changes bootargs. But in
>> >>> general ChromeOS provides the whole Linux cmdline to U-Boot.
>> >>
>> >>
>> >> this is also runtime change. And as a side note, if by doing bootflow=
 select, should env bootargs gets overrided or appended? This is a bigger a=
rch-wise question worth at least a public paper. and I might not go into th=
is depth.
>> >>
>> >>>
>> >>> If you are wanting to append, I suggest writing a new function, or
>> >>
>> >>
>> >> yeah agreed. I do more appreciate and feel it really lower project ma=
nagement/test cost.
>> >>
>> >>> perhaps adding a 'bool append' arg to bootm_boot_start(), if all the
>> >>> other code is useful for Android.
>> >>
>> >>
>> >> A more simpler method is to create bootm_boot_start_ex(kernel_cmd_lin=
e, vendor_cmd_line) as
>> >>  I proposed to complement with
>> >>  bootm_boot_start(cmdline) or even add one layer of abstract, called =
from bootm_boot_start(), make vendor_cmd_line param as null. As can preserv=
e the old logic and behavior.
>> >>
>> >> So build time env preset value, and runtime value override decision c=
an live in this new function, or elsewhere; but is not within my scope.
>> >
>> >
>> > Tr/Dr I wrote a proof of concept code here:
>> >
>> > https://github.com/99degree/u-boot/compare/before_tag...reboot-mode?ex=
pand=3D1
>>
>> This thread is a bit confusing now, but it seems you have written a
>
>
> I am sorry but I had to prove my patch is necessary and correctnessly and=
 also limit the scope of the patch. Thanks for your understand.
>
>> new function and that is fine with me, as it won't affect ChromeOS.
>
>
> There is no new function at all. I am sorry to put more info here again t=
o let related code to be clear for every audience here.
>
> As you may notice function bootm_modify_bootargs_env() is a renamed and m=
ove to bootm.c which is split/extracted from existing function android_imag=
e_get_kernel()
>
> And bootm_boot_start_ex() is split from
> bootm_boot_start() with your suggested enable param.
>
> I am afraid if you or other reviewer might wonder why move to bootm.c and=
 here is the reason.
>
> Supposed with below 2 code paths:
>
> Boot->bootflow->bootmeth_android->bootm
> Boot->fastboot->do_bootm->bootm
>
> I believe android_image_get_kernel is living around within bootmeth_andro=
id stage so first two patch has taken care of. But fastboot path is not. th=
at might be the reason above two path need separate special handling for.
>
> So as to code reuse with fastboot path then those code had to move to boo=
tm layer.
>
> And my understanding each stage is isolated, and depends on env as a kind=
 of api to link up each stage. Then I believe the patch is now a clean solu=
tion. Anyway welcome to jot a mail if there are suggestions, if any doubt, =
please jot a mail too.

It seems fine to me, but the thread is becoming confusing. Could you
send a patch?



>
> Thanks,
> George
>
>>
>>
>> >
>> >
>> >>
>> >> So I leave it as a open-end question here. Once you had decided then =
feel free to let me know and I can do one extra round patch. Thank again fo=
r feedback.
>> >>
>> >> George
>> >>
>> >>>
>> >>> >
>> >>> > ... this question ?
>> >>> >
>> >>> > We are wondering why bootm_boot_start() overrides the bootargs var=
iable
>> >>> > instead of appending cmdline to the existing bootargs instead.
>> >>> >
>> >>> > >
>> >>> > >
>> >>> > >> people (potentially abootimg) inject needed boot param between =
bootmeth
>> >>> > >> stage. Perhaps, either clean up bootargs before bootmeth load s=
tage, or add
>> >>> > >> kconfig to check and enable this logic, a better representation=
.
>> >>> > >>
>> >>> > >> (2) One more thing, the vendor_boot cmdline is not handle neith=
er in
>> >>> > >> original logic nor in url from you provided. So I can say the u=
rl one is
>> >>> > >> not capable for extended with Android boot img version > 2 sinc=
e
>> >>> > >> vendor_boot cmdline not handled.
>> >>> > >
>> >>> > > What do you mean by the vendor_boot cmdline is not handled?
>> >>> > >
>> >>> > > When parsing the vendor_boot image, we go through
>> >>> > > android_vendor_boot_image_v3_v4_parse_hdr()
>> >>> > >
>> >>> > > That function copies the vendor_boot cmdline with:
>> >>> > >
>> >>> > >       data->kcmdline_extra =3D hdr->cmdline;
>> >>> > >
>> >>> > > (to the struct andr_image_data).
>> >>> > >
>> >>> > > Later on, in android_image_get_kernel(), this gets copied to the
>> >>> > > bootargs:
>> >>> > >
>> >>> > >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>> >>> > >               if (*newbootargs) /* If there is something in newb=
ootargs, a space is needed */
>> >>> > >                       strcat(newbootargs, " ");
>> >>> > >               strcat(newbootargs, img_data.kcmdline_extra);
>> >>> > >       }
>> >>> > >
>> >>> > >       env_set("bootargs", newbootargs);
>> >>> > >
>> >>> > >>
>> >>> > >> (3) I don't think it is very much different between your mentio=
ned url with
>> >>> > >> my patch. There is nothing advanced, but just existing code log=
ic reuse and
>> >>> > >> that logic handled vendor_cmdline in other path. I prefer code =
logic reuse.
>> >>> > >
>> >>> > > The difference is that in the patch I've linked is that we only =
change
>> >>> > > Android specific boot behaviour. So less risk to impact ChromeOS=
.
>> >>> > >
>> >>> > >>
>> >>> > >> And I believe above are not the important thing....
>> >>> > >>
>> >>> > >>>
>> >>> > >>> Changing this would potentially break ChromeOS boot behaviour =
so I'd
>> >>> > >>> prefer to find another solution.
>> >>> > >>>
>> >>> > >>> I know that TI has a downstream patch that changes bootmeth_an=
droid.c
>> >>> > >>> instead:
>> >>> > >>>
>> >>> > >>>
>> >>> > >>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-b=
oot-2024.04-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
>> >>> > >>
>> >>> > >>
>> >>> > >> ...
>> >>> > >>
>> >>> > >>
>> >>> > >>> Would that work for you?
>> >>> > >>>
>> >>> > >>>
>> >>> > >> Well, the one from url also fine with me.
>> >>> > >>
>> >>> > >> The important thing is here. So as to ease the change with "min=
imal impact"
>> >>> > >> gets in. I can add one extra check to maintain original behavio=
r in case
>> >>> > >> people have concern of breakage. Code example as below:
>> >>> > >>
>> >>> > >> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS=
))
>> >>> > >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>> >>> > >> + else
>> >>> > >>       ret =3D env_set("bootargs", cmdline);
>> >>> > >>
>> >>> > >> This logic eliminated the concern, but it also limited those po=
tential use
>> >>> > >> cases for Android boot header version > 2, unless the newly int=
roduced
>> >>> > >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
>> >>> > >
>> >>> > > I'm not sure about why this is better, as from what I understand=
 we
>> >>> > > handle vendor_boot cmdline properly already.
>> >>> > >
>> >>> > > Can you provide me with a test case or some example commands tha=
t show
>> >>> > > that vendor_boot cmdline is not handled properly?
>> >>> > >
>> >>> > >>
>> >>> > >> Or this one with good extendible.
>> >>> > >> + /* Clean up bootargs purposely */
>> >>> > >> + if (IS_ENABLED(SOME_FLAG))
>> >>> > >> +    env_set("bootargs", "");
>> >>> > >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>> >>> > >>
>> >>> > >> Either way. I prefer first one and can blindly apply without af=
ford. I
>> >>> > >> leave the idea above to people more concern with it. Please let=
 me know
>> >>> > >> your decision, I can provide one more revision later.
>> >>> > >
>> >>> > > I'm sorry there is so much back and forth on this series. I hope=
 we can
>> >>> > > come to a common agreement and get something merged.
Regards,
Simon
