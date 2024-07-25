Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB6AC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C368884A7;
	Thu, 25 Jul 2024 19:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GLqg5vLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EFA87C7E; Thu, 25 Jul 2024 18:18:03 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9461687F19
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c6924f2383so18322eaf.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721924278; x=1722529078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3DhfC/oz7LptIyc3/DZ6SuqKwA/FBohMYf+yI/kEY6Q=;
 b=GLqg5vLbWdpGRI0PlH6EKXi1JSR3umAyAC9Lp1Xf9XWpVGUsC+2EsGDai6YZkpunb5
 E3bprOHFsKPvfv0hn/I2AtAZOwqJC8JhBxl0ZKmOSyfrWmeKDoU5w/U1G95klyfJClQw
 6cuB36u68w3Rro8d25sL7zq+sUtY6gZEZkL7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721924278; x=1722529078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DhfC/oz7LptIyc3/DZ6SuqKwA/FBohMYf+yI/kEY6Q=;
 b=GTRbbGqZgicMsQgD2euMNfG3JtQp1ya5DhppFLbYFvl+pu9l/mXR8yhQD7ChO9hWa/
 NYmkNqHJdmQ31iZZTshQSfZTvwNwcSynReo0HhOTPspJDbO5jKuvBp1F8bVx2CVGLZvX
 PX20HYp/VzYDL7139rP95NzBUzIVAWggsKHqYcLZE7BfZ0NxkhXPQrGIF7cviRJ+Afq7
 lW+Q796iWtijtKiKtea6jm48AbKQGGjON4eMPEg928EsSgbdB8j7DSbDpdntb+Ef6XjL
 WwtcmaAr7/SsQLcFN7ahxYKXdR34jPK4C2H6H7UK/a3yKIhJsmhTnixLmp0k2o0ysy/g
 u88A==
X-Gm-Message-State: AOJu0YwkTeR5j9GiBdMZwnLTmqhvrvlAZMFI92oLdamzKtlXiQ15Tdz5
 1eiYhYJBCU/ZqPThP1Zp3M0pf+dDOqMY5ApsSbe7dqiomwM+OhrsTlEkpdjC9tA=
X-Google-Smtp-Source: AGHT+IGbamAvTx3uULuuV98FsxGiU6tHfaLmZbqcurovlTeomCFS+aNpt/lu2KgRV+uUd+haVSh8pA==
X-Received: by 2002:a05:6820:1f08:b0:5d5:b6d2:4749 with SMTP id
 006d021491bc7-5d5b6d2492bmr2662533eaf.8.1721924278176; 
 Thu, 25 Jul 2024 09:17:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b346e0c3sm190187eaf.3.2024.07.25.09.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 09:17:57 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:17:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bo Gan <ganboing@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Shengyu Qu <wiagn233@outlook.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Bin Meng <bmeng@tinylab.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ion Agorria <ion@agorria.com>, Yang Xiwen <forbidden405@outlook.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v5 02/20] net: introduce alternative implementation as
 net-lwip/
Message-ID: <20240725161754.GW989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z5i+vH7gBI5MiADc"
Content-Disposition: inline
In-Reply-To: <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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


--z5i+vH7gBI5MiADc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:57:23PM +0200, Jerome Forissier wrote:

> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
> adding a new net/lwip/ directory and the NET_LWIP symbol. Network
> support is either NO_NET, NET (legacy stack) or NET_LWIP. Subsequent
> commits will introduce the lwIP code, re-work the NETDEVICE integration
> and port some of the NET commands and features to lwIP.
>=20
> SPL_NET cannot be enabled when NET_LWIP=3Dy. SPL_NET pulls some symbols
> that are part of NET (such as arp_init(), arp_timeout_check(),
> arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
> added later.
>=20
> Similarly, DFU_TFTP and FASTBOOT are not compatible with NET_LWIP
> because of dependencies on net_loop(), tftp_timeout_ms,
> tftp_timeout_count_max and other NET things. Let's add a dependency on
> !NET_LWIP for now.
>=20
> As for SANDBOX, NET_LWIP cannot be used either because of strong
> assumptions on the network stack. Make NET_LWIP depend on !SANDBOX so
> that the NET_LWIP alternative is not visible in make menuconfig when
> sandbox_defconfig is used.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
[snip]

Here in net/Kconfig you do..
> +if NET || NET_LWIP
> +
> +config BOOTDEV_ETH
> +	bool "Enable bootdev for ethernet"
> +	depends on BOOTSTD
> +	default y
> +	help
> +	  Provide a bootdev for ethernet so that is it possible to boot
> +	  an operating system over the network, using the PXE (Preboot
> +	  Execution Environment) protocol.
> +
>  config SYS_RX_ETH_BUFFER
>  	int "Number of receive packet buffers"
>  	default 4

But we must have SYS_RX_ETH_BUFFER defined even in the NO_NET case as
otherwise previously <net.h> and now <net-common.h> cannot be used, and
untying that is another big mess. We include <net.h> in common areas for
function prototypes where their usage is guarded. But we use PKTBUFSRX
in some structs that aren't guarded. Trying to build for example for
am62x_beagleplay_r5 with this series blows up in a lot of places.

--=20
Tom

--z5i+vH7gBI5MiADc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaieqsACgkQFHw5/5Y0
tyyeKwv9H/d/5b+6HR3GhTx1ZLtM+ciMCqG93IveKZio5dWi2vxvqrjiVJQ0/FOj
chK2/IUihlx8ZwWIm5aFDeA8Kd5xddoElaRSAIh0bAjtc6VY9yF8BKpQBjU2pN0W
XBhHVb04B5mbFW7LSxpA7rD2GyG50ECtjnXsM01uF6iedati9M9aAZKY0wZD25+v
lbZ3uBekzioPh4iFM9lrTOOp7/klmSY+OHkLhifDPTP3l4dQ+6FHOsQcg3ukygM9
xhBVJU8HAfrPiRG4qYaLtpYxtipeMYY6Pb6MXa+PbJeBu+4WWqA6k9o4+Z5P3sei
dvdMMv/lHx5EuJwqQDtX20SehIAe4XvX3OnSGVZbWZsghpArEDo0GTPlRRfvUd0A
Xq3g5tCP6hgBofqZQ2zenbc+clBPjoj+oaKCmeQi0IzuxIrUAfJG0akB+Ag+FgDB
W/UUJ87e+iiP4vFoq5WBUhlUQ2b4qs/lUkSQM3hKAoF8c6cSw6DHtVAyk9Cx5RTP
c8PO/OWW
=XVzF
-----END PGP SIGNATURE-----

--z5i+vH7gBI5MiADc--
