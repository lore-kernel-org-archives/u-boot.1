Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC3ACA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FA68399D;
	Thu, 14 Aug 2025 18:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4eMubms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467D7839CA; Thu, 14 Aug 2025 18:32:18 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C7F8391B
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3e57008acd8so9465225ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755189134; x=1755793934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KTUfsdRt9imfWvjw5CJOFVsRrbllapL+6j6qR2mFrYE=;
 b=N4eMubmsAlmm1KLWB/DSKBWSsa1nw0G05FOOALHmnX8GBKuEzsbUs9EbaCyAHwWanS
 W/OonJYB18CKaqfsgbyDOkAb2+U2Qubq+8PeFvbzO4mpcWbB9OayPwuc5C+0Q9xfdixQ
 KNvHvzYWFAEWDdoXppt36tDjUw7/4DGThWOnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755189134; x=1755793934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTUfsdRt9imfWvjw5CJOFVsRrbllapL+6j6qR2mFrYE=;
 b=W772heAxwPFDOovYqFTyqx11tg+dUZa0aKRj9i/bfrgW43vpMuIIpsZtpi5dmHbdDA
 +Q3h+ViTC5EwhXEcIQPFgaGse0UCqy+zvGNq5WHiYthYZlwXzRW1exmRGhS0hS7HkJei
 iMPuZ9zkCRgGWqIwYZZBTDvEySvdnXhHsPpA+32F591sczUtPaMtEKqFPXhA4wsoG5ls
 i4OAUWwFpjDjgfXPweb2sxw48ZA6i8VchtRAIxysNoeW+PZ2m7yDiAlNrdmAxNylXAr/
 7myPSvRWp9g7LtbHYpaFShIwHoq7TWlRLjYm6a3Ti37GKkd0NfzNjct6rom4d/AK1cG2
 28Sg==
X-Gm-Message-State: AOJu0YzOPp849e37fG/dKx6Wlehwv18IdvrzGWPlJI0fY+ixLvEKPowT
 wQyLXQzY5s/DbQ3kLJqBuoAVuS1B73/Blryele/ow+96LMOd9mXHrcKp1Mc2HlpA/6b9ZPh+c0b
 VGTZ5cAM=
X-Gm-Gg: ASbGnctwIkC6jkXbCMLWKPdfaBpEyXvPcoIBotKlA+wNxWdTo0iQBScK6ILTM7jZgQb
 VIcuBP6MwUL4+aFQLIsbhJVrwikt1vGYE7AXKOpzztgujyUIeNdksctcUtsNGu4kmW/EP7jpC08
 uskO/DOLWtDs0HDM1jXLkbHbkz7krhbUIeYrPgXas9AvEfc0SIZh0neM3ZWi+INM+hc1dw4osaX
 NYOq0bb2yJTySRTzxbPV//z5rt9Nz3toGu7sp5lIj5lO+fo6xMnucpU7UOMAg5TXugMcZ7saRFF
 hRN+ZbwFLPYXIJuSS2kC4gGkGPalcrrmINvyHTQ6ETShxJTf/O5RNa5NwuT/I96uP13AoOelcXR
 KUTOaTEGABoaYyEcZ0Se7MKvCPq+aRMNK9eDLImm9lqydQVseMcatzoPN
X-Google-Smtp-Source: AGHT+IEllTrJfFOQR8iBfhlb0+WMcGEoqSzlCrOc9GzWLiXbS7d9V4S02dWQvLOs1CZtQsyuzftrHQ==
X-Received: by 2002:a05:6e02:216a:b0:3e5:4447:5eaa with SMTP id
 e9e14a558f8ab-3e57076e5ddmr72240365ab.1.1755189134274; 
 Thu, 14 Aug 2025 09:32:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e56053a60dsm24615415ab.48.2025.08.14.09.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:32:13 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:32:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com,
 heinrich.schuchardt@canonical.com, ben.dooks@codethink.co.uk,
 jamie.gibbons@microchip.com, michal.simek@amd.com, sputnik@on-the-web.ch
Subject: Re: [GIT PULL, v2] u-boot-riscv/master
Message-ID: <20250814163210.GL124814@bill-the-cat>
References: <aJ29JN0YOKGS5tBn@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="57PSdRcFerxVJHV+"
Content-Disposition: inline
In-Reply-To: <aJ29JN0YOKGS5tBn@swlinux02>
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


--57PSdRcFerxVJHV+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 06:40:36PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 869217ee2907595919261b6d4ae81fd76a8ddd=
81:
>=20
>   Merge tag 'qcom-fixes-13Aug2025' of https://source.denx.de/u-boot/custo=
dians/u-boot-snapdragon (2025-08-13 08:57:49 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 35d6caad6de93b3a5545df7bcdc6d322a4edb93c:
>=20
>   arch/riscv/lib: update memmove and memcpy for big-endian (2025-08-14 15=
:33:00 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/27379
> ----------------------------------------------------------------
> - Board: mbv: Prepare MBV for CI
> - Board: MPFS Icicle Kit cleanup
> - Board: Add Andes Voyager board support
> - RISCV: Update SYS_BOOTM_LEN to commonly used value
> - starfive: fix return code of `mac write_eeprom`
> - arch/riscv/lib: update memmove and memcpy for big-endian
> ----------------------------------------------------------------

Ugh. Does RISC-V still have some reason that fdt_high / initrd_high need
to be set to disable relocation? I thought that had been fixed
already...

--=20
Tom

--57PSdRcFerxVJHV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ4PhwAKCRAr4qD1Cr/k
Cv/WAP0ZH0z2BGKRSK6tLkA0yC19r2e0ixtvjwuiZIS8Ski9pQEA5dHVMTFBujod
4qYEgv+lErtdFm/u7qqI9O2sdDd47Ac=
=gbj+
-----END PGP SIGNATURE-----

--57PSdRcFerxVJHV+--
