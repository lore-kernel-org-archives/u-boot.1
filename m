Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5BBC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 21:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4231987DF1;
	Wed, 20 Mar 2024 22:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PvRbSZK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AB288049; Wed, 20 Mar 2024 22:17:53 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C505D87DF1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 22:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-568c714a9c7so242687a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710969471; x=1711574271;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHDx3boyiOd2yHKufnLrVEL5pbkZ68LKjJlCi/ISpnE=;
 b=PvRbSZK/HBQID7DBNj1VdOfMkXU2eTvruixfbXDd2WEjJ0j3KWv2HoGENDEJEImhk6
 Onbv2EBnOH3wTUDar3lepuwpupK1akXutjzC1R5I//4qSWQzWCgWK80B/gERUPrnjAG1
 tIHhAlO+7F6GRGXpzrfZva4kg2wuYbg3PS3s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710969471; x=1711574271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHDx3boyiOd2yHKufnLrVEL5pbkZ68LKjJlCi/ISpnE=;
 b=VLPYODRHPJ6fYTxSP35L0kiEMeOg+brwtzS5Uu4G2GIJnLgpZYh0E6tEtWKP/tls/h
 vPr7UEZuv2zcvk6t6KbfUQ1wcpX1ZY1gP7uoISBbnxrbF93YAnUoLkvuAy78VOUrpuMt
 L15hyqqELSh+HUmhujm1QV6LoljbohUPJ9XExWqsHKMhLyiJsGT2YNS/Jf8O89Z/D7+Z
 uHRShyUW1nFDUou4wf6A5xDtk1NDl3EMtf7l5EOnOuweh2bb8WBnCpRT0CC/RBxKAl7b
 EL1c2BiuQWMu4ddaZbtnmP5lTxIDfa+H0GiJmb2HJuoD48cpEhmdeDEZ/ip2i5F7xuO5
 7YEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURO03HEBsEXJN3C0ka8n06fVos/wQoYwZvXEbyDFFpb9AGWQKCLux8js32M3Ms23n4Klawa7ECE0gDP49br9ZJERXFtA==
X-Gm-Message-State: AOJu0Yz+6cSHCcRJfvA/QnMnHTnSCV7YwC8IYs0HyYJ/P74MFJfK7e6D
 8Xnvz050eJD5rAXliyiwe1SuPy20fBwT/S7/WAzHOoNZ7HnOKCLgCUs2t0CQkwITbdk1l3qTNW9
 UJe8z6O5yaAlB/xoV1BfzopXcreuWaIDQYCKbqw==
X-Google-Smtp-Source: AGHT+IHFpMb0zCGmfuw12kmzdKvymdjWKmFgNKmpzApSMrEKbPMFbKSlO+7AnzyltaNHT30lX1BVSk9pkl9WS/Tko8U=
X-Received: by 2002:a50:cd9e:0:b0:567:fb9b:37d5 with SMTP id
 p30-20020a50cd9e000000b00567fb9b37d5mr98894edi.32.1710969471154; Wed, 20 Mar
 2024 14:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 20 Mar 2024 22:17:39 +0100
Message-ID: <CAOf5uwnD2mHzTUYh0-d1rZ=p6z8ZAdprcsfTsxG=QMq7G=SfJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: ext4: all file paths are absolute
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <seanga2@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, Mar 20, 2024 at 2:25=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot only knows absolute file paths. It is inconsistent to require that
> saving to an ext4 file system should use a leading '/' wile reading does
> not. Remove the superfluous check.
>

Just a typo, "wile reading"

Michael

> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index ea9b92298ba..9eac6beef3b 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -765,11 +765,6 @@ int ext4fs_get_parent_inode_num(const char *dirname,=
 char *dname, int flags)
>         struct ext2_inode *first_inode =3D NULL;
>         struct ext2_inode temp_inode;
>
> -       if (*dirname !=3D '/') {
> -               printf("Please supply Absolute path\n");
> -               return -1;
> -       }
> -
>         /* TODO: input validation make equivalent to linux */
>         depth_dirname =3D zalloc(strlen(dirname) + 1);
>         if (!depth_dirname)
> --
> 2.43.0
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
