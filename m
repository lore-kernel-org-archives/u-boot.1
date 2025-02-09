Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB18C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACA4807FE;
	Sun,  9 Feb 2025 19:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g4qhCZp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A19C80834; Sun,  9 Feb 2025 19:06:43 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2554A80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f768e9be1aso39276507b3.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739124400; x=1739729200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fAJ+ZDZy5SpAEJIMFl/jPNn+DvXXGHrecAveHz6Tlg0=;
 b=g4qhCZp3xbJtSFSzufcfKEhaVqVxkOG3UTfIDMv4rzI1C/qPeEoikoQYiYExA68STf
 YzXZ12OcOz+Nbsl8jfiKWPk7zWJR8uYfAFo+AWTPo08XOAXgSk1k/GHexwm8Lx2/KeUA
 LfS8ujTzMSjK2B5gi6+BqI3Tm8Mwe6XNWGbJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124400; x=1739729200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAJ+ZDZy5SpAEJIMFl/jPNn+DvXXGHrecAveHz6Tlg0=;
 b=R5yBhnFUQ1Cf6WsYqlpg73dkvT1RUBHnEnVBwJDQ2/yQjWKU6n5usS1XqwWQ7B5tGB
 KiY+kSgdWZcVpGaThMdkMhI2f4zHZxpZVwVdcPXMSi+N5mWwDa1c5mBU2unKzaT5FhyE
 WMKfflhIyEpIlolQkR5g38KNNmHZ2CQs03OVWCEiXz4IcdkUjCZMC/Y3cjGXYFMPhOuj
 ptQTqYBMfLnDyGctSpWjL6wmxteqk/wMcmcFwxWwANK1JnR98yFerVLPIgmkMRXipBcp
 8csNaA3JKEVkDilwZOxWwM063R5gSv3yYIejuHTcOGHEX1fmi0rVNrr2H3apvm+LKukA
 onNw==
X-Gm-Message-State: AOJu0YxwHlE3y/WPGF+rt+/lbN4T4LQcw+YDQDOiIuv0lIkiPHalI7rO
 yvxDY6wKrc+jL5oywjqmYoBI1cho0+UmrjA+spa1Af0vKjQ9P48JOBR2Yo+TGwo=
X-Gm-Gg: ASbGncs1THeuXuJ7fDlTwxE+78nBhpVsrqP3mccVrCp8e8Xcl+/+IB6J8dToHOhDlDN
 rwEOUELlzUBERLA8CHd/gMjqWSq56Em49Jn215ysh5G3KP91q9BKwy5IBcVQ22hmS2SkhXbp+oT
 ahPrArV3AfTWytT+eqd1qWcUu4/9nIXPp1t3Ibdp74cr4VlpdjOpFj/n6MXhzAiUmN0mbPVVdKC
 1Rd4JNtwwzikAaKR6hQeLb3D0sseeJtRcvUCj0Z4b/kDeILP2jI1XyfVJPb54i+tH019K9pzPZA
 in/2Bp0woUttRtE=
X-Google-Smtp-Source: AGHT+IFkmRCyTVKVWW5brwplbPg5oVvcqKRiEYud3DBmuEn4+8oeGOJTUkx51t6DHSjMzQWtjvSENA==
X-Received: by 2002:a05:690c:4b86:b0:6f9:4244:329f with SMTP id
 00721157ae682-6f9b38415fdmr87338827b3.7.1739124399897; 
 Sun, 09 Feb 2025 10:06:39 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ffc374esm12950457b3.117.2025.02.09.10.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 10:06:39 -0800 (PST)
Date: Sun, 9 Feb 2025 12:06:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: Re: [PATCH v3 08/29] treewide: Rename VENDOR_EFI to ARCH_EFI
Message-ID: <20250209180637.GU1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ASxDrY8DZxQkUiM2"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-9-sjg@chromium.org>
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


--ASxDrY8DZxQkUiM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:07PM -0700, Simon Glass wrote:

> The 'vendor' concept comes from arch/x86. Rather than letting this
> spread around the tree, rename it to ARCH_EFI.
>=20
> While EFI is not quite an architecture in the strict sense, it is
> similar to sandbox in that it sits somewhat above the CPU architecture.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Likely the best we can do for a generic enough name, thanks.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ASxDrY8DZxQkUiM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo7qwACgkQFHw5/5Y0
tywTlwv+OtggFtdp8Ug0w9f51c3K1x7DCzlm2vu3IIwUpifpsat8d/gt/86qvFHi
8PirnMSNVzGzeqlLC/6m91A5Q4gEu/u1bR1t69CxLJMZd7xy+SIJu66bbP5wH5iR
/gADLJqDbAsR9+lUzC5rRTsgD8uH64zhjhgbAQhaHwnEr84sYG2+9UT9hVUJLHe4
/H7krGHl5OxQGG6YjBAnwKOk7ED9/z+8TfOMuDWAA2wbQtdr6HPiUTmcT0bvkc+N
ABF+reRXr5pNqQgmpp7oBI1x7GUCo2u70qzjqpee4fZE1KzllvJM9OYy1j0CUWr9
tkxtEh14s5Xlu5h5cCMAWPDnuc1Rp0H7zmNrmRsQGrDf/v6QBKcmNy52L9Am0bVm
Jol3lp4oZ3aEahftGXjJLLOACbaAqqYeVXg/QsbkUUvMeX40pMBpMI3O1mjh9pS7
CsdeMrjh6OwQtJ5FTCI1JoVuRZoxbzBC6BarxTGDCe8lcMlzUGgRAa6J0GixuPey
sTyNu5GU
=7CAP
-----END PGP SIGNATURE-----

--ASxDrY8DZxQkUiM2--
