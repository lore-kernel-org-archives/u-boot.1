Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD0EC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6708357C;
	Fri, 23 May 2025 18:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f1igC+lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB938329C; Fri, 23 May 2025 16:06:21 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC5E83285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3fa6c54cc1aso6048484b6e.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748009178; x=1748613978; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vQUmn2tvdFEhsLb2xZucKaWGzzHLWawLSB/9h7PIULk=;
 b=f1igC+lq98NGbCnKBG3MJrima44TkWpnW88oyrcYaKyvW9QK1K2NTeFvxAveXvPupq
 SIMIC62/SLTJ56WwScC4DkzCbVEqY+f+JdRLk8881uw0cBF9k640i1+AhGltw8BaJTtx
 23vWPuy/49Pou4aT7yO0p0kno3dzq/ffC7gIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748009178; x=1748613978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQUmn2tvdFEhsLb2xZucKaWGzzHLWawLSB/9h7PIULk=;
 b=GhoFsYw/1Ye0iY6InzSVCAI1Y/2/NyF2uhgs4O847wsBj3G7Wqu7nibwxQwUZQc4WT
 c/8T0RIrbpj//2bNzNJPGlwCnZ4VPeMKUuzq10oX+G4UvMM9EU1BZ3GdHuwFGO66v5ir
 69oP2kwiMIzYzErdevx2c6gQdwo2ZaavSOuZJVneV9Fcz3JxSn3ik1r7SYjNfaYyU31s
 d7YLhomVKeML21r9zDUvivrhyXb67nfh2v/0JeRqWk+u2CRgQrvO0um+N4Ywp2S2AL0f
 iAJbd82YR7Bsg7kN7/dO06ziiwGQrEoTznOfxCKDJxmmkYIJ7sU8N7iNCcGP3tUE9Qqc
 NDpA==
X-Gm-Message-State: AOJu0Yweo3J30ge9hRQ/HeWkB6hR0SK4mJI4c/DDO6ses6tMJ7D41fjb
 ZB4b/Qba2D/HR0amkYESFcs6WtHXftETyXt+NGZycKN3b39+jxTMlk0eJ3OZH18ipE8=
X-Gm-Gg: ASbGncvzIjUOj7A6Bwjh2MkPqEaCRKCQXabMAZGgKTEnS/B+SeErZL4GlYo7t+s/1G6
 tboPZIz7Buoh/+a+s+6HKHmtBK9f0ABLaqrJlsfGOBQ1IVflZa8CaI4xWHrGLgSf/5rpc+Yc51M
 cFaWnlMCFkg6vJk59PZz/SXlJACCn7iZYz60cGO33PjrQrcGyQcBZITY0ja3gjmEEHtN4GKWOUm
 vvZzmgd8TAIMEtv57EMRvPaSiIDLSyb9nCxs5PMA5iloqW+cwN9DaAIJZ4mndkAq2q51FavL0V9
 pF8275u/2sRi8VE6ioEPpwDNERAjry+nEl/te7yXfZFuBf6s9SdPMQMWCpdvB3Yb+q5wIS0JKse
 9SN+MUMINT4cf
X-Google-Smtp-Source: AGHT+IE/X4zgPOHxRietW3M8SyLf1unLj2vsfv4bAd0w7nlxlVjFoM17ZBojOf9w6IZMMipU4mLLHg==
X-Received: by 2002:a05:6808:3383:b0:406:1e0c:3196 with SMTP id
 5614622812f47-4061e0c337cmr10228651b6e.28.1748009177983; 
 Fri, 23 May 2025 07:06:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b2785sm2963462b6e.33.2025.05.23.07.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:06:17 -0700 (PDT)
Date: Fri, 23 May 2025 08:06:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian =?utf-8?Q?Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Message-ID: <20250523140613.GQ100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xxGsxnhbYz5+LiZo"
Content-Disposition: inline
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 23 May 2025 18:56:12 +0200
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


--xxGsxnhbYz5+LiZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 02:06:35PM +0100, Simon Glass wrote:

> Some functions provided in lib/efi_loader are actually useful for the
> app as well. This series refactors the Kconfig and directories a little
> so that code is easier to share.
>=20
> As a starting point, it moves some filename and device-path functions to
> the new directory.
>=20
> The next step would be to move device-path code over, but this will need
> some discussion.
[snip]
> base-commit: 3599a58a5114224a01557d18371036a5823233cc
> branch: app

Please base this on mainline, next branch before asking for review.

--=20
Tom

--xxGsxnhbYz5+LiZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwgNUACgkQFHw5/5Y0
tyzutgv+LARPtivn+wQdtDajKfBabWvqsc2DoqIFjebc4Oszl0geRS7Vrb9P3/4t
hyUoiRlX2TV/Y7E1I7S5Z8cZl357ES2G1xpn2NXMsj5qznMCX4qZqojer3QzvGpt
PAC/2H4nN9Fyv6rcuiguVhH2x5Hze0GOPwwK1NdIrFRcXsjyzsoxi+UxDsXvvGt6
wZ2othIANDJC07HC7LXZ/27FuH2eBXS2xY1JCNYEL/YNXvSiIykNknpPRsx2im3O
L1sjmqg/YtxLRXH4UwlpWTzjSZGlTXSP8DOdh1IG7DUHdovtcsP3YlUh1O+NJKEU
+FCeLyP9Gxn1Oj/jCtMMfLWIEcUAiKs9aO7FBiCoT3D/AsUXfg+1Yoqt0wA/uw4Z
Lj/uZZmImxI8lDchx2IDSX1Drrx11Tx9fEAfeWF1pHD77lZiE1xQvGSbsFYIzW/0
NxVYy9p87Z1yokWC7PMEtAV0jDm9cW34tUCfFMkhksAmle/YCp0wSSW5aTeAZ2ai
u61ziERx
=3l3k
-----END PGP SIGNATURE-----

--xxGsxnhbYz5+LiZo--
