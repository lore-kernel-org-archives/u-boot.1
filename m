Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121A3C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 20:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649DB800CF;
	Sun, 19 Jan 2025 21:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XhLE2zpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8AAF801CF; Sun, 19 Jan 2025 21:18:23 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FCD980085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 21:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d896be3992so29571146d6.1
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737317900; x=1737922700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r7DubS0u6po4DrShUYqJ2K1RgJX6zVf2oZusv8zNXgY=;
 b=XhLE2zpCHGmde7TmeJuEX81C6+2Mj3WNHfQ0T7k7NQItmHZ/iIKoSFURfblg9SfD2G
 OZXnyQA0tl3jySNquf6tkP1ZycmxehXmgGzmRznIvatsmZltze4C5+wwaUUiRtpHBxtS
 QVf3LkWKGTx42lA7Q5NN2cH0L3AMLQP3o6wUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737317900; x=1737922700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7DubS0u6po4DrShUYqJ2K1RgJX6zVf2oZusv8zNXgY=;
 b=qyDnusrULCjDL5mZiVUH3mcE0/jvmFfo01n5ZweWd0xsQOIjX7iDwSuVk+wYRPq/4I
 /UIKTffFYhbolN7yn3Vi+PmzxIXeWGLU/UDUGf/V6VCdxdL3OGaTmqprA2wpwcjSaWj9
 9aWYCBVLXRtnhgMEc5hDuBqCIyTL+2DdjMJkjXkxr2vkW98eCJYvJD+RLp0juuqJvD+3
 nOBE5TpeM1slFAh/YQAA7e2TQ96M2hBtjUMtv6ZvmykvPtx7fMPeTX4X+XMalrRVwIVw
 uYxsfMdyd5OjysBEPyRZCbRJWoS1qXS6SWXW45iZNt/gDBzZeEdcgPFexY4g5qWWcZVq
 AXfg==
X-Gm-Message-State: AOJu0Yzj6EZD2V7Cc2bzXJ4YOLtuhIYbGjqPCpnzEmrjr7hbl0LlX+KX
 RHTYAH/BHE19HlWMev0Vm60YN+/Qhhq1qXBZYo2olmJGi+c1Mp00kt/rjN3RQBFCywHegXjuo7V
 k
X-Gm-Gg: ASbGncvss3GT2PIRuBEgkKza++cckdYuC9IO8iCq66HRsxnLdXK+z4Jf6UNlFz4cNKv
 SsIgygCb6iKaNCOce4aDrEFoJRZEvZhzNwb+osv5wNLXo2NelTunIdtZAdf0lfZGmTXOU/A+14r
 X40whaDEGrkqhWvINdDor2M9YH5m9hGl7bSP7SWyCSSPZzv16/OEEQMjjDfplwAsQqcpfQebBXW
 gs+Ov1aw53al5z8+PthJnYKnrA6wrU0ApGV3dJWy9uErRITZL7y/KtgN/rmsSBIcC8=
X-Google-Smtp-Source: AGHT+IG/ut2Trq3EcWmiMgVzaxpXgcUpS7/5MKzXvpdnj/EKK7BcAb85j0LHz7+BZGxSbQgx2pNZ8w==
X-Received: by 2002:a05:6214:260b:b0:6d8:92c9:12a0 with SMTP id
 6a1803df08f44-6e1b224cc1cmr181317626d6.44.1737317900341; 
 Sun, 19 Jan 2025 12:18:20 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1bf056fb8sm19401466d6.34.2025.01.19.12.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 12:18:19 -0800 (PST)
Date: Sun, 19 Jan 2025 14:18:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20250119201816.GB3476@bill-the-cat>
References: <20250118111830.362667-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oV/sGsmXw2ZPHlfi"
Content-Disposition: inline
In-Reply-To: <20250118111830.362667-1-marek.vasut+renesas@mailbox.org>
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


--oV/sGsmXw2ZPHlfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 12:18:17PM +0100, Marek Vasut wrote:

> The following changes since commit c11dc783fb4418393dd08d39ee01debfc2dea4=
d4:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2025-01-17=
 08:27:40 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 1487c34efa7b6a439ee7396e333cfc3f789f564c:
>=20
>   arm64: dts: renesas: Deduplicate extalr_clk bootph-all (2025-01-18 09:2=
9:17 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--oV/sGsmXw2ZPHlfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeNXgUACgkQFHw5/5Y0
tyyigwv+OhHd1LUHI48xRGCQzQy8h7Si0+KHeqfmmRmstFhrhyE6BQe3vfON/PqV
YIgJo3IWQ4VDlSO8bwBIfe3AQP8rswOZKqtNZ2Of9FGFwSL45+6+9KPZzhZ1ZHiF
/J+cGUkpu++1oiErbOHofuWS+v/NoTn0FgV8xSeLrU9fdKeMIiZinkkSErKiCrGT
5u/zbgvGLau0/RYhWSldlULwLfB3eDg39SGjf9WsbzvthPJtBD5F0uOZmLcOhBHr
2ZlPxx7HCriNyNDMGXg/bztAehkCSv1bdC9q94mZkoqcuCecaIlcpbeRj6+M+u9Z
SOf8q9jLq8fhCDm69yAUgJqKb90My5kXI+f8WUlAZKiDU+S4i2zEGx8uS4VfwPeH
7zbKvEqIk5+dJp374cD//pBQocVN50xKcf9KO7Sn3hx5cIYls3ekFw2DnaVYxvg7
YyG8LVY8gvJV4n0nTrqLP3ohqQg/BtqTQ8Wb5vIfYUeEvJ2JnR9vln2rb66U1b4O
AV5y6Rdg
=5xU/
-----END PGP SIGNATURE-----

--oV/sGsmXw2ZPHlfi--
