Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A755CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 16:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7365F83335;
	Wed,  1 Oct 2025 18:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AzeHA9+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FD78344E; Wed,  1 Oct 2025 18:22:50 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB5F81D6A
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 18:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so15932366b.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759335767; x=1759940567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5Rqjd/mq9ecSGiFjoWgldca/kyd/WqZDRVZYEMgX6M=;
 b=AzeHA9+QaflxU8GpXXE7QCZBBjK6GbL82gdpeNrLgBxBCnnjO7BZ433MqE/Z+5ccNB
 CocXBWPjNGSm1Pi5YCgyXlWBar9Iu0riGyo+e1E6g4P/eNfvhwleYuslz0OfmmOUsR3m
 MAeOopAoh3Y8ZoGm/6WsUXCDUioQAUq1w/J7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759335767; x=1759940567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5Rqjd/mq9ecSGiFjoWgldca/kyd/WqZDRVZYEMgX6M=;
 b=We3sRCi2Nxz87H2IhueOFcGq82Kr4RUDXLM+NwsMuatyn/7Fsg06QpmwxGZcgrWRUA
 xejnrN4vXvqj1yhYX2ZW9f6MfS94z8gntWEGCPi9eK1V/1t9kOv1IX3LUUA2eJzGmuAA
 1SKMKPIaU1PwD+aJtZtJCvNp0uQH1gufFBMqXPaQk6GzlDCZcL0AKadOVB4ZTHQ46Exg
 ACZOnbUsFRQ6taGhJqgqr8Eve7DnDPOpLE/53VWE41NJ6NKGGiMdqL7vDtITFSS/ukX6
 dHuNeb/VoAnQN89lvtVYQ6YaJwKb/7e82ZmYhdbjBVp+77/v9FS22GFW1pI47kC5QA0F
 OAOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYduSRBzFB5Mq+PiiGsed7t9eglYTFr49gSLYSgff7+y1Xbw32aAbY7ChGmzPtXwg8JtKlRSo=@lists.denx.de
X-Gm-Message-State: AOJu0YxeW8P4hhJe0J/DPHWSxDOXQDKIE19RK5/tMfIE7dQbGqFDQrSq
 GjnOBfRP78vQv2nKNwQfYqW5MrefDLIFCTjyd5A15SncC0nCkDA2P17mmaKKff6vVoK2JL+LbYB
 N11OvBqYYz64/7DdLIYoI1IyWjB9WLP6z2U3nCucE
X-Gm-Gg: ASbGncuYa7dw4tAWW/q29QuFMqe0mUDKzWA37EzjG/xCfNupN1Wkf0UlCn6YXFDYaxE
 xG9ffBGQfCoJR2/qiSlwbVLBx7+xxbVAlXLOzmAsJcL5QpU76/mORIgfal1XwqQFnVfFFuAzKQo
 QrI0g13m/mXm1Aoc7labGGe7aglLz6Sb++fnVAXubWWPaiw6q6n20No26Fz7CQv9u159NPw0zbU
 5RwRzfbgoK/I6+JFnPVPn/Cy4ooWA==
X-Google-Smtp-Source: AGHT+IFI18bUzq0aa6gYCPeFDkbm2VsDzPX0ciV4z5Kz7LG1+Ho0G43ie/TZAB5dC9TZJqridhIMqz7+Qxl6bmxtc0I=
X-Received: by 2002:a17:907:3fa6:b0:b04:9ad9:5b29 with SMTP id
 a640c23a62f3a-b46e985e19amr615723766b.54.1759335767333; Wed, 01 Oct 2025
 09:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org> <873484jt3u.fsf@kernel.org>
In-Reply-To: <873484jt3u.fsf@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Oct 2025 10:22:34 -0600
X-Gm-Features: AS18NWDO4tUXduqUWZ1hD1-05-ys5bGL_1719PPbby8UAx8nvNM2Ywl6goDlX0M
Message-ID: <CAFLszTjuZb=wwQyKEJFj5TAMhXcWxtuNngwFAURFzju330rRJQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: george chan <gchan9527@gmail.com>, 
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

Hi Mattijs, George,

On Tue, 30 Sept 2025 at 01:29, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Simon,
>
> Now that you are back, could you please have a look at ...
>
> On Fri, Jul 18, 2025 at 14:03, Mattijs Korpershoek <mkorpershoek@kernel.o=
rg> wrote:
>
> > Hi George,
> >
> > On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com> wrote:
> >
> >> Hi Mattijs,
> >>
> >> Thx for reply.
> >>
> >> =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:05=
=EF=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >>> Hi George,
> >>>
> >>> Thank you for the patch.
> >>>
> >> ...
> >>
> >>>
> >>> > -     ret =3D env_set("bootargs", cmdline);
> >>> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >>>
> >>> I don't think it can be done this way. bootm_boot_start() is used in =
the
> >>> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
> >>>
> >>
> >> I got your point. I have 3 ideas come out.
> >>
> >> (1) The logic purposely empty the env bootargs, either developer don't=
 use
