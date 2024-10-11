Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480ED0EE12
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 16:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFCFE8937B;
	Fri, 11 Oct 2024 18:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MGG6voET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EFA893AB; Fri, 11 Oct 2024 18:56:24 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1805A8937B
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso4588856d6.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728665781; x=1729270581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+H4FzeDw6xiXExdOn6c9SE3rnSFu3tEzGkJOP2XD60s=;
 b=MGG6voETwToSoFGEpvg4uMhXG55DfCTV2U8h+PptGkmg6QPSFsWX2Pq+Eu6xyxqFeK
 24DpzzXefQR1YoTvr5wJqRKjYvkMS+a9zDQfs2S0SHFE4A/HNB8V1zMthht/qLFH7eFR
 W/muqB2dBrh7BQwVHH09QrD0o8iWZlFvDjkTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728665781; x=1729270581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H4FzeDw6xiXExdOn6c9SE3rnSFu3tEzGkJOP2XD60s=;
 b=MIe+mWIdRdtC0vC5egjhtvlOEv+/uk5t2+GLdwNqI4vSW+pLlcUnbGEW44stjl/Y6M
 7+DcxWhK0eRnMhRBma09qKGOVhRGiEEoxTl+97OS56v2k2gCl/Ju2sDFUqwJDjSw+/0a
 +bDArKc2TLiWSN5rt/1Mf2DzMC6K/oF1ZkwOajquVdpqghgy3S4+hjEt3vvmozArNSYN
 xSPRBaa2QQcVEn0BInj9zZ5OnMlpsNgY+8dQyxqBq40VIhBTUYic5fyfe384TzNC6Bht
 ekiY7iPG6buPPvtKPnTpw7waBEUo/ZiQytLcmEnfrDt5H2zId0Bmp+ZY3/67q8Y2FbII
 GsgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoP36rCpfUQLM6G24KQdJ7FcetVUe66iWdP6eSAVib7QMpRDo/uCcG/oWnpj/G5IJo9/go4Jk=@lists.denx.de
X-Gm-Message-State: AOJu0YxNHHDeslyX12+HAgR7RAvw1EOBqWhd58ruLbGPbhjF6jcwVtij
 5QJ4RZ2DZQD7d7FGkVn/1JwiGgqfQYPJwo0adYqbVBegBo7QymGSoOZ0cY5fQIE=
X-Google-Smtp-Source: AGHT+IFjbL3+xWczPziJiXV+gwUeI08pkgqjradvmaz8Vt5wEV+F4cgtrw80WYtz5bSsVZCQ5AWBEw==
X-Received: by 2002:a05:6214:4882:b0:6cb:e453:590 with SMTP id
 6a1803df08f44-6cbf009965bmr56171346d6.37.1728665780788; 
 Fri, 11 Oct 2024 09:56:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe86093a9sm17116576d6.86.2024.10.11.09.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 09:56:20 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:56:16 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Simon Glass <sjg@chromium.org>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 uboot-imx@nxp.com, gilles.talis@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241011165616.GW14210@bill-the-cat>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NLyA5HfXk2cs9LlJ"
Content-Disposition: inline
In-Reply-To: <20241011105827.7729-1-peng.fan@oss.nxp.com>
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


--NLyA5HfXk2cs9LlJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 06:58:27PM +0800, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> U-Boot device tree is padded just after U-Boot proper. After the whole
> stuff loaded to DRAM space, the device tree area is conflict with BSS
> region before U-Boot relocation. So any write to BSS area before
> reloc_fdt will corrupt the device tree. Without the fix, there is
> issue that =E2=80=9Cbinman_init failed:-2=E2=80=9D on i.MX8MP-EVK board.
>=20
> Move the variable to data section to fix the issue
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/cpu/imx8_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
> index 6c0a8c0cbe4..19c65c7ce47 100644
> --- a/drivers/cpu/imx8_cpu.c
> +++ b/drivers/cpu/imx8_cpu.c
> @@ -71,7 +71,7 @@ static const char *get_imx_type_str(u32 imxtype)
> =20
>  static const char *get_imx_rev_str(u32 rev)
>  {
> -	static char revision[4];
> +	static char revision[4] __section(".data");
> =20
>  	if (IS_ENABLED(CONFIG_IMX8)) {
>  		switch (rev) {

Why isn't this padding and alignment with the BSS being taken care of in
either the linker script or the binman dts?

--=20
Tom

--NLyA5HfXk2cs9LlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJWK0ACgkQFHw5/5Y0
tyzmAQv+O2gkOKkueSDNNo1DyKqziCtVxzrPOL6drHy/YEka1IeIfOi0dzflQiF5
GxmjM7Lfqthi1MQMdqe2XhT1bqBOpHkbZlOT++AFyy/6wpAgnRXeexqAMX+dX5M5
Dze1EVAvTH3YupqNVmidEuF3w8rBrdFw35JGVPoQMhTB+878Ni3nQyu+8BlOSXH0
TkAWMhVMMW6ulPe88iL/pRxU9Cp/zO52Jw1JygJ4iiGcR4f04QcCJE+DBfRFdtD9
WraE5/T5IrTct/SM28D06t3fnNuxqGI5Ee3NkwYJDG45rMvgncZ5KkIp9Pvr4GEp
NYwvUNVFDMGEHeTBIk/EzPBT47BAd5LnLn/O9UdIG5037KYhoZHkUrJPZj5MiC7O
DlDd2NiqUi8Lr2NcQSv7/xiyMsDUu//YXlY8ANVqHiskZFL4hyDPWBzsHHC4bCzv
M5+4IWhN6SCDkl+T4IZFg8VS8+8HrMIMleu1CsSaLS6OY85yb0h/cJwPIyJNDGtp
3NH5daHC
=udZX
-----END PGP SIGNATURE-----

--NLyA5HfXk2cs9LlJ--
