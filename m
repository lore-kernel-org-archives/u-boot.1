Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198DEC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8A487C39;
	Sat, 16 Dec 2023 20:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sO5/v7a3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04ECD87BF2; Sat, 16 Dec 2023 20:58:04 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE63787B48
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67ab5e015aaso14920436d6.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702756680; x=1703361480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rq4QbDXXwoY3SWziARKe44wRlXxhcOLbKdkN6iQ8k9s=;
 b=sO5/v7a3jXQmu15tSGXbKnBjmNAN5ofuTOMj3TtvyJUY0TbEq5Jb26Kkn+lgpuYtyz
 1LKmM9HGbFdSJQ3+yRp/ah29EnEgPfsRzu2+Xw9JQLq0FifP6UCF6xxQptIJFsn7ZbEB
 RVj2TxNx7VV4NRm8nhgDSUpoYacfylFljAtjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702756680; x=1703361480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rq4QbDXXwoY3SWziARKe44wRlXxhcOLbKdkN6iQ8k9s=;
 b=Dk6YIrciVMPn1sDNcQUbQZWmNVkuHNN1Rqk9w2ab2cgcx9k1KHVHMvKQ72mibCo4H7
 6U1qXbEyQLFhRZ8N36Ui1YrvX5nbxrcx9H1Ttw2Lxe5aA1EP3fekIrnDEImiqg7CyUO1
 /tV2Lfx+hjeLylso+sRy8qZim8d1Drcmq19aMMGccDx4pdC0Xm8l27G+Y24AUHI4c9wG
 sP9nv5C3m5ZT50E7zn9s995p3fZTal6kUPBYpqcm5GGeoqiSdKk6ZIAQOPBmatCIHD56
 RQtErSCdZdNAKufmrC1xdb3IbvCGSYpZNcQm4wIkuWpwWHmaPaPdxh0klWsh9hqwdShq
 fj5g==
X-Gm-Message-State: AOJu0YwUqoztKZXpvGDzDtuEvEte2HhQGDsAImxnloQhKdA4040EA5hP
 fGb+OzcdMoDEb9iDHuPG3zIAmw==
X-Google-Smtp-Source: AGHT+IFxN+NxUyps2/rYfOQBBCT8SijJiZr0BBABhKcZehr17XNZt8X3TOoqH6koJalh7Pg6Au7eMg==
X-Received: by 2002:a0c:e801:0:b0:67a:bb37:d9b5 with SMTP id
 y1-20020a0ce801000000b0067abb37d9b5mr13591474qvn.21.1702756680623; 
 Sat, 16 Dec 2023 11:58:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a0cfa4a000000b0067ef3341c77sm941583qvo.39.2023.12.16.11.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 11:58:00 -0800 (PST)
Date: Sat, 16 Dec 2023 14:57:57 -0500
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
Message-ID: <20231216195757.GZ2513409@bill-the-cat>
References: <20231201005507.2080396-1-seanedmond@microsoft.com>
 <20231216170949.GA706916@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L0z6jI/LAouRlojr"
Content-Disposition: inline
In-Reply-To: <20231216170949.GA706916@bill-the-cat>
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


--L0z6jI/LAouRlojr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 12:09:49PM -0500, Tom Rini wrote:
> On Thu, Nov 30, 2023 at 04:54:39PM -0800, Sean Edmond wrote:
>=20
> > This patch series creates a common API (fdt_fixup_kaslr_seed()) for
> > populating the kaslr seed in the DTB.  Existing users (kaslrseed,
> > and ARMv8 sec firmware) have been updated to use this common API.
> >=20
> > New functionality has been introduced to populate the kaslr using
> > the RNG.  This can be enabled with CONFIG_RNG_TPM_SEED.
>=20
> This series introduces a fail to build on ls1012afrdm_tfa and others.
> Also one of the patches has a double Signed-off-by, please fix that too.

Also, a large number of platforms grow by over 1kB, see beelink-gtking
for example (and use buildman's size comparison tools).

--=20
Tom

--L0z6jI/LAouRlojr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV+AUUACgkQFHw5/5Y0
tywfYwv/czDJT2byyfMdoalF1iE5J4+v1bJ+GeScYC9wCGN/K1ti0xhvvzS5ZnRn
cFitXmTkxiT9AK8IVrFXNTEyjihgbNl00QBv2v/nruLJes0cKGLzwc4xQBOoSgLA
JRJoTSilMkPPP+uis+9g7m7B1ki7HeWM5wLZwz19L0JFSM0Dr1a3ZWe+nivaEJvw
xviohKkCXnZWyo0e5mwhVLNCJ9HjqLI48dMmM51JkPUj8EvlKEYksATTAv5PZHpe
WFjFwtX0fv5nnpniC5KejmznAi2DzkEV11Y28NP8Bt70i0DKGiAospahjZ3kGaUI
kLZy6S9GGptnM+KF2V72zbDpUkqqyF8kGMdMc5kSH0XFgYoD2qgWqvPFQUdFjtsJ
31EToPO5Ny4oMsVX7M9cnx3+nOU6QNLJlokudnXu/ISMsD/oLGoRfrCBgHYQbzma
hNVU+t9DqVIdRXUC2A9Y7wqaKN8t9AstTRSunkozOLopL2nbW5Rh2qsuntShwW9L
3D1BoAbJ
=nk18
-----END PGP SIGNATURE-----

--L0z6jI/LAouRlojr--
