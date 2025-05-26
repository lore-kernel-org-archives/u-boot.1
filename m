Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD4C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FBE82C57;
	Mon, 26 May 2025 11:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ax9wlLAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0976B82D18; Mon, 26 May 2025 11:04:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC19982C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748250259; x=1748855059; i=xypron.glpk@gmx.de;
 bh=OVTH13gJSL3oxW0OtYAZnPMu3sfX6rjMa+t29qk2F3U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ax9wlLAP0mJ87SYI1SePEcAwzBP9MgjYRHmmR+4LSXhrMgYcHbBB+A7/CMwrO0JM
 o18aoleuYYi7RMDY+sD+ki984hj0ED5Ssf8cVWbTv7Sq5uHvCvSWxCwxCQqe8lZwm
 D/RPVINtzFLuETQEGBU2RTSrOLhbjRQPYoBh4YDvx96um28gVVmVSoJTEUNyUnIeU
 lztqg9RJqLvNWwLU8pG4Ge+S4QWVnDHBcumQgFVzGqHlkFcrmyZ3JU7hOG+un7Cyq
 fthCT+sTYNNdYP2UrWoZRmL5iyNrPFWKqdTAsv4DPBMi9ydPrSS2jbovtiQkxLfwF
 KDlOcEiArWBuKuiRTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1v978K0dDP-00xvOk; Mon, 26
 May 2025 11:04:19 +0200
Message-ID: <60d88da6-858f-4279-90d3-3e98dd99849d@gmx.de>
Date: Mon, 26 May 2025 11:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] efi_loader/net: Remove efi_net_obj struct
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-6-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-6-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NnmWQOJanIuZqbpDsnEsoM5xrL4kykri76XxMoa4fmLcBEWMeia
 rLfdsPv3y3wRT86NvnY7UinvzGLBdDX0bBJg7Jjmkvomp7zB/vAKfwI7D5sKX2x7spHksic
 GEqd0sGCq46X9DCRowCmlg9kJdPeEuHyDSHqhMEpH/NABY02tkN2yT5RISl+khD6Hozba6v
 SPs896vQk+R/6nppBiy3g==
UI-OutboundReport: notjunk:1;M01:P0:XdehUXXY30Q=;9hUMlTj7SRAqjhxbRuHCBnwl6w5
 +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
 MKrY=
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

