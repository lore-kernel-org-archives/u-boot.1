Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D405EC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465CD808AF;
	Wed, 16 Apr 2025 15:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nKVKVAjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF7482DB4; Wed, 16 Apr 2025 15:50:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673518006D
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bbead793dso4886225a34.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744811419; x=1745416219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XY45rcPGRyaI6M8xkTTk3iRCOWBvCFRWxjL+pRdT9qY=;
 b=nKVKVAjBwfMr+/Ob6Xq/DfqB/2Ajty7maUrOvfASKqZRcLyN18kBkfEcUXur0OjGBQ
 oTNxjnexcjmDkp5/tze6i9158aGZWpWaAe/q4yztC/cUUJKbk+oS3U6j8heByIKE5TL7
 YFuPAlAZOA0FooHi9VvttXfNvHCZVKx8Ckza4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811419; x=1745416219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XY45rcPGRyaI6M8xkTTk3iRCOWBvCFRWxjL+pRdT9qY=;
 b=kj5qOg6iMrwg990kU0ib7H7uZIaJ1nudQBB03uwb0b4oUEGm/Ghjf3fdA714aLckj6
 H+YodOgItAlcZCujm5f2QH2XEjvnEYb8kY4iiqopxn65uWOLr43yCTwMhuJtF7UpzKTV
 idrD/khV580DYP3mrS5FYay0/uZymOGcqV31XnMke0onCDY67QUFhIKvC69t+PzwzT4Z
 kA/hyOU1q41TpwbWn/TeU+04Bvwu6H8Jx43Swr39J4UhIR9JEjn2UJ70ph1Zs57SgqkF
 Ksl0EpxcYvDUmdkVX19vrX1cWHzXNOItKtV63UYRpcWUrtFOz3E788Npz+HEKy5p4G8Y
 N6lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqgB5GHRQeUAlmGTfaeMHKpxbO/Kne5XkTur682+dWLCqKoTf8DrWgabAJSfd9KTF2Wg6ErWE=@lists.denx.de
X-Gm-Message-State: AOJu0YwByhvepdruItv92s/UAdQqkB8Rd0kWq4n8xKgrWjStcvYh81Gu
 PzIq/19X1FTtVioukpqrIeAqQK2zvyXCoNcz3aPGWYXbdxF2OW/VJSSv+BbB3w4=
X-Gm-Gg: ASbGnctj3QqI0mBM0///hAlvG6U5UkXIF+SXveo6XHLDKb5d6J5SYbxtqrALPjX2m4L
 C64+szECfFCrnQPAoP0+cj/tnAVuV68eUgEn/WoPqAdMkRtmJOYIStw6bocyfhgNDqhlCy8vLgj
 EdmRNEZ7aW1rVTkkbiEFff6ExyKSgReDJZCH2Eceg8DPGmEx0KDD/BoFcBCb2cNHFphaTIhD1mC
 UJlGMXptOnNLH9n8VekKW9isS3amR4PVPIMI9xm/+kVJXRQy6BRHIUEXl1Mq97U+vqJmAqRx8ti
 kI7roYCnolOrCsoEVSNuTUCiv7CgKlnLG5G0OqoSlvPKtmkdxr8zQgOs0hrQapZ4nIKAHTWIAI3
 Elw==
X-Google-Smtp-Source: AGHT+IGz5Gjy1GFdkoZ0WZxgFzMvMXicD/Q8sNCVc+4Cy3wn6gWwCDByqMIUcwOyuP7MTmI/EjJ8Dg==
X-Received: by 2002:a05:6830:6213:b0:72b:a465:d955 with SMTP id
 46e09a7af769-72ec6bf7942mr1203034a34.12.1744811419037; 
 Wed, 16 Apr 2025 06:50:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8acb4sm2785872a34.29.2025.04.16.06.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 06:50:18 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:50:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
Message-ID: <20250416135015.GP5495@bill-the-cat>
References: <20250405190711.365419-1-sjg@chromium.org>
 <82103ca6-0e9c-4f4a-bfbf-547d1c06d976@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/jVTx1TOgg0OMzcn"
