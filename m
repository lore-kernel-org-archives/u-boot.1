Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEFDC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B428081A;
	Thu,  1 May 2025 17:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tcq79BSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD4D8070C; Thu,  1 May 2025 17:33:22 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2148081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c0b4a038fso750282a34.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746113599; x=1746718399; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ii06l+1xynL3OMrFtT8nTyQ9Gsp8WgGvgMuE2EQcrNE=;
 b=Tcq79BSzTXttSZwCoA/thqCcDPpFc1fQjhJoElWYQ+yU2jFD+EkXjF+nAJ+2/R/plx
 jPswYBzXnTlC7hEaS3/Nm9UokQauBf3kJtpznE5fQQsHxJenfuz2P8L4X22xxzIxQXB3
 485mxdZ+UmzJr8M53LbVQ/qFqIk/M90BzIRDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113599; x=1746718399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ii06l+1xynL3OMrFtT8nTyQ9Gsp8WgGvgMuE2EQcrNE=;
 b=e7/m59GMnfck9g8R4wBoehpH1MQWAIHMIhLd94Z3Q7y/26fpCUZSBNRYt4uC1TOk1g
 Db/f20NBYPVRTMhnjUFIv5abx3kfwbS9hQ5vBd3cP8wm7SEcYgpHUNAt4//WrPrBnsNw
 4z+/J/tdoBkkpSJFBEokT4ZL/k9F30+8VhfMEJM6nn06JMcz6K41H0zTfXVqy16O1m7b
 gXVYwAMgMgZ+ihWuHNHIlVeZB0SaKfkj6Qj1wPou8UD/OFD7E9KNKBDBfFmz4K/723dS
 ILYzGk6hw2QTrTVrqcOgzQzzQ05YihwB58jngNfH8CBMHLXZMEEMnxslrJM+c3lVbMg2
 VxdQ==
X-Gm-Message-State: AOJu0Yzdpj5eNeoIMNepWo7QXJvjo0DRQoS+A9Rk0TvRM9vwEMZHAcpO
 p0VO1vLCpmayr25m5Qw6WYMh34L6v2zi6ZpH7oNrAw3lgUN7urqmTajeYrdDZGw=
X-Gm-Gg: ASbGncsrCHs9tF+IRd6IDRJwAWQRUHLcuNHVPUSWPXh22CqaNd7JGcHjjp5/EsqynbP
 5YVYeGy+j9B3xwaTvdk8lKg+PUnNhRlOZfMh9Y80ajOra0jDp/+mv40yoRaq2euHmB2AoaqYGpF
 ulKAtNa7n+nejD/ewb+s8B0rknuQRNS2Nr5qo8JQP6YplcS1U4ViHPLZBjAWuH+6w3IGH7Xz2et
 YCMtvE2wKYhB/NqN6zGjW6x6fIzEHywuFQl2zyHF3JNX+1Jba3iYPS8ADVbclv5sEbSj3Lm1oT3
 pvY0xkY2UCdLoD4A1a1BOujgBeIvIcE4Zgk28CpLOpdY9GqCWrVGi06BlZrhaVoFZM/T8CeJF7V
 sDQ==
X-Google-Smtp-Source: AGHT+IGfoI6VNLmXsAn4oIAAkuIda97TlhxZ5muy8ofkVcqyFtfz8dEsb12Rwen4sBIFRO8sAkRL0A==
X-Received: by 2002:a05:6830:6407:b0:72a:3a7:a07c with SMTP id
 46e09a7af769-731cf352e21mr1539952a34.13.1746113599220; 
 Thu, 01 May 2025 08:33:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f8bf86sm167098fac.26.2025.05.01.08.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 08:33:18 -0700 (PDT)
Date: Thu, 1 May 2025 09:33:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250501153316.GH1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m4biH0VZ8NLe442U"
Content-Disposition: inline
In-Reply-To: <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
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


--m4biH0VZ8NLe442U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > This file reads from the environment but does not include the correct
> > > header. Update it.
> > >
> > > Drop the unnecessary config.h while we are here.
> >
> > Are you sure about that? It was explicitly added in commit
> > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > includes") probably because of CFG_SYS_... usage.
>=20
> Well I assumed it wouldn't build if it had it, but perhaps that is
> incorrect? I understood that CFG_ things had to be values and you
> couldn't #idef them?

The cases where in that series I added config.h were for good reason,
either failure to build or tricky size change reasons. All were
intentional. An audit-and-remove of config.h would be it's own series as
yes, there's perhaps not the need now as whatever complex chain was
unwound.

--=20
Tom

--m4biH0VZ8NLe442U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTlDwACgkQFHw5/5Y0
tyz7nAv/SsNkyvY1+HRLweVRlLVDTj9ljA93CNPG/SaK61NWaCToExmZGOBjjpWB
7iOIohLIOhqAMipSZRKtLsar7AdTPkIrszw/Hyg/HVfxtEQ/KP7GM7AugvyS74Kg
4wuGzr9oTfYOwKW1kmCUrVcWNa7hsWTVv4yXo5gmhAoRGLJjUxI25sd4ZK2E8WI6
mm8zOHeMh9EcVwYiudC0znZ8DLFZ6ydomNNLbA383STW9A3WSSavZO5f9x36CkYZ
r2tBSoiCMCwGo3ryZ1Gacwh2e87fchVZQGuQ+9fkcmQ3avzwRgZFI5vjgHLhxXHL
hITDlmJ2avDhQvUEds9TlD0SMX/PoX7FXWqVlOXAX2JD6ObanOUVE2CbGKBWTIWC
JzUzXxkJ9aZo3Km8frCA1Uc2r04NvR8OIKytc9Pz+xUbywDbov343t6OdArEeSbu
PIXr6wSSCtcY4DiIB3uNJuFFsKlfdwavH6PzinBk+Bwv0a7Z2cThyYgdoXcb2qrT
yOwe9bmG
=QK/k
-----END PGP SIGNATURE-----

--m4biH0VZ8NLe442U--
