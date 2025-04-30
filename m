Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4F5C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 21:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB8B800C1;
	Wed, 30 Apr 2025 23:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZjS1xQ6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BFD800D7; Wed, 30 Apr 2025 23:04:56 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3798F8007D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 23:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72b0626c785so208358a34.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746047093; x=1746651893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QxSJAGui6HyWnNADu0L9Oc0gQUQi0yvAUfAt/dTKvtc=;
 b=ZjS1xQ6HliHzwPAhWzJMwo3IL1UTPXQ5VK4QG1R0xE4j/RMvXMh0ot1SnAbxvzAycN
 1CyCfWWWtsTATQtH17evOHZjEH4MV4r3ETBqvPnyjNkYq5EVOm4RMhnNcRmQefZkvOu0
 /pM9WusAkG1zbsC94tV8veTOIR3Eyqp0HuYns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746047093; x=1746651893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxSJAGui6HyWnNADu0L9Oc0gQUQi0yvAUfAt/dTKvtc=;
 b=RUt6AZVtDrprCVl0rzDqUMXmcvqoUb2ZYyv0B2JS4mazC0wKiGZvedlFu3qWSw62XB
 W+pkiYMUxckjGvyCJwoj/V5wy5WAbrZR31pEL6RwFBLY5mUuLviFDTEEP7Vv1qvMKSNn
 826PqRM2PE/+QPZxdUom8FZeJhZoRCS0dNL07T9ytqwZwyzfS/yipMDgrm1qe3CMmlEP
 +wvi8PAeKseD0J7HbtGnrj1Ius9YsenAUEP0zLgDW+CuhopD568VSe3W4VCCUCr7146O
 EvkYJ3uUrGv0CBTrYaGAO/Rd63Jr1XrvtzHCq75yABraswh9tnuVOJ1jnFz0HOpSJS3z
 ZJ4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/jr2x0ltfTJSga5V76qxH/HKQPizLyOtan72PV3rgCcRmHZgQPjD/xFiKMYAGLDmbnQA9P0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy19JZ0qXcNEWVWmlks7ArRl1WRhp5gJmwzS9vHjmha9xuQLkV
 AtqF9swWYzsVctAmXYyV2kvUW8KzgZTJVQJy0HG5OQ6Y46c3F6t8t3CtpSNCbgQ=
X-Gm-Gg: ASbGncvhe/hl06D9e4rzQRzeSruaxM9LOyzcx5ptTIbiklALvBNdUAKUb4j2ipxRhRr
 gDDO7kJlngwY2WXwsdJdzmZjfHjoURgvLlGoHiVhJpTDdR6qZLLn3kmaR6vuCgmW49Dly1LHpTs
 7JqcQFaN0vCK0sWCyMUIAJ3aa7ENJxYNpLIM7MY7RfDHg+AdJ/wF776VQW+a6M9csrs9Q3CJYeB
 TRaX/X7M1EiyqGRL2281irs7CPxod5hBus/CF+XrLuK/uBbcvN4oXlLGmCYKQpSHOx8ewSbgUt6
 2qPKo3B9WBBH8opF2wAptF8fh0tQAqEsdts990airHEg1K6dN9Q5mjlBuiF16P64t2KGfMFIzbb
 gTA==
X-Google-Smtp-Source: AGHT+IGtSI0CR3mi5nCGyPW+Ct7D0TGFFpgecu8luFeKpBPiuQ/eS2xZ5p5FNrByNloVne/AzDRaRQ==
X-Received: by 2002:a05:6830:3981:b0:72c:10db:f210 with SMTP id
 46e09a7af769-731ce333847mr151597a34.13.1746047092882; 
 Wed, 30 Apr 2025 14:04:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b1315cfsm1041106a34.34.2025.04.30.14.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 14:04:52 -0700 (PDT)
Date: Wed, 30 Apr 2025 15:04:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: "Raghavendra, Vignesh" <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430210449.GA1261075@bill-the-cat>
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
 <20250430163156.GV1261075@bill-the-cat>
 <fa03eca6-1cdc-4ff6-abb6-fde05682da01@ti.com>
 <20250430174004.GX1261075@bill-the-cat>
 <20250430192604.5dmv465thftsm2uj@bryanbrattlof.com>
 <20250430193149.gbfzi37e6yx2edfs@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lxktUtfPXOTVQd8M"
