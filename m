Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FD4E92FFA
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 09:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 789AE86D19;
	Fri,  6 Oct 2023 11:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxKIR44C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D51286D3F; Fri,  6 Oct 2023 11:22:49 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A246386CE5
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 11:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so3225142a12.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696584166; x=1697188966; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4NNMWPQHMdNZ/rw6Qpon3AsNGu/loOkzH2fO00qDb4=;
 b=bxKIR44CM1jJas8WJ2w4iWiu3sZgYpAYacT/NVNXg+tvJpOSCtCibEuq7/sUxep8s2
 q6835VBQBsdRKlnqyf9U8+nk2C+UlYnZEHELWosJkSNoro8iV3iLXrvRaDM16r6hm923
 +8bQrqIV+jyvoJeXTWvJ6Nn9F5kp/Nv0wQiVCoT6paZF7z6ruee/WRDA+TbkMughmSmi
 MrrS69V7+oXSFuFR6sLjE8BfxstsPlz21TbXl0IvuythLNxGJwTZbMZz4BJFZR/ZyBXG
 NdddGP2FiAFArfqAnvYp0ws0CQOD+QbJ8f+z+j73ETvoNEFirWkHK9TBKwUSfBLupAFZ
 HHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696584166; x=1697188966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4NNMWPQHMdNZ/rw6Qpon3AsNGu/loOkzH2fO00qDb4=;
 b=ZOVMZDNK8mHVxtOctbLT9ERaswJWXrFsk4EfD9zav+07rxlEhLU2GR05jP8PI4gULC
 nErNodzKS93+SIpraVe52Z6jTOTlPVtWE0TORPA2gF08P7NQeaQPsQmseCLWYLCA8OWr
 +yU30GOJeL+AUjw4xnWTZSgqV0LJLhoaM5kwUoMMXq13t+OM1B3uUc0VV+zhK2HQA5bv
 GB4JiQ6apBEy5u7C/HHjjmWYQ71hJGnFihf0dmdq08Vun/E9aYRuQta4TZvSE4n4dLIr
 IjXBbWie8+PMi62q/R7sZmG8VAbQuqL7+atSSZw8t8ZlPVu7e87QmHVwKBCTU6imcFbn
 0KQA==
X-Gm-Message-State: AOJu0Yxsspa24pQTn3SPc7yNc7sE2JimhpdkMCGfgDxkU4hCKivnDU3s
 xxezN89xBfMMZYwnKqvvUn6Z11cz0FtBqm3gIrU=
X-Google-Smtp-Source: AGHT+IGXHYrJyrX5Q7V1pgnH7p49QmVytAIk/8rIw0EMijPBDOds+UgrFJT3VV1YPKEwFsUQWhUcrA5yxb8Ni41NEE4=
X-Received: by 2002:aa7:dd0e:0:b0:533:1832:f2b4 with SMTP id
 i14-20020aa7dd0e000000b005331832f2b4mr6596000edv.13.1696584165934; Fri, 06
 Oct 2023 02:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
In-Reply-To: <20230727215433.578830-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 6 Oct 2023 10:22:34 +0100
Message-ID: <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Simon,

So with more testing of 2023.10 in Fedora we found a regression where
the display dies when the vc4 module loads in the kernel. With further
debug it was found that it was due to the new U-Boot and with
bisecting it myself I have found this series is the cause of the
regression.

The testing I have done is with recent RPi firmware, U-Boot 2023.10
and kernel 6.5.x, but also seen with 6.4.x, with a minimal text only
image. I can also reproduce it by using the F-38 GA image, no updates
and purely just changing the U-Boot component. I've done my testing on
the RPi4.

Let me know if you need more information, I believe you have a RPi you
can test with.

Regards,
Peter

On Thu, Jul 27, 2023 at 10:54=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> This series moves Raspberry Pi boards over to use standard boot.
>
> It also moves rpi over to use a text-based environment. Unfortunately it
> is not possible to empty the header file due to several CFG options.
>
> Fix the repeated "and and" while we are here.
>
> Note that this reduces rodata size by about 4.5KB. We could get another
>
> for a total image-size saving of about 15KB. This is mostly because
> HUSH_PARSER is not enabled anymore and the environment shrinks down by
> about 3.5K. Hush is not actually needed anymore, since standard boot does
> not use it. Also CMD_SYSBOOT is dropped since standard boot calls the
> pxe_utils code directly in that case.
>
> Changes in v3:
> - Rebase to -master
>
> Changes in v2:
> - Rebase to -next
> - Add new patch to disable DISTRO_DEFAULTS
>
> Simon Glass (3):
>   arm: rpi: Switch to standard boot
>   rpi: Disable DISTRO_DEFAULTS
>   arm: rpi: Switch to a text environment
>
>  board/raspberrypi/rpi/rpi.env  |  77 +++++++++++++++++++
>  configs/rpi_0_w_defconfig      |   2 +-
>  configs/rpi_2_defconfig        |   2 +-
>  configs/rpi_3_32b_defconfig    |   2 +-
>  configs/rpi_3_b_plus_defconfig |   2 +-
>  configs/rpi_3_defconfig        |   2 +-
>  configs/rpi_4_32b_defconfig    |   2 +-
>  configs/rpi_4_defconfig        |   2 +-
>  configs/rpi_arm64_defconfig    |   2 +-
>  configs/rpi_defconfig          |   2 +-
>  include/configs/rpi.h          | 134 ---------------------------------
>  11 files changed, 86 insertions(+), 143 deletions(-)
>  create mode 100644 board/raspberrypi/rpi/rpi.env
>
> --
> 2.41.0.487.g6d72f3e995-goog
>
