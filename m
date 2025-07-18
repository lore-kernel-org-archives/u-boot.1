Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F0C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 18:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3411C8363D;
	Fri, 18 Jul 2025 20:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QMttnsAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EF9836AC; Fri, 18 Jul 2025 19:17:40 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B3D834EC
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4ab3fb340e7so41166961cf.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752859056; x=1753463856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PHlsA3l2YlUl1D2evuL1e4ctDZ8ODywCXafvCFkFPE0=;
 b=QMttnsApfSshplHw42V4DCR/QclW/fzWNH8NbxaEPx/9TuB0GGOw5kWOdPZWGysKre
 EfICm5iC9akQw/PpV8FG822sLHR2ncO+phrRO8n8qTSTFuyqDgPvuUFC0tY1ChtxfZnq
 tsBcIP2Uxzshb6NtvNm8SlISs61P7+8qdJ040k8xJqa8WOWP3l0Rq2TT+QeD6ygGLZnD
 txOopEYVHKozfHwQaGGPkvGBULldsp2vrzoic+wJv8OWkB9o1P0nN5GMpX2mx+ENkS5V
 5+UOrZoKuB25lh2MgoAGknR+EF1igFxpdX+fD33p4CU0WiK78gYk3Bow0HIz2LxRhxqf
 HVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859056; x=1753463856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PHlsA3l2YlUl1D2evuL1e4ctDZ8ODywCXafvCFkFPE0=;
 b=UCLjlbtJV4V+WMIb2S4vcIuYpTUB3jsFVa2TAfZS+4rwxxWLiAHHhnub4NZXYOU4ul
 0rvSrkKxjkKlOD3+KpmhZ2fZvEUjt8Wnr8Y/XADe3E745uMSuFoVMQX7QPjhWvfXsBwd
 8s155dufVduA6mhRWnVnLzlJSh2Chd36LJZfslrHvZpYpiyjKkNXsSGCio06MSlGOi5J
 JNLY7VU2y60dGSEIzRItBXW4dYkipApWNa/k6Te2xeWzDiOHEPOlDkyX6GRb8uJpTHNP
 Tww9dQ6NQKcc/c/HxyIDf9A1LTZgUgl6y23gEHnBBLg6Q9JhD6XX4Xg3Y/ILSsgSEkZS
 d1dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/PsFjiGIu4pa2GbktQGw5qUGlxa7pi7hyBMB1GkI8e3hFll5k72cTIweZxtACCYYzCaJsHA=@lists.denx.de
X-Gm-Message-State: AOJu0YxePFq6W2Np3n0IRqvJuwzl5HfXtSWXUOKfJMIn1hI7FAW4oQlH
 xkf4Oq62xeyfaE8BwXFwxpA/juVtPSbe1ZacORVKKdvu+DefjvVP1jXxONlzp+N5xwgjK1HqFjc
 i+8XenKsv0b/zKEWfEYnQFcdpuO7agRc=
X-Gm-Gg: ASbGnct2pTIL77kH6ZXC1ICx5QBXToyvogempZtRkeU2Kc8hqRBiHzWh3l/CTeoU52k
 nNHnrxw3IL7XXgmXvPUPOi/dFtACLijIGp3xLUYdv9PzsLzn4OdDufI/lvLurrPuA/hLmn8aYwL
 M2e+zt8XUJQpKYznFUEM9/0aGzDDbhIKPUo18F6Vb1NbPIv86y4mTHAUvroxNy1EIEnF2YBRVXY
 RoZr9C7YA==
X-Google-Smtp-Source: AGHT+IH0BVrvDLKY/Y89M8WYvyf7tSosXXn+zgZMqN9J4zwn+ZM9ywdb84uAD+KcyujuLabXj3ALl0V/Agu0lAasB3g=
X-Received: by 2002:ac8:5805:0:b0:4a7:1402:cce9 with SMTP id
 d75a77b69052e-4abb2c7b46amr60146541cf.7.1752859055952; Fri, 18 Jul 2025
 10:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
 <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
 <871pqdaepm.fsf@kernel.org>
In-Reply-To: <871pqdaepm.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Sat, 19 Jul 2025 01:17:23 +0800
X-Gm-Features: Ac12FXw5PutbUAPtkXosTJ7Pl5LJaUIs9UGxZ9Dmok0ye7GoXfjX-5cAlpxXgFc
Message-ID: <CADgMGSuQbeDGfiBRxCFsUNOvTS7b6u4vqDR3RGGH-gEPwC8HQQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, 
 George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Fri, 18 Jul 2025 20:23:34 +0200
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

Hi Mattijs,

Congrats to be a new dad.

