Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B407BC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 09:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2090E81E18;
	Tue, 15 Apr 2025 11:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m4mQlz2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9036E827C7; Tue, 15 Apr 2025 11:06:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CFE812BC
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744707970; x=1745312770; i=xypron.glpk@gmx.de;
 bh=WzLIoJSbIUeJTu/j3LMCid0XofHkbbIhvgXn1Et5I6U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m4mQlz2V9Gn7oKw8Wcbc9kot071OIniznYUhhvtnk2G/f2G1alPn/0AzVQ2eetNt
 TIq8EYc7f1cTKdPMif3dno6d/CmPD2SVMBDvwDn9hySgsO39BmL9TF3HkfHWvp1b1
 UHQ7mkIjdu+JPBZJbGFWZ3EkRLbQaoRH02NsYZ5s9/9itSg3KWPM4B1QRQqGrTD2n
 68sF8Dm66UNWz/Ix4+Scg2hjIXKBuami4mpHJZDc5I/kXYeNL34txIX3qvV/XoNf3
 lKueBS+LyUEjMwvxSUfgSvQ/Y9u3aTdTakeR86xoh9wFEhj5cyBdGLXfeLf4ro1Wk
 X6e7jShOBQet9yQa8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1tlAW839DN-00RzEE; Tue, 15
 Apr 2025 11:06:09 +0200
Message-ID: <949f734b-9af8-4f01-a6ab-568bd895329e@gmx.de>
Date: Tue, 15 Apr 2025 11:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] efi_loader: efi_net: Add http, ip4_config2, and pxe
 on demand
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 =trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-12-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311164758.421900-12-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nQ5G+OvA64hCoz6WLTOdJnVMHibbSdrxJCjlT6wny8zNyg4pXXj
 ZCaSS2Btc+3wx1pGRwYB5X6Qq0XdI/JSy9SsH12J0INt5bz9Yj9KCipTDX4IsDOmM+GLtcF
 TKfCNAn22UlJ7PX/xKI9poOM/+gATOj36HJ1I8YdRJrZSlwZa8oDxx9LcBvyNkqNp1zMx/k
 XXVicexBLjbMNJLA+AOOw==
