Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C08C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE47687D3C;
	Fri, 19 Jan 2024 17:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T54eOaI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C3C87CF4; Fri, 19 Jan 2024 17:09:10 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64AB87D3C
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5fa4b03f3f5so9388637b3.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680547; x=1706285347; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XPkzFc4Hg+mgopDJ71VUH49CI1mmoWW0znFk8WSuoRE=;
 b=T54eOaI9sWeH5wZbsjHokcCqhq4SlQ2ZkbPzZvh7RLtSNOEQpVYFyYljoJx7d5fNbP
 HK8YNEoEvlIBOwXm93WOZ+HrpOv97HgUhqgZOrN46qPlTErwX6759WvP96ScXQIQs0hi
 89FqdJcsTvMVc6mKVFn19N2pVPBpbV107wgtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680547; x=1706285347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPkzFc4Hg+mgopDJ71VUH49CI1mmoWW0znFk8WSuoRE=;
 b=bZsoadTurfKCML+mjQKBgXMcp/JfkVUwAes/vrSai3n9RpNMYW5YJslYCkPge5IFIB
 W1+fcRAJLacpJdXX8W8BZahI09axGs5CcpfWNoxz4PtRWFRm0OwUIPuE5TlLtIWkthEw
 yI3qtCYTeYJdVEjsvIjZGhQ0JhweZjIG2BGqRLQxs5GRYG0N26wmt0UFUgrX27W53oAI
 Cv6x0ORxA7Tmz4BEUQa7DQukELpgHe5Z2Ty/KADBf7rCNQO1v2XDyjymF3ZekSGZO/fU
 pUDUR8W4ATCQlAP2gRAxyLNwwwxLxTW9g8R84CeilEHaHrAqmGGwSWYYh5DNwHxOw4g2
 aAQQ==
X-Gm-Message-State: AOJu0Yxhl7y/QUcQmaNSeQOYsd56YQtS0vbrBPRFVGEcFrlKMhxA72EL
 Fbb56j0vlTHa44Y8bt2STWc3E2t/9w9tGuT3elkAEeTSEN5875HXFsPx503hYkw=
X-Google-Smtp-Source: AGHT+IHksSPHAV6BU7o1JELykqyL57Q8h+oRsf0EC/3srgDKfFk0nRQLZPArso8MX0dhF5WWNx47kg==
X-Received: by 2002:a81:48c9:0:b0:5ec:2c54:5648 with SMTP id
 v192-20020a8148c9000000b005ec2c545648mr100306ywa.76.1705680547489; 
 Fri, 19 Jan 2024 08:09:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 s184-20020a819bc1000000b005ffa70964f4sm186568ywg.115.2024.01.19.08.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:07 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] smbios: buffer overflow when zeroing entry point
Message-ID: <20240119160905.GV12635@bill-the-cat>
References: <20240111063408.9807-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+NATJogMBZmUXhVu"
Content-Disposition: inline
In-Reply-To: <20240111063408.9807-1-heinrich.schuchardt@canonical.com>
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


--+NATJogMBZmUXhVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 07:34:08AM +0100, Heinrich Schuchardt wrote:

> A SMBIOS 3 entry point has a different length than an SMBIOS 2.1 entry
> point.
>=20
> Fixes: 70924294f375 ("smbios: Use SMBIOS 3.0 to support an address above =
4GB")
> Fixes: 1c5f6fa3883d ("smbios: Drop support for SMBIOS2 tables")
> Addresses-Coverity-ID: 477212 ("Wrong sizeof argument")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--+NATJogMBZmUXhVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnqEACgkQFHw5/5Y0
tyymoAwAkyWx77lYjEsXveDY8gKyK/uHea9MTsZ0FAqB2GbZ81WA3dWgO2JpgCcZ
pgEDOKASwUmOcCRs/j20d2+Gy9aQGAlr0covup/w1PdgRoHA8N+xGins7CS8QJbg
3J2PCMTTMzk6aZV44iWEuENvRIXYzIbo1lsN4hNEEPrD+6dfSQQKSVDqxbQH3HMB
0nsIj0RoYsRZEx2GASYAHCNYGaZ1ROi/PZ9EiQcS8ieb+JhlRxmOayABicTmAZti
M8XS3fLHueX5zzxgi7gvS9n0nlvr/Pp37LLliRxGVCrIkgUJnOPg4TIkPuQUSMOU
ACTH7bUQS0AnPNaQk3PrUBPKOvAsPMwo3VdVhF5xMJHyMh6X+NsmNCzKMfzqs2Xu
WPbPXtks7+PItTiUHItvQ1uyaSvxY6GOk8QAW8/0wGalM2/7SKjct+UKcczExZ+D
V7m/wfwKFR/3ZS6lpx6WsP9U/FWZDFaDTeabPMM5tQwwaIcUcQ9p23qO/6DgGjkd
FyKPT+Ny
=n58r
-----END PGP SIGNATURE-----

--+NATJogMBZmUXhVu--