=E5=9C=A8 2025=E5=B9=B47=E6=9C=8818=E6=97=A5=E9=80=B1=E4=BA=94 20:03=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi George,
>
> On Wed, Jul 16, 2025 at 19:55, george chan <gchan9527@gmail.com> wrote:
>
> > Hi Mattijs,
> >
> > Thx for reply.
> >
> > =E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:05=EF=
=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> >> Hi George,
> >>
> >> Thank you for the patch.
> >>
> > ...
> >
> >>
> >> > -     ret =3D env_set("bootargs", cmdline);
> >> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >>
> >> I don't think it can be done this way. bootm_boot_start() is used in t=
he
> >> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
> >>
> >
> > I got your point. I have 3 ideas come out.
> >
> > (1) The logic purposely empty the env bootargs, either developer don't
> use
> > env bootargs or those use cases touched bootargs in some early step. An=
d
> > then wanna disregard previous u-boot bootmeth operation, and empty
> bootargs
> > for that ongoing bootmeth stage...well that's not congruent behavior; I
> > have a gut feeling this is a bug or band-aid anyway, it closed the door
> for
>
> Simon, is it *intentional* that override the bootargs variable in
> commit daffb0be2c83 ("bootstd: cros: Add ARM support") ?
>
> Shouldn't we get the bootargs from the environment, and append cmdline
> to the existing bootargs instead ?
>
>
> > people (potentially abootimg) inject needed boot param between bootmeth
> > stage. Perhaps, either clean up bootargs before bootmeth load stage, or
> add
> > kconfig to check and enable this logic, a better representation.
> >
> > (2) One more thing, the vendor_boot cmdline is not handle neither in
> > original logic nor in url from you provided. So I can say the url one i=
s
> > not capable for extended with Android boot img version > 2 since
> > vendor_boot cmdline not handled.
>
> What do you mean by the vendor_boot cmdline is not handled?
>

Yes I mean it. If origin/master logic (for fastboot, my test case) had gone
through android_image_get_kernel then this patch is not necessary.


> When parsing the vendor_boot image, we go through
> android_vendor_boot_image_v3_v4_parse_hdr()
>
> That function copies the vendor_boot cmdline with:
>
>         data->kcmdline_extra =3D hdr->cmdline;
>

Yes and that it is. Since many routes now through bootm_boot_start() with
single cmdline so obviously vndboot_cmd is yet to finalized unless in
previous stage logic combine boot/vendor cmdline by purpose. So here a
better choice is to extend with 3rd param for vndrboot_cmdline. And let the
new bootm_boot_start_ex() for example to combine/modify.

for example:
Int bootm_boot_start_ex(ulong addr, const char *cmdline, const char
*vendor_cmdline) {
...
ret =3D android_image_modify_bootargs_env(cmdline, vendor_cmdline);
...
}

I did not do this way because it is a bit  clumsy. But in code maintain
point it might be good.


> (to the struct andr_image_data).
>
> Later on, in android_image_get_kernel(), this gets copied to the
> bootargs:
>
>         if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>                 if (*newbootargs) /* If there is something in newbootargs=
,
> a space is needed */
>                         strcat(newbootargs, " ");
>                 strcat(newbootargs, img_data.kcmdline_extra);
>         }
>
>         env_set("bootargs", newbootargs);
>
> >
> > (3) I don't think it is very much different between your mentioned url
> with
> > my patch. There is nothing advanced, but just existing code logic reuse
> and
> > that logic handled vendor_cmdline in other path. I prefer code logic
> reuse.
>
> The difference is that in the patch I've linked is that we only change
> Android specific boot behaviour. So less risk to impact ChromeOS.
>

Yes. As above suggested _ex() function to get around the limitation. Just
leave those old caller to stick with the old bootm_boot_start().


> >
> > And I believe above are not the important thing....
> >
> >>
> >> Changing this would potentially break ChromeOS boot behaviour so I'd
> >> prefer to find another solution.
> >>
> >> I know that TI has a downstream patch that changes bootmeth_android.c
> >> instead:
> >>
> >>
> >>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.04=
-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
> >
> >
> > ...
> >
> >
> >> Would that work for you?
> >>
> >>
> > Well, the one from url also fine with me.
> >
> > The important thing is here. So as to ease the change with "minimal
> impact"
> > gets in. I can add one extra check to maintain original behavior in cas=
e
> > people have concern of breakage. Code example as below:
> >
> > + If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
> > +   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> > + else
> >       ret =3D env_set("bootargs", cmdline);
> >
> > This logic eliminated the concern, but it also limited those potential
> use
> > cases for Android boot header version > 2, unless the newly introduced
> > CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.
>
> I'm not sure about why this is better, as from what I understand we
> handle vendor_boot cmdline properly already.
>

This is my previous patch aimed to do....I moved all bootargs handling from
android_image_get_kernel into a new function and reuse it in
bootm_boot_start. I am glad you have same assumption on how bootargs should
be handled.


> Can you provide me with a test case or some example commands that show
> that vendor_boot cmdline is not handled properly?
>

May be above explain is enough?


> >
> > Or this one with good extendible.
> > + /* Clean up bootargs purposely */
> > + if (IS_ENABLED(SOME_FLAG))
> > +    env_set("bootargs", "");
> > + ret =3D android_image_modify_bootargs_env(cmdline, NULL);
> >
> > Either way. I prefer first one and can blindly apply without afford. I
> > leave the idea above to people more concern with it. Please let me know
> > your decision, I can provide one more revision later.
>
> I'm sorry there is so much back and forth on this series. I hope we can
> come to a common agreement and get something merged.
>

Yes I am struggle with this as well. If there are still some uncertain,
please consider merge patches with review-by and leave theose questioning
patch alone?

Thx again for reviewing.

Regards,
George


> Thanks
> Mattijs
>
> >
> > Regards,
> > George
> >
> >>
>
