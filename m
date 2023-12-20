Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC48C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A63875C5;
	Wed, 20 Dec 2023 05:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kKyTvIQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9364B87527; Wed, 20 Dec 2023 05:46:42 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4345870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a22f59c6ae6so649986966b.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047600; x=1703652400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vLS9PaU8nIVL2AoH4rLCrYKFdEWvg7cona46iVrsMKI=;
 b=kKyTvIQci23wQwvufVQ6ppokTjCv4Dckn07eOmXSgoTBMQ6WaVb/8X47TzvikbtH0N
 9TNzH+u6hkmXptAhpCmA4Mlkw6TWcvByZaafjNuSYn9AmZo3SiuXxHkMdk7g50jwXKlk
 TqrboyQpczbdGyqnrfJnrt+zDEL7pqO+eS12Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047600; x=1703652400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vLS9PaU8nIVL2AoH4rLCrYKFdEWvg7cona46iVrsMKI=;
 b=E5u0Kr6NtCJQTSMdxkD4VWhxrbaFG6a1TpXH3UePPgb1G+Tem2B8/f9PghTi86qwu7
 eO/5u/zn5Z0HR30fChafSHst2JAHESAvfyJSgvemhDs0tpojyMrg7Eoy6G8f14fVDhSW
 Zcw11Em3YEtX6GJpd5LifmeEccyj6b0wfqkF+rnhfvVSneBG3ih3jlL6BqiQ1F3GSyWb
 kMa8HHzKjmmb7fPblkEV3isWcyixhzfn6HN4kn58ojzdhX+a1nu/0ClKfrr774x2yYvZ
 qsfOSVRG26FnLeM7vvtKYmke1+xMnp5WXEkRfy3xaf9YL33g+7d6mOYDnY5yuC0r8Lj4
 OZPg==
X-Gm-Message-State: AOJu0YwqgxmNQ/s3aElT85r0uUgm3XPx2qhKkqa9BreyiIknHWw//kkH
 pKREmIDcSMPj9iClPHTxd6cp5z4DPuU1AHHACM6O6g==
X-Google-Smtp-Source: AGHT+IFAI+S3ZzFD0judEUb9L4BVLyKQ9nBmPU88qofcc+Wkx3yw142zsf9jSD4CDxYSbTQAVsVcINK+x6zvNtrJ0ek=
X-Received: by 2002:a17:906:55d5:b0:a23:2d69:1533 with SMTP id
 z21-20020a17090655d500b00a232d691533mr1467549ejp.310.1703047600113; Tue, 19
 Dec 2023 20:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
 <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
 <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
In-Reply-To: <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:27 -0700
Message-ID: <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

On Mon, 18 Dec 2023 at 15:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 18. Dezember 2023 16:01:40 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi AKASHI,
> >
> >On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> ><takahiro.akashi@linaro.org> wrote:
> >>
> >> Now it is clear that the feature actually depends on efi interfaces,
> >> not "bootefi" command. efi_set_bootdev() will automatically be nullified
> >> if necessary efi component is disabled.
> >>
> >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> ---
> >>  fs/fs.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/fs.c b/fs/fs.c
> >> index f33b85f92b61..82ee03b160e9 100644
> >> --- a/fs/fs.c
> >> +++ b/fs/fs.c
> >> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
> >>                 return 1;
> >>         }
> >>
> >> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> >> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> >> -                               (argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> >> -                               len_read);
> >> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> >> +                       (argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> >> +                       len_read);
> >
> >As I understand it, this is setting the boot device so that (if it
> >happens to be an efi application) it will know which device it came
> >from. But this is a hack. For bootstd, the device is known as it loads
> >the kernel.
>
> Please, consider what happens when the user interactively executes the load and bootefi command from the console.
>
> >
> >Also it does not deal with memory allocation (nor can it).
> >
> >Where are we using the 'load' command to load a kernel? The distro
> >scripts are deprecated.
>
> Some users use boot.scr scripts
>
>
> >
> >At some point this code should be removed. Is it too early for that?
>
> Yes, as long as we allow users to invoke the bootefi command with an address pointer.

So how about we create the new path, with the info passed in as part
of the bootefi call? Then we can remove the call from bootstd, at
least.

Regards,
Simon
