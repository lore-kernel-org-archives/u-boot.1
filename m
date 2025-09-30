Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0469CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1601080819;
	Tue, 30 Sep 2025 17:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GFykpCxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF93182998; Tue, 30 Sep 2025 17:48:43 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A1B800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-937b40137b4so871139f.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759247320; x=1759852120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M1/dqqd2MCYxytn59BWanjpSp+/CXUSpUjrNqOAfcVk=;
 b=GFykpCxm+lmHb22bOMj/kzn7RzdX18SkMB1sn223sERBS1Bog3ihcPPVjk2c136f7f
 F94PWGXKAZvI/FHa5+TkmCJkeM+w8NH5F1ovtPrpG2pSvMyZXeBytWOTDYvY9BAnE0uT
 Z1SChrvXqPzcGDs2vaGHehmcTdYAAdA2wWQaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759247320; x=1759852120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1/dqqd2MCYxytn59BWanjpSp+/CXUSpUjrNqOAfcVk=;
 b=uWyiUXNTpZ3uEUmLT7AyVWeQr656RfvtHYDMg/TeEP68LU0hdvnm2qb2M0lnaPffw2
 ojfdUWOOrBaqkuO2zOa4SYKFnRnv2Vp3Fiu4/nmLkY0ePpVjIpd5LPww5JFb/hTTdsAz
 L8MqAGRAPjf20duFvAJ2vvVVUxra8ZRvCprEFomjXthQepQC9JbFkmeXxB5/xyeWR8YZ
 K9xHgcs/V6dONKUAi+fl/iC82B2dma3d6jf4IDmD9b8GRefyD46i8hz4J662sGkVOLi2
 aP/csnBbw1mJWb3jctgWHomSNzmMsmbVrsqaRr+LP4dbLUQmC/NiDfi6Ivr1qa/zpQXC
 mISg==
X-Gm-Message-State: AOJu0Yw2qkeW/KmKX8UYp43cFlZJGiPA1XprLd6J3P7JB84uA+LggLrq
 +ospOR18+oX7hS1TESL+iN1GKVnHuxnbc5xb4HCOxYQXfcVsoIlQp/sdlvdjYqmq4gNQpm37VTF
 J94NadXc=
X-Gm-Gg: ASbGncs48dVO39g6K0ENgYYf5cLXfvGZsy32dKLKoM3RSq6j2wzya+m6pXU/nrI9Ilw
 gUxWdHOL63z8LlqXOiUMmYbk8sHkRKKxw6XevnebZBX5i7YTvG1p2m/0PvcvwZYiMgLlUsmY7DF
 Oop+xaDqNDXBZ7Mf3GvZzbgnETE6pmOeioK/uEhG6QN3Rv1DR39lzCY513Qda2p/4QqDIkIeU2g
 agxOB6JAk+sT58LPHJ/EVtapPVJxe5aIqx0D+8wBrjrsrpa+/Yr5+jK7b/pw7cJJ+lElHNCvWmG
 z7KYjeeRSdKiMq7ctUjvA4jdcjGQv9cXRNWu4ho55fVW71sBOK471otFl99nk26Ao4175JRvJUL
 h7HpjJg78/InkzugNpz0LHG2usxLGr4vz0wdaEOPX8arngzffdYjzgLKWYMb4RZbE/R7X5A3c+q
 K3noG54kqZ6l0cUdU=
X-Google-Smtp-Source: AGHT+IG413IM/zRBtClMlVnadtmqdOrpPLXGk0Xgg6D9iKAvbXyFg/hKXOC9KPiKOOWdamCpqFAzJg==
X-Received: by 2002:a05:6e02:1d8b:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-42d81616fccmr4953795ab.9.1759247320342; 
 Tue, 30 Sep 2025 08:48:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425c0546cb0sm68424015ab.42.2025.09.30.08.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:48:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:48:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: Re: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Message-ID: <20250930154837.GB6093@bill-the-cat>
References: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aqaMFArHIR0rMIOA"
Content-Disposition: inline
In-Reply-To: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
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


--aqaMFArHIR0rMIOA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 04:45:34PM +0100, Jamie Gibbons wrote:

> Correct the assignment in board_fdt_blob_setup() to use *fdtp instead of
> fdtp, ensuring the caller receives the correct FDT address. This
> resolves an issue where the device tree pointer was not properly set due
> to assigning to the local parameter rather than the dereferenced
> pointer.
>=20
> Fixes: 63a8506580b6 ("board: mpfs_icicle: implement board_fdt_blob_setup(=
)/board_fit_config_name_match()")

This commit is not in master nor next, where is it? I think this is
something that can be folded in to another patch and that patch
re-posted. Thanks.

--=20
Tom

--aqaMFArHIR0rMIOA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNv70QAKCRAr4qD1Cr/k
CuInAQCkQBROESTwO66axw+ry9ajT7JOx3gULPbOhMlFpN2KWAEAwOUCrNbDNrDk
dR4y1fQln/iKjtqcL5tuRWh5+dCYtgI=
=p0u2
-----END PGP SIGNATURE-----

--aqaMFArHIR0rMIOA--