Content-Disposition: inline
In-Reply-To: <82103ca6-0e9c-4f4a-bfbf-547d1c06d976@gmx.de>
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


--/jVTx1TOgg0OMzcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 07:33:51AM +0200, Heinrich Schuchardt wrote:
> On 4/5/25 21:07, Simon Glass wrote:
> > At present it is impossible to change the qemu_arm64 defconfig to
> > obtain a devicetree from the U-Boot build.
> >=20
> > This is necessary for FIT validation, for example, where the signature
> > node must be compiled into U-Boot.
>=20
> This description looks wrong:
>=20
> Signatures are in FIT images.
>=20
> Only public keys to validate the signatures should be compiled into U-Boo=
t.
>=20
> >=20
> > A proposed change to QEMU to allow device tree additions has been
> > blocked for several years. The only known workaround is to use QEMU's
> > dumpdtb option, merge in the signature node manually, disable
> > OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> > complicated enough that it is documented in U-Boot[1].
>=20
> This seems to relate to
> [PATCH] hw/arm/virt: Allow additions to the generated device tree
> https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.o=
rg/
>=20
> As your describe in [1] QEMU already provides a -dtb parameter if you wan=
t a
> crafted device-tree. Your proposed change is confounding boot stages and =
and
> would not provide value to the QEMU project. It was therefore rejected for
> good.
>=20
> It remains unclear why you would disable OF_HAS_PRIOR_STAGE if you were
> using QEMU's -dtb parameter.
>=20
> What would be the benefit of compiling the DT into U-Boot instead of
> providing it via the -dtb parameter?
>=20
> >=20
> > Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
> > to hack the Kconfig.
> >=20
> > Add a new QEMU_MANUAL_DTB Kconfig option which makes OF_HAS_PRIOR_STAGE
> > optional, thus avoiding needing to patch U-Boot to get this working.
> >=20
> > This seems a clearer solution than just making OF_HAS_PRIOR_STAGE
> > visible, since that symbol is intended to be set automatically by each
> > platform.
>=20
> To me the new parameter is harder to use than simply making
> CONFIG_OF_HAS_PRIOR_STAGE always editable.

I don't want OF_HAS_PRIOR_STAGE to be editable. Ideally, we shouldn't
ever be asking the user/developer to put this in the config, it's a
feature of the board. But as part of Simon's whole "Why don't [I] try
saying yes?" request, I'm trying to accommodate the design he has in
mind. And so, for QEMU, we need something here, because on real hardware
implementing the scheme, everything required would already be in the
provided tree.

--=20
Tom

--/jVTx1TOgg0OMzcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf/tYoACgkQFHw5/5Y0
tywkKQv/clSZkLzjKz3xWjLkfU78SWdm65Qt+uwnrk1Vm3JrnPB+gCQtg1fBeaD9
R/TuSzkoMI6YqVyBUsMmG1GeGXm8+LEgIuhlpCI/fCrGPkwzSAAjEFqgZkAmJNMv
HgOJhsbKO/wilroOckHns5jId/Bzbfifzgr/M9bM0AV8E8UBTLvc19a/URBFfmCs
7hstT8sBpRbUgTX0wkYErMj6xIhr6//aNBDqmbwhdRdN+9kzlHjjL9RfXlplvMKJ
L1k/FWlSl8zG9b1+hpGQQq2LolD+gmMt2KdA3nhF1UyyMdzh3he8ep7a0q76b9vu
8D0bpasYUdDSMqr8UAh09730a0Ozq0fgqVElAxDV6xYLtCT9dhuCotL8xiGNVicc
gnUycFsj8iJQ3NycOmLyE4v3kbV6x+Y4suVq4KBKlidslaDe24H+CBxk0eelK/Wg
cfeQFSqsA6o7rg25EVpOewTImGROwcFNv6vtGnmVo7RmUAmhOzfo5c9MjOE9NrjK
m+JW4Bp+
=7qkq
-----END PGP SIGNATURE-----

--/jVTx1TOgg0OMzcn--
