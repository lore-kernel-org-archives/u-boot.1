Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854ABC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC9E8765B;
	Sat,  9 Dec 2023 16:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MXdSew1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F83A8765B; Sat,  9 Dec 2023 16:48:55 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E9887215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d8a772157fso25392947b3.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702136931; x=1702741731; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v63WRHG7Rh7997+vhjCcKhv2PlckHAlOD8we4b3fKY0=;
 b=MXdSew1qAxx9J5fbYae8XdfWnWa5N1okXabsAeG7cTBjK03AH5Y/+/NnJyY0bQGdlj
 efq+r6xZdrEJ92bC94fZktxk+mcrvX2YVmjCrFXZfbxqJ/RrF4WQ3GpCyHueBZrV/+Tc
 81PnHM73ZDx1xLulfvOkR/n74LE7swQH7o6wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702136931; x=1702741731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v63WRHG7Rh7997+vhjCcKhv2PlckHAlOD8we4b3fKY0=;
 b=CmGHAiQBrIm4ACy+jin3U3novMKOGKdK69c1Uh88Kmj3wX9twgneKqhxc0yMWnKMAw
 UPGSOZ5txyjT2GZuOL1JUOiw8K7CP/CO194NXAFQTKtM3MXWTXje3uF4R1BSe66ildiu
 iaK2JGqZRILYLDsWVIz3x1gtKAnKKbvRQYz5JnbW8F88naRX353pEuAT2lLrCwIscIQh
 wn5aexRJ0LwzZ3OWtihmFLZrV9mdbxFi9Mh8aaiUUG3hDWDZh+MTkzl4aS1i4PSrClDa
 gnzC5jbKatTkJrQtqq80QtczL0uBeOmXXBst3PtwQyRJNhCNlpDq5+vM30nPxDrj+Vks
 UP1w==
X-Gm-Message-State: AOJu0YygeiWKhCChzpWeo4+FPTC4sZYK6n/QX3IwJh4PWAiYjJivdjnm
 dKEqNammk7Jx2aCUZec9bTeGJA==
X-Google-Smtp-Source: AGHT+IEYvaAn1tXPcuI6HHSCCi6jPT1YhW3h8EXSNjua7Y8GXhGTQuDJMlJ+hOv3L0NP+zmp7hAyxA==
X-Received: by 2002:a81:6e0b:0:b0:5d7:1941:acd with SMTP id
 j11-20020a816e0b000000b005d719410acdmr941205ywc.104.1702136931437; 
 Sat, 09 Dec 2023 07:48:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a81d24e000000b005d8bb479c51sm1538563ywl.11.2023.12.09.07.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:48:50 -0800 (PST)
Date: Sat, 9 Dec 2023 10:48:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231207
Message-ID: <20231209154849.GH2513409@bill-the-cat>
References: <54bab289-477a-41a5-86c0-8647ba2a1610@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CATAPs8HaB9uaLkF"
Content-Disposition: inline
In-Reply-To: <54bab289-477a-41a5-86c0-8647ba2a1610@linaro.org>
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


--CATAPs8HaB9uaLkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 04:02:26PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> A little fix to add the missing DM_USB_GADGET config for the amlogic boar=
ds
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18828
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231207
>=20
> for you to fetch changes up to 4005729c0de234ffcf36465f6471755617b42375:
>=20
>   configs: meson: enable missing DM_USB_GADGET (2023-12-07 09:36:19 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--CATAPs8HaB9uaLkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jGEACgkQFHw5/5Y0
tyzK1gwAmusgUMY+HyPhtjF9Y8HwCtOWYhHPXfMfuqEdCZAomnAi/wt3mZjAIrdX
Ey9LH/tTv8Ga1pVUj0E6SlZhDVlUOG/Uv1vCl8WpwTZcRAnKtg56GC/82T/1/kqt
pZyZRb2ygwW8OroKyIcUt30q71PZvV9KwrMPGTJqER9HH0n0O4NZVsnwAiQZVvGc
tG50lrnY4+T901c7v3KAQ05V0l8hMdeyrPXZfFYw/CFn9LY/A7ikpWp4BCdXv/CQ
0oVVd/6R8Y49hY51saKLmz7DBI7rUYJCws4BD1u6bt9Da6HNzT6oh56JlaMREOgZ
pLENltfbM1bBeh3g0X7sy4SHr94dlc5isuAG0GXrYrt0vI9c9A+W1from2ljToal
bIH4Z2NGVOUSaG3wbCYStnex2cfaqhCHPMMJfdODKNKLhVOvARYppDz2W4l6Vf6x
p74hMTEN90QE3A83AuYSvY9bMW44aEqzskK0jCrweHIv2/KgCzmLjc5QRVDyOlM1
nbUgEQhf
=puWR
-----END PGP SIGNATURE-----

--CATAPs8HaB9uaLkF--
