Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B9ACFB44D
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8D988D33;
	Mon,  7 Oct 2024 19:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="epbOoqH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D5088D4A; Mon,  7 Oct 2024 19:04:56 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BF388CBF
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7ae3d9a93c0so484334185a.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728320693; x=1728925493; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xp4aRHXPxhe1skB2nP41reTGCfNuVzt9++aHmdUOr1o=;
 b=epbOoqH/wblqHh6ZikSu+MRSJ84zl4oz9FJUSYhYCqLBYSflcHR8dYFUVRIW6B8fBh
 PkN0ANQa4pQuobeHgludQe0PnCNXjzVDkSgahUUaMKzHYUETA/7R8uf0Ay7hcqi3fzZx
 25qwbEp2Xvz59SMVWyYK7frSS2dqbMtzbq5jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320693; x=1728925493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp4aRHXPxhe1skB2nP41reTGCfNuVzt9++aHmdUOr1o=;
 b=d0P3fO1+2DXhE5f7A9p6Xv8AvGvBQVM3pTZ8sgFBG6pMElpVd0r7cjT8vUYAE6VFUz
 nlqxjfzntiKkmtM22rFRXuZGpzAzeR7WnDmIJS9KXukftjrkAGcwqsb4bS5S1Kzy3Suq
 IpPKriWuepjYR/1873W6CKKlYga1DcSKOKHO5eykL40wfJ8WP74hVNSpYk4PGy1ej3he
 /8dM8/t5bKDrgjsL5IdSAhGipnDFB813DEUJpbl/TxFfW1A6fakiZpaWBS28UVbB8kC9
 q+J8AuNrDuR0pzzJD5QckuRuXMBau01Oz58G7MQgMqseNgzwC4J8XjibUM9MIoiA8Vs7
 6gWA==
X-Gm-Message-State: AOJu0YxFk4un/w5c8FksTArBapramKc6Hzl2mrQTrFWpuK/QboSPO84v
 4Q/gjuPRE+cw8mnbyFxpITWZGFsuhGxCK0ngX6LVHKqHSIFFVbCVNo4YrgUrTXg=
X-Google-Smtp-Source: AGHT+IF0NiH/y2x0fmE4RMJN3JQB/INvPFZ0DXMNIGpGkRRFfsozJay4AiHRh0+/GixCpYMIUQgpoQ==
X-Received: by 2002:a05:620a:4084:b0:7ac:deb5:43f5 with SMTP id
 af79cd13be357-7ae6f43c856mr1903954585a.16.1728320693140; 
 Mon, 07 Oct 2024 10:04:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae757626aesm271933685a.123.2024.10.07.10.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:04:52 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:04:49 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, ye.li@nxp.com,
 peng.fan@nxp.com, akashi.tkhro@gmail.com, sjg@chromium.org,
 festevam@gmail.com, marex@denx.de
Subject: Re: [PATCH v1] scmi_protocols: Update discover list protocol message
Message-ID: <20241007170449.GA4737@bill-the-cat>
References: <20241006095022.2800641-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SKsl6Fwd9LOVabOF"
Content-Disposition: inline
In-Reply-To: <20241006095022.2800641-1-alice.guo@oss.nxp.com>
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


--SKsl6Fwd9LOVabOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 05:50:22PM +0800, alice.guo@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> When work with System Manager, System Manager provides vendor specific
> protocol, so the protocol array size is not enough.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  include/scmi_protocols.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 43b66be00a..6204ce076e 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -146,7 +146,7 @@ struct scmi_base_discover_impl_version_out {
>  struct scmi_base_discover_list_protocols_out {
>  	s32 status;
>  	u32 num_protocols;
> -	u32 protocols[3];
> +	u32 protocols[4];
>  };
> =20
>  /**

Changing a constant from 3 to 4 isn't good, please define something and
add a comment explaining what the constant means so it'll be clear
when/why someone changes it to 5. Thanks.

--=20
Tom

--SKsl6Fwd9LOVabOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEFLEACgkQFHw5/5Y0
tyxB5Qv/XqgcKITPhzUtWnQnT9j1GGTxGX/3sl2KdMnPQjFsIUBP+h7LC/hATO6K
o4t0BSUHYH3Y64GQSzmsA23xlQr+jZzWk19lamgnLKeuUb1RdUm1GL+aHphbG2aD
L4Nol0rrOAo3PiHYsxvADUz2ubOHc6vkwtEM2hKdS4aF1ZrSmW7YcGUXbQZCA9bt
1+AxBf8NiGvIIHvP2ulUR2/+198L0U/+MsSNLQCS+i2HSnp6B5TRR1fdV3VtASkY
L1BLD4C5vf/WYBDs3e+DL2qx0/l3Enwhm4O7I+IWmD8nHI9iLgIwnjDOuXtPvFXe
nUAhffYnFxgp3mHU1tFgQ5ZlABxU2EVKqDUrcrgUS63Iu9Xf5T1ynvwRX83JkH1s
92gMsSyZdmOFSzuXrXOLdwX7mh39Gji7H+blXdhe/Jj5Ph8FkFSzJYlauC4AE6+0
6PU6AYEcKOD91bNG/+nTkm1Xow1RNKyEV26ZIf9oOwwOpLJQdYBvjGCO8RN9/aqE
Muu9rH8P
=Wyfq
-----END PGP SIGNATURE-----

--SKsl6Fwd9LOVabOF--