On 16.05.25 10:18, Adriano Cordova wrote:
> As all the protocols moved out of efi_net.c, and EFI
> net object is just an efi_object struct with network
> protocols installed on it, so efi_net_obj is not
> needed anymore.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/efi_loader.h                    |  2 +-
>   lib/efi_loader/net/efi_net.c            | 76 +++++++++----------------
>   lib/efi_loader/net/efi_simple_network.c | 10 ++--
>   3 files changed, 32 insertions(+), 56 deletions(-)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index cc90bdf6a3a..b53f88674fc 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -660,7 +660,7 @@ efi_status_t efi_gop_register(void);
>   efi_status_t efi_net_register(struct udevice *dev);
>   efi_status_t efi_net_do_start(struct udevice *dev);
>   /* Called by efi_net_register to install EFI_SIMPLE_NETWORK_PROTOCOL *=
/
> -efi_status_t efi_simple_network_install(const efi_handle_t handle, stru=
ct udevice *dev);
> +efi_status_t efi_simple_network_install(const efi_handle_t handle);
>   /* Called by efi_net_register to install EFI_PXE_BASE_CODE_PROTOCOL */
>   efi_status_t efi_pxe_install(const efi_handle_t handle, struct efi_pxe=
_packet *dhcp_ack);
>   /* Called by efi_net_register to install EFI_IP4_CONFIG2_PROTOCOL */
> diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
> index a7ceef4cbba..498ec4a0a8c 100644
> --- a/lib/efi_loader/net/efi_net.c
> +++ b/lib/efi_loader/net/efi_net.c
> @@ -57,32 +57,7 @@ struct dhcp_entry {
>   static struct dhcp_entry dhcp_cache[MAX_NUM_DHCP_ENTRIES];
>   static int next_dhcp_entry;
>  =20
> -/**
> - * struct efi_net_obj - EFI object representing a network interface
> - *
> - * @header:			EFI object header
> - * @dev:			net udevice
> - */
> -struct efi_net_obj {
> -	struct efi_object header;
> -	struct udevice *dev;
> -};
> -
> -static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
> -
> -/**
> - * efi_netobj_is_active() - checks if a netobj is active in the efi sub=
system
> - *
> - * @netobj:	pointer to efi_net_obj
> - * Return:	true if active
> - */
> -static bool efi_netobj_is_active(struct efi_net_obj *netobj)
> -{
> -	if (!netobj || !efi_search_obj(&netobj->header))
> -		return false;
> -
> -	return true;
> -}
> +static efi_handle_t net_objs[MAX_EFI_NET_OBJS];
>  =20
>   /**
>    * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
> @@ -124,7 +99,7 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
>   		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
>   			phandler =3D NULL;
> -			r =3D efi_search_protocol(&net_objs[i]->header,
> +			r =3D efi_search_protocol(net_objs[i],
>   						&efi_pxe_base_code_protocol_guid,
>   						&phandler);
>   			if (r =3D=3D EFI_SUCCESS && phandler) {
> @@ -139,17 +114,17 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   /**
>    * efi_netobj_set_dp() - set device path of a netobj
>    *
> - * @netobj:	pointer to efi_net_obj
> + * @netobj:	handle of an EFI net device
>    * @dp:		device path to set, allocated by caller
>    * Return:	status code
>    */
> -efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_d=
evice_path *dp)
> +efi_status_t efi_netobj_set_dp(efi_handle_t netobj, struct efi_device_p=
ath *dp)
>   {
>   	efi_status_t ret;
>   	struct efi_handler *phandler;
>   	struct efi_device_path *new_net_dp;
>  =20
> -	if (!efi_netobj_is_active(netobj))
> +	if (!efi_search_obj(netobj))
>   		return EFI_SUCCESS;
>  =20
>   	// Create a device path for the netobj
> @@ -158,21 +133,21 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj =
*netobj, struct efi_device_pat
>   		return EFI_OUT_OF_RESOURCES;
>  =20
>   	phandler =3D NULL;
> -	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler)=
;
> +	efi_search_protocol(netobj, &efi_guid_device_path, &phandler);
>  =20
>   	// If the device path protocol is not yet installed, install it
>   	if (!phandler)
>   		goto add;
>  =20
>   	// If it is already installed, try to update it
> -	ret =3D efi_reinstall_protocol_interface(&netobj->header, &efi_guid_de=
vice_path,
> +	ret =3D efi_reinstall_protocol_interface(netobj, &efi_guid_device_path=
,
>   					       phandler->protocol_interface, new_net_dp);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>  =20
>   	return EFI_SUCCESS;
>   add:
> -	ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +	ret =3D efi_add_protocol(netobj, &efi_guid_device_path,
>   			       new_net_dp);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
> @@ -183,18 +158,18 @@ add:
>   /**
>    * efi_netobj_get_dp() - get device path of a netobj
>    *
> - * @netobj:	pointer to efi_net_obj
> + * @netobj:	handle to EFI net object
>    * Return:	device path, NULL on error
>    */
> -static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *ne=
tobj)
> +static struct efi_device_path *efi_netobj_get_dp(efi_handle_t netobj)
>   {
>   	struct efi_handler *phandler;
>  =20
> -	if (!efi_netobj_is_active(netobj))
> +	if (!efi_search_obj(netobj))
>   		return NULL;
>  =20
>   	phandler =3D NULL;
> -	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler)=
;
> +	efi_search_protocol(netobj, &efi_guid_device_path, &phandler);
>  =20
>   	if (phandler && phandler->protocol_interface)
>   		return efi_dp_dup(phandler->protocol_interface);
> @@ -213,7 +188,7 @@ static struct efi_device_path *efi_netobj_get_dp(str=
uct efi_net_obj *netobj)
>   efi_status_t efi_net_do_start(struct udevice *dev)
>   {
>   	efi_status_t r =3D EFI_SUCCESS;
> -	struct efi_net_obj *netobj;
> +	efi_handle_t netobj;
>   	struct efi_device_path *net_dp;
>   #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>   	struct efi_handler *phandler;
> @@ -229,7 +204,7 @@ efi_status_t efi_net_do_start(struct udevice *dev)
>   		}
>   	}
>  =20
> -	if (!efi_netobj_is_active(netobj))
> +	if (!efi_search_obj(netobj))
>   		return r;
>  =20
>   	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
> @@ -257,7 +232,7 @@ set_addr:
>   	 * but the PXE protocol is not yet implmenented, so we add this in th=
e meantime.
>   	 */
>   	pxe =3D NULL;
> -	r =3D efi_search_protocol(&netobj->header,
> +	r =3D efi_search_protocol(netobj,
>   				&efi_pxe_base_code_protocol_guid,
>   				&phandler);
>   	if (r =3D=3D EFI_SUCCESS && phandler) {
> @@ -280,7 +255,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>   {
>   	efi_status_t r;
>   	int seq_num;
> -	struct efi_net_obj *netobj;
> +	efi_handle_t netobj;
>   	struct efi_pxe_packet *dhcp_ack;
>   	int i, j;
>  =20
> @@ -313,13 +288,14 @@ efi_status_t efi_net_register(struct udevice *dev)
>   		return EFI_OUT_OF_RESOURCES;
>   	}
>  =20
> -	netobj->dev =3D dev;
> -
>   	/* Hook net up to the device list */
> -	efi_add_handle(&netobj->header);
> +	efi_add_handle(netobj);
> +
> +	if (efi_link_dev(netobj, dev) < 0)
> +		return EFI_DEVICE_ERROR;
>  =20
>   	/* Install EFI_SIMPLE_NETWORK_PROTOCOL */
> -	r =3D efi_simple_network_install(&netobj->header, dev);
> +	r =3D efi_simple_network_install(netobj);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>  =20
> @@ -338,19 +314,19 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	}
>  =20
>   	/* Install EFI_PXE_BASE_CODE_PROTOCOL */
> -	r =3D efi_pxe_install(&netobj->header, dhcp_ack);
> +	r =3D efi_pxe_install(netobj, dhcp_ack);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>  =20
>   #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
>   	/* Install EFI_IP4_CONFIG2_PROTOCOL */
> -	r =3D efi_ip4_config2_install(&netobj->header);
> +	r =3D efi_ip4_config2_install(netobj);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
>   #ifdef CONFIG_EFI_HTTP_PROTOCOL
>   	/* Install EFI_HTTP_PROTOCOL */
> -	r =3D efi_http_install(&netobj->header);
> +	r =3D efi_http_install(netobj);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> @@ -376,7 +352,7 @@ failure_to_add_protocol:
>   efi_status_t efi_net_new_dp(const char *dev, const char *server, struc=
t udevice *udev)
>   {
>   	efi_status_t ret;
> -	struct efi_net_obj *netobj;
> +	efi_handle_t netobj;
>   	struct efi_device_path *old_net_dp, *new_net_dp;
>   	struct efi_device_path **dp;
>   	int i;
> @@ -708,7 +684,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_ht=
tp_method method, void **buf
>   		if (!net_objs[i])
>   			continue;
>  =20
> -		ret =3D efi_search_protocol(&net_objs[i]->header,
> +		ret =3D efi_search_protocol(net_objs[i],
>   					  &efi_http_service_binding_guid,
>   					  &phandler);
>   		if (ret =3D=3D EFI_SUCCESS && phandler &&
> diff --git a/lib/efi_loader/net/efi_simple_network.c b/lib/efi_loader/ne=
t/efi_simple_network.c
> index c7c03062b11..5426d366e21 100644
> --- a/lib/efi_loader/net/efi_simple_network.c
> +++ b/lib/efi_loader/net/efi_simple_network.c
> @@ -758,7 +758,7 @@ out:
>    * @handle:	handle to install the protocol
>    * @dev:	net udevice
>    */
> -efi_status_t efi_simple_network_install(const efi_handle_t handle, stru=
ct udevice *dev)
> +efi_status_t efi_simple_network_install(const efi_handle_t handle)
>   {
>   	efi_status_t r;
>   	struct efi_simple_network_extended_protocol *simple_network;
> @@ -767,7 +767,7 @@ efi_status_t efi_simple_network_install(const efi_ha=
ndle_t handle, struct udevic
>   	size_t *receive_lengths;
>   	int i;
>  =20
> -	if (!dev) {
> +	if (!handle || !handle->dev) {
>   		/* No network device active, don't expose any */
>   		return EFI_SUCCESS;
>   	}
> @@ -777,7 +777,7 @@ efi_status_t efi_simple_network_install(const efi_ha=
ndle_t handle, struct udevic
>   	if (!simple_network)
>   		goto out_of_resources;
>  =20
> -	simple_network->dev =3D dev;
> +	simple_network->dev =3D handle->dev;
>  =20
>   	/* Allocate an aligned transmit buffer */
>   	transmit_buffer =3D calloc(1, PKTSIZE_ALIGN + PKTALIGN);
> @@ -820,9 +820,9 @@ efi_status_t efi_simple_network_install(const efi_ha=
ndle_t handle, struct udevic
>   	simple_network->net.receive =3D efi_net_receive;
>   	simple_network->net.mode =3D &simple_network->net_mode;
>   	simple_network->net_mode.state =3D EFI_NETWORK_STOPPED;
> -	if (dev_get_plat(dev))
> +	if (dev_get_plat(handle->dev))
>   		memcpy(simple_network->net_mode.current_address.mac_addr,
> -		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
> +		       ((struct eth_pdata *)dev_get_plat(handle->dev))->enetaddr, 6);
>   	simple_network->net_mode.hwaddr_size =3D ARP_HLEN;
>   	simple_network->net_mode.media_header_size =3D ETHER_HDR_SIZE;
>   	simple_network->net_mode.max_packet_size =3D PKTSIZE;

