Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F243C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A638321D;
	Fri, 18 Apr 2025 15:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VjKjmACo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E42283249; Fri, 18 Apr 2025 15:54:17 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B17082A1C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72b0626c785so1453786a34.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744984454; x=1745589254; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pQPs413fztPDUEXJK/mDA9s1AHeX8VoCqcJbNA1F200=;
 b=VjKjmACoxlB4sTduxSlUWFT/OigPtsDTfrOf9ldiIvwfWS0IHlG0Ayhs9HducCRhhk
 6blCZ6u8is2UoHq5zOgMpGY2QeFYqe0P6ZyvaGL786HqmgZofPVdNbEUHrsxycRdbU5R
 fwJPHvCgpCHsECVMxtZRVnrXXaG8DaOjrVLFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744984454; x=1745589254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQPs413fztPDUEXJK/mDA9s1AHeX8VoCqcJbNA1F200=;
 b=SzALCQ88SHHO63HDYNQCbhrbz1EZu9ulEyARvXoZCtniyB3/E3wlXOwvF/djOQkWI4
 tIdSnBAp0cloLXnzwic3mVuEQCRIsP+7jd1kkzj4pWstN4oa6ko6iQnMxmgv8/GxtEqQ
 MvMlLwtanPu/eCIqXTzyiuDfeTToxv40DPioGEQjAjU8bAH2NfDLNYKoHlTg73VOt5G4
 BA18QrcqLJZe1S4PaC/U1icu4RGGYrAS3tzbL3pLNYJYhafvQqX2t+UdjylIxFhdpBnJ
 3em0I9MC1ddjZzhNlCpbOZe6nEBD278TBvCBYDCrMOedStv1sYTw6OA3cg9x1Za0eZjR
 KRTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy3l24XzhZsOF/lV0LzLHkoi2x6YOjExyUmgJPfj41u+b9p8C3Kd3qjleyCBOVqjwiKAuzCmk=@lists.denx.de
X-Gm-Message-State: AOJu0YxkBubVU9AC6CQSJ7v0E1lUPVTXtgLF4nbzLC/xp79/+/raUV6Y
 kWwdx8yRPsqm9yGDP1JQHT6b1hESJlWqeQe4tVg2VV0DL0I91kipdEVMGy2mJETcvLf1NorfX06
 H
X-Gm-Gg: ASbGnctM3NT1v2cltO2q04seUAp+Tls4qoBhlYD21gHbzefJaOzHqPpLnD+0kvVJzfg
 iiLxBQBynqVsZTvrLZXWNOS1W6eDbkMzPGXESgNlozw2tY+9nFNjswusRRIZJt/bj6C/0XclHx4
 W7flrrZQNKFOgwOhbArygXNTFC2de4itXjjd8PToV5jitrhHtKOPZ4QC6SD7X4eVaDMtWWglyyV
 cDy3QEp/sWrEZbs5sHhROpV2dUWYwnl/xu9zLiffl+vyBJgcJlvyg1I3+khJgcC9fz2RcoDs55n
 UesIQqvteBezvSG9T4fmw/NZECucgef82jh/H5LkaukFxXClhxb1xhFeUihuBppWyIdMMxK11r4
 zN5FPGGltVDz+
X-Google-Smtp-Source: AGHT+IF1Umx0b9htDS5/DjqrFIQAnzYkuFSwXbw2av+YIGbu6mye97AwRfGrqIMhc9XLKGzGOiVcHA==
X-Received: by 2002:a05:6830:2aa1:b0:72b:9dc8:7f30 with SMTP id
 46e09a7af769-73006326396mr1510175a34.20.1744984453945; 
 Fri, 18 Apr 2025 06:54:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047afafcsm344922a34.17.2025.04.18.06.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 06:54:13 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:54:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Dockerfile: use QEMU 9.2.3
Message-ID: <20250418135411.GO5495@bill-the-cat>
References: <20250418025743.529973-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AQpfNF9BogUxxsLT"
Content-Disposition: inline
In-Reply-To: <20250418025743.529973-1-heinrich.schuchardt@canonical.com>
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


--AQpfNF9BogUxxsLT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 04:57:43AM +0200, Heinrich Schuchardt wrote:

> The RISC-V emulation has develop quite a bit since 8.2.0.
> Let's update the QEMU version.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--AQpfNF9BogUxxsLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCWYMACgkQFHw5/5Y0
tyziIwv/ayiTcOPLcqpjg6UkwDzPNjuSIons7z6xZxXcuoxCJBq6O0Y0cou8TRX4
echqLwMTT9nObPmZ2S889B8CzncrszF77Z2+zvZb6fBxadd77EVe/OhloCHTNCfy
WNCSqJdxasKzlENRUIEVQAKZOw0HPMYiC+BKXJnYumolWRR1fpX+EEw/4/QQ53yd
yyJxlMwDPGtlywvHOupKLCcDdy4tvo8wBTiO3Si5yIwlZ8RdQLLB21d7qjdqMfEm
w41vUBpiAXTitXU2o296eaMgqHYAA/RgWCbC0lp4SnW+WIJ+aV+2X7zVcFkIW7oq
e0Plwa2zMa/AnuWLnH0ykMneFSXUZv0kZTiZBLwXRpNjgefOxLWI0PL9vRW/qG4l
iYLA7t4FqjCFDntn4hpPPEJGZDXGVbA0oTAbo7yJaXx8NxisXPWJq3xWlEKHktxP
wmkYlifASt33JTLQb2S4Z+mEToAgDg1duisWW2hGQWZnJwfZm8LtjPatdQ9/4/r9
bYnCPzpP
=HiJJ
-----END PGP SIGNATURE-----

--AQpfNF9BogUxxsLT--
