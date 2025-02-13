Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BC3C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 15:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3915580EBD;
	Thu, 13 Feb 2025 16:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jeyHf8BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB81C80EBD; Thu, 13 Feb 2025 16:59:30 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B751980C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 16:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f9625c0fccso9331337b3.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739462367; x=1740067167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SJzNjH9XAZyB1jzz3pzAzPFP+fC2oNiZVtWipmmmc9E=;
 b=jeyHf8BObE7b78vkGiroDBG2G0pqHwMb6XOIUizPCmY2LoearXUqTIjFhcPb1/OAM0
 EBo8sy27dy8HRbzs0k1uZ2F1SFCWp//MHyKxMmxf0AcCyTt+Y0F3KJXQ2BqU11vjRHh4
 c4KYzTBffvx461ysnUZOklDtoI7ALAzyFV6Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462367; x=1740067167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJzNjH9XAZyB1jzz3pzAzPFP+fC2oNiZVtWipmmmc9E=;
 b=kU1zyak1E1EqvYvLQ4R+NM1TYoxqXwnGi/ENOyK/8p4V7TKyLTfh6yb8PI+QM2qbgr
 IgQAUJwo/rzEPufG/UTh2pPZPRN9tKH5ekN+RhPpx1SIav3tMx90PbMsyhpnnQL39fKJ
 vQGoMXbvtKzv0127x9qxB3Xt9N4Gslvv52Ku352GU1r3rGsAqirtj8fBB3yPL8NFshxy
 DdNBepIXwANSalP4AiCMYt4/t8JbgajppZqDA7MwlcAjpkzzkkSh3e35rA8Nl94mQ8D7
 dvgvmwhOYx3x0pRzT4PRpx09Sgc7BBcR8gV88mD8PmJDnMwHed3NhCjF3tskRSXSayfc
 eTxA==
X-Gm-Message-State: AOJu0Yz4bN0B6I+6i98KfK9eF1NP6XXMw1gWXDaGJdY1mhpXY7Ib/hA0
 dWccymRZRhlBgv5v7NdEPhm3GAl+muvwHub+YXmt+WU1qjp6FqBlEFgWSr5agkM=
X-Gm-Gg: ASbGnctt2WuMICspgvp3ptZjzMIA0+WMajVF8aIj9zFj9p2bKd/yCiuxpPdme+82pq4
 OkDIggbbS/qzv5gnjzpOUDpSPHPtYW4h/1O9lDbcHV59KwKqtVgH8EQy+dsomAbKD7/35NAXeiN
 c3KMWuVATsXmC0k2Tts+Kq8rYvFuXPY3f8jFJiBYY56cxHhmdttbq0bduj4kzryqu/87Bfy24mb
 jqODAtsSIWv2sm3/gQVpWmMtcDZc5U3SdfzaQmXrsOiJHjwWlpbhPCvCl++YGUDKkyG8zyzBGoN
 j/9pNJJkTuHXO1w=
X-Google-Smtp-Source: AGHT+IHSRJWQrXjbaczM9oLoYxI9hu29aGgliAarSfnB9TywueX4eLFHzNwweMhINiITPPyAGBkIHA==
X-Received: by 2002:a05:690c:9989:b0:6f9:7fae:495a with SMTP id
 00721157ae682-6fb32d6e260mr37409817b3.35.1739462367630; 
 Thu, 13 Feb 2025 07:59:27 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb35f669fbsm3511777b3.31.2025.02.13.07.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 07:59:27 -0800 (PST)
Date: Thu, 13 Feb 2025 09:59:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 4/4] lmb: build lmb_map_update_notify() only with
 EFI_LOADER
Message-ID: <20250213155924.GW1233568@bill-the-cat>
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-5-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h8Sb10JEiFR52rTg"
Content-Disposition: inline
In-Reply-To: <20250213131104.186663-5-sughosh.ganu@linaro.org>
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


--h8Sb10JEiFR52rTg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 06:41:04PM +0530, Sughosh Ganu wrote:

> The lmb_map_update_notify() function is used to update the EFI memory
> map based on corresponding changes in the LMB map. This is causing
> build failure with a certain old architecture(armv5) toolchain, when
> building with CONFIG_CC_OPTIMIZE_FOR_DEBUG symbol on platforms which
> do not enable the EFI_LOADER code. Build the code in
> lmb_map_update_notify() only when the EFI_LOADER config is enabled to
> get around this issue.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--h8Sb10JEiFR52rTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeuFtwACgkQFHw5/5Y0
tyzyMgv/YnQsWurfpi705c1zVgIEZ0BeUuvFh/+il+aDosF5sOFBcWBS6XUdCokN
/BFYPwpKHf/mBcENOWrSUlkPgstjLu5AvLim0310bo6cBPb0ceaSwgie2HMghBg8
wEZyLG8Zjlj32Amc1CUJfxq8YvDYchb+SFlW0N802be+nlV66eoWVWzkljPTZIkf
jQLNmQWLUetSJ2lOj4Oi/Mdbl5uWjtTRfPZn42ztHSSiQFHWpa+YKgF7esQZqRQX
4pqri7h+jfHlERPHOvRaiy4ZCQ6qSsc6iZzvIyOMDyKYNXDSVDyK+fifFzbxAu0r
Q2HmFa3fe9mh5iIJuhKkUPhwtqFPmZUzw5Nwyf6teha06ZVfGbZamPC2A1G9202K
3x8xpvaYDetG1sbi45XctT2yQUSoIeOhzHBPdmxBtqcRf4CH/dwVg+GMeGqxCpOt
gnh8T9uqXxdQWT9+ObjFZqyGd+SzeQaVbMz1C9YApyQis9L2tOEnWLyNxkQ98oZX
5zV1m1eb
=m/vd
-----END PGP SIGNATURE-----

--h8Sb10JEiFR52rTg--
