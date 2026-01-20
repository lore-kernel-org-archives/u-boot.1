Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C2BD2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F094983A8F;
	Tue, 20 Jan 2026 15:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aBXdVaKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B5583A91; Tue, 20 Jan 2026 15:35:58 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8EF83A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45c8b850f96so3532340b6e.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919755; x=1769524555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CoQQLYAdwi95gfJ4BhN82mHCeihVKEhEw9/kRqcmPMY=;
 b=aBXdVaKrlAQFbUCMz72dxhRcwwmYYRnGAML1Zf2HkyytNptqFi/XNJu8pF4jlzmy4z
 0cjGcluiIv3J/9hMsqKh2kLpTikNKgILUOJzd8guGz/UdO3FFls6VizTK/mZJxonSOl/
 ndOgFnpu8vGkZhxzfwmO6M3xb2pxHt4sYh5KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919755; x=1769524555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoQQLYAdwi95gfJ4BhN82mHCeihVKEhEw9/kRqcmPMY=;
 b=Bw+5TtxO81DM4I5Mkh4LbSZB+kIZgd1LkI3OVirHyZUzGcrB104goJV9zyvE+Jn2Qy
 Qgv+51bitXbriF+kiHWIgWX/gadAXPwE1rpt2uWRQ340CiA/sFmI/ZmxNaG7AoKNF7go
 Hr2oBciF2zZth4LlxHZM1iiGpp4Q9yHXrIth2d68lr0mxeEo1eKy9gptheG2k/XQaNeC
 XIJNR1DZSGiXqqon6SEBmYccsUZFKgsgAX/eP4dU07hUsVn3w7klCTKib+W7VMKwajC+
 7JBGbI0rgkWmPO6TG9obcHSY/UTIMn5JVRTYGX1QgWOVInY3jkLF0qyZQW8J7D1UY7dy
 D48g==
X-Gm-Message-State: AOJu0YyknQ957oSnch8vezDhcUcIfGfOPLLGmrc4g8vkLCUgxH4o8PQm
 DeGL5mpLq4pJqnzJaPYgKa4ehlFNLnQwVO/0gm2EzPyEDOOsDfJtJtcppSeyKLC66kw=
X-Gm-Gg: AY/fxX5OZQUOrgEgHk9/4tH+fpWDjo6mJkvyRXsZO1AD/TnZN7TdV5IBA7VlIp9wdLs
 pAzv9EV/1cu4BINP+CofCLgFoe0JuyUK5ZrQs3oo01dMxuBrcPAt3guOIDlSWTy43dxr5jXyBfZ
 CpWwkkK5LRQAiFmX0nRfF4y+TuFZRzaz4yOoMbRVT+67rEh/GcQc/JhV/2vthAyDkcyTHroH85U
 +NGfCE4nEyUpnfpsg8ul5dF0LRrGBBTjGe1T/GwDO/O3EgnT8S8pgQt7SlcaHHRnRTNIi4aurL0
 nIelFGXq2ucrfzVpnodsJ8VWtDOGqhesx3HG6ASnPDu3gt0lX8frzfucRjXGny/l5wTedLwXvWW
 kGHe3bgYEebrI80frnT+lFJbjplwxaLi0FPkcg4h7b0uyJ4wEvFKtYQZs7Va+/h/ELIQYAJ/wTE
 VNABjS+KE85ZNanLChkN7kUbip6pbYLIhbapvYZ05uZ8jxSa8vflnLF3hljCKFxJa3Uo2wlxn+m
 seqC0k3/LL9Vm55mDW86ur/1CNJzexDXTKTbU8=
X-Received: by 2002:a05:6808:5381:b0:44d:bf83:d7f8 with SMTP id
 5614622812f47-45c9d70a42cmr5875943b6e.4.1768919755453; 
 Tue, 20 Jan 2026 06:35:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9df08545sm6866724b6e.8.2026.01.20.06.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:35:54 -0800 (PST)
Date: Tue, 20 Jan 2026 08:35:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, eballetb@redhat.com, alexl@redhat.com
Subject: Re: [PATCH 2/5] disk: part_dos: Align dos_partition_t with struct
 partition
Message-ID: <20260120143552.GI3416603@bill-the-cat>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EJk4QRkccPo+TtDi"
Content-Disposition: inline
In-Reply-To: <20260120133630.1695055-3-javierm@redhat.com>
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


--EJk4QRkccPo+TtDi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 02:36:11PM +0100, Javier Martinez Canillas wrote:

> The dos_partition_t struct defined in part_dos.h is nearly identical to
> the struct partition defined in part_efi.h. They differ primarily in how
> define their starting sector and number of sectors fields.
>=20
> The former uses unsigned char arrays while the latter uses __le32 types.
> Using __le32 is preferable, as it removes the ambiguity and potential
> misuse of a raw byte array. This also aligns the structure with how the
> Linux kernel defines it nowadays, which is the original source of it.
>=20
> To prepare for future consolidation where one of the data structures can
> be removed, this change aligns both definitions and updates all accessors
> for dos_partition_t.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--EJk4QRkccPo+TtDi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+SyAAKCRAr4qD1Cr/k
CmaJAQC7BYiT/a2nBRxvnTNKo6ychsDFgKW1AlBSyl7zC45u9QD+MWZr9xhmr8Pn
Ilv+Vl27zvHHkhFndlgaHSKnWemQGQI=
=Fyin
-----END PGP SIGNATURE-----

--EJk4QRkccPo+TtDi--
