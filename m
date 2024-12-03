Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153B1E64A80
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 11:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F34589345;
	Tue,  3 Dec 2024 12:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h5X21bfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E606A8963B; Tue,  3 Dec 2024 12:47:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9AD89048
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 12:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733226415; x=1733831215; i=xypron.glpk@gmx.de;
 bh=K09qpVjSXvUAbK2WcEwIDZ+G/kxvlVDH6HBro/f5n54=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h5X21bfAeDvTEHDgMofpDXcrb7POh3U5Po9LNkn0EL4ZtlMu3FJaiTAXJRGzQTI3
 IihULtbhEXSPYD8FoWOjyLE7IOEnkoKXEaXpK7uz7Zs8pTPQzHogptbnX6BkF6xIw
 8Vehm1YaoSorGBl+UL2sWeTP+n6MB+i1OnMToFL4sSjN1L3oZsPeU9kWkSdMluwjO
 0EyMvqoZgEq/xLQUIdyb9GqW3FBd35Pcwe99ObDzPlHLsnX+xBUr17/4tzyJnlTJF
 fmUGRMBzwO4v9QtahC2AJXdXmLEINRIYrZWEgTISiK9LAdgiiriHzXIcT7v9QfJ4c
 HS6jgK2z6X6QpxiE8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1tMIzE43wQ-006PgJ; Tue, 03
 Dec 2024 12:46:55 +0100
Message-ID: <c8982185-bbb6-4d50-84d0-771af91bdb02@gmx.de>
Date: Tue, 3 Dec 2024 12:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-9-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128144416.604126-9-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N/atH9tya/Qk2dBUqq/GHddiOx7h4F36TATB6KURpaCgDGOOkpa
 yEwUGz9eVoisdZRc3IHhR8YixuIEWMk5w+0WCov8i5wTFz+cV2I7oi2FPc35gIBJ9S7137E
 0Y4fJJaBN9p+qjxiqIIyZqOqS4VF7GxtIY1wOvYeYUFppHvW2B7F8rNm5Vrv3t0Y6JLuo/i
 WwaGi56FpmGwrNC+/U9dg==
UI-OutboundReport: notjunk:1;M01:P0:W7ZIoncNzmM=;gpGGWmpQQbuzWwQN8tOl2MRYsig
 /gB1SX5XGn3ISsLDn0DBdH9CVAHeWhxYwJ1AqT6IXjZ8dbqWKne9P2lauo1AsqKl0vDCrmczl
 Ng8bH7o9Gp5XMjsy9Hqz8tfFPHvXK+I231Rgs/UbFKtCYOZfbrN8AkOUKUxILdZ0GS4HrMc+J
 NWPlaYFetU1NY8XR77zQe7ngRznRIP8Smy3ldznKqr588PBxWFH8PX2HNPcbx+tgTfkIxjUye
 I2nOSvsiHa7KcdyShR1HcV1o7lCxX81KSokTC5nGRYLoRqAthNsaTYbUmbQC88YCiFyVglPuI
 iRv+Bdg1BCs1ga6fVzVtFYxqNHd3M+lmTQBsU7kmIChxxQcBvw4sQ0OveYju7HRk5J52l0HoS
 JaKiS1bG2hmfY3I3CNzJJDuhlK9AHkZyMq9yTwWR49wc//VZyXQQkolOObcvMz6hTBBMUTLou
 kgDxStSX6PX3KIMGNUQ5H315VrPhC3LyeribGExTftWJXaNSFDK0czXbiwdHUUAG6hD/vpJba
 z1NOmG2ALIusMYM6OvbGq9Yb1X7oneH3LeTiXLekj/5eWUfbXHdXQW4EuY1/RVevcMY/sSyE1
 RBzb7gbr2E9Z/djEMBDFsyuqj5Crk7TqDj5L6hDIkyVRCl2U5YNmgaQo6zIIph1eRQEPG0krQ
 y9Za9G3D0WchT9ysktGJkP89ueoJX62tmiB5m6UzBhn2pS5k0kdiwyTZN+Ud7D7u0/3LMyg4X
 yagUv+vpMjjIg30BeTglowezctVjLdoTW8IUweke+nImFRPblA1SSSBYET46NGaSdm3e3VzJT
 BPtosTT5r6xlVVw0PfTtRlFZ1GQkXq9bFJC2guF9F5Y+P86aCK70Alj4Cog5UxyXJ2Ii5Z7v9
 silBZkOPH8fmK0FmA7lRIhimWKKNNgZe+REPrtWJ1+erKzvREzCPPsOISuyyX16ZZw/dP/YP0
 PvBrvrKPX2WQluwxyIocWvJ8sw7vZCZed/PQFA5yiM8m0oxgoLx7PXO6AW8OiTlj9KoPXmOF5
 ELPYGSKbOrQNKbGqVmASRfiBpX2mbJ1keis5U0e8YFz45tidgQnGx9nEPkzvTpZwaWFXUwwmJ
 pHaxMhgGiHbbzFFTkIHjdL61TjqvAI
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

