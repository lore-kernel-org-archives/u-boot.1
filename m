Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8829C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 19:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144EF84C86;
	Mon, 13 Jul 2026 21:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aHkIXlAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A44684C0F; Mon, 13 Jul 2026 16:18:37 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9444584B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so643778a91.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952313; cv=none;
 d=google.com; s=arc-20260327;
 b=V46UrR3KlIcTCc6w11q4aPWCPhb6LczvGHUm1B92LvdITg4tqFF1RD/eXkD6jBIy+b
 8ittdT1SIOVXWUroDdoNWSRmAMYXhuvTtfr2gKlKJdG6rrKEenlIWzpLO/msPwCU4QTn
 s/00gegT78RLkdk0Tf1hZNcY5JxhaQR8DRK1GYfrNoUuJkoLqd2hM+xFSKEL2gLzhaC5
 mBrqk2MO147+UHM7lymAJNqPOdR71LqXLM101cwoe6yhIk9S5JjXDX7VKu08oRVDcdzZ
 4d6Ygq83eATKn4hq88YSnNlB5Cnl9FHyX2cezxEA1SHXmnHxOSf85hjAo7lq69oxLJgG
 DK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FRFoKuFTK83AQdgfpydTX1QrqRHDw8OGwwjsFxBXOJA=;
 fh=kCc17K58xO4O+yx/fTM8mpTkxC8iofy3bqAtC7rxpM8=;
 b=YaAGFH/u08+g7bvkdk1UirXiOo4eXRXGRaicUt/bs5DDVlTOzsvHiyQI7X8OKjfUWf
 rA4Rp/NGN+GX0UasBc8R18Go7UvvNXEt+A1gkNocunT5RDwAezNvAyV4wzTbNDUJBuH7
 c3mxyACijUL+U65Wc6Mg1VzEKOW9vgrsRHFl1PIfxsXb2xCVAR2XABi0guG3iqq6ZHNI
 v23gDlIGmDCxSKybwS0tOMdE9QvcZcDgVn8VYi4QPqS0dzPKtVhzku2A/l10DOsDlcCB
 ZA3ZR0nWoLSV5ilrCSLk+R/vQCCw1HyxkJ31KOtXTPGN0NstPXODmPyUplcJG2MdVNLH
 14qg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952313; x=1784557113; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FRFoKuFTK83AQdgfpydTX1QrqRHDw8OGwwjsFxBXOJA=;
 b=aHkIXlAQPXteakvQg6bsOt11YuS58xSfEXeBqBw+uuyao0NQHmkRFtnf6TivylM3NU
 pxKV4Wnw2U3JTkrhwkEeqm+Hb3ByhnWdTxl91U/wSnWDtdKheKFGs4K2B6TGxAMGvfeR
 1fnp9SWe1T3QgX5nPW6Jspmfa8ecDGb388l4FEsqnDuxcExgNRKnVvTNTf3nukQWVt40
 cU2/VanwI9zM+lsGBQkZ72S3IT8JaRUMpkIqWEE3yNyClcUo+5LM/fdPXciiFJkCYFR4
 RZWvcdpXri4vzavj2f1fWLTPaMT3Op+vgToxhcUikza2umkdd1Stx+8bV522awpl0o2i
 dtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952313; x=1784557113;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FRFoKuFTK83AQdgfpydTX1QrqRHDw8OGwwjsFxBXOJA=;
 b=f1gYBGqDnCbaKvz9nut99kl3srZRmqyljhKjprZB6SqtDxbGZf5FS05GAcMgOE19HQ
 H8v1abIKgwclVpyqy2cje9XG1dFJlhxM0CNmkVxUV6i235BG576Bm6WVJOzcDBs3rDKw
 ulwktVB2ALt3Huj7hZkCOMWdEAfEeLsVTYCe5tt7PvTft/3VlRTDKBiQoyIS6n1+1uPo
 LjnFls+p2R+w3Bk7wzlia9OQzBrQxbwQZ7pqMPp15DjkqH2Gn/5qo6iVoD7p4uYfGKHW
 XxHxZsUueYj7Vuo1zNAfgvv6erRGtoH0Di3Cew8IWcYYUmm2O+ZLtYliV65L++dVqngV
 EoIg==
