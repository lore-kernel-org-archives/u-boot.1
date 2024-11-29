Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D1ED70E0B
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 03:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917B38937E;
	Fri, 29 Nov 2024 04:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BGClDh5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6499B89376; Fri, 29 Nov 2024 04:29:07 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C548936A
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 04:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4668cec51afso12049121cf.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 19:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732850944; x=1733455744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pn3rLGHhlXeHAgbTGiFGVYIUBF+uXU+Xz7KDj1t1i+g=;
 b=BGClDh5nanEiznEhBKJKXa8oFRvCA6Zej8MbtRUT7Fb82UHrDc1Jq0airp238A/Ksv
 Vq1zohKAVz5iTwlxLz8QVEIZmH2yqlTEpu3bcKhp9jCTzKs5tosUGI1t80+r1A9JGgpH
 6j0U2P9AxrabiVwAt9UAdWAiQyQwmr0E4oiQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732850944; x=1733455744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pn3rLGHhlXeHAgbTGiFGVYIUBF+uXU+Xz7KDj1t1i+g=;
 b=SBUN3gg0Te0IV9cV5cQejcp01/7823+jr1YyjzDQzXFlgtSv6zod/kiJ2kZNm+Ab+K
 Bn/MHKNT0ir41LYC8SpnWjoW5L8dCcovAuQjwvpqyye3gGmVbXM/tFAnNAcxM0RhXX4W
 GdXzTRL/QMZUT8qlRqLThKfWZPCHjbHIk3+bqIDnk84quENg6Kls9YaE5xVFlCRdNzMX
 z6V77uNg4JOqTfMwLkkAoE3gg3iKYSntQOnqv3f9WrcfSeo59OaI/qYIbj9yntHNMdyt
 fxdtLk79v1SnT/9e0AB1n1vijWfdqw3sBhBKCi/0LqZEINB8cTei4m8eyq2s4T5kWl16
 askw==
X-Gm-Message-State: AOJu0YxhVZNMdKMXCIhgMdLK6j+9PqHBSMBsz921tX/tw8qCKiUCtWup
 BZFfar5QfjH1V/5vVHNkjxrYxjJbKPWZRfQVEKiGglvTulh1tpC6cRqjtmaafYk=
X-Gm-Gg: ASbGncvql81skfRGEbs/Sia+LSwTbqfE2UbWe8y2hg2zrTOY97KAicurQ4hCBNjtGmr
 xiDgGTz/QedVEovzlztr+0EqH0CfF71CGjrTzP3qPu8Y6Z+4nv/QGC1EVKju/jD8QkB5rRgVHeV
 Pc+/7E54a5WpRroc/YuUdW0ZsxQ81/63Yap7mlYoI8GDwyXWIcq2qBbxG5IgM0RxwTX4jqsVwL4
 QNvMEMBrD4aoIgu36VPl1MJYr6nrGWGR9OuuUnMERMhRPJmgg==
X-Google-Smtp-Source: AGHT+IG9hQhrT4vtfbdrUxmHJxUd+sHyjBDyXXf41JOAuvcAR3Y7BJBP0EEYkuigXNhCV6DIUTfLrg==
X-Received: by 2002:a05:6214:4007:b0:6d4:215d:91be with SMTP id
 6a1803df08f44-6d864d86f74mr129636236d6.26.1732850943798; 
 Thu, 28 Nov 2024 19:29:03 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c604bsm107231485a.121.2024.11.28.19.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 19:29:01 -0800 (PST)
Date: Thu, 28 Nov 2024 21:28:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] efi_stub: Sync the debug UART definition like other
 platform
Message-ID: <20241129032858.GG3600562@bill-the-cat>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <35abc74c-0936-40db-b574-da3bec78bea5@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PbHMbB9PMxQKKtOV"
Content-Disposition: inline
In-Reply-To: <35abc74c-0936-40db-b574-da3bec78bea5@rock-chips.com>
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


--PbHMbB9PMxQKKtOV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:22:50AM +0800, Kever Yang wrote:
> Hi Tom, Simon,
>=20
> =A0=A0=A0 With these two patches, I didn't see error report in efi_stub f=
or
> disable DEBUG_UART,
>=20
> but I still get CI build error below, but I can't identify what's the
> problem, could you help to take a look:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/963215

So, with:
   88   60    2 /150            qemu-x86_64

We know two boards failed to build. I don't know why buildman
doesn't then list them as part of the summary, and please file an issue
in Gitlab for Simon for that. However, we can try and figure it out by:
=2E/tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc --dry-run -v
In that tree, and seeing what's listed there but not in the CI output
summary.

--=20
Tom

--PbHMbB9PMxQKKtOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdJNPYACgkQFHw5/5Y0
tyzlDAwArEMuDtDvq+aKwMWPZncqAokJ4DA6PZttGNdg/GlAYTy0QjVaLZXqHohn
E7x9rwku3Qqkw2WzmrT6FktRhaamte0ug6WgjgSfhak/gzu+JKWqyf6K7Yogh4Ea
rn59mm9HDWUUDrF1LKAyKsGlhEjN5R3jLd2b2Dmn14Bn2WO9b90tP0igSovxYnug
GJrBM8VSLl/ZvtJMQ4xKl71VcNPYL76MLpvgHdRqq3+OQK+I08ywwXc89KLIrcEh
i7ZxTbEQtpoFRRil9BoXtKbNWegQE0v/4YTF739c/XB8pCssczbiLUvL8qAZrxl4
r500clC1B2u39TnrcCdpNrn0WXVIK6fPC9yAUxsFeMY/+OIOn+gRyaWOphS+8mdl
3Al1ecoYjC/JUiRjdM0MJ5lG29XO4PEQrvFxVwFuxihKXHuTVmFmfjwQVX1ylbgK
ivRbJAR9KYE4rSa7c53rmV2eZHleepZ6Sv1UZ9CNU9pV1cqxyEcfoc6enuG8T+DY
G2PrlsWt
=dx7V
-----END PGP SIGNATURE-----

--PbHMbB9PMxQKKtOV--
