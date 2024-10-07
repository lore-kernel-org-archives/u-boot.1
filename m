Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD9CFB44D
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA15888B2;
	Mon,  7 Oct 2024 19:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SU+8b1Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C878870D; Mon,  7 Oct 2024 19:00:12 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A242C888B2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb3ba0a9a2so33969546d6.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728320409; x=1728925209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fJvAu/gfJR4KvYUdWE5wy2oojRbU0dXGCf41qCeISKg=;
 b=SU+8b1Bna3+HcgHhRKhclVwZa8slG3+zSdvgy8QBJmf6zJ+mg2oetvvrJnkcWA9Uda
 LbuvbqbR5h059itxXjjHWei5qY2ON843eXxs5nLgJ0o+gjZkfm20U2vS4QG1yoNlRt+k
 kBtXQZnQcaVsleS+KjqOOTOem39gR7oiJWIXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320409; x=1728925209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJvAu/gfJR4KvYUdWE5wy2oojRbU0dXGCf41qCeISKg=;
 b=PLvSGwtbkkze3+JaxjIJef3xmPs9atMRSzdljBytbRewFSWZOiH3aioW3SnmLaXCvP
 Zn8fJ6Lg/B8Mtttr5Oi5M/R854o4ozvboFlCcVtgmUvD+/ZqR0ad/WwEDwOttmuAEtPm
 d3y7ZjpNtrQhQTghYNEc/AhybAA3gdFBg+N/cbXxzteOAA3YzwLIjwV/6LiwV7xKZ9VX
 /2G0XN+WWGPPLLBk/Cw2bLfFviwE0r7wZeNjtm41riQkgVfSvXrtg1SUQrIRLl+cvuF1
 lO4aix90YV0kqQC3CvBVdovaqCe8qSig03gjF0QDZRMKl99jxhEudCZ93DWgL7p2Mkhe
 D4OQ==
X-Gm-Message-State: AOJu0YzeLI6B349AyRNquXZTMfYoWywIbFlt/rEDX2JwajZMLfmvKj3Q
 4M99bI/1bxYlEc93ndbn88AgsZ7VjSodW3pa9iSFFTL796vC7apzuQJQppJITn8=
X-Google-Smtp-Source: AGHT+IEv8Eei/xL7BHvVyhiT0YGu/cAtXrtqdBNkhdwHpCY16VvRDSUQQ0d6gQ8oAw99DFwjgqqvZg==
X-Received: by 2002:a05:6214:4987:b0:6cb:3a53:c549 with SMTP id
 6a1803df08f44-6cb9a330870mr198318816d6.1.1728320409304; 
 Mon, 07 Oct 2024 10:00:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46dfc13sm27248196d6.49.2024.10.07.10.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:00:08 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:00:05 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, festevam@gmail.com,
 marex@denx.de, viorel.suman@nxp.com, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v1 2/2] firmware: scmi: smt: enable doorbel return
Message-ID: <20241007170005.GY4737@bill-the-cat>
References: <20241006070702.2792392-1-alice.guo@oss.nxp.com>
 <20241006070702.2792392-2-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CVRDs/aheK2OXtFy"
Content-Disposition: inline
In-Reply-To: <20241006070702.2792392-2-alice.guo@oss.nxp.com>
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


--CVRDs/aheK2OXtFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 03:07:02PM +0800, alice.guo@oss.nxp.com wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
>=20
> Enable doorbel return to work iMX95 System Manager.
>=20
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/firmware/scmi/smt.c |  3 +++
>  drivers/firmware/scmi/smt.h | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
> index e9d401f0da..98e07d3a16 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -49,6 +49,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct =
scmi_smt *smt)
>  	if (!smt->buf)
>  		return -ENOMEM;
> =20
> +	/* make this configurable as function of DTS property */
> +	scmi_smt_enable_intr(smt, true);
> +
>  #ifdef CONFIG_ARM
>  	if (dcache_status()) {
>  		if (IS_ENABLED(CONFIG_ARM64))
> diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
> index 9d669a6c92..768b0f4c8a 100644
> --- a/drivers/firmware/scmi/smt.h
> +++ b/drivers/firmware/scmi/smt.h
> @@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_sm=
t *smt)
>  	hdr->channel_status &=3D ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
>  }
> =20
> +static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enabl=
e)
> +{
> +	struct scmi_smt_header *hdr =3D (void *)smt->buf;
> +
> +	if (enable)
> +		hdr->flags |=3D SCMI_SHMEM_FLAG_INTR_ENABLED;
> +	else
> +		hdr->flags &=3D ~SCMI_SHMEM_FLAG_INTR_ENABLED;
> +}
> +
>  int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);

Where is this being configured based on the DT? The only caller only
passes "true" without a check anywhere.

--=20
Tom

--CVRDs/aheK2OXtFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEE5UACgkQFHw5/5Y0
tyxKwgwAkyWRyGRP47pnAWVMKFz/G9TLaag1j6D0y8LZLL6W03rKQBXvoLGQKDmv
DG66k2glJEnDY8u3V+v0tqwXJSQ7XIMAjEHYE5C7pN93WjYp/cfUZso4og0tQrzq
1/dcFUicUrw4q4kTUr8cr+T/ylJvjkUyhCEE1JRaMIBVz3HzPAAg7Huuw+Rg6a6G
FJgwKjSTMqEYHQJ92ElTvMKuHVaRWNO6IkkN9pHa6Sc15+v2elLMbXSXFyB8oq8X
VZ1nKnb0E/EGEUAdmDv4rhHUDYuFJTRs1LfUdnuxVU3RLvHdde3UWu7L3FGgPt1G
7B595XZjprs+hAROQk3jR9NtTGm7PHM1LZJwTwgQVmfRJzOW3sIcIm/CGewCgy2w
FnUeUCa6RZkhX8Sav44hk1XthBcYY17BWrJFAvJzLGOxwMGRiSWQOPjzYtPRu0K3
JNCf9WhkHkmkB7que1jiVrQzhk1bVzGCDWuIUVddJdKJtNV5R2ts6cE0xdtv915R
oIy/6Xsf
=vKZf
-----END PGP SIGNATURE-----

--CVRDs/aheK2OXtFy--
