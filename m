Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E679ECD9B5
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 01:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4352F83015;
	Fri,  6 Feb 2026 02:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qn59RqzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BE583AA4; Fri,  6 Feb 2026 02:54:53 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9B880086
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 02:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6610b05b37dso1312637eaf.2
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 17:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770342890; x=1770947690; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GPzyg0mPSG9LixM3ash0O2y1ha5upV9JjS0pu+XM69I=;
 b=qn59RqzL7R/BNr9n/up2AJHOKRtgtiFJId+moAg9dWmYs6hePE3y5Ucas0DvDNwmLk
 otUYB6TTVto7znM3NNOqzofieyT4xTRSAEQve0u3VvjbviNGu9/NEnccnOSGE6Rc6lNl
 Wf78+jJ7jU+Cff1uMlTnDe6Xssqs3g35EIY2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342890; x=1770947690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPzyg0mPSG9LixM3ash0O2y1ha5upV9JjS0pu+XM69I=;
 b=X2xWo1pwD7t6s1yuQDZ6Hv+8Ucuxy4QoG+MfbMGevgV0/MLe69UuiUGS950DIeLKIA
 f4d/ZBc9+6Sp9PGq9a2GFhwQSd7bPj7J93OtZgf7yinJTo9F2D2t/8zWhivXUwpGau8M
 HGKzSAJUq2clCaNNyFklqEhtNOhTVWQCvrjjYK9LeTEiStTCRUAYIFm8ddiDTaV6a6Kf
 knsCbSCMs5s8TtQkpj4N9jbfjY55vSGeFhNXRDns6lQs9iT/7EP1eZealiSFwY/0j8MC
 xFmMhMVR1hycU9W9BFmRa8M54te3LyGUJ6PvRpEjKCPl/DPav+87UZALuG9FfkpkieZs
 otFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmRrvO9WmY8062rE+Kt5UDBQoem6472tYEVYuSIbNnoIWy9dO5DRG1BrmkZ26NvXtcq4Tril8=@lists.denx.de
X-Gm-Message-State: AOJu0YwKdpHZVQa4iVJ+dKMvmgkZEitMBSaXX/Y6KQbe61SltAgSCPgm
 mwCo5g3yFP6yC6JQgng++tJL/5kSqGpxg/cpr3povdCUE+vc52hObWNr7GHWfkQNUJQ=
X-Gm-Gg: AZuq6aJ1QWpz3FPkFxmZeGRDQu5eWveCjzBOBEOcNxGMWGTfWdgbsnbpMwvqTqHCaXe
 rILqdR80yBKlTKLEOkpoLct4p2yvbAx7WjAW6IqtbaFo1mNXwEjiCtckwyjqi7NsloapkAfgM3I
 Z/t13b5FTM/IxaAeuN6XeiLsOoMtMf5JRubz7CbMZvzlN4xM5QDz7+HfwRxfJCAVYB4K08BdNYU
 kq11JI1us9TuuYQxQxQZryOM4Z0GXMZSGO2/jQn0upHaw1ytWq8kF4Faa3nLZUKN8S4rOxehi2J
 ZoUDK6K98dW9YRNmSxoQ7yX4TYnFP7pBf5rcU5o/QDR5B07Iw4CO8tHVnMlCqxRv/1Ke6nMCeHj
 V7x2JgIM3VujnuofKUQggiD+vhADiwnb9211vbjC5EAj6hkh5Z2YjRmdUHrYR+6ysoxNYlGA9GD
 qKL3bKbWsfjBkCd6EY1tep/HxiExflcFZQrAZV4i/RYOeEE5UuNJQpjxOLpWwZ5R+i4bTMK4iv7
 LUHfc1f3HNFrZrztfl42lcFMyGFWu+T52WoENc=
X-Received: by 2002:a05:6820:4a87:b0:663:821:24cd with SMTP id
 006d021491bc7-66d350d18e0mr368754eaf.63.1770342890329; 
 Thu, 05 Feb 2026 17:54:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a5aefsm421728eaf.13.2026.02.05.17.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 17:54:49 -0800 (PST)
Date: Thu, 5 Feb 2026 19:54:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
Message-ID: <20260206015447.GP2603314@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t/iPE/s5tlYp5ZLf"
Content-Disposition: inline
In-Reply-To: <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
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


--t/iPE/s5tlYp5ZLf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:20:27PM +0000, Dorde Stojicevic wrote:
> Hi guys,
>=20
> and thanks for your fast response.
>=20
> Sorry for the formatting issue, I am bound to our company Outlook, which =
hard-codes our signatures, so this one will not be possible to take out. I =
am not quite sure git send-email would work, for the same reason + corporat=
e stuff....
>=20
> Anyhow, an update/clarification on the things going on here (I could/shou=
ld have sent initially, sorry for that):
>=20
> 1) Lynx Toolchain compiles a FIT Image with the following structure:
> 	{
> 		Images{
> 			Kernel-1 {
> 				Data=3DImage;
> 			}
> 			Fdt-1 {
> 				Data=3Dsystem.dtb;
> 			}
> 		}
> 		Configurations {
> 			Here kernel-1 and fdt-1 used as default conf-1
> 		}
> 	}
> 2) Data=3DImage does not have the Magic Code 0x644d5241
> 3) It is booting with U-Boot SPL 2020.04+g1ccc9d93576+p1 according to Lyn=
x. I haven=C2=B4t tested myself since we started with 2024.04, and we need =
it for some other features.
> 4) Then I investigated differences v2020.04 vs v2024.04, and found this p=
art of code came in.
> 5) The finding is consistent with last error reported by U-Boot prior to =
reset "Bad Linux ARM64 Image magic!"
>=20
> 6) I 1st tried patching the Data=3DImage in Lynx FIT with the magic code,=
 but it didn=E2=80=99t work.
> 7) once I patched bootm in U-Boot to skip this part and behaves as in v20=
20.04 (excluded all restructuring etc.) it booted the Lynx kernel
>=20
> Basically, v2024.04 correctly detects "Bad Linux ARM64 Image magic!", as =
none is there at the moment, but in order to boot Lynx Hypervisor as-is thi=
s backward compatibility to v2020.04 is needed.
>=20
> Does this shine more light on it?

This is helpful, yes, thanks. Can you provide an "mkimage -l" of one of
these failing to boot FIT images?

--=20
Tom

--t/iPE/s5tlYp5ZLf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYVJ5wAKCRAr4qD1Cr/k
CrpOAQDvsM07GJPJpPZFV2TI8EKsQkYCdagCrnO7LPV/xuto8AEAmEhfRxccvnbM
OFWxZEGcggyGZRX9A1r1demzG0to0AM=
=zU9S
-----END PGP SIGNATURE-----

--t/iPE/s5tlYp5ZLf--
