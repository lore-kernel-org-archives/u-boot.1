Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AEFCAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 15:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521108349B;
	Sun,  5 Oct 2025 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VudqRb63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D944F8206E; Sun,  5 Oct 2025 17:41:39 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F8B808AF
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 17:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-8e3eaa30c71so3827214241.0
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759678895; x=1760283695; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6W5d2PffRIO5LA2WXxF5rII0NJTLjkDbI5pe8apNyk8=;
 b=VudqRb63pxM17vxKVzfdRzEIfc35AS8BTk9Dd/PWvTG4v8sVgatMnqG3FuR4Qfrwuw
 6ZVqMfNJYvrDpLDlsYhQ96kKr2sz8QNZSz1SKoDQz7wloZzF1SL84nW11zrScrr2oDN6
 jZQi2JTM0ks6NC/eRARYXZOUdM13nVUFKvBAUtygZx3fy0yKkbjJPwCwWUDzHgWfWLQ/
 fx0rMk8fYG10gkIVtK45PqsYeSbRRpGmWTL321DG7LqsEohsMB5T0AwrXQnl4owxe2d4
 7jv+0fYJWQtT2Gml7rKHPr+ahadKM57NrPyhgI9c5FdI8SdT7R6T8giuOCOTzkX3IZc2
 xYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759678895; x=1760283695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6W5d2PffRIO5LA2WXxF5rII0NJTLjkDbI5pe8apNyk8=;
 b=IlqIZZF9ESnp82N6IEEcBuGuNUfWxkApcRzXWsRzre0+UU6onKf1dQ6s/y2Rws/82v
 ersslSzb9+4kOh2AZd9iT21h9iupOlfRfo+zQse+aBHMcqa10Pw0sRlQJwsBdoFiH0WN
 1TsictyqSAadfRC6brtTV5elY3q2bujgzxUO/FheJqfxqbXpW/QWmqudgxBA4Tr2O/+R
 JvaA1Iq/i3Bu/nldF0DIbenY9S9IL2u78ApSHJv95wWnsaCMvVgF0LfrgxWiJFFWp9eZ
 aSV5Xqv1iNkcba3QRGpZWFVuxGg+6C4N0NI8g708CviGnyUh0cCn43eNFMs0UnhiIIDL
 Rejw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxOvwc1ROCPDsV0LxVRkF5mWRllLivBuxFEAScheVgA+y9dVHSFKdAH+D6HrvpnErJMgTVk04=@lists.denx.de
X-Gm-Message-State: AOJu0YyASkN3C2cL7eqQhO4hNRpBI5YjJ/lUgVZOtTRtrvEta14X2ytl
 KVsiVjaol3QS4mOyTMluFOZataCK0TTwm+PMQTxDzpRHDQuVBN6CVzvqADqT9TqbKsHergjnL/9
 MT3yEhAHHW7Q4KJkbFnOhIqPW0Rh1FNg=
X-Gm-Gg: ASbGncuTcGaZ1iMfPwOEpn+xMgwhXoPHcpqHM9iXg3ek4VJhQbfLguSnuAThEbYa3+p
 y+4a8ft0d6i/ZybzWSr4JupBhOc5vrINS/TTp7xFb6UtWwB3YAJt/vNu8bX69+mhNDGFkj9IWTh
 s00lFXFXtTHdB7AdP+fBqPQhZNEMhpKVX4oBYyhJ/D9RJCPiW61wr28UdhYozlYDEZoOr5QlV9m
 WaJTe58nMNaBjCeRUagyyOZ5RtW6wyj
X-Google-Smtp-Source: AGHT+IHk3830HSY1uDs5V8zn3WLdvMCqUwVCCbx8eox1znOBc/a4dNbMl0PPWF9O3DF1tkrfszsU5V7eZxhFbl3O8aE=
X-Received: by 2002:a05:6122:1d44:b0:542:d782:2522 with SMTP id
 71dfb90a1353d-5524ea76019mr3824330e0c.14.1759678895399; Sun, 05 Oct 2025
 08:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org> <873484jt3u.fsf@kernel.org>
 <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
 <CADgMGSu1es4dex1u=6ai4WEBK2Loo2RAZdONRf07AqTWhZL8mQ@mail.gmail.com>
In-Reply-To: <CADgMGSu1es4dex1u=6ai4WEBK2Loo2RAZdONRf07AqTWhZL8mQ@mail.gmail.com>
From: george chan <gchan9527@gmail.com>
Date: Sun, 5 Oct 2025 23:41:23 +0800
X-Gm-Features: AS18NWBn6gs2U4ImgkdABC4s3w6QevwvcJGBF62Z1GY8sJjOrXeSBXrfVVvZIgc
Message-ID: <CADgMGSu7n+85gzdescBJd27WKvwryhtvXzY4MX3BWR=oLsLyhA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Sun, 05 Oct 2025 17:48:18 +0200
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

