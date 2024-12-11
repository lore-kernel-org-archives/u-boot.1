Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E800DE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BCEA801BE;
	Wed, 11 Dec 2024 23:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JhqKD+t4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD16801E7; Wed, 11 Dec 2024 23:42:24 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909A0801BA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b68e73188cso4225985a.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733956940; x=1734561740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W5akENDYN5riBp9WwvwCrwUfbz8jXJICI0zlQqwDqSI=;
 b=JhqKD+t4+m13eYLiAEtF03gsWudihf8DXgUsyeICa1cCdPtEXgXVZoL85Hrd0fdjBF
 95qnQWVFpdgdDDCsi5mbROI5mlF+AQT6ZjG/EeU+8hvAHzcgEMo7TWq6Uh/h0hmHfiLn
 L+smk5QQchCG9l0BxVfUKPMIw50Oa3fcseSNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956940; x=1734561740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5akENDYN5riBp9WwvwCrwUfbz8jXJICI0zlQqwDqSI=;
 b=YeCEVCMgSqBMzWcOOGLnyT1yEBPKUMk0VVKUPcQ1xrpiqxomuhjpo395qyOkHzmQCR
 olORiJLwIKRhjjYP+UA1cuO+QPQJ3yC2tNXFqrZHjiiUv2UQc07kUvWQftbfEamY8aUL
 RrVytvYHi8j0tiXpWNQuV1jeDcEb7qesMgrQrlndvlKT0PZLTiZBr76oqP528Ez3CHlk
 Ud3kFfjb5P0E3GiCNJuR+MI9lRKy8EyTSn4YCWLOJ74LoRAdVzqKit/StFfWDSQ1w5ta
 rGXe47/k4Rjpw097JuiMu5UB+Z+/W/7TrqrkuOyw1q6wbXgYTO6tUEHKyh4E0rZcSEUr
 TatA==
X-Gm-Message-State: AOJu0YyqUI9aWgN5XV268I2hnOGbWuXEwbJ3x3In4XubzdcQZ3YyegiI
 XeokDhuAS9kadK5hhxjwMt1z+4IXNjDGQBjXMuhHcimU1aSIoNFhq/KmKmNOuXfkT8VcPjo5y7u
 QEgE=
X-Gm-Gg: ASbGncsqvClbDNlCqXnh6GwfwWjOufvhYiKPKQxtpwo09/UoywP2dCEWLvjZc1p7EDp
 spm9xtD6/Vr0k/2c/3OmH8G5/zljAJdW3K3ztoXiFIbiRAwuJAzdF7XwrMOwF26sUz87vrUmQJM
 +Rf9th++XT0d7rVVW4dVCUtihK78I1+5EE5Nr3HYTY8rVr4I5tvrjmg+euxV+9gRlI8VWfn/n7P
 7E1KlvyUAeLTs0IDmsu7K2gziXsq34W1uxtizosZrVFu6yh5TzF/w==
X-Google-Smtp-Source: AGHT+IGgQ8jRuB70k56ho3SUD7z+RCxvLfXDhgYIPAHbL3WLyQzQvhapbgvJjsTbcaCD5vD1ZYnhzg==
X-Received: by 2002:a05:6214:1d2b:b0:6d1:7433:3670 with SMTP id
 6a1803df08f44-6dae38e49a1mr18346656d6.4.1733956938944; 
 Wed, 11 Dec 2024 14:42:18 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66eecbsm75090606d6.15.2024.12.11.14.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:42:18 -0800 (PST)
Date: Wed, 11 Dec 2024 16:42:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] rpi: updates for v2025.01
Message-ID: <20241211224215.GH2457179@bill-the-cat>
References: <CALeDE9Nr0gDo0FFp9YJy7bWoxM-4mEq7pCAFcZnJqgVwk9dUBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v2+tklbAy4DcRXdn"
Content-Disposition: inline
In-Reply-To: <CALeDE9Nr0gDo0FFp9YJy7bWoxM-4mEq7pCAFcZnJqgVwk9dUBw@mail.gmail.com>
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


--v2+tklbAy4DcRXdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 04:07:51PM +0000, Peter Robinson wrote:

> Hi Tom,
>=20
> The following changes since commit: b841e559cd26ffcb20f22e8ee75debed9616c=
002
>=20
>    Prepare v2025.01-rc4
>=20
> are available in the Git repository at:
>=20
>    https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2025.01-rc5
>=20
> for you to fetch changes up to 6a5fc32fd20b5e5367fda9a75f0e8de1a4b76649
>=20
> Updates for RPi for 2025.01:
> - Enable capsule updates
> - Pass CMA through from firmware DT

Applied to u-boot/master, thanks!

--=20
Tom

--v2+tklbAy4DcRXdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdaFUMACgkQFHw5/5Y0
tyyHXAv/S2704oU+MP3QYZyLTVNzwjMkQcFEOUlX+j8r6X2RziK33eOxA9z2YFpL
uOfAwpx3HxRcadMadnoRLEg+ZFfPaqbR4C9R153vPkIS5A5f5E8VBoXtuOrrqtIY
OKqNsCPW85g65qmnKdsNIhGZHQCJ6mu2Qg/eKTD9U8lXEomFsLethdDh+X049pcR
bL0Iclz9AXDXllTM2Xk/DfdpKRt4CqX7vKJC3ebDKyM+d0/Wr9NapE/X/h83Knva
teY9XJu3CkcJ/9DnbwVsIIo1Br45HR6JlrXp1nOsDnvtoE5o5wcDfHfnze2s6UGC
05TCpd15iodgACeJtRh7SuhICy9a2N5KSzNKb5cVVrRotaKqdyw8vcgE/lLkuWzJ
gmy9JwhWN1M3RUF7pK9BFto5h/3tIrzc+UZ1XxM9zP20XAaYC1WukUf3+9//z9tH
MFEX6VuEU3PK/sS44ccafaBAe4caWyPXxgHnHWyxIlEx+RO4E2UpcD0myqcRh8QE
jAoZfgDr
=VYaX
-----END PGP SIGNATURE-----

--v2+tklbAy4DcRXdn--
