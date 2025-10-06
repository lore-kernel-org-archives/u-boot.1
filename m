Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0108DCAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 08:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876EC831D6;
	Mon,  6 Oct 2025 10:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="z0hlMbHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6D483327; Mon,  6 Oct 2025 10:45:13 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC64A82E34
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 10:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 47F2D4E40F13;
 Mon,  6 Oct 2025 08:45:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17ED8606B7;
 Mon,  6 Oct 2025 08:45:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7682F102F197D; 
 Mon,  6 Oct 2025 10:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759740309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Mz2WUPpFZ15h/N0qiuPXiFL1BwAxUTgxZCs8ljba8gM=;
 b=z0hlMbHfk2voQdKlv4QTuwXt1aA/egxDG7bA82kl7tSukcgRTWm29I1KdLq4FmHuuHFKdu
 /eixz/l1ESJYkiO0dEvtU9dbizqbHCIcJxmGBJ0oEAdNqKHn7VbrOoxOJBr0WtDKEKMlBD
 K3xMwKpelAMxcAfPJ1lkAuvwpU6bWp3eRUMRVpXm6Q6HE6w6TbF+qA+twMbb4UB3ryPkDs
 T4OOmVGpnujF76pw9foaOnnYe75VLoXSbRlrCJYJm4mFrbIj7d6s5Pkx+7uUU49y/n2eRO
 3eFsriQBr4YMxCKbqI5fdJeWkicPLLPhMTBbGBbRwnh9A8jRCK4QL6VUSy8vjg==
Date: Mon, 6 Oct 2025 10:44:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jagan
 Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 07/16] board: sunxi: Refactor CHIP board extension code
Message-ID: <20251006104456.55252350@kmaincent-XPS-13-7390>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-7-458b8bf85325@bootlin.com>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-7-458b8bf85325@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 03 Oct 2025 18:33:47 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Clean up and improve code structure in the sunxi CHIP board extension
> detection implementation.

It seems I forgot to build test CHIP_defconfig because there is a build err=
or
here.

pw-bot:cr

>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  board/sunxi/chip.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
> index 270af2506d2..ea0d3a56f5f 100644
> --- a/board/sunxi/chip.c
> +++ b/board/sunxi/chip.c
> @@ -42,13 +42,7 @@ struct dip_w1_header {
> =20
>  int extension_board_scan(struct list_head *extension_list)
>  {
> -	struct extension *dip;
> -	struct dip_w1_header w1_header;
>  	struct udevice *bus, *dev;
> -	u32 vid;
> -	u16 pid;
> -	int ret;
> -
>  	int num_dip =3D 0;
> =20
>  	sunxi_gpio_set_pull(SUNXI_GPD(2), SUNXI_GPIO_PULL_UP);
> @@ -60,6 +54,12 @@ int extension_board_scan(struct list_head *extension_l=
ist)
>  	}
> =20
>  	for_each_w1_device(bus, &dev) {
> +		struct dip_w1_header w1_header;
> +		struct extension *dip;
> +		u32 vid;
> +		u16 pid;
> +		int ret;
> +
>  		if (w1_get_device_family(dev) !=3D W1_FAMILY_DS2431)
>  			continue;
> =20
> @@ -90,8 +90,8 @@ int extension_board_scan(struct list_head *extension_li=
st)
> =20
>  		snprintf(dip->overlay, sizeof(dip->overlay),
> "dip-%x-%x.dtbo", vid, pid);
> -		strncpy(dip->name, w1_header.product_name, 32);
> -		strncpy(dip->owner, w1_header.vendor_name, 32);
> +		strlcpy(dip->name, w1_header.product_name,
> sizeof(dip->name));
> +		strlcpy(dip->owner, w1_header.vendor_name,
> sizeof(dip->owner)); list_add_tail(&dip->list, extension_list);
>  		num_dip++;
>  	}
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
