Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C266CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 16:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A72580107;
	Tue, 23 Sep 2025 18:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="odYCCwnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D58F800B6; Tue, 23 Sep 2025 18:55:53 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E172C80C93
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 18:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74526ca79beso4884314a34.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758646549; x=1759251349; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=btR2TGFmHcvFul791ihZxCh8n3TpfkpQS5noFHwlarM=;
 b=odYCCwnz+2Te0N0AMKXGJdXp1BZQ0zezv4KXZy8D/v5ztGfuKaxwi3hNskqWIFlOOC
 XUWT40w/5WwjO5WeydFE4klU9N40HsrhurTNar6mBsv+8uNOT2witD3mdR+4Z0EcjmtT
 fc4mM+okctLqL9upSvpnF0nM9fspafhANp2QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758646549; x=1759251349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btR2TGFmHcvFul791ihZxCh8n3TpfkpQS5noFHwlarM=;
 b=EJWKa+SmKAB/y2mEd9H88ofTcb/P0nm7NsGnmjuuaZMA0JWcGr3El5llsqKGKI+vfv
 4BF1qHy1VnNsbW7GTibzrcl+jMM6hEis4wk7kOSJulFZjiqZXYMuV7onawHmOX/6yanB
 rR5is6mJS7uO5Bel5a+1AnC/d2vxEChgQGkk4Sn6+EKUy3P8ctjx/dj+BSKSxAIRUCTg
 FTDUZiMu2zkFc1Sg/fcCE/sWoj8jZysN4f7EnS55ekebsZRteuI7zNPk39IF8/oGFEK4
 UZScPM2Ot1+fRJYsq+/tlaT3/ikgO2O1f8T4v9VMoo7iyDS5YbaUjRxywkRdQAZ9ju6M
 kzhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTG2otJ9RxLEJtmBQwrnjdL7reS4C6dqWr7QIxG88hqUhlQ/AqTxxcZmoDuduXStkS9AFyVI=@lists.denx.de
X-Gm-Message-State: AOJu0YyTpje3KvdA5sRR4k8unYnwfNlB1BVSvBVeOSspPGF+Bl5o4fYZ
 E5MGt1txITIfxXGXI0+nLocl9wBR/OLyb6NIWw6SA7DGfwbS/luqe75XeWp1IEABDcl7o5IGByg
 0Ypxe0B4=
X-Gm-Gg: ASbGncv+3yfNPYJMA4s8JM0UdBCMG7WoIFSSen3d16CVvXJBMHiHpYqMWNaUbsv56As
 sSP4oI5Kx4u1Ppa6Q9DZ8RrHAHFQBL85izmOIgYhKR4wRNAYylHSaAP26NGc9x+QQ/JJYBFUvH+
 x1qZjMlFZfsI30dPDwRlAWzmbNmECkt1Yjdg2YQm8Iyl2tsIuTaLWDkwyzaXKSCleVPZZof5gK4
 hfY0Xi0BLTZCs5tYq4En4jRZZkF3PKvmnB5mVVdrybT3TtwbQp7Qrs6SFt6IMBwBc/HkZN/yi/4
 IXj7MB3nV3li/07S5l6XRDGG3to04pOufDgZEVdz64+EFpoeCED1tQybr+hFAR1SJ0i9e1UbqGX
 zGk4Et4uCDICg7Ei1w5d4N0bpqqfN1NmzQV8zNFtiqEYk8SrDHPvEWCDZoOo7N8dkDUs=
X-Google-Smtp-Source: AGHT+IHyt+gSyuJ184ovm0T1Pnj3zA2CZwpYlN4UpisapOhhWgJmcZvXIUYv8o9ApGQdvwZ/ij6ruw==
X-Received: by 2002:a05:6808:211d:b0:438:241b:e8c7 with SMTP id
 5614622812f47-43f2d4f9ce0mr2296814b6e.45.1758646549520; 
 Tue, 23 Sep 2025 09:55:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c85d269sm6049271b6e.23.2025.09.23.09.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 09:55:48 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:55:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] bootstd: make it possible to use tftp for netboot
 with standardboot
Message-ID: <20250923165546.GA197373@bill-the-cat>
References: <20250923-ip_dyn_bootstd-v2-1-eb59a788e647@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+20zMq5AJL2eJQJ"
Content-Disposition: inline
In-Reply-To: <20250923-ip_dyn_bootstd-v2-1-eb59a788e647@phytec.de>
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


--d+20zMq5AJL2eJQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 03:43:09PM +0200, Benjamin Hahn wrote:

> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
>=20
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v2:
> - fix build error when CONFIG_CMD_TFTPBOOT is not activated
> - Link to v1: https://lore.kernel.org/r/20250911-ip_dyn_bootstd-v1-1-74f7=
4507cc18@phytec.de
> ---
>  boot/bootmeth_script.c           |  8 ++++++++
>  cmd/net.c                        | 18 ++++++++++++++++++
>  doc/develop/bootstd/overview.rst |  4 ++++
>  doc/develop/bootstd/script.rst   |  6 ++++--
>  include/net-common.h             |  8 ++++++++
>  5 files changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 020cb8a7aec0..fd15b1ac1a20 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -129,7 +129,15 @@ static int script_read_bootflow_net(struct bootflow =
*bflow)
>  	if (!fname)
>  		return log_msg_ret("dhc", -EINVAL);
> =20
> +#ifdef CONFIG_CMD_TFTPBOOT
> +	if (env_get_yesno("ip_dyn") =3D=3D 0)
> +		ret =3D tftpb_run(addr, fname);
> +	else
> +		ret =3D dhcp_run(addr, fname, true);
> +#else
>  	ret =3D dhcp_run(addr, fname, true);
> +#endif /* CONFIG_CMD_TFTPBOOT */

This is a case where IS_ENABLED(CONFIG..) is helpful as we can do:
if (IS_ENABLED(CONFIG_CMD_TFTPBOOT) && env_get_yesno("ip_dyn") =3D=3D 0)
	ret =3D tftpb_run(addr, fname);
else
	ret =3D dhcp_run(addr, fname, true);

And when CONFIG_CMD_TFTPBOOT isn't set the compiler optimizes this to
just the dhcp_run call.

--=20
Tom

--d+20zMq5AJL2eJQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNLRCwAKCRAr4qD1Cr/k
CuP7APoDJuOUrUmvmg4PTqZoQBGLov06gRidCmnsGgZlhw4F7QEA3CHOQahjJbC2
Z1BmpfEz7F9TLeCCmw290+ETPoxzhgY=
=ES//
-----END PGP SIGNATURE-----

--d+20zMq5AJL2eJQJ--
