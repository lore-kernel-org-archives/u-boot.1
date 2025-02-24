Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FE9C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 14:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFFB800B3;
	Mon, 24 Feb 2025 15:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mkwoXwK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA48805C3; Mon, 24 Feb 2025 15:54:16 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BACD80079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2211cd4463cso89051435ad.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740408852; x=1741013652; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6RiOZi65WqwdsONYLjS/2j5GN2ioxG9ftJZw1nLhUJ8=;
 b=mkwoXwK6qEutPdg33J0MQApe3L+ZSsSIdfmFSvffp1tuFrzblzMVEZuhBR9qdQZsal
 OrQj7lxQLR5UnxGTGxCtqvWxKKQAb4WKy6VfwWspCflMBgY4Pqxt/XLgBRk2lvLtBURL
 m8iniDTxsmfEOca2hjPf427UFTnOt8W/nHF3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740408852; x=1741013652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RiOZi65WqwdsONYLjS/2j5GN2ioxG9ftJZw1nLhUJ8=;
 b=eUWP11/TJnyI37GNWGTy04btsSRTb/lzQ/dPxz9bpph3hAloq/dBY9J1AEbPHVX65w
 ZDlJEbtGcUi0a6Pv6D0u6LcO/Hq0f+5LZai8M/QHycItmXwjJfG1zvEp+9Diu16iLbZY
 Ns57SoZVH8kP99QPK/G8WQrWler6hWNkoiwRUJEAuP6EMtdUx0ryiNvJ/VdmTR/V7vF/
 z+R+JsFuqXJoyafXyYJJFIjo1t/84zMJV4k25pvcgSGyYryEnS9d2vVvaAxWdt61p9+8
 y1cO2RRD3hQyQ278RjooNZpgqbDcYK3U2Nl8Cr2nAO0xUOKbhubTwDEb1gSH65wxbs11
 roBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3MkcmVp7HzwX9kCp1/EYERU4PbRuwSYKG2VnKYXS+FKojipZIPZQ4uzEHL+FP3ASiMQfKAZU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3ZnqYr0dfkpowIpT5yIOAkjVW1l1abMXnFrl9RHjiGPIZq6SP
 EKYgLnwfunkhhFXWAfOKeVT8JM+puZO2svJCt3tH46F1xVpmjBHJRfsf2X7S3Wc=
X-Gm-Gg: ASbGncvWQj24v1ADa5nwvjPR8TNo9lt/csJ566RZefhCnchqDWk7wPvyuDXg1gF88GB
 H2FjKjGLw9lx/JbxTy1YM5ODbyGeM5V6YuGY4mx+N1WxZQNNf0eDZMfYvBy1xibedvnenZN7xbD
 hoCOGBh+FMtipYAjrwECE5YiXGKk4ockhCHAODzgzq1G8/gP8D7GpXbcVDtm7GJbyG9IBu22Jqa
 2LMRA4bZixRgDHn3L7LMcCxRLhS7LCalqFtovdczAwAr7VrRE8LYwn33G6Yiqmlbvb/iGO9FTfD
 YV66i2h+Ph9h0G33QkRew362
X-Google-Smtp-Source: AGHT+IGeqUO1gxsGZ4QCsjZld2F7nlXjJxWWD2t0pDFpu4O59A8WTEFFMt5FnQtFLKqd7nav/oeEng==
X-Received: by 2002:a05:6a21:81:b0:1f0:e4e7:ef7c with SMTP id
 adf61e73a8af0-1f0e4e7efa8mr5707591637.28.1740408851387; 
 Mon, 24 Feb 2025 06:54:11 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242761569sm21385421b3a.130.2025.02.24.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 06:54:10 -0800 (PST)
Date: Mon, 24 Feb 2025 08:54:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: Re: [PATCH 09/17] spl: riscv: opensbi: Error on misaligned FDT
Message-ID: <20250224145407.GC1233568@bill-the-cat>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-10-CFSworks@gmail.com>
 <3382d476-c1b3-461a-b8f0-c47cccb6899d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="exFxJCMeDiUhmmC5"
Content-Disposition: inline
In-Reply-To: <3382d476-c1b3-461a-b8f0-c47cccb6899d@gmx.de>
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


--exFxJCMeDiUhmmC5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 09:54:56AM +0100, Heinrich Schuchardt wrote:
> On 2/24/25 06:55, Sam Edwards wrote:
> > libfdt 1.6.1+ requires the FDT to be 8-byte aligned and returns an error
> > if not. OpenSBI 1.0+ includes this version of libfdt and will also
> > reject misaligned FDTs.
> >=20
> > However, OpenSBI cannot indicate the error to the user: since it cannot
> > access the serial console, it can only silently hang. This can be very
> > difficult to diagnose without proper debugging facilities. Therefore,
> > give the U-Boot SPL, which *can* print error messages, an additional
> > check for proper FDT alignment.
> >=20
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >   common/spl/spl_opensbi.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
> > index 5a26d7c31a4..0ed6afeacc6 100644
> > --- a/common/spl/spl_opensbi.c
> > +++ b/common/spl/spl_opensbi.c
> > @@ -57,6 +57,11 @@ void __noreturn spl_invoke_opensbi(struct spl_image_=
info *spl_image)
> >   		hang();
> >   	}
> >=20
> > +	if (!IS_ALIGNED((uintptr_t)spl_image->fdt_addr, 8)) {
> > +		pr_err("SPL image loaded an improperly-aligned device tree\n");
>=20
> We only use pr_err() in drivers when we copy code from Linux. Otherwise
> use log_err().
>=20
> As this code is for RISC-V, this patch should have been sent to the
> RISC-V maintainers.
>=20
> cc: Leo, Rick
>=20
> SPL size is very restricted on boards where it is responsible for
> initializing DRAM and therefore has to fit into cache. We should only
> add code that is strictly needed to SPL.
>=20
> What makes you think that this problem can realistically occur?

I would like to know if Sam hit this in practice as well. But we have
had more than one place where because we don't ensure 8-byte alignment
and have use-in-place, that we've broken things. Picking up one of the
patches that would address this within U-Boot is on my list now that
we've had confirmation of some padding command that's sufficiently
portable.

--=20
Tom

--exFxJCMeDiUhmmC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8iAgACgkQFHw5/5Y0
tyxveQv/TJI2RwNtI/k85fG8CC8I2aHPk4maeY7uYqyUUfS+Z+zkjRkA1RBM3ylC
pYNhYVr+qyE/R4uXpRDvjpKPfOz+JNmqKaAGJqtF+DYCDfgE4VzYVCPaaG6n4AA9
d21UAhKDsfKAR+aEUAYFPWA+CpMB7WyjiSYiR0UEzuIp92EsU0H7E40fP7zgKa8M
5NVKcGSFSqRdAPnOO5GTtLEGRxaxqqo2oWYrqXJt690F2l+0/6M+/92IVJ9HpCJC
oSxssYvkNQHi1hHnCulR6V1Kstd7rLxfk2hw18uQLT5HzWKXmzVl3wGPznvNaVxq
zDe+vfeqxBgCiLx1LAq2mCWr6uoWIyF1nHaHxTPaxRl3EpVEOqO+sMVA+K7rehJn
TihlK2xJL07s79AIzT7hFnqHStLcxtJv3lnSTgbkL2VrvEPOc3f9pkOaQRXx1Tzn
7Eu5Xy4ENXuDTYwhAZe6BZpP4tevoBvIcmZ2H0XNgMpp36Pf8hceqMjVNjaSzJWE
yZTu/01Q
=L1JT
-----END PGP SIGNATURE-----

--exFxJCMeDiUhmmC5--
