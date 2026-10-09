Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932A3CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 15:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2273560656;
	Fri,  9 Oct 2026 15:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGJPFBezAYM4; Fri,  9 Oct 2026 15:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70FE46069C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791559995;
	b=dYI/fHDM1L4rc3jxUzx4xdbCW1JX++8BWG+1uS0kU/nS0S8WzwBDiAEd+p40hZ1pI1kX
	 qsr1e8K0czGkFemeQYSpftOy4SengBtuCBUPXrRSL9pZySPk3PFuxG9cMfl2tUkxJjmTw
	 FarjqU+kPYH1L1YfW9tH/McIX/ylBfvsLw4PtGG7n5clgk8dcjQyYmaFrVlqGUdo1PQdz
	 w626/kWA5Ab3OXYpAxxa2luTEdn6Q0uy1dFDR6pZPXy33dQtMzZpUWLEKqRT9tMYJI3S5
	 WYrL78cgzwI3ej8WTiMMovf00bycIISgWT+WENt3km2R49beWuJ5QQO6klddFT+F/tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791559995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DcSNrXjwEd0WhRiUYMeTkleV5cLsCo2TKqE/7nz6oQA=;
	b=aYf9xRQ4OLvu24nHKQ5BQpZWZtUhCYTAUkqlfdSaaYxn5aJ2Odk535V+nAro1ZJf0RHJ
	 Lzcop/dQRVQFrJB1Tv5bsM6nhwejSoOPMW1hxUUOYJoox8O8jAgQBbvoL/lw0eFXC6gsz
	 E/hNhZpIdaGDn6deqGa835IOErkWzPsKFU0HM6uR3IdGs/w8UmCsjOnlMIGnJUTYnAc3x
	 0NZv2xKjIHAKHAFVyNgs064b9O1bCi3DYhIup0Gr7MYJGIrz/WvdabwhGFqZsVlLmYy1d
	 lqeeiC6ThLFA+u/HJOK/s54ATUKKC98TEEhW+n6VT0ndxcdd2GMiIIm0IQD4uNtxViw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791559995;
	bh=DcSNrXjwEd0WhRiUYMeTkleV5cLsCo2TKqE/7nz6oQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bb+jXJi7vMlswSeTFj1ZwKxrIY7Qp5GWkSThezXoJbK8jDLLsgfXDZnsUOruV04oc
	 3fzLTncb6aloWEkp27D7EHrPYXWKXNtZmj3VZ1Cr6PORLOiLUbhRRsf9TmWwFp3kkj
	 i8zAdykPMRpYjLRH49ohc/VFkcuonBXIq5FXIw3bwO3B8XRZL3kEYR/b4UO5HuYVuR
	 eoSOekD58meRViZL8ozLpwnqeAD1pFEV4Lv7xqqE8A7YYDIxGTW/yIc+bFwQC/VCZ4
	 r1hojGALMuNrfR9/Yv2Td41GdsWK7CWdt4dGu2ho5zCbjYWMFCVX/iSHviLwdhR9rB
	 zfZ3cxaOtOzkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70FE46069C;
	Fri,  9 Oct 2026 15:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B43541D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1E9C408A2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXnwfrL44I93 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 15:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F246D40888
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791559994;
 b=Y/hnJn6NfHgQoLxik/LJKga6133BUf8wfI48tuVrzBxKzeKpNIXuzkGslthr3ipfcxPj
 6SfpTu48ZqRUgBR2wBKiDdNgn++9197V3zjzjbwkFd9/oAvCxkYlImT3PGo9IF/fndgz+
 ibmWsTvsspv9VJRcWs5w6MK+uuTO9QmPbJ2WvaKX3MYl2z0ONjdUBNr4U3oAb7kHDuQkr
 s+5KfG4vB3TOp2Q6Lc2Ihr49CTwvwcA535l/bAB9sVXoy9tbAdXi0KX7gmnSKTelQ6GuT
 KfqB18g8KW7U+exSgREBUT15xE3rvEK3mTQhX1PPLeMzkB5OgcoGqqsvO2kT6c4h5oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791559994;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=DcSNrXjwEd0WhRiUYMeTkleV5cLsCo2TKqE/7nz6oQA=;
 b=iz+TpuuPu9im7mAUwS4kH3/rkZYMcuBpMwWNyZmil5GfpmPw8SwT0FbEIVxMptZ1JZ5y
 aZAh+trlb/fkcAkE5K1qBrmFOdMVDwgn4DgCPl1MRxfmktlPYday636EOqchnfAZCEskP
 Zjeo4ghv6VEinHmgiWRSOJ8ef/ccgzLJ6YbRrBDtW1Zvb41zNRXE78kq4ZwoI8prq/kRx
 fTD4FkUBfqanely75QTBQmvo7aTAyPMQ2x6v7+Pl9r6c60oFcz85nUG3FV039IA7oepWe
 I2+7LoLNprnVSDu3W1HERVQUFSsi5coqHn1FVp3z9eoTWNjsjk9UOJlheuayx0BTJ+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bqee9KzN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bqee9KzN
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F246D40888
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:33:13 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6de3360d905so3099824eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791559992; x=1792164792;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DcSNrXjwEd0WhRiUYMeTkleV5cLsCo2TKqE/7nz6oQA=;
 b=Bqee9KzNweflULFQJwArnlUW/GdpgI8s1EUE+/K4YuBZB6u3uRUBSM28nhYD5tRjMc
 2h65xIVCLjcs2CCpey9hkoNd0aOdq1PB9dnjsp4UMU7rk3DFKNoUkiM6Um4HAj/8vEBg
 6bviMYyLDS9YP4ZImHtqau5wI2n3/JOt/+ZBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791559992; x=1792164792;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DcSNrXjwEd0WhRiUYMeTkleV5cLsCo2TKqE/7nz6oQA=;
 b=LWytDbBl2Zdej0Idn4yMsg32Etyyi81xnOqhnM2JMF25479aZitCou4Hyslp+9jkGo
 TYxp10aU4H0bxF8e2CpsdLd1dLMsLxqufBPX79Ol0J2gMEGkAZG34/8bRFo8txM/twRm
 Jd6aI7hdcjYlIKdOaIXI30RG04hwX7NMSUNxmtz7ubN3m1iwQr8dD/VEC28PWzY1uVAU
 QLVUWz8kpgHWJxtShwbCKErL5aLHMCd9cBNBlAf9Nu4T9RHkl/mvdG6Fjx71sV1bopMT
 8k1cjbpC3fIaH5SiIuHdwg2Tzu+knE6tDFQpqgPE3UdCNfMCVzgAGuiUxK33LePF/lVn
 RNBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjVAnWMr2vYkZ92iJVvHEnlartBYwGP91nZIWpmk7HnAC+lHJGlgr4opSaX8DZ03Skl+g2meI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lqu4WY/tzOimbKztH/UPPpgWMwaEWnMVL14xFMbtpudZ74dw7c
 hgspF7HQEmtBLRynD/zPayJwzqcjGbROjkPF8lnJAfRw8dWgI32Rz/mfyUqE6fsl0vNqfWdD+j4
 Z95Ns5agPkUA1
