Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B43FEF8FEF
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 14:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F3C839A8;
	Wed,  4 Mar 2026 15:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IKL/XlqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E375F83BB1; Wed,  4 Mar 2026 15:38:23 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5041838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 15:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c307db9aso4386647a34.3
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772635100; x=1773239900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fBUP0qbNd8Wx0xsWXdRdoowFRPKmcCDj3WITAKh1mkU=;
 b=IKL/XlqE4rV7buOlHTfEAveLGkzcEhkG1UMcl6KlCqHHvkYQdbVfduZL1xCFHeFJGM
 a5WNmXMJrNV5N0fJzpYAJg0XDKUKsy4qotGzwPeQjQ1Vf43YizK+/QNeYaBnSN4WjJmR
 knddX+/YP7E3ECzyD1pr+2HzDUq0UltCG1iHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772635100; x=1773239900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBUP0qbNd8Wx0xsWXdRdoowFRPKmcCDj3WITAKh1mkU=;
 b=aozzCuodOgpGC+v6Dl0i1FMai+yE5CuH2Keb/28iiUIMlo//SEkw5mxDOyVwOZ7dBZ
 yNAnxmJFvjzqmzC1Uh8SGhxgbYN/1HrilrtZnw0bUmaSjJmQAhKULnb5ptL6uycqkUfD
 ZKAtw3HsadHnqwm5QSs4/crMI8A3ZXBxomeOH55s9dSfIMUbFjdikesqbRMAN7w+fBnv
 BnwvdcSigVzjzx4dBYI6VkLbWr5yKUlFjpFtBrHIYt5B1PLdtI8pD0O0UZiTushAZaCR
 aHuVlCFU615btDzUwN20DPp7xXJyZ83On2cAu3RtQddKiZ0iiItwERuJAf9NYPulXpIs
 RtsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfXVj/uoayegALwJKUR+p466YxPQPKUk0yEk90GY+Nlrw9RIi5Ua2ziribZD2fem3o7YTCHYA=@lists.denx.de
X-Gm-Message-State: AOJu0YydAQJ5D/Ecv7qM89ESaryU7ARuvjVLFNOKD9eF3FQ+fEbuZJ+F
 um5w7Bq+vZrzJ0SfupNdHbfy0Dbu3DEs7EIMGlnPJCne/5o6N5g1uOShpP7UrBULynw=
X-Gm-Gg: ATEYQzyCWUBOBR9i8/IlHAghSs48Jxsjn9VRlYiC/yD289lqRXPQg0oK+d6N/oQG8Of
 x2QLm3aC7doeQK5Wk6fnyFEYztO1QUd1nY83uOhKD6ijiGxIoPWoI605tvieJl/QLLcb/jKOhWP
 CXfP2uunecJV/Gl87xGOlbcUa1p8fbDGzDbHNz4HJaXUw9nXUGmVTHl1cLTWDpqmd0UAz/rQWE0
 dwiJBMMmy7xHSNPwv3+EayVqko/hlcVslFs3fBhC9Ui6sc7ZrUfDeCpZy23oNgCkLegM/mRXJdc
 8SxhZ0PewCKatzY7BFw7ARoDuFfF4al+wgHl/oIQgeJE+I/H/IPQi17OApNrv5DY3pzkuMOIYdY
 xa3FLP8RtVEiojumeEMRo5kE3ZXPsJRaVGjFrArmrv8nKvDe5VMkZhH5lbRNV+tR1PKapaYXC9A
 hFR82KSp+NaJL8Rbd4F/+5Fi+FjB6yHoKhyJMfg+h6AeoO5Q18JhPPOMRmEGu4tHcdxGRJ5DEG7
 qJHbCc/HcbSBCTqpRHirQjGuwTI9LiUWcqZEtGWFiBUqpbMI4o=
X-Received: by 2002:a05:6830:6d13:b0:7c7:5458:75f8 with SMTP id
 46e09a7af769-7d6d13becffmr1043328a34.29.1772635100456; 
 Wed, 04 Mar 2026 06:38:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5864743c4sm15692091a34.12.2026.03.04.06.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:38:19 -0800 (PST)
Date: Wed, 4 Mar 2026 08:38:17 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: Conor Dooley <conor@kernel.org>, U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
Message-ID: <20260304143817.GS1388590@bill-the-cat>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
 <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
 <20260303170554.GR1388590@bill-the-cat>
 <09b4a249-15f5-4e0a-ae51-b248aa57bcdd@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2QUtM56kIrWNyNb4"
Content-Disposition: inline
In-Reply-To: <09b4a249-15f5-4e0a-ae51-b248aa57bcdd@altera.com>
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


--2QUtM56kIrWNyNb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 10:41:57AM +0800, Ng, Boon Khai wrote:
>=20
> >=20
> > Thanks. And can we reasonably follow what Linux does here instead?
> >=20
>=20
> We don't have ACPI in our devices, instead, i think that can be replaced
> with DTS.

I thought Conor said it could be auto-detected still, without ACPI, in
Linux?

--=20
Tom

--2QUtM56kIrWNyNb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahD1gAKCRAr4qD1Cr/k
CuKLAP9xLXUXA5xLSoBT6QCAAAbfuRRkTJEg9cpe3SI8mZ63TAD5AaTUjs0+tGUc
5MjJHYZ4K8VaADWpj1g/e21m1HpEWgs=
=hv1o
-----END PGP SIGNATURE-----

--2QUtM56kIrWNyNb4--
