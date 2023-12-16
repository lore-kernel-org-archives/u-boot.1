Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A0BC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0FA876F6;
	Sat, 16 Dec 2023 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kVlqCuhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFB1876F2; Sat, 16 Dec 2023 18:09:55 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54687874FB
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67f3135a717so1600696d6.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702746592; x=1703351392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Kz0qqMDTC3aI/gXUKfTIa2QvGG4+6KAS794JNthpQM=;
 b=kVlqCuhP1ViHF4o2b6lKhV7BqXdfQ1HGk7zbhuI6tepslCXtMPY4yfaUVZ/UhgdJn+
 rHEoxQQJBTC6ayBA+rgxCPjcj8BdZ5hCxmFBNXabo9/P/azfak6cGZx/BAaN2SDKCk39
 fDqDITYmuEbOhWbefkXrijBrgu5qdg3JanLrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702746592; x=1703351392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Kz0qqMDTC3aI/gXUKfTIa2QvGG4+6KAS794JNthpQM=;
 b=YUyctIRc7foxjYkFDXKt9YaSzB9ZNSSBdqD0BDFYXzz/uuhsrO/GXqg/jM7rNVQyvy
 sEdAXv7Qv+8xS52euwq9V4ShrAw3O+XPkD+X60IjDABwWDhVIRNAcQXIIQmlh6Qwskg2
 y9s1FaFcwc0D1TXZLUif8uOMBnUMilBEji/KnRxecO+3sdv/4SRXpk/X+XRSM5A8qCnm
 WEqXt4WcZ38apJS/wt+iL/s0Uua4xRcMPpjfcNWkAROl6HeAG9Nm+l6ECl0mtCf2sg6Z
 7zZl7R7TjI0z8jVC+gnvVeZ5vYbne/EC9+vCdftaQo8R7LW+7KOzIhHfPEOheTVUhpOC
 KWwQ==
X-Gm-Message-State: AOJu0YxCkROe9sGQEYm9qWtBP1wV0yl/gstvdVJU2X9etI5fciQnarDg
 X0qNx3fshjmDygrdshU0Kuwylg==
X-Google-Smtp-Source: AGHT+IGvLwMMCTQ7XtAejuL/p2zkcnQbc2EJF6sX9iWvcKW7i7Z8aAUcUfv1Djdp2iFtFSXIb0+Meg==
X-Received: by 2002:ad4:5ca1:0:b0:67f:2541:1b6e with SMTP id
 q1-20020ad45ca1000000b0067f25411b6emr3637304qvh.27.1702746592097; 
 Sat, 16 Dec 2023 09:09:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a056214017100b0067efaec8127sm3182947qvs.13.2023.12.16.09.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 09:09:51 -0800 (PST)
Date: Sat, 16 Dec 2023 12:09:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Edmond <seanedmond@microsoft.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <senaedmond@microsoft.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v6 0/5] Populate kaslr seed with RNG
Message-ID: <20231216170949.GA706916@bill-the-cat>
References: <20231201005507.2080396-1-seanedmond@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kc3hNuFarHh8xE1m"
Content-Disposition: inline
In-Reply-To: <20231201005507.2080396-1-seanedmond@microsoft.com>
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


--kc3hNuFarHh8xE1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:54:39PM -0800, Sean Edmond wrote:

> This patch series creates a common API (fdt_fixup_kaslr_seed()) for
> populating the kaslr seed in the DTB.  Existing users (kaslrseed,
> and ARMv8 sec firmware) have been updated to use this common API.
>=20
> New functionality has been introduced to populate the kaslr using
> the RNG.  This can be enabled with CONFIG_RNG_TPM_SEED.

This series introduces a fail to build on ls1012afrdm_tfa and others.
Also one of the patches has a double Signed-off-by, please fix that too.

--=20
Tom

--kc3hNuFarHh8xE1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV92doACgkQFHw5/5Y0
tyw0Hgv+KSkSLWto+lK+mCvypDG2ziKYUbMUXr4wlO9WteQ9Rltt1KoKEOLGinI4
66H+vrgGoyqCDCCTEDY07o61g5S3lYSn/AIFVxakpQys94oly/of7tdifXvUJ7gU
4dU4FLSBHofOIoa9jVMRIKdPVXDvYae2NP7as+9+mv/SuJRJk0BIXg7sOP6JbfEb
Uyb3wZK62+61NK2cIjHlsbK/WaLGURlo7bV3e63JZtY8wmbj0VmK7F0MNvgQV1jc
z2a6P5UbiSApMMObAxnih+SBjsSWDgLyCshXgHpChkn5iFbs0Um9ufebMtpjNc3V
E4wBuFn0uYNCCjDw2xcrmYWlvEdVezZQWSx62eDTOZbje393A06qp68znhYhoSn0
X1V+Z8EdmMILP1UXm33IbCzORPAzV0DiqfTcOBO7X709Ad/FcSkcGZO5HE3h5yQ3
ia39O1djPKZA5Gf3MJo+354QU3vqactDYWa+DopgnrqPDzv0MdK2OPG3D6dp4Ph2
0G60dVhE
=R0Kc
-----END PGP SIGNATURE-----

--kc3hNuFarHh8xE1m--
