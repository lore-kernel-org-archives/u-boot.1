Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994EAD10BEC
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 08:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A411888DF1;
	Sat, 26 Oct 2024 10:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YQ+ZJEKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9D388DF8; Sat, 26 Oct 2024 10:52:26 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D35588CD9
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 10:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so2687212a91.0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1729932740; x=1730537540;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayQFIAjr1qY4DgTSg4SEf4vYsnK6IwNCAIF22KeML0g=;
 b=YQ+ZJEKpb9RWZ7SsiG0H6RCNFqhGMyHBV4ezqw9FdUZgMD0o0GRBlTqK5PUOf9Ocdr
 rn4FXCJavDaspBmBt4aLAGjx90qqZnHp7JTEUjJEcR4ZyjugtdNCUJ3ACi31Y81gKjB/
 UXwnpc88tZ2837HJQkbEAW01Fmqx7WcBfBiSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729932740; x=1730537540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayQFIAjr1qY4DgTSg4SEf4vYsnK6IwNCAIF22KeML0g=;
 b=DZrgZHSwWpxSByOUjNI96R0mnu9K0FZXDexF4qH+JxhkJZoTTl0aB41VJ28Ru4hs5m
 SixQjkIVnqeOd+GTZ3MMvEuLrQblvqZBSfK8GCVITvrLzHUO+rLl5N/x1I9JVSTEg0cd
 wXA15v31oRfJNOgYMrPtJv6b3aiNIZxSIaHxfwUZKqiawxNUAGcYQPYg6K240fUiZT0e
 He75I9JbIkvFVK5vEniv1ruBBkLk2qJOJiXbSzM1ouh5YtbsFReKUks3hVROQc2XKdoN
 K1zawwGvAuTWJW4rYtKyHCbbAcjo5utLi+Kq7amWN8Kt1d8q35XIZVG+qK/DR3musZzS
 kuIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVulstnVETUgxauNdl+oDv2+tQUTPB98PW27HUK0ZO6x2MjXRrfTyjWqhhBMJ7g7hiaktPMGy0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/ScugzIyVUaUikVuFhWS50dtzIwGDQ3WL2fi/Vf6vCAx7R6Wf
 uJh4CLKxlLLKhQl4ZNOGsXq3Bv9+xW+jDwyrRc2YdlTLlj6UWJJB0XbZ0zq0grAA6uDsjlZJ2bJ
 GXFFNTn/dMrTsJrITigosCwi2V0JTvLZzk9yfSQ==
X-Google-Smtp-Source: AGHT+IHrxAOk51z4bU2UGpoCX6TMV8jEa3+GDpk2Vn09G4Rkzt0qVhTrA/XDLNXy55t9WynMY1oCljrreIleSHbTPRc=
X-Received: by 2002:a17:90a:70c2:b0:2e2:c1d0:68dc with SMTP id
 98e67ed59e1d1-2e77e5e48a7mr12856829a91.9.1729932740407; Sat, 26 Oct 2024
 01:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 26 Oct 2024 10:52:08 +0200
Message-ID: <CAOf5uwnC7G9DjKT86KwQMbb+rkb5YcL8c6cV_jziHoGoDSPn3w@mail.gmail.com>
Subject: Re: [PATCH 1/5] fs: ext4: simplify ext4fs_iterate_dir()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
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

Hi

On Sat, Oct 26, 2024 at 8:41=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Remove copying a pointer with a cast to the very same type.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index 76f7102456e..c1e38978bb9 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2046,24 +2046,23 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, c=
har *name,
>         unsigned int fpos =3D 0;
>         int status;
>         loff_t actread;
> -       struct ext2fs_node *diro =3D (struct ext2fs_node *) dir;
>
>  #ifdef DEBUG
>         if (name !=3D NULL)
>                 printf("Iterate dir %s\n", name);
>  #endif /* of DEBUG */
> -       if (!diro->inode_read) {
> -               status =3D ext4fs_read_inode(diro->data, diro->ino, &diro=
->inode);
> +       if (!dir->inode_read) {
> +               status =3D ext4fs_read_inode(dir->data, dir->ino, &dir->i=
node);
>                 if (status =3D=3D 0)
>                         return 0;
>         }
>         /* Search the file.  */
> -       while (fpos < le32_to_cpu(diro->inode.size)) {
> +       while (fpos < le32_to_cpu(dir->inode.size)) {
>                 struct ext2_dirent dirent;
>
> -               status =3D ext4fs_read_file(diro, fpos,
> -                                          sizeof(struct ext2_dirent),
> -                                          (char *)&dirent, &actread);
> +               status =3D ext4fs_read_file(dir, fpos,
> +                                         sizeof(struct ext2_dirent),
> +                                         (char *)&dirent, &actread);
>                 if (status < 0)
>                         return 0;
>
> @@ -2077,7 +2076,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, cha=
r *name,
>                         struct ext2fs_node *fdiro;
>                         int type =3D FILETYPE_UNKNOWN;
>
> -                       status =3D ext4fs_read_file(diro,
> +                       status =3D ext4fs_read_file(dir,
>                                                   fpos +
>                                                   sizeof(struct ext2_dire=
nt),
>                                                   dirent.namelen, filenam=
e,
> @@ -2089,7 +2088,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, cha=
r *name,
>                         if (!fdiro)
>                                 return 0;
>
> -                       fdiro->data =3D diro->data;
> +                       fdiro->data =3D dir->data;
>                         fdiro->ino =3D le32_to_cpu(dirent.inode);
>
>                         filename[dirent.namelen] =3D '\0';
> @@ -2104,7 +2103,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, cha=
r *name,
>                                 else if (dirent.filetype =3D=3D FILETYPE_=
REG)
>                                         type =3D FILETYPE_REG;
>                         } else {
> -                               status =3D ext4fs_read_inode(diro->data,
> +                               status =3D ext4fs_read_inode(dir->data,
>                                                            le32_to_cpu
>                                                            (dirent.inode)=
,
>                                                            &fdiro->inode)=
;
> @@ -2140,10 +2139,10 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, c=
har *name,
>                                 }
>                         } else {
>                                 if (fdiro->inode_read =3D=3D 0) {
> -                                       status =3D ext4fs_read_inode(diro=
->data,
> -                                                                le32_to_=
cpu(
> -                                                                dirent.i=
node),
> -                                                                &fdiro->=
inode);
> +                                       status =3D ext4fs_read_inode(dir-=
>data,
> +                                                                  le32_t=
o_cpu(
> +                                                                  dirent=
.inode),
> +                                                                  &fdiro=
->inode);
>                                         if (status =3D=3D 0) {
>                                                 free(fdiro);
>                                                 return 0;
> --
> 2.45.2
>
Nit I don't know if this can a const pointer from the function call prospec=
tive

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


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
