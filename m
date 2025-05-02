Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC059C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6E2820E1;
	Fri,  2 May 2025 16:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VD+gn4lc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80BE81F7E; Fri,  2 May 2025 16:10:30 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFA4820EB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c1425fbfcso1482321a34.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746195027; x=1746799827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cK0xfMykforlbf7nTEGdm2wXkZF/Pbw+pfjUwZCEsLE=;
 b=VD+gn4lcucKgHRaHxyzEhCwXMem0ys5fm4s2xDhio4sI8irRjghA6Z2kgIm36iZXpG
 Gp6J9i6g1IvkqyUHKy0b+JEFDhn67A6E6VOnpu+qqOf47vig0kVLH43+1aF8D9X9jTM+
 +JzUsQiJz9ex9+D/v6aP0dSeI8rJu8jnsnNbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746195027; x=1746799827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK0xfMykforlbf7nTEGdm2wXkZF/Pbw+pfjUwZCEsLE=;
 b=G5TSZ1yROM4hR9xcCtfMz8/GmLcMNLKwjY5OnahhElu26MvTsALT7peiR3rW+ApAIH
 /xj2Ca27Y/apkquUIOJGnQbWEX2g34YjPI4ZHB2TeyNy6XOgFpImp5v3gnl4PDiGwnCg
 abwJwGrqBRS1ubLeJOk1vTXdKdnOm9ljpZxibWkNpOl1PNBorkKiQwE/NKdjyg3ElZh2
 sYZQAQcIob9p0yRRMZTkKwwoXidJksma4Z3PcNF4VjEwEc2DdDGKcmfgSCzIsH/o5GRK
 ZBuZgDd8T16jAqVb+TKLj3BAADnnDyxJssv/EZQe9v5ewf/WTNSacxcQiHP7nM0G4kMP
 IPNQ==
X-Gm-Message-State: AOJu0YxFn1oMl7sKgHjCb8jBmzWQmhIdzr8xRJzMiFVJyAwTwTdzLDYS
 7slRYhWg9/2jGCw+w/fiCKkxYvIEqWnFnTWUCpqgOmDV632+Y3cZrGYvmn/RoRg=
X-Gm-Gg: ASbGncuRwD2Ln8R5L3BJjhp6RCT4zjcJzuC5zqZA3vZ4wzY+OPOYwn41pzYIW6JHO8G
 hoaiuRIqkHBNUqNKscYl4bTuu09OertJJhmXMV+ovFT+KkEC+Dg3W8daWsmvexxLyU8ERovE1Lq
 QQy2NaNjrBTu5Z0CB4kWsK4zF4qOkhmdhp13HWDKNmnQSdHnVHj8cd85QUOCCTxU5Jsnd5jUh0a
 7vWWkUSngXopeijamOM1HxuCB+c1GvCtHsvF5fU8qPKycYpt57iaRlhK3dzHgqH0nGu/RRga2li
 J503/zryp98G4a9Hz4tMdZ/gjq1lJzqtgBHHXhnqF1FVnrt0wggjxaCka+qwyk01exbSjd58gCY
 7soMB3DLT9ugf
X-Google-Smtp-Source: AGHT+IG7XL0Pbv3Ic3xwkw0iU4K1GSKFFWW4zgahKkNtPgaaSE2MjtBEL4GrJCfcGIOF7f5mM9GqUA==
X-Received: by 2002:a05:6830:2a14:b0:72a:18a6:d431 with SMTP id
 46e09a7af769-731da17a7damr1669528a34.14.1746195026885; 
 Fri, 02 May 2025 07:10:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31c71aasm484899a34.20.2025.05.02.07.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:10:26 -0700 (PDT)
