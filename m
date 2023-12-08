Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D15EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 01:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D682D8762F;
	Sat,  9 Dec 2023 02:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ics-com.20230601.gappssmtp.com header.i=@ics-com.20230601.gappssmtp.com header.b="VB9WgFss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA8D8755C; Fri,  8 Dec 2023 21:09:35 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6EB874F3
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 21:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lpmeyer@ics.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-59093f6c94aso356694eaf.0
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 12:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ics-com.20230601.gappssmtp.com; s=20230601; t=1702066170; x=1702670970;
 darn=lists.denx.de; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8tE+FcHEZgxHCUUhOky+gwPmYcbRQYX+UnmbEEsVYw=;
 b=VB9WgFss++OOb/S+abKyYW3tJjZ0U9aIGCUW8MXvQqTPDtRh6piXsl2iBrN4tgvH4O
 xVU7namitRzFEJOnKpIJFmOmDEyhknZITqKHR3eIgCotOsJeLv1cp3Tb9q//tAEXTtkz
 b0WEKn8+5J68fJy3q5bNWT4wnyBSEHKhK8c/0doKKZHy6/t2zsq+hL3UPq5QqzNfVMZU
 qRHGAlB1/Pirwv9qkCF7CxqX3ieIKh5nfGKHYvHtfbeCxhkV35Plfetv+IJniT9Vt9wI
 vIu/ahNebLE/6j1lxGe4kzLbaY+P51GLsTVx/VNr521g/Shb0DXHr7oY+aahmddGUGWG
 6kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702066170; x=1702670970;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8tE+FcHEZgxHCUUhOky+gwPmYcbRQYX+UnmbEEsVYw=;
 b=i98GnBox0QYq6qwe4h//fGyh4wXVbM2ucbTQBX3zTn+hwqJJrRmoMb7n/UR9OrNDvI
 YNGNB2hBmhCP4/QAMUK5Dv/2O4F1KDj2eLYYIGKTb+PIUucHq5PqAseU4hjpIFWmRCGU
 l7w8Z+WmAfkLQbwZDYpSZlfXKde1liXFHOQmKrdJ6HeKLhMK+GqOR3rEdRE985GOWGIT
 06C34Bl4dj61R9sVvKQkFLcgjCBgsv4ooNGKFVQ0E0SJmhSomOsgrqgj74aUa831eGmA
 rHWyuiSllvRf5yUDO2HWwpmD55aQp/2F0jHIq5lLpvrLpb5hEHjnfImTUn84CpV48w5q
 z+Tg==
X-Gm-Message-State: AOJu0Yzo98IwqYt0DuGv+mRTgdKN1pPKRd5VOiidu4BvhuzTkUQlNRlt
 waEsiVgMLs6tVDtV79lUCzKjTDGhMYKj1uFyvmiWBIwec2Ihjy0LZCs=
X-Google-Smtp-Source: AGHT+IEl+m1GZtOd5d+5Trqag6LfFN80y+GITzrVzXYSAXunoqpHlRfLj/YY6T5H+hCiHjaoB3jzgofEE4FZmSdnGcc=
X-Received: by 2002:a4a:e6d8:0:b0:58e:28cb:43f with SMTP id
 v24-20020a4ae6d8000000b0058e28cb043fmr728819oot.6.1702066169930; Fri, 08 Dec
 2023 12:09:29 -0800 (PST)
MIME-Version: 1.0
References: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
 <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
 <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
In-Reply-To: <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
From: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Date: Fri, 8 Dec 2023 17:09:14 -0300
Message-ID: <CABqjNW_2o4qfbStxA3A_e4YHMzo80ki1QZSwXn0YxeLDjS0ZCQ@mail.gmail.com>
Subject: Re: iMX6, CONFIG_IMX_HAB and fuse_read()
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 Dec 2023 02:14:53 +0100
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

Don't forget to CC me ;-)

On Fri, Dec 8, 2023 at 4:54=E2=80=AFPM Lisandro P=C3=A9rez Meyer <lpmeyer@i=
cs.com> wrote:
[snip]
> > On the mx7dsabresd_defconfig, for example, both CONFIG_IMX_HAB=3Dy and
> > CONFIG_CMD_FUSE=3Dy are selected
> > and this target builds fine.
>
> Sure thing!
>
> For the sake of completeness:
>
> gcc: gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz as per
> https://developer-archives.toradex.com/knowledge-base/build-u-boot-and-li=
nux-kernel-from-source-code#tab-4-imx-6
>
> ```
> $ export ARCH=3Darm
> $ export DTC_FLAGS=3D"-@"
> $ export PATH=3D~/gcc-linaro/bin/:$PATH
> $ export CROSS_COMPILE=3Darm-none-linux-gnueabihf-
> ```
>
> I added IMX_HAB:
>
> ```
> $ echo "CONFIG_IMX_HAB=3Dy" >> configs/apalis_imx6_defconfig
> ```
>
> And built:
>
> ```
> $ make apalis_imx6_defconfig
> $ make -j16
> [...]
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-imx/hab.o: in function
> `imx_hab_is_enabled':
> /tmp/tmp.iSzdlFQa34/u-boot/arch/arm/mach-imx/hab.c:879: undefined
> reference to `fuse_read'
> make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> ```
>
> Same error :-/

Forgot to mention: I used master's current HEAD, commit
2f0282922b2c458eea7f85c500a948a587437b63


--=20
Lisandro P=C3=A9rez Meyer
Embedded Platform Engineer
