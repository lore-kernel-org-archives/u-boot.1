Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF2FC4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D7387266;
	Tue, 31 Oct 2023 18:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WNY0Qwco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37E587479; Tue, 31 Oct 2023 18:46:28 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C284D87191
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d13ac2796so38628686d6.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774385; x=1699379185; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M4a3YaQcoEFVo2IqMGIBdtDofSj84g8HtNOIHvclvNs=;
 b=WNY0QwcoF0rx3mEHh37097TJbwF944NjcOdzLe3s8WVGr76xhrFZ+HMJdltMrRTIU2
 2zzU+gf+2esM71H7d7D36sPY+7IuN1DWrwH0ighs/hGvJNqVJ+OXtrMYNkdHf3buc+0i
 bOh4rucc1PFdFu2LYBixRgHwea13Nl8fjJGLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774385; x=1699379185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4a3YaQcoEFVo2IqMGIBdtDofSj84g8HtNOIHvclvNs=;
 b=WFq0c/O4L2zjaNvyE4xZHiHY538qevyJzAnFaIZP0C6eNZ2+qQISgrcZLV3bdlnspS
 ldT0tDXfGCeyvIRb6PypqdT/0YqRHraKmk2BxI+aWZN3G7M+OJQ+JyNtz0PYcTTxrvA+
 78qe4IwF30YoEC6HrpC/7/R8yNHxgvR94oj9drKDt3TJG4B/Rzqx1OTk8xlTQc3e1yKk
 FN7hQyaVuYUOpOucjnUQGeIWULAsuOoMb6MVu61+wkZCwKjJM2hJ4enlmAXXDlRmSv5Q
 N8hjinLc9ccqKaH79yRZydhTi+TlN425McNYMrZtoGAOO7Y/8v+Dj4SayIERSjzX3vu+
 I1uQ==
X-Gm-Message-State: AOJu0Yz/FhxKMfDNJGH3f351Nxz2CZlfZVSGy7y2+Ucb6OSS0xSNIeAU
 zYLYQCWkwWvloTyLssdixXcG6Q==
X-Google-Smtp-Source: AGHT+IFBL3MvkSdM61hp7d09qredZdISNIBoihgUb2U/B3e64iErOsDUx/kfm60CBoHJad4zhapGZg==
X-Received: by 2002:ad4:5ca9:0:b0:658:23a5:e062 with SMTP id
 q9-20020ad45ca9000000b0065823a5e062mr17715974qvh.31.1698774385608; 
 Tue, 31 Oct 2023 10:46:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 kh3-20020a056214514300b00655d711180dsm722507qvb.17.2023.10.31.10.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:25 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:46:22 -0400
From: Tom Rini <trini@konsulko.com>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, nd@arm.com, Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH 2/3] corstone1000: enable distro booting command
Message-ID: <20231031174622.GX496310@bill-the-cat>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
 <20231026125051.321493-3-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KuNh41BdYRhjx2wu"
Content-Disposition: inline
In-Reply-To: <20231026125051.321493-3-abdellatif.elkhlifi@arm.com>
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


--KuNh41BdYRhjx2wu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 01:50:50PM +0100, abdellatif.elkhlifi@arm.com wrote:

> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>=20
> enable distro_bootcmd
>=20
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--KuNh41BdYRhjx2wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPW4ACgkQFHw5/5Y0
tyza7wv/UlvekQ8AZZK193DEv+K5xiS6wUffBP2yP++DE4COx1D78Xs/F52Uq56h
1/920RK0d7Ui1stympeOkXHCxZKLmVeaavkh3T9VY9oHRGCYDOgCbocpWy3Aq2Al
79B75kQ1NBVOzEgGQXMkuafXFOKQRHOrhcDDCKt1G9k3c/jdLogMS6TTGyERw3EY
MoE6XfHhu2ZFZKpVOeBWN167osOi0qc8CKyT/WbjP0S07oYAEYz3vXUqEbQ/D5bx
JdnxGSvOxlDsEWs/6iSlPl/GOCgbf+Y00e/c+wk7nomreJzP/HKmJ2sYZ/5IClHY
C2JokLIDkxkT7gp3gICcTDUF9yHQI9pQHeQ5tCSdfs6iukUfVqlgNS0/3MqxvuKk
RSOxxOauLmDeb6VndWjHa6RcR0hBZbkcF9Y1WwwNR6fnLkLbMgr30jGueIKA1CND
5yDacdp7sBD5bV7rpgkc7OTquHL980Amxs4L8Y0x+J0hMiqwB9J4iS1GYpM4Si19
gML/5N/B
=GlHL
-----END PGP SIGNATURE-----

--KuNh41BdYRhjx2wu--
