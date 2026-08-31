Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D38C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 23:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0695606A5;
	Mon, 31 Aug 2026 23:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pkoa2i-YK5gs; Mon, 31 Aug 2026 23:01:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788217281;
	bh=jhVE0YgHiW1cPJNV9fa8qJYJD4ADYy9qXZW0PnqMS7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1QRZUmC2pTOlHkLkc4vexBDGszHpDo2bw0Apfo7kEbLCgIMD+ihNPnw697EKV39b
	 uyVRkrLbhqv+iwP0PixTpHpssxnbAjQE1ZBKsrGGksFs8YBdKPk4ROObQdkZDXEIQH
	 10gdQUYN6sNDi/fuARd1B/sFB51zR+i/F/qSJtd7hlGrEbH8BC1bjQYPNZbEr+Hg/y
	 ga0RDgPhlXZk6UGqf4FjIhCOCRk+kHBre0bvbPv4GIVdaju5SYBAnijR7fNzN07I7h
	 g4BOKjN/GGEff4xFttQz802sjC4tYgRG8uyd1Th443o417PFsvGTG75W8td4eEPO9M
	 KYrNkDkh2quMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0584760645;
	Mon, 31 Aug 2026 23:01:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E15342AA
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 23:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C120C40556
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 23:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7bTk4FqvH0TZ for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 23:01:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NlLG3u68
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9C124054E
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 23:01:18 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso231813a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788217277; x=1788822077;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jhVE0YgHiW1cPJNV9fa8qJYJD4ADYy9qXZW0PnqMS7w=;
 b=NlLG3u68ZpxQvLxB+TRwYV9YST0iWVa5leOjZeDRCvYnVJAYkRXVfnsn7tDr9Qtu/7
 7JOy5tIvbL5jlj5/8HJ9iBAhRcBvPDkQWxvsREuHRQYMs6j7IUNAGtk2Qs2EeHpa3vVM
 H4MVrTleSs2RZh7tIo8PaS6Yf0e4YPiU34Wcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788217277; x=1788822077;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jhVE0YgHiW1cPJNV9fa8qJYJD4ADYy9qXZW0PnqMS7w=;
 b=pj1bY5zqISU3G0+Xaf1iXXuJZYOfV69nKaF04u+c0kK/4Ag48pCeLqyXVYNsGFUJvC
 Gwvk0bUoX9cXUEW7HR12jTD1j2CDFLzF055KSFztIsP+S2UTu+OhngOaWsQOcBICLu+x
 Nvnxuu25cyCxTW9qqnz4acQPg/WwsD/Oovvr5qTUf9+VcgojODetO2xmRwAzJuFgeMWa
 xL2I6MBt4TCuAUqfDWhMJKbbooLpW694OoOutN1AeY9NWdXpuqTD5RJyuOnMueroYdN4
 5SVj0bulRtzU0nI+ges1XWyEL9R1W40DjEv3fRnFr35ytzI9QrVBWf8lXoqL3TRTdgNv
 M4Jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCV3NQq1b8LPv9xdem7ETJ1i+zYZyqcHjN558Xrl+wKZj8T8QTmPA65VgcjGu7xSqH1z+P/hs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mn8cGjh4QFi+VRG4PZoqlhvZLtBfb+3WU4QNhjx22PxzJtcuTI
 po7kuJ5ddbJvaDStChFNO7iu4fwdu8qWfb4XFMOEHSYNLw4ZKygdgGDdngqniqZ9knE2M4oNU6l
 PjurlMngih8QN
X-Gm-Gg: AR+sD11t4HemKfd/okapUgUUvkxAwWtx50tuQOe85WdK0oprBPaxVEKN2kmSscHcIHH
 6uK1hAC39rJzfKuu0KMG+XFqqceqMOJ3AzzzB5XWNAQfLLxDb0aF+TBLTTNL+3XxZxHaxtnuJ98
 OVM9gt2g5bvVFLby0H121cdnwJk2l/u64Fi3++I1VxMkePZKh3xaQ93t45Jfh6q4schpDg4xdjV
 AASlobrKUIW34l13WnVpn0M69+NMP+ts6ZZp6pD3PWdsB++wk44LhfUjd5aorRxH3W3VpzmBA+0
 XU94EfYUKYhu986AvG1pieVJFEU2chiSDgfl4UHv/3pNObiq6N8XaIT1ijd/RgsyMXceKzFqtZZ
 yz2T1tkjGm1W0wa3fcdAc5rOv+3gAe86LOptnpM2Lmo3iCPlIEyJKWoOB1YYl6EnSLrRbG3z5Zi
 JHtKRm+OJQDJwbG1IR7OdCIZa4hyqq4kGLGKXBDAQdfhWLKwokN873iuAr0vSOWdMA+UP+e0WFs
 7+6ktzIVxAqCzrG7WaoUFenjyRDwg9n6l8Uv3K9p1K4XXT3q99HDbNVyhXotn4CX16n1Y4x7lJY
 hfQCtuPUt//2YjlCUm/W
X-Received: by 2002:a05:6830:7306:b0:7f4:ec7f:9de6 with SMTP id
 46e09a7af769-7f4f23a4f7bmr33564842a34.12.1788217277358; 
 Mon, 31 Aug 2026 16:01:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa6bc42fsm8958473a34.6.2026.08.31.16.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 16:01:16 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:01:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuxiao Zhang <yuxiaozhang@google.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] u-boot: fix error check in eth init
