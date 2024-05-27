Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D97AC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7580088307;
	Mon, 27 May 2024 23:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7BORRuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED6B87A09; Mon, 27 May 2024 17:34:44 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AC788268
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 17:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so3797826d6.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716824080; x=1717428880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CK6nGuKIObCb639REc5vgXdy2ui3LrFVSBO3YUUvlc4=;
 b=X7BORRuoahwg1SSt6vENJRGAp+mQbo1Y4osbR2x6H2G2cTMX5fUAem68t/JuufbL8w
 E4J+OH+pXeSzeH2vdjYPWbMVcq+ZXRW7YrVQ9FpgEEI/6yu+yMo1R3NdgMCqOlkcmT/F
 nAYrENAv8AQJGOwvI8HXjB4v5V1yMNs5r+bp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716824080; x=1717428880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CK6nGuKIObCb639REc5vgXdy2ui3LrFVSBO3YUUvlc4=;
 b=D7xsEt5l2u589cfVVRRDiuPxA9lQSmRg8MFjLiCTqjGi0X7UYvh7Pr8j3VCFDosyEQ
 +pBSjku0UVN+XZ4sF/aOXHZrInHRhBmk1ALmBu6CoezkurK1+g5komIYIrn0qFd+fcxO
 dvtfWWLESaUWLhBAgl/+0OOvdI562f/yXqoUWnkLt84qXyMDr19ObdICupTs9T2FmsMS
 lR5/h1kTdqXxxXYIKbxQTbrDHGV1iApmZ8IeHl7RX0S0cHMPxLcpLtzZ/CZHTQ4OQqQy
 YUSi2L8JRxP0tdIIcgWUY2BlXLpTzjM7cXpJKQKzMcXYhN1vh6DJwkdUh5Y6o0nOdwNa
 lkrA==
X-Gm-Message-State: AOJu0Yxv/9YOSJ06TAMYMZwYiD0koBBmNaptQdWVsgyhT4iuid+L5ftH
 35dI+uCY23LlB2TSc4iDgsUtSOcVu5QAAYZ168LvbtT1raMX2G02uspHuzOfCDM=
X-Google-Smtp-Source: AGHT+IF4nmQq+gyDdZrd1PsRY6tD/HWTIgDt7SRyvoqhdcdzMVKsccOSgVtak7KAWxT5r73uY3raug==
X-Received: by 2002:a05:6214:434a:b0:6ad:6cd7:72c6 with SMTP id
 6a1803df08f44-6ad6cd77574mr85893186d6.15.1716824080179; 
 Mon, 27 May 2024 08:34:40 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad653e0a21sm27285796d6.81.2024.05.27.08.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:34:39 -0700 (PDT)
Date: Mon, 27 May 2024 09:34:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Joshua Watt <jpewhacker@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ion Agorria <ion@agorria.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 01/14] net: introduce alternative implementation as
 net-lwip/
Message-ID: <20240527153434.GH2568172@bill-the-cat>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <923f66b4a74d9c91c6d661e96dced8e1cbcdc7e0.1716566960.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Raoil4yn9fn3z+i9"
Content-Disposition: inline
In-Reply-To: <923f66b4a74d9c91c6d661e96dced8e1cbcdc7e0.1716566960.git.jerome.forissier@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 27 May 2024 23:34:36 +0200
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


--Raoil4yn9fn3z+i9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 06:19:55PM +0200, Jerome Forissier wrote:

> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
> adding a new net-lwip/ directory and the NET_LWIP symbol. At this
> point, enabling NET_LWIP simply disables NET. Subsequent commits will
> introduce the lwIP code, re-work the NETDEVICE integration and port
> some of the NET commands and features to lwIP.
>=20
> SPL_NET cannot be enabled when NET_LWIP=3Dy. SPL_NET pulls some symbols
> that are part of NET (such as arp_init(), arp_timeout_check(),
> arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
> added later.
>=20
> Similarly, DFU_TFTP is not compatible with NET_LWIP because it depends
> on net_loop(), tftp_timeout_ms, tftp_timeout_count_max. Let's add a
> dependency on !NET_LWIP for now.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
[snip]
> diff --git a/Kconfig b/Kconfig
> index 82df59f176e..758256ab121 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -747,6 +747,8 @@ source "env/Kconfig"
> =20
>  source "net/Kconfig"
> =20
> +source "net-lwip/Kconfig"
> +
>  source "drivers/Kconfig"
> =20
>  source "fs/Kconfig"

I think we need to instead rework this to a choice statement instead so
that in the end we have something like:
choice "Networking stack"
config NO_NET
  bool "No networking support"
config NET
  bool "Legacy U-Boot networking stack"
config NET_LWIP
  bool "Use lwIP for networking stack"

if NET_LEGACY
source "net/Kconfig"
endif

if NET_LWIP
source "net-lwip/Kconfig"
endif

And then SPL_NET still depends on !NET_LWIP for now and we sort out the
problems with different networking stacks in SPL vs full U-Boot later
on.

--=20
Tom

--Raoil4yn9fn3z+i9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZUqAYACgkQFHw5/5Y0
tyyvpQv/T4ZJywYNFHMA9h2sSodFAzRp/I0g6RplVQ9XZeAwJGUZUJcHDg8ztaLi
eoNBvJyplEKWGcTMp7t0EmjqRzfnJvhbmqyLwsgAFEvyXzTYurwO0Ef6LN+4FWXw
8lvv6J8WHekL2oe0fNvw+UCduO8WcKOoiTg1XsjWrABqEpjzStlgRgF/XH+MTEzL
DQ0yj0ovV4vTSM5AF6PDidydzFIIdwXFwx32VLPGQCnfveWMFvei4lxdLppixM5l
y6Vfus/Awsd41LYogGOTUV03l94PuDbTRbjvEYambkhsGkx7VUmC0p9tO24EwM4O
BQDiIfrbZ/0kqzKlV5UBsDq3OfZywQWfjILgHN/awHN3OcKcln+Op7h0A7oDo8Fz
/tK8zBtR8bax3NcowdoTkazdsTKSOsR0Jyt3ENOI3awhyIJh3DLbtvZhqzMbzIGD
XHNkWiRgfTLAyMdufNF3xyAlUZq62DjwsI+ospLCfKH3oTY0nvb5wrT5HaWzXd5y
zYhi1Gxc
=CLZk
-----END PGP SIGNATURE-----

--Raoil4yn9fn3z+i9--
