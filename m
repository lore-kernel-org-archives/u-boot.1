Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4591CC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7157820E3;
	Thu, 30 Jan 2025 15:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qzJjt3wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70106820E3; Thu, 30 Jan 2025 15:50:35 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26CE82102
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eba583fbe8so240220b6e.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738248631; x=1738853431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=28AYLWlfA+6drg7nBcg35Ok/SPN+lW7vnxMP1rs9S7M=;
 b=qzJjt3wrFLAC0mcdq6bFX3SUmVPgR4/aL1ITFrrgn6OYQKntqTeDL9xBflDadoEJfN
 h9/NpLZDbxeq0BduGarpWXkGQUxwXEDIdHmIm7hxKuZLznE/4NjxmgEAuvJWXtld0pOk
 4gpDxh0JUPHLBzlh5gcFGh0Twte8UO6vfR7yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738248631; x=1738853431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28AYLWlfA+6drg7nBcg35Ok/SPN+lW7vnxMP1rs9S7M=;
 b=QfnVTS5HdWgIP9rKr5aOWBliB+G691PpX5ayVGfgA2FjBtSjYRHYUTyOuFt+7o6vJj
 TqEkA6kEp7ZF9Rt8S3OpjXVDKA+E1MS8D4JwP71LORmcDCaUPPd3mTAiM0edr8X2uvMA
 daEuIwoiRboZHwwLOB6YvTjHij8q+6KFqvpWqll1xdXQjJQ+UZEHQEsfNDp4PK15S96f
 H6bjt5v8YYxo9pIoZKQ+tNZwuOjdhuGUQjy2JS70TgygIa4VwnELJgzkLsciS5X96bje
 3W/LjPZfly09JiIioPtXDEfYsTgAE4+VkYtRmH9Kgko6b+vooozQfMMDdAm6snx/h54v
 vNZg==
X-Gm-Message-State: AOJu0Yx52U+lhv/nHU7YTRot2PVqvLdhBsXyk6OxjSDVDO2fr7Z1QtjX
 DcoiY12eLL5BB+IjfsoGZtzdk7qByNdpCllZH6Wk/D6UTiAaRI5/Be4tMrfySMs=
X-Gm-Gg: ASbGncvojWt5co/Tyeu/Li8UHstLq+xtD80O4OG2Wp8QvdKgJr5b/78SpGXUIPosZyE
 70H9VpgL1MFfZtjkv50jQRSHUcj7Wc29GlzHCKXMcRpHiTD7npT4WEPBeJx0ZR0UuxgoT1y7tRV
 UqTZPlnsgxadDoPWquDcD14kevlHiPPKiMvM0Zw3UYnrYChelNP1iCitHeBzdaxnyP5qzJEAOx7
 WrUMx6nq/7jfQ88r5qmGHK5s7pNBx1M5Pn466EyT7BsW5BhlB21KwaNxbzH2z6aoxLFTzWEsH/Z
 ZmLyoXh22KG0E1Q=
X-Google-Smtp-Source: AGHT+IFszCnjt52kbULdM3w36hs6htWUZb7oe/pvfJ8Age8A78Y4dRby5GezoTKx7tH+uHdOXTS/OA==
X-Received: by 2002:a05:6808:22a0:b0:3eb:575e:3eaf with SMTP id
 5614622812f47-3f323a7780cmr5264438b6e.19.1738248629852; 
 Thu, 30 Jan 2025 06:50:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333523be4sm275210b6e.4.2025.01.30.06.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 06:50:28 -0800 (PST)
Date: Thu, 30 Jan 2025 08:50:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 E Shattow <e@freeshell.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] net: lwip: move eth_init() out of new_netif()
Message-ID: <20250130145026.GY1233568@bill-the-cat>
References: <20250130082226.1572302-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0L+woLc8NV6d9pYL"
Content-Disposition: inline
In-Reply-To: <20250130082226.1572302-1-jerome.forissier@linaro.org>
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


--0L+woLc8NV6d9pYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 09:22:20AM +0100, Jerome Forissier wrote:
> Move the initialization of the ethernet devices out of the new_netif()
> function. Indeed, new_netif() accepts a struct device argument, which
> is expected to be valid and active. The activation and selection of
> this device are achieved by eth_init() (on first time the network
> stack is used) and eth_set_current(). This is what takes care of the
> ethrotate and ethact environment variables. Therefore, move these calls
> to a new function: net_lwip_set_current(), and use it whenever a
> net-lwip command is run.
>=20
> This patch hopefully fixes the incorrect net-lwip behavior observed on
> boards with multiple ethernet interfaces [1].
>=20
> Tested on an i.MX8MPlus EVK equipped wih two ethernet ports. The dhcp
> command succeeds whether the cable is plugged into the first or second
> port.
>=20
> [1] https://lists.denx.de/pipermail/u-boot/2025-January/576326.html
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> CC: E Shattow <e@freeshell.de>

Reported-by: E Shattow <e@freeshell.de>

