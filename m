Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A41C5AD44
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A5BC60678;
	Sat,  8 Aug 2026 19:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEsbnEJc_5Mo; Sat,  8 Aug 2026 19:19:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C0AF6065D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786216781;
	bh=ngn3IOED/nEkCdSNas6La3EO2QENBiyUpBOkuSauKUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E4Aa2Oyv06iOTeuMTaopMl1czKJ7QPVPn/u2CRZhBEUwXnwtvKSKCVRfrC9D9NyGg
	 qtr4kbSjmgJa5ihLqIB3QVbKmtcftfZ/uJYvQjNAVyBhWrDKfQ+GKbjyaoevPJc0Ka
	 4AgMhyghGMcaChnVviJqLJq5kOlVrDM2qTga7fYeJOXt92tOm4o5c+FWK2WMLvwVjt
	 VCSCu2nVEKLYZ72KOsKX8koTijbpMirp8j43pIGI2qiWpOsKZfAOs0xTaNDewaWrVq
	 7OBwoD4vaseugx/KmbsqmR0h0TTliXvi//T23uMb2KS0m0QzGGMNeimJeL0bIytXZK
	 wRH2OSn+OCRVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C0AF6065D;
	Sat,  8 Aug 2026 19:19:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3971E10E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B29680BC4
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAZ4eK_cVRSd for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:19:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1F7DD806A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F7DD806A9
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F7DD806A9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:19:39 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb63dbd229so461654a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 12:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786216778; x=1786821578;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ngn3IOED/nEkCdSNas6La3EO2QENBiyUpBOkuSauKUM=;
 b=cNvA8iIoiZM5GEcJz/ykzCrIT/j0UlwCmA9AvttPfXH865g2+gsY+n3a1+2sEsm15Z
 XYin4E0G7U58mfnnjnbGO1qPByXPzQB/rZwDACDGMWJPNmufiaT4UuRZ10x+lV2U5WB9
 F8sSOEa25VDv2FE64qGeSMA4knExYphSG5QarXwYdzTpxXujfKTHqfrBzIJ1WHhzaBpG
 x880XM1rM4WDIKiYU8AxtZr3UCKRHP9Rpi13ZD25Pdt/fRzlDT3DZWvisQ6lR4Uay4BR
 NPoKN35aedKHDmKTDm2Pkkk7FZxWX5kC5okczpRabeaEdpfZQTSCAMFRoXfyrK6c21Yq
 SlcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoswzOOgQ0IQoKX/B8S6uuonWrb1V7kUTGO6B8RAYs7TKrVSkwmeJ/e/syTvuB/wTWO3TAQznk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy2kHSSYa5mUhUOIpio+rM/z2qZZv5LHzrPE7TP7hU2kMnAkbfz
 WMAbpTp0A+FJUc2ux7As6760YVcowFZXIddM4Fn4+hiFUyQqjCIMPLsu1d8KdTPO/xo=
X-Gm-Gg: AR+sD13ocG/s5FiamNOjpU4U5jdSuhQa7mKB6I85Cb9pUOK9LuXS2hM+wpWeKpccSQ1
 2nFeafO4fidlTZBvMFwMKofehRJEbEQIFD3q2uGn1wFr5kTdkJsu+kuo5e/BuxyMHi9KcfThJst
 VJf14ZTyWTJO68earbcuPFsWzAGHcVsRkPq51KQyLQn72pomBzdrbdjt5uSbMqprzaU/4ABUbhM
 ezhbmwPKiElv2Y0zarrJlnR1KrSC6QRIkviQTVKDmGw6JzgPi97JDYVeGjt17xbCZdDKbFFcca+
 eUde9uBxMjcQHkZDmfn5fZ0MPjJyYcr50mo25ma3EBExwuJaFdkjj/Ze32CWTKq4qVeYEnmk71s
 s1haaaUk+aMlDIy3e/py9HuKGh3SlIICgHuZSuZ4YIVFHG2tARWgVIU+6ZzVI2ioNh8IXImhtor
 LxjLkjhKORgmyzkbYIadAy+AgZvMcPLy077IYJJIrj6jAGG4owGajOobYgAZH03aXHubtBPAIXM
 2tvXtweAQ8lWtP+auq+f8+9LNh9WWX///zJKATwa9V0hyjUUWeQQD0cfnGkwqu+0U/NWO7G0Ecs
 kEQyixfE4A==
X-Received: by 2002:a9d:6c97:0:b0:7f1:e04d:fc4e with SMTP id
 46e09a7af769-7f36c10f8a4mr1547490a34.2.1786216777951; 
 Sat, 08 Aug 2026 12:19:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7c4ba7sm3909018a34.23.2026.08.08.12.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 12:19:37 -0700 (PDT)
