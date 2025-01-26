Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFA5C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 05:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F295B80F85;
	Sun, 26 Jan 2025 06:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y4+3pufh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5DA807E4; Sun, 26 Jan 2025 05:40:10 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA71807E4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 05:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso706812166b.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737866407; x=1738471207; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Bdx/SrLQ4FTD9e5tqo1MSb/bfWikMgnd0DEAAgVCKo=;
 b=Y4+3pufhpFFiF8NTL1lPqHfL5Lljs91qiS3OdsqowqU7ztRLGPiVv05DQ3LRnr4ABc
 mBhWr6IMtPraobdrwhXZ/67gEHcNQMjgOkF/Ug7KitePD/L66Zy/4FEPOFxdb9Subqcr
 KL63a7jF484MN4orsDLQWdRWUcR+YF17lI8JI2mhB9DRN4qPuhpo3rGmtzl/nTQX67ku
 ak4mJkK7vnUYz06g3F1F1kd9n1ddJq4gYOb4JTnEfOtzf7XEzTSzAsAThv5WaR501Pv6
 NvHkrtyimvi30ar55oa+ihw3FhrTlAlwOyAazU5Y5LnxC9F5qNDvthR79ToWWUm35gIk
 +5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737866407; x=1738471207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Bdx/SrLQ4FTD9e5tqo1MSb/bfWikMgnd0DEAAgVCKo=;
 b=A8JO3lkcKNcKnUi9Ms7pG3+dxRIHJCLYGW6X2EmiUJdcsxr1naamT37p4JkyiRNt/c
 JpmgK8cV1onJf+C1mRQ1R3yPmWsWMUUDAzf/NDOlufDe6Up/5ie0MEdCQJ6yqqhm/1Tn
 NnsSdwLKyKXaGai97fwkajWTUj800gDOXDnzUotCr5x+SFT+NFtEYj+wmS1w9qZ2XzSf
 lVN8KxMV/HxwHdbEzsgF2Ij3VZAn6/BdpX8i9nchpCka7p5qjQqugkzZlxXs7RpCOetg
 3VJ+PGuDO5XNOOjIUD5F/izoNJOtGiIxFr64kOSwBO0ZOVygK8CQWPPLw5gTA3EdTcNf
 HcPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOU8feciWdWiaP5q1+igLbdmnB7nmy6fAAaMLQ6RTkhqxhOPRSHc/xy0S4jjmUqvlz2u8YdI4=@lists.denx.de
X-Gm-Message-State: AOJu0YyEM0hzDN44pXowpBg1gxanIZ+8zr+DpY9Ja4gtAR2/jSu2Chij
 6PLHVADYuE2Y5KgiyZHGrBQqNIF/08IC3DAreacNrx+34Tjltv+rftktSUgnFKD0haWX6TUcpWq
 tD+6zRYGSRwSeHgoROi2yq2g4EHk=
X-Gm-Gg: ASbGncus5FXFoUD9rsg0ZFSdUZHpNtGNKX56bfoHqTTyYoBT4kopt/s/B9nrh30hk3C
 5CHlabHU9iLYK73TOdud6/SCAFbyb9dfRWdFFJOdNcECcAsgZ7UnxYo2d8oSbPw==
X-Google-Smtp-Source: AGHT+IH1omdJn1C3fjTUt2qTSo+nfcoftxkZ1eqv54v8yLyBfntKfh5fezLhjVeiFi7Hc7NML34M1keO6wu3IIKnx9U=
X-Received: by 2002:a17:907:706:b0:ab3:2b9a:4a5a with SMTP id
 a640c23a62f3a-ab38b3c6a1emr3875243766b.51.1737866406610; Sat, 25 Jan 2025
 20:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-5-gabriel.dalimonte@gmail.com>
 <14244381-2773-4265-82db-972f6ca684b8@gmx.de>
In-Reply-To: <14244381-2773-4265-82db-972f6ca684b8@gmx.de>
From: "Gabriel D'Alimonte" <gabriel.dalimonte@gmail.com>
Date: Sat, 25 Jan 2025 23:39:56 -0500
X-Gm-Features: AWEUYZk5j_wdGMFebvxdG5xmFVdXEJ0FR-Wa6rIRPXnFTfiybWSLTFY6ufeM5D4
Message-ID: <CAHc-7YusdbQj5YV1qPObAG7tZk3TNvttYfD8Xy2UafuZ5PLzsQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] fs: fat: update parent dirs metadata on rename
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 26 Jan 2025 06:15:16 +0100
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

