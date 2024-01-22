Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B665BC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 15:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA01A87872;
	Mon, 22 Jan 2024 16:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JZWOj12w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505B78793F; Mon, 22 Jan 2024 16:36:27 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F54877EC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 16:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5fc2e997804so27889707b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705937784; x=1706542584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H58wDkKGINfeZTsmjoo8tY/J253uCoZXQoC8r9TVrPM=;
 b=JZWOj12wwIszCMWClJW226WlQZZnzgwRsiZEwx+Pp+pbzA+1aDYFJ8+STWJy2f39tp
 UrT/x21mnNIsqD5I9GpMNEgPEYwr2sSbeNfnxEvz4a4NJa8z0o/Gg9JB6D5QyFbk6krw
 x0z7Yx4XGvziiW2TWIejD7o+DnLtIKfnddI2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705937784; x=1706542584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H58wDkKGINfeZTsmjoo8tY/J253uCoZXQoC8r9TVrPM=;
 b=abxdPF0bvtyI4wHE5wtPLgGULbly3IMB1WLXZpHNo2pV2+Grmc6K+Su77UZUwVmUK4
 m9/ZdG1IaY4fGSZA55ixVO0GZ1SJFuX8xKyu71Wltns2wD2Ae1f+2aElkv5BAlEQ9e0q
 fYgihdhWwNbzX264YChpATK6hofwbIND3ZqLUH1XRkbkyPe3azbvGsYxL+ZHhT8sUG4l
 RpY2segqr4gFIPojDwG3Aap098rC833QgVizGbNw/oIGblhmYGW/S08wGuZuw4ZmZBk/
 qJQuHPgpq8udnry4x1F40a5bktfYCZV8Xc3vkXjJyLhHruKMXAZ8aoymY+jlrd5wKr71
 0Mhg==
X-Gm-Message-State: AOJu0YxT+wycr33bKDMBSMlwepFb2ixQB/JGdCuKxHom2HUMnDtFwUpn
 5Y5y00Ur8U3VBsUePPW8QW6r4OpcZ1IIXIHOXIjPwiLdYD6J5dmNWLLjLOlqt8/c1mgHKu5vmbD
 o
X-Google-Smtp-Source: AGHT+IHoaozHhd6SUYji0HkDdfcV4Jnn5cHoBzFhl7m4p4JvFfwIVf5WLHGYDXHn56Q/d4HaMs3QUg==
X-Received: by 2002:a0d:fec1:0:b0:5ff:5d73:2fb1 with SMTP id
 o184-20020a0dfec1000000b005ff5d732fb1mr3879221ywf.93.1705937783915; 
 Mon, 22 Jan 2024 07:36:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 a126-20020a0dd884000000b005ffa3fa57f9sm2249948ywe.51.2024.01.22.07.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:36:23 -0800 (PST)
Date: Mon, 22 Jan 2024 10:36:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Tim Lunn <tim@feathertop.org>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/5] board: rockchip: Add Sonoff iHost board
Message-ID: <20240122153621.GK3652023@bill-the-cat>
References: <20240122124603.3341988-1-tim@feathertop.org>
 <20240122124603.3341988-4-tim@feathertop.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DN6Va/KjopDXmpKC"
Content-Disposition: inline
In-Reply-To: <20240122124603.3341988-4-tim@feathertop.org>
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


--DN6Va/KjopDXmpKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:46:01PM +1100, Tim Lunn wrote:

> Sonoff iHost is gateway device designed to provide a Smart Home Hub,
> it is based on Rockchip RV1126. There is also a version with 2GB RAM
> based off the RV1109 dual core SoC however this works with the same
> config as the RV1126 for uboot purposes.
[snip]
> diff --git a/include/configs/sonoff-ihost.h b/include/configs/sonoff-ihos=
t.h
> new file mode 100644
> index 0000000000..8ed5d78687
> --- /dev/null
> +++ b/include/configs/sonoff-ihost.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __SONOFF_IHOST_H
> +#define __SONOFF_IHOST_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=3Dserial\0" \
> +		"stderr=3Dserial\0"
> +
> +#include <configs/rv1126_common.h>
> +
> +#undef BOOT_TARGET_DEVICES
> +
> +#define BOOT_TARGET_DEVICES(func) \
> +	func(MMC, mmc, 0) \
> +	func(MMC, mmc, 1)
> +
> +#endif /*  __SONOFF_IHOST_H */

We should be using standard boot, which removes most of this, thanks.

--=20
Tom

--DN6Va/KjopDXmpKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWui3EACgkQFHw5/5Y0
tyzTLgv9Huk21UKTJfRozFVtE/DuRkdmMvtfRrdFZavx6AsSHYbVnTMt6QWOESU9
YWmk5FcEv5MCiTmft1p4SMITnoFBvE+lxbgbo/Gn3UfHpvFfHp2wAEiLtmbBZhtz
HkZlsriVxFHb7jtbZGLdNd139yRHzt1Ma67j5/Fs4HkkzkKpjDlh71wwg/pvDpL4
FKz41vxO60E9MO6fdg6vZ57dBBdtt0tVJb4yX8b3jmZ58WiAAVvhoZfDdmoHlLxy
TH2m+vGHuRJRE99DV8eBY+z5zkIpDEmRCXGTbsjbBGhcalBWXSBs9vNR9wOcI3DW
kuSGBP5fzouOXJt2dahidLjuxF6oRcua6oy87LBkEQQANWSh2AfiXEdXbqD6HdaM
lWVxlhY4pNQqq7z+ezwK7bsLHKRDFkr27xKhKZgdgMYcc+8pFldk234hk3fZwwOk
2yrhK7Y62LnfxdO8PMxwY8scFrML6xEuy1F68K43kLTn+qXV0tYBmOmGiFHec+jK
GD2dBbzb
=eoGD
-----END PGP SIGNATURE-----

--DN6Va/KjopDXmpKC--
