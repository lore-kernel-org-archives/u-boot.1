Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A86C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7F9874C3;
	Thu, 16 Nov 2023 19:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OJqaj3+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03A187452; Thu, 16 Nov 2023 19:34:09 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86C9874C3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77784edc2edso64354585a.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700159634; x=1700764434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F+LZAXZlAVihLyN3gGZS00kttWYOvFyt2SH5csznHvA=;
 b=OJqaj3+rssBWmBVi50cok3nUyUbL+yA2/A79SxLwkWrmJMRgqnFhR5T2qkT4aqUUBF
 zsq2fiKfPmpkyHztY3OpOKNlKiXUAnL6s3nmfERj6dIGLhAfpucDcG/u7lRgcwDGIn76
 mBL13DkGRP4Rh7cF8KbfILzI9SBCQWge7M2Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700159634; x=1700764434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+LZAXZlAVihLyN3gGZS00kttWYOvFyt2SH5csznHvA=;
 b=GXRmcTON4YmGno9wuh23tqx5+bu2+45YXa0PKyHF+B89DwXpD4RnGHgePhuIe5s/8T
 oCnUXcFRZR5oKE209RyvbxmbBp9YePpHYx1IMOxqNU/obckqz7OMbdKbv9jGBw0JK5Dz
 EvFfXH4OTrJ66Qvjg4QPb/vw89IDKpEVdidmoc2GX0owMxrZjcEJRlMxZjT/PKN8DN+x
 EphI6WfcIxlNV8bp5NymgrsF6weMa3RLGa4H2OFnEKsTq3gqNl5aZ+dRNJZLoCwao716
 DA8aqtRSgfHi9P7rLNJ7K6vqGqzpCNy24VYSfyllxk6LaTFZuUm6ThmkTpLKbsyJtnoH
 Y4lQ==
X-Gm-Message-State: AOJu0Yy9igtDlSO5SHxrNmEr6YqYwhxv2GkKmzUY7K5tZwvSaFd9z3Gb
 iTRTHRsKS6JR5bEAtNq9iBhVcg==
X-Google-Smtp-Source: AGHT+IEJKNCkUCN56lWrRlkQ+8UKK8uPEpVrEoCsI+0BvK1hX3aAzK/g5nydSz1Juybjx0VMHJLjdg==
X-Received: by 2002:a05:620a:2948:b0:767:2076:5bee with SMTP id
 n8-20020a05620a294800b0076720765beemr11207178qkp.9.1700159634483; 
 Thu, 16 Nov 2023 10:33:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a05620a450700b00773f008da40sm4448857qkp.125.2023.11.16.10.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:33:54 -0800 (PST)
Date: Thu, 16 Nov 2023 13:33:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] fs: Fix SPL build if FS_LOADER is enabled
Message-ID: <20231116183352.GB170968@bill-the-cat>
References: <20231116171612.143910-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="acMjxh15u9+HpTKx"
Content-Disposition: inline
In-Reply-To: <20231116171612.143910-1-mchitale@ventanamicro.com>
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


--acMjxh15u9+HpTKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 10:46:12PM +0530, Mayuresh Chitale wrote:

> If FS_LOADER is enabled for the SPL then the build fails with the error:
>=20
> fs/fs.o:(.data.rel.fstypes+0x128):
> undefined reference to `smh_fs_set_blk_dev'
> fs/fs.o:(.data.rel.fstypes+0x140):
> undefined reference to `smh_fs_size'
> fs/fs.o:(.data.rel.fstypes+0x148):
> undefined reference to `smh_fs_read'
> fs/fs.o:(.data.rel.fstypes+0x150):
> undefined reference to `smh_fs_write'
>=20
> Fix the error by populating the semihosting entry in the fs_types array
> only for non-SPL builds.
>=20
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--acMjxh15u9+HpTKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWYJAACgkQFHw5/5Y0
tyzc6AwAid7HQCefiioIlqjAXIBwvKzTyqaF4cWYSHnRCnhXOPdLWC+S2TlVDBNn
59qV1ZV3pDbyCiXTg1NytJQi13qo3vjMPWCJcc+8Fa0ZkK957TytXpE5JQuf24n6
l4xzAekwlOzVVKrsyDHuPVeVIqNgGBncKNhUGvOtCsk40BPtVVFuVys13Da+B5sT
09SiMA7Oy+m2o+sQ52Uk0h73FNfqjFA2Kt0gYF6s9BBWFW0UiaPaBKNv2+hLA6qc
NOVPpNkGmyutnSg54jBVbeJNVjurUvckXnvApa9He1DvYTb/V2SbIM4eHH2h5cUj
nViMRFy4kaGDV+SGXVos6+sbh5YeOuEHef6Loycrlqc/SAIo4QOJ8uFHx/GYkFxM
kdZ6+JrjCBWDUpC19FLd7BmKO+13DeMxajj1iQDAnLgeVbw8sqZYRuyjfBix/h6W
SAD5qUGgOcHBQ1+ztIh3F10h6XA+mSdeU5YRmLKriVIO6d8hW1VRIIB//omCxt5a
i3hZI9BP
=i/jV
-----END PGP SIGNATURE-----

--acMjxh15u9+HpTKx--
