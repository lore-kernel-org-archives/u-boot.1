Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7FFC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 08:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D7382C57;
	Mon, 26 May 2025 10:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q82Y3tpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E17982CF8; Mon, 26 May 2025 10:56:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F7782B7C
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748249771; x=1748854571; i=xypron.glpk@gmx.de;
 bh=H6CHoFCMWm33ktC9JnkJG1tG8cwjMt+rY0MKJIZsCY8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=q82Y3tpv95RBJkATKImZ2wUctO/SMpyWxvYq0OIC3hTKyyCtV6BlnO9+Qc/9ERV1
 Db7RHN/62zPEtloSbncbI3qdwWxYmzEju+6IyNAgldVJXJQcBlrU3kiflH7/a6IpJ
 Rpz2tA3zRKS4dDu8VWUhzyIE+RLZ2cilC1pfcG1j4Afe0Qn49S8zeQFrj+REgCBbZ
 SOFrydQrPmFEHprZCrTBol4aGNqIAqTuDqmIouQ3UUvMMZPuqTzuQFl4mSSPIq9bM
 BR45qbyhnVdWHOu74LtTIu/p0yA8CNxMxqBIEPNM5H0W9O9DCL+vN0yRnEXx3iKyq
 PR3DSpL36U8AE+LTPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1uTOj91xy0-00ULV2; Mon, 26
 May 2025 10:56:11 +0200
Message-ID: <20408378-0345-4b6e-b46c-9ff789ce605c@gmx.de>
Date: Mon, 26 May 2025 10:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] efi_loader/net: Remove http and ip4_config2 data from
 efi_net.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-3-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-3-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nuFA8RP2AX5qIXeKK5nQ6Hk6qMFEMRIzgHM158Ize6CtdJfcynl
 eG3zFMGMK4dCSYSDuD91Mdph8wgfG02qOQKJ5jL7nBG+0o7mQRLkWolHEhWiufxTIbP5bk/
 2U+VAUgCnbRfOQzlPOpl9M1nJi0Us59edaqv5RM3gjxZTFqSNB6Xrq8mExfWHNS3DMg/DvQ
 oEymiE0c1IVKaxgCqt8ag==