=E5=9C=A8 2025=E5=B9=B410=E6=9C=885=E6=97=A5=E9=80=B1=E6=97=A5 00:35=EF=BC=
=8Cgeorge chan <gchan9527@gmail.com> =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi Simon and Mattijs,
>
> Thx for feedback. Just in case the discussion drift to other direction, d=
o
> let me have a chance to put some background info here.
>
> there are ways for pre-set env variable and its value. Firstly external
> env file and loaded by uboot, like, runtime handling; and another type is
> build time embed env file into uboot body.
>
> maybe in chromeos case first stage boot loader will pass along bootinfo
> struct to uboot and treat as preset defaults.
>
> so in either case uboot can have right to choose the preset from (by
> disable external env file, secured/trusted boot?), and then either follow
> the bootinfo struct preset value and/or concat and/or overrite with uboot=
=E2=80=99s
> own embedded env value at boot time, and then runtime modify.
>
> This behavior maybe enable or disable by kconfig. but in secured boot
> context point of view, env file kind of thing, might have potential desig=
n
> wise conflict. And this is not within my scope.
>
> in some other use case like simulation of vendor bootloader behavior to
> have a build time preset default value, this is within my scope. and that=
s
> why i decided to put those preset into env file and embeded.
>
> let me reply below inline.
>
> =E5=9C=A8 2025=E5=B9=B410=E6=9C=882=E6=97=A5=E9=80=B1=E5=9B=9B 00:22=EF=
=BC=8CSimon Glass <sjg@chromium.org> =E5=AF=AB=E9=81=93=EF=BC=9A
>
>> Hi Mattijs, George,
>>
>> On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
>> <mkorpershoek@kernel.org> wrote:
>> >
>> > Hi Simon,
>> >
>> > Now that you are back, could you please have a look at ...
>> >
>> > On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <
>> mkorpershoek@kernel.org> wrote:
>> >
>> > > Hi George,
>> > >
>> > > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com>
>> wrote:
>> > >
>> > >> Hi Mattijs,
>> > >>
>> > >> Thx for reply.
>> > >>
>> > >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:0=
5=EF=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org>
>> =E5=AF=AB=E9=81=93=EF=BC=9A
>> > >>
>> > >>> Hi George,
>> > >>>
>> > >>> Thank you for the patch.
>> > >>>
>> > >> ...
>> > >>
>> > >>>
>> > >>> > -     ret =3D env_set("bootargs", cmdline);
>> > >>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>> > >>>
>> > >>> I don't think it can be done this way. bootm_boot_start() is used
>> in the
>> > >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
>> > >>>
>> > >>
>> > >> I got your point. I have 3 ideas come out.
>> > >>
>> > >> (1) The logic purposely empty the env bootargs, either developer
>> don't use
>> > >> env bootargs or those use cases touched bootargs in some early step=
.
>> And
>> > >> then wanna disregard previous u-boot bootmeth operation, and empty
>> bootargs
>> > >> for that ongoing bootmeth stage...well that's not congruent
>> behavior; I
>> > >> have a gut feeling this is a bug or band-aid anyway, it closed the
>> door for
>> > >
>> > > Simon, is it *intentional* that override the bootargs variable in
>> > > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
>> > >
>> > > Shouldn't we get the bootargs from the environment, and append cmdli=
ne
>> > > to the existing bootargs instead ?
>>
>> The way U-Boot operates today, bootargs defines the entire cmdline,
>> not just part of it. So if you use 'env set bootargs ..' you are
>> changing the entire cmdline passed to Linux, etc.
>>
>
> This is runtime change. My test case in fastboot path, it get bootargs
> wiped and filling in with something from boot img. That might share same
> procedure with other boot method like chromeos do. Wipe env default each
> time in fastboot (when fail) might be a secure-wise handling.
>
> And I feel it is a critical entry point logic like a central hub, and
> looking good to decide uboot behavior here. By kconfig whatever? Again, o=
ut
> of my scope.
>
>
>> With ChromeOS, after 'bootflow read', the cmdline can be edited using
>> 'bootflow cmdline set' etc., which also changes bootargs. But in
>> general ChromeOS provides the whole Linux cmdline to U-Boot.
>>
>
> this is also runtime change. And as a side note, if by doing bootflow
> select, should env bootargs gets overrided or appended? This is a bigger
> arch-wise question worth at least a public paper. and I might not go into
> this depth.
>
>
>> If you are wanting to append, I suggest writing a new function, or
>>
>
> yeah agreed. I do more appreciate and feel it really lower project
> management/test cost.
>
> perhaps adding a 'bool append' arg to bootm_boot_start(), if all the
>> other code is useful for Android.
>>
>
> A more simpler method is to create bootm_boot_start_ex(kernel_cmd_line,
> vendor_cmd_line) as
>  I proposed to complement with
>  bootm_boot_start(cmdline) or even add one layer of abstract, called from
> bootm_boot_start(), make vendor_cmd_line param as null. As can preserve t=
he
> old logic and behavior.
>
> So build time env preset value, and runtime value override decision can
> live in this new function, or elsewhere; but is not within my scope.
>

