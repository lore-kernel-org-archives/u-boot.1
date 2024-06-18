Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F5BC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA7788427;
	Tue, 18 Jun 2024 20:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WUMLOAqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB46801BA; Tue, 18 Jun 2024 19:59:44 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2485888180
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 19:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b970a97e8eso3189111eaf.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718733579; x=1719338379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=14eGF3UzsChau0gPRjsHE64H6GqWO01NjFZE8cNnCek=;
 b=WUMLOAqnJVaqI5o5Ro6NwUXRXjtFD7SX+OPPYF8UXi101HciwQI+voeWq/3WVrME9X
 gAj9rBC5sGb4fEMRYfzcL72f8q/NWwxA18bsW5GBW68NhMkCIVbA0wBO75RTPV5YiyR2
 ko662AAxNZI0NrO1Z7rCgSCUtDUoTnNElpM9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718733579; x=1719338379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14eGF3UzsChau0gPRjsHE64H6GqWO01NjFZE8cNnCek=;
 b=foRJbkmxUXx3raryWCI1QKFDH2nIwOMjYHTM5U5RhphaRIhQ7qOvzMs89XG92bHNWw
 6i5jgDdPNTd2EW/v7MN+sOyaMhYZX5RM7HIV4m7u7BfmDcGdO+sl3ozxXWeBkbOZusts
 9EExxE9VA4tZLONFck5s5OrNPqNpQYOu62KHnhVz+eJ4jx4HdSDNxMu95ugubv6rlW+X
 CE6SUne/QpA3Y2fay/Hr85bKv3sSt0zB/GsFY/ROc3GDvLu6KHyHWWyS9nVMdfj0SeWQ
 F+e11k58hBx0Iv0mrnDiSHJQHrvKcW8N2RhmtApEYOQr8qVvb/1UT4a5AkDUtH7z2ok1
 vzIg==
X-Gm-Message-State: AOJu0YymtQ8trVb1Lbb8IDPMOZYbA1xDEhavTrBYgZezCuLe7NBBL5XF
 HU8mJII9a9xe/5KIBv/tuyWeDTRWWmgDxNaaHND6d3ggkMYOHoIEhCWFCuiAgBI=
X-Google-Smtp-Source: AGHT+IGdnB2fy7IKTVGzPCcZqSzSqJlug3sjtAh8WjK+WUgb3EkLZU/FJ00+/BRDM+vgCZ5BH/RjcA==
X-Received: by 2002:a4a:ea23:0:b0:5c1:a665:fbfa with SMTP id
 006d021491bc7-5c1adb43f90mr728454eaf.2.1718733578754; 
 Tue, 18 Jun 2024 10:59:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5e088868sm1348890eaf.18.2024.06.18.10.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 10:59:38 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:59:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Shengyu Qu <wiagn233@outlook.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ying Sun <sunying@nj.iscas.ac.cn>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bin Meng <bmeng.cn@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Ion Agorria <ion@agorria.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v4 02/14] net: introduce alternative implementation as
 net-lwip/
Message-ID: <20240618175933.GV68077@bill-the-cat>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <f382942cd9d0d62da5204b884c6fa1a59526d262.1718638104.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8bQp1Q+Dysh78HK3"
Content-Disposition: inline
In-Reply-To: <f382942cd9d0d62da5204b884c6fa1a59526d262.1718638104.git.jerome.forissier@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 18 Jun 2024 20:58:28 +0200
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


--8bQp1Q+Dysh78HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:32:54PM +0200, Jerome Forissier wrote:

> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
> adding a new net-lwip/ directory and the NET_LWIP symbol. Network
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
[snip]
> diff --git a/Kconfig b/Kconfig
> index 82df59f176e..cfe2a6d3eac 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -745,7 +745,48 @@ source "dts/Kconfig"
> =20
>  source "env/Kconfig"
> =20
> +choice
> +	prompt "Networking stack"
> +	default NET
> +
> +config NO_NET
> +	bool "No networking support"
> +
> +config NET
> +	bool "Legacy U-Boot networking stack"
> +	imply NETDEVICES
> +
> +config NET_LWIP
> +	bool "Use lwIP for networking stack"
> +	imply NETDEVICES
> +	depends on !SANDBOX
> +	help
> +	  Include networking support based on the lwIP (lightweight IP)
> +	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
> +	  the default U-Boot network stack and applications located in net/
> +	  and enabled via CONFIG_NET as well as other pieces of code that
> +	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
> +	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
> +	  exclusive.
> +
> +endchoice

For ease of reviewability the next patch in the series should change all
of the configs with '# CONFIG_NET is not set' to 'CONFIG_NO_NET=3Dy' so
that they functionally don't change. It's 105 files and so while it will
be folded in when lwIP is ready for merge, keeping it separate for now
will make review easier.

--=20
Tom

--8bQp1Q+Dysh78HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxywIACgkQFHw5/5Y0
tyxtCgwAieWaO+UvOvDILHgwsuz3wJ+hlR8B2RdqIqhzHcsmckHTFCU1G3NhdVh+
OzlLhkqu5k6oq/6ijeOHEfHuoBbZvtlmf+xCZrVgR2wK9eM659WAvhl082NzBjjO
DBfqRy285MLycWgEe8PO1dhz++IxRYTb6N6jO7yaCj9oEFlQWsASEyycv0VRIwkO
DgD4w3ky0v9vYLPEqQm876xfOt4RFZUiyOR9BjvZxLPudO2Yj6JsUGTgmlSzd1PE
qyYHbrpvuqu/keq8CftaPW3LhX1MUTFnpS7fRk7//NBCs9cOFOCSuutioLlizSBn
h0O2+WrKqvoJ4G0FuVJSDx0VUo/XPP5hVRCoD4sn8q4DzN9ie2wbZErFXdtbAx40
PCvRiP0WkMNh2cOj5Gqw+Gdzt0GgbBNwmBYdvLdTu886BN/5v5MfWE6VFoG3aPYi
/7/XV8mZChvjFezImZrEEW4Ec6PPk90szquXFcwUMNc5oupn2kZD0/rSsw1xHb8M
e4poS7g6
=3O/A
-----END PGP SIGNATURE-----

--8bQp1Q+Dysh78HK3--