> >> env bootargs or those use cases touched bootargs in some early step. A=
nd
> >> then wanna disregard previous u-boot bootmeth operation, and empty boo=
targs
> >> for that ongoing bootmeth stage...well that's not congruent behavior; =
I
> >> have a gut feeling this is a bug or band-aid anyway, it closed the doo=
r for
> >
> > Simon, is it *intentional* that override the bootargs variable in
> > commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
> >
> > Shouldn't we get the bootargs from the environment, and append cmdline
> > to the existing bootargs instead ?

The way U-Boot operates today, bootargs defines the entire cmdline,
not just part of it. So if you use 'env set bootargs ..' you are
changing the entire cmdline passed to Linux, etc.

With ChromeOS, after 'bootflow read', the cmdline can be edited using
'bootflow cmdline set' etc., which also changes bootargs. But in
general ChromeOS provides the whole Linux cmdline to U-Boot.

If you are wanting to append, I suggest writing a new function, or
perhaps adding a 'bool append' arg to bootm_boot_start(), if all the
other code is useful for Android.

>
> ... this question ?
>
> We are wondering why bootm_boot_start() overrides the bootargs variable
> instead of appending cmdline to the existing bootargs instead.
>
> >
> >
> >> people (potentially abootimg) inject needed boot param between bootmet=
h
> >> stage. Perhaps, either clean up bootargs before bootmeth load stage, o=
r add
> >> kconfig to check and enable this logic, a better representation.
> >>
> >> (2) One more thing, the vendor_boot cmdline is not handle neither in
> >> original logic nor in url from you provided. So I can say the url one =
is
> >> not capable for extended with Android boot img version > 2 since
> >> vendor_boot cmdline not handled.
> >
> > What do you mean by the vendor_boot cmdline is not handled?
> >
> > When parsing the vendor_boot image, we go through
> > android_vendor_boot_image_v3_v4_parse_hdr()
> >
> > That function copies the vendor_boot cmdline with:
> >
> >       data->kcmdline_extra =3D hdr->cmdline;
> >
> > (to the struct andr_image_data).
> >
> > Later on, in android_image_get_kernel(), this gets copied to the
> > bootargs:
> >
> >       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> >               if (*newbootargs) /* If there is something in newbootargs=
, a space is needed */
> >                       strcat(newbootargs, " ");
> >               strcat(newbootargs, img_data.kcmdline_extra);
> >       }
> >
> >       env_set("bootargs", newbootargs);
> >
> >>
> >> (3) I don't think it is very much different between your mentioned url=
 with
> >> my patch. There is nothing advanced, but just existing code logic reus=
e and
> >> that logic handled vendor_cmdline in other path. I prefer code logic r=
euse.
> >
> > The difference is that in the patch I've linked is that we only change
> > Android specific boot behaviour. So less risk to impact ChromeOS.
> >
> >>
> >> And I believe above are not the important thing....
> >>
> >>>
> >>> Changing this would potentially break ChromeOS boot behaviour so I'd
> >>> prefer to find another solution.
> >>>
> >>> I know that TI has a downstream patch that changes bootmeth_android.c
> >>> instead:
> >>>
> >>>
> >>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-202=
4.04-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
> >>
> >>
> >> ...
> >>
> >>
> >>> Would that work for you?
> >>>
> >>>
> >> Well, the one from url also fine with me.
> >>
> >> The important thing is here. So as to ease the change with "minimal im=
pact"
> >> gets in. I can add one extra check to maintain original behavior in ca=
se
> >> people have concern of breakage. Code example as below:
> >>
> >> + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
> >> +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >> + else
> >>       ret =3D env_set("bootargs", cmdline);
> >>
> >> This logic eliminated the concern, but it also limited those potential=
 use
> >> cases for Android boot header version > 2, unless the newly introduced
> >> CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
> >
> > I'm not sure about why this is better, as from what I understand we
> > handle vendor_boot cmdline properly already.
> >
> > Can you provide me with a test case or some example commands that show
> > that vendor_boot cmdline is not handled properly?
> >
> >>
> >> Or this one with good extendible.
> >> + /* Clean up bootargs purposely */
> >> + if (IS_ENABLED(SOME_FLAG))
> >> +    env_set("bootargs", "");
> >> + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >>
> >> Either way. I prefer first one and can blindly apply without afford. I
> >> leave the idea above to people more concern with it. Please let me kno=
w
> >> your decision, I can provide one more revision later.
> >
> > I'm sorry there is so much back and forth on this series. I hope we can
> > come to a common agreement and get something merged.

Regards,
Simon
