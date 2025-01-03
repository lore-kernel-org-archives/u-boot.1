Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B2DE7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 14:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE46801A0;
	Fri,  3 Jan 2025 15:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aE2Z6p50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4848180295; Fri,  3 Jan 2025 15:55:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF33480196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 15:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735916129; x=1736520929; i=xypron.glpk@gmx.de;
 bh=hmc9iFRHLCCF49Db/HoCt/WXbMWs2jBQExKCOWVvODw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aE2Z6p509hDfJ2BCAVbXTYDfxvBZo9mSmG5U8CR7m39w4PC/UajVxnPQeBp2Alzm
 OBS2yLTiejDrTbs6OrP/HjVaAHhseJJIPsNq3b+5O6XrKyd487ZSVsmTSU6CYlBs+
 V7rsbwhYCfDgSHjVrK0f5Y0Mzh6Lgg8bpAuwQfNYti2s6k6tU35/tAwvb9GWfBOST
 RMYLmlYFyYM7ynCL8H9IhgA/sLIEtVrTmU0fWJKt6SqOlZEliF/lB5TrGxK8pjArZ
 GezRgkTDOsbRAayJbMbQMjsnccuaSK4JqX/Acw5dAJ+64MUgt3ka5Kzp+dtP3Be6B
 jQ1Y68oPMBY92/Q+ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1tTj5F17aq-000sTU; Fri, 03
 Jan 2025 15:55:29 +0100
Message-ID: <af1efc80-2b03-4e00-8b92-437f2bf3feee@gmx.de>
Date: Fri, 3 Jan 2025 15:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/67] boot: Rename fit_image_get_data()
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250101221003.1944600-14-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250101221003.1944600-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qmDf1jYijlYKg0EBEr3NJ5aDWr/sV99+05FMd0UQ0GU6raFCD7u
 IHdv/g0L3+6hHNKJWcQOwR74YDD5n+HjyBQAVy+sC0kKYvavHqvj1D8uOXv3BRxBDVpRJrU
 TF1O2KWZnh2dozxUmaloFjo0xsTAf1auUQspPDIZtdfWWN2KaPGoqV3klVbAwyzhvDwbSkf
 tHj+e+tYOpR3ZrOJPWR2Q==
UI-OutboundReport: notjunk:1;M01:P0:LZYd8mt26yw=;AK37jTfxf40KiPjTlJ70AnrXk1n
 olYrSaEwTwjtJWi+M1I39KUxP5fjknFJWc3Jik9Efzue6TvW1KuXMKD0fg2vIFxzRbAHTtDyL
 eKg766pyNH/PWKxGkBD528bldW0yAsNsEeZGuadCzsFK/72YDieR3fNITud7sheEJOWSs4F0g
 1e21seTnr7b3n2WLx3nsw8zrtZh0YeSvRCcT4FqK2TxYJQEA1uWNUtocPqYUca3WU/G11xTol
 Yh6lS0qn6tVooz1wLeiu2QXOUASb/TBTR8t9livy7M/Z6yVyxwydJHP0CInS2Tj7TLwZT+kUG
 zQql2XGoiCLhFpkbBV96IhgE7BJ4S40A3+UVzf6RjLIVZEfVyHcpzAGIWBmJAIQatts4emz+j
 UbmQdH1VWiTZPNUGyDkgQ6uIthseiGRCqXJKGH4B1fW6AtPq/11bF9ghE7lx1iXyzFAxJPBI7
 /fKeS2OBJ+XWJJrf5d0n188Wr9zMmTnZQEYrEvMCPhc4tHHpYBHR0IawT5f+fJRsItqS5CB5J
 Xn7YCjUXoQ1QfSJ3pnvXpoGu8EmYNUgawDjB4Fx7uyWMHY2L/0UC3TMgdnjiyd2OfBb0nlihH
 0ASre9YhG+jYUw4dpMatviPI2/+Mv/gBUwK8jtIHGxPk8JYfTAU4eAaxrWH8yWyhdWA+TJi0i
 bUpRZKjMG4xVrRoRRqUR5PIQ+5aJlklqAq1rOEbs7ECT2KCWgWVzQXPQUS+LMLqFRa9xmATzj
 7p4844NNtVAwK8nSGws1ZwEgBJTxZ4t1/TJ06RFJjYvndZ9eVNdVgOzzdy+RB8eZ1zgdZQ18p
 h1Z0rYU/r3UbEwGphv5cctxDfBEcgwk1TG4GlrjPDDTUrN3816A3K/ZMw5fQ2hkSjgUYcmG/y
 tBy54QDU+fSv7Fu0hktaGn/l6lmafkhb5oONASPTAK9xA+m72caZBIQW0yNpL2IjeVgy6xWcr
 xWssyQD09ehXrOFU3WwYfJWUodYdfHAkQJltNLYnhOSB/kWdu7dGI4U/aNXan//pCETZ97NHi
 bscI4+MmErmFRDhysVNMbJ0ZwKhpWyAOHkI1WvtDEtZ5Uc7SHhJT0idMMhbeHi/AQAQh9Tdeq
 YrNmBOwqCTSy98qVJC3PsDvDaD+C9R
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

