Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC492CFB44D
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 16:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467A6888B2;
	Mon,  7 Oct 2024 18:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D3wm2xxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064C5888B2; Mon,  7 Oct 2024 18:58:36 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BB08870D
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 18:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7ae6f8956baso421643685a.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728320313; x=1728925113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eprWQnaDuW74wwDP9uK3pdfR1VgsYGPKvaGwzhQ82Sk=;
 b=D3wm2xxaBLGCGg1+6HVgMHWyM6VPgId5GXaFlUCUV/SdbpLWGOFwosbYndBuBYeXae
 m8X775PCNY2B84qjHU0YcChHm/+8CovFshiGw9O8GJTSwPbX8nkQ19XQWC2/AIBYh/FK
 TkDa8oRhvO4Vpv8AafQIgmabunrrtfNUPysi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320313; x=1728925113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eprWQnaDuW74wwDP9uK3pdfR1VgsYGPKvaGwzhQ82Sk=;
 b=xH47yEOe8ZDWCZTBMuF/lbviHvsT41T+uGodipZIbR3zPS1Y9AWPkyv/qgXsJ62NPF
 1V/G5ILoiFmj0rSYn0qNXxaSf7rlHjiZc7zNK7cXC5bseu1Y2bZ0nY6V0g70fSjwRMPn
 TieE+4qCgt42YqNJOz6N8dziKej2I4hYel4lTlyQM7JFDPMJvVhcLOCTp7iJBADugKPK
 fhf3VnyPlLJNmmICvr8670QO1kD+Egr2RCHh1bNzDMEBA4uf/585btTvC5qB/I1ZfDnb
 +yK72VL0ggCCLpgtYOSCc45m2S6iHID12IaZDyjkxW4C3ZQAajympovBGSFZPWlVSeyi
 oprQ==
X-Gm-Message-State: AOJu0Yy0ic9IQfcUf8v7Phetam4kX5ELHIfmhsPfndvQhhkFj4QK5uNT
 yJ2PWkaDmuWqwYp6yLaRZPFLRoBRWtLk+ncdtqpCyIJ9d2drxH29gNtHsmUCNFM=
X-Google-Smtp-Source: AGHT+IFty5fe6AuWaY2FwijFGY/pR6Eblw7vXYeT7i9TDFVCXGl8b66EAwC0RvTyprfVpXqXKd2Mgw==
X-Received: by 2002:a05:620a:4727:b0:7a2:c96:855b with SMTP id
 af79cd13be357-7ae6f453683mr2453270485a.32.1728320312707; 
 Mon, 07 Oct 2024 09:58:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cd4fsm270438385a.50.2024.10.07.09.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:58:31 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:58:28 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, festevam@gmail.com,
 marex@denx.de, viorel.suman@nxp.com, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v1 1/2] firmware: scmi: use PAGE_SIZE alignement for ARM64
Message-ID: <20241007165828.GX4737@bill-the-cat>
References: <20241006070702.2792392-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CDKIdfJN3StL1xM/"
Content-Disposition: inline
In-Reply-To: <20241006070702.2792392-1-alice.guo@oss.nxp.com>
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


--CDKIdfJN3StL1xM/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 03:07:01PM +0800, alice.guo@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> For ARMv7, the alignment could be SECTION size. But for ARM64, use
> PAGE_SIZE.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/firmware/scmi/smt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
> index 67d2f45002..e9d401f0da 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -29,6 +29,7 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct =
scmi_smt *smt)
>  	int ret;
>  	struct ofnode_phandle_args args;
>  	struct resource resource;
> +	u32 align_size __maybe_unused;
> =20
>  	ret =3D dev_read_phandle_with_args(dev, "shmem", NULL, 0, 0, &args);
>  	if (ret)
> @@ -49,11 +50,15 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struc=
t scmi_smt *smt)
>  		return -ENOMEM;
> =20
>  #ifdef CONFIG_ARM
> -	if (dcache_status())
> -		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SE=
CTION_SIZE),
> -						ALIGN(smt->size, MMU_SECTION_SIZE),
> -						DCACHE_OFF);
> -
> +	if (dcache_status()) {
> +		if (IS_ENABLED(CONFIG_ARM64))
> +			align_size =3D PAGE_SIZE;
> +		else
> +			align_size =3D MMU_SECTION_SIZE;
> +
> +		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, align_=
size),
> +						ALIGN(smt->size, align_size), DCACHE_OFF);
> +	}
>  #endif
> =20
>  	return 0;

You can move declaring align_size down to this stanza, no need to
__maybe_unused it.

--=20
Tom

--CDKIdfJN3StL1xM/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEEzQACgkQFHw5/5Y0
tyw8Cgv8Dnx8wj4J+dOLJStI/7mQkC6I15b4RH3RP5BCHAzMeS5sGUTa+ngzaU29
d0SHRt24btTZ4YN1PcZWrnQeGxAMOzWFGD5lEwT3RjmdbDJFbIrHjyNUTnD4JUNp
OLw5UXRCPj0yC6lzZJAd58zvEIVj2t8PPlrPve67z87Y2giRceFcLwVoZDtmMjQF
H+nb9rMgYWT/J3EDzT+TYiqH5zoum/SeBsBTkUxK7JP/hdOFb8Q8b+l13PLgL8zT
mPn3cTybCglORm5wVA4phL0eWNifVt9W0gBjKoNtGoHwj8TeeDEVrz9JKtcllr4/
689+LCCyeWrC0BrXY7y0lyjT7icOAPEROC+S1FxiDlME0LRIVV0/y6FTVngutGHz
JJlYorC+6wk9/QtdysDnzoh65bd5eQC405P/pZ/H59yTSeLsUet/+2vDgYMku0YB
Y25UVbLCGx1EbkC0l4n4NwTrtud859VKNcTlP7HN3MZpGiUe7ToPow7D5quRE08Z
DFQU9Nus
=vFiY
-----END PGP SIGNATURE-----

--CDKIdfJN3StL1xM/--