> ---
>  include/net-lwip.h  |  1 +
>  net/lwip/dhcp.c     |  2 +-
>  net/lwip/dns.c      |  2 +-
>  net/lwip/net-lwip.c | 23 ++++++++++++++---------
>  net/lwip/ping.c     |  2 +-
>  net/lwip/tftp.c     |  2 +-
>  net/lwip/wget.c     |  2 +-
>  7 files changed, 20 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 4d7f9387d1d..64e5c720560 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -10,6 +10,7 @@ enum proto_t {
>  	TFTPGET
>  };
> =20
> +void net_lwip_set_current(void);
>  struct netif *net_lwip_new_netif(struct udevice *udev);
>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
>  void net_lwip_remove_netif(struct netif *netif);
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index e7d9147455c..3b7e4700c6e 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -115,7 +115,7 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc=
, char *const argv[])
>  	int ret;
>  	struct udevice *dev;
> =20
> -	eth_set_current();
> +	net_lwip_set_current();
> =20
>  	dev =3D eth_get_dev();
>  	if (!dev) {
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 1de63c9998b..149bdb784dc 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -121,7 +121,7 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc,=
 char *const argv[])
>  	if (argc =3D=3D 3)
>  		var =3D argv[2];
> =20
> -	eth_set_current();
> +	net_lwip_set_current();
> =20
>  	return dns_loop(eth_get_dev(), name, var);
>  }
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index b863047f598..cab1dd7d483 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -127,6 +127,20 @@ static int get_udev_ipv4_info(struct udevice *dev, i=
p4_addr_t *ip,
>  	return 0;
>  }
> =20
> +/* Initialize the lwIP stack and the ethernet devices and set current de=
vice  */
> +void net_lwip_set_current(void)
> +{
> +	static bool init_done;
> +
> +	if (!init_done) {
> +		eth_init_rings();
> +		eth_init();
> +		lwip_init();
> +		init_done =3D true;
> +	}
> +	eth_set_current();
> +}
> +
>  static struct netif *new_netif(struct udevice *udev, bool with_ip)
>  {
>  	unsigned char enetaddr[ARP_HLEN];
> @@ -134,19 +148,10 @@ static struct netif *new_netif(struct udevice *udev=
, bool with_ip)
>  	ip4_addr_t ip, mask, gw;
>  	struct netif *netif;
>  	int ret =3D 0;
> -	static bool first_call =3D true;
> =20
>  	if (!udev)
>  		return NULL;
> =20
> -	if (first_call) {
> -		eth_init_rings();
> -		/* Pick a valid active device, if any */
> -		eth_init();
> -		lwip_init();
> -		first_call =3D false;
> -	}
> -
>  	if (eth_start_udev(udev) < 0) {
>  		log_err("Could not start %s\n", udev->name);
>  		return NULL;
> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
> index aa617530749..200a702bbb5 100644
> --- a/net/lwip/ping.c
> +++ b/net/lwip/ping.c
> @@ -168,7 +168,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc=
, char *const argv[])
>  	if (!ipaddr_aton(argv[1], &addr))
>  		return CMD_RET_USAGE;
> =20
> -	eth_set_current();
> +	net_lwip_set_current();
> =20
>  	if (ping_loop(eth_get_dev(), &addr) < 0)
>  		return CMD_RET_FAILURE;
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index fc4aff5f2ba..123d66b5dba 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -280,7 +280,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int arg=
c, char *const argv[])
>  		goto out;
>  	}
> =20
> -	eth_set_current();
> +	net_lwip_set_current();
> =20
>  	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>  		ret =3D CMD_RET_FAILURE;
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b76f6c0f1d9..9aec75f9bed 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -354,7 +354,7 @@ static int wget_loop(struct udevice *udev, ulong dst_=
addr, char *uri)
> =20
>  int wget_do_request(ulong dst_addr, char *uri)
>  {
> -	eth_set_current();
> +	net_lwip_set_current();
> =20
>  	if (!wget_info)
>  		wget_info =3D &default_wget_info;
> --=20
> 2.43.0
>=20

--=20
Tom

--0L+woLc8NV6d9pYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebkbIACgkQFHw5/5Y0
tywNcAwAjnsOivuKRgCVhZ+XNFc6FUIOnHr9se7NqlSLLUPiAflSVn+xnjdyiJ29
l3G5koYVmwa0WT8WK3qezMRWwhHibcxKxZ6tddOSVltYBaeIvZhKWm/iFSpHDjDR
rPuiE8rOiCKdWGU10iFkmjKbgJ3LNiXLfZ4qn8cYqTrASrCMV3gd55UMJYKUvIA/
G89Pq1lKw8iSIzTSJpOqYdhXeNv8gLkRthJBvmW1NrseDBPu+jJjPhwR6nAQzsoV
nAseFzw+2WF052K8bcUX7SPmnJ+5WcWFXwI1cc4IWfsUdJbf72JB4Mk8+IXLnI6M
ffAB82zeQZULwzHyFGOJgXtJrWFrCltOeNB/TmWl1OAaDkTxj2MsqkGYn5dFK7KP
p2tSAp10HiWvHLBLjqjJ7nB2covNBt0lNzoO0aBEJeY4gWaqY8lVElIymqQVurZn
wsJohnHalAIIs+KdNdjnW4Sm9meKjhNMja6SxrJ6BzLS9Bllyb2MLqaiuxa9n+mj
/5EmWMSH
=yLbr
-----END PGP SIGNATURE-----

--0L+woLc8NV6d9pYL--
