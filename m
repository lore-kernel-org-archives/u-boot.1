Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16494C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4DF87796;
	Mon, 27 Nov 2023 19:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pLI7fy/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E9087791; Mon, 27 Nov 2023 19:20:20 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDCA48761B
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db4422fff15so3623815276.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701109216; x=1701714016; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BOLDETgzSRwGbmCaiZXv75ArLT+2Mkc/0cbTFc79EMc=;
 b=pLI7fy/SFcy9NZLYJwu2k3N/+NCSQrsPjRaVTlFTROh93+q0slOeSwL5ngByuPApaI
 WI7aswzYDofwpubjVz69PnWbyOR8BU30I4qnWoXgGqzK9FW87OdC776uGSaJeN/Qxl2z
 /gHg9uKFxIiXweJ2Obg0GFVMUr0brGk5cogD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109216; x=1701714016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOLDETgzSRwGbmCaiZXv75ArLT+2Mkc/0cbTFc79EMc=;
 b=DtJaBPuU6FRJC6hO80f7dPrYGugrLhoVsMt9HwUhWlpJ/nhkuqQvC8sxNQlqWw3KBu
 xPaoUM6PgTwY9Okkn7azzX1zUL6YE9j2mw82f4ffzlFig6dfdDnGtnm9KcGJs2iP1xMe
 hOSQ/YVNtUjZPE3hS2alM2GClkzKdFAzZLf0x6Y4A4YtObJO+vtFKMPcOQ2Qn25J/ZtE
 U+py64Ep/oQ9R39Cja7J++tGtpjwbN+H46Inv+oRZ1i0337xPL5Ui2Qw0gt8jkLnDC1k
 ZAo06h0gosFPmYMVVOzudHU59WRGrtBVUPm8OZ+Zsenf/KJUasC+5AgNezwUzt6rDzA5
 Z7rw==
X-Gm-Message-State: AOJu0Ywg6T0q6siizoElxOND4FTWxoM2d5ZjuTrjUSxpDJhvXG8zWi4O
 uSaEkXDNg0sYoa1OYHaGp6fqxg==
X-Google-Smtp-Source: AGHT+IFv1iiUs1CsVglH818OdoNwhf/XK4XZl+AScJUKPqJkKMxIsyBf9/WpcCx3fhV4Y/h2trqwPw==
X-Received: by 2002:a25:8ca:0:b0:d9c:a3dd:664e with SMTP id
 193-20020a2508ca000000b00d9ca3dd664emr10814088ybi.56.1701109216643; 
 Mon, 27 Nov 2023 10:20:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 a31-20020a25ae1f000000b00d9cbf2aabc6sm3198931ybj.14.2023.11.27.10.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:20:16 -0800 (PST)
Date: Mon, 27 Nov 2023 13:20:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 18/43] net/smc911x: fix return from smc911x_send
Message-ID: <20231127182014.GP2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-19-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hd+iYEUKV56WwpZ7"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-19-maxim.uvarov@linaro.org>
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


--Hd+iYEUKV56WwpZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:01PM +0600, Maxim Uvarov wrote:

> return value of smc911x_send is ignored, but on sucesseful
> send we need return 0 and or error -ETIMEOUT, not opposite.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Hd+iYEUKV56WwpZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk3d4ACgkQFHw5/5Y0
tyxAugv+OIme6FTd69AatAGrKg7gGH2Pr7vELrq/4mCU/5rndMb3x6zsdUlnny2V
4Nq8kzjvXhZ2hEnc4aOlrLdyx/JupUj0sC6IxziRS4OQqBZOlVj3VWjubHwXAaG1
H1tueedpVi/J+Isd1Mca61Ss2oAMf5pq5QQUlea7JPX1BmguM92p8PBkVcibN420
6k7jBxS6iR0J6tbJ84iHBuQG+SSweE1pR4GlyC7yeR8NkY9PsG/lkU+4ZT8kmdtd
ThvkoUvfCuNt4m32bTjF3CAuQUgYdEy7NlkR3kw+G97s5rtZkDcYmGpTHUssQ2eS
y0/kaYSLoTaqcCyXZWBQr6G6Kw+fk4pwwscinxEBM7DbJiVnvgXtWxNkFsC3X47g
i00QyVWmHpAyn49z1Oxa041ueydS2OfctFC02utNOP0RKZpbakJS77nAd/M45hM+
Xma2tF0/3PZPFY5wH12dWgZELkbqof2eLJ3hevMU0DnehzLPrHgvtQbxZwq2Mh41
fPTxOYfX
=m020
-----END PGP SIGNATURE-----

--Hd+iYEUKV56WwpZ7--
