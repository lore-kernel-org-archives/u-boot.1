Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A0AC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5640F8829B;
	Tue, 14 May 2024 18:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OW/ekIXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E344288343; Tue, 14 May 2024 18:15:31 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE59F88356
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-792b8bca915so564988685a.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703329; x=1716308129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kzpCrBDcL1eDNnAE4Y4De4z95YQRjwlBD6JZY3x3pcM=;
 b=OW/ekIXGij/c+4BUVrx25uoxjSOZWF687L12QNtmkrWr82j2pucIf3YdoU/xp2t9eS
 IohH2XKeYAjAiakPE3YpILykW27xRwowjDQa+JnDiC8vFYB4EdNswkDmlgkz4EsrFFBF
 LKWi3FR2jo4mNnpn6xRMoejQW12f96nVYp2Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703329; x=1716308129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzpCrBDcL1eDNnAE4Y4De4z95YQRjwlBD6JZY3x3pcM=;
 b=oe4kJBwLCX2kJKjcc1WnqvOGNg/cxIUHV7dRwkzdhfW6jlUQyKXZZfOJvNOUlRvibj
 HnN4Um7MT4jPwNEPS0OHoqiJ05OMNtw6NxsQrooPXFRW/72Mk/VAMq1O1BpkoL6upVRL
 Dyt/u8Z3c1T0ki/BbMVLflb4fNOCl1tmv9JTExJyAy9ZH/NTJ87XPa2hcrizC7adArg1
 PvapL4eDquFIVT5zpNSizBH1dyehDiALexEGiuU6lItC1BukxQmvadFZV0W3uDJTuNb3
 lgSML3qg4HRlc0HR9tmnWG0B8CR8w1iQ1uYLaEU4RKjHWNi2rzikcHJd32/HC0ZcptdK
 Xx6Q==
X-Gm-Message-State: AOJu0YxIXaqJZxXrY5seaTPQvtQytKxtIl0x9zsSF+yYvt8eutlR+7VT
 oIodTZM+lgqUWO63xSJ4mrHXP0WxTgN8qfWTu1eUg6k7ZrO6oow6jUmU4wk0XPw=
X-Google-Smtp-Source: AGHT+IGrlfLrxNUICqwER6jXo9yJxuPar7RxHS+2ScgsYS8RgvUMR0RP0S61Zu9IWldqMkpicurWXQ==
X-Received: by 2002:a05:620a:4610:b0:792:c7dd:c057 with SMTP id
 af79cd13be357-792c7ddc885mr1736142185a.72.1715703328613; 
 Tue, 14 May 2024 09:15:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a5724sm579500685a.69.2024.05.14.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:28 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Hoyes <peter.hoyes@arm.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com,
 neil.armstrong@linaro.org, sr@denx.de, michal.simek@amd.com,
 patrick.delaunay@foss.st.com, sjg@chromium.org,
 patrice.chotard@foss.st.com, quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v2 2/2] armv8: generic_timer: Use event stream for udelay
Message-ID: <20240514161525.GO2568172@bill-the-cat>
References: <20240501081633.120913-1-peter.hoyes@arm.com>
 <20240501081633.120913-3-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RnAzJ4nKwq5II/TB"
Content-Disposition: inline
In-Reply-To: <20240501081633.120913-3-peter.hoyes@arm.com>
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


--RnAzJ4nKwq5II/TB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 09:16:33AM +0100, Peter Hoyes wrote:

> From: Peter Hoyes <Peter.Hoyes@arm.com>
>=20
> Polling cntpct_el0 in a tight loop for delays is inefficient.
> This is particularly apparent on Arm FVPs, which do not simulate
> real time, meaning that a 1s sleep can take a couple of orders
> of magnitude longer to execute in wall time.
>=20
> If running at EL2 or above (where CNTHCTL_EL2 is available), enable
> the cntpct_el0 event stream temporarily and use wfe to implement
> the delay more efficiently. The event period is chosen as a
> trade-off between efficiency and the fact that Arm FVPs do not
> typically simulate real time.
>=20
> This is only implemented for Armv8 boards, where an architectural
> timer exists, and only enabled by default for the ARCH_VEXPRESS64
> board family.
>=20
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied to u-boot/next, thanks!

--=20
Tom

--RnAzJ4nKwq5II/TB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjh0ACgkQFHw5/5Y0
tyxAUAv8DIrsOIfhcfRkPkxW1oG9DtQzu3ntt54Lx+oB9ncil7QHLjjGUsWdnR0a
/JzsrjFZtFDEONQtgFDPUdbB/ocZObh5OLKOYsXVL+ORo6tKYp8c763PI0Bky+xD
WsfxFnIf1Nj06AmPEPiLK5JS6RjKWAz2hd+uQ99Tmm0HGu/73JGP7/oOCx5wplJ5
JXbDkWtHAEQZtNo0wb4eC22nEkdzSrwekkQM775pKTC1ocBmmV7fVcJWtOAMTDVg
iFQLTT6QITeckrkKpwLyuTndPCT9TmQaKbGKutXrulcNFljt6MQtLcUsc0pDuGYp
fAqjKfaqONpUQQRMFRUviQUNkiorKxLXrGFEFWsBE/yvy8/EXu6ndXowKgsYawH4
VWrNqV3b7HtJFcl1JYbMGQPfsALPsNgALznWTYc3N2QwOe1UlBNcuoNtAbxB3Kyf
HTMzgbwC20oNGsapcE1sLrSc4dEZwKO/Tj122b6NhLoyKKnymETarFIWLtquhGpX
iiIk4Q6Q
=Y+K1
-----END PGP SIGNATURE-----

--RnAzJ4nKwq5II/TB--
