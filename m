Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7CC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 14:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1193801BE;
	Thu, 20 Feb 2025 15:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QYP1rYWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C259801DE; Thu, 20 Feb 2025 15:37:19 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F358007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2211cd4463cso20519365ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 06:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740062235; x=1740667035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PJ+sp6V/7JmByPQ+SCGUZyHY3frnBUrkz8ZspSS2cto=;
 b=QYP1rYWwq/fiq4Rz2k/+FWSBzquHP/Z0KhxQ7+ljT7/sRFWXWDWWiNrsKXZ14RBMKn
 I7k90ME4XGNvo35Vf2HwBF99FPREQQ4eSV7ypoPBr0HK7yK4saXuzpm4HqUHilC5/zjJ
 1f18P7fY2W8E/IVO+rwOsqKkzNl1hH2yPOYaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740062235; x=1740667035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJ+sp6V/7JmByPQ+SCGUZyHY3frnBUrkz8ZspSS2cto=;
 b=pyzs7UnUEYGKWKO9d5Z8fXTfUa+4safjMT81a/bBqEpvlfYBlWtC+SETxlFmeCnRiE
 HbvVEU5Z33FC8tEvaVX7lQq/2rvR2t9oZDFzqbdBdEOHPpOdny75mrKUYaS5m+RwLGQI
 oaA//ZvqjeVRudxL144aNO2szxbCov4Sa0wBmDezeXVLIPnWqgPOQomgetmj4EikMOmx
 0XlImdbySntiyLEJ2duQe7pGwk4bGMgbgqEZ7uAA7xT4DGquHG+cODaDpdv6dd2GAStz
 Vn7J5d9QdcBd45fK+Z8mR3oVR7eIIFqJuEWXVTQEbCVuFbsAlRaaIEqrfazV/JXxZPj/
 qLrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe8tND92j5WtT719ZLp10G9aiKySybt8Lv5R8X0GdqfxEeenFmq15/iFtIGeTWBvZkM8odZpo=@lists.denx.de
X-Gm-Message-State: AOJu0YzDziyweAzvxqt4Qo/6eHr4xxqq4alv1flywFzqpjjMk3JCXayo
 lW4tyVbCxWNI+P5Z4kGmJm6M8UI6Fs3wddIHHAZ+Lw8wMIxsCsmDrisPxc43kq8=
X-Gm-Gg: ASbGncuu3avHegKgP3yLzMCKct4w+nTsTEoUYIkkxtlavi1TuCFYMBdBD8mvEbAHrrZ
 Dqwq1zReSvL5XqDSpt92S7q9hmZ27JwcIycsweaKd8+wEco07RdDDuzNtKyFNE+Cd8vQk0N1cvq
 aqrpdc+PPQ7BOUPH5+td2JPKCTe8iuHhpjK+iuYj7v+98UdIeYfGAB6QM2XTCVWYTZZBa3oK/Xg
 q+bj+if7IqSwwcgoZEueglidU8uHT52YB/y3F30TVNfm2IXwL4y5M99kKOgGFlIyxjI5jKPNJvp
 IluwU3LNx721bw==
X-Google-Smtp-Source: AGHT+IE5XfHP77aSTEFVXfjjmhn6VjkM1hMM648+rudnkvhcNwrsKBwcoz26L/b4zRUhZKIcMerS0g==
X-Received: by 2002:a17:902:c94e:b0:215:a2f2:cfbf with SMTP id
 d9443c01a7336-22104048715mr346524175ad.18.1740062235378; 
 Thu, 20 Feb 2025 06:37:15 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d43dsm122997255ad.158.2025.02.20.06.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 06:37:14 -0800 (PST)
Date: Thu, 20 Feb 2025 08:37:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: n-francis@ti.com, s-k6@ti.com, kamlesh@ti.com, a-shenai@ti.com,
 u-boot@lists.denx.de, s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU boot
Message-ID: <20250220143710.GX1233568@bill-the-cat>
References: <20250220100241.1170993-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pw9l+LJS8qWfTeLU"
Content-Disposition: inline
In-Reply-To: <20250220100241.1170993-1-h-salunke@ti.com>
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


--Pw9l+LJS8qWfTeLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 03:32:41PM +0530, Hrushikesh Salunke wrote:
> Increase the size of malloc region allocated before relocation, as
> current size is insufficient for dfu boot causing it to overflow and
> corrupt the stack.
>=20
> Enable the fixed regulator configs required by vtt_supply which is used
> by "am654_ddrss" driver. Without it during DFU boot DDRSS initialization
> is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
> are missing from "am65x_evm_r5_usbdfu_defconfig".

Sounds like am65x_evm_r5_usbdfu_defconfig needs to be updated to use
#include.

--=20
Tom

--Pw9l+LJS8qWfTeLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme3PhMACgkQFHw5/5Y0
tyyc4wwAnGmAkMB3mjXtL7zVz6h7uMfSBYNMSM9yKHglH1YUgnnTlf2Um6PlF2ze
CmmnHuGoawL1hE7FZJkvx1WC/GLpKP3yQ8igIeQ+M/aivIHnhfDJlmWFpa0HOQ19
tgDKHBN+63xAdwCbmvqDOgrh+r5E5bzBInnCURTpUjKIDCN10FUdxE7MBo1ku8fy
M61aAQqRaNXFyGVdDad/jzmxBtKV4nCXyNUaJkKm8roRI/owSAxtP2gxy0ZPWqKL
HjcgwwMtNKWuY64MP2DfrKfVgMzFLbNI322E6v2mOuxNgRng7NGxRK0Wl5iZB5I3
qhvFi637Gi/prOAeLFIkXSoYny3jmMQ5UdoStNmvJYfvqpz1xijj/J3+TpaFpt/9
hT2I8/NWLGKYQdeLwWpjMwruSn3e/LWo1gZUWZDGumouUYwhB3ShIk6gjIgzB7H2
/mZYNcBy87dtKqPP96USgDIjnFrxQggjRYH+RYjlXndIu3WfBSF0hpqWpbMStLA3
5Xap3Kfn
=XhIH
-----END PGP SIGNATURE-----

--Pw9l+LJS8qWfTeLU--