On Wed, Jan 22, 2025 at 4:00=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 22.01.25 06:32, Gabriel Dalimonte wrote:
> > None of the existing fat code appears to update parent dir properties
> > however, the POSIX specification for rename() mentions that the
> > last modified timestamp should be updated. In addition, I believe
> > the ATTR_ARCH attribute should also be reset on the parent directories
> > as the content of those directories has changed.
>
> Could you, please, provide a link to the referenced specification.
>
> E.g. https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.ht=
ml
>
> Here I find:
> "Upon successful completion, rename() shall mark for update the last
> data modification and last file status change timestamps of the parent
> directory of each file."

That was the line I was referring to in the message. My apologies for
not including a direct link in the commit message.

>
> Does this mean that if we move a directory we would have to update the
> fields of all moved non-empty sub-directories?

I interpreted that to mean only the immediate parent directories of
`old_path` and `new_path` are to be updated. With the rationale for
updating the timestamp and archive attribute on the moved file coming
from the application usage section stating:
"Some implementations mark for update the last file status change
timestamp of renamed files and some do not."

>
> On many boards we don't have a real time clock. Should we skip updating
> if we have no RTC?

That is a good question. I think skipping timestamp updates in the
absence of an RTC makes sense rather than having a timestamp jump
backwards by (likely) several years.

Thanks,

Gabriel

>
> If we want to update parent directories, we should do this for file
> creation, too. The update function could be called in the function where
> we create directory entries.
>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> > ---
> >
> >   fs/fat/fat_write.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> >
> > diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> > index f9f7051e30..2559e38d5b 100644
> > --- a/fs/fat/fat_write.c
> > +++ b/fs/fat/fat_write.c
> > @@ -1912,6 +1912,42 @@ exit:
> >       return ret;
> >   }
> >
> > +/**
> > + * update_parent_dir_props - updates the modified time and resets the =
archive
> > + * attribute for the parent directory
> > + *
> > + * @itr:     iterator positioned anywhere in a directory whose parent =
should be
> > + *   updated
> > + * @Return:  0 for success
> > + */
> > +static int update_parent_dir_props(fat_itr *itr)
> > +{
> > +     int ret =3D 0;
> > +     __u32 target_clust =3D itr->start_clust;
> > +     /* For START macro */
> > +     fsdata *mydata =3D itr->fsdata;
> > +
> > +     if (!itr->is_root) {
> > +             ret =3D fat_itr_parent(itr);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             while (fat_itr_next(itr)) {
> > +                     if (START(itr->dent) =3D=3D target_clust)
> > +                             goto update;
> > +             }
> > +
> > +             /* dent not found */
> > +             return -EIO;
> > +update:
> > +             dentry_set_time(itr->dent);
> > +             itr->dent->attr |=3D ATTR_ARCH;
> > +             ret =3D flush_dir(itr);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >   /**
> >    * fat_rename - rename/move a file or directory
> >    *
> > @@ -2086,7 +2122,12 @@ int fat_rename(const char *old_path, const char =
*new_path)
> >               ret =3D flush_dir(new_itr);
> >               if (ret)
> >                       goto exit;
> > +             /* restore directory location to update parent props belo=
w */
> > +             fat_itr_child(new_itr, new_itr);
> >       }
> > +     ret =3D update_parent_dir_props(new_itr);
> > +     if (ret)
> > +             goto exit;
> >
> >       /* refresh old in case write happened to the same block. */
> >       ret =3D fat_move_to_cluster(old_itr, old_itr->dent_clust);
> > @@ -2097,6 +2138,7 @@ int fat_rename(const char *old_path, const char *=
new_path)
> >       if (ret)
> >               goto exit;
> >
> > +     ret =3D update_parent_dir_props(old_itr);
> >   exit:
> >       free(new_datablock.fatbuf);
> >       free(old_datablock.fatbuf);
>
