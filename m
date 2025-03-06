Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0583C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9D581249;
	Thu,  6 Mar 2025 06:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB11980805; Thu,  6 Mar 2025 06:51:05 +0100 (CET)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CEA980BAA
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id BB265772172F;
 Thu,  6 Mar 2025 06:51:02 +0100 (CET)
Date: Thu, 6 Mar 2025 06:51:02 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, marex@denx.de, u-boot@lists.denx.de
Subject: Re: [PATCH v7 15/19] tools: imx8image: add i.MX95 support
Message-ID: <20250306065102.4b76491e@karo-electronics.de>
In-Reply-To: <20250305-imx95-v1-15-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-15-286d15acbb8a@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /
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

Hi,

On Wed, 05 Mar 2025 21:28:27 +0800 Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
>=20
> i.MX95 uses binman to invoke mkimage to create image container. 2 image
> containers are needed currently. The first one is composed of
> ahab-container.img, LPDDR firmware images, OEI images, System Manager
> image and u-boot-spl.bin. The second one is consisted of ARM Trusted
> firmware and u-boot.bin.
>=20
> Because DDR OEI image and LPDDR firmware images have to be packaged
> together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
> not check if m33-oei-ddrfw.bin exists.
>=20
> When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
> delete the line for u-boot.bin in container.cfg. In fact, binman is
> always called after the u-boot.bin is built, so imx9_image.sh does not
> check if u-boot.bin exists.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  include/imx8image.h |  19 +++++--
>  tools/imx8image.c   | 143 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  tools/imx9_image.sh |   8 +++
>  3 files changed, 153 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/imx8image.h b/include/imx8image.h
> index 6b95e93fb5..b48e2b0396 100644
> --- a/include/imx8image.h
> +++ b/include/imx8image.h
> @@ -157,7 +157,9 @@ enum imx8image_cmd {
>  	CMD_SOC_TYPE,
>  	CMD_CONTAINER,
>  	CMD_IMAGE,
> -	CMD_DATA
> +	CMD_DATA,
> +	CMD_DUMMY_V2X,
> +	CMD_HOLD
add comma to facilitate extending the enum...

>  enum imx8image_core_type {
> @@ -169,7 +171,9 @@ enum imx8image_core_type {
>  	CFG_A35,
>  	CFG_A55,
>  	CFG_A53,
> -	CFG_A72
> +	CFG_A72,
> +	CFG_M33,
> +	CFG_OEI
dto.
> =20
>  enum imx8image_fld_types {
> @@ -208,7 +212,10 @@ typedef enum option_type {
>  	FILEOFF,
>  	MSG_BLOCK,
>  	SENTINEL,
> -	UPOWER
> +	UPOWER,
> +	OEI,
> +	DUMMY_V2X,
> +	HOLD
dto.

[...]
> diff --git a/tools/imx8image.c b/tools/imx8image.c
> index 0135b19095..94b1efacd1 100644
> --- a/tools/imx8image.c
> +++ b/tools/imx8image.c
> @@ -7,6 +7,7 @@
> =20
>  #include "imx8image.h"
>  #include <image.h>
> +#include <linux/sizes.h>
> =20
>  static int p_idx;
>  static int sector_size;
> @@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] =3D {
>  	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
>  	{CMD_IMAGE,             "IMAGE",                "new image",          },
>  	{CMD_DATA,              "DATA",                 "new data",           },
> +	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
> +	{CMD_HOLD,              "HOLD",                 "hold",               },
>  	{-1,                    "",                     "",	              },
>  };
> =20
the list terminator entry should not have a comment at the end, since
it MUST ALWAYS be the last entry.
Without comma adding an entry after the terminator (e.g. when resolving
a merge conflict) will lead to a compile error.
Otherwise adding an entry after the terminator would go unnoticed.

> @@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] =3D {
>  	{CFG_A55,	"A55",			"A55 core",	},
>  	{CFG_A53,	"A53",			"A53 core",	},
>  	{CFG_A72,	"A72",			"A72 core",	},
> +	{CFG_OEI,	"OEI",			"OEI", },
> +	{CFG_M33,	"M33",			"M33 core", },
>  	{-1,		"",			"",		},
>  };
> =20
dto.


Lothar Wa=C3=9Fmann