Content-Disposition: inline
In-Reply-To: <20250430193149.gbfzi37e6yx2edfs@bryanbrattlof.com>
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


--lxktUtfPXOTVQd8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 02:31:49PM -0500, Bryan Brattlof wrote:
> On April 30, 2025 thus sayeth Bryan Brattlof:
> > On April 30, 2025 thus sayeth Tom Rini:
> > > On Wed, Apr 30, 2025 at 10:56:27PM +0530, Raghavendra, Vignesh wrote:
> > > >=20
> > > >=20
> > > > On 4/30/2025 10:01 PM, Tom Rini wrote:
> > > > > On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> > > > >> On April 30, 2025 thus sayeth Anshul Dalal:
> > > > >>> As discussed here[1], the go command causes undefined behavior =
when used
> > > > >>> for running custom OSes since the icache might hold outdated da=
ta. OSes
> > > > >>> usually also expect the MMU to be disabled upon execution.
> > > > >>>
> > > > >>> Therefore this patch adds a call to cleanup_before_linux before=
 we jump
> > > > >>> to the loaded program/os which disables both the caches and the=
 MMU.
> > > > >>> This makes the go command's behavior consistent with riscv plat=
forms.
> > > > >>>
> > > > >>
> > > > >> I know quite a few other OSes are beginning to use U-Boot (QNX,=
=20
> > > > >> GreenHills or all the other RTOSes) each with their own requirem=
ents=20
> > > > >> from the bootloader. I'm curious if we should make boot* a littl=
e more=20
> > > > >> generic rather than abuse the 'go' command.
> > > >=20
> > > > VXworks has its own:
> > > > https://docs.u-boot.org/en/stable/usage/os/vxworks.html
> > > >=20
> > > > I suppose QNX and others should ideally have their own cmds as need=
ed.
> > >=20
> > > Well, what's the QNX output file format (options?) again?
> >=20
> > I've only ever seen outputs in compressed binary formats but I've been=
=20
> > told there are tools to produce an ELF for the simulators
> >=20
>=20
> Ah as soon as I hit send I find it in the QNX docs[0] it's their own IFS=
=20
> format :)
>=20
> [0] https://www.qnx.com/developers/docs/7.1/#com.qnx.doc.neutrino.buildin=
g/topic/intro/intro_ifs.html

I see other mentions of U-Boot in the QNX documentation and even some
forum posts that aren't 15+ years old. It would be great for someone
=66rom QNX to chime in and explain what they recommend people do today,
and from there we can see how to improve the situation if needed.

--=20
Tom

--lxktUtfPXOTVQd8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSkGQACgkQFHw5/5Y0
tyzEGgv9HpfdK+8dc22wGcUjyY94svb7/fmt5tppgCyjImWAub/I/Kw8yphEUbV/
Y/qajOP6wab7vYvfeBJ9M90M6OcbEasD3DtfHY5SXOMU+UEjPsmerF7wmxYi+CVh
4jxM4IkTm5TLP6fYgMiE3CydbhfO49XXYctxVUiooVGl9fJ8pSmDuqrgCQPMI5ND
jxdgZJavncj/UJ4uWeEH9B1OmQbY0FY1WbKNG1Wm5obWRugZPXxMIRWjD6SbvGdP
OnbShxq/X/OY6gGwKkQP2zSZaE4I8zx+l6HyZyXJ3S0A8j7pK6Lkg5EjZHaM8Uhs
Wtjku8wToeEqe5E+jvJRa8IFZxD6zTNXVzvFEcTVwVgL/Z1HU+BiM+JNFfcyXK7V
zibGmEioCGAvays1O9cKCx/ksSiVARrJIiy/9P7zpehgN2xF10mLbH4p1lquRNSG
e2yOlWROlz/rjDSbrhz4Qzua59wrRc9ZJKP8SDdpm2p1xuvVdSdAYgivuHSS8LYo
letQuAes
=n8xA
-----END PGP SIGNATURE-----

--lxktUtfPXOTVQd8M--
