Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31AC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 18:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C28740A4B;
	Thu,  3 Sep 2026 18:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bb4aPCytHvAr; Thu,  3 Sep 2026 18:33:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5A0C240292
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788460410;
	b=oewLCSAEWyrTruU9JGRyUdWOriQVucadS1nJH+kQ/OQ7v3D/LSWPi3XJ8XjCtm4Pb2Qa
	 BsICyJ1qhQ1oaN5Jh4gon0tepbqWbRVZSTkBgq+9BGTjnBGReNb5CroizqrZ40kVNhz7x
	 ZeVVLx8UD5SXDVu4ic/UYMlmHynQFt8yCIH4r86lspo0bIgTjZxJ/r4gPMIZ3SKRhv2UI
	 hFO96aMZjlMlMVh0WZsvqVxQSTGPzxD5Z0jVTyyFtTrh0ywgPIOpFSWBS6uTs29sUT/Uv
	 nMS14BL6aw86MfZAEPdYhXSXX+tSnbbTlbeBx6d0qgI+EvDGA07pAfDX6HGw2XgEefw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788460410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HnESHFTEu7Uy+GfmpDxOjEawuukjePjab4Bd8bUccUk=;
	b=H3wH1nerEgagVAq3oFYlF+iTy5l2v8c7Vu5+GvzMmdtaIpZm3muRP+T44kOxxXgd6M94
	 b58uhYSB1mxuzy5m6eGw0LIpNIdO0Y253A5rmqNV2cU+Z6grPB37iuHVq48qcS+Z3/V9c
	 diKOV3SiHDXgByJXcYLNi6LAxZb8v5rDPa4Ek0G/s9JU9onUFRKfB9uMLFE5Fn2tVtppu
	 d4lUl0ybWMr22FfPbCKdPBf3jqzQuEOd+6GReoCNmjpe+JOGIHzDiUEwkmsUSIiqtP61T
	 yRsOI21jf7s1YQU3cByVA0zh/4nUvS8Nn32e0vBAP7a/BP9kEnaYe2kThhVu0YCnMDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788460410;
	bh=HnESHFTEu7Uy+GfmpDxOjEawuukjePjab4Bd8bUccUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDQ7+np/Vjn+A6DX6eaTJlPVRwvpjTMyDUKxpY5efdoHo/LZ6F7ATxP+TMvpWQckC
	 Un/o47qzrkscfdJANhk/1/MpHfxOfq8avZ8sYwpk8lYwJ3oy1QzJyKQs5lBZ3XXTi5
	 0i1w1oZngxwNU4kYvFjxgR++UoQDVmCIWWueg/vpd2gKbce7xok9tBzxqWtvBlgBb4
	 cIHsb0/epKJoXAA5qrjfxACkmnrJHx47U2LQ8d2xx1Z34MaXzHLiV5STCCJFiED+1t
	 8YWfNWcyOT6uLcYTvqVKMD6gXxSTb7slXzEVHJujcRjzDVOnZ+l3F95qzc21lKp4Rl
	 a0DzN7ZHoITNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A0C240292;
	Thu,  3 Sep 2026 18:33:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45375279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 18:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A0D380F5E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 18:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twViXoKFAzF3 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 18:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 633F080F33
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788460408;
 b=CowoSfyMWI92BTzPatTD6Yau8KR6lym0ULgO8OAZ2Tzh7RzZD8wXC3uyOeYVfqsHR41f
 XLfuHO9JPgl5kmh/dh+QFVTqpnuw2oe4s6JvLRCdZ/VCxYFs44aSLB/0WHSMPn4riTlIE
 G9qx7Kt/UE+SC9xItnT0juSOifadBjCMDm6dRlSgqEd5CbPM1SDhNTSSDksB6cFLaL2wO
 PPEDT3MM8s8f6zt47DnP0l5TOKDNW/9a+zDK6wuwSXNwCKMiMUyNrxROWgomKUbnkMblb
 sdE8j/aCBtTlqOeYBsngHFnZAYYZ7Zs91HP21BxdlfhMq4xpJAIxjJYDBtUUs8Rr8Vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788460408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=HnESHFTEu7Uy+GfmpDxOjEawuukjePjab4Bd8bUccUk=;
 b=nNEYhb1f24jfOLn1xQN00iudZIFPcs8o8cyEw9LyiJbglAvGwh3yTeaGMre8oHmo3bAI
 knZrchYUwR7Yqdj85NolteOzPnfBe52hkK9+fMeYVgMZG47tS374rfOl+ftcRF3TzkyKA
 60bh/3efMaWfrGeAY5mTLqb8mWdWbySTmay9WoUpcdS3xT7aCYImp+xZ8cofDQvo+X32H
 mx1+DC9j/2fEb3a5LSL3V7xe9R8iEObTtMYJePxt+FMloAPz+bRWIGWoTSns43gOAp/76
 vBoOEEWTLFz6Y1gMtwgwA7SFPBr51rnTG6w4983BFpEiAW61CPy4nF7McwlJqSu39KA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=idgeJUve; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=idgeJUve
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 633F080F33
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 18:33:27 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4b190cdc9feso159731b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788460407; x=1789065207;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HnESHFTEu7Uy+GfmpDxOjEawuukjePjab4Bd8bUccUk=;
 b=idgeJUvexRq/YQjdRUVzsYdtXJy8fF1UAHroF5AVvAkM2qdCmpm55Zs5D95/RY91lA
 cpcFlEEm05qfO3l/DjriPguhFvyiudGPKTLHKyxumDovacOPwlTLommd0HMUsQ6spiVz
 Mg6MYwhWBujZ7YiiKVhvjmc9zgL1M0y96KB48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460407; x=1789065207;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnESHFTEu7Uy+GfmpDxOjEawuukjePjab4Bd8bUccUk=;
 b=s8gBEYuUlyYPi2VMhbLCIybGE6KEHhP7tRqY3HJII3oNp0nDKl4YhgZOmrCI7ns8u1
 4JfdB0gwtfpbYIW2weToe6nTBPoosC3Xrhm6ycf4JYlMAZokSojuwDMkSPL28QgY9/FV
 0VAAfbhUo00cV6GGQ2NIhVvWsSHBpux4GynmYp8XbRzvZibCEaffGDCtoMJpg4f4eMri
 oA/ys7CHq8TU//q0L3tl5ZZ3J9NhroVw3qAF2j3vvLcuBIyp1Ad04FmGO/+U/UDXI7rW
 5Y02htrsQwvZTPv8U2DD7S12pDjdcElGk6q2vC7wp2/PsUswBOZjAsPzszshvEkdNmvk
 1FuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDDgbOVIz3BDhmooQQpXQHoxF969cdkl0h/8ILEoPgD941WPcBy0hxch2UEsSwEZ0wJBn2JQY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mKFPR3GcPOGgQeyWgzBEmJ8f48EnoKXwMcGW4eMq14sS9jHVc4
 fCIW0/w7lnYprcdbJZTBNTEHpd3ghKpOldD9UFyJiBIM9k+/VoR0h589HaMN90856CI=