Message-ID: <20260831230114.GC1145425@bill-the-cat>
References: <20260826181428.1856166-1-yuxiaozhang@google.com>
 <20260826200207.GB3959812@bill-the-cat>
 <CAOOoKeQPDO0FTN0ya+W5-HR0DsadcbXFgfyG=SwG9DaM8S-GWA@mail.gmail.com>
 <20260826204240.GC3959812@bill-the-cat>
 <CAOOoKeQXLLWa-aUJviAt0Qrj_Z922UkeM-0iVs0FK1swBwiOFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mfGbyQgDnKoAaJ6X"
Content-Disposition: inline
In-Reply-To: <CAOOoKeQXLLWa-aUJviAt0Qrj_Z922UkeM-0iVs0FK1swBwiOFg@mail.gmail.com>
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


--mfGbyQgDnKoAaJ6X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 02:00:22PM -0700, Yuxiao Zhang wrote:
> On Wed, Aug 26, 2026 at 1:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > On Wed, Aug 26, 2026 at 01:12:55PM -0700, Yuxiao Zhang wrote:
> >
> > > IMHO at least the activation check is a valid case. It just check the
> > > status flag and returns EINVAL without setting errno:
> > >
> > > 292         if (!device_active(dev))
> > > 293                 return -EINVAL;
> >
> > Please don't top-post, it makes following context harder. And, this
> > isn't quite what I was asking about. If we look at commit:
> > commit 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0
> > Author: Jerome Forissier <jerome.forissier@arm.com>
> > Date:   Wed Oct 16 12:04:01 2024 +0200
> >
> >     net: eth-uclass: add function eth_start_udev()
> >
> >     Add a function to start a given network device, and update eth_init=
()
> >     to use it.
> >
> >     Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > Which introduces this function, and examine the code before/after, we
> > aren't quite doing the same things as before.
> >
> > So yes, we aren't handling the error case you describe correctly, but my
> > first thought is that the caller here should be doing eth_errno =3D
> > eth_start_udev(); and then setting ret =3D eth_errno if we get a proble=
m.
> > But that might not be quite right either, I've only spent a few minutes
> > on this,
> >
> > >
> > > Thanks,
> > > -Yuxiao
> > >
> > >
> > >
> > > On Wed, Aug 26, 2026 at 1:02=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > >
> > > > On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:
> > > >
> > > > > eth_start_udev can fail but errno could still be zero which causes
> > the
> > > > > function ignores the error silently. This fix catches the error
> > > > > properly.
> > > > >
> > > > > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> > > > > ---
> > > > >
> > > > >  net/eth-uclass.c | 11 ++++++-----
> > > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > > > > index 5c437143a30..5518268bd68 100644
> > > > > --- a/net/eth-uclass.c
> > > > > +++ b/net/eth-uclass.c
> > > > > @@ -347,12 +347,13 @@ int eth_init(void)
> > > > >                       debug("Trying %s\n", current->name);
> > > > >
> > > > >                       ret =3D eth_start_udev(current);
> > > > > -                     if (ret < 0)
> > > > > -                             ret =3D eth_errno;
> > > > > -                     else
> > > > > +                     if (ret < 0) {
> > > > > +                             if (eth_errno < 0)
> > > > > +                                     ret =3D eth_errno;
> > > > > +                             debug("%s start failed (ret=3D%d)\n=
",
> > > > current->name, ret);
> > > > > +                     } else {
> > > > >                               break;
> > > > > -
> > > > > -                     debug("FAIL\n");
> > > > > +                     }
> > > > >               } else {
> > > > >                       debug("PROBE FAIL\n");
> > > > >               }
> > > >
> > > > Is it a valid case for eth_start_udev to have failed and not set
> > eth_errno?
> > > >
> > > > --
> > > > Tom
> > > >
> >
> > --
> > Tom
> >
>=20
> Sorry for the late reply. I checked the commit
> 7ad5e878cd850102e13ee2a5f8a5fb69742f70b0 and looks like the issue still
> exists before that commit. If the check "device_active(current)" failed
> then the errno is also not set and we still return 0. I am not sure if
> "eth_errno
> =3D eth_start_udev();" since that just ignores the real errno. The fix I
> proposed is just to capture the corner case that errno is 0 but eth_start=
_udev
> still failed for whatever reason. Otherwise the logic keeps the same as
> before.

Yes, before if device_active(current) is false (it's just a flag check),
we would only end up with something in eth_errno if eth_get_dev() had
failed.

So at this point, it should be clear that, as I had asked originally,
this isn't some special case but rather a problem in handling errors
=66rom eth_start_udev to solve. Perhaps it should be setting eth_errno
instead of directly returning? Or perhaps as I suggested at first we
should be doing 'eth_errno =3D eth_start_udev();' and going from there?

--=20
Tom

--mfGbyQgDnKoAaJ6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapYHtgAKCRAr4qD1Cr/k
CizGAP9yy7Yi/7YsCohG3rVqRb+7mAeJLFzERlMmESJB7CjGOwD/Z+06aFXA0xUF
c+dZZos2kWP9kEtr3cs8YMPOvs9uIQE=
=fLNs
-----END PGP SIGNATURE-----

--mfGbyQgDnKoAaJ6X--
