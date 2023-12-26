Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF141C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC4B878D1;
	Tue, 26 Dec 2023 10:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dn4eZDi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FF9878F2; Tue, 26 Dec 2023 10:47:31 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB47878DF
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2043e721daaso2590155fac.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584048; x=1704188848; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Av/p6/G0xj0+gBxddHv6XW1N32jKEKR2yPC7E5gz0QI=;
 b=dn4eZDi8moVw321oETIs5HRmOZL97/AnkYUyLdSdOIgVKhey8oHLBSf2ZTBw3kylzX
 7qV6gfaSNfo3XBQ5rTTTDGeE9rI07atgddmEPfdOVbQWtTEHgMH8YmqWOvE8vrdHB5BE
 03PU8bGLf40B4/GH56Lcw9xXLEqlC9RhQ7400=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584048; x=1704188848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Av/p6/G0xj0+gBxddHv6XW1N32jKEKR2yPC7E5gz0QI=;
 b=cWW9uZLCQSxRR2B9LYjkyCB0eDu89vYcZjAcyZK7lRBrJhsEkdiz3QSk0WHSEpGQIZ
 sC/AFDNWbV5dvu3R6gYwhNE6R5PJEHVWqGDBuTOLcyfljtMTKdwQe4UkrNj/50e/sR1B
 o0wD2ddiV6ovYbkvIbLhqaCFd2FyNz+8vrXtpyQuVLN12w/ivZ6qn0ZyW9sqRWpgZDvb
 wl9o/+0NcjAUIzwH32INmBNclY3ikQ1kMEXl0AAn+PDO8RJu50MkVzHaNeSR7v8t4Ejm
 s7U0wvtF/7/DzRYStLyUgj8zs2VVQqe4a+mpYrroXhCUkbZBg4E+3oaICcKje87UeO9M
 Y8TQ==
X-Gm-Message-State: AOJu0Yye8k1uYgHN3X/RahypOJ/4YvIdK5M2D+12eCPZOGyDlinPSW6x
 BL0VNU54CVftDnr3d8hGkyvUVcpeIlnz6cNLjjq8VnGlbxNR
X-Google-Smtp-Source: AGHT+IF7w4G0NRkSF+F4lNCYFB58J9qH/iI1YOedCNDOzspOjl8Gtut5HqfBvsMQxrQnh7ZHBFitP0ft81U7DHH/boc=
X-Received: by 2002:a05:6870:a110:b0:1fb:75a:6d4a with SMTP id
 m16-20020a056870a11000b001fb075a6d4amr8131246oae.113.1703584047838; Tue, 26
 Dec 2023 01:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
 <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
 <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
 <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
 <20231220132503.GK2513409@bill-the-cat>
In-Reply-To: <20231220132503.GK2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:52 +0000
Message-ID: <CAFLszTicmvmK9zVuvNF3v2twgEMzxrdPRuaxDJaXnTEqMR5exA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

Hi,

On Wed, Dec 20, 2023 at 1:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Dec 19, 2023 at 09:46:27PM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 18 Dec 2023 at 15:16, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >
> > >
> > >
> > > Am 18. Dezember 2023 16:01:40 MEZ schrieb Simon Glass <sjg@chromium.o=
rg>:
> > > >Hi AKASHI,
> > > >
> > > >On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> > > ><takahiro.akashi@linaro.org> wrote:
> > > >>
> > > >> Now it is clear that the feature actually depends on efi interface=
s,
> > > >> not "bootefi" command. efi_set_bootdev() will automatically be nul=
lified
> > > >> if necessary efi component is disabled.
> > > >>
> > > >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > >> ---
> > > >>  fs/fs.c | 7 +++----
> > > >>  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/fs/fs.c b/fs/fs.c
> > > >> index f33b85f92b61..82ee03b160e9 100644
> > > >> --- a/fs/fs.c
> > > >> +++ b/fs/fs.c
> > > >> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, =
int argc, char *const argv[],
> > > >>                 return 1;
> > > >>         }
> > > >>
> > > >> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> > > >> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : ""=
,
> > > >> -                               (argc > 4) ? argv[4] : "", map_sys=
mem(addr, 0),
> > > >> -                               len_read);
> > > >> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > > >> +                       (argc > 4) ? argv[4] : "", map_sysmem(addr=
, 0),
> > > >> +                       len_read);
> > > >
> > > >As I understand it, this is setting the boot device so that (if it
> > > >happens to be an efi application) it will know which device it came
> > > >from. But this is a hack. For bootstd, the device is known as it loa=
ds
> > > >the kernel.
> > >
> > > Please, consider what happens when the user interactively executes th=
e load and bootefi command from the console.

Yes, that case needs to be handled.

> > >
> > > >
> > > >Also it does not deal with memory allocation (nor can it).
> > > >
> > > >Where are we using the 'load' command to load a kernel? The distro
> > > >scripts are deprecated.
> > >
> > > Some users use boot.scr scripts

We will need to figure out that. But we should make bootstd do the right th=
ing.

> > >
> > >
> > > >
> > > >At some point this code should be removed. Is it too early for that?
> > >
> > > Yes, as long as we allow users to invoke the bootefi command with an =
address pointer.
> >
> > So how about we create the new path, with the info passed in as part
> > of the bootefi call? Then we can remove the call from bootstd, at
> > least.
>
> Why? It's not clear to me we'd have this information available at that
> point unless we stored things to pass along at that point too.

For the bootstd case, we know the device where the kernel came from.
See distro_efi_boot() for this code. It calls efiload_read_file()
which calls set_efi_bootdev().

We should instead pass the device information to efi_binary_run().

With that done, we can perhaps make the 'load' and 'tftp' commands
record the device information somewhere, so that bootm can pick it up
when it starts and put it in 'images'. Then at some point we can clean
up the 'devnr' parameter, which should really be a partition number,
since the 'dev' parameter tells you the device.

Anyway, this series is fine, so long as we can agree to the above.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
