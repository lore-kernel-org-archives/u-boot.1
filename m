Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E75C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 22:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B4B83340;
	Sat, 24 May 2025 00:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vhq9+UwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18FF8333D; Sat, 24 May 2025 00:51:50 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2939E833F8
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73502b47f24so180553a34.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748040707; x=1748645507; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HQUePzk4JUo8bpZdKQ+b/GIS0cj1BHPq3sWBMLR8jBk=;
 b=Vhq9+UwAtkHnRBnSlAwHqgGuBX996brpeC8WrfnlJcSIthY8m4xz5HPrXvV5DDatXN
 jXTGIF+RvQm+l41HNMEW1fIv9Lb53VQTYpn1hjnJzBsdT1bmUFdvcgBAfaBLH62/Njke
 DCOgRAaGx8o3PxKjvDcD3T7IP0XuYa5833Th8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748040707; x=1748645507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQUePzk4JUo8bpZdKQ+b/GIS0cj1BHPq3sWBMLR8jBk=;
 b=T4pvlhiX7DkbjcYsjVwVtE5HYqJeaRM+6hlHjCG2Te98xsvLUbdIOJ7RQZXm1UIkVn
 0VFF5oN51kVfhEUggnoIYXIvn5xphbU13LAKooRhWbx5TC7Y5oQaNUYmXDLossZhZXTS
 B+SmRuLJmQLXoilOz6b6rCe95C0ppMkP1YFIWIxW+zeFiRxNWbwMjUufckXLgrnTk8jN
 iI0z2kmcfbueiGWN23JheRTX2IM5mcDQWGuQ6eEXFfxZ7tStB5zryOxsWw3oa1gQq3zK
 nsVD4YJvpcFfUHmgc9nGlbnaLQJ4qxP7k6ne2W5cpBEMi0xCO5iWgyJQX/xS5MPpNHa2
 gf/A==
X-Gm-Message-State: AOJu0Yxm81eNNR7G9dGVgFkFsJ8hHLG1uBB5x1S0zn5M0N5hUwOmWnhN
 B8DCc//3MhmCx1XKWZRuvEnmiIaE/TY6qYfU3OjgKfqjOorj30BzXAobJC8JGJSzDF6N2/Qhowz
 o31q8+aU=
X-Gm-Gg: ASbGncsvQ9sbRgaju3P279v2LL9Nmegvgzrpd66iklAljr9csEk4eXkRBW5An+nb4v5
 Fn4mJKtVvpsw2RbK9geHwpT3sY8fBpwipDCBKusl9w18V2eXluC7uvN+F7hNk/bM2oef5AsXlKI
 A8i8+odKCOJoXJs4Bet47065mdNLtEcSJuPv9g1Kn88NZz5nGQ2+GxCFI6UbvDCqLtSU43fq+/h
 hIpMIC+cavzw+vyBUnH6xsffQ7meDpLWeWnQ7BxFRRBMVzpI3xCFsb4t0erbFvKNXMEA1GhnGo4
 dGRFI81MdEQwvz2vm+I/zc/V5oRadiXDQ8EYoRYmgClQvUhoRbVPbP5ASA/EM4x2h+0Xpdpfx4o
 XmPpYd6yczczI
X-Google-Smtp-Source: AGHT+IGw+OEi0Rw+gXbrD1un5WSbAcAP0mRpC5eM4gc6Us0Cx7pLH+1nD4EAJchE6YGNDusDl6jMbQ==
X-Received: by 2002:a05:6830:b91:b0:731:cac7:362f with SMTP id
 46e09a7af769-7355cf2a0camr880501a34.6.1748040706868; 
 Fri, 23 May 2025 15:51:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4b0bfsm3080841a34.7.2025.05.23.15.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 15:51:46 -0700 (PDT)
Date: Fri, 23 May 2025 16:51:43 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sean Edmond <seanedmond@microsoft.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v8 0/3] BOOTP/DHCPv4 enhancements
Message-ID: <20250523225143.GA100073@bill-the-cat>
References: <20240509023918.2504185-1-seanedmond@microsoft.com>
 <174803917198.2369538.18387605008838632819.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2XcdcEQ//y0Wa2xd"
Content-Disposition: inline
In-Reply-To: <174803917198.2369538.18387605008838632819.b4-ty@konsulko.com>
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


--2XcdcEQ//y0Wa2xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 04:26:11PM -0600, Tom Rini wrote:
> On Wed, 08 May 2024 19:39:00 -0700, Sean Edmond wrote:
>=20
> > In our datacenter application, a single DHCP server is servicing 36000+=
 clients.
> > Improvements are required to the DHCPv4 retransmission behavior to alig=
n with
> > RFC and ensure less pressure is exerted on the server:
> > - retransmission backoff interval maximum is configurable
> >   (environment variable bootpretransmitperiodmax)
> > - initial retransmission backoff interval is configurable
> >   (environment variable bootpretransmitperiodinit)
> > - transaction ID is kept the same for each BOOTP/DHCPv4 request
> >   (not recreated on each retry)
> >=20
> > [...]
>=20
> Applied to u-boot/next, thanks!
>=20
> [1/3] net: Enhancements for dhcp option 209
>       commit: c867045eef153b0beab69fbc74059fcfc4ad9472
> [2/3] net: bootp: BOOTP/DHCPv4 retransmission improvements
>       commit: e6bca3305bbc333cc71e5bf1ee483bbacfa84736
> [3/3] net: bootp: add config option BOOTP_RANDOM_XID
>       commit: 2111bd7e93a3044f0590c942a41f2667d15d923d

And sorry for the delay here. Can you please follow up with a patch to=20
doc/usage/environment.rst for the new environment variables? Thanks.

--=20
Tom

--2XcdcEQ//y0Wa2xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgw+/sACgkQFHw5/5Y0
tywtPgwAjwrSXiK20GQCEB2H3IqFR735cIIgK4+qkGefeTq1QNUkdtN6s2tmhfJg
2zg0wYy9RbVFyjy1GeLHaEXfEquC1u1Rst26+mUOM4ktkbWavEWsd6KQL9GNGpjK
J/Zco4jOBpe6U9nVvqdADyZokZR1L32XS5PhO/Cioq+6iukbpjXBzGPnME/+oUS+
4UA4s41QMA0S+PrwQOpzx5mAGdAy5Gr8BWy1go8N0UUV1gKf4crVgi+JjmfG7OBa
obvYnZCEGVfoyoraV1CNf5Rm+SWzUzQD3PK9t0C+4vXXDG2K6uzZdjk98G7gn+Q/
d2c6ZZ7PD+kHWzuZOx5E1wCzUgRmsl2Pwzc3wsDy8ihJaLQVhupqqgt5AjVG+YNf
yCKbm4KIfwmSEM18V5I09iRJkpigE/IwM+2oyZg6mYInybytMZEh8ICR76abNaQR
Ssyahe170L1I+13QsgRkwqBSqZxZSnj1NFQ42pWtNSWPbpeXjjetjraYqYRpY0HO
rE4ctc6o
=g//i
-----END PGP SIGNATURE-----

--2XcdcEQ//y0Wa2xd--
