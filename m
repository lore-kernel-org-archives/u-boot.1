Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB737E67819
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72EA389066;
	Sun,  3 Nov 2024 00:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="k+fGLxt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423F98908D; Sun,  3 Nov 2024 00:36:54 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046278901D
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cdb889222so29983615ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730590610; x=1731195410;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eZsOgS3JQqaed5kr+hB3ZT+phnJmp8qAl+J1mp5Byw=;
 b=k+fGLxt9iZhaCECwqsAHHE/3v2ZH7GX/RysDzDDhVv7mu2dDlJFxcstZbWrY0Ko+Fk
 mo30HjcP4vaXUXVhK0NoFlgUprkuimHFBmw8MizL7h0G3NUp+40lh7zdG2OQr9YC2gcT
 enuwAuhnarr/es71H0DvLYryeV7RADLsSM6Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730590610; x=1731195410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eZsOgS3JQqaed5kr+hB3ZT+phnJmp8qAl+J1mp5Byw=;
 b=o7rMf6opQJSPKScvtfqR3SUBImu5E2fr+SBIsl8T7LzYz5AkNHp+yaCUPNbNDtmXZG
 bOnZRDRbaRRYPOnrLTzJmnJuqVXqvOBGom515iPkGhAxhP2gAwaqI8Co6+V/BJcRpNJC
 s3BqPBkgBU4B+4aOkXkq6R6bBCGBO1EXthL31/RnFumAuvUjd4AGz1rICPNK3KO+gGah
 j4K0LsVgzbpZiJGRWVjYRrFhCGKHC305bLXBISXGgm4S1LpJVwjU+IemSVHvAhCcCCHg
 JzoCjODRreGa0f2cOW4ZIBKcN/mWojCe2V/sDe/hwSLg2cWKqqvn9xQBZ5ZwOu99pt90
 WnGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOGU09ZSYGSiSk/O6Om6EQ9dnMlfwtikMHOqTQ8t93ZqcWzR/6JpkFAzUAagSZZAkbCIKn3QE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu4hc65rSaOzQOUZi8uHCAK1zEtwbZA6/o44lmQgWosRr9khfr
 W1VgmkVU7T3UuPdU9qTp/QePyXhyxmnACMga71doCjQDXvXTVFoKeRyyoA9/WsYhl3wsAIvucW0
 3aCJTyNiHYgwG/TiQxO6UcygZMcvygeO/q4LMhZJTNmnRFAcDSIs=
X-Google-Smtp-Source: AGHT+IFgb0hQwOQy1Kd2nlvo1CfEugmCwR/JFXYWVnKhgKhVIM/iwwVI5mco3n81AoobZzi+F4RTRLuS9jrgrnmukZg=
X-Received: by 2002:a17:903:1d0:b0:211:a6d:85dd with SMTP id
 d9443c01a7336-2110a6d8aa1mr118439555ad.47.1730590610395; Sat, 02 Nov 2024
 16:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
In-Reply-To: <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Nov 2024 00:36:38 +0100
Message-ID: <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

Hi Tom

On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
>
> > With this series opendir, readdir, closedir are implemented for ext4.
> > These functions are needed for the UEFI sub-system to interact with
> > the ext4 file system.
> >
> > To reduce code growth the functions are reused to implement the ls
> > command for ext4.
> >
> > [...]
>
> Applied to local tree/v2-tidy-test-dir, thanks!
>
Am I sleeping?

int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) {
    struct ext4_dir_stream *dirs =3D NULL;
    struct ext2fs_node *dir =3D NULL;
    int ret;

    *dirsp =3D NULL;

    dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
    if (!dirs)
        return -ENOMEM;

    dirs->dirname =3D strdup(dirname);
    if (!dirs->dirname) {
        free(dirs);
        return -ENOMEM;
    }

    ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
FILETYPE_DIRECTORY);

    if (ret =3D=3D 1) {
        ret =3D 0;
        *dirsp =3D (struct fs_dir_stream *)dirs;
    } else {
        ret =3D -ENOENT;
        free(dirs->dirname);
        free(dirs);
    }

    if (dir)
        ext4fs_free_node(dir, &ext4fs_root->diropen);

    return ret;
}

Should not be like this?

> --
> Tom
>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
