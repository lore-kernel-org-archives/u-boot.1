Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B87C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455C2800D7;
	Mon,  3 Feb 2025 21:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MKrzhzRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99126805D7; Mon,  3 Feb 2025 21:09:36 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76AF7800D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d8e773ad77so36883636d6.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613373; x=1739218173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1P1+VlIkofnnosUuDMHCsNTXzVl6hN6xYH/5+rNRmIA=;
 b=MKrzhzRIR5l5FamzUJOHhjHQH1Mswimjv+S67jsKXBDj83YC8hK6t31oTGuADoMjXB
 xYYck/iNsxgQXoy8WB9kM9hEDbUpSPNwiqLDqPUhP7f6t8brAzEu9nvGlQoEQSLv3hAY
 lOafmiyGOiPxIH5fl5WwJHKAaMv93aEJEk8GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613373; x=1739218173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1P1+VlIkofnnosUuDMHCsNTXzVl6hN6xYH/5+rNRmIA=;
 b=TLxJ7rS8aaa1Um+7uK8xBf/9kzqo98Urkw/g77f5UnBxwGNN/qdOPE4Bnq+z1+Pipy
 34UZmmO6Y4fDeTjd8Rv95lQ6oJbK6fUtjcNhFvDfR+YjoEyCOeKV2CGpQ3TMkVI+anMn
 NWR70E2mZXG4myQ2VJNC/ngmVCKSO7w0pE4OPAVQkyBWsJiaWu3J8+mjcBGf1WVmlg0g
 LTe11w3zA9FehzFxSiaUh1FElv4BznpxhzhaYbbfsxPa54ZLFi9fwE5vLPtRniiWcDA2
 Ofze9uXWwCyeeWPqtMUMnT9XUX+ri+l7JfBYPfXdPAAy2JWsCIkCPobsH+G27rKuG7aa
 5x0g==
X-Gm-Message-State: AOJu0YyLzZ3U1HOl9oeV1dn1bjppbCMnDW0ePELQWaEfW9tLUB1W1fJ4
 BsV+vl0BFts6WPKjiJ0mqERuSKzUsC/Rf1GMslbDP02C0qzpaQgf/QfFWnRhjcH329JHjLiBK5g
 e
X-Gm-Gg: ASbGncsZu36bd+UsjVSXwjUHEOPVZa4Og5f9/7G7yhZ/aLWtZrzGvHugz0KX4wf0DNW
 HYtDfAtSsp7KlOAAorBLHRaoh8o9o3nGlO28frAdT6StqWa64RHalyeeswdLYA1js6HvRSz5Zxu
 v+qnqiIG/Re6R3pzLdtOwqo4HjKeMEVTZNP5rtSDD/0e2W4ZOVKJsjkKbzzcEUSJ2CXkormai03
 uczGi680VNhiYN2CMx1V3JZyUOkec98CCbGKkz1dlB/YWdbLE9RkqXiwZwqCyD4IBhwLh36aST3
 cUGcuk+b+ei04eo=
X-Google-Smtp-Source: AGHT+IHkHUXvSwghK+s86T5ImoGizDLdQS37IzIBvSq9XA1lZXeGKm+Lv3hMphNHaWcOPBO5cEHJfw==
X-Received: by 2002:ad4:4ee5:0:b0:6d1:9f29:2e3b with SMTP id
 6a1803df08f44-6e243c1c95bmr360552846d6.13.1738613373308; 
 Mon, 03 Feb 2025 12:09:33 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fe407195asm49434211cf.0.2025.02.03.12.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:32 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 20/32] efi: arm: Omit the ARM start-up code in the EFI app
Message-ID: <20250203200928.GK1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-21-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="riN5LEqwIqob51uR"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-21-sjg@chromium.org>
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


--riN5LEqwIqob51uR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:13AM -0700, Simon Glass wrote:

> This code is not used with the EFI app, since it enters through a call
> to efi_main(). Remove start.S and crt files from the build.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--riN5LEqwIqob51uR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIngACgkQFHw5/5Y0
tyxYOQv/cj+nomAXozLiFOFdxOUN9xW7OlSA9iYk8djpBdrEAURbXtL8uecXxnKA
5nCdkKnfcNRQmilzsJZw+IupJ9Co1gpSzQBOQApNRm1WBF+MwM/sq7kk7f8mCkTL
bx9zmgyrmK73iBqYLK2o1FvAvaCgMdVMyfvtedLV6M+foY0Qm0bV7SBjz9YzhXl2
owIlUqpy9Ixv5RtvjoGf5FpnGYg4A08vQM5ducDVQtwwzjWITXeDqVrBtgxga22Q
6+XweevAT7FiZbuiwl/2kv82TClh7/Km4o1Hk/Rq4UT8QRMwlBt8w1oGOKx3ouW9
zxJ6PR+WAnGPBltCBIsAexTNaPPBMBWAMJNh3TlVd7ORA+k5ZGkAHEWdi762K8gh
bLQU0VtmukyOL/InPGjSjGA9MSZPf0SkKCy/nnc0+aBtWsvmxc3pUzgjjnhgYjGd
gPbPY73qZhyKfEOWyz+kM78IL9Jk5s+/7c3fbykud/PfUNIwjCH2IRy4UHIAFftV
Svfue9GE
=rePX
-----END PGP SIGNATURE-----

--riN5LEqwIqob51uR--