On 28.11.24 15:44, Adriano Cordova wrote:
> Set the device path of the efi boot device to an HTTP device path
> (as formed by efi_dp_from_http) when the next boot stage is loaded
> using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
>
> When loaded from HTTP, the device path should account for it so that
> the next boot stage is aware (e.g. grub only loads its http stack if
> it itself was loaded from http, and it checks this from its device path)=
.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes in v6:
> - Add error handling to efi_net_set_dp and put it inside efi_set_bootdev=
,
>    reducing the number of calls to efi functions outside efi code.
> - Free net_dp before an update
> - Complete documentation for efi_net_get_dp. Error handling: returns NUL=
L on error
> Changes in v5:
> - Add description of net_dp
> - Change a void** for an efi_device_path**
> (no changes since v2)
>
>   include/efi_loader.h             |  5 +++
>   lib/efi_loader/efi_bootbin.c     | 40 +++++++++++++----------
>   lib/efi_loader/efi_device_path.c |  5 +--
>   lib/efi_loader/efi_net.c         | 55 +++++++++++++++++++++++++++++++-
>   net/lwip/wget.c                  |  5 ++-
>   net/wget.c                       |  2 +-
>   6 files changed, 89 insertions(+), 23 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 96b204dfc3..0da0248db4 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev,=
 const char *devnr,
