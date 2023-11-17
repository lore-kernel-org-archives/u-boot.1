Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867EEC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90B986FF7;
	Fri, 17 Nov 2023 14:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pj3630LM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14CE86FB8; Fri, 17 Nov 2023 14:42:07 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39D686FF7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7788ebea620so117267785a.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228520; x=1700833320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PzOBGjUaF1hIi4UFyUwJKOAwXWLiCy7Eo1eOJSycwUY=;
 b=Pj3630LM4b/sGT0DsIWLStvRLYyryTBN4nrL0fV+pZGIrJBlHQzsisAuLncDPi4Bo5
 dSwCgUc1uMJdO3f1EFp7rE60L+8+BWZTWqHQSJEuGoJWPqnbvdGB0cJ1k8v1BlXgQTWl
 hm6CSrYwSFcBfYjsBCO7BCTiHyFC9fa14yfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228520; x=1700833320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzOBGjUaF1hIi4UFyUwJKOAwXWLiCy7Eo1eOJSycwUY=;
 b=GETY49HvD4nlL2oTiQo0Hjq4kA5epKR6A2reT3OR7tgq9KGYBwx9jCKNowwkH9gyUl
 ckqDetzzhPrTBmrde0t8qbE/j6Nssq7dNp9VvwKzJjo1pQQrhFSlsty0mjgFtNLDucK/
 2QQyd1FJEFHjT6KwLVf1+qcviqGSuF1h44p0F40eGV1lj4ZFhJZVjyymtfjFTFAUGu6m
 VRpeLC5PW39YbP2W9yOcRpUScp6SKcsC/Evun+wlS1fP2zC1xq5Zcno14iSFerg1W0uw
 51SMtRhen3ZCeufmkySwvUVoUuVb0fUCfu7u6aAKtoaPIdxif6PPYSDyvUhrIjRYBC3g
 33rA==
X-Gm-Message-State: AOJu0YznDXT1+OH4LFCaJrpSu9FvZfu3zXaWa5kuWSrI0tT6VuJiTLw7
 9CqjdkJtRZSyeU3Jx4ImEeR2VA==
X-Google-Smtp-Source: AGHT+IHIfIFodMDLQ7v0UAK4IoWStboPNjKTQvjyrmPzQ7JfbuCIXNz1MXL8QmnNhRaj/khq62jJlg==
X-Received: by 2002:a0c:f98e:0:b0:658:997f:79b7 with SMTP id
 t14-20020a0cf98e000000b00658997f79b7mr11678970qvn.3.1700228519783; 
 Fri, 17 Nov 2023 05:41:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 qh10-20020a0562144c0a00b00677f605f12asm430609qvb.79.2023.11.17.05.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:59 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH v3 2/2] blk: Drop reference to DM_SPL
Message-ID: <20231117134157.GT170968@bill-the-cat>
References: <20231112200349.172779-1-sjg@chromium.org>
 <20231112200349.172779-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E6JcsO5PlUhJWahd"
Content-Disposition: inline
In-Reply-To: <20231112200349.172779-2-sjg@chromium.org>
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


--E6JcsO5PlUhJWahd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 01:03:47PM -0700, Simon Glass wrote:

> The intent here is to only allow SPL_LEGACY_BLK if !SPL_DM - i.e. that
> when driver model is enabled in SPL, legacy block cannot be used.
>=20
> However this combination is used by about 240 boards, so we cannot
> disallow it, at least not yet.
>=20
> So just drop the condition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--E6JcsO5PlUhJWahd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbaUACgkQFHw5/5Y0
tyxgswv/Rzs346THMvk/DFIzHQq76lwSuOPBQPv5lbPLgebmEvFLgoiQGR+5N/lT
owusYUQL16CFv16QgSaoZRPHBL/H9UthKy9R2dWb55kZ8wgJEYtVKBIuH68Ipuse
pDpfRy6x99jqp6r0j5ndyvNLm9JgBlTfHCcDXG40yMW1TMEEUSUuik7IB7+ka5Oh
jqT/AcPZEaZLqCZlZSror1UCeWbJ7OvVKhoCCQTocTLxHcie5LuGY+8xvRHjaixh
Ipoo/EccxhsN2jf3BOTDdvcv1GYP28Zrl146ONywnbil+KgeqvFljeKEMq4vaygP
ooeT8aTjvLsnC7xDUaqFRAs2O7RYlREE96hAtSQ1ltW/+PK7yGvXji3PDD47HU06
j3TE0arExYYIXnjeOkCQCCHnwomTxwvMsoD97EROZV9vzinWPwYp7btj6Ki/0elc
A5e7iVSMZ9O+ADShV2OdW8dq6uC1kCw+RQvBmnq0R/cSKRGQRfSKi0V2gpwOgN06
ySCBRVy8
=qoSn
-----END PGP SIGNATURE-----

--E6JcsO5PlUhJWahd--
