Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FE1C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 20:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFE0A406ED;
	Wed, 26 Aug 2026 20:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRzuudFylhGj; Wed, 26 Aug 2026 20:42:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787776968;
	bh=3Es1SL21VGuDUJVHzpaP5bCOkwiXj5JskgI44iJUprI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0HYDxp5kOFlEl+hdzsqlryU0vM2xG6ByVHPNN1rQbK8cYqwx1N2KwGcsRnYlFWJ8
	 9zHUYz2/yDYjVWoYQ1TnWDPRKBFhps+qkhN02XGRdyiSBYQk5nlbTZbIoBimtQzsRJ
	 ZWfRyRunz1RHxMZ7IPOn8jOlcsOW8YxjWN/b7hWjwX2ZNmtJ+8aChrg5OOTHCUV2t/
	 ptlpoqjtinDXqh1/FGUK82xj6e1rar3IOWSQQv0Grjky1VouizHkoLcGJjvCwficrm
	 bwE0w9cFzlZZ7RkisufSf0+w+Br8QKpmEE+VqXRYdKOPgU53C5Nl3OleReSaly6UdL
	 zHTowlYmFo8YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 257BE406E6;
	Wed, 26 Aug 2026 20:42:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CAE73AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AA834024A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIxGZikExi8w for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 20:42:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b3dAoKPt
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 603C640247
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:42:44 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7f42ef0b693so1084844a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787776964; x=1788381764;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Es1SL21VGuDUJVHzpaP5bCOkwiXj5JskgI44iJUprI=;
 b=b3dAoKPtjiBc72Fe+ApN1NchrTfK/Rxcqkhz4WBZyYYW0Pi0A/D4MSyIdqV/3mKPro
 zpqPi7mKW0LLgk0DiXL+LLa0c3i6B3b3rxcjf0Iv8nO60DAQF/MK8Ucb3KJ40mftuQz6
 6YSIseXQutYvfXfJTc2lIAvnQeevcJrMfdi4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787776964; x=1788381764;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Es1SL21VGuDUJVHzpaP5bCOkwiXj5JskgI44iJUprI=;
 b=bE+8179A7dGocjoxbHXaRhUJOzoFZnSYQ0KBgKiLLpBLHBDKmIFy6RSx8/ksuPWp36
 C4YNaVz0fNPQ+Wm3iLVFVaJvrVrbZhsIoodUBJ9Zb7UoCVIyWVWhTnwVBSlW7Da8uVEd
 44ui2UFpSShRkNBHx6NGH86EJWthH0WjKccCBzuiFbYdpbkhpsT60LnNvl2X56RVakdC
 OWRHp0bF7PwhGyMce0lOfrYN1wspUw70hpX0ep1TpJVEJRz/Zdn1WmXFLzK2oIrm8P/z
 qUWdDvMBv+WxJXD7t797flsGh1Z5xeIPFHre/0r9BuuWIqUY+/lj0nODLx5KDwU82dCL
 0NzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrXqI/1h06L0cUGzFmqPOPORqkT/JWTHHNiPIkaSCvJIS2mSMBMDwVplWdTelmVnx47dzxG5g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ms5jL4uyX3K6Xl8VvjboO4NjpjX5KYj6MUQY4KMveQ5ggJ5fbz
 SYM+hL3jRK2gCKxRUs1O4zMVaZke+/4Ap1imldcI1/jz0d/R9L8N4a7heKp3oR9B3u0=
X-Gm-Gg: AR+sD12+ssNW2hrM44WR0PiyidfdHDLngnGGgqV93iUEfXzU/pk24anMdawwu6LPf7U
 1TfyvaabWtHn+nOl5P6mszNhpeVwRNb3I+CmwwJhjsTjQLJcaY/RCW5FcXkjW/W1PNSMevddUSN
 xHAF+oLxhzAX+2W+XU4p+GyjlyOJ/Dj4gKxN+vyo5tQeoYC+Rij5bVwgTvADBVlPGSYJMe+1dGy
 x+fcpQ3CSslG7CfBg+SK82SOCIiI+BUbI8b/iCYJ2Bl5cN0GA5ONIrEgA8xB5CS519Pfr2mBbx3
 Mie58jB1AR8BQ24bJRKrSF7HXNk/vpc1GyzdP39aRkYczTKo7NkPHpH4xrnFqIl8bjG8/jQ2a2H
 2lxy2WSJlxTW6EBNvTP7CRTjbXlORJWF9YnJGWJVB6JcyQJ3IboBT85XkkDnIpkGdxHWoOYh6Px
 I57atdSZCI/F2OnQ3bD9FZNl0wB/GetTTi8YeV2Cbc+iEld0GltHHSc7dhDxP9bEG1Fu+RFb0AI
 nqWRBtXYU1lAdJxh/wLm8kIV08o0FS1U7N+XKHMC07kf+FiDbAJiK6ibA04APv6DflKv9wUZ1il
 WaOSgjd+DQ==