UI-OutboundReport: notjunk:1;M01:P0:OfLzaWN6XAU=;T9tNlGjgxRwUAxAqsbY/Vw8MHx0
 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
 8qSNA5/VlS0LjVTHsf31uuQ59
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
> efi_net.c should only [un]install protocols, leaving the
> actual implementation to efi_http.c and efi_ipconfig.c
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_loader.h              |  6 ++----
>   lib/efi_loader/net/efi_http.c     | 20 +++++++++++++-------
>   lib/efi_loader/net/efi_ipconfig.c | 19 ++++++++++++-------
>   lib/efi_loader/net/efi_net.c      | 26 ++++++++++++++------------
>   4 files changed, 41 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 84e8cfe320e..5c1244824f3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -662,11 +662,9 @@ efi_status_t efi_gop_register(void);
>   efi_status_t efi_net_register(struct udevice *dev);
>   efi_status_t efi_net_do_start(struct udevice *dev);
>   /* Called by efi_net_register to make the ip4 config2 protocol availab=
le */
> -efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> -				   struct efi_ip4_config2_protocol *ip4config);
> +efi_status_t efi_ip4_config2_install(const efi_handle_t handle);
>   /* Called by efi_net_register to make the http protocol available */
> -efi_status_t efi_http_register(const efi_handle_t handle,
> -			       struct efi_service_binding_protocol *http_service_binding);
> +efi_status_t efi_http_install(const efi_handle_t handle);
>   /* Called by bootefi to make the watchdog available */
>   efi_status_t efi_watchdog_register(void);
>   efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
> diff --git a/lib/efi_loader/net/efi_http.c b/lib/efi_loader/net/efi_http=
.c
> index 189317fe2d2..536ce1edb97 100644
> --- a/lib/efi_loader/net/efi_http.c
> +++ b/lib/efi_loader/net/efi_http.c
> @@ -24,6 +24,7 @@ static const efi_guid_t efi_http_guid =3D EFI_HTTP_PRO=
TOCOL_GUID;
>    *
>    * @http:			EFI_HTTP_PROTOCOL interface
>    * @handle:			handle to efi object
> + * @parent:			service binding that created this child
>    * @configured:			configuration status
>    * @http_load_addr:		data buffer
>    * @file_size:			size of data
> @@ -391,7 +392,7 @@ static efi_status_t EFIAPI efi_http_service_binding_=
create_child(
>   	if (!child_handle)
>   		return EFI_EXIT(EFI_INVALID_PARAMETER);
>  =20
> -	new_instance =3D calloc(1, sizeof(struct efi_http_instance));
> +	new_instance =3D calloc(1, sizeof(*new_instance));
>   	if (!new_instance) {
>   		ret =3D EFI_OUT_OF_RESOURCES;
>   		goto failure_to_add_protocol;
> @@ -482,25 +483,30 @@ static efi_status_t EFIAPI efi_http_service_bindin=
g_destroy_child(
>   }
>  =20
>   /**
> - * efi_http_register() - register the http protocol
> + * efi_http_install() - install the EFI_HTTP_SERVICE_BINDING_PROTOCOL
>    *
> + * @handle:	handle to install the protocol
>    */
> -efi_status_t efi_http_register(const efi_handle_t handle,
> -			       struct efi_service_binding_protocol *http_service_binding)
> +efi_status_t efi_http_install(const efi_handle_t handle)
>   {
>   	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_service_binding_protocol *http_service_binding;
> +
> +	r =3D efi_allocate_pool(EFI_LOADER_DATA,
> +			      sizeof(*http_service_binding),
> +			      (void **)&http_service_binding);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
>  =20
>   	r =3D efi_add_protocol(handle, &efi_http_service_binding_guid,
>   			     http_service_binding);
>   	if (r !=3D EFI_SUCCESS)

If a failure occurs, we should free http_service_binding.

> -		goto failure_to_add_protocol;
> +		return r;
>  =20
>   	http_service_binding->create_child =3D efi_http_service_binding_creat=
e_child;
>   	http_service_binding->destroy_child =3D efi_http_service_binding_dest=
roy_child;

This sequence looks odd to me.

I would prefer to fill the structure before installing the protocol.

Best regards

Heinrich

>  =20
>   	return EFI_SUCCESS;
> -failure_to_add_protocol:
> -	return r;
>   }
>  =20
>   enum efi_http_status_code efi_u32_to_httpstatus(u32 status)
> diff --git a/lib/efi_loader/net/efi_ipconfig.c b/lib/efi_loader/net/efi_=
ipconfig.c
> index 9f51f77fa9a..a46cba09f01 100644
> --- a/lib/efi_loader/net/efi_ipconfig.c
> +++ b/lib/efi_loader/net/efi_ipconfig.c
> @@ -190,20 +190,25 @@ static efi_status_t EFIAPI efi_ip4_config2_unregis=
ter_notify(struct efi_ip4_conf
>   }
>  =20
>   /**
> - * efi_ipconfig_register() - register the ip4_config2 protocol
> + * efi_ip4_config2_install() - install the EFI_IP4_CONFIG2_PROTOCOL
>    *
> + * @handle	handle to install the protocol
>    */
> -efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> -				   struct efi_ip4_config2_protocol *ip4config)
> +efi_status_t efi_ip4_config2_install(const efi_handle_t handle)
>   {
> -	efi_status_t r =3D EFI_SUCCESS;
> +	efi_status_t r;
> +	struct efi_ip4_config2_protocol *ip4config;
> +
> +	r =3D efi_allocate_pool(EFI_LOADER_DATA,
> +			      sizeof(*ip4config),
> +			      (void **)&ip4config);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
>  =20
>   	r =3D efi_add_protocol(handle, &efi_ip4_config2_guid,
>   			     ip4config);
> -	if (r !=3D EFI_SUCCESS) {
> -		log_err("ERROR: Failure to add protocol\n");
> +	if (r !=3D EFI_SUCCESS)
>   		return r;
> -	}
>  =20
>   	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
>  =20
> diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
> index b3291b4f1d5..40db80f4726 100644
> --- a/lib/efi_loader/net/efi_net.c
> +++ b/lib/efi_loader/net/efi_net.c
> @@ -31,6 +31,8 @@
>   const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>   static const efi_guid_t efi_pxe_base_code_protocol_guid =3D
>   					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
> +static const efi_guid_t efi_http_service_binding_guid =3D
> +					EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
>  =20
>   struct dp_entry {
>   	struct efi_device_path *net_dp;
> @@ -73,8 +75,6 @@ static int next_dhcp_entry;
>    * @net_mode:			status of the network interface
>    * @pxe:			PXE base code protocol interface
>    * @pxe_mode:			status of the PXE base code protocol
> - * @ip4_config2:		IP4 Config2 protocol interface
> - * @http_service_binding:	Http service binding protocol interface
>    * @new_tx_packet:		new transmit packet
>    * @transmit_buffer:	transmit buffer
>    * @receive_buffer:		array of receive buffers
> @@ -92,12 +92,6 @@ struct efi_net_obj {
>   	struct efi_simple_network_mode net_mode;
>   	struct efi_pxe_base_code_protocol pxe;
>   	struct efi_pxe_mode pxe_mode;
> -#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> -	struct efi_ip4_config2_protocol ip4_config2;
> -#endif
> -#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
> -	struct efi_service_binding_protocol http_service_binding;
> -#endif
>   	void *new_tx_packet;
>   	void *transmit_buffer;
>   	uchar **receive_buffer;
> @@ -1285,13 +1279,12 @@ efi_status_t efi_net_register(struct udevice *de=
v)
>   	}
>  =20
>   #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> -	r =3D efi_ipconfig_register(&netobj->header, &netobj->ip4_config2);
> +	r =3D efi_ip4_config2_install(&netobj->header);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> -
>   #ifdef CONFIG_EFI_HTTP_PROTOCOL
> -	r =3D efi_http_register(&netobj->header, &netobj->http_service_binding=
);
> +	r =3D efi_http_install(&netobj->header);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> @@ -1645,6 +1638,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_=
http_method method, void **buf
>   	int wget_ret;
>   	static bool last_head;
>   	struct udevice *dev;
> +	struct efi_handler *phandler;
>   	int i;
>  =20
>   	if (!buffer || !file_size || !parent)
> @@ -1656,8 +1650,16 @@ efi_status_t efi_net_do_request(u8 *url, enum efi=
_http_method method, void **buf
>   	// Set corresponding udevice
>   	dev =3D NULL;
>   	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -		if (net_objs[i] && &net_objs[i]->http_service_binding =3D=3D parent)
> +		if (!net_objs[i])
> +			continue;
> +
> +		ret =3D efi_search_protocol(&net_objs[i]->header,
> +					  &efi_http_service_binding_guid,
> +					  &phandler);
> +		if (ret =3D=3D EFI_SUCCESS && phandler =3D=3D (void *)parent) {
>   			dev =3D net_objs[i]->dev;
> +			break;
> +		}
>   	}
>   	if (!dev)
>   		return EFI_ABORTED;