On 01.01.25 23:08, Simon Glass wrote:
> This function can only be used with FITs that use embedded data. Rename
> it so this is clear.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   arch/arm/cpu/armv8/sec_firmware.c  |  4 ++--
>   arch/arm/mach-k3/r5/sysfw-loader.c |  2 +-
>   arch/x86/lib/bootm.c               |  6 +++---
>   boot/image-fit.c                   | 10 +++++-----
>   common/spl/spl_fit.c               |  2 +-
>   common/splash_source.c             |  4 +++-
>   common/update.c                    |  2 +-
>   include/image.h                    |  4 ++--
>   tools/image-host.c                 |  4 ++--
>   9 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_=
firmware.c
> index 44372cbe4a1..b7c73f288bd 100644
> --- a/arch/arm/cpu/armv8/sec_firmware.c
> +++ b/arch/arm/cpu/armv8/sec_firmware.c
> @@ -128,8 +128,8 @@ static int sec_firmware_check_copy_loadable(const vo=
id *sec_firmware_img,
>   			return -EINVAL;
>   		}
>
> -		if (fit_image_get_data(sec_firmware_img, ld_node_off,
> -				       &data, &size)) {
> +		if (fit_image_get_emb_data(sec_firmware_img, ld_node_off,
> +					   &data, &size)) {
>   			printf("SEC Loadable: Can't get subimage data/size");
>   			return -ENOENT;
>   		}
> diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sy=
sfw-loader.c
> index 188731e673d..c323d2f78f8 100644
> --- a/arch/arm/mach-k3/r5/sysfw-loader.c
> +++ b/arch/arm/mach-k3/r5/sysfw-loader.c
> @@ -115,7 +115,7 @@ static int fit_get_data_by_name(const void *fit, int=
 images, const char *name,
>   	if (node_offset < 0)
>   		return -ENOENT;
>
> -	return fit_image_get_data(fit, node_offset, addr, size);
> +	return fit_image_get_emb_data(fit, node_offset, addr, size);
>   }
>
>   static void k3_start_system_controller(int rproc_id, bool rproc_loaded=
,
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 5fb46112ccb..3305560aa06 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -106,9 +106,9 @@ static int boot_prep_linux(struct bootm_headers *ima=
ges)
>   		is_zimage =3D 1;
>   #if defined(CONFIG_FIT)
>   	} else if (images->fit_uname_os && is_zimage) {
> -		ret =3D fit_image_get_data(images->fit_hdr_os,
> -				images->fit_noffset_os,
> -				(const void **)&data, &len);
> +		ret =3D fit_image_get_emb_data(images->fit_hdr_os,
> +					     images->fit_noffset_os,
> +					     (const void **)&data, &len);
>   		if (ret) {
>   			puts("Can't get image data/size!\n");
>   			goto error;
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 7d56f0b5e6e..4b116ba5891 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -902,13 +902,13 @@ int fit_image_get_entry(const void *fit, int noffs=
et, ulong *entry)
>   }
>
>   /**
> - * fit_image_get_data - get data property and its size for a given comp=
onent image node
> + * fit_image_get_emb_data - get data property and its size for a given =
component image node
>    * @fit: pointer to the FIT format image header
>    * @noffset: component image node offset
>    * @data: double pointer to void, will hold data property's data addre=
ss
>    * @size: pointer to size_t, will hold data property's data size
>    *
> - * fit_image_get_data() finds data property in a given component image =
node.
> + * fit_image_get_emb_data() finds data property in a given component im=
age node.
>    * If the property is found its data start address and size are return=
ed to
>    * the caller.
>    *
> @@ -916,8 +916,8 @@ int fit_image_get_entry(const void *fit, int noffset=
, ulong *entry)
>    *     0, on success
>    *     -1, on failure
>    */
> -int fit_image_get_data(const void *fit, int noffset,
> -		const void **data, size_t *size)
> +int fit_image_get_emb_data(const void *fit, int noffset, const void **d=
ata,
> +			   size_t *size)
>   {
>   	int len;
>
> @@ -1074,7 +1074,7 @@ int fit_image_get_data_and_size(const void *fit, i=
nt noffset,
>   			*size =3D len;
>   		}
>   	} else {
> -		ret =3D fit_image_get_data(fit, noffset, data, size);
> +		ret =3D fit_image_get_emb_data(fit, noffset, data, size);
>   	}
>
>   	return ret;
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 3160f573bfb..097c731d9a3 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -282,7 +282,7 @@ static int load_simple_fit(struct spl_load_info *inf=
o, ulong fit_offset,
>   		src =3D src_ptr + overhead;
>   	} else {
>   		/* Embedded data */
> -		if (fit_image_get_data(fit, node, &data, &length)) {
> +		if (fit_image_get_emb_data(fit, node, &data, &length)) {
>   			puts("Cannot get image data/size\n");
>   			return -ENOENT;
>   		}
> diff --git a/common/splash_source.c b/common/splash_source.c
> index f43e7cc1be7..5ac32a2f995 100644
> --- a/common/splash_source.c
> +++ b/common/splash_source.c
> @@ -396,7 +396,9 @@ static int splash_load_fit(struct splash_location *l=
ocation, u32 bmp_load_addr)
>
>   	/* Extract the splash data from FIT */
>   	/* 1. Test if splash is in FIT internal data. */
> -	if (!fit_image_get_data(fit_header, node_offset, &internal_splash_data=
, &internal_splash_size))
> +	if (!fit_image_get_emb_data(fit_header, node_offset,
> +				    &internal_splash_data,
> +				    &internal_splash_size))
>   		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data, inte=
rnal_splash_size);
>   	/* 2. Test if splash is in FIT external data with fixed position. */
>   	else if (!fit_image_get_data_position(fit_header, node_offset, &exter=
nal_splash_addr))
> diff --git a/common/update.c b/common/update.c
> index 6801b49479d..d149ca18e78 100644
> --- a/common/update.c
> +++ b/common/update.c
> @@ -200,7 +200,7 @@ static int update_fit_getparams(const void *fit, int=
 noffset, ulong *addr,
>   {
>   	const void *data;
>
> -	if (fit_image_get_data(fit, noffset, &data, (size_t *)size))
> +	if (fit_image_get_emb_data(fit, noffset, &data, (size_t *)size))
>   		return 1;
>
>   	if (fit_image_get_load(fit, noffset, (ulong *)fladdr))
> diff --git a/include/image.h b/include/image.h
> index de44dc09d07..e5241648b5e 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1196,8 +1196,8 @@ int fit_image_get_type(const void *fit, int noffse=
t, uint8_t *type);
>   int fit_image_get_comp(const void *fit, int noffset, uint8_t *comp);
>   int fit_image_get_load(const void *fit, int noffset, ulong *load);
>   int fit_image_get_entry(const void *fit, int noffset, ulong *entry);
> -int fit_image_get_data(const void *fit, int noffset,
> -				const void **data, size_t *size);
> +int fit_image_get_emb_data(const void *fit, int noffset, const void **d=
ata,
> +			   size_t *size);
>   int fit_image_get_data_offset(const void *fit, int noffset, int *data_=
offset);
>   int fit_image_get_data_position(const void *fit, int noffset,
>   				int *data_position);
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 5e01b853c50..007a94f72d5 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -574,7 +574,7 @@ int fit_image_cipher_data(const char *keydir, void *=
keydest,
>   	}
>
>   	/* Get image data and data length */
> -	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
> +	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
>   		fprintf(stderr, "Can't get image data/size\n");
>   		return -1;
>   	}
> @@ -654,7 +654,7 @@ int fit_image_add_verification_data(const char *keyd=
ir, const char *keyfile,
>   	int noffset;
>
>   	/* Get image data and data length */
> -	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
> +	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
>   		fprintf(stderr, "Can't get image data/size\n");
>   		return -1;
>   	}

