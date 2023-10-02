Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEC2E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969EC87254;
	Mon,  2 Oct 2023 03:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="xkxH3YZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEC587438; Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280E5871A2
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso2240771166b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209734; x=1696814534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fa2x+jWLznIdZLOzQWIDr63VqG+zCfDORdYqGqXC0YQ=;
 b=xkxH3YZi3p1XDYa/5GDVAaQdmnkFZKtH5pmLfEw7ozk/CNpnwgdZ1fTQ7X1ARwPqLx
 CNcG9pFEy3hy7BMIw3Ki9u6sm3JsmxUGIwYnwFXq/ab/AadNBYtwh0pqKMvMI0OLNmmy
 zpimAzk8wVvm0ToSG551QS6OkavgVIC+3WUZjNv165MUCJ9W54MPbpSUSDBH6G+UFfwP
 nY3yaR/VnGAUuJgP9/CQUUvyxX0Kopg3SvVBU31wv1siCyrm02dTCb4iu9t/Py9R1rA2
 GzwsaFIb6cPfAN2VgtxA4Hu/y51cUA3pAlA4OsJ5ivjnGQ69cNDsBYzf+4dEI+a8zMiA
 SKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209734; x=1696814534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fa2x+jWLznIdZLOzQWIDr63VqG+zCfDORdYqGqXC0YQ=;
 b=gIWnrpB9bnDaxN+iQWGKrMlDIVlwg89vSXb3VVyEBX2ANKjsbrPZdSxw8X5y/ZxmFy
 sy6XYT8tsXfo7IubU/yKfD9KuEpOXFAH7Nz9LZDWSW10uQWRosEQzyM2kZtAh4z55wu+
 gxPTnv0RXkGiaOAGizA4w3RF9WVDwi0a7dN45++COFYRSJob7COc47rCLtsRi4YqcCaZ
 43eOEuPYT3oiyiuD5acSObwBX2I6WHgZq5JKlc85QCxCFtpbucVcBtxn3S4Rx83DvGdy
 Rid5jVNgJ4aF2opJ4jIOxhanaShyKKK8ElUBHgZl9AEW+ZlRRSbwi44/JimLkL49K42k
 AZrA==
X-Gm-Message-State: AOJu0Yyt32mYcHee3YhF40VKB/qmH8x72uJ95ja0CzOsJPaXT9tIkSAg
 t5pYH4t+w8HaycuJTUi2/FlAGSc6yHnoyYnCJFjXdw==
X-Google-Smtp-Source: AGHT+IE32irmn98y9V4yp2y7HUFhH0LDn6hbvdZPYHB6ng2vOKcT6g9LngFNghVfwGt7lK9gx7ELmDQvFWRS0dyv81M=
X-Received: by 2002:a17:906:76d4:b0:9a5:ca42:f3a9 with SMTP id
 q20-20020a17090676d400b009a5ca42f3a9mr8560561ejn.2.1696209734543; Sun, 01 Oct
 2023 18:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230930143623.318903-1-seanga2@gmail.com>
 <e3663767-0f99-aadc-924c-5295dafc1e6a@gmail.com>
In-Reply-To: <e3663767-0f99-aadc-924c-5295dafc1e6a@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:16:41 -0600
Message-ID: <CAPnjgZ32HSq0TOaULvt+TJ3NNeT7ScCVZFh3ft4sqtNZ7QRH6Q@mail.gmail.com>
Subject: Re: [PATCH] linker_list: Fix ll_entry_get alignment
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
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

Hi Sean,

On Sat, 30 Sept 2023 at 09:23, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 9/30/23 10:36, Sean Anderson wrote:
> > When ll_entry_get is used on a list entry ll_entry_declare'd in the same
> > file, the lack of alignment on the access will override the
> > ll_entry_declare alignment. This causes GCC to use the default section
> > alignment of 32 bytes. As list entries are not necessarily 32-byte aligned,
> > this will cause a gap in the linker list, corrupting further entries.
> >
> > As a specific example, get_fs_loader uses DM_DRIVER_GET(fs_loader) in the
> > same file where U_BOOT_DRIVER(fs_loader) is present. This causes a crash
> > when walking the driver list.
> >
> > Fix this by adding appropriate alignment to all accesses.
> >
> > Fixes: 42ebaae3a33 ("common: Implement support for linker-generated arrays")
> > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> >   include/linker_lists.h | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linker_lists.h b/include/linker_lists.h
> > index f9a2ee0c762..e0c8a01b9ba 100644
> > --- a/include/linker_lists.h
> > +++ b/include/linker_lists.h
> > @@ -209,7 +209,8 @@
> >    */
> >   #define ll_entry_get(_type, _name, _list)                           \
> >       ({                                                              \
> > -             extern _type _u_boot_list_2_##_list##_2_##_name;        \
> > +             extern _type __aligned(4)                               \
> > +                     _u_boot_list_2_##_list##_2_##_name;             \
> >               _type *_ll_result =                                     \
> >                       &_u_boot_list_2_##_list##_2_##_name;            \
> >               _ll_result;                                             \
> > @@ -229,7 +230,7 @@
> >    * @_list: name of the list
> >    */
> >   #define ll_entry_ref(_type, _name, _list)                           \
> > -     ((_type *)&_u_boot_list_2_##_list##_2_##_name)
> > +     ((_type __aligned(4) *)&_u_boot_list_2_##_list##_2_##_name)
>
> OK, so this causes an error in clang. And it isn't really necessary
> because the entry is already declared at this point.
>
> So I guess the right fix is to replace DM_DRIVER_GET with DM_DRIVER_REF in
> get_fs_loader. But this seems like a really big footgun. You can use the
> wrong one and there are no errors except at runtime. I wonder if we can add
> a warning of some kind?

I can imagine having a runtime check, something like:

ll_check(sizeof(struct something))

which checks that the linker list (end - start) is a multiple of the
struct size. Do you think that would find the problem?

If so, then it could be perhaps be turned into a link-time check. This
produces a list of the linker lists along with their individual
members:

or ll in $(nm /tmp/b/coreboot/u-boot |grep u_boot_list_2 |sed
's/.*_u_boot_list_2_\(.*\)_2_.*/\1/' |uniq); do echo; echo "linker
list: %ll"; nm /tmp/b/coreboot/u-boot |grep $ll; done

...
linker list: ut_str_test
011a9a20 D _u_boot_list_2_ut_str_test_2_str_dectoul
011a9a30 D _u_boot_list_2_ut_str_test_2_str_hextoul
011a9a40 D _u_boot_list_2_ut_str_test_2_str_itoa
011a9a50 D _u_boot_list_2_ut_str_test_2_str_simple_strtoul
011a9a60 D _u_boot_list_2_ut_str_test_2_str_simple_strtoull
011a9a70 D _u_boot_list_2_ut_str_test_2_str_trailing
011a9a80 D _u_boot_list_2_ut_str_test_2_str_upper
011a9a90 D _u_boot_list_2_ut_str_test_2_str_xtoa
011a9aa0 D _u_boot_list_2_ut_str_test_2_test_str_to_list
...

Then you can check that the address of each one increments by the same amount.

Maybe.

Regards,
Simon
