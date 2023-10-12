Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DEBCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F31B386E7C;
	Thu, 12 Oct 2023 23:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SPZ/jEgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084AB86EAF; Thu, 12 Oct 2023 23:08:19 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6A086EA8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f82ad1e09so17127837b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144642; x=1697749442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j9Jes2jBYhNbYaob87irva5TqWaeSpKxFqVDTGogEmY=;
 b=SPZ/jEgPibWRyykj24AC2s4LW511DS/s0pCEIZESlp9BuHFt+JTwSSx8XtEdE/5adj
 bfD29pGETJ8pImbJobVKpL8fHF05MQLiPFE/bDGiwaJld05ND7cTN+iOiYAENMEbdxIP
 YcXKorAy5IjnZiPkhai3w+akGCRakCSN1hT18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144642; x=1697749442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9Jes2jBYhNbYaob87irva5TqWaeSpKxFqVDTGogEmY=;
 b=wPpFZKq58v4LtZkkMCQK13GkE3zRq0wfs0wk+Gul74tC5D4ZNUm/QeqA167S0SKMdy
 TKMTRENYwFhcObcl4UA4uNkz6+xlLqvgUAcMSoEmHgO/8ZhTXeH+TRLrgDqcQepgcJwa
 kDISuERUmM5QKmRMZeIwP8LtswZ4ldr1tnMSN+/s+tfLzQ++hOTyD/JAxymlJsXQrdm+
 FKCq/KACf2XgKqrbQqfLNISmXoP8TF40CXseblAWUd48iV5CAzX2u8fX0SnxO3UiZnl9
 1pdz3Wu1nG5G1TEgoz39+SNdChO94YiGvHtJCy5U+P/ySe7hc+9OIXWSQIiQ0mlazUZi
 9rQQ==
X-Gm-Message-State: AOJu0Yym4v6L8dwv6KqBt4AYWFW1xCuFe4yuqkPl1MiA13u5J3CU1ZkU
 MII2KBJkVT3fr1iiWMn9r5ZJ2w==
X-Google-Smtp-Source: AGHT+IEsDXlq2CCOWQFDBqTRfEXq0bUC24HjkA6DxH/2hviqleFZoUA9F63seWGUJqtx+1oVr7/VQw==
X-Received: by 2002:a81:dd0d:0:b0:59b:ec85:54ee with SMTP id
 e13-20020a81dd0d000000b0059bec8554eemr28812121ywn.39.1697144641760; 
 Thu, 12 Oct 2023 14:04:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a81a50d000000b00559fb950d9fsm219100ywg.45.2023.10.12.14.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:01 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Reid Tonking <reidt@ti.com>
Cc: u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com, nm@ti.com,
 vigneshr@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH v5 2/2] arm: dts: j7200: dts sync with Linux 6.6-rc1
Message-ID: <20231012210359.GZ3119521@bill-the-cat>
References: <20231005181258.1004539-1-reidt@ti.com>
 <20231005181258.1004539-3-reidt@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="drRtLCUjtm9HwdQQ"
Content-Disposition: inline
In-Reply-To: <20231005181258.1004539-3-reidt@ti.com>
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


--drRtLCUjtm9HwdQQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 01:12:58PM -0500, Reid Tonking wrote:

> Sync j7200 dts with Linux 6.6-rc1
>=20
> - k3-j7200-r5-common-proc-board.dts now inherits from
>   k3-j7200-common-proc-board.dts instead of k3-j7200-som-p0.dtsi. This
>   allows us to trim down the r5 file considerably by using existing
>   properties
>=20
> - remove pimux nodes from r5 file
>=20
> - remove duplicate nodes & node properties from r5/u-boot files
>=20
> - mcu_timer0 now used instead of timer1
>=20
>   mcu_timer0 device id added to dev-data.c file in order to work
>=20
> - remove cpsw node
>=20
>   This node is no longer required since the compatible is now fixed
>=20
> - remove dummy_clock_19_2_mhz
>=20
>   This node wasn't being used anyhere, so it was removed
>=20
> - remove dummy_clock_200mhz
>=20
>   main_sdhci0 & main_sdhci1 no longer need dummy clock for eMMC/SD
>=20
> - fix secure proxy node
>=20
>   mcu_secproxy changed to used secure_prxy_mcu which is already
>   defined in k3-j7200-mcu-wakeup.dtsi
>=20
> - removed &mcu_ringacc property override since they're present in
>   v6.6-rc1
>=20
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--drRtLCUjtm9HwdQQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXz8ACgkQFHw5/5Y0
tyyIQgv/SNtppXufzR5RMVTHWlO01A/rAJw28lW7Ytkj5mX4/78fIyh7zZkciIUM
d8uPzkkyWXXOAJXy8Le4xehypwMXuspE/PK9oSCmnrsonYOQgXRUd9V+Vz1NBEMq
GoZTUv94NvFKLHkTdnDFMwu6S7c9PpGR1v5Axn7ti1jnto/+qsSHiaux8A6aTP9g
hxgnpP237Fd1WP5gItNpXaQ+JDZ2ZaUxDN09tcypK9PF6+0JMU9DgdkpTQpN6iyh
5Ds8nQqlM9QqGPex2I6Kgkm9KzA1ThPqfvja5zplrVAZry5ZM/2F7NZAAaWqFSKG
ZVHDo5DT7FdDvSsH2tc9YrEk6acFwOj9qDYK9pD93CvYPqfjfVohji+3hDYkhD3E
hZUHzRG0rS/eOoIBpuTxLxpT4c9PzLLe8QWrwltj5ll27qv2KUFAmfWqTYsK0BBf
giE+1rUWELfq/trdHojlbl2zE0EMGy7GHUv/CwPZQdy5PYhmk/+DjihJV7AettTI
sgAwmBjO
=By4y
-----END PGP SIGNATURE-----

--drRtLCUjtm9HwdQQ--
