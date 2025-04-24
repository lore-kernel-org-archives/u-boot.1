Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017E5C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 07:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E97E809D4;
	Thu, 24 Apr 2025 09:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="AjBmxU/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B74D80FA8; Thu, 24 Apr 2025 09:14:28 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F7C809A5
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202503070814; t=1745478865;
 bh=R/2viONyL+Nhr34hsMLUpZxQeD288dS6U3bUXoqpFgg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AjBmxU/LfY/4fU8xseBE7HBwuFnAVjrweMnbJoWS/1RI5Py9veIduouHjEl69sweU
 3P79WnmEeyelobzgoqic3NI2J2U6xs4Co+459Sd8O1u0wIjCNvR0mq2w/bk1jMrU6M
 BgW9sFzJsWzlKqfU/3DIAGhhOaHy/cIqS6zkORkhUdY1sAuCT0W7HnxAzXXRDu8fF4
 ldqHyuf1PeLeI8QaQzgbdQyasD8mLIfYjC1c7M0AHNdw8LS8ZkBeCtsks8/0RxMwfg
 WB4WKV+zXYZ2JVlYeaU8GLmDQxTxzXsUIHj4SLbukFe2q7/AkHYeEtf5wb7GV/XFKb
 Prqq7yKrkT3Aw==
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id E6A9977289D2;
 Thu, 24 Apr 2025 09:14:24 +0200 (CEST)
Date: Thu, 24 Apr 2025 09:14:23 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Simon
 Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice
 Guo <alice.guo@nxp.com>, u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v10 13/21] spl: imx: use trampoline buffer to load
 images to secure region
Message-ID: <20250424091423.68e348d8@karo-electronics.de>
In-Reply-To: <20250424-imx95-v1-13-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
 <20250424-imx95-v1-13-10a8449b1e5e@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: +++
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

On Thu, 24 Apr 2025 14:33:09 +0800 Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> When SPL loading image to secure region, for example, ATF and tee to
> DDR secure region. Because the USDHC controller is non-secure master,
> it can't access this region and will cause loading issue.
>=20
> So use a trampoline buffer in non-secure region, then use CPU to copy the
> image from trampoline buffer to destination secure region.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/scmi/soc.c | 18 +++++++++++++++++
>  common/spl/Kconfig                |  6 ++++++
>  common/spl/spl_imx_container.c    | 41 +++++++++++++++++++++++++++++++++=
------
>  3 files changed, 59 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/s=
cmi/soc.c
> index 3a5bdddd785..d2b0455bff9 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -729,3 +729,21 @@ enum boot_device get_boot_device(void)
>  	return boot_dev;
>  }
>  #endif
> +
> +bool arch_check_dst_in_secure(void *start, ulong size)
> +{
> +	ulong ns_end =3D CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
> +#ifdef PHYS_SDRAM_2_SIZE
> +	ns_end +=3D PHYS_SDRAM_2_SIZE;
> +#endif
> +
> +	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
> +		return true;
> +
> +	return false;
> +}
> +
> +void *arch_get_container_trampoline(void)
> +{
> +	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
> +}
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 3282e08a754..a2b214f3d74 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -361,6 +361,12 @@ config SPL_LOAD_IMX_CONTAINER
>  	  Support booting U-Boot from an i.MX8 container image. If you are not
>  	  using i.MX8, say 'n'.
> =20
> +config SPL_IMX_CONTAINER_USE_TRAMPOLINE
> +	bool
> +	depends on SPL
> +	help
> +	  Enable SPL load reader to load data to a trampoline buffer.
> +
>  config IMX_CONTAINER_CFG
>  	string "i.MX8 Container config file"
>  	depends on SPL && SPL_LOAD_IMX_CONTAINER
> diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_containe=
r.c
> index 2c31777fcd3..6e6afec1ff3 100644
> --- a/common/spl/spl_imx_container.c
> +++ b/common/spl/spl_imx_container.c
[...]
> @@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_=
image_info *spl_image,
[...]
> +		if (info->read(info, offset, size,
> +			       map_sysmem(images[image_index].dst - overhead,
> +					  images[image_index].size)) <
> +		    images[image_index].size) {
> +				printf("%s: failed to load image to a non-secure region\n", __func__=
);
> +			return NULL;
> +		}
Strange indentation and rather unreadable code...
Since 'map_sysmem(images[image_index].dst - overhead, images[image_index].s=
ize)'
has been assigned to 'buf' before, this could be written as:
	if (info->read(info, offset, size, buf) < images[image_index].size) {
		printf("%s: failed to load image to a non-secure region\n", __func__);
		return NULL;
	}

Lothar Wa=C3=9Fmann
