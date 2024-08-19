Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC738C52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 13:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2D388CBF;
	Mon, 19 Aug 2024 15:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=johanneskirchmair.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=johanneskirchmair.de header.i=@johanneskirchmair.de header.b="LomGx5A0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A234388356; Mon, 19 Aug 2024 08:46:00 +0200 (CEST)
Received: from mx8.mail-out.lima-city.de (mx8.mail-out.lima-city.de
 [91.216.248.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459A988009
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=johanneskirchmair.de
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=mailinglist1@johanneskirchmair.de
From: <mailinglist1@johanneskirchmair.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=johanneskirchmair.de;
 s=securedbylima-20161106; t=1724049957;
 bh=tPsG8G93wXvNfNuZt7cG/11JFLw7aBrIq3dJI0j3hQw=;
 h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
 b=LomGx5A0YR2LdzClvs3aOSkAlt44KaGo/8eVVX6mFZI/kE6R5TUrrkH1lBRZ1cyBQ
 tOWyYnlFiNDCQn2HiI2eoBmy/BAtVfZ5pdH1L2jk+ox/QY+UD6LkDOjpuOarqC44Cc
 0/bC07GiUzK6s4A/bNrklBL2WFR0lz+02nAXIzSA=
To: "'Simon Glass'" <sjg@chromium.org>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>,
 "'Johannes Kirchmair'" <johannes.kirchmair@skidata.com>
References: <20240816073332.279025-1-mailinglist1@johanneskirchmair.de>
 <CAFLszTgx3NrH8-6XF4NKhfCcYxn-nWY3f6GNL_ORbzD5zGaswA@mail.gmail.com>
In-Reply-To: <CAFLszTgx3NrH8-6XF4NKhfCcYxn-nWY3f6GNL_ORbzD5zGaswA@mail.gmail.com>
Subject: AW: [PATCH] spl: fix error handling of spl_fit_read
Date: Mon, 19 Aug 2024 08:45:58 +0200
Message-ID: <000301daf203$73c1b7f0$5b4527d0$@johanneskirchmair.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de-at
Thread-Index: AQKgpYxFpKtwKDAD7E2rRuPPb6XJPwGtmQujsJVNHDA=
x-bromium-msgid: b30f5f67-e99f-4e05-afa5-aa9845aadbff
X-Mailman-Approved-At: Mon, 19 Aug 2024 15:54:55 +0200
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

Hey,

> -----Urspr=C3=BCngliche Nachricht-----
> Von: Simon Glass <sjg@chromium.org>
> Gesendet: Samstag, 17. August 2024 17:58
> An: mailinglist1@johanneskirchmair.de; Sean Anderson
> <seanga2@gmail.com>
> Cc: u-boot@lists.denx.de; trini@konsulko.com; Johannes Kirchmair
> <johannes.kirchmair@skidata.com>
> Betreff: Re: [PATCH] spl: fix error handling of spl_fit_read
>=20
> +Sean Anderson too, for this
>=20
> Hi,
>=20
> On Fri, 16 Aug 2024 at 07:36, <mailinglist1@johanneskirchmair.de> =
wrote:
> >
> > From: Johannes Kirchmair <johannes.kirchmair@skidata.com>
> >
> > Returning negative values from spl_fit_read leads to u-boot =
crashing.
> > The return value of spl_fit_read is compared with an unsigned value.
> > Returning negative values leads to the check not detecting the =
error.
> > Not detecting the error leads to crashing.
> >
> > Returning zero in case of an reading error is fine. It indicates =
that
> > nothing was red.
>=20
> read
>=20
> >
> > Signed-off-by: Johannes Kirchmair <johannes.kirchmair@skidata.com>
> > ---
> >  common/spl/spl_fat.c | 2 +-
> >  include/spl_load.h   | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
>=20
> Perhaps instead this should be fixed in _spl_load()? We don't want to =
ignore
> errors, and returning -EIO is not as good as returning the actual =
error received.
> The docs of struct spl_load_info indicate that functions should return =
0 on
> error, but that is somewhat surprising behaviour, which is probably =
why
> people are not following it?
Could also be a valid way of fixing, as Sean did in his patch [1]
Too have less confusion in the future, we should also switch the =
signature from returning ulong to long and allow negative return values =
for errors.

>=20
> > diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c index
> > bd8aab253a..345bc55149 100644
> > --- a/common/spl/spl_fat.c
> > +++ b/common/spl/spl_fat.c
> > @@ -53,7 +53,7 @@ static ulong spl_fit_read(struct spl_load_info
> > *load, ulong file_offset,
> >
> >         ret =3D fat_read_file(filename, buf, file_offset, size, =
&actread);
> >         if (ret)
> > -               return ret;
> > +               return 0;
> >
> >         return actread;
> >  }
> > diff --git a/include/spl_load.h b/include/spl_load.h index
> > 1c2b296c0a..b411d9daa1 100644
> > --- a/include/spl_load.h
> > +++ b/include/spl_load.h
> > @@ -17,8 +17,8 @@ static inline int _spl_load(struct spl_image_info
> > *spl_image,  {
> >         struct legacy_img_hdr *header =3D
> >                 spl_get_load_buffer(-sizeof(*header), =
sizeof(*header));
> > -       ulong base_offset, image_offset, overhead;
> > -       int read, ret;
> > +       ulong base_offset, image_offset, overhead, read;
> > +       int ret;
> >
> >         read =3D info->read(info, offset, ALIGN(sizeof(*header),
> >                                               spl_get_bl_len(info)),
> > header);
> > --
> > 2.34.1
> >
>=20
> Regards,
> Simon

Best regards,
Johannes

[1] =
https://lore.kernel.org/u-boot/20240731130913.487121-1-fventuri@comcast.n=
et/