Date: Sat, 8 Aug 2026 13:19:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
Message-ID: <20260808191935.GC394392@bill-the-cat>
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
 <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
 <20260808181058.GB394392@bill-the-cat>
 <CAKTNdwHED5XzQc4vQX7k_R-+O_0ae3q__w-tG5mfViPgBXW67g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qxMVdivAdiEyTNIg"
Content-Disposition: inline
In-Reply-To: <CAKTNdwHED5XzQc4vQX7k_R-+O_0ae3q__w-tG5mfViPgBXW67g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786216778; x=1786821578;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ngn3IOED/nEkCdSNas6La3EO2QENBiyUpBOkuSauKUM=;
 b=R2J+V1frJGJ1erX6nmTAONaGTZV+kpO78SfXMweHt/fAQOcmpRuUPMrN75u4wPgMiC
 1gCUZ7fh/CwtteYufMrw8DIzfrADwU3917rJx0a3/mf68vYXPqefaJ//g2Mx+2H9hQX3
 3OOzTW0CD7t2qVq5SB97AWI33UJRj1Vrj6MVc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=R2J+V1fr
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--qxMVdivAdiEyTNIg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2026 at 11:12:47PM +0400, Alexey Charkov wrote:
> Hi Tom,
>=20
> On Sat, Aug 8, 2026 at 10:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sat, Aug 08, 2026 at 01:02:02PM +0400, Alexey Charkov wrote:
> > > Hi Simon,
> > >
> > > On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Alexey,
> > > >
> > > > On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrote:
> > > > > pylibfdt: Grow the FdtSw buffer geometrically
> > > > >
> > > > > Every expansion copies the whole tree into a freshly allocated bu=
ffer, so
> > > > > growing by a fixed amount makes building a tree cost time quadrat=
ic in
> > > > > its size. This is especially painful when assembling larger FIT i=
mages with
> > > > > binman, as it assembles the image with the data inline.
> > > > >
> > > > > Grow by at least as much as the tree already holds, which is what=
 variable
> > > > > sized arrays usually do specifically to avoid such excessive copy=
ing.
> > > > >
> > > > > With this change, building a Rockchip TF-A+Falcon image whose FIT=
 carries
> > > > > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itse=
lf down
> > > > > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The imag=
es
> > > > > produced are byte-identical and the binman and dtoc test results =
are
> > > > > unaffected.
> > > > >
> > > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > > >
> > > > > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > This is a _shipped file from upstream dtc, so any change here will =
be
> > > > reverted on the next resync. Please can you send this to the dtc
> > > > project first (see https://github.com/dgibson/dtc) and reference the
> > > > upstream commit / PR in the U-Boot commit message, similar to how
> > > > a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvement
> > > > will be lost.
> > > >
> > > > > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> > > > >          if check_err(val, QUIET_NOSPACE) < 0:
> > > > > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > > > > +            self.resize(len(self._fdt) + max(len(self._fdt), sel=
f.INC_SIZE))
> > > >
> > > > Logic looks correct - doubling gives amortised O(n) total copying, =
and
> > > > the INC_SIZE floor keeps small trees from taking many tiny growths.
> > > > Nice measurement in the commit message too.
> > >
> > > Merged upstream: https://github.com/dgibson/dtc/pull/189
> > >
> > > Shall I spin a new version of this one to mention the upstream commit?
> >
> > Yes please, and are there other changes we need to merge in from
> > upstream as well, in the pylibfdt portion?
>=20
> I've also added public accessors for address-cells, size-cells along
> with add/delete methods for memory reservations, which David merged
> earlier today [1]. It would be great to pull those in, too, while we
> are at it.
>=20
> They are useful for the Falcon mode via TF-A series I'm working on [2]
> but haven't yet posted the new version due to breakage in am335x_evm
> which I am yet to fix. I could send them together with this change
> here as a separate mini-series if that works (i.e. ahead of the Falcon
> changes which rely on them).

That's good to know, and yes we want them. But I'm asking if there's
other outstanding upstream changes to bring it?

--=20
Tom

--qxMVdivAdiEyTNIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaneBQwAKCRAr4qD1Cr/k
CrUmAP9idZQB+75wPjRt9wa7a5ZQLCxfg65ILdj8GipRaJm/dAD/d7lP6uGv/RA3
qOQVuvi5HPSBKmLVZR1v559EXjFCaA8=
=Tf3c
-----END PGP SIGNATURE-----

--qxMVdivAdiEyTNIg--
