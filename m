Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0167FC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 23:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B841F87AD0;
	Fri, 19 Jan 2024 00:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qOyjU/Oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B9386FB2; Fri, 19 Jan 2024 00:03:46 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6046886FB2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 00:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5ff821b9acfso1589637b3.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705619023; x=1706223823; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kVaRHNZhH9VamGU92mTcQpu78fvB2NP9zJBs9oeIttA=;
 b=qOyjU/OhxX0jPqlfh09SplzYZxzjnIcnHT4qggZSnMCkZGXL3UbTx0j5pGYGfmdS/X
 amKeKi5trZkk7UNJikma2GS95ttZ8Fno6GuRuYCUHkuQb+NHbEGgepbvBRdqwtNlhHCD
 Hzx1HlGVgp0HI90tLjOL5mmDbf7ut/RDXpyYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705619023; x=1706223823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVaRHNZhH9VamGU92mTcQpu78fvB2NP9zJBs9oeIttA=;
 b=lOXQSCArDGS4TCGWVGtjEnsI9b91sqBdHygcfnAO2wLcUi/81vySdc8StXBRrJSPC3
 BLHi3h5IvZEdNJsgn+D8aXAhO+O1QZSy9CvLHhx5dAAw17k2eFU/CT8qTPofKlLjJfTx
 9UZMeF2TLPb41a/3r1WhMDH57M/sKZoilR/fsbJtkdXfPpWERTkH2t4JuFyIuQBN5eTG
 4PaSDL3vd44FdrjTbzVNSwTEMRmVP6bX00/IE9glKhkTf2MSPC70w+XyC4TkeGeK36CA
 ydUGZtzz0MdPzMwgvmcYgQFuKTjUrHwjAc+DKW2PaCrYkFkKQ/7Xgp/1GA9h3L/YbCgH
 Xf/A==
X-Gm-Message-State: AOJu0YxMAR1pNMOoeuOeD1C9vqHRdIHV+ei2oIuU2/pFW/80oD659UWq
 bEr5pneM39Oks7gquCpSXJFaqt28bK9Ed4xsCgjvmhUR1CbPs7W9EgjREYzN8gE=
X-Google-Smtp-Source: AGHT+IHVF7WoHURuqVckB05CFXF0syoULuBqQHMSLNyn9ul62fI9H4z6Kj3A1QlSA5g6LkywdBRK8A==
X-Received: by 2002:a25:b1a6:0:b0:dc2:331e:48bd with SMTP id
 h38-20020a25b1a6000000b00dc2331e48bdmr1403665ybj.44.1705619023042; 
 Thu, 18 Jan 2024 15:03:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 c127-20020a254e85000000b00dbdb2966f67sm6361508ybb.24.2024.01.18.15.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 15:03:42 -0800 (PST)
Date: Thu, 18 Jan 2024 18:03:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Moritz Fischer <moritz.fischer.private@gmail.com>
Cc: Moritz Fischer <moritzf@google.com>, bmeng.cn@gmail.com,
 sjg@chromium.org, wenbin.song@nxp.com, u-boot@lists.denx.de,
 patrick@blueri.se
Subject: Re: [PATCH v2 RESEND 2/2] nvme: Update nvme_scan_namespace to keep
 trying on busy
Message-ID: <20240118230340.GI12635@bill-the-cat>
References: <20240110050448.1441657-1-moritzf@google.com>
 <20240110050448.1441657-2-moritzf@google.com>
 <CAJYdmeORBWpwMFKA-C9Ybie20OgJDwUzdo+ZE7eESn7VpV_2PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LIOK7F0lQrPBxXw0"
Content-Disposition: inline
In-Reply-To: <CAJYdmeORBWpwMFKA-C9Ybie20OgJDwUzdo+ZE7eESn7VpV_2PQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--LIOK7F0lQrPBxXw0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 02:29:11PM -0800, Moritz Fischer wrote:
> On Tue, Jan 9, 2024 at 9:05=E2=80=AFPM Moritz Fischer <moritzf@google.com=
> wrote:
> >
> > A busy controller shouldn't be game-over for all controllers,
> > so keep trying on hitting -EBUSY.
> >
> > This change brings the actual behavior of the routine in line
> > with what the descriptions says.
> >
> > Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > ---
> >  drivers/nvme/nvme.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> > index ec45f831a3..59a139baa0 100644
> > --- a/drivers/nvme/nvme.c
> > +++ b/drivers/nvme/nvme.c
> > @@ -695,7 +695,9 @@ int nvme_scan_namespace(void)
> >                 if (ret) {
> >                         log_err("Failed to probe '%s': err=3D%dE\n", de=
v->name,
> >                                 ret);
> > -                       return ret;
> > +                       /* Bail if we ran out of memory, else keep tryi=
ng */
> > +                       if (ret !=3D -EBUSY)
> > +                               return ret;
> >                 }
> >         }
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
>=20
> Gently ping on this. Is anything wrong with this series or why does it
> keep falling through the cracks?

Randomly, I'm testing this (and your other patches, and some others) at
the moment. Sorry for the delay.

--=20
Tom

--LIOK7F0lQrPBxXw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWprkkACgkQFHw5/5Y0
tyxqTAv/WHFe+tlx43oJn9JzW7jHIioEXgE70oOth5Vzp5yH1QzK3nZaBE8ubCiX
9bRjvg23iW53GwW07Ifi5Dr4xWcUQh0N9pCOymgHJOlgygmTLMp/Epps5ca/Bd6r
zz/ZqgTCWTF/2slRlwMO9zS3xZlCJotFe/LIdfoU/x0n6bABqTV5dYF3Vs00sJWQ
o+oOltUHbLYNlEATCTpISKcZga3y7VjEhV4p7PUZEtlyCOQObj0IgfJqKecPEfhD
CgWCcQPwLerkUy0Y1Q0wbLHneHtl8F94fphYaYGuqkyLZw2MXgoAPNGdp9XNeXXf
TcJNINiiPi4CQAvqyjuq8aUtnIebVCQ0QQx6XMbpvlpttrMAkW9CqD3NyU5OTsml
gypzAbRkPwbFYGwSFOECV1QsEhSfEYRu6OpDFPbg9jmrNOHwq+JV5O18/OjvrPVM
Fdi9j4AkjyV6yWXASm7G6GubNHe7iSC/p7PsTlQS3jr1dSkKeTOYcAr/KHDYvRub
gvU9QGxH
=3iyU
-----END PGP SIGNATURE-----

--LIOK7F0lQrPBxXw0--
