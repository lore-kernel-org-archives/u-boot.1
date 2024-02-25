Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22267C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 13:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687BE87DC4;
	Sun, 25 Feb 2024 14:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LS5/13BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C573B87D83; Sun, 25 Feb 2024 14:10:17 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F3887DC4
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 14:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-607dec82853so23195367b3.3
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708866612; x=1709471412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bdkl89RSgLtjcsbscTFA9mOMYpzS9V8piHquwKxzh7M=;
 b=LS5/13BMufa5b2q3XG+3WZicWDPvwOtbcF2lAuGyrXLs6Lwrp3uoIQl28g6BffKjqe
 2VTlHys19qQcJd4HBAd4D0Oce6w8G80bRwev8rK94vXoD8KnUVcqiP0b9CxJKhrcm/Wb
 IZgtOBX97TVyeVbgKjpsXFPJX2OffaZJ0wxEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708866612; x=1709471412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bdkl89RSgLtjcsbscTFA9mOMYpzS9V8piHquwKxzh7M=;
 b=gW7uo1aeGGx812oYr7G/MnxNUALi8tkW3GLk4myXWlLssJ06vwGjenK1bBRHpaglqm
 Umm5nfSp6578PFLDZdN/Q+VhxPMvLEqH/j6rV2cl9anMTo+QGabLSGJNtdzU9n3NCn0i
 VCEyel6RG67ZksVDtc4uAYhhff2U8rTHm6frA4opJGQtKQVlb8SiF07jz+pQZOoiZr6d
 oEi8ZI9zo7XdTUFDSRP5p8j5b8HEAim9osUz1b9YxeOB9pGyoNSeQ0NNH9+jNkPn/kHu
 ESWZgJ9cu0B4pL+d+CJ7VYA9vXKRxF7XPSeU446VbirLHBI+kx7umhERgTWq9oxDIHKj
 ri/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqK9+OqZZeSbCiFUK7aoJNZCudDboyYJAFHaC3JAzDu4zdiDI83smpMr8NZ/C9mBc8/4eK/dlOtFlLBe3qb9WErrRrmA==
X-Gm-Message-State: AOJu0Yx5X9r1gR7+KC+XlBMWSgrJLIPpin++xZf5553HCjtqz4diFL9g
 cFdXxCqlPwhSSHwsRc6DMyNGUivlHbxB85ysxc6uGxZ/0xqqDNeytI+LFcRKWjA=
X-Google-Smtp-Source: AGHT+IE9ugt2MqXUS6h//qHZ2odm7EFMZMM4JhRAhUKaW+Oj1bgeI49N1mRBIdyi7fqNpEEsSAlnEQ==
X-Received: by 2002:a81:924e:0:b0:608:f912:c872 with SMTP id
 j75-20020a81924e000000b00608f912c872mr225642ywg.30.1708866612465; 
 Sun, 25 Feb 2024 05:10:12 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 b3-20020a0dc003000000b0060447768630sm723557ywd.124.2024.02.25.05.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 05:10:11 -0800 (PST)
Date: Sun, 25 Feb 2024 08:10:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Tianling Shen <cnsztl@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Bhavya Kapoor <b-kapoor@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH v10 08/15] board: ti: j784s4: Add board support for
 J784S4 EVM
Message-ID: <20240225131008.GD3040305@bill-the-cat>
References: <20240223202153.3756094-1-a-nandan@ti.com>
 <20240223202153.3756094-9-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O603SElXF1dG/hv9"
Content-Disposition: inline
In-Reply-To: <20240223202153.3756094-9-a-nandan@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 25 Feb 2024 14:10:44 +0100
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


--O603SElXF1dG/hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 01:51:46AM +0530, Apurva Nandan wrote:

> Add board files for J784S4 EVM.
>=20
> SYS_DISABLE_DCACHE_OPS is selected in the Kconfig because
> J784S4/AM69 are a coherent architecture at A72 level by
> MSMC support.
>=20
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--O603SElXF1dG/hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXbPC0ACgkQFHw5/5Y0
tywlJgwAs2RmdtU29thE0qBwQ7R6C96ypU/X3GDEjMccd2yVDYuzLvNLyN0eDkJf
8cBjmIcUxagHWkkW1D6g7PzvydZtW/iywcsofhl07VUk8Ct+LR4nfwlE18yhIMQe
Ro/LBmMSraWfpOlQjPH2uXvXlgZEYlHM3xNjnKumAYW1FpoYxdoUVI9ixfCM9D8W
y9hpyWwjngCUlDmpIWyA8CywBQ7NDqf6hwSwOt9X7ProI2U7cU7j/HVs8iJ7dP2r
awUlGCp4YkfrwEDlWycC0UHbDTW3BI5SpdNe1p9GKMxFGn7RDgLj2L8aKFGChNZ7
00XN+Rmf+kIjaQ6nS1tjo0YmrHdl9x28HQG8QMn5dXy8DFkBiV+yhRak/sS4KxSM
8RtDkMaV7Xo0EW++dDFXEcD7a8h2CVImnS2E6OxkvINxjxX7C7Nmlv/cITKvsSuz
crEIRQxvxMBO83BzDstFOV5l0zBVNPs/CNf5AeGPJOF/CRMx9BeKhNnXvuPVQs/F
08G3QDgY
=31IU
-----END PGP SIGNATURE-----

--O603SElXF1dG/hv9--
