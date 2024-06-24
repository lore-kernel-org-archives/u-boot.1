Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19AFC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 22:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DED9882B7;
	Tue, 25 Jun 2024 00:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kY21GJ/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D9B8836D; Tue, 25 Jun 2024 00:22:15 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A598824C
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 00:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d2472450d6so2593456b6e.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719267732; x=1719872532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+CTAbgHFmj7cZfcsIZaPKGe9XUB2CF2LNM9fMOso4Nk=;
 b=kY21GJ/MqW5bN5sIeEtkvjp570BmbJ+0AuI0ozQEGNeV3DBrMP8guTu2fNm52roLd7
 clbZTpXZ+ZiNpS1s681vOrW0eOVgbjMSZeZfOfvuvr6hLXwrPh99cPro5C+i2eDiya61
 2sBhIul4fB88qxQUe7x08nZL9LsXT5detC1/lDrsP4nxa9zeYzDhiK8iyXt9kJ3p8LG3
 HBYCNJ7x7UPHRm74nP2TiEbfZGYFkq3at1TPiOdmeMYrnVp2Fp2LTpVXVRr5cx/tSlfk
 TjIk+5ZsbALNx+ixqXhUUgGKhwTyHrSjFcdZxvSi3DTekltGFOLad7gbtClVfPRdr8jM
 OZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719267732; x=1719872532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+CTAbgHFmj7cZfcsIZaPKGe9XUB2CF2LNM9fMOso4Nk=;
 b=Lhox0kgnn638Jzg3vafWxpBbpnZ6NdghS3SdxJmGYezvQxMykmiMDovbnyPUky4vm0
 s60cjIJEkcq02YC7lc3phiAKTQDayibuT2oRfM0ZqlazSTARG8oj+DU+N4K7CorT0XyF
 ueOVbNgxOjFGo6iSO9D5kkNmbAH6+asw3uqZ/IgOAhF4a9kYvbagFXP7nNQpwYGgqpkr
 dK7mV8255n8Mpz/3maaktJWah9UgER62mCBVuDGwfdsXiVwiHrDDiwQ/IdMaXAx0EDqU
 CrSsvEzXNTE9D2dBHn3XYCMMMZAeyIQE6VHAUU0nKmQDJbsvyZxvjaSfWELXGpIpJesl
 /vWA==
X-Gm-Message-State: AOJu0YzIW+K20MSr4b38I8h26vEfwyl7j11hxTTN4nnLtwjaij6BzqQh
 RunGPjDa5nr0fzco3x34IKcW/Wv3JusY2CAZoprCHlEMjUOx/hmgmoN5mo3NAKoKOw5Bc5oV2Ki
 jRjwWSyi9xQLtkG0lSFIwoc0tMR18gqgheK0=
X-Google-Smtp-Source: AGHT+IFNO5zWnZSoIPvbNSpA8xPG114eUScJDtv2yl30nLONi28EGFxTQcUfIsMS05/BGW07ZJFn8zsQVFDv1jse3qU=
X-Received: by 2002:a05:6871:b07:b0:25c:c5da:a7a8 with SMTP id
 586e51a60fabf-25d06cc05c6mr5745736fac.33.1719267732109; Mon, 24 Jun 2024
 15:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240618214138.3212175-1-alexthreed@gmail.com>
In-Reply-To: <20240618214138.3212175-1-alexthreed@gmail.com>
From: Alex ThreeD <alexthreed@gmail.com>
Date: Tue, 25 Jun 2024 01:22:01 +0300
Message-ID: <CAF4oh-NEUG4rVqiUg_wFVaRF+_dFCXQNbrTPNA90Y2iGqksh2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: btrfs: fix out of bounds write
To: u-boot@lists.denx.de
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
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

Hi all,

Is there something on my side needed to push this forward?

On Wed, Jun 19, 2024 at 12:41=E2=80=AFAM Alex Shumsky <alexthreed@gmail.com=
> wrote:

> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usuall=
y
> read files into huge static memory areas.
>
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: e342718 ("fs: btrfs: Implement btrfs_file_read()")
> ---
>
> Changes in v2:
> - fix error path handling
> - add Fixes tag
> - use min3
>
>  fs/btrfs/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..3998ffc2c8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,11 @@ static int read_and_truncate_page(struct btrfs_path
> *path,
>         extent_type =3D btrfs_file_extent_type(leaf, fi);
>         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>                 ret =3D btrfs_read_extent_inline(path, fi, buf);
> -               memcpy(dest, buf + page_off, min(page_len, ret));
> +               if (ret < 0) {
> +                       free(buf);
> +                       return ret;
> +               }
> +               memcpy(dest, buf + page_off, min3(page_len, ret, len));
>                 free(buf);
>                 return len;
>         }
> @@ -652,7 +656,7 @@ static int read_and_truncate_page(struct btrfs_path
> *path,
>                 free(buf);
>                 return ret;
>         }
> -       memcpy(dest, buf + page_off, page_len);
> +       memcpy(dest, buf + page_off, min(page_len, len));
>         free(buf);
>         return len;
>  }
> --
> 2.34.1
>
>
