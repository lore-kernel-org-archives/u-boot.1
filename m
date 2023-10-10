Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAA9CD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6966086D85;
	Tue, 10 Oct 2023 14:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rdIVni+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB5E86BED; Tue, 10 Oct 2023 14:58:44 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F4486DEE
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7a77e736dso17507527b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942716; x=1697547516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vTfnTxyc6TXOSidW65lfO63YtBApbwY6Ru6r5s4mmwI=;
 b=rdIVni+uOsXPrbwt+zE7FjIYk1DoxLE/h2Vf+8jkyCmUX/Wu+Zd+0mt9j8d36zTy8j
 h/gWPAi06k4184CKUC/8ol48CBOEaviIBJ4O+KQSTNGK2ZkLf3u0ZfeYij0WuRWSWxBb
 biPvThWUXANq5aPCMrkmoPKS8197WNjz/xs5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942716; x=1697547516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTfnTxyc6TXOSidW65lfO63YtBApbwY6Ru6r5s4mmwI=;
 b=iXlCHVMQ0a1Z78xvw95IrS9OuxIiZrGUwdXFj1zQP92kjhgFFqjU4kT25HvTJkJWg0
 WBdNvTVFotwr899A+zf0J1WM06ReEOu5K3yeYega78xKP4rSgyaUAlsqpdRmeIq2t+B6
 nrS995B9zKC8ANBTG+44tnK3unnzeb40X8Szrh0rBGVzfoW6HYHgum4J2WtGX55fnH3E
 6YgF5mXu20NRH0V8sEB4RTbu6MMjT5CeEh6rqgZKjxGDVzwDI2qGPIHzWem3dltoUKFJ
 kSy2tY2twyCN2h0Uz16taNKbDRU4eCrYoc+x8SugV+Rqlfukbwlpj1JUVuNLEdMMoLE6
 gBjg==
X-Gm-Message-State: AOJu0YwOV5+5xCwATiZbpRxfMmMV2GCiW7NbsPu4vV69+D98Gw8dbQB0
 QXil4s1fFt40JrDvNd1mEWj29g==
X-Google-Smtp-Source: AGHT+IE/l9d0rET8nAY0TvmqAKcDlWrgJ1h1BKPuF96NrU2LVwFQzrSd87aZ5r3bGy1l+ux3PdfvHA==
X-Received: by 2002:a81:b620:0:b0:5a7:ba09:e58b with SMTP id
 u32-20020a81b620000000b005a7ba09e58bmr2443759ywh.14.1696942716555; 
 Tue, 10 Oct 2023 05:58:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 o64-20020a0dcc43000000b0059f5828346csm4370046ywd.3.2023.10.10.05.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:35 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, patrick.delaunay@foss.st.com,
 sjoerd@collabora.com, sjg@google.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, michal.simek@amd.com, dsankouski@gmail.com,
 kettenis@openbsd.org, sumit.garg@linaro.org, sam.shih@mediatek.com,
 mark.kettenis@xs4all.nl, sjg@chromium.org
Subject: Re: [PATCH v2 2/2] test: lmb: Add test for coalescing and overlap
 range
Message-ID: <20231010125833.GB2227687@bill-the-cat>
References: <20230926112443.4190471-1-u-kumar1@ti.com>
 <20230926112443.4190471-3-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WO5hweo4U7Bs1K2Y"
Content-Disposition: inline
In-Reply-To: <20230926112443.4190471-3-u-kumar1@ti.com>
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


--WO5hweo4U7Bs1K2Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 04:54:43PM +0530, Udit Kumar wrote:

> Add test case for an address range which is coalescing with one of
> range and overlapping with next range=20
>=20
> Cc: Simon Glass <sjg@google.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--WO5hweo4U7Bs1K2Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSnkACgkQFHw5/5Y0
tyx91wwApAnHq/F6OyrRSkKUdKFA6qTO+rStsfe4hizTyJ4Q45YXvoZ4WDKdGmFc
W03ex6Rk/cQc+N2+zgLp/TGzsmSSO2QyLYI/u6DP1NTMEn/h6vsHpde2x27TlfmI
AejYKCk01nbLou7gK7xxtfZBLkpqtiKlflDcHCdozhrBh2On0+/QYKxANh7d8Ux7
Qs/eEABK6hJtJJTCLDQZ1zebPKnu+CHmrQNwsuQqKcmr6s/shPbs8yZbwDDDXiIB
BOpVX1pFuy13MMmsiy5HgWzGlwQz4X9uFbUi4jm2eSeZBo7Mv+82Ydo00kwSp95U
kk0JCZD6FDnjnsHAhnVTSDKFzWoywQzvOB4VL+/tNW4BE7mSlghFip+CEU0CBDkf
PooFj2FrY1okIkTz3MerDtq8cM5rKDWGRJDIUzjm7egNOaciDoRPaAr/PfS784kp
JqcrW2/kI2W0WP+Bq1nB7Ls8pkUOuJ2EGmWQw05lEq70kXu3x+31OleqUuRn2HRs
8+ch8Z3j
=fp1H
-----END PGP SIGNATURE-----

--WO5hweo4U7Bs1K2Y--
