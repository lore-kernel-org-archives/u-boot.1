Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7650AC282C5
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3370A81436;
	Thu, 27 Feb 2025 18:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yb+EPGtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C4A812D8; Thu, 27 Feb 2025 18:05:16 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CBD81280
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2230c74c8b6so34983735ad.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675861; x=1741280661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eCgVhnDYccTwyJa70aSmKfQhLQ/jW6zVD4UnuD2M9JA=;
 b=Yb+EPGtPgG6oUnonhWnuWjaTwI/6laawJ9xLuCiDs/s9IPBoG59S8aibilCVS2KUW/
 GY5r+QFBCcMkTA+dD7z4lTO9rRnIvc2Obc7TaeXaI5spdPqVKh+r+WVJUjA6CTQ5vUyl
 PQ+xFd+ZKw6qhiIcm9gOBqFBb70DkWoJan5eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675861; x=1741280661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCgVhnDYccTwyJa70aSmKfQhLQ/jW6zVD4UnuD2M9JA=;
 b=sHp40FS9x6ZO6spudb8erWwa29aIQO8zO+OtA8edZf1oa1iYm01A6lJ1gj8Cm9uCNd
 f0UTydJQ6pfVu6q5xum9ibNKmauxlzhejk2e7/whWqR0nJkFeIg5IqLIgnrx51/OesG7
 F91wWJ8bERP1aBw12G8cqGweA531HYszlioN3s8FIkeGkul/AXjXDPkSs5JqdFBM4IW5
 lOJh0RUGzSCpmT2qOJpjjUkPFJLpNOFfyD3nVKu4tcPb4gbL50ebWVJiKLKSPCohHvDQ
 9S55T1gW9EW5DdVrhKnOC8dDfVtqpr2aZzs+OlQwmtoJIgGP9sOASkF+QxesthNPh24f
 h2LA==
X-Gm-Message-State: AOJu0YzaVRfVpp7HgYXcJI3Je1ArxsDwTJFzF11fss2vTa83K7SFZ67C
 irNt2KTQld0BUL0mnsNxqeB72zWF6N+gfnJ4qnvGmNCkMfbI2Zvwz2ooBUKzpWTSlUvA5LL+EZV
 l1mQ=
X-Gm-Gg: ASbGncvMgMLK0/+Uc+xgi65733RCFjWV2q6+1yfNi7EcIwfGme8Sd5np9A5/NjGZYzd
 HeEy3xYvwkMRgBvUj4qIXWta7aXWtFlrt49nXSqaGEl04C3yxsnnu+u86B/+Kkdjt492OL86/6S
 sJcA1jjhlHne9kHITugrcgRCv26UVw46jWVt4E4QNGY6sDzi23f+uc7qgSLxOimqi8dJ9LJc7XV
 lcIAoz1geDtI0oH/biBFK2Vd/9RpgtQPtnGN0CCWnSBvzQAkcBw89h4ENGjQdsh06Kny0F/K8SB
 o9KTRuDeoS6G+9hJccVoPH/x
X-Google-Smtp-Source: AGHT+IF6gEv4i4wimMDAQZwhLTy6sg3wPoh3oUwLJ2Zvr2bGVCzXH1OePFHHiZy+WsdjnSrq1UokxQ==
X-Received: by 2002:a17:902:f682:b0:223:674d:c989 with SMTP id
 d9443c01a7336-223674dd018mr2507655ad.41.1740675860868; 
 Thu, 27 Feb 2025 09:04:20 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501fae29sm17362615ad.95.2025.02.27.09.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:04:20 -0800 (PST)
Date: Thu, 27 Feb 2025 11:04:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 06/15] arm: Support running U-Boot as a coreboot
 payload on ARM64
Message-ID: <20250227170417.GB2640854@bill-the-cat>
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-7-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bk55AHfBaF7fHIrn"
Content-Disposition: inline
In-Reply-To: <20250226221607.1283592-7-swboyd@chromium.org>
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


--bk55AHfBaF7fHIrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:15:52PM -0800, Stephen Boyd wrote:

> Add a 'coreboot' cpu to armv8 that looks for the coreboot table near the
> top of the 4G address space.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--bk55AHfBaF7fHIrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmxEACgkQFHw5/5Y0
tywhvgv/Q+ZzkT9HlPMI7BmxrVuioqCV8ACbEW+p7Msn/k5b7SFFbXd3A62IYW0o
ziNI58dpyYrsQiJlhvT5cBbEmssH2St5+7mAEyAmArkUOQ8oS4+gKZ0hhEUR46Ru
jL9HPmkM6UPsDS1vcFgvrPf7SoiUNp1mqNbP8iRj4ZO3h+//tzdRcbOERxgrGBZQ
RG+d8pckyTdVk8dNc8SCccR26bqIPdfRGjtNmn9s9oCeB5xarxppPhWeZ25YePHI
5xBXD3/CIzxGMdd3rB1jQqC7J/jU+F9+UAN/a8fQOzF5hpHztY4pucj/32jrn8C4
VP9P0oY8MHp80gZojajQR+cJ+HsNFzQOt5UA87EdzU1a+oPx2ZvR1bI6YeFdgc+C
Sqzo2Y7kMwilB7MxnpwdJ5/N/j/4Uy+b+ww4JxglmPrN+JqwHTubRHgIXHZEL3Op
EG/TyCwgdIhpfubDxAAqDSfWybV4oE3dSM74w8grmtj2wDCVZcE8SyUdUpjFcJus
TJhWpzlS
=JKSn
-----END PGP SIGNATURE-----

--bk55AHfBaF7fHIrn--
