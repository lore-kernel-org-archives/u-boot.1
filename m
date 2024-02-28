Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3849C5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 23:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E615F880A2;
	Thu, 29 Feb 2024 00:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cnot5BxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC9F880A6; Thu, 29 Feb 2024 00:31:52 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE08880A1
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 00:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dcc84ae94c1so371790276.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 15:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709163109; x=1709767909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ixDhQSKzf6U99nwlheQk7EuMamMukzqeBNQA6XPatw=;
 b=Cnot5BxQRHwo3k7KKRtXOxiTgoF0kKrvqqAGfi+xk6yLE3yL1wMBaSdNC4JaR52gB+
 NAfCPXVYjUQFEQ7Rw+C6WXdO2tJXkHDETpOlt9qDDJMiPI5v8+X4rjfWeVgrWJGl00+O
 PA+s8FLQbkKFwEJMf+x3vX8qtno6ZsvmCnXQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709163109; x=1709767909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ixDhQSKzf6U99nwlheQk7EuMamMukzqeBNQA6XPatw=;
 b=QCRfl2LLkYVp4l+65KHRIpO41wIOGWNwBWFCVuSIcYgQRYAbR8qyRM9raVuCPPNoyX
 BiaNLaopRdxuOpbc3pWIEp06rXq7ztvRaC8Vb9YmYxnAl7BkRDZRpvlbe3k01ExK41HR
 o1P6gDIdTXsYnLRqs/AvZ9eAViNQhKgn2/HMTl6xvGkY05DdcVk0xDmHPJ1VOTRpGqZ8
 vxC1l/oL+99v/oFTTMIDKIeQBZZdiehgL4BaqB8Ra+sH3ha8n2fV/yCG1nemR5Lqz4Up
 gIQOZ/Cz4Qn/t/J9SjIWMvQN3rqdpvQCBbdIjpWMcEWkGYNcGFy8Xsa51iG/1W49AAM1
 a3Xw==
X-Gm-Message-State: AOJu0YzOLsdq9PBSZDqyXTTZQn21i4fX60/yHdC+TskfkkoA12YHM+qe
 PejmoGs/KkMqMwlyhnNOEz2PBcP8tEwo6U+fDpHAEghji1PRfJhOb/ZjgHDuVLc=
X-Google-Smtp-Source: AGHT+IHHaOlEKd/vKwFtb1lZYnGo2LCC/3QT1yxAEuyrSiurL1vkeRrKcjtSDsvSG1fe8gdodGbdwQ==
X-Received: by 2002:a25:aa30:0:b0:dcc:8114:5a54 with SMTP id
 s45-20020a25aa30000000b00dcc81145a54mr594315ybi.43.1709163108798; 
 Wed, 28 Feb 2024 15:31:48 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 g13-20020a25ae4d000000b00dc74258241fsm16086ybe.45.2024.02.28.15.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 15:31:48 -0800 (PST)
Date: Wed, 28 Feb 2024 18:31:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [NEXT] Pull request efi-next-2024-02-28
Message-ID: <20240228233146.GP3040305@bill-the-cat>
References: <476bc3dc-ac10-4915-a598-5e61280d862a@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wleNRmyPFfO89nMJ"
Content-Disposition: inline
In-Reply-To: <476bc3dc-ac10-4915-a598-5e61280d862a@canonical.com>
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


--wleNRmyPFfO89nMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 08:11:52PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes for the *next* branch since commit
> d49fa3defa50c6d3f04acbb52fd486c13c14ab6a:
>=20
>   Prepare v2024.04-rc3 (2024-02-26 21:23:36 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-2024-02-28
>=20
> for you to fetch changes up to 97da9aea78ab71e92778649bf9d1071f30e260f0:
>=20
>   arm: separate .data and .text sections of EFI binaries (2024-02-28
> 14:39:27 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19761
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--wleNRmyPFfO89nMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXfwmIACgkQFHw5/5Y0
tywQ3Av/bvbAKNwVcEt0upEcOF1zR9/N0m66hkS489DnJI5mvBeGBh+sVndym0Ob
SxIamLZ+a/0lacmtt4vSeyDjSCj6RDXnXeDIVPv0g7Er7VC5uU+ZeR80QgYlxOBH
TjSCgm4pF28GIdkjG3VGqpTcKmJXFaCyoUAV/hhQkv2C5j8/0tD4EjIfBAZajIsd
xTKY6EcAXFJyvlFmhWdtJ4j3WYDuklYOdN/aZm8EKY4kEkP+Qf451EY94wd02nY+
akSXQ4CNAkSBYv5yWUhcyb5we0u4k/AjvQoIZlkSh1XkeqkVoDsT4VXpZWiE5WjP
NoMmuzBrM1ESm9FiZxZ11r+WeXMGiFUDsyisD2mnyPuBZjM7CC4rI06wRP3OC60V
dzl7L0rmBHuhnu4InM2C4/1E8lgK5y4SeUQ+x7zbU67DbtY+JR92toq/EaOr7roI
q787cLmUGYmBOrqGw55GzR/JCFqo+fYphBTHXljbtFDLufaZbF1pgIey0K4KlWGT
ykyvCkKV
=pTVo
-----END PGP SIGNATURE-----

--wleNRmyPFfO89nMJ--
