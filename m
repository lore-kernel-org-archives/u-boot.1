Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D79C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 16:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A0BA80F2F;
	Wed, 22 Jul 2026 16:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4O-HyHqjDl8f; Wed, 22 Jul 2026 16:19:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCFFD80EE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784737155;
	bh=wjkn+Pa97WGFcrGOUEoaTJm6SaF22hmASMvzlPZyR7s=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=B/Xsiavc3tW2sywrGHDe1SqVoPqFcy7QuXbjcKe+qgSqL0mjpWz1sPkObR6Bf3QAY
	 5gF4ow5HPd3aB/jrqPGR86kXVBi5k44YU7lm5IX8CimhdBVEi9u5DwX+258BECzMwp
	 8McpcXrtU5wyTB7lnkdHG843XxxStLXGQr9VoTJPdNjrvWg2G16C1bcGohqSTAK/oV
	 JU+9ciyIpeMVQCz1w1vGJO7J+YUkG+wy+KrBgSA3N7WcF/qSi3xP4BveuRtdbIRsc3
	 bkL7wyzVq6pcOKMbLOiRSRaE+1+4EwFEm/IaksEkqrd4gZNo/sCqYIKYgV4KhNpk8T
	 rHI6nE3YBwZfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCFFD80EE7;
	Wed, 22 Jul 2026 16:19:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF165390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A170D605D0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QjqiJZA0UAth for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:19:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C8549605B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8549605B7
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8549605B7
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:19:13 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a379b68f76so4995700eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737153; x=1785341953;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wjkn+Pa97WGFcrGOUEoaTJm6SaF22hmASMvzlPZyR7s=;
 b=J3aEKLjKpu/njzLZFO9nUZyMgvHsypHv/r9enD1ptUmVtB7Vr4GjxrbhOR/LK/tH1g
 ZRYtR1MY/gqjPgv5SaC2JYgCJ9M38e4rXP0rJdhh3KrURUEu0wgwkhg/uswEiuOyWtaE
 M3T+9stncByivIGljonX0YPJvM771r1+4X2SuyNXuBRhZnc+0m2S5VBGrHo1NNqv4viV
 6nTzrtLBX9NbvAS3gnU/wbOIHXG5UBGAruEnHbRjSNQ4HzCsisv392rETAaEixQUnvHD
 f6EuXKyC73B1hvOT7l8ndlrFOAjG7UPyi2FnKNxpF5aOrqk7HE8KqiPeWTDKRiIKjY1h
 Q5MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY4yBx+PcGmDRDm5wWmarCvKFyIGrV22Vx0qjqzOsaQCvrgfzOaJ2UvmuwWCKrC5flPoTITJI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwqFzRj24FhFctsDd8/LFgbQZItEKlpL1ME8KRB+npm0tCxqPFS
 dlWOklgbvXz6Ox33qPpOOyNP2eQMMQOIm56I8AKEAu6mZVBlqwQnB5NVE7lJdNicByk=
X-Gm-Gg: AR+sD13Njd9bzhVhe+88uyQgbBEH0KS/5MaX6FiwJ3ze0RWS9KqP621XlMV79nig+x7
 gzS3oncqIiUMP/KZjDpDTCoDU9GLSatzyeEVCMyvmnmeMvkx0gHq5Whj/2Pk9+upH7pvakDbu7U
 bluDcKopE1bCk4BqvwOc+YI93miqYFsgMJTUWIk97xLPj2bknEwYg1N6LWhXzCO6aLDcctb1+Gd
 6gY3WHydfJpi91oK1WVhuBmmreMI8sl93O+gyQ+UEDow4aUBYvm6V/JO0XwFDrlXcLJkstArqKd
 jPM4HKJDqCjnrmaNps9zjHqhWshlt3E7dSwvlB/0byK3BDnlI7l104nyrob5QzCbZURweydOmEe
 Fy6LKEeMwxo4yBqbraTxSa4/PmOK5jU31HFn/EVKv3U0BbDGYaBsaV6+zfEQTamnuith+m4Qyv9
 5vyIgR8iU6jd8y7eUVeMeG3Lot65O48al6CDweqTXxUiA4A4LcTtFELIH7NqeKHfbNeL2uGLVUq
 2DKcEghr3XTUuqKDrNNFxMZN5M=