UI-OutboundReport: notjunk:1;M01:P0:nNCzynuxyCU=;+Cq5+lIzFw8wn4LYmLZCkGh6CUj
 1dD7mtTuxzT5RQqSxZ+08QG4nI7/NTBlP0/Cdvd3fzQrLB3MDRTYmoWY+pvUjnkAzInrWneml
 av7Ov64j8F+ZyNEb7FfmfRmZkkJuXvX0QML+S/7buv+caSVuLLv7YryeHYDdKHSxvOvVLVz1c
 +eF7pjtgHp/l0i24ssILX1DWGI1CQU3ZTV7RMwO2o/sIUFtf9t4cElkfG4lPOi8bi9dF2qRQG
 eL0AwWsEz5k8zLSYeiQDQk/LreYEVbOLr3qvhNf0v11O9xLhPt56g/G6O6NolhBvzDHmy1u/q
 qrR7xmZNFvNQdY+3Tvx2oTmx0l6SeUTHYUoRjWuaRw4KL9qdQvOP/m+3GZH0hC3q9Xk9k/ZDB
 jdJnzuKhJ7oEvVgyesZzyv2fsWrwkhAAxX0dkbr6YhFPD+yMrhEbMszX1KHj+5A0R2e+2/ZvD
 zWkZ99BTdaNawEBBvNsiJbMtay8/rP5HfJrM78c7KZs8tO9ck6kGaAWX5Rn8rNVtTZB+Xp6f1
 RPRHfv9ddqUvJKMLq0x3XKqGUnCnT5JIeJYmrDh2MtsIef0Dr6hPUzLYcX+OnASTJzg3rxVKj
 xuSf93nVv2WnE8TEWcSFz6M8obdIhPyAGCdcCtg62vs2VisFkCemvQqkth+YqWg23MKSyv5fi
 041CJ6011p7x9cZzvvve0LRNRyuG05wtmLCMnJAaK7XibuhRHgFtYQfCovhOJDizKbCeY9bu9
 jdKPiP4/WeA+v0lYyPCnb8eAItqJsSFOlL3dV0fKCsC5x+KZsToyagSiqlxCs9mDk9PRExPA4
 3gQMeHGhRtNzJiojZtpCmVfTMVAR1JDLQMpMkFpngTB8KzqWpYokFg5fS3i/1pZbeMWsKNZTU
 HK9yuPH1YrVebx6XZeJN4zuRMCYmIXfCtwLdp2Gbs3cEQqBB+Fyv1WT0+QwkwVXeGOlN/iz1Y
 mH8i7KIRg1F6wgFVz/XgurQ2/t5AG7g1TIZzS1V5mADIE0EWfjkib4ECdGPqhQ8+q181T+/6s
 TVPz2E3N6m4EzkMZpjgAYbkp78l3SZt8zTaerXb0nkSTzEJK6Qlt/dUhL+MbVh3H2wh8JEof+
 HTyYaRoJs3PPEy86gmVZUEkm3k6fap7SPdWRZRV0jRL/fc11PSN8odDJ15V4JTP0kFq5mmvEB
 XEOBbIDndsq+Cj0XTpHOytECzpRB/puYo39gAKJHspm5ZqAORd+7FGKpMrdLq729dlfZmOx80
 PvDij2pdJZjSoXY5kKyFr+obbWsRXslqMLRQotoVP+ngij/79r6u3LORC6NbUBU2mtLLL+vDZ
 cWNU1cPKZ/BwF/9tmMofK3lVoDmeYNCGZyHEaGUT+niTQuskN5GjWqalALSeVv5SGbf97aWxO
 Y5gry4v37BIJbjLJ/0BfCij6NfMOmg19LV5wmIDYCtF1zZjAio8YETWjRImNdcLoSNX5m/V91
 AznPd9yYTb5dpq2+JjZPpvaCMLoA=
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

