Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF02AC54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD50388028;
	Tue,  5 Mar 2024 00:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LMbO0Jql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55AF87FFA; Tue,  5 Mar 2024 00:44:54 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59C688025
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a132ce36ebso849461eaf.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595889; x=1710200689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=unVBoMzUpr/FRBffmW9qjvVtaCZgSt15lfD6OwIs8sk=;
 b=LMbO0JqllAWQeM39iNlzDtS5pfIrWCXt2+D8c8DCXd5lHuDA88atNUOEpr30kWqQiH
 C7qt6LeEIbhFpPysAWI0VDhiQaaYYsnbSVHKgzAV3DHDXUsK0VZET5LHJEwwLdVTZ066
 59zQFepPTrJ8ygUIaVLcyZu6n9vyC/dEeW3h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595889; x=1710200689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unVBoMzUpr/FRBffmW9qjvVtaCZgSt15lfD6OwIs8sk=;
 b=VNFbQ2JlGABHF5KRtnq9FrVtV0JsYQJPr3THp2zOiBOxi9MuzJ0tH2R7HefwMLR2CT
 eNAHHH7U9h/LdfXkMcjRR/+NcpdBoBbWgYwidvkiLVbwoRWyO+c2d7CdFYrvw+4KpZoc
 3lww0jiMLRhIJo770yY1Sd5e+f3F4bjYepq+0SsOzheojZ8/iT8OHQc76ozGuAg82dFr
 dYp4lZeb37n0wq7Fk7lgJBWMYOWh4fWTjrnVObm9yxe8nhelPU1U2mDtb1ioFDqCuNMB
 Zc3yjvELcCCWCy6CPK6hLPlNxeebAJlt+yKEYRp5P4kbt08hSfarR4+90ni3PbIeyO+Y
 c1sA==
X-Gm-Message-State: AOJu0YyLKXJ9V1PiJFD2hiVq73E6M72S9e3y25Uxn8zA2zg/3mU13Efs
 RQie08GASJ14F/3xXOX7pDllmRaaxx0d8oFM+iIcLTW0E5oiLWqlATxOORUsRyf/MUkhWweOiKC
 O
X-Google-Smtp-Source: AGHT+IEKjwVtC1Z0xfy+AjAQW75lrWVYmfng/jpIlrPUdmYkCJNWUu57d+WGfvVvHcYRR99PAUwrFg==
X-Received: by 2002:a05:6358:7422:b0:17b:ee7d:f957 with SMTP id
 s34-20020a056358742200b0017bee7df957mr260977rwg.15.1709595889509; 
 Mon, 04 Mar 2024 15:44:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05620a15b100b00788287e3430sm1410501qkk.130.2024.03.04.15.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:48 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240304
Message-ID: <20240304234447.GY1523872@bill-the-cat>
References: <20240304175251.823846-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SeAV3Gp1Gq0iZIgW"
Content-Disposition: inline
In-Reply-To: <20240304175251.823846-1-festevam@gmail.com>
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


--SeAV3Gp1Gq0iZIgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 02:52:51PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit eac52e4be4e234d563d6911737ee7ccdc0ada1=
f1:
>=20
>   Merge patch series "ARM: renesas: Rename R-Mobile to Renesas" (2024-03-=
02 14:30:25 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240304
>=20
> for you to fetch changes up to 9b9f022e7368cacafa368beaa7fadd931f2cfcdb:
>=20
>   video: mxsfb: add back imx6ul/imx6ull support (2024-03-04 08:18:48 -030=
0)
>=20
> u-boot-imx-master-20240304

Applied to u-boot/master, thanks!

--=20
Tom

--SeAV3Gp1Gq0iZIgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXO8ACgkQFHw5/5Y0
tyzYdAv/dujOwdoM4TN4tRv07FjKLxOdKE+UX1tw3qlXnCeG/b6XY2b9vW1X0chP
vi70+kMaoDbcVZyp3E7hvLbdCFAcJNuLLYBxMYn2PFqdD71XDYeAPHWZDQ7FoUWe
QyNtxrw0EsSY59mFEAYdQr+d/zs6OvnQE+ILIFA08VnrME6fmjVkMIcViSQe2BNw
YUxLKtN621JPQKdaK2OHhjL3FZNWmA0B+Y0MYyGsQdNyRHM+a8YsCPzzj3GEYAkh
zxqrwB8aK49zVDTlyDZJTStZ39NkeOa70ec8xBvupi61EbCCVafV3BAldXeI6oUR
zMDPy+c1xsLsgjuXVxmDITpvtcg0SvYPNu7ILcIOUAEsUfhr88r6nZd+ZmvDvWVC
TrbSBh0oUVsDqTMsmQwkLd3W1Gg6yCcHQta1u4rAF7bx6JmsINhfhRiMkx+oUuKS
C0fbgeK89Qs6Gv2dgLnNqT1mzrRyylEI4eFfHBKQYilm0J/K/08uenR7u6diULEV
6DLL8auv
=Tnj/
-----END PGP SIGNATURE-----

--SeAV3Gp1Gq0iZIgW--
