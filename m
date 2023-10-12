Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D57CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2B186ED5;
	Thu, 12 Oct 2023 23:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UmMdQafe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B8C86E4F; Thu, 12 Oct 2023 23:24:30 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA34C86E40
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7b5fe8ab5f9so641010241.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697145583; x=1697750383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ekyPKX4kgbhv34aOLG4r1sIF28IBDVV5RR4aeobgN0k=;
 b=UmMdQafezb8mydY8XsXuDK2QJbUlMZoqjyhhqcFduhvSpNSOcUqVxrq4HyGFBQQsn9
 3x5HtahmgFl3S6JsRiKNffVEYn3fsZncJqZhKn1LJhH0ibkzIjTYw2l73jBeYWsOIgXe
 PJsWBiR4YDm1PCB+3FMkZdnbXB6Tr/604tCQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697145583; x=1697750383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekyPKX4kgbhv34aOLG4r1sIF28IBDVV5RR4aeobgN0k=;
 b=olf+wMXNUvY0q4oPHooi5YfZZ7PHFJR79UGV/e3WDLSJuais5du9U4D7prwikE4FHk
 kfpc9eWELRMA+msWU6c2Jr4+0QMeEIkdWTWab+R+RBKW8QkU83Ce664Tl18oxpi/DAnw
 HNuEFBX4cFLResxnXJVa7l0QMyodwkh+VbbOT26ff0upbSaNNrI62btoyh9R5isGuEqo
 uY9yyzbXXFHFVPOVrVrKwWUHSC5RgRVcB1PdlwueavqXrJY1YKNi/ZYxxOo0l4AIvxxb
 2jcoM2lbp2MrNVS0YHw8xOx0kqsuV0mo9V+cHasWBegdgwEjv36y+afh7Ut6DKOQkqyJ
 0Muw==
X-Gm-Message-State: AOJu0Yx7b5/9psGlY5aw/XOMAeGFDgvolWigcvuOxIrm/zyDalix5Rdn
 g/kUoOZAKBd4qTbNz/YQs8WGR0cEiISSGLnKsENNFQ==
X-Google-Smtp-Source: AGHT+IHqawdNnWpRjZrHSUPXsVdmn1tauaHD+1XujxnnPLeggIn3lzutus+YLgE+AjVTCharKZ1GAA==
X-Received: by 2002:a81:7255:0:b0:59b:fc99:8e5 with SMTP id
 n82-20020a817255000000b0059bfc9908e5mr25293674ywc.29.1697144652724; 
 Thu, 12 Oct 2023 14:04:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a81fd05000000b0059ae483b89dsm219580ywn.50.2023.10.12.14.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:04:12 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:04:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 2/7] Revert "arm: dts: k3-j7*: ddr: Update to 0.10
 version of DDR config tool"
Message-ID: <20231012210410.GB3119521@bill-the-cat>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-2-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jgSL7D+nA/DTmM0r"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-2-5d31f765dd2c@ti.com>
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


--jgSL7D+nA/DTmM0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 10:15:56AM +0530, Manorit Chawdhry wrote:

> The update causes instability in am68-sk boards so revert the patch in
> the meantime till fix is available.
>=20
> This reverts commit f1edf4bb6aa19732574ac23ca90cb9a0ba395ec1.
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--jgSL7D+nA/DTmM0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoX0oACgkQFHw5/5Y0
tyw53QwAnAxshZEdabJgh3FP/54E/QNJtj52osS9jlni0Ly8r2mRFyVuNgosDJcu
2HhwtaXrdstODaNIyufHmZ2+FNIBnaYhDBd6Ulwka+9vYw4jubHa5NHIcElsZYn6
rDjSa2sngEmMAcEzEBTDW3Q0MkgKaNGsvydfXRFEI3fyIS/47dnbTCgSXFEuHT9e
3glLfmj7XwYG/gFVlyApsfbMv67+Y9EdrNkpTZ5fE2fUVn7aOu8MuOh/7bANIynS
kXwwiGXeL0erQmFPSH7e7as500olObmhL426dDb1VH9u2G1kb6IhQ1LIlGFkTq+h
Gi5pwYzGEfw/DWYntHQf9wSfLTxF0WjorkbQuPruiSEbr1qJia60oEut4Jh7Yxz0
vmgefNDtEcG2LnAIF99YLLw2ZR+ZX870b3o2XqGWEvrTtb1fjgnssTJKEQvOEN92
FlhIfFU+TU4IzT3Jhd4Lm5A2P27gSkv3/4hKuc2pStU4b4gzyguYUXr6wKuoM7ev
a1zDtOoi
=BR97
-----END PGP SIGNATURE-----

--jgSL7D+nA/DTmM0r--
