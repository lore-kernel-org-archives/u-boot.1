Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98EECFB44E
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C5288D36;
	Mon,  7 Oct 2024 19:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SsbRYEab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F4B88D36; Mon,  7 Oct 2024 19:02:52 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8568888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-458366791aaso21264791cf.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728320569; x=1728925369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JvZVI7WFyHq+Q+ZVhJJSbBL9zC/yhTaaijur9AxMJV0=;
 b=SsbRYEabgkW77kVzU+AKvLzkuQW8r1QtV4VoE0Rpb9IaXlEbVZSIIIAtwTFqLb3Uhc
 pZkTdEt331GuXwS7+8S2dJVAsYAXtGD65dh9HeUumTznq2lD0P6FmkoJmuinRJS/rOA0
 GVrTtudrv2xWHenmqTh4t9pcGWi7wrqswlNlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320569; x=1728925369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvZVI7WFyHq+Q+ZVhJJSbBL9zC/yhTaaijur9AxMJV0=;
 b=SXwKUGNr7jlwpudSywOFhlreEti0YIcvVBj3EY4uC4gLBYOEmi/FvAXhBn/lJAPbJs
 J2ra8/AxglD7nSWABqGX0rWco0cUrZ6Os/+IaNgQ3YBUy3PfltDbNPGICciq3Dvqb2fc
 dc//A/v0k3f41cMJEI7PPnFKvq0PHqV25b0sfGeB6GIOSsYJ3o215MrzH/5jmF5pdTTo
 rLUv+LsS8pjDKdKNsfMfnKeUk5JV7oAcu69e+N/sAtrDnrSPzjdwwXeiBPmdtHl25cA/
 E5/3sz2Ut9jqGcQ72DdlsAcidDwYnjfcWNS8P0uPTAh9MnhpkMJZBok4clzW8zmHV91x
 7I4A==
X-Gm-Message-State: AOJu0Yz4ZSeRzW3NWcUPCaCAx4xB42iu9p0LfFEUVwjWSesRAsyJd/Wg
 P5Dq7vWoxx4fLyOVrT8UnG7duf2MRZSMzQ/WnoGu152GMc+fv7/s6RI9RXH97BE=
X-Google-Smtp-Source: AGHT+IFT7eM8+eQKDcZC0robicwVzQGx3domYQD3tmnHc+qdsSCwVW57rO1w78WkRngb8ef3e/NAlA==
X-Received: by 2002:a05:622a:19a9:b0:458:2b7b:c453 with SMTP id
 d75a77b69052e-45d9ba2f097mr195038751cf.4.1728320568590; 
 Mon, 07 Oct 2024 10:02:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da760f2fbsm27851501cf.59.2024.10.07.10.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:02:47 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:02:44 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, lukma@denx.de, seanga2@gmail.com,
 peng.fan@nxp.com, ye.li@nxp.com, alice.guo@nxp.com,
 etienne.carriere@foss.st.com, akashi.tkhro@gmail.com,
 Ranjani.Vaidyanathan@nxp.com, festevam@gmail.com, marex@denx.de
Subject: Re: [PATCH 4/4] clk: scmi: Add workaround for set_rate/enable/disable
Message-ID: <20241007170244.GZ4737@bill-the-cat>
References: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
 <20241006093825.2800013-4-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EFV7WW9OvEvKlYRL"
Content-Disposition: inline
In-Reply-To: <20241006093825.2800013-4-alice.guo@oss.nxp.com>
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


--EFV7WW9OvEvKlYRL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 05:38:25PM +0800, alice.guo@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> Add workaround to set_rate/enable/disable to bus clock that SM
> will reply DENIED error.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

In general, please include a cover letter so it will be clearer what the
overall goal is, especially once merged.

> ---
>  drivers/clk/clk_scmi.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index a01292c479..a860a653ba 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -73,7 +73,13 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>  	if (ret)
>  		return ret;
> =20
> -	return scmi_to_linux_errno(out.status);
> +	ret =3D scmi_to_linux_errno(out.status);
> +	if (ret =3D=3D -EACCES) {
> +		debug("Ignore %s enable failure\n", clk_hw_get_name(clk));
> +		ret =3D 0;
> +	}
> +
> +	return ret;
>  }

This seems like a generic change being made globally and not a
work-around for a specific problem on (some?) iMX families. Has this
been tested on other platforms?

--=20
Tom

--EFV7WW9OvEvKlYRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEFDQACgkQFHw5/5Y0
tyxt3Av/QdJdLqh3se9LaXbJOkL+SZMkLnKNIljiNe8aF0jh9/uVfcXE/LTRKJBS
lG9tLvtxDpXBwn57+5XISw+6s3YmCRZ4SFWE/hKi+vhdYLsKKGRbEZ7/8LjP3FOk
s/6XmfdIJHDY6M2NbdZuV9NHQdlvEett21T+MQoDNfKDxH4R/TYFei9qFDfCFLTI
HZdScY2Jcqnkw7acdHbgSn5XO6hfS21PL8USVg8kQ+VdlPL+AVsmRuYBjvX8VA/4
fCzObJlHYzFffTxtpOkv6+jrdxrVR8KK24z/yawn7Ise6LjOFlOUJudcjOHjK1d7
dawcBHLNE/ZktGIyl7YXdXCtKppt1nfV7SxoOI1exTJVzervUHXNJ6Kh3iinStBV
br4KwL3Ch2KefKR/0DuO4ooIGoCDqN3FyCJTFFX2VVF2BPuuDy9yW8t8WFKfDuUD
7PfLiqNZwKpTYysjj+BWbD5Eu2YdVHFw1Idw/8xQP2Pr2uqro7e1lKS0sBB5pCTd
4sue9z+G
=QIRq
-----END PGP SIGNATURE-----

--EFV7WW9OvEvKlYRL--
