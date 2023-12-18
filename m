Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CD1C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6DA87E4E;
	Mon, 18 Dec 2023 16:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J/gpxEYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B7087E49; Mon, 18 Dec 2023 16:02:38 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDB787E0A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dbcfb7e8ad0so2364862276.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CPeDCxhWMaRT5JkRJXw8bkg+FzXYwF07j3YAZcZDhbo=;
 b=J/gpxEYfAqIsT0XxZDTvgUNHWjhUk9KKBcQUkDbeWfJHhGQIwg6Wjgiff/Skq3sSOR
 jqZyNk5GpXvsiRaGvEIbGyjrbJNFMDm4bJp5iH9YMjATkftUVV61+19ujnMmDQ//0bCK
 cB44JwHulaZpAyimgfEMZIopy8AkTCC71C01Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CPeDCxhWMaRT5JkRJXw8bkg+FzXYwF07j3YAZcZDhbo=;
 b=kDQcHqM+8xoNhzk/fCUdtHRN64Kd/zQB5E2HrbIvO4V/3lOakKbwp3Xz8ZWbXP+BLU
 NaOkR04feNlz4aFLTYwJ9PT3ZAXD67tqfZgXYKOjCjlVATAGSDvclXTeO7kJtT9Ez161
 O+zq7y4pocy79K5Z/s21+Pci2zC8hQQDkzc4ah2UYCj+3ukw77Sflb7BVuGZ0iu1lXFi
 QhUQlWJgupZFl71MY+7sO48naq916/0wbu5WjtW5p3C3cDgxixXGOFpsGmOeIQ/uusk/
 q3SezWopKDhemzqmc3elVi+9D9kHnNGwC1KCUCNNG9G7xSfaTVLLJldeq1zIL7EckeYz
 2dNA==
X-Gm-Message-State: AOJu0YyxdqGDG/B6NDO7r+IDil1n8aflSgjQEb28wMuj4VnX3LwAYKTu
 qKrEjIiKJiWvUF5MqKRf3CkSZKbNTGkKa8TyVqYMjEj1xzgWCL6BlJk=
X-Google-Smtp-Source: AGHT+IE2CLfvghx9+MVyrF9wqJZaX8X1paT0KlUYAj+rbZJMAVChktiJwu6EUMS/qpohlJcYX7Tx2WDU5XY6GVwZjpw=
X-Received: by 2002:a05:6902:70c:b0:dbc:d6ae:22ec with SMTP id
 k12-20020a056902070c00b00dbcd6ae22ecmr5453451ybt.82.1702911752776; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <acfe7ea1-a25a-4293-9e05-bfe4ed7c2a05@gmx.de>
 <CAPnjgZ1CmmEHxOKPRVbo1zjQ8FDQ1HxdU9ww6c5fJBFc7+Dtjw@mail.gmail.com>
 <6d926cc2-6100-4b1a-8ee1-11a19ac36f35@gmx.de>
In-Reply-To: <6d926cc2-6100-4b1a-8ee1-11a19ac36f35@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:36 -0700
Message-ID: <CAPnjgZ1X50hb63FdSWJVnN1-2OOao38C0qtWVTr5HfmmWF8Smw@mail.gmail.com>
Subject: Re: Booting fails on the sandbox
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sat, 16 Dec 2023 at 14:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/16/23 19:45, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 16 Dec 2023 at 07:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> Hello Simon,
> >>
> >> I have built sandbox_defconfig with PREBOOT='host bind 0 ../sct.img'
> >>
> >> On the image I have an ESP with file EFI/BOOT/BOOTX64.EFI.
> >>
> >> I would expect the sandbox to boot from the ESP.
> >>
> >> But when starting the sandbox is does not boot. Instead it shows a menu
> >> with some Fedora related entry:
> >>
> >> Fedora-Workstation-armhfp-31-1.9 Boot Options.
> >> 1:      Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
> >>
> >> This makes absolutely no sense on an x86_64 system. Could you, please,
> >> fix sandbox_defconfig to boot according to distroboot.
> >
> > What sort of 'fix' are you thinking of? You should be able to discover
> > all the options with 'bootflow scan' and then use 'bootflow select' or
> > 'bootflow menu' to choose which one you want.
> >
> > The Fedora thing is used for testing and development.
>
> I want to autoboot the sandbox without manual intervention. This
> requires a sane state.

Well, stop doing that :-)

Really, sandbox is for development and CI testing. It is not designed
to boot anything automatically.

>
> If that Fedora thingy is only needed in CI, can't we put it into a
> config segment that only used by the CI scripts and have the sandbox in
> a generally usable state? Or can we let the Python tests add the
> otherwise not needed bootflow?

Yes, we could. We have some extra mmc devices which are manually
enabled in tests.

But it is handy to be able to try out a distro without doing anything
special. I suppose we could add a sandbox command to enable an mmc
device in test.dts

If you have ideas / patches that is fine...it's just that I do want to
be able to use sandbox for basic development and trying things out.

Regards,
Simon
