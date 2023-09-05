Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EF3C83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 02:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE3C8690B;
	Tue,  5 Sep 2023 04:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zx2+VmV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1ADB8653E; Tue,  5 Sep 2023 04:27:12 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254A486611
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 04:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d7eccc1b8c6so1731298276.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 19:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693880828; x=1694485628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JPbbK2CFy6GuQV7pCIBUtXKh34byijrV1EaP+tEyTRI=;
 b=Zx2+VmV6S3LOx92S0NYlOfMLiySev+VwDu5d83UkBnzRA8MDP8tnfCBWqkFRwX99fZ
 o2W6dQwLy/D/vR3WJBgNyD1AVDWaKGuvmChKHURmnf8tfvcyxrB2k6it++Ou0wnUVezh
 TALD5uAnQa6dsSGpmZYak6YiGujGbOikFVDWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693880828; x=1694485628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPbbK2CFy6GuQV7pCIBUtXKh34byijrV1EaP+tEyTRI=;
 b=NRxZb3BmZLr2COKdMciQEj1jMIFqz/kl9yi6Hva1qeMul2DIqmf1fda+bEFHEF5h/N
 d1r3Gz3ADWflElu6BVG7Femyp8fZx1ouZ5GLpp5psd5oMXu/dKJODM28za/l15/idR9C
 cSYIXSVx2tJ/ejIId+kKrHc8S+N43C4Mtcp4uVSwvXt58bp3wX4g0lLDlRyAdjr3kRr4
 wT3gQbpZnQhPKJhfHZv8JZbJB2l4Lc5cuEzYoxGPwqZJydFQfFuN5HtSWrybMWi/Pj6O
 H3Y/x/ETp/SqMqG9GivP0txRirsvALxEtPyYRXAn6B9nk7JfuDGNefHlvAhnkQivkATW
 di9Q==
X-Gm-Message-State: AOJu0YxUj10+UUYu0oemWpfmBa+Ul2/wevNYmepv5FiIzZDwpimPZ6lA
 CjrElS4xD2qtJ88NghvaEFPnsVhomiq9OEziYF30bQ==
X-Google-Smtp-Source: AGHT+IGbCNSOizfAoI0r5MXx3C4AwIbOpCeg8xvq4jVdfY0S85HiQ+s5z37amVMhWYyDf3NGG5is+Q==
X-Received: by 2002:a25:8451:0:b0:d43:18d7:e292 with SMTP id
 r17-20020a258451000000b00d4318d7e292mr13361926ybm.32.1693880828697; 
 Mon, 04 Sep 2023 19:27:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 200-20020a250bd1000000b00d13b72fae3esm2578578ybl.2.2023.09.04.19.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 19:27:07 -0700 (PDT)
Date: Mon, 4 Sep 2023 22:27:05 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 2/2] nokia_rx51: Remove platform
Message-ID: <20230905022705.GJ3101304@bill-the-cat>
References: <20230905011228.4006020-1-trini@konsulko.com>
 <20230905011228.4006020-3-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aYd0tubu72f2029A"
Content-Disposition: inline
In-Reply-To: <20230905011228.4006020-3-trini@konsulko.com>
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


--aYd0tubu72f2029A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 09:12:28PM -0400, Tom Rini wrote:

> This platform is behind on migrations (it is the sole user of the oldest
> legacy version of the USB gadget stack and is long overdue for
> migration) and with Pali no longer being a maintainer, we remove this
> platform.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--aYd0tubu72f2029A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT2kfkACgkQFHw5/5Y0
tyzzIQwAoMRU/UsZgljzRmSXalXeMntvze63etR2T2fmkpVXxaIP+rwqe66u9nnf
Q/hvU4u8uKRnoWvNz/NcfpOMh2tvzqa0Meok6ADwKl3kU1v7BNSny8jaDaiTUhZa
BknmYbi3+q7cszEj3pRlxpibOul025prb4pX1ouFocs9r3iccXImpD/HxWqng7/B
mshvL/xgECCmbbK4eGBglLauD0EqZRWkRWBMQVf1Vi9YHIfWwgc0NafGElg0sZ+V
Sln91GpaNucTG7P7xKOyu/F4UfSo5ItY8TnA5/sPHsEZyOCiluWzwpqZA8e1UydD
vHp7kXlUG0yhzBCWBBb504iajvG/a7K1D29ZwBnVK+0M9pD1MK8CI5UvN1rWziRz
Y4dmTV375rSczI8skdnHLbFX0+BUH894l13wnRfv4AngknVRc0F56TGDcPVK6c+V
Cdheo9Td6KSDCp3DLjQ7N6PUcgdS7wwv3TihLH5QQaAxOzM2KYvmgGF5k85OvXgb
5msh+PcF
=kaB6
-----END PGP SIGNATURE-----

--aYd0tubu72f2029A--