X-Gm-Gg: AYBFou1JtpBEN2bc9UDLM9m2QLHfOLJFiYtKe1OXIIaNXbTwVWZiZ2CdNvXUOBHjA5y
 KT9i34JS2U7cd7YBAdZyxwfwpLGsWoQsffyCO06RzndH9Zp4yuu0Bk7Y+g3nT82FMZ6gM5d7i3q
 OnpGBhqFBg/TwuwHCJ9ejNpch3KSMtnGBCmT98FKg3Y9ty6FzVgbLvnuUzSwiMKgFmn0lFX/77H
 +45XbRojk92KYs9KiamR4DHRniG6xMs0TFnFR/XViSOCUxaXZH5M7dZK/GeyHr6+vXAAcS6PGPT
 rIOLrqUNj+AjTWMUlvdyOMrcnz1IauQLE6V/aSiMvwBS0cb9Z+2FTWErNVnQydTwZGwo0ikimhd
 /NS4uoeBYGLzBj3jxl3KM27Q46y3HhCubDBJJkL4irZQ5L9udUi/OwgyNK2l0yxSg8WL4SJ+xLN
 SjCsxx42fg1k492SPOXPbz4oWSMwETKctmZ4zVJErO0NahT88dPa7UlCRGwG/VcKhwn7E/93S68
 e63f0KuZuY1p+fQ9KSc5iLHtgOCmGESknUxpMQG84uEwVNI3PnWpGs0XTAGGZSfuJpGnOtWuuO8
 qgGq0TxxcQ==
