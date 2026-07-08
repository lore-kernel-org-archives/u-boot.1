Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25949C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EDE84118;
	Wed,  8 Jul 2026 03:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dp47hogW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F7F84942; Wed,  8 Jul 2026 03:12:52 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4F6838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso82650fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783473168; x=1784077968; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vN8UhHQmXs77u1fcRXQy/36MPSdYpvtK9BJJM5ijFhY=;
 b=dp47hogWD0Ol427OiCKOk+a9ndw0l8LI5SpfsIwdfgMKbepBM1oSchH8UvkvOKV0O0
 7H/p1cz5b/ssY+aoZO3BzntozYXASJRLAM71n4+n5FP5lXrHgf4DoLknmvYjp6K5+I1x
 xOCuCL17R6zTu/e+FtN8Xglfv09v5dKqtlu6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783473168; x=1784077968;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vN8UhHQmXs77u1fcRXQy/36MPSdYpvtK9BJJM5ijFhY=;
 b=YcoDkgXKSsmqHdcOsxFAXlzVlwKA3BliEVpTw061SMtaozRaRYpGw1FTTN/4Zyu2CY
 MYLTu5oGUtqf06fRaLba25Ud2cm60LHg9hOglvqEMVWHsMC/so+1PtcVIjWDaZ1q/EOT
 THAj1+y7/bJHEESzfoRidrtL8pcbnXwxhvMzlaLWTAMzdrKKZCvXb9MQ5J4T9A2Gsm5T
 cij7eB+veuRLWmsFArtzqgMxItMKUErMqadfiG8V9gtuoaM6b0oDguQHzLTljHNGA8Hk
 mPFIDKLN8GmFMjyCBniMftC+08eIZE6ACAysgPtuo8S+Mfxsi3JLVyN/Z8EFA2wPgM/x
 5NEA==
X-Gm-Message-State: AOJu0Yzbs+DsBBYKR/i8s6wahsH9ESQ2t9BGz7AWL8Ixi1ipSM2r8ofR
 fhVbHkzEcupOJGuV+a+IgipLa5rdip9t0ihhnNUepzQReJhAOFNLcRy0anVJQbqp0INNHxMUo6L
 lTNUlHMI=
X-Gm-Gg: AfdE7cnf9PZeQeO05Sn6r1s3huxMSJ61LMQP4tCe6PkQTBoixmo8XWbad5a0rxEbQDB
 HmS3WUTK3a+2BdnNYZ9mjj+/n/kvti42NyS8M/DtYjb+1/f8dEhy+nQLjn+nsAIe+vaiDvoC5Qm
 EnH7kvWdzw2EBjs+Mei3PTLUokqWVGudtQsbB4yq03irEvdJdCIZXdpxjeCC99n64YkK1n9fp6c
 LIDVTVCgxtkKln3zkhOsdSkOTeKMNpN/CSVn4zhSno2kWxB8N04nwPCknzIOhghCybjVqOpOydK
 FeEfKvetFvA+azk/xtO1qwHYw9e8kIE9nWvd3XrmQJXv3r6nnhdPHOxt53o4+MkuLnu+k0YtmQW
 BnIpIrtv9H/4NSWNQeBRdWN2F8IT5SMglAz4FCRWxwRe8qudvC5oexEm4ucH4te30Yw0qvVajIh
 rjwBYY3M0FLG+27yMRVb6B8IOivdiD1oPQPutj1UWV16qFcEgWIo8zO1SrACPYWB/kqPrvGPVNu
 r3IPURzaf4IvqwV1pcb21d6c/hVMNoQvTSdGlASvXV7cnV9
X-Received: by 2002:a05:6870:16e8:b0:43d:7b24:96 with SMTP id
 586e51a60fabf-45162e07d2emr297021fac.0.1783473168454; 
 Tue, 07 Jul 2026 18:12:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm16375481fac.8.2026.07.07.18.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:12:47 -0700 (PDT)
Date: Tue, 7 Jul 2026 19:12:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bloblist: Rename GD_FLG_BLOBLIST_READY to
 GD_FLG_BLOBLIST_HANDOFF
Message-ID: <20260708011245.GO749385@bill-the-cat>
References: <20260707224842.261424-1-trini@konsulko.com>
 <CAMDkj5z3tTVxZeusOsNwjmfUr3qCAthBeRUQqgBpifZS4LDy7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c2sj7aDPXOlTZxXv"
Content-Disposition: inline
In-Reply-To: <CAMDkj5z3tTVxZeusOsNwjmfUr3qCAthBeRUQqgBpifZS4LDy7w@mail.gmail.com>
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


--c2sj7aDPXOlTZxXv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 08:04:22PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, Jul 7, 2026 at 6:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > Now that we have made bloblist have distinct "find" and "create"
> > functions, the global data tag "GD_FLG_BLOBLIST_READY" doesn't quite
> > make sense anymore. Rename it to GD_FLG_BLOBLIST_HANDOFF.
> >
> > Suggested-by: Raymond Mao <raymondmaoca@gmail.com>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  common/bloblist.c                 | 8 ++++----
> >  include/asm-generic/global_data.h | 4 ++--
> >  include/bloblist.h                | 2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> >
>=20
> Sounds good to me.
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>=20
> BTW, do we need another flag for the locally allocated/static-assigned bl=
oblist?

Probably not? But it's been a while since I put a lot thought into this
area. I had this sitting around and noticed I hadn't sent it.

--=20
Tom

--c2sj7aDPXOlTZxXv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak2kAAAKCRAr4qD1Cr/k
CovMAQC+mJwz+PgFc5YBK8O7ZVNhBF4EtOZS9UoQyBTrMEGbGwD4gFzI7gTsXqC5
YCtoZlyTmqRqDxFcDzm9aFAp0m0GAw==
=zj60
-----END PGP SIGNATURE-----

--c2sj7aDPXOlTZxXv--