X-Gm-Message-State: AOJu0YwTzkcYsKaSpDGnZP+RGRMVbDJB09UO890QRfgVoKvnPKilUrD3
 l+0dV8T4HgVruCI7qnLJGNeA2L8WpXqfwW4PKFMCm6tvCBYPZdeU9zDDsGehdl86oaYYtV9WCOJ
 CQFJqmEWgfUavlovi9pc/1ORjVOlgh8A=
X-Gm-Gg: AfdE7ckWBvgUlQK89GGNHZr7dHZNAKAAwi2KSrvmxgC+h0vVpjQH80MXs13mVwgLtI2
 6zfYIDMhYNVbNewq5H5DmLhGSkK4sSQVbfk3F/KwwwGJv0XXFsr4yUKMEqAYQRWiju2/eY8RS7P
 7d6Yl1Kk1dOirvVrI609iSbxzaVRp3gmcadkGYCJGoJhRUX2dfQbLFtSU3IHnKC7LjtkNIG3wyB
 2IGb6IoTsx/KQelca/rVlg8PuocBh3SQCdB/wZpyYakAhRPYjAohDxu9hAQYlM9pR5QN2Wx6rA9
 41WhI4+izkystImwneoqWqywN6GuolWcAMMTqX6hbxFqZ/+afPyPf+NNxi1NU4/sDm6ICmdiYdh
 TIUJGtERvBd0h4RxO2EOY0WKF64Klr2/nqsw=
X-Received: by 2002:a17:90b:5585:b0:37f:ad5c:d18 with SMTP id
 98e67ed59e1d1-38dc75ed90dmr8764596a91.11.1783952312758; Mon, 13 Jul 2026
 07:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094353.722555-1-allan.elkaim@gmail.com>
 <20260611094353.722555-4-allan.elkaim@gmail.com>
 <1bfb8b3a-5204-47ef-9aa7-fc5748248453@bootlin.com>
In-Reply-To: <1bfb8b3a-5204-47ef-9aa7-fc5748248453@bootlin.com>
From: Allan Elkaim <allan.elkaim@gmail.com>
Date: Mon, 13 Jul 2026 16:18:16 +0200
X-Gm-Features: AVVi8Ce0l3HvSPIzyWb29tZdVtVyhOpcXqx3MerwyvHIg9v3q6PRaGAguVHYhxc
Message-ID: <CACgNL-FkyDzLxMwMeheUVyW95KtLfb4O1EVRZFNUy_FcUjRQQg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs/squashfs: fix dirs->entry leak on inode lookup
 failure
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailman-Approved-At: Mon, 13 Jul 2026 21:59:35 +0200
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

Hi Richard,

Le 24/06/2026 =C3=A0 17:23, Richard GENOUD a =C3=A9crit :

> Having a 2nd look at the whole function, it seems that there a lot of:
> ret =3D -Exxx;
> goto out;
> without freeing dirs->entry

You're right, my v2 only fixed one of them. Going through the function
again, the entry is also leaked on the -ELOOP path, on all seven
allocation/tokenization failures in the symlink resolution block, and
in a more subtle case: when sqfs_readdir_nest() aborts via its
sqfs_find_inode() failure path *after* sqfs_read_entry() succeeded,
the while loop exits with a live entry that the "Cannot find
directory" path then leaks.

> It seems to me that we could keep free(dirs->entry):
> - in the while (!sqfs_readdir_nest(dirsp, &dent)) loop
> - at the end of the for (j =3D 0; j < token_count; j++) loop
> - and before the recursive call to sqfs_search_dir()
>
> And remove all the rest to add something like:
> [...]
> out:
> +       if (ret < 0) {
> +               free(dirs->entry);
> +               dirs->entry =3D NULL;
> +       }
>
> (not tested)
>
> What do you think?

I agree, this is better than fixing each site individually. I checked
that it holds on every path:

- On success (ret =3D=3D 0), dirs->entry is provably already NULL: it is
  freed at the end of each token iteration and before recursing into
  a symlink target, and the root-directory early return never
  allocates it. So the conditional free at out: can never take away
  an entry a caller would use (sqfs_opendir_nest() doesn't read it
  after return anyway).

- No double free is possible: every free site resets the pointer to
  NULL, including the recursive case, where the child's out: label
  runs before the parent's.

