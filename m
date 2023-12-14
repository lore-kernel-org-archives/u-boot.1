Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF80C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E7587AAA;
	Thu, 14 Dec 2023 18:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EcKTWubn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA8187A92; Thu, 14 Dec 2023 18:51:56 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E103B87B53
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dafe04717baso7902026276.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576312; x=1703181112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bpus5xTeF7wqgFkguXNp1Au5Mb2ynogHrL4ZGI/7RFw=;
 b=EcKTWubnEVRRad6lMcj2oNMrp6D+eAEjpEmS33hQ6ODh/4kEg0qouy37msU7bSA8q2
 xStcaebrbO3MyaWWJ535Ltd7gkjZigiLrJLSzKAu/T7YGqRYKP9u8Fn0DVtNDRyqMAWQ
 t2/QEtHJjEyYNnSIj0pLDpMx0PxQpf5kQFcKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576312; x=1703181112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bpus5xTeF7wqgFkguXNp1Au5Mb2ynogHrL4ZGI/7RFw=;
 b=MiHMcpAzFOfixkLkTltShhEJgSLhZtftXdyK59fgrgPZcNyxzrXLMKvtxKwC2+6lrs
 EEnHgvZgX3tsBd9YH3Nr4sHmYygFo5nO8dizUiUYwkeUw4A0x74MKocvO83SbVOj2WRZ
 5ylYhGBNWLgsU+lsG/joIkkeQf8g97vd6BBFCZ/RJyXqH1DoupYxRkF0kjmejwthHBSb
 CNZa76HWUQ8GGzY7ArlxZfKgcc+m3EfKwyNvx2uFG7kZwnXFwTJm1GYQ6daHBowtt47r
 XN+oJWqnQcCRGOnOL+WrseBZi0fZ1aYqARmdhJmsSx5d96gEJ6oTAB/72zob9B0XBU9w
 KKxA==
X-Gm-Message-State: AOJu0YxxG8gvi/6ywchw87RkxoGVWxLQGGn8CJTAZEnAvSM5pBtQQFaG
 cUaEHcjSFTQlYKuS345ah1UsTA==
X-Google-Smtp-Source: AGHT+IHtj2n/rA6GUHT6Ijg44Mc72zmLSlnY2ahs+DAF7z3oL9ASmrxiqB37AKZz1lCZF6Am+8mgig==
X-Received: by 2002:a25:55c4:0:b0:dbc:a1f7:e273 with SMTP id
 j187-20020a2555c4000000b00dbca1f7e273mr4436616ybb.89.1702576312556; 
 Thu, 14 Dec 2023 09:51:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 67-20020a251546000000b00d9caecd5c86sm4938782ybv.62.2023.12.14.09.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:52 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 17/21] bootm: Create a function to run through the
 bootm states
Message-ID: <20231214175150.GL2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dVJHnMGW09Q0W0ST"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-13-sjg@chromium.org>
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


--dVJHnMGW09Q0W0ST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:26AM -0700, Simon Glass wrote:

> In quite a few places, the bootm command is used to handle a boot. We
> want these to be done without needing CONFIG_CMDLINE, so add a new
> bootm_run() function to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> +int bootm_run(struct bootm_info *bmi)
> +{
> +	int states;
> +
> +	bmi->cmd_name =3D "bootm";
> +	states =3D BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOA=
D |
> +		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
> +		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
> +		BOOTM_STATE_OS_GO;
> +	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> +		states |=3D BOOTM_STATE_RAMDISK;
> +	if (IS_ENABLED(CONFIG_MEASURED_BOOT))
> +		states |=3D BOOTM_STATE_MEASURE;
> +	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
> +		states |=3D BOOTM_STATE_OS_CMDLINE;
> +
> +	return bootm_run_states(bmi, states);
> +}

Looking at this, and then boot[zi]_run, I think we should either always set
BOOTM_STATE_MEASURE (it's a nop without CONFIG_MEASURED_BOOT) or always
IS_ENABLED check it before setting. I think we both would prefer the
former? And I really do wonder how much it would hurt or not to just
have boot_run() or something which takes the name as a param and handles
the few "bootm"-only flags.

--=20
Tom

--dVJHnMGW09Q0W0ST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QLYACgkQFHw5/5Y0
tywRKAwAhPhWprTszcENFHkhmwd3zbOdJEGG2aa87o4N2uLuqZZm3PbAJUwXJ6VH
yyNd1ggiIJ+42wnIBELPNvo0fWfPnXUDNS9KroBAXu3IB23qdCZRx//hVwWREsDS
KuDtgaROpKwk4BU+PlXx9uA6T6lpDVlI6YgkeshM8t6HY+QoLTZ7jv8S1Ur7UAsd
MlCSVW3gNxPulmMMeZRXG7aILzyM4bGMJn3Vx4HfLHj7K8rIwOo6tlFeYdAe7rfd
1zzmEU6RiO4H+mBCWaIo98eB8ngdxA/aBNYmJ27IPP1sHPEQV/9rxkaux7z8Rekp
pza7pXc6HqF5UsZ30fqjj5YqOLlKtquZOwi6JNSSXuAj4iQhA2z8P1ZoRBrhKWdK
3D0el5E24J/JQRw0kWCze68IVSs8iX31OSokWtKGEuHgjc3B9OTsjO/H6C+X5YtU
TDS9FsWI55lsdcx4Cyavtoke2Q2qKoTOyG4ETpBn7/LFhx3odxBdBTN3vJirq4OW
GSL/j3Uq
=qUJc
-----END PGP SIGNATURE-----

--dVJHnMGW09Q0W0ST--
