Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1218AC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7841588835;
	Mon, 15 Jul 2024 16:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qV9QCauC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 848818886D; Mon, 15 Jul 2024 16:28:50 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFB788835
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c9fea3b566so2141303eaf.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721053727; x=1721658527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o6g3iTrvXfJmKDKxeqYIY4t2yVk5VN+qoAIZgiuexPM=;
 b=qV9QCauCHmno0bJvZbREugOQuMWHj41fTp5sj5tVVQaaY22aq+WHAFwsarUFp7QSKR
 G6AKz+YXWB0a2AgXy/g+8CTkSNL+4dMX1oi/RCu2SGozTvLSG1cJMGVcus+5vs7JT6mS
 drz0pOlJZI/MrPFzI/BMq0rX7xR/5gpkUi/7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721053727; x=1721658527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6g3iTrvXfJmKDKxeqYIY4t2yVk5VN+qoAIZgiuexPM=;
 b=CrndCkBbTRolXhqNQYU96rO5ME+jEdl+fYcsTUDXm8QXMPfOcmkWZIrOmvEKZaYfyI
 1Wih5Y/6dW6Oq3BEqFjKJEMfShEBYVBqmOlg0AsN/5en9HzwrP2nSzcqatTFW4FHHh8D
 Jo5XvWeupfAyeE/90EB6FMqgKgWZahjn9bXcbSwZEFvDkSO20kNAMt8xZ4+EYBbV/kDx
 JR6Hkbpnv1FG3RHggbRTksb94pkJTUGxrXttjhj03N5lLF7RSh8gjkxknLMNiFb3es15
 96OJTb81fSG5aAEOhbDTmdjqcbQ4PinFIbPIGtI6/dBUQE1+Ng32X+e0jNL4WO2zSljJ
 6IBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlWKKclJz7rJLj2I4o/Mh2T7yejqo+0a+N1Lgce4Or/tzPr21JjiyW9F0VXGq43IeDQjVXxg9+fN+MsSIqh7tGxtA0/g==
X-Gm-Message-State: AOJu0YysXUmi0G0NjCZ/Y69mb/w1VdyuZ2t4H1tz8mtNAocOO3H/1sDR
 aw1wunsKIuSpgmdOV9tRfRLfozdj+VeeBBBZ4U0DjNZmf31LuhJN5+He4MgxV3s=
X-Google-Smtp-Source: AGHT+IE/b2EZolp541bB9HUwG3cST0tbggDEBQd6MxzIsmXczAKU+ybuZ8Je2XskE4wKpAacQ7tgyQ==
X-Received: by 2002:a05:6871:8797:b0:254:a218:89e6 with SMTP id
 586e51a60fabf-26052961edfmr4557202fac.23.1721053726844; 
 Mon, 15 Jul 2024 07:28:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26075176419sm964018fac.31.2024.07.15.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:28:46 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:28:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 0/2] a little RPi watchdog cleanup
Message-ID: <20240715142844.GG38804@bill-the-cat>
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
 <0586321e-b2b0-40f6-87cd-6da74b79fc40@denx.de>
 <87a5ii959q.fsf@prevas.dk>
 <CALeDE9MsL-DR5+6ce97r4osSwNNo9SAaepYf3rsr2-ZdLuD5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jF7lApUZMaKTOBpE"
Content-Disposition: inline
In-Reply-To: <CALeDE9MsL-DR5+6ce97r4osSwNNo9SAaepYf3rsr2-ZdLuD5bQ@mail.gmail.com>
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


--jF7lApUZMaKTOBpE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 02:24:48PM +0100, Peter Robinson wrote:
> > > I can't find these patches (and v1) in patchworks. Do you have an
> > > idea, why this is the case?
> > >
> >
> > Perhaps because they (v2) have already been merged to master via a PR f=
rom
> > Peter?  commit 1ca216522d4.
>=20
> They were there, although weirdly they weren't assigned to me and I
> had to dig for therm.

Since that was almost certainly me, sorry, and I don't recall if I
assigned them to Stefan as "watchdog" or just typo'd and very randomly
assigned to someone else.

--=20
Tom

--jF7lApUZMaKTOBpE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVMhgACgkQFHw5/5Y0
tywHpgwAk2RQXvylpnp8sEMbArUasUF5jW6/o6uD9ovbgPsvV2Iw6SCJUxeMI4Rg
5pI2ebGlVypL2GyKB98CHS7uHGsnyMc64JAWLB7M0oDyMmn0Uc2HTzR973FAimLV
wLmSmaBd+5goDH1N+rjxQSLBZN2sSMVjyFWFb6OmgPcftS0+fjnU1g5lkxLHJH8s
Fk9vZvOcLLTiLUGKu8cK1rlzaDZQWudEJ657XmG3KNLqBRu570yhCFB4lD86wiVu
kurmHO1EuyjY7VtOLpg0GwNVU4WbpCtCvUdQD/dIKk0E0Xvc5lZ/xztxrEdnLVqZ
8yrGdFA6t42Xl0vSESJlIy2Yko4QDlrEOuM/2+IdvD52HoQF0e3+0rHd1eUyS8Rn
+7f0x1CAyAztM3X846ZczcfWNXSlaQMqjgUf1oDT67k0LEwDrTJPb60IodxSEtrW
CZAAkRU7Zsswg1A2j7sFIz+17fexoY/ZAkexb4oDaOX8sm57XnaKwize4svInNUy
0KShPKo2
=F4wj
-----END PGP SIGNATURE-----

--jF7lApUZMaKTOBpE--
