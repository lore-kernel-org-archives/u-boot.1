Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E339BFCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6225983F2D;
	Fri,  6 Mar 2026 23:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g2VWGon6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044F783F75; Fri,  6 Mar 2026 23:22:55 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB2883F1F
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c307db9aso6058243a34.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772835771; x=1773440571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sQQGwbZPseqYn7WcX2rZ3A4f+SeWJzueyhem3J7Q80k=;
 b=g2VWGon6OZjb9azT+V3ksrOLPNxX2mmj9YpFZjU3dPuvmQOx0acsWKaXlnrVu09Drd
 RSkAFPi5GHfrPnlcGx7cBZNj/RsEqxq+Z5r9cRG1x9PPMvnwqyMCBshSmW9WGXrWkpA5
 0HCcxq1sLiw8WR66MaKSioC948YfjOejl4Qs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772835771; x=1773440571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQQGwbZPseqYn7WcX2rZ3A4f+SeWJzueyhem3J7Q80k=;
 b=Q350nfMFwrK4xF/lfIe105gnKpMVBIHCZQHFb4V0cwpnw+1VB2/+yY0SGZD2Hei1Im
 7rClUzkHFOhT+RGedoNn12kqz8rEh4AKGKvV961Y9XYRfkNDfETHgx16nq94xpOksm2y
 ahh8ZiQSoJhSDbx1838BTDIqsL2kL7v2ZF7mcDJMfcb24nVu/PuBxexKdLP2ptaehlh3
 lNBfHRY9G7hKMRFLcwMl+24D/3xVsptXbVQFfVkl8E1Kml1yuT1o9q77O/OK/XdyK2vT
 AoPXCor98Gx9okSXbJg49BTAI3alGyKySI3DjhzrCebIXJrNgeR3Nl4HMt/3Msm2qpiZ
 XpXA==
X-Gm-Message-State: AOJu0YwztaY0lQc0PCRfeadTw7orQ5f0KD7NC5pQXIL+HD2bAO6CFhF3
 +OmAoMZ+1PotGP8usrPMTKsWPukuMBLeZ8AqXZ2srV1Zx0U4gYOWn4faaa/wgwFzXvs=
X-Gm-Gg: ATEYQzz6vRD3DxFjTm8XUG7C7lXwI5Z9CuPzWaJNiD/EeGRCv6D0NqsIFEgDWNy7ycl
 9aj57tX5xiK9WzVnPstIxT/W0digRRxvn/VuYlJcj/R+UNiwKGM6IYoncs9QPEJBAaEEz54Ch72
 rGHgQxvikUwOSGaQkjuGYN9CPRtSj8MaF2MJ55nIGxHNgm0fU9ZazBh74FqA4WhM+O+GxviWMhN
 Tn04KItEfXl8TO2bMHl9Sa00nAyUSt3+iwtIkOCXfNWdjJilJOKiyKz/z5o1bH2GrHHKfFMBoqw
 I6eI7de5uCBv78HhQplDW4VWpnSyhFNef9t2TnC2ZlMJjnv0rLNWkdvj8NZmjVlF2X4QwMS62Rx
 CM9Z0U/6sV2grbONJ8L7gJczMkJOJYQhEWe58G4UNGecHS5jLZTKWx0tXRA4g8FucRoYaAdKPGT
 CRVhtHo4T+2z0lyLiS/wwmcjA5kmo6IYRsBNzj1QZ7G96LB9XyAT2NHH6+ZTsaUXIYlxHorlbUa
 9eW2QUAKbb0sFoyc6hFbRsF5KXAW8nTPy+4v5t+yt7Lv4VqN/c=
X-Received: by 2002:a05:6820:1503:b0:67a:1c94:8da1 with SMTP id
 006d021491bc7-67b9bd1afcamr2186526eaf.48.1772835771221; 
 Fri, 06 Mar 2026 14:22:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67b9d503700sm1522171eaf.14.2026.03.06.14.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:22:50 -0800 (PST)
Date: Fri, 6 Mar 2026 16:22:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 1/7] test: fs_helper: Allow passing the image filename
Message-ID: <20260306222248.GS1388590@bill-the-cat>
References: <20260306190818.3586749-1-sjg@chromium.org>
 <20260306190818.3586749-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sgQDgGZN9Aul5NT5"
Content-Disposition: inline
In-Reply-To: <20260306190818.3586749-2-sjg@chromium.org>
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


--sgQDgGZN9Aul5NT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 12:08:07PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The mk_fs() function always generates its own image filename from the
> prefix and fs_type. Some callers need to specify a custom leaf name
> while still keeping the image under the persistent-data directory.
>=20
> Add an fs_img parameter that accepts a leaf filename. When provided,
> it is joined with persistent_data_dir instead of the default name.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sgQDgGZN9Aul5NT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaatTtQAKCRAr4qD1Cr/k
CmuoAP9tRzXhSULg49194nTSBe8EVC7sUi2/kxRMiwYbe0xM/wEAkMg3WZbWA/vx
TjuSyVS12XljsAYkzNplz0pLF2oh/gw=
=1+RR
-----END PGP SIGNATURE-----

--sgQDgGZN9Aul5NT5--
