Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79937C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 14:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4B287C61;
	Sat, 24 Feb 2024 15:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YlbjWJ0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D5F87C68; Sat, 24 Feb 2024 15:00:11 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63588751B
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 15:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dc6cbe1ac75so1440240276.1
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 06:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708783202; x=1709388002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rDuRoPo80gvzRbRzTUWSpwlYUaaAG72jmZ3RyBrQwX8=;
 b=YlbjWJ0clskS+kse5ZS9brxih4vHx+KCy1NmsM6THUFrE7M2pz+Ybzcy5q81wC3c6j
 Hjp8DQJ+RoSMtnBsXjrrK8qx24xMT406C7nNrPbrsV7S5e0DRM9XRc+sqx2kBOx6hTla
 9sMacZQH8RmxawNBaOL4dXZg7ZhYKj81eVLjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783202; x=1709388002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDuRoPo80gvzRbRzTUWSpwlYUaaAG72jmZ3RyBrQwX8=;
 b=ul5cXzu7X9KXub57SSzvF1GZhpe1MXPhG1VhfbalDNTSRK25BO6W/blt9u6kxe2kE1
 CbcKWrRN3PMiTUOYckSmLemkrY5FNrVc+sVprT9gdPyLpgosxMMklJuyvGgAuIjJwI1t
 16RISb5rCyjEg6yIxbvi9SLEfi6tHKvCH9eyKYlZlhVKoqSYnmfQ484bLZwdmY/NGDAO
 KvMhVRo1sXEStVpwztCCyeRTmrjuV+Vz8gFYyYsFLZOgQ57/s9q7CNfuO+oVrD5SWaH8
 8WangPg0r5P7GlZ5meJi4bpWwWS9zhz/jqZ+rBbqd4UP+hOzq39U3M+WzvtGCEdMbRni
 jdSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPMl3kihHhluxbZDg7I/hNh/39vS6JJsZGPT9udiFFKfnFOQ497lxt8LSHfj5xb4pMy7aZ7lUGm7VMS4YJIOeKfV5LsA==
X-Gm-Message-State: AOJu0Yyz0WZRlqfwBXcgxIL9lq0iGKW6OPtzomsG1sXld+9nuVWrWCWw
 Al9ftZ9w7aTJ3esx79Vjtqd8Vt10Gw70XIJZVBSeEXvV2AtFRs7g+2hl7BlPiVsAKJg4mT1ADfH
 w
X-Google-Smtp-Source: AGHT+IGdtRmUbLe/x0M5DMDE+4xRTW2tnPxenCsU1Nf/KdMUyslkPTR0u3t/ZoIngzXI/Q9DUZtxBA==
X-Received: by 2002:a25:7bc2:0:b0:dc2:271a:3799 with SMTP id
 w185-20020a257bc2000000b00dc2271a3799mr1520644ybc.23.1708783202206; 
 Sat, 24 Feb 2024 06:00:02 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r11-20020a25ac4b000000b00dcd2c2e7550sm217522ybd.21.2024.02.24.06.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 06:00:01 -0800 (PST)
Date: Sat, 24 Feb 2024 08:59:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support in
 SPL
Message-ID: <20240224135959.GC3040305@bill-the-cat>
References: <20240224001702.2283727-1-j-humphreys@ti.com>
 <20240224001702.2283727-3-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/H9xT46N3Xp2qrDN"
Content-Disposition: inline
In-Reply-To: <20240224001702.2283727-3-j-humphreys@ti.com>
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


--/H9xT46N3Xp2qrDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 06:17:02PM -0600, Jonathan Humphreys wrote:
> Add bootph DT tags to enable OSPI in SPL.
> Set OSPI regs for R5 SPL to address OSPI's boot region.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 16 ++++++++++++++++
>  arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
>  arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 16 ++++++++++++++++
>  4 files changed, 42 insertions(+)
>=20
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am64=
2-evm-u-boot.dtsi
> index b843078243..60b219c0be 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -182,3 +182,19 @@
>  &cpsw_port2 {
>  	status =3D "disabled";
>  };
> +
> +&ospi0_pins_default {
> +	bootph-all;
> +};
> +
> +&fss {
> +	bootph-all;
> +};
> +
> +&ospi0 {
> +	bootph-all;
> +
> +	flash@0 {
> +		bootph-all;
> +	};
> +};

So this gets back to what I was asking in the first series, is this
needed in SPL or full U-Boot as well? The bootph-* properties are
supposed to be transitive, but originally the tooling didn't handle this
and now the tooling handles SPL but not full U-Boot. Which also brings
back the is this _needed_ question and is bootph-all right, rather than
just the big hammer?

--=20
Tom

--/H9xT46N3Xp2qrDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXZ9lwACgkQFHw5/5Y0
tyytxgv/Ysf55991/WuCEqaSmlTHcDzH7D5x08QA7l/NNcFLUpNHHAUbEWRbtIIs
9gmVYHnNiQP2IFeSKatjridfhI+HE7NzzbrTL4hmb7Sig5mueIeFEjCB+M+742o0
0kH+9NNZfcDdFAlj/jadjcfXmYdeSlyYoHZhhZxhmSE17Lj8T9sRE8dB90AlDseU
MhOMsIK0c3rdooKGTjaiql9QTrz1HH3M7wFY2K8I6ClqN5ldI/UZYICFOXLu165B
B0FwITQTLJ/upqlJD5eyXIWDe5xhJ+4/alQ1vU44U4XuP1tVN1AnxnQCWovjWXZA
erLGfWg/oAJXN8e1/RGsy+Nx2wTqdYmq0VnRiklTXTOnxiPtjj1r+8FGkVnjL413
SJOVuUVZXqahAeRoYNzYoZcw5uQ4wBV+8LODjk3u+y77gwavftvaHMU4MVXZ3GKH
RL8wJQjlDdtgK2f/S8z0CJ5KsCvfLGz6Oi15j4BvFjMV+q3joA3X7UMqIXMXZCFo
wabCxnmk
=xeX4
-----END PGP SIGNATURE-----

--/H9xT46N3Xp2qrDN--
