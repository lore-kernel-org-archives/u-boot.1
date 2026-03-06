Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEB7FCB611
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 15:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B6883F9A;
	Fri,  6 Mar 2026 16:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t3GhShv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884B483F98; Fri,  6 Mar 2026 16:12:28 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D793839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 16:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-679f23befd6so4268932eaf.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772809945; x=1773414745; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w9beO3k65obH8nqErmaFTjSoX+rwmDYgCoIx6tY1joY=;
 b=t3GhShv3PDs6pp3p8Cj30IpDP0Cux48UQ0cavM1xFPKl1hYZYv+vYbF27BJuavvkiP
 tlUk3hwHUaHh0cAUEvd5QlxKOnRRc08vtj8s7cytw1INxc3sPLUGkGJIInrMWrVVQyZW
 SM52GZ/pAzRWdd056e+hIkBKQWjaqOVWf/Nlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809945; x=1773414745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9beO3k65obH8nqErmaFTjSoX+rwmDYgCoIx6tY1joY=;
 b=Q0P7vFvbyxE125dkjcf8qzOrbX36IdWzn2BH5oCqDl+3HxeWWWKY8/G4916mY+f81L
 EBfDwIaDi+5F6lgElBkKL9KuWoYdWO1jdgdKLDplD2iDp2JrCOL5qxD/9JLSlZavrXW/
 wnKebYZsqSxLht99STlQufeg6hYPbhElBPurt+yIZonxxIDOQyAYumogsV84H6FHjqK4
 vs/VcS/cqA3gr839jNk8M9jY9R2Bm8+mOCtfcCXK7Bxx748xA6T8+C26ybT4lKtqKBsB
 FEOrVH1u4/5B4m1h7ojY4NgTxjvLfpVNqdr8m2qp+IIwScepMnTT64hJfOVb9yWfUDBF
 JwdQ==
X-Gm-Message-State: AOJu0Yx78i6iggjWzVYnZ3Vd6wuiAfunjBseSiC6eNCt9Uigu5a/6W65
 619LbdjthgdGRbGUWoHqN7Z4HlRa01GiXqc0+JGTA8/BdlcWILWtb9RO9qJEqNOu4CE=
X-Gm-Gg: ATEYQzxIDv+fXCLqN/9bG5Oj3qeCAa+XR1LluwH294FURlRbFYRuVleEJ775SYfdfEW
 sxcXzeYPyDc13bIaP0pJXI/0wJmQdaoQFXl0SUk/376CVeTnt3n6KeD5kL3DucXr54RYI5M7x7+
 FkHt17JSMhfrWaCVnneKdNMFVvazIX2zGhaP4DcLTU5A2qKQSBOGsCFeTMZZrbeXZ7f5MdQaCCX
 GHK9n0F68/X01ZtqC9NzH1wyl7wmG0vMr6Rr7+GEsEB7T1RxfPUvEXtzRntdENzRaQ/czZtZau5
 eaS+KfSmBOAZZxOL4ze4cPIZ99ef59DaUG292hWjIvZodUsfTkiems8Xa/4ajuXvPzqdxPjBgAq
 aIbxWicI/oQyuSqqVjnTwPloOOxh+xLPDTbdCW+oGvtuQVA1N53HTu7zDnDZT0g3zqCpTQxw58d
 hsuM1gjWlM4d59IQaaQP7FDImVq/56ZjEeIDHYwyxcdMkLP8wwyip8988f66TBSrf1p5E+s/4mk
 x8Zffl40RlQjMiUZAHAQiVN08tB1QnUXLpti7Pu7d8pKCNMTik=
X-Received: by 2002:a05:6820:188a:b0:66a:ebc4:66d7 with SMTP id
 006d021491bc7-67b9bd72f7dmr1559333eaf.70.1772809945169; 
 Fri, 06 Mar 2026 07:12:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e688d5cdsm1558074fac.20.2026.03.06.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:12:24 -0800 (PST)
Date: Fri, 6 Mar 2026 09:12:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Subject: Re: [PATCH v4 04/17] bootm: Create bootm_final() for pre-boot cleanup
Message-ID: <20260306151222.GN1388590@bill-the-cat>
References: <20260306023638.2678886-1-sjg@chromium.org>
 <20260306023638.2678886-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xlc7N0MGKq+5tzSd"
Content-Disposition: inline
In-Reply-To: <20260306023638.2678886-5-sjg@chromium.org>
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


--Xlc7N0MGKq+5tzSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 07:36:13PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> There are various functions which announce that booting is imminent and
> do related preparation. Most of these are arch-specific.
>=20
> In practice, most archs do a similar thing. It would be better to
> have a common function, with perhaps some events for things that are
> really arch- and board-specific.
>=20
> Create a new bootm_final() function with the common pre-boot steps:
> printing the "Starting kernel" message, recording bootstage data,
> optionally writing bootstage to the FDT and printing a report, and
> removing active devices.
>=20
> Be careful to avoid using BIT() macros which are not available with host
> tools.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Xlc7N0MGKq+5tzSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaru1gAKCRAr4qD1Cr/k
CnjCAP0aZarNZnfhoWyafw72KAoryc3NeYt2HWv4vaWlCLllBAD+P1DETIZoI+0/
In9rJQHsjteDJKtt7wfD3aAyALoN/wg=
=XGlF
-----END PGP SIGNATURE-----

--Xlc7N0MGKq+5tzSd--
