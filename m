Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800C7C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30D187D84;
	Tue, 13 Feb 2024 15:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pz4LnGey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D9187D78; Tue, 13 Feb 2024 15:12:11 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5127E87D84
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-604ac794c01so6497617b3.2
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707833521; x=1708438321; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ddb4yDnWvoaoNxunh1dh+gdXZ4Kz7U4QJ7FRlUaxBoI=;
 b=Pz4LnGeywUxgOyxPu1vvsYKK0XzjUSsk9L5Ai3KQghptdA05iMKGKs/faOVUBvG+Lm
 UcUPGqsnF1AjUshIhelzdhcYFFvqQA/Twjohd5QnWIDtuHqyZf1l6uBBlczdjSYCvg0n
 RZpGKrFXWLFBbDV0jyRbc5+FYYMaY8cuwE2J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707833521; x=1708438321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddb4yDnWvoaoNxunh1dh+gdXZ4Kz7U4QJ7FRlUaxBoI=;
 b=hZ+wSsky0jXdvcSrlMuRDnR6h8VvN5pS/s1bABLJDs9F1fwaQz0cfA+hxX+KRNy2Xu
 TwtBXzXs1MF9Wsg3hCtPiyMXAeHlXrh7eh+HnxXdIpNWHQ8qGWXdIY/2BgCPy04C8t+M
 026OzKffrs09jAeztHDsG5GwkO0rwWrVbzY6BxHdbUDZOXjCxZGnsyh+l0kpIViu82rk
 rkVLswmBPq3aYPEqZojLD8IjLuXI8/Z0l3AdZ3xKIbr8V5bXcC5wdRdH8CMBsK7Lq19f
 v/RwWJupyjeIpBNHkPZlNE7I6fs7DOIcgqn0AV4UNVVjwNeBa/mF/NUXr/+j5StH8ZSt
 wfOQ==
X-Gm-Message-State: AOJu0YwdZTsE1Hm9o6cwWOAloaebIF70CADG4xLedWaxmGbZf7xcY6/k
 8KS8OFxm88Gg06Ga0vyzr4CNH8MGDVFlmm082MWSsBbhC/81XOSGReG1WgmORTs=
X-Google-Smtp-Source: AGHT+IG7SI/329dJhCnBxUSbjsaFRO00uHWxZiLgyNd8ZXct1HH9hnUUINl4BYiBFc7s4QQfPFC0BA==
X-Received: by 2002:a0d:f681:0:b0:607:83a9:d3c6 with SMTP id
 g123-20020a0df681000000b0060783a9d3c6mr1864979ywf.38.1707833520966; 
 Tue, 13 Feb 2024 06:12:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWpnkvDIjBjpJtIDYlzkBnEPYr11cLMwuXxcJYGNb2BHzOwcmfUh6SScLEC4Xylxi+3xo5lwEjBUMpg34ygtTA8m10GWfAcpEeDqMQX0pwasPHH8dI=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 i138-20020a816d90000000b006078cfca84dsm241464ywc.38.2024.02.13.06.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 06:12:00 -0800 (PST)
Date: Tue, 13 Feb 2024 09:11:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: reset: Add a test for reset command
Message-ID: <20240213141158.GR3040305@bill-the-cat>
References: <3fe83c9fc262878367d9cfbde31e44b133edbd10.1707815050.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iUMrmTPRiscT++2d"
Content-Disposition: inline
In-Reply-To: <3fe83c9fc262878367d9cfbde31e44b133edbd10.1707815050.git.love.kumar@amd.com>
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


--iUMrmTPRiscT++2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 06:26:56PM +0530, Love Kumar wrote:

> Add a test for reset commands which performs resetting of CPU, It does
> COLD reset by default and WARM reset with -w option.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>  - Set bootmode through boardenv if modeboot is not defined


Still fails on sandbox:
test/py/tests/test_reset.py F

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_________________________________________ test_reset ______________________=
____________________
test/py/tests/test_reset.py:49: in test_reset
    setup_reset_env(u_boot_console)
test/py/tests/test_reset.py:32: in setup_reset_env
    output =3D u_boot_console.run_command('print modeboot')
test/py/u_boot_console_base.py:269: in run_command
    raise Exception('Bad pattern found on console: ' +
E   Exception: Bad pattern found on console: error_notification
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> print modeboot
## Error: "modeboot" not defined

Please note that
https://docs.u-boot.org/en/latest/develop/py_testing.html talks about
how to run the pytests on sandbox as well, for next time.

--=20
Tom

--iUMrmTPRiscT++2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXLeK4ACgkQFHw5/5Y0
tyzpiAwAhJlXOqP9LG50uEZTENwMEezjL+pkIlPrZ+wAKUC/0AbSqd8jnbMIeejj
/aq9LRMbay19buqLSj/YdCD9WOYibyf9yfBgTxWQ2GxRD+s4UaiXYzbshinq0WMI
O5Ldebg7wrW9DHxhbO31uG4nFBe0H+CDpMJN4sBeQWIMFT0YwhPygG8741/PN/mt
lvD7N2uu291stepLWE/46AWYTv3vWpSYJCZJdmfni25uNaR9s1LhwY1sOLz2623F
jmzsQnAJJVLn5vWjB1ihHm9veppX/s8GlHgZrf2nxev7HaSsFgPI2/SLMqDBlWTv
HA6T99Jo2YV/wieywbENJaUpyDIxhKBaa6/Cm8jrJQxi8+59ZLLHsCXsp+EIlNaN
/9Cr2f91T3xTSLsYGiNHHgiKW0QmP7QBX+ZWOZ0NIleoy/D81+49LR6xaYNjzqaC
F85PiMuMKovbih7KKlugbq0UhP6jVK0M+FQVixdRznXPO/RqKWn6P1j60yGPUMjO
WsYb5gcS
=upOB
-----END PGP SIGNATURE-----

--iUMrmTPRiscT++2d--