X-Received: by 2002:a05:6808:159b:b0:497:da47:df5f with SMTP id
 5614622812f47-4b9623ccb8emr345471b6e.17.1788460406591; 
 Thu, 03 Sep 2026 11:33:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69bd2638csm5943099b6e.18.2026.09.03.11.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:33:25 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:33:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>, marko.makela@iki.fi,
 jonny.green@keytechinc.com, simon.glass@canonical.com,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v9 05/15] drivers: crypto: add software ecdsa support
Message-ID: <20260903183323.GK1764417@bill-the-cat>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-6-philippe.reynes@softathome.com>
 <CAMDkj5yhVhSZtV4z+=Vy1qdTO9zh5p66UyM0QsGNnFA7xOkxPw@mail.gmail.com>
 <CAMDkj5yMzQJLPsGrbLHDcpoYK1no2etBNTN3htetmNc9E0wdnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f+CJtH7OYiy0ElMM"
Content-Disposition: inline
In-Reply-To: <CAMDkj5yMzQJLPsGrbLHDcpoYK1no2etBNTN3htetmNc9E0wdnA@mail.gmail.com>
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


--f+CJtH7OYiy0ElMM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 11:33:01AM -0400, Raymond Mao wrote:
> Hi Philippe
>=20
> On Thu, Sep 3, 2026 at 10:32=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.c=
om> wrote:
> >
> > Hi Philippe,
> >
> > On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
> > <philippe.reynes@softathome.com> wrote:
> > >
> > > Add a software ecdsa driver so it is
> > > now possible to use ecdsa signature on
> > > board without ecdsa hardware support.
> > >
> > > Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> > > ---
> > > v2:
> > > - no change
> > > v3:
> > > - add depends on ECDSA_VERIFY to ECDSA_SW
> > > - change sw_ecdsa_verify to ecdsa_hash_verify
> > > - v4
> > > - use ECDSA_MBEDTLS to build the driver
> > > - clean include (change order)
> > > v5:
> > > - use $(PHASE_) in the Makefile for the driver
> > > v6:
> > > - remove include u-boot/ecdsa.h from ecdsa-sw.c
> > > v7:
> > > - no change
> > > v8:
> > > - no change
> > > v9:
> > > - no change
> > >
> > >  drivers/crypto/Makefile         |  1 +
> > >  drivers/crypto/ecdsa/Makefile   |  6 ++++++
> > >  drivers/crypto/ecdsa/ecdsa-sw.c | 32 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> > >  create mode 100644 drivers/crypto/ecdsa/Makefile
> > >  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
> > >
> >
> > Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> >
>=20
> Sorry, there is a new line at the end of the file. Please apply my tag
> with this fixed.
>=20
> Applying: drivers: crypto: add software ecdsa support
> .git/rebase-apply/patch:89: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

If there's nothing else to do for the series, you can fix that up when
applying. A v10 for just a spacing issue is a little excessive.

--=20
Tom

--f+CJtH7OYiy0ElMM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapm9bwAKCRAr4qD1Cr/k
CijmAQDbpjnKqDxPb982qRqzutPLfbt1RxeBnkGadZOw7J1cmQD+KoGWYCu6epZG
Pkmfb7RdKg8D8mPJJX0nDStBfSvdjAs=
=tp4P
-----END PGP SIGNATURE-----

--f+CJtH7OYiy0ElMM--
