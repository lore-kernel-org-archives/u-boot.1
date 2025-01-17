Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBAAC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 17:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77CE8069D;
	Fri, 17 Jan 2025 18:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mI/6vffY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DAB8069D; Fri, 17 Jan 2025 18:56:37 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2048073D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 18:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so210632285a.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737136594; x=1737741394; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+uVYVMY2M3jTbI/agj8RmYisEuXXX4IoHHODL6B93Ro=;
 b=mI/6vffYh/sopjsSe9k4pFHER2qwKV0Be5Igo5vIDbckHE8BYh/ZJKj9T3z2IA9D5V
 oXxrPne4iREe7DhKgDZluixgZlQ2V+kf27DhaUjnj7JhO5n831qrNyxThoENC0PJMjNY
 FiwFEWoKpotfM2sHkrKZ9U4gjQEIlInSUFkHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737136594; x=1737741394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uVYVMY2M3jTbI/agj8RmYisEuXXX4IoHHODL6B93Ro=;
 b=Xq2qI/bZbIPWLLaZNH6LeoKXdE5q6L0XuObC+NiCdB2Y2Nwi+1HumuHY7HjXaPhnz0
 0LfLZDbyXjLmY8wwvWoo9vIie/6BoFei5FxU7egiNPCpsk1emdu/Jwi7PYZ/G8qO7HpF
 NxTWuwpBPOQW2uVvMGNKbnu+HxoAWj15fAm2eGg3nZxjsGKOB7OSSeKvPcyBqjZNH9wW
 CWseDwBc15S76BRcmBuBSprX72XIghbopGo6XYdOruzD0oxQ9xX8iOSyV8iDF+HaUa7i
 QGWhxZHTxsqLp4HR2dkAoGLeJAtN7voMpQSy+sTMlB5NwD42v99ze22aZUhX1sORJJO1
 n3xg==
X-Gm-Message-State: AOJu0YzWqM1Amq/N4YF4UKS08WxjobgbJhBUP0JaU4NoaiaXKoL8YEap
 BurKXHCV6jovN2YGTUuxeEoYI/SHCrB0veUbQr9H8sNCsmhaGW/elLLGwgVc8C4RVAmWwU0G7lu
 iF94=
X-Gm-Gg: ASbGncty5JMk4/4tpyxWkTZ8UcSx7589D4X3IWFB+CUzEAE6FvcCmQLtq/n09RVpZmT
 SFfJhDXv2gY2R7vI8QmjSmzOhbeSBe/GMLJGYK2H5kL790OZMU9WCkz4i9vj23XdoWA9R9+fIE3
 yC2JMcImPKr6EgRMVSDduygEDZGyey4fd84dNuwwmLTsz6Lw2fLEt//Bugs5BsJtubde0yaZyS0
 pgzPnhBn+JuIl6ZcZN3oUeTTl3JhB6eZLtoHhfZWRneUg2kLOsfWg==
X-Google-Smtp-Source: AGHT+IH1NJg1+Vqx1w0Hl9kOjCd4iGcWNF9ssqN15fYPjuOHRIrzryJhzfKA3Lg765SWk8eaSzZEig==
X-Received: by 2002:a05:620a:f0f:b0:7a9:c333:c559 with SMTP id
 af79cd13be357-7be63289330mr543451385a.48.1737136594357; 
 Fri, 17 Jan 2025 09:56:34 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61473c98sm135986185a.19.2025.01.17.09.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:56:33 -0800 (PST)
Date: Fri, 17 Jan 2025 11:56:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: Uboot Open List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>
Subject: Re: [dt xgmac binding 0/1] Add Synopsys DWC XGMAC Binding
Message-ID: <20250117175630.GU3476@bill-the-cat>
References: <20250117025405.6206-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2LkMnlm9m8RLKywc"
Content-Disposition: inline
In-Reply-To: <20250117025405.6206-1-boon.khai.ng@intel.com>
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


--2LkMnlm9m8RLKywc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:54:04AM +0800, Boon Khai Ng wrote:

> The proposed patch introduces a new binding for the=20
> Synopsys DWC 10G Ethernet MAC IP block(XGMAC). This block is
> configurable and supports a wide range of options, including
> various bus types, clocking and reset structures, and feature sets.
>=20
> The patch includes the essential properties and optional
> configurations to ensure compatibility with different
> hardware setups that incorporate the Synopsys DWC XGMAC IP block.
>=20
> Boon Khai Ng (1):
>   dt: net: add DWC XGMAC binding
>=20
>  .../net/snps,dwc-xgmac-ethernet.txt           | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.=
txt

We need to just use the upstream binding here, thanks.

--=20
Tom

--2LkMnlm9m8RLKywc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeKmc4ACgkQFHw5/5Y0
tyyB1wwAq/6w2H5usljs3/PAch65xZhNb7+7u5CZoYORQpzhOhR5LsPpX0xpBFk2
k/IDgFRFcHlO0+ohHum+MCI7thx+esuq5Qn8Pbpj3fq50LsaSV18HHB7CbsSK4d5
um+is+/OY6bl57SrydzCWz8mwUs0uK6FHnVB2YEdNiIOCgJhoHKINSWtsl0HwxTB
4DNYcWqdLdIHmMqDuGYnGdomN8Uztv+9Hoaf7Behff8JZv8PnW6FFNy+N9iXENrt
ej0r0sYsTBSjPYMX8bYI1gXxsPLozee7vNR+1Rk3UaGJ3MSwky6f49trjxDKbeLe
p5FgSfyJdUPE0xhUM4XEmSjmAfK89vag8wSiuzYRznmFs9I0q3SLK7OEeYc8371b
FurOfA3Y5dRPMc0fEiwxEZM1Yxsiwokkos6jDT1iXFvoMsSFUkUAq2dZHMRPJcO+
rZuQGV6uxtumfgvcojq6S2LeE0oWxTP+RC5zMPGJnn4b4ccWhdu/YBrw2z3EpJhd
GgISUdmV
=eRCF
-----END PGP SIGNATURE-----

--2LkMnlm9m8RLKywc--
