Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC4D715E5
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 14:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410F883BC8;
	Sat, 24 Jan 2026 15:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XOalBU1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE79983B85; Sat, 24 Jan 2026 12:35:26 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658F283B63
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 12:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benjamin.robin@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DFDEF4E42247;
 Sat, 24 Jan 2026 11:35:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B428C60760;
 Sat, 24 Jan 2026 11:35:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AFE6119A8618; Sat, 24 Jan 2026 12:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769254523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+bvH+/7zagji1hN0JFp0QXzXqtGCqrvBw0g5wBnOgwk=;
 b=XOalBU1CGlK7mWYqEIfRbS7QS0JE1iVrx0nuDLaghKesXbrvkmoJBvHxb+NiZYXUygXDyC
 6kZvVbU0IAATOTyS4VFCOaeG1taTGi9sC+YNpTt56UsXOh0tGtYXMEr6yaHpLgy5/b50gs
 vew0ORMp1sxeWFGehjqoB1MTChixcLEUiTj6p18nDrZvKyw/2ViLPKffZwru0nM8o/iHeU
 MAx3ELpcjHrsHba3CtXsbvpzxaY0bN/5g5VTm3X8qzZKhuFe6XShfQeuuv7+Zwf4aGf+2f
 WeMCvijQ62vzjLGid/i/Nsw4BbiVSQeAjxRXROvpGwfnp+kAMA8gp2RSbifQ5A==
From: Benjamin ROBIN <benjamin.robin@bootlin.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] env: add w flags for net config in explicit write mode
Date: Sat, 24 Jan 2026 12:35:19 +0100
Message-ID: <2397776.ElGaqSPkdT@brobin-bootlin>
In-Reply-To: <20260124054040.7597-1-hs@nabladev.com>
References: <20260124054040.7597-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 24 Jan 2026 15:35:21 +0100
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

Hello,

On Saturday, January 24, 2026 at 6:40=E2=80=AFAM, Heiko Schocher wrote:
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>=20
> In explicit write access mode (CONFIG_ENV_WRITEABLE_LIST) the
> environment variables listed in NET_FLAGS and NET6_FLAGS are
> probably intended to be writeable. Therefore add the 'w' flag
> to these variables.

Users who enable CONFIG_ENV_WRITEABLE_LIST typically want full control over=
=20
which environment variables are writable. The new default behavior introduc=
ed=20
by your patch might not align with what all users expect or want.

Would overriding the flags using CFG_ENV_FLAGS_LIST_STATIC not work in this=
=20
case?

> diff --git a/include/env_flags.h b/include/env_flags.h
> index 0c48874690f..fc65dcaba21 100644
> --- a/include/env_flags.h
> +++ b/include/env_flags.h
> @@ -56,6 +56,16 @@ enum env_flags_varaccess {
>  #define ETHADDR_FLAGS "eth" ETHADDR_WILDCARD "addr:mo,"
>  #endif
>  #endif
> +#ifdef CONFIG_ENV_WRITEABLE_LIST
> +#define NET_FLAGS \
> +	"ipaddr:iw," \
> +	"gatewayip:iw," \
> +	"netmask:iw," \
> +	"serverip:iw," \
> +	"nvlan:dw," \
> +	"vlan:dw," \
> +	"dnsip:iw,"
> +#else
>  #define NET_FLAGS \
>  	"ipaddr:i," \
>  	"gatewayip:i," \
> @@ -64,16 +74,24 @@ enum env_flags_varaccess {
>  	"nvlan:d," \
>  	"vlan:d," \
>  	"dnsip:i,"
> +#endif
>  #else
>  #define ETHADDR_FLAGS
>  #define NET_FLAGS
>  #endif
>=20
>  #ifdef CONFIG_IPV6
> +#ifdef CONFIG_ENV_WRITEABLE_LIST
> +#define NET6_FLAGS \
> +	"ip6addr:sw," \
> +	"serverip6:sw," \
> +	"gatewayip6:sw,"
> +#else
>  #define NET6_FLAGS \
>  	"ip6addr:s," \
>  	"serverip6:s," \
>  	"gatewayip6:s,"
> +#endif
>  #else
>  #define NET6_FLAGS
>  #endif

Best regards,
=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