X-Received: by 2002:a05:6820:4df8:b0:6a1:524b:1f5 with SMTP id
 006d021491bc7-6a5368375e6mr11903222eaf.42.1784737152476; 
 Wed, 22 Jul 2026 09:19:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45767488299sm2362483fac.16.2026.07.22.09.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:19:11 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:19:09 -0600
To: Michal Simek <michal.simek@amd.com>
Cc: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 git@amd.com, padmarao.begari@amd.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/4] i3c: dw: fix slave device setup and probe issues
Message-ID: <20260722161909.GX749385@bill-the-cat>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
 <5c6ba716-263c-4a79-aaaf-ccf714050b75@amd.com>
 <d0788bac-8527-4236-91d0-476479a92fb3@altera.com>
 <853abbc7-4f45-44f4-a935-64cebb4479e2@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I4K81DnvMZnWh7vB"
Content-Disposition: inline
In-Reply-To: <853abbc7-4f45-44f4-a935-64cebb4479e2@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784737153; x=1785341953;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wjkn+Pa97WGFcrGOUEoaTJm6SaF22hmASMvzlPZyR7s=;
 b=ZbsLZfsm0sVyPYS90OqBv/0oDziHBnYgeg3v+ILvDdhx/ZOy/sxiVpKPqmYEy4711O
 zGmyjgySxRAWi4s2JdrOsdg+bH76qCYPLTIUHkEvWI3D3sygqdrXxbJpO06cHdIq2G1H
 /C3aLv0WgCN74M8SDrn+T7PLHIlJQiiBXYj/M=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZbsLZfsm
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--I4K81DnvMZnWh7vB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 07:30:44AM +0200, Michal Simek wrote:
> Hi,
>=20
> On 7/22/26 05:56, Maniyam, Dinesh wrote:
> > Hi Michal Simek,
> >=20
> > On 21/7/2026 4:07 pm, Michal Simek wrote:
> > > [CAUTION: This email is from outside your organization. Unless you tr=
ust the sender, do not click on links or open attachments as it may be a fr=
audulent email attempting to steal your information and/or compromise your =
computer.]
> > >=20
> > > Hi Dinesh,
> > >=20
> > > On 7/9/26 11:12, Pranav Tilak wrote:
> > > > This series fixes several issues in the DW I3C master driver and
> > > > related infrastructure that prevented I3C read/write operations,
> > > > and enables I3C support for Versal Gen 2.
> > > >=20
> > > > Changes in v2:
> > > > - Use -ENOTSUPP instead of -EOPNOTSUPP as the reset stub in
> > > >     include/reset.h returns -ENOTSUPP when CONFIG_DM_RESET=3Dn
> > > >=20
> > > > Pranav Tilak (4):
> > > >     i3c: dw: make resets optional in probe
> > > >     cmd: i3c: fix list and current needing pre-selected controller
> > > >     configs: versal2: enable I3C support
> > > >     i3c: dw: fix slave device setup after DAA
> > > >=20
> > > >    cmd/i3c.c                          | 11 ++++++-----
> > > >    configs/amd_versal2_virt_defconfig |  3 +++
> > > >    drivers/i3c/master.c               |  1 -
> > > >    drivers/i3c/master/dw-i3c-master.c |  7 ++++---
> > > >    4 files changed, 13 insertions(+), 9 deletions(-)
> > > >=20
> > >=20
> > > Dinesh: Can you please look at 1/4 and 4/4 patches?
> > >=20
> > > Thanks,
> > > Michal
> >=20
> > Reviewed. Thanks!
>=20
> Thanks.
>=20
> Tom: Are you going to take it directly? Or do you want me to collect it?
> In patchwork it is assigned to you.

I was about to take it directly yesterday then I saw your email. I'll
pick it up today.

--=20
Tom

--I4K81DnvMZnWh7vB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamDteQAKCRAr4qD1Cr/k
CsFmAPoD1qB3xmbIJay0yEvGkzBFsdbnZ8wkqevr3Cd8V8aJmwEAvk6rXx9Wx0Zg
dkFcOxn1DOOI6w8GftNoTjH6OgKzYAc=
=b5Hu
-----END PGP SIGNATURE-----

--I4K81DnvMZnWh7vB--