X-Received: by 2002:a05:6830:3695:b0:7e6:e8cd:bb7e with SMTP id
 46e09a7af769-7f4c4b8b2e5mr10731137a34.4.1787776963643; 
 Wed, 26 Aug 2026 13:42:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c818355csm2516755a34.6.2026.08.26.13.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 13:42:42 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:42:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuxiao Zhang <yuxiaozhang@google.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] u-boot: fix error check in eth init
Message-ID: <20260826204240.GC3959812@bill-the-cat>
References: <20260826181428.1856166-1-yuxiaozhang@google.com>
 <20260826200207.GB3959812@bill-the-cat>
 <CAOOoKeQPDO0FTN0ya+W5-HR0DsadcbXFgfyG=SwG9DaM8S-GWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w3tU07rzQYlCsAb+"
Content-Disposition: inline
In-Reply-To: <CAOOoKeQPDO0FTN0ya+W5-HR0DsadcbXFgfyG=SwG9DaM8S-GWA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--w3tU07rzQYlCsAb+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 01:12:55PM -0700, Yuxiao Zhang wrote:

> IMHO at least the activation check is a valid case. It just check the
> status flag and returns EINVAL without setting errno:
>=20
> 292         if (!device_active(dev))
> 293                 return -EINVAL;

Please don't top-post, it makes following context harder. And, this
isn't quite what I was asking about. If we look at commit:
commit 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0
Author: Jerome Forissier <jerome.forissier@arm.com>
Date:   Wed Oct 16 12:04:01 2024 +0200

    net: eth-uclass: add function eth_start_udev()
   =20
    Add a function to start a given network device, and update eth_init()
    to use it.
   =20
    Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
    Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Which introduces this function, and examine the code before/after, we
aren't quite doing the same things as before.

So yes, we aren't handling the error case you describe correctly, but my
first thought is that the caller here should be doing eth_errno =3D
eth_start_udev(); and then setting ret =3D eth_errno if we get a problem.
But that might not be quite right either, I've only spent a few minutes
on this,

>=20
> Thanks,
> -Yuxiao
>=20
>=20
>=20
> On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:
> >
> > > eth_start_udev can fail but errno could still be zero which causes the
> > > function ignores the error silently. This fix catches the error
> > > properly.
> > >
> > > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > > ---
> > >
> > >  net/eth-uclass.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > > index 5c437143a30..5518268bd68 100644
> > > --- a/net/eth-uclass.c
> > > +++ b/net/eth-uclass.c
> > > @@ -347,12 +347,13 @@ int eth_init(void)
> > >                       debug("Trying %s\n", current->name);
> > >
> > >                       ret =3D eth_start_udev(current);
> > > -                     if (ret < 0)
> > > -                             ret =3D eth_errno;
> > > -                     else
> > > +                     if (ret < 0) {
> > > +                             if (eth_errno < 0)
> > > +                                     ret =3D eth_errno;
> > > +                             debug("%s start failed (ret=3D%d)\n",
> > current->name, ret);
> > > +                     } else {
> > >                               break;
> > > -
> > > -                     debug("FAIL\n");
> > > +                     }
> > >               } else {
> > >                       debug("PROBE FAIL\n");
> > >               }
> >
> > Is it a valid case for eth_start_udev to have failed and not set eth_er=
rno?
> >
> > --
> > Tom
> >

--=20
Tom

--w3tU07rzQYlCsAb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao9PvQAKCRAr4qD1Cr/k
Cg3WAQDXe+NoQscQZU3CrfyZQKP7k4pdRPap+cAbVLdpyQNsSgEAraM4C1XyrbBu
dqFr+2TDgZOW9PnIqMViNx1d1BRT5Ag=
=vijq
-----END PGP SIGNATURE-----

--w3tU07rzQYlCsAb+--