X-Gm-Gg: AYBFou2wosmG/aAtBiBWOXtGc/hZAL9MfxIaXBsMSaG7L34+yimghVo1RWmR+JTSbQ6
 5wg8WTAY+ifwLO2XJFo1Z2JO361ISIEmGF+7zdSuvB+LlpUsMOzkd2QeBcFHoAhAoAI9OQ7ia0O
 TLhB/fh57pGxe6mfpF/k+VvOEmSq4XZg5EoOFWM9XdoGtHlk8kbcgUpEitSQZbPEeIh9QQZJpqz
 hW0KN9/gjBMwL6bRtaiAeTuBZVAdZszFJ2q9H51k+vSVZsbTV56WBrQD+YSex1fSKe6M0GKTmKe
 jr+Mvjg4yqLs6xk95Dra7G70kvbiiW+5YZtZOxFogjIu5fs8ExUN+NS+ACpZqk5qRvoqlDqVBlo
 586FG6wREK4++hy2BZJnvMLqumcSvklWijVt5u6X2Xvdo11rHFeXm1rjfcaMiAEgVwdwTziRlre
 JIZymaqPy8ZHWTzoGpzTowI8jkDf7KK4kb5lSRvdcneMhp+wVOkhtB8LPXw89Z95lXckFxyNzKP
 Ti99Yw1FV2WKxsjsgd+jEhoj2HMxrz6BeglPX28EKscOVY+aANlv6sKchXmqMQrGv37BDxedfWv
 WEdgr2u8KA7vgpgDPHQ=
X-Received: by 2002:a05:6820:80c8:b0:6b7:46fc:1e6 with SMTP id
 006d021491bc7-6ef10097afdmr1558592eaf.69.1791559992577; 
 Fri, 09 Oct 2026 08:33:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef00feb63fsm1963048eaf.7.2026.10.09.08.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 08:33:11 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:33:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Haener <michael.haener@siemens.com>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
Message-ID: <20261009153309.GC769217@bill-the-cat>
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-4-michael.haener@siemens.com>
 <CAC_iWjLO9LwkF6x9Eq3Rej27A20W_BZ-BXmL43OumemfG17SSA@mail.gmail.com>
 <CAFLszTjAaX-HKexye-V0AVhQwFQ_uBnxRG8JkhyxkmCBTKH+0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+4w/smoJLBbbMbjE"
Content-Disposition: inline
In-Reply-To: <CAFLszTjAaX-HKexye-V0AVhQwFQ_uBnxRG8JkhyxkmCBTKH+0Q@mail.gmail.com>
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


--+4w/smoJLBbbMbjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 07:43:15AM +0100, Simon Glass wrote:
> Hi Ilias,
>=20
> On Thu, 8 Oct 2026 at 11:14, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Tue, 6 Oct 2026 at 18:52, Michael Haener <michael.haener@siemens.com=
> wrote:
> > >
> > > The Kria boards start the TPM with a 'tpm autostart' call in the board
> > > environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup f=
rom
> > > the environment, so the TPM is started even when the preboot script is
> > > changed or skipped.
> > >
> > > The TPM is now started before preboot, so the TPM reset hints for some
> > > carrier card revisions are printed after the startup. Boards which st=
ill
> > > have the old environment saved run 'tpm autostart' a second time, whi=
ch
> > > is harmless.
> > >
> > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > ---
> > Simon there's also configs/chromebook_coral_defconfig that call the
> > startup. Do we need to change that as well?
>=20
> Tom isn't running the tests on my lab, as I understand it, so I don't
> think it matters.

Setting aside that none of your hardware is part of the project
currently, we don't intentionally break platforms, so I believe the
question is if the option needs to be enabled or not, for general
functionality.

--=20
Tom

--+4w/smoJLBbbMbjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaskJLQAKCRAr4qD1Cr/k
CqZAAQCauASLvUHsPqviTxQTv3lJbaLhJduVgiYdoEg0Iv7ceAD/VaxMKq1SmXO8
Q5UkWMeIt1TgNfqX1AeIdMszuC/yNQw=
=mjvl
-----END PGP SIGNATURE-----

--+4w/smoJLBbbMbjE--
