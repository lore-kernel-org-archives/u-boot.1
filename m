Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20716C54744
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9A38897F;
	Wed, 28 Aug 2024 01:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QBSXtlUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D372A88931; Wed, 28 Aug 2024 01:59:40 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73B288A3E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e1161ee54f7so6578144276.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724803177; x=1725407977; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f6F/89Z+sT2GBT+Ifkv2kbksmBe+PbFQgarnj9xhZkY=;
 b=QBSXtlUJvVoDyHEFofEaUEl+Xr1hhuXDzLJXmRsaX9KaDqT6ILTgx4pTsRsMK01R7w
 eiO4Wn8HkXWaRNwFOJq+kj3+A/1aVu2kxhydIJcDlsH7xOAVaIqXsMPtzMcnopF1oyG+
 hrXV73olB2uwLw1F446URESfyLYA0XBmu0rS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803177; x=1725407977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6F/89Z+sT2GBT+Ifkv2kbksmBe+PbFQgarnj9xhZkY=;
 b=OIIem3a0cDXIIZAwGPMDHKCT3rdhJEp/CBMyAl9MJ0uq810ZaU5AfJxljD3u7XCfHb
 kswh5CBODvCXtVJwyI1c1fevoBA2lsPuPOa+LBZDuujRvbJZPkSq74zBc0yonIPjAwPM
 Jfy/j2oA0obhr5H7Rv6lF97hhMtd/wjXuvsoDVqCe6VGt083dK7w0p7YxTecS2nLtCJ1
 8BtDO8ajLtvimRspdqS5sjb89U2zktJBmRxcG46BZ9zYo23n+go+Qff7me49AkFbhveA
 zKvFeOLc/YDACRIm6Fdmi6Tpz7RyaQYVGUKmw9X8IfPdo8J+3WJ9YfnGJ9px3YqSEdIb
 OxJQ==
X-Gm-Message-State: AOJu0Yz33NbZPwOwCRkHYZasz76dufrZCDXUy+nNNMjfF2qzbwP3C/Pj
 OcytQzQDVnvkbolvuyMN0QIZvdqjHmAM4G5IdjBWn+7ku1VezZoa2XfS9hhQ6K0=
X-Google-Smtp-Source: AGHT+IGxmBEQsmP9iufgWfpzBBygYOYpVV+yt7hi3He/e1BdUrArAj1I4oAffGUK/O0WQcuUl7lyYQ==
X-Received: by 2002:a05:6902:1502:b0:e0e:887e:880a with SMTP id
 3f1490d57ef6-e17a85e00bbmr16833179276.33.1724803177367; 
 Tue, 27 Aug 2024 16:59:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dd1dbesm60949376d6.128.2024.08.27.16.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:59:36 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:59:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] list: use list_count_nodes() to count list entries
Message-ID: <20240827235933.GA2976080@bill-the-cat>
References: <20240731145521.19527-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OeAfiWVw2Azya9CN"
Content-Disposition: inline
In-Reply-To: <20240731145521.19527-1-sughosh.ganu@linaro.org>
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


--OeAfiWVw2Azya9CN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:25:21PM +0530, Sughosh Ganu wrote:

> Use the API function list_count_nodes() to count the number of list
> entries.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Note: To be applied on top of efi-2024-10-rc2

Please rebase this on top of either current next (if not a
bug/regression fix) or master (if it is), thanks.

--=20
Tom

--OeAfiWVw2Azya9CN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbOaF4ACgkQFHw5/5Y0
tyzaTAv/ZZxcqQfuzUFPo1Q9b61uzGc2aNvr3n2amMuGTE/beygVTM0pCIiEGO3W
egjqvc5W/rVyH8XGaAxW0IbjA1vLEVGyyp5pan5oItwZ3IY6w1h9qXdhY9BMxBa/
b+AcEZmmsjia+NjiaTueAKbE0ASSeZhSK6O2mWU0gk7pLS1xFkUwJoGSY9dLx2AW
xTce5JKpkfBFAjaEo4DWGsg9gTNl/uz9Yq6uH6h2e/8YKiXIzGdxYq6B9Kl/FBQy
L7yYKqXFD+vQJRH21zG3b+XuAyZailYYq8D+X9rVaKmJc+yVgWwt3AssWIYupCzw
dr8sgkx1c0fsjTp32Ijs86WXJT45cHiYOLGjLkL2hQ5idCMRsKkBLMTJkkk0+IGZ
Za8uVF+cd3FPyDauRGnyWGRPVbIL5+53T2Qwu1kQXWK6zStzBkhRBIA35PIidNL/
GNRh61LJ/dKUYtrjvAnHh2mVHrIcnMgcNCPBQ9Aygqr43jEXHZVQhncuIytOz5rr
j8CeVWvO
=9LQr
-----END PGP SIGNATURE-----

--OeAfiWVw2Azya9CN--
