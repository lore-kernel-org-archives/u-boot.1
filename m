Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC36C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 20:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 834CA80ED8;
	Thu,  6 Aug 2026 20:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hh_whMscM6KO; Thu,  6 Aug 2026 20:58:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66A5180EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786049888;
	bh=C+/L+/L0tZILt4P4CRKVtsUh4pq1N4fSJ6jKxbjEvTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DjYqfuUksfEodtUibO3p321PJKrhE6bshXmLrWma04U9C/JKLuuEvssjlvBuN5l0Z
	 XEGf7/OLFq9DpzeBiNIE2fnhsznhlsJxALN2EZjcJXFKTa/r3MU+J6dKvd2sraDTdX
	 EdLiFYZMWlj0kfPOaoKEop6d4sbUikBRyLTaHoc7mGkmDnR0xVmbE3t5W1pKb7sIrp
	 w2gec3XcWCYTrStzDrWzMYh3iIohZSxfxadCmvO5GsXKGkXTQA8nCBC/rTsdp+lEro
	 nwTCXRG45buz8r6C3aWLKTMnix2MPTH8Fm3zfBODL4cjl4+/628JWIY2DkR7wxsvzy
	 +4REOzk5ZlQWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66A5180EA1;
	Thu,  6 Aug 2026 20:58:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F312A28C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E52106070E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kv7KJFGUxS2e for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 20:58:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 38BC1605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38BC1605CA
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38BC1605CA
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:58:05 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6acc74fee76so1136513eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 13:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786049885; x=1786654685;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+/L+/L0tZILt4P4CRKVtsUh4pq1N4fSJ6jKxbjEvTE=;
 b=P7HwWLAYUeUcPpftaBMVKFhAelQfDIb1uAezHAK/yWgAk8V/ChUIbL6QNwLeY42hET
 N0vIRBnamWzThAsO3BXwoYgejD1URArg/1pPffEe62zsSkagYsgMK3s7kQo0QHuOgoVG
 Ncksk4YCB3A5HcI+rHaXRztoUdxvzccowOHLDKFdXygHOSiMHNSIUnetEA5UqG8iwKwu
 N6UvJ9MTeR9OU8MsTm7mlJeGbrh8q5Ckls6KY8XmRF7G+2SO4n6kX+tN7IZDDnd6lcRM
 5maLjI9PQYPQzb4s5SCzdzZTu06XSB6U1v9jPaXqvTt6hrtq4RNanwCOxk13mc3qmKIs
 6BJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpkd67t++EQiEvfi/JX9TBh2jHESlMGTKya+aAsxZiE1FbqXUwAh1hydFqzNoYHRbD9aka4ZJI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzed8Hp868uR5INEN418B/SFynl2guMkC6bbadOwMAKmz0GPMfg
 La92C0Bwt8aLJYD1XZocQn/bY/I53VjoG03Wf8goq2jVr5ee2vvH1QAQHjB2R5hHW73RI98yxlg
 ZIqu5
X-Gm-Gg: AR+sD12oZjdMLZfONOc7V9HuAhsZfYhVezRU7SvChsRYjyPRlv6Pns3e0xM0Z1bA1cv
 CuOediTuhdrWNLIew0SIuEbAiwq7J7s8raiapwLGkDIKwNSbtJyTlTKC1+dMt24qa69gyvRdMba
 obgtQn207Xe8cpKpKyDEaTKBC/MFi3pvH9eKUGnhVfdMtBOWtZMSefJm5lXFCtKkSA/hi1cEsSE
 1qjLRMGxKLXhseSi14BC7RjFS0dRVbYlsQklBEZf8YBoa9Hh+2mXDZy/M08YiAxeZv1TfelTZTD
 EpN1C313BVbdz2RGKvwLJs2zt7RNuZHEkOO+lI48Hfqs7skRpx35m0BG86h+CQU72n/CQefstjI
 lnx6uZvGO86IBv7boNAFmQ5PB/wLoM23GK7wtvlagksDMa6tIhjpAZF7k2gqGfEJhkcHEeSj7/a
 dyZfz+5DIndZQzuzguqZZKxsx7HWUcOwZtt8NV4CsZbzekP2F8u8tGznI4wuyYaixfPuM+g/xNU
 1dQPdp3Ei/ox/+6kiLiDUgQQyOc1DxJxkgLxLsBBERLr4Pon5nEL4PStfgrEKE4CNLnQyK+4Z7h
 EeNxY9e/Iw==
X-Received: by 2002:a4a:ee87:0:b0:6a1:82f5:b009 with SMTP id
 006d021491bc7-6ae96cbf078mr9569623eaf.13.1786049885012; 
 Thu, 06 Aug 2026 13:58:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be9294fsm472474eaf.13.2026.08.06.13.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:58:04 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:58:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Subject: Re: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
Message-ID: <20260806205802.GE165443@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
 <CAFLszTh7F9K+NqyOxSzs7G_+MgNURFrLyGuK3WJhdNndvwQZpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mP+xfEiGBmYYm8gf"
Content-Disposition: inline
In-Reply-To: <CAFLszTh7F9K+NqyOxSzs7G_+MgNURFrLyGuK3WJhdNndvwQZpA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786049885; x=1786654685;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C+/L+/L0tZILt4P4CRKVtsUh4pq1N4fSJ6jKxbjEvTE=;
 b=Tbj0/DcwMNoxHyu1v7gDMd3R3mstqizos5I2ZJLds8K8rudoQ4J1hbRKnOTIN3eiba
 fe0awoeb2g1cWCiDPMsuwKY+g52p3h1J6wBBccJ5OWc3hDfyBgY2V8QZ+ffY4MtqSU3P
 H7jRGH99rcPDTdQprkZM+zkxdKNu8PAMPEVe0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Tbj0/Dcw
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


--mP+xfEiGBmYYm8gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2026 at 04:03:58PM -0600, Simon Glass wrote:
> Hi Dorde,
>=20
> On Thu, 5 Feb 2026 at 06:06, Dorde Stojicevic
> <dorde.stojicevic@rohde-schwarz.com> wrote:
> >
> > Hi guys,
> >
> > and thanks for your fast response.
> >
> > Sorry for the formatting issue, I am bound to our company Outlook, whic=
h hard-codes our signatures, so this one will not be possible to take out. =
I am not quite sure git send-email would work, for the same reason + corpor=
ate stuff....
> >
>=20
> Patman supports the b4 relay now so you could try that. It just needs
> a simple registration step.

It would be best to not confuse things however, and just use b4, with
the b4 relay.

--=20
Tom

--mP+xfEiGBmYYm8gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanT1VgAKCRAr4qD1Cr/k
CtWRAP9YERL7mHljbteXE75sRLteCieTxqgUM+BpqbGK4ELDXQD+KpD1XS/fi7xb
pvwn9ssdFulfJL0X32pmPlShQqNwhQM=
=ZdjO
-----END PGP SIGNATURE-----

--mP+xfEiGBmYYm8gf--
