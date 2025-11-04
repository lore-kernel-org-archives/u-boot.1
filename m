Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE46CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8454D808AF;
	Tue,  4 Nov 2025 19:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="flSC42uW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71258004F; Tue,  4 Nov 2025 19:29:49 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE99C8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c28bf230feso96923a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762280986; x=1762885786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EptemAln7v6JmrPZ67BoI/rFbZiuwJlX7MITgD7mC8g=;
 b=flSC42uW1Vyjja3vxVMmtfdx8HUYJ7T0CHMbrLdmSya6Z9z0+BxlucJ4uJwb2Elx/y
 JxmuL7NUIXC31AdpYG96CMbWiPmugENFEcB8lXumxj+Ro6MG/8c1TYl3bwWivHB1NqSN
 qWtRt5Cy7radhziZxxMuy7sgd9P5kRkwpw8z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762280986; x=1762885786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EptemAln7v6JmrPZ67BoI/rFbZiuwJlX7MITgD7mC8g=;
 b=SXIAfW67HTyCyo+7F6Ldv9z2zN6rXbrAj2ldkCVTxROwNb4CuFeNkf2GJnWoMzRV/k
 UIKlxkB0sv6tU/vudj1tDB8jzMpT9px4wRbZh3Nvzii79f31hOgsnV+lGaz2g4B+7jM/
 jJQdBLdtIj2es2lMpGjxWLi5fFANFMRpfhNNwfFHfXx+3Dip8p9/7egW3Zrb7PGl/K/H
 2g3ZUVvZck14yaEjp33IDOxrDLYpqpGk3V586WffA0UXhPgzbQlnfjo3cV6i/8jXl7iR
 Z23ZeuTGMyNnjfoUWu6rtnu/HaUI6wayRCbK3WLeuKb7pkjivJnPX8T8roodHkTLJ2Ej
 wJCg==
X-Gm-Message-State: AOJu0YxkjHQuJTeIEfaoa7OY2CfFp/0tCUVzKTasy3LUSyxafU48qj2P
 w1qFEA4iR35U7EpjpRMqPLS+Yew1cXrMqaUxWqdEWgTGAIwVfNCbU0P3Gbh/hssiRRvsWgcQPeQ
 /M+v3yHzhhA==
X-Gm-Gg: ASbGncvkicmlY84vpEf3/6YQxNEYMdSvjnII01+b1lt32G+bUuPBpbwVbbA9ITs1C0C
 sWAGLJ3NN4s5dfO1xnHMi8Nbhlq0M1Umgno2YpGJ+G0NOqv4qeh3gYs5v2sbcWrHpzvXrvK5j5S
 kQZ2eEUvhya6A6ho3cegr6UASTCKsJsfL9V/9gBrxXcpuGTxZraJb63RjknckjzaYDryCW1n0J+
 CCkn3uDR4N3RkrfiTh19uIzyQ/JvNGAckJRXp9Ek+NecEZhZ0r4ypLZ1Xx/msZR/2AW4V+YoJv2
 WO1RZ6g6Jm/lLEnRzmc+ytQVER//57NMoIutQy6wf1hyFZzHb/e/rExbXed09+eH1WlhwAYN6Aw
 v/iEFzl5JCVV3NsXSMWz4B6GdXb98DVn6eiIS9fncxKrYRIWLqOLp98RiQwstnF1r3BV35hfa4u
 lmArqU7sqWrLagFT6zRf8E0njlffmSDcK8RfIi6i0=
X-Google-Smtp-Source: AGHT+IHKua1o6afgCvDAHZNzBxIKOU7nIsdizedG9GHyBsSh6Dt4cLvlh9Q6O/MqC3CTtGfJYjzOvA==
X-Received: by 2002:a05:6808:6f87:b0:44f:b05e:2637 with SMTP id
 5614622812f47-44fdc0560b4mr1907237b6e.31.1762280986292; 
 Tue, 04 Nov 2025 10:29:46 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff6f61187sm1284585fac.13.2025.11.04.10.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:29:45 -0800 (PST)
Date: Tue, 4 Nov 2025 12:29:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] configs: Add rock5b_plus-rk3588_defconfig
Message-ID: <20251104182943.GF6688@bill-the-cat>
References: <20251104182523.2142120-1-bryan@bryanhinton.com>
 <20251104182523.2142120-2-bryan@bryanhinton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DMXcaoTChTVVZmFi"
Content-Disposition: inline
In-Reply-To: <20251104182523.2142120-2-bryan@bryanhinton.com>
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


--DMXcaoTChTVVZmFi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 12:25:11PM -0600, Bryan Hinton wrote:
> Add initial defconfig for the Radxa ROCK 5B+ (RK3588), tested on board
> revision 1.2 with 32 GB LPDDR5. This mirrors the existing ROCK 5B baseline
> and uses the DTS from U-Boot=E2=80=99s vendored Linux snapshot
> (rockchip/rk3588-rock-5b-plus).
>=20
> Build and test details:
>   - U-Boot build: 2026.01-rc1-00232-g0673831a738b-dirty (Nov 04 2025 - 21=
:18:07 -0600)
>   - Toolchain: aarch64-linux-gnu-gcc (GCC) 15.1.0
>   - DDR TPL: rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
>   - BL31: rkbin/bin/rk35/rk3588_bl31_v1.51.elf
>   - Boot medium: microSD card (U-Boot image written via dd)
>   - SoC: RK3588 (8=C3=97 Cortex-A76/A55)
>   - DRAM: 32 GiB LPDDR5 detected
>   - eMMC socket present but module not soldered (controller still detecte=
d)
>   - Verified: SPL =E2=86=92 U-Boot prompt
>   - `mmc list` shows SD + eMMC controllers
>   - USB EHCI/XHCI enumeration works (`usb tree`)
>   - Control FDT present (`fdt addr ${fdtcontroladdr}; fdt print / model`)
>   - Default environment: `fdtfile=3Drockchip/rk3588-rock-5b-plus.dtb`
>=20
> This configuration reuses the ROCK 5B base defconfig with minimal adjustm=
ents
> and builds from the upstream DTS snapshot. Follow-up patches will enable
> NVMe, Ethernet, and saveenv support.
>=20
> Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
> ---
>  configs/rock5b_plus-rk3588_defconfig | 118 +++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 configs/rock5b_plus-rk3588_defconfig

A thing we don't talk about enough is that defconfig files can use
"#include". So how much is different here from
configs/rock5b-rk3588_defconfig and could we instead do something like
configs/rpi_4_acpi_defconfig does to just augment an existing defconfig?
Next, this needs to update a MAINTAINERS file at the same time in order
for CI to pass.

[snip]
> +# Minimal first version; follow-ups can add NVMe, Ethernet, saveenv
> +# CONFIG_CMD_SAVEENV is not set
> +# CONFIG_NVME is not set

Please don't include that, and make sure this is the output from a "make
savedefconfig" so that we don't have noise in the file later when it's
resynced automatically. Thanks!

--=20
Tom

--DMXcaoTChTVVZmFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQpGEAAKCRAr4qD1Cr/k
CuzsAQDAFHFIYOWimKDhNBAnr2TXN+ZsSCWtALWax9bgpcSsygD7BiQuc9Vl8s5q
ljkkLFMEiHojisU5pODDmsffZlhEtwU=
=sKdG
-----END PGP SIGNATURE-----

--DMXcaoTChTVVZmFi--