On 11.03.25 17:47, Adriano Cordova wrote:
> Add http and ip4_config2 only if they are not already provided
> in the handle. The current use of pxe is only to store an ip
> address if a dhcp ack is received, this address is used by grub.
> Add pxe only if a dhcp ack is actually received.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_loader.h          |   8 +-
>   lib/efi_loader/efi_http.c     |  30 ++++-
>   lib/efi_loader/efi_ipconfig.c |  36 +++++-
>   lib/efi_loader/efi_net.c      | 203 +++++++++++++++++++++++-----------
>   4 files changed, 199 insertions(+), 78 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 35f500fd97d..ad234dbe6b3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -677,10 +677,14 @@ efi_status_t efi_net_init(void);
>   efi_status_t efi_net_do_start(void);
>   /* Called by efi_net_register to make the ip4 config2 protocol availab=
le */
>   efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> -				   struct efi_ip4_config2_protocol *ip4config);
> +				   struct efi_ip4_config2_protocol **ip4config);
> +efi_status_t efi_ipconfig_unregister(const efi_handle_t handle,
> +				     struct efi_ip4_config2_protocol *ip4config);
>   /* Called by efi_net_register to make the http protocol available */
>   efi_status_t efi_http_register(const efi_handle_t handle,
> -			       struct efi_service_binding_protocol *http_service_binding);
> +			       struct efi_service_binding_protocol **http_service_binding);
> +efi_status_t efi_http_unregister(const efi_handle_t handle,
> +				 struct efi_service_binding_protocol *http_service_binding);
>   /* Called by bootefi to make the watchdog available */
>   efi_status_t efi_watchdog_register(void);
>   efi_status_t efi_initrd_register(void);
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 189317fe2d2..dcef875f5b5 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -486,23 +486,45 @@ static efi_status_t EFIAPI efi_http_service_bindin=
g_destroy_child(
>    *
>    */
>   efi_status_t efi_http_register(const efi_handle_t handle,
> -			       struct efi_service_binding_protocol *http_service_binding)
> +			       struct efi_service_binding_protocol **http_service_binding)
>   {
>   	efi_status_t r =3D EFI_SUCCESS;
>
> +	r =3D efi_allocate_pool(EFI_LOADER_DATA, sizeof(**http_service_binding=
),
> +			      (void **)http_service_binding);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
>   	r =3D efi_add_protocol(handle, &efi_http_service_binding_guid,
> -			     http_service_binding);
> +			     *http_service_binding);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>
> -	http_service_binding->create_child =3D efi_http_service_binding_create=
_child;
> -	http_service_binding->destroy_child =3D efi_http_service_binding_destr=
oy_child;
> +	(*http_service_binding)->create_child =3D efi_http_service_binding_cre=
ate_child;
> +	(*http_service_binding)->destroy_child =3D efi_http_service_binding_de=
stroy_child;
>
>   	return EFI_SUCCESS;
>   failure_to_add_protocol:
>   	return r;
>   }
>
> +/**
> + * efi_http_unregister() - unregister the http protocol
> + *
> + */
> +efi_status_t efi_http_unregister(const efi_handle_t handle,
> +				 struct efi_service_binding_protocol *http_service_binding)
> +{
> +	efi_status_t r =3D EFI_SUCCESS;
> +
> +	r =3D efi_uninstall_protocol(handle, &efi_http_service_binding_guid,
> +				   http_service_binding, true);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
> +	efi_free_pool(http_service_binding);
> +
> +	return EFI_SUCCESS;
> +}
> +
>   enum efi_http_status_code efi_u32_to_httpstatus(u32 status)
>   {
>   	switch (status) {
> diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig=
.c
> index 9f51f77fa9a..18f659f4ed1 100644
> --- a/lib/efi_loader/efi_ipconfig.c
> +++ b/lib/efi_loader/efi_ipconfig.c
> @@ -194,12 +194,18 @@ static efi_status_t EFIAPI efi_ip4_config2_unregis=
ter_notify(struct efi_ip4_conf
>    *
>    */
>   efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> -				   struct efi_ip4_config2_protocol *ip4config)
> +				   struct efi_ip4_config2_protocol **ip4config)
>   {
>   	efi_status_t r =3D EFI_SUCCESS;
>
> +	if (!ip4config)
> +		return EFI_INVALID_PARAMETER;
> +
> +	r =3D efi_allocate_pool(EFI_LOADER_DATA, sizeof(**ip4config), (void **=
)ip4config);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
>   	r =3D efi_add_protocol(handle, &efi_ip4_config2_guid,
> -			     ip4config);
> +			     *ip4config);
>   	if (r !=3D EFI_SUCCESS) {
>   		log_err("ERROR: Failure to add protocol\n");
>   		return r;
> @@ -207,10 +213,28 @@ efi_status_t efi_ipconfig_register(const efi_handl=
e_t handle,
>
>   	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
>
> -	ip4config->set_data =3D efi_ip4_config2_set_data;
> -	ip4config->get_data =3D efi_ip4_config2_get_data;
> -	ip4config->register_data_notify =3D efi_ip4_config2_register_notify;
> -	ip4config->unregister_data_notify =3D efi_ip4_config2_unregister_notif=
y;
> +	(*ip4config)->set_data =3D efi_ip4_config2_set_data;
> +	(*ip4config)->get_data =3D efi_ip4_config2_get_data;
> +	(*ip4config)->register_data_notify =3D efi_ip4_config2_register_notify=
;
> +	(*ip4config)->unregister_data_notify =3D efi_ip4_config2_unregister_no=
tify;
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_ipconfig_unregister() - unregister the ip4_config2 protocol
> + *
> + */
> +efi_status_t efi_ipconfig_unregister(const efi_handle_t handle,
> +				     struct efi_ip4_config2_protocol *ip4config)
> +{
> +	efi_status_t r =3D EFI_SUCCESS;
> +
> +	r =3D efi_uninstall_protocol(handle, &efi_ip4_config2_guid,
> +				   ip4config, true);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
> +	efi_free_pool(ip4config);
>
>   	return EFI_SUCCESS;
>   }
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index fd43eec4c03..5a00e7a570c 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -19,6 +19,7 @@
>
>   #include <efi_loader.h>
>   #include <dm.h>
> +#include <dm/lists.h>
>   #include <linux/sizes.h>
>   #include <malloc.h>
>   #include <vsprintf.h>
> @@ -31,6 +32,8 @@
>   const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>   static const efi_guid_t efi_pxe_base_code_protocol_guid =3D
>   					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
> +static const efi_guid_t efi_ip4_config2_guid =3D EFI_IP4_CONFIG2_PROTOC=
OL_GUID;
> +static const efi_guid_t efi_http_service_binding_guid =3D EFI_HTTP_SERV=
ICE_BINDING_PROTOCOL_GUID;
>
>   struct dp_entry {
>   	struct efi_device_path *net_dp;
> @@ -93,10 +96,10 @@ struct efi_net_obj {
>   	struct efi_pxe_base_code_protocol pxe;
>   	struct efi_pxe_mode pxe_mode;
>   #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> -	struct efi_ip4_config2_protocol ip4_config2;
> +	struct efi_ip4_config2_protocol *ip4_config2;
>   #endif
>   #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
> -	struct efi_service_binding_protocol http_service_binding;
> +	struct efi_service_binding_protocol *http_service_binding;
>   #endif
>   	void *new_tx_packet;
>   	void *transmit_buffer;
> @@ -761,6 +764,8 @@ out:
>   	return EFI_EXIT(ret);
>   }
>
> +efi_status_t efi_net_add_pxe(struct efi_net_obj *netobj);
> +
>   /**
>    * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
>    *
> @@ -795,9 +800,12 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   	next_dhcp_entry++;
>   	next_dhcp_entry %=3D MAX_NUM_DHCP_ENTRIES;
>
> -	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> -			net_objs[i]->pxe_mode.dhcp_ack =3D **dhcp_ack;
> +	if (efi_obj_list_initialized =3D=3D EFI_SUCCESS) {
> +		for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +			if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> +				efi_net_add_pxe(net_objs[i]);
> +				break;
> +			}
>   		}
>   	}
>   }
> @@ -1069,6 +1077,52 @@ static struct efi_device_path *efi_netobj_get_dp(=
struct efi_net_obj *netobj)
>   	return NULL;
>   }
>
> +/**
> + * efi_net_add_pxe() - install the pxe protocol to a netobj
> + *
> + * @netobj:	pointer to efi_net_obj
> + * Return:	status code
> + */
> +efi_status_t efi_net_add_pxe(struct efi_net_obj *netobj)
> +{
> +	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_handler *phandler;
> +	int i, j;
> +
> +	r =3D efi_search_protocol(netobj->handle, &efi_pxe_base_code_protocol_=
guid, &phandler);
> +	if (r =3D=3D EFI_SUCCESS)
> +		return r;
> +
> +	i =3D (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTR=
IES;
> +	for (j =3D 0; netobj->dev && dhcp_cache[i].is_valid && j < MAX_NUM_DHC=
P_ENTRIES;
> +	     i =3D (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++)=
 {
> +		if (netobj->dev =3D=3D dhcp_cache[i].dev) {
> +			netobj->pxe_mode.dhcp_ack =3D *dhcp_cache[i].dhcp_ack;
> +			r =3D efi_add_protocol(netobj->handle, &efi_pxe_base_code_protocol_g=
uid,
> +					     &netobj->pxe);
> +			if (r !=3D EFI_SUCCESS)
> +				return r;
> +			netobj->pxe.revision =3D EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
> +			netobj->pxe.start =3D efi_pxe_base_code_start;
> +			netobj->pxe.stop =3D efi_pxe_base_code_stop;
> +			netobj->pxe.dhcp =3D efi_pxe_base_code_dhcp;
> +			netobj->pxe.discover =3D efi_pxe_base_code_discover;
> +			netobj->pxe.mtftp =3D efi_pxe_base_code_mtftp;
> +			netobj->pxe.udp_write =3D efi_pxe_base_code_udp_write;
> +			netobj->pxe.udp_read =3D efi_pxe_base_code_udp_read;
> +			netobj->pxe.set_ip_filter =3D efi_pxe_base_code_set_ip_filter;
> +			netobj->pxe.arp =3D efi_pxe_base_code_arp;
> +			netobj->pxe.set_parameters =3D efi_pxe_base_code_set_parameters;
> +			netobj->pxe.set_station_ip =3D efi_pxe_base_code_set_station_ip;
> +			netobj->pxe.set_packets =3D efi_pxe_base_code_set_packets;
> +			netobj->pxe.mode =3D &netobj->pxe_mode;
> +			break;
> +		}
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +
>   /**
>    * efi_netobj_start() - start an efi net device
>    *
> @@ -1102,15 +1156,8 @@ efi_status_t efi_netobj_start(struct efi_net_obj =
*netobj)
>   	if (r !=3D EFI_SUCCESS)
>   		return r;
>   set_addr:
> -#ifdef CONFIG_EFI_HTTP_PROTOCOL
> -	/*
> -	 * No harm on doing the following. If the PXE handle is present, the c=
lient could
> -	 * find it and try to get its IP address from it. In here the PXE hand=
le is present
> -	 * but the PXE protocol is not yet implmenented, so we add this in the=
 meantime.
> -	 */
>   	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station=
_ip,
>   			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, ne=
tobj->dev);
> -#endif
>
>   	return 0;
>   }
> @@ -1147,16 +1194,20 @@ static int efi_netobj_init(struct efi_net_obj *n=
etobj)
>   {
>   	efi_status_t r;
>   	struct udevice *dev;
> +	struct efi_handler *phandler;
>   	void *transmit_buffer =3D NULL;
>   	uchar **receive_buffer =3D NULL;
>   	size_t *receive_lengths =3D NULL;
> -	int i, j;
> +	int i;
>
> -	if (!netobj || !netobj->net || efi_netobj_is_active(netobj))
> +	if (!netobj || !netobj->net)
>   		return 0;
>
>   	dev =3D netobj->dev;
>
> +	if (efi_netobj_is_active(netobj))
> +		goto set_timers;
> +
>   	if (!netobj->net_mode)
>   		netobj->net_mode =3D calloc(1, sizeof(*netobj->net_mode));
>   	if (!netobj->net_mode)
> @@ -1203,11 +1254,6 @@ static int efi_netobj_init(struct efi_net_obj *ne=
tobj)
>   			netobj->net);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> -
> -	r =3D efi_add_protocol(netobj->handle, &efi_pxe_base_code_protocol_gui=
d,
> -			     &netobj->pxe);
> -	if (r !=3D EFI_SUCCESS)
> -		goto failure_to_add_protocol;
>   	netobj->net->revision =3D EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
>   	netobj->net->start =3D efi_net_start;
>   	netobj->net->stop =3D efi_net_stop;
> @@ -1233,38 +1279,15 @@ static int efi_netobj_init(struct efi_net_obj *n=
etobj)
>   	netobj->net_mode->max_packet_size =3D PKTSIZE;
>   	netobj->net_mode->if_type =3D ARP_ETHER;
>
> -	netobj->pxe.revision =3D EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
> -	netobj->pxe.start =3D efi_pxe_base_code_start;
> -	netobj->pxe.stop =3D efi_pxe_base_code_stop;
> -	netobj->pxe.dhcp =3D efi_pxe_base_code_dhcp;
> -	netobj->pxe.discover =3D efi_pxe_base_code_discover;
> -	netobj->pxe.mtftp =3D efi_pxe_base_code_mtftp;
> -	netobj->pxe.udp_write =3D efi_pxe_base_code_udp_write;
> -	netobj->pxe.udp_read =3D efi_pxe_base_code_udp_read;
> -	netobj->pxe.set_ip_filter =3D efi_pxe_base_code_set_ip_filter;
> -	netobj->pxe.arp =3D efi_pxe_base_code_arp;
> -	netobj->pxe.set_parameters =3D efi_pxe_base_code_set_parameters;
> -	netobj->pxe.set_station_ip =3D efi_pxe_base_code_set_station_ip;
> -	netobj->pxe.set_packets =3D efi_pxe_base_code_set_packets;
> -	netobj->pxe.mode =3D &netobj->pxe_mode;
> +	r =3D efi_net_add_pxe(netobj);
> +	if (r !=3D EFI_SUCCESS)
> +		return -1;
>
>   	r =3D EFI_CALL(efi_connect_controller(netobj->handle, NULL, NULL, 0))=
;
>   	if (r !=3D EFI_SUCCESS)
>   		return -1;
>
> -	/*
> -	 * Scan dhcp entries for one corresponding
> -	 * to this udevice, from newest to oldest
> -	 */
> -	i =3D (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTR=
IES;
> -	for (j =3D 0; dev && dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIE=
S;
> -	     i =3D (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++)=
 {
> -		if (dev =3D=3D dhcp_cache[i].dev) {
> -			netobj->pxe_mode.dhcp_ack =3D *dhcp_cache[i].dhcp_ack;
> -			break;
> -		}
> -	}
> -
> +set_timers:
>   	/*
>   	 * Create WaitForPacket event.
>   	 */
> @@ -1299,16 +1322,26 @@ static int efi_netobj_init(struct efi_net_obj *n=
etobj)
>   	}
>
>   #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> +	netobj->ip4_config2 =3D NULL;
> +	r =3D efi_search_protocol(netobj->handle, &efi_ip4_config2_guid, &phan=
dler);
> +	if (r =3D=3D EFI_SUCCESS)
> +		goto http;
>   	r =3D efi_ipconfig_register(netobj->handle, &netobj->ip4_config2);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
>
> +http:

This does not build if CONFIG_EFI_IP4_CONFIG2_PROTOCOL=3Dn:

+lib/efi_loader/efi_net.c:1337:1: error: label 'http' defined but not
used [-Werror=3Dunused-label]
+ 1337 | http:
+      | ^~~~

See https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/1101680

>   #ifdef CONFIG_EFI_HTTP_PROTOCOL
> +	netobj->http_service_binding =3D NULL;
> +	r =3D efi_search_protocol(netobj->handle, &efi_http_service_binding_gu=
id, &phandler);
> +	if (r =3D=3D EFI_SUCCESS)
> +		goto out;
>   	r =3D efi_http_register(netobj->handle, &netobj->http_service_binding=
);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> +out:

This does not build if CONFIG_EFI_HTTP_PROTOCOL=3Dn

+lib/efi_loader/efi_net.c: In function 'efi_netobj_init':
+lib/efi_loader/efi_net.c:1347:1: error: label 'out' defined but not
used [-Werror=3Dunused-label]
+ 1347 | out:

Best regards

Heinrich

>   	return 0;
>   failure_to_add_protocol:
>   	printf("ERROR: Failure to add protocol\n");
> @@ -1428,6 +1461,10 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t=
 handle,
>   int efi_net_register(void *ctx, struct event *event)
>   {
>   	struct udevice *dev;
> +	struct driver *drv;
> +	struct efi_netdev_plat *plat;
> +	efi_handle_t handle;
> +	struct efi_simple_network *net;
>   	enum uclass_id id;
>   	struct efi_net_obj *netobj;
>   	int i, r;
> @@ -1449,17 +1486,24 @@ int efi_net_register(void *ctx, struct event *ev=
ent)
>   		}
>   	}
>
> -	netobj =3D efi_netobj_alloc(NULL, NULL, dev);
> +	handle =3D NULL;
> +	net =3D NULL;
> +	drv =3D lists_driver_lookup_name("efi_netdev");
> +	if (drv && dev->driver =3D=3D drv) {
> +		plat =3D dev_get_plat(dev);
> +		handle =3D plat->handle;
> +		net =3D plat->snp;
> +	}
> +
> +	netobj =3D efi_netobj_alloc(handle, net, dev);
>
>   	if (!netobj)
>   		return -1;
>
>   	if (efi_obj_list_initialized =3D=3D EFI_SUCCESS) {
> -		if (!efi_netobj_is_active(netobj)) {
> -			r =3D efi_netobj_init(netobj);
> -			if (r)
> -				return -1;
> -		}
> +		r =3D efi_netobj_init(netobj);
> +		if (r)
> +			return -1;
>   	}
>
>   	return 0;
> @@ -1476,7 +1520,9 @@ int efi_net_register(void *ctx, struct event *even=
t)
>   int efi_net_unregister(void *ctx, struct event *event)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	int r;
>   	struct udevice *dev;
> +	struct driver *drv;
>   	enum uclass_id id;
>   	struct efi_net_obj *netobj;
>   	struct efi_handler *phandler;
> @@ -1501,18 +1547,22 @@ int efi_net_unregister(void *ctx, struct event *=
event)
>   		}
>   	}
>
> -	if (!netobj)
> +	if (!netobj || !efi_netobj_is_active(netobj))
>   		return 0;
>
> -	if (efi_netobj_is_active(netobj)) {
> +	drv =3D lists_driver_lookup_name("efi_netdev");
> +	if (!drv) {
> +		log_err("Cannot find driver 'efi_netdev'\n");
> +		return -1;
> +	}
> +
> +	if (drv !=3D dev->driver) {
>   		ret =3D EFI_CALL(efi_disconnect_controller(netobj->handle, NULL, NUL=
L));
>   		if (ret !=3D EFI_SUCCESS)
>   			return -1;
> -
>   		ret =3D EFI_CALL(efi_close_event(netobj->wait_for_packet));
>   		if (ret !=3D EFI_SUCCESS)
>   			return -1;
> -
>   		ret =3D EFI_CALL(efi_close_event(netobj->network_timer_event));
>   		if (ret !=3D EFI_SUCCESS)
>   			return -1;
> @@ -1524,22 +1574,43 @@ int efi_net_unregister(void *ctx, struct event *=
event)
>   		if (phandler && phandler->protocol_interface)
>   			interface =3D phandler->protocol_interface;
>
> +		if (netobj->handle->dev) {
> +			r =3D efi_unlink_dev(netobj->handle);
> +			if (r)
> +				return -1;
> +		}
> +	}
> +
> +#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> +	if (netobj->ip4_config2) {
> +		r =3D efi_ipconfig_unregister(netobj->handle, netobj->ip4_config2);
> +		if (r !=3D EFI_SUCCESS)
> +			return -1;
> +		netobj->ip4_config2 =3D NULL;
> +	}
> +#endif
> +
> +#ifdef CONFIG_EFI_HTTP_PROTOCOL
> +	if (netobj->http_service_binding) {
> +		r =3D efi_http_unregister(netobj->handle, netobj->http_service_bindin=
g);
> +		if (r !=3D EFI_SUCCESS)
> +			return -1;
> +		netobj->http_service_binding =3D NULL;
> +	}
> +#endif
> +
> +	if (drv !=3D dev->driver) {
>   		ret =3D efi_delete_handle(netobj->handle);
>   		if (ret !=3D EFI_SUCCESS)
>   			return -1;
>
>   		efi_free_pool(interface);
> +		if (netobj->net)
> +			free(netobj->net);
> +		if (netobj->net_mode)
> +			free(netobj->net_mode);
>   	}
>
> -	if (netobj->net) {
> -		if (netobj->net->mode)
> -			free(netobj->net->mode);
> -		free(netobj->net);
> -	}
> -
> -	if (netobj->net_mode)
> -		free(netobj->net_mode);
> -
>   	// Mark as free in the list
>   	netobj->handle =3D NULL;
>   	netobj->dev =3D NULL;
> @@ -1891,7 +1962,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_=
http_method method, void **buf
>   	// Set corresponding udevice
>   	dev =3D NULL;
>   	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -		if (net_objs[i] && &net_objs[i]->http_service_binding =3D=3D parent)
> +		if (net_objs[i] && net_objs[i]->http_service_binding =3D=3D parent)
>   			dev =3D net_objs[i]->dev;
>   	}
>   	if (!dev)