>   #endif
>
>   #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> +/* Call this to update the current device path of the efi net device */
> +efi_status_t efi_net_set_dp(const char *dev, const char *server);
> +/* Call this to get the current device path of the efi net device */
> +void efi_net_get_dp(struct efi_device_path **dp);
>   void efi_net_get_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
> @@ -133,6 +137,7 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
>   #else
> +static inline void efi_net_get_dp(struct efi_device_path **dp) { }
>   static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
>   				     struct efi_ipv4_address *mask,
>   				     struct efi_ipv4_address *gw) { }
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0..f8d3ee0bcf 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -93,24 +93,32 @@ void efi_set_bootdev(const char *dev, const char *de=
vnr, const char *path,
>   	image_addr =3D buffer;
>   	image_size =3D buffer_size;
>
> +#if IS_ENABLED(CONFIG_NETDEVICES)
> +	ret =3D efi_net_set_dp(dev, devnr);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +#endif
> +
>   	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
> -	if (ret =3D=3D EFI_SUCCESS) {
> -		bootefi_device_path =3D device;
> -		if (image) {
> -			/* FIXME: image should not contain device */
> -			struct efi_device_path *image_tmp =3D image;
> -
> -			efi_dp_split_file_path(image, &device, &image);
> -			efi_free_pool(image_tmp);
> -		}
> -		bootefi_image_path =3D image;
> -		log_debug("- boot device %pD\n", device);
> -		if (image)
> -			log_debug("- image %pD\n", image);
> -	} else {
> -		log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
> -		efi_clear_bootdev();
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +
> +	bootefi_device_path =3D device;
> +	if (image) {
> +		/* FIXME: image should not contain device */
> +		struct efi_device_path *image_tmp =3D image;
> +
> +		efi_dp_split_file_path(image, &device, &image);
> +		efi_free_pool(image_tmp);
>   	}
> +	bootefi_image_path =3D image;
> +	log_debug("- boot device %pD\n", device);
> +	if (image)
> +		log_debug("- image %pD\n", image);
> +	return;
> +error:
> +	log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
> +	efi_clear_bootdev();
>   }
>
>   /**
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index a6d4300686..5eae6fd39c 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1185,8 +1185,9 @@ efi_status_t efi_dp_from_name(const char *dev, con=
st char *devnr,
>
>   		dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>   				     (uintptr_t)image_addr, image_size);
> -	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
> -		dp =3D efi_dp_from_eth();
> +	} else if (IS_ENABLED(CONFIG_NETDEVICES) &&
> +		   (!strcmp(dev, "Net") || !strcmp(dev, "Http"))) {
> +		efi_net_get_dp(&dp);
>   	} else if (!strcmp(dev, "Uart")) {
>   		dp =3D efi_dp_from_uart();
>   	} else {
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 3491d4c481..e8af2e3d95 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -16,6 +16,7 @@
>    */
>
>   #include <efi_loader.h>
> +#include <dm.h>
>   #include <malloc.h>
>   #include <vsprintf.h>
>   #include <net.h>
> @@ -32,6 +33,13 @@ static int rx_packet_idx;
>   static int rx_packet_num;
>   static struct efi_net_obj *netobj;
>
> +/*
> + * The current network device path. This device path is updated when a =
new
> + * bootfile is downloaded from the network. If then the bootfile is loa=
ded
> + * as an efi image, net_dp is passed as the device path of the loaded i=
mage.
> + */
> +static struct efi_device_path *net_dp;
> +
>   /*
>    * The notification function of this event is called in every timer cy=
cle
>    * to check if a new network packet has been received.
> @@ -902,8 +910,10 @@ efi_status_t efi_net_register(void)
>   			     &netobj->net);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> +	if (!net_dp)
> +		efi_net_set_dp("Net", NULL);
>   	r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> -			     efi_dp_from_eth());
> +			     net_dp);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   	r =3D efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_g=
uid,
> @@ -999,6 +1009,49 @@ out_of_resources:
>   	return EFI_OUT_OF_RESOURCES;
>   }
>
> +/**
> + * efi_net_set_dp() - set device path of efi net device
> + *
> + * This gets called to update the device path when a new boot
> + * file is downloaded
> + *
> + * @dev:	dev to set the device path from
> + * @server:	remote server address
> + * Return:	status code
> + */
> +efi_status_t efi_net_set_dp(const char *dev, const char *server)
> +{
> +	efi_free_pool(net_dp);
> +
> +	net_dp =3D NULL;
> +	if (!strcmp(dev, "Net"))
> +		net_dp =3D efi_dp_from_eth();
> +	else if (!strcmp(dev, "Http"))
> +		net_dp =3D efi_dp_from_http(server);
> +
> +	if (!net_dp)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_net_get_dp() - get device path of efi net device
> + *
> + * Produce a copy of the current device path
> + *
> + * @dp:		copy of the current device path, or NULL on error
> + */
> +void efi_net_get_dp(struct efi_device_path **dp)
> +{
> +	if (!dp)
> +		return;
> +	if (!net_dp)
> +		efi_net_set_dp("Net", NULL);
> +	if (net_dp)
> +		*dp =3D efi_dp_dup(net_dp);
> +}
> +
>   /**
>    * efi_net_get_addr() - get IP address information
>    *
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 2becb02f7b..fcc0e62512 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -260,10 +260,9 @@ static void httpc_result_cb(void *arg, httpc_result=
_t httpc_result,
>   	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
>   	print_size(rx_content_len / elapsed * 1000, "/s)\n");
>   	printf("Bytes transferred =3D %lu (%lx hex)\n", ctx->size, ctx->size)=
;
> -	if (wget_info->set_bootdev) {
> -		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0)=
,
> +	if (wget_info->set_bootdev)
> +		efi_set_bootdev("Http", ctx->server_name, ctx->path, map_sysmem(ctx->=
saved_daddr, 0),
>   				rx_content_len);
> -	}
>   	wget_lwip_set_file_size(rx_content_len);
>   	if (env_set_hex("filesize", rx_content_len) ||
>   	    env_set_hex("fileaddr", ctx->saved_daddr)) {
> diff --git a/net/wget.c b/net/wget.c
> index f3b43b06b8..d338eaf4ef 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -447,7 +447,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>   		net_set_state(wget_loop_state);
>   		wget_info->file_size =3D net_boot_file_size;
>   		if (wget_info->method =3D=3D WGET_HTTP_METHOD_GET && wget_info->set_=
bootdev) {
> -			efi_set_bootdev("Net", "", image_url,
> +			efi_set_bootdev("Http", NULL, image_url,
>   					map_sysmem(image_load_addr, 0),
>   					net_boot_file_size);
>   			env_set_hex("filesize", net_boot_file_size);