- The three frees you list are exactly the ones that must stay: the
  first two run on success paths that the "ret < 0" guard at out:
  would skip, and the one before the recursive call is needed because
  the child's sqfs_read_entry() overwrites the pointer without
  freeing it.

- SQFS_EMPTY_DIR is -1, so the empty-directory path is covered by the
  "ret < 0" test like the current explicit free.

I've reworked patch 3 accordingly for v3 (with your Suggested-by),
dropping the now-redundant frees on the individual error paths,
including the two added by patch 2. Tested on sandbox with the
squashfs test suite ("test.py -k sqfs") plus a manual sqfsload
through a symlink on the image that originally triggered the bug
report, and the error paths (missing file, bad directory).

v3 also moves the collected tags before my Signed-off-by, per your
remark on patch 2. Thanks for the review!

Regards,
Allan


Le mer. 24 juin 2026 =C3=A0 17:24, Richard GENOUD <richard.genoud@bootlin.c=
om> a
=C3=A9crit :

> Le 11/06/2026 =C3=A0 11:43, Allan ELKAIM a =C3=A9crit :
> > In sqfs_search_dir(), when sqfs_find_inode() fails to locate the inode
> > of a directory entry just returned by sqfs_readdir_nest(), the function
> > returns directly while dirs->entry still holds the entry allocation,
> > leaking it. The bare return also bypasses the regular error path.
> >
> > Free the entry and leave through the out label instead, consistent
> > with the other error paths in this function.
> >
> > Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
> > ---
> >
> > Changes in v2:
> > - New patch, fixing a pre-existing leak of the same kind as the ones
> >    addressed in patch 2 (suggested by Richard Genoud's review)
> >
> >   fs/squashfs/sqfs.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> > index af32d008..df988774 100644
> > --- a/fs/squashfs/sqfs.c
> > +++ b/fs/squashfs/sqfs.c
> > @@ -547,8 +547,12 @@ static int sqfs_search_dir(struct
> squashfs_dir_stream *dirs, char **token_list,
> >               /* Get reference to inode in the inode table */
> >               table =3D sqfs_find_inode(dirs->inode_table,
> new_inode_number,
> >                                       sblk->inodes, sblk->block_size);
> > -             if (!table)
> > -                     return -EINVAL;
> > +             if (!table) {
> > +                     free(dirs->entry);
> > +                     dirs->entry =3D NULL;
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> >               dir =3D (struct squashfs_dir_inode *)table;
> >
> >               /* Check for symbolic link and inode type sanity */
>
> Having a 2nd look at the whole function, it seems that there a lot of:
> ret =3D -Exxx;
> goto out;
> without freeing dirs->entry
>
> Like here:
>                         [...]
>                         if (++symlinknest =3D=3D MAX_SYMLINK_NEST) {
>                                 ret =3D -ELOOP;
>                                 goto out;
>                         }
>
>                         sym =3D (struct squashfs_symlink_inode *)table;
>                         /* Get first j + 1 tokens */
>                         path =3D sqfs_concat_tokens(token_list, j + 1);
>                         if (!path) {
>                                 ret =3D -ENOMEM;
>                                 goto out;
>                         }
>                         /* Resolve for these tokens */
>                         target =3D sqfs_resolve_symlink(sym, path);
>                         if (!target) {
>                                 ret =3D -ENOMEM;
>                                 goto out;
>                         }
>                         [...]
>
> It seems to me that we could keep free(dirs->entry):
> - in the while (!sqfs_readdir_nest(dirsp, &dent)) loop
> - at the end of the for (j =3D 0; j < token_count; j++) loop
> - and before the recursive call to sqfs_search_dir()
>
> And remove all the rest to add something like:
> @@ -677,6 +677,10 @@ static int sqfs_search_dir(struct squashfs_dir_strea=
m
> *dirs, char **token_list,
>                  memcpy(&dirs->i_ldir, ldir, sizeof(*ldir));
>
>   out:
> +       if (ret < 0) {
> +               free(dirs->entry);
> +               dirs->entry =3D NULL;
> +       }
>          free(res);
>          free(rem);
>          free(path);
>
> (not tested)
>
> What do you think?
>
>
> Regards,
> Richard
>