Date: Fri, 2 May 2025 08:10:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] CI: Update the CI lab
Message-ID: <20250502141024.GR1261075@bill-the-cat>
References: <20250501012530.3954999-1-sjg@chromium.org>
 <20250501140354.GC1261075@bill-the-cat>
 <CAFLszTgKbsE0N1AEkwydiQQLMrMRNDtivQWVKmDsESYqZE-4VA@mail.gmail.com>
 <20250501153015.GG1261075@bill-the-cat>
 <CAFLszTjvaGLARFCGVODsbRL8h+dLg9Pk1SCV3RcrsC1SrvmTqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ugCc3rdmwKJAipoW"
Content-Disposition: inline
In-Reply-To: <CAFLszTjvaGLARFCGVODsbRL8h+dLg9Pk1SCV3RcrsC1SrvmTqw@mail.gmail.com>
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


--ugCc3rdmwKJAipoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 06:51:31AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 1 May 2025 at 09:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 09:03:15AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 1 May 2025 at 08:03, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 07:25:24PM -0600, Simon Glass wrote:
> > > >
> > > > > Update the boards in the lab to match the current situation:
> > > > >
> > > > > - bbb and pin64 are working again
> > > >
> > > > And were never disabled in mainline (since iirc I never saw them not
> > > > working).
> > >
> > > OK good.
> > >
> > > >
> > > > > - samus and c4 are still broken, with no end in sight
> > > >
> > > > Good to comment out.
> > > >
> > > > > - new boards for colibrimx8, rockpro64, rock3a/5b, rpi5, zybo
> > > >
> > > > Except the imx8 board doesn't work in CI in mainline and had it's o=
wn
> > > > long discussion that petered out.
> > >
> > > It has been fine for me.
> > >
> > > https://sjg.u-boot.org/u-boot/u-boot/-/jobs/49094
> > >
> > > >
> > > > Please v2 where you drop the line about bbb/pine64, and don't add
> > > > colibrimx8 until you or someone else are ready to work on the under=
lying
> > > > issues this exposed. Thanks.
> > >
> > > Do you know what issues?
> >
> > Yes, can you please look at the thread from your initial patches?
>=20
> I see[1], but I'm still not sure what you are referring to. Is this a
> board which is broken with your tree, or is there some issue just with
> the lab?

I guess you forgot the related buildman changes which is where I
explained that:
- If there's blob problems, someone needs to go and look harder at the
  imx8/9 binman support.
- Looks like most of the imx families aren't using CONFIG_BUILD_TARGET
  and that needs to be fixed.

> Also I was wondering why Nvidia board was not in the list and then
> found this patch which is marked 'changes requested', but I don't see
> any reason:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20241217210920.2050997-1=
-sjg@chromium.org/
>=20
> I marked it 'new' again.

Doesn't apply.

--=20
Tom

--ugCc3rdmwKJAipoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU0lAACgkQFHw5/5Y0
tyz0bgv+MxtyaJvF9iJC2y1Ou1Wgun3t+AuX6Airbo+CXcT+Na4MJZw2hlQI3JQp
HyuAx+Ng+UrxtbwF6iFPCUT6lZ9GI6fq49DcMUQz5kdBZWLeVnir+q2CRMQcpXlh
rFwmnUAYHx/g+RrSiPPi9v8TRmxtmiah+/Q3BFBYmvAEL0DsjaiTLyV6nwCwXxt7
zQ+qxBZNV8tLtSr0jlcPVqmy88M+Oi2ad45QqETzrg95Ccmc7UuydFnKzi0RVxYV
y8djGKALTuwi7pHMOxnyPvA9TXqFv+5txFo4bEtUMEXDx0gUf14HGvOVMiTRUDqS
qpqjRW2qnTx/6eICJJEk1KBZuoybOTgsV/w6lmiUcukQo12NgzgzBkHvEq6q7y7c
esEB7VBVUljhveP8ctBiuez8W3eS7Fqip1flJD4N/bt2B46npvu1jCAupTurtxI5
VCwYNnYIKtBgjwZgyDlpc7rL6TsJQeD7k16PeLyNOP08cb+EoSPgVoGKGoRuIv15
eAK+u4vu
=HDB6
-----END PGP SIGNATURE-----

--ugCc3rdmwKJAipoW--