Tr/Dr I wrote a proof of concept code here:

https://github.com/99degree/u-boot/compare/before_tag...reboot-mode?expand=
=3D1



> So I leave it as a open-end question here. Once you had decided then feel
> free to let me know and I can do one extra round patch. Thank again for
> feedback.
>
> George
>
>
>> >
>> > ... this question ?
>> >
>> > We are wondering why bootm_boot_start() overrides the bootargs variabl=
e
>> > instead of appending cmdline to the existing bootargs instead.
>> >
>> > >
>> > >
>> > >> people (potentially abootimg) inject needed boot param between
>> bootmeth
>> > >> stage. Perhaps, either clean up bootargs before bootmeth load stage=
,
>> or add
>> > >> kconfig to check and enable this logic, a better representation.
>> > >>
>> > >> (2) One more thing, the vendor_boot cmdline is not handle neither i=
n
>> > >> original logic nor in url from you provided. So I can say the url
>> one is
>> > >> not capable for extended with Android boot img version > 2 since
>> > >> vendor_boot cmdline not handled.
>> > >
>> > > What do you mean by the vendor_boot cmdline is not handled?
>> > >
>> > > When parsing the vendor_boot image, we go through
>> > > android_vendor_boot_image_v3_v4_parse_hdr()
>> > >
>> > > That function copies the vendor_boot cmdline with:
>> > >
>> > >       data->kcmdline_extra =3D hdr->cmdline;
>> > >
>> > > (to the struct andr_image_data).
>> > >
>> > > Later on, in android_image_get_kernel(), this gets copied to the
>> > > bootargs:
>> > >
>> > >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>> > >               if (*newbootargs) /* If there is something in
>> newbootargs, a space is needed */
>> > >                       strcat(newbootargs, " ");
>> > >               strcat(newbootargs, img_data.kcmdline_extra);
>> > >       }
>> > >
>> > >       env_set("bootargs", newbootargs);
>> > >
>> > >>
>> > >> (3) I don't think it is very much different between your mentioned
>> url with
>> > >> my patch. There is nothing advanced, but just existing code logic
>> reuse and
>> > >> that logic handled vendor_cmdline in other path. I prefer code logi=
c
>> reuse.
>> > >
>> > > The difference is that in the patch I've linked is that we only chan=
ge
>> > > Android specific boot behaviour. So less risk to impact ChromeOS.
>> > >
>> > >>
>> > >> And I believe above are not the important thing....
>> > >>
>> > >>>
>> > >>> Changing this would potentially break ChromeOS boot behaviour so I=
'd
>> > >>> prefer to find another solution.
>> > >>>
>> > >>> I know that TI has a downstream patch that changes
>> bootmeth_android.c
>> > >>> instead:
>> > >>>
>> > >>>
>> > >>>
>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.0=
4-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
>> > >>
>> > >>
>> > >> ...
>> > >>
>> > >>
>> > >>> Would that work for you?
>> > >>>
>> > >>>
>> > >> Well, the one from url also fine with me.
>> > >>
>> > >> The important thing is here. So as to ease the change with "minimal
>> impact"
>> > >> gets in. I can add one extra check to maintain original behavior in
>> case
>> > >> people have concern of breakage. Code example as below:
>> > >>
>> > >> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
>> > >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>> > >> + else
>> > >>       ret =3D env_set("bootargs", cmdline);
>> > >>
>> > >> This logic eliminated the concern, but it also limited those
>> potential use
>> > >> cases for Android boot header version > 2, unless the newly
>> introduced
>> > >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
>> > >
>> > > I'm not sure about why this is better, as from what I understand we
>> > > handle vendor_boot cmdline properly already.
>> > >
>> > > Can you provide me with a test case or some example commands that sh=
ow
>> > > that vendor_boot cmdline is not handled properly?
>> > >
>> > >>
>> > >> Or this one with good extendible.
>> > >> + /* Clean up bootargs purposely */
>> > >> + if (IS_ENABLED(SOME_FLAG))
>> > >> +    env_set("bootargs", "");
>> > >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>> > >>
>> > >> Either way. I prefer first one and can blindly apply without afford=
.
>> I
>> > >> leave the idea above to people more concern with it. Please let me
>> know
>> > >> your decision, I can provide one more revision later.
>> > >
>> > > I'm sorry there is so much back and forth on this series. I hope we
>> can
>> > > come to a common agreement and get something merged.
>>
>> Regards,
>> Simon
>>
>
