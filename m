Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDBCC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 20:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA0A82103;
	Tue,  3 Jun 2025 22:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l5olCnlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8E6822D7; Tue,  3 Jun 2025 22:12:56 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98A681F0D
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 22:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6021e3daeabso2933151eaf.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748981572; x=1749586372; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tdwWr+8MXbfu2swZxn+9OHbxO4F1MTyUMvk018F6jeE=;
 b=l5olCnlVCCBTRFrUxL/Fn60Hbxpp68Tu7Xpc2NQgoM9hChOgQ8uQR+f73YyDcCWt4f
 h9oL7nX5E4Ejt2Nr7jWJPNrTx95DaeMHIKrigfIWGruiIr8srAbDwz0UrMGFWi07f9Lq
 Lv3fSlcFetMNKcfxzpPkVIr9UEQfYmS2J/y6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748981572; x=1749586372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdwWr+8MXbfu2swZxn+9OHbxO4F1MTyUMvk018F6jeE=;
 b=lfP1fM7C4BPTmvoYJw6lkHv7PLGq/qqhGjcA0SAMWZy/0ykWu6BXkzx/7xHspDIgYJ
 rYouSJQREVEI6kWat9khunu18Fg9f789Xq5mD7Ye1Hc/1jQxRqVzz3EWS7X+A1jd0iG0
 vgJobt6p43Y2sRQbmR4tb6A8meB3MDASBRN7gY3colgoz64CwrdagcNUXMoDqjz4lNwm
 ZyXBiU9xB71y5Wi/rgskRI4YMmpTVZxdsT11kkbGqzLSfylqtL/YfUmcapLectoeAOnR
 bmiwQT/xzdQ+aLrmdcZM/aSSv0NguSIRzoY1s+XDo06aYagwe6krAfccOp+19Di2MZ2V
 unNA==
X-Gm-Message-State: AOJu0YxSgHWlXSMuqPPbwzWd4u0dE7OhFqGoU3rdDXETSpOZRr+RCjuQ
 PDttgmlkcqXYCnvmUoGWk/fptagvWCRKuZ6gbV2WLhBq4zZZrbhXETEO+N5Asw5YLcU=
X-Gm-Gg: ASbGncsYH4n7ClRHl8SZf60DkzfpF1MiwbqbtVwEKWEC8Jwpa4wphVTu1w2/yvJ0rLe
 q2C9jRbMkKv+92hgBwnQvuXv0hBjkQGuvwKnrDokkkqbwHVOOoklKTba/XjGWKK2fJLSUgC55AH
 mXhzatFvYMEssGsmFvdPC4Vs6aHV4MwifXOLl0UWW0innjEUJymETDjJigFd6Xi01g20binbxIz
 kSfwrQrleOJFIG1BdxZUsE6SRm/acIzRLG+/ulgseDQk0+owlU4faZHOeB7hWmaZ659tHcAc0IV
 BwYiTxFe7omQFJHMkKFTMN2E+PbxL5nZqFx98owX+g8p81Li7Lm49SEvafMrfgslF4dpaUv9vt9
 u3HkIPxvybIOT
X-Google-Smtp-Source: AGHT+IHgxBi3pQX6iOBjv9eFSxH39athmG8uCooqMAsCftA7zsN59LtVp+7a0xIG7js2sG9Wgp3AEw==
X-Received: by 2002:a05:6871:2312:b0:2e9:a15f:6c3b with SMTP id
 586e51a60fabf-2e9bf303400mr70600fac.10.1748981572542; 
 Tue, 03 Jun 2025 13:12:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e9960d70ffsm570981fac.14.2025.06.03.13.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 13:12:51 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:12:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH V3 2/3] test: cmd: nvedit: Add basic unit tests
Message-ID: <20250603201249.GA1510455@bill-the-cat>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
 <20250509190043.28641-3-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="enaIkNhHVfgwpzdV"
Content-Disposition: inline
In-Reply-To: <20250509190043.28641-3-cniedermaier@dh-electronics.com>
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


--enaIkNhHVfgwpzdV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 09:00:42PM +0200, Christoph Niedermaier wrote:

> Add basic unit tests for argument checking of the env command.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
[snip]
> +	/* Binary format with checksum and with wrong size */
> +	ut_asserteq(1, run_commandf("env import -c ${loadaddr} %x", offsetof(en=
v_t, data)));

This will be "unsigned long int" on 64bit or "unsigned int" on 32bit,
and so we can't use %x here.

--=20
Tom

--enaIkNhHVfgwpzdV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/VzkACgkQFHw5/5Y0
tywfSwv/RlKWvs8YutBHXmhA0cPO82XpLHAk+XTkq6HYrFmAfTcC4DXjB0vmr9H5
2rCXHUuatWPMb+Sx1gc43E0ZbCLGQwWV8pD1k2fv3tdTTmZ3OYLjmfBDIJNqzhGm
V4y4pI6/Iu4ZKks/rhJofmrG5+SwQNfOBuwzLAe+SuqPI7JJQs9lxncA8/Bi3RCZ
jUxMWRVys4XNpfA2g2gjUUAeLZ4vE/aNs8+npgiCab1EcYIPqJ+zoxe5HVL5h8Es
G38uzkrIQ/iegohKQJCnZsmCRsnV3x5CquzMunXorFuzW+A+Yf+Quc3Nzo5+L59M
XVTp0hDtcgegEAzVCTngJVgbezG7cu1WWebw7ff8fB3nHIjxMQtaEQBLGawkpO5g
oeARgRZnYXpQ/S2/BfJuKcCEPAhY7b/gYjXCuazh+vApIzzR4X198eux6T3k+FUv
VXM0Qu0YbXId1eZ247gUT/IxsJ7WC+dcQZlyB7v4cIHNxfbdXskrwFwCAvzTcnwZ
k4glyxsO
=AjYp
-----END PGP SIGNATURE-----

--enaIkNhHVfgwpzdV--
