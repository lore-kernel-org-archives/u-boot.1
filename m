Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377BEC021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 11:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D9780F67;
	Sun, 23 Feb 2025 12:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="aU/2N3En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5D880FB6; Sun, 23 Feb 2025 12:36:44 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBEA80087
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 12:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Z11zW0gqZz9wPY;
 Sun, 23 Feb 2025 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1740310599; bh=9J81Nmauvf0BE3OXuioJMl1giksef9/2MZczs7ArJVM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aU/2N3EnR75CH94WzVNeCF+0w2GgX9iThjZIFvvPPY0X7Z+54GE6MGzeWp07kc17q
 kGOO23gE6aiN7lrqkS395Kxm3+tXWY7ZB4g4jwKt3Dl3qGov0xewEZCL8/ueP6ViAs
 k5iiFk+crtZBczto7r8pGwZ9htMPe54cVykzwv5M=
X-Riseup-User-ID: 923EB398D5CC784779B9BFD5F14D238041C971AF64B5C0C0ECFDDBB3EFFA2BB6
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Z11z94nFZzJmwh;
 Sun, 23 Feb 2025 11:36:21 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Heiko Schocher <hs@denx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas =?UTF-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 1/3] video: bridge-uclass: add get_display_timing ops
Date: Sun, 23 Feb 2025 11:36:09 +0000
Message-ID: <7027183.31r3eYUQgx@melttower>
In-Reply-To: <20250220170629.228485-2-clamor95@gmail.com>
References: <20250220170629.228485-1-clamor95@gmail.com>
 <20250220170629.228485-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Works with Rockchip DW MIPI DSI bridge (drivers/video/rockchip/
dw_mipi_dsi_rockchip.c) after I add ops to the driver.

Tested-by: Dang Huynh <danct12@riseup.net> (PineTab 2)

On Thursday, February 20, 2025 5:06:27=E2=80=AFPM UTC Svyatoslav Ryhel wrot=
e:
> Add get_display_timing ops for internal bridges linked to
> panels that do not support EDID (MIPI-DSI panels for example)
> or have EDID not routed.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
>  include/video_bridge.h                     | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/video/bridge/video-bridge-uclass.c
> b/drivers/video/bridge/video-bridge-uclass.c index 2084a2e03ee..1b8aa12b9=
e8
> 100644
> --- a/drivers/video/bridge/video-bridge-uclass.c
> +++ b/drivers/video/bridge/video-bridge-uclass.c
> @@ -33,6 +33,17 @@ int video_bridge_attach(struct udevice *dev)
>  	return ops->attach(dev);
>  }
>=20
> +int video_bridge_get_display_timing(struct udevice *dev,
> +				    struct display_timing=20
*timings)
> +{
> +	struct video_bridge_ops *ops =3D video_bridge_get_ops(dev);
> +
> +	if (!ops->get_display_timing)
> +		return -ENOSYS;
> +
> +	return ops->get_display_timing(dev, timings);
> +}
> +
>  int video_bridge_check_attached(struct udevice *dev)
>  {
>  	struct video_bridge_priv *uc_priv =3D dev_get_uclass_priv(dev);
> diff --git a/include/video_bridge.h b/include/video_bridge.h
> index 3b429eac578..7158deb299a 100644
> --- a/include/video_bridge.h
> +++ b/include/video_bridge.h
> @@ -53,6 +53,19 @@ struct video_bridge_ops {
>  	 */
>  	int (*set_backlight)(struct udevice *dev, int percent);
>=20
> +	/**
> +	 * get_display_timing() - Get display timings from bridge.
> +	 *
> +	 * @dev:	Bridge device containing the linked display timings
> +	 * @tim:	Place to put timings
> +	 * @return 0 if OK, -ve on error
> +	 *
> +	 * This call it totally optional and useful mainly for integrated
> +	 * bridges with fixed output device.
> +	 */
> +	int (*get_display_timing)(struct udevice *dev,
> +				  struct display_timing *timing);
> +
>  	/**
>  	 * read_edid() - Read information from EDID
>  	 *
> @@ -98,6 +111,14 @@ int video_bridge_set_active(struct udevice *dev, bool
> active); */
>  int video_bridge_check_attached(struct udevice *dev);
>=20
> +/**
> + * video_bridge_get_display_timing() - Get display timings from bridge.
> + *
> + * @dev:	Bridge device containing the linked display timings
> + * Return: 0 if OK, -ve on error
> + */
> +int video_bridge_get_display_timing(struct udevice *dev,
> +				    struct display_timing=20
*timing);
>  /**
>   * video_bridge_read_edid() - Read information from EDID
>   *




