Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF3C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1800879B2;
	Fri, 12 Jan 2024 14:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PyeBCO4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 541DC8794F; Fri, 12 Jan 2024 14:46:45 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E4C87B04
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e86fc3f1e2so58093847b3.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067201; x=1705672001; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yK2bd4aade3j9LbUhAt5citBXf/2A6GzopZMs1Y4RlI=;
 b=PyeBCO4JDvekmTLNgm8P5a+GFZbGFtr9kF0f9YWEAMsX23opv4UbriRb5c1W4p9/7o
 39SgjepdrdYat725c2JrP6LAyF2alcbjyU99BCL56S90hbNRtTL9hCzkPViYMwpmJ4os
 RCuFW3xTqQMkqcT24XUtuYQGBNKFuf9ywquE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067201; x=1705672001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yK2bd4aade3j9LbUhAt5citBXf/2A6GzopZMs1Y4RlI=;
 b=ZS1xAAQ7AVXwxIZLdSemBB4LGL3JvyNQ1cRHVMr90iQ1XTaxh7WwO8H6DPrr0RVm9U
 zXldvJz3Z/Z6k8/FL8vVwOPApeMFEHFqrKRiF1ogRxJnMqJsS0+v4BLwKKl9WXIn6DtO
 0wKW1nU3LzUd29qP0zvJbOP+VdiqhadWkQ2Y6zyWKpuO6dWiFdBtMfT4NSZ4xCLBTj//
 qqbbXJ6xeXGLrN3rhugM4+kaRd19Dhti4039Ln8bR4FVv5FyS2FVWPHAtFLAjbDv6B2k
 G24fGHz4o21Km/6wLYnqyOvG7cFrsNfjQwWKoiND9BoUy6fm/iC84640YI3A3G53Sq3p
 vINA==
X-Gm-Message-State: AOJu0Yw4VEbXg/bvSJ7veI+BG073Y/VJiixAfJ9o+OuRRKVwmhHsAAVK
 gyfRjcAONXHNtA9busHHa99AG2rzklAKhg==
X-Google-Smtp-Source: AGHT+IHNtKrqYI3B6viNqWDZhsnpak+7sSOLo6gPTEzrVENnEkId0uHt58gYB6mSceTZMOz8u8hFng==
X-Received: by 2002:a0d:e602:0:b0:5f1:5ab9:2f53 with SMTP id
 p2-20020a0de602000000b005f15ab92f53mr1223153ywe.27.1705067201129; 
 Fri, 12 Jan 2024 05:46:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 r68-20020a0dcf47000000b005f66a83db14sm1339789ywd.131.2024.01.12.05.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:40 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: jpewhacker@gmail.com, sjg@google.com, semen.protsenko@linaro.org,
 igor.opaniuk@gmail.com, mkorpershoek@baylibre.com,
 u-boot@lists.denx.de, kernel@salutedevices.com
Subject: Re: [PATCH v2] android_ab: don't ignore ab_control_store return code
Message-ID: <20240112134638.GY1610741@bill-the-cat>
References: <20231225102247.76794-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pIOebL+m+UohKtFA"
Content-Disposition: inline
In-Reply-To: <20231225102247.76794-1-avromanov@salutedevices.com>
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


--pIOebL+m+UohKtFA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 01:22:45PM +0300, Alexey Romanov wrote:

> ab_control_store() can return an error if writing to disk fails.
> In this case, we have to pass the error code to the caller.
>=20
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--pIOebL+m+UohKtFA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQr4ACgkQFHw5/5Y0
tywQ+gv8CFhE8jK3BLIEAJrdeAAj4OB86kAss03Nezy1Lr8pqMMvQh80ufKWFtxH
fgQg2K2LRuQPO95I/P4qoIHJpOC/NW1O1wyxXemLuRqCqPOoERHZjgq/JDYAfT+M
qtm4Zwc+Fkx8KyZ0G3isAjTtTzi2omLGIwMImSJYocmNzkHfOclwahwy/qSnHR1+
6wlDE6fEhQNpPcaNxK7uYYJtV5ZlUgoLrBP9fhSX7JRpD3KYUXBODJfczRJ/e+pL
kGpwu3+o3bh86YmuJ+7sadGE1Ym26ZCBesrFo04vNM77hZ0NsUpkJfthWXtoC1Ex
pEfYhEMY6z1EXXIoD/axBXpZr+lsAOsjUL8o4p1kwblEKjq5cxSzHwVV76Wg9sMC
/YKJKEfqw7kNTq8qgl5x6bbhjy8jHYLQCPZSwqIK/XnpwJMtSJO9kjjBoGuyHDw0
QAkq1PaQCza3utB6H+LDBUVTv+2C9LKU7h/g11r0f1b90U2mh/ulufeqN9pwygle
dXtigoeX
=jOtZ
-----END PGP SIGNATURE-----

--pIOebL+m+UohKtFA--
