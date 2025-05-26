Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD2BC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B1882D40;
	Mon, 26 May 2025 11:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RMrH32JY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4F482D43; Mon, 26 May 2025 11:14:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFF582D34
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748250878; x=1748855678; i=xypron.glpk@gmx.de;
 bh=8X11D0kSjeRfvIpM12zXb2P0Khg1kCgEnPar+BjQ+q0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RMrH32JYXZ2TaZv2+FOOJ86RTCmKluH0z6AhzKB3zmmL1uOIxgDsoOuG+T/z1WHe
 NVh2yTdUlYVF7UURIRJMs0DtUeUHxUjiRwhyziMpwpsgzDfeUSoODZn6nhfPdcGIk
 ND9lwsdSu++Bya0TSU/Jf7YZNdTnN/X4p7O5pNJ9JvslJuMTmXLKE5ELzWTokXp3+
 ZzX0BRVhWV5v4MkNrUtsgdBKos98RozdtsHoeznUXV3cI1PfEejKJJyN828A7OiNF
 b9RAGo/cNoBRqZcis8NXcp/IoiPnMg+JDS/PDUafXVBuxGQgh9Obw9CIUa29BHlXz
 tA5zc5EFmbkyLnmEoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1uP0j40rF6-00WzXW; Mon, 26
 May 2025 11:14:38 +0200
Message-ID: <5ae0108a-d158-4334-b349-f89965ed895b@gmx.de>
Date: Mon, 26 May 2025 11:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] efi_loader/net/ip4_config2: Add support for multiple
 instances
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-8-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-8-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZGOJKkztmNGTxDMXt5s0imjWT0rCWb6bSUND5IL1rMfPD3xZK6
 QQnksb/WAQyEAGeNhQKTuNqg5v16jeHbfgGAngLbJUBNvD99MeOFcSz6HnDK2Jg6TLKRPZg
 e68ZWlZ63c76Z5RkWhu8p61PSevqb4A2UbuWxVTf92PkSrH7QKMrWR85S88a0Dhkfm9wpv5
 +poLH04o4fKG7nJnZ9u1w==
UI-OutboundReport: notjunk:1;M01:P0:ochf8tMMYwo=;qqChhJCZ7VuQTeNkzAsh4b8wpbe
 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
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
> Fix support multiple instances of EFI_IP4_CONFIG2_PROTOCOL in
> efi_ip4_config2.c. Station addresses and policies should be per
> protocol instance and not global.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/net/efi_ip4_config2.c | 73 +++++++++++++++++++---------
>   1 file changed, 49 insertions(+), 24 deletions(-)
>=20
> diff --git a/lib/efi_loader/net/efi_ip4_config2.c b/lib/efi_loader/net/e=
fi_ip4_config2.c
> index a46cba09f01..a924a10716f 100644
> --- a/lib/efi_loader/net/efi_ip4_config2.c
> +++ b/lib/efi_loader/net/efi_ip4_config2.c
> @@ -14,12 +14,25 @@
>  =20
>   static const efi_guid_t efi_ip4_config2_guid =3D EFI_IP4_CONFIG2_PROTO=
COL_GUID;
>  =20
> -struct efi_ip4_config2_manual_address current_http_ip;
> -static enum efi_ip4_config2_policy current_policy;
> -static char current_mac_addr[32];
> -
>   /* EFI_IP4_CONFIG2_PROTOCOL */
>  =20
> +/**
> + * struct efi_ip4_config2_extended_protocol - EFI object extending the
> + *					      EFI_IP4_CONFIG2_PROTOCOL
> + *					      interface
> + *
> + * @ip4_config2:		EFI_IP4_CONFIG2_PROTOCOL interface
> + * @dev:			net udevice
> + * @current_address		current address
> + * @current_policy		current policy
> + */
> +struct efi_ip4_config2_extended_protocol {
> +	struct efi_ip4_config2_protocol ip4_config2;
> +	struct udevice *dev;
> +	struct efi_ip4_config2_manual_address current_address;
> +	enum efi_ip4_config2_policy current_policy;
> +};
> +
>   /*
>    * efi_ip4_config2_set_data() -  Set the configuration for the EFI IPv=
4 network
>    * stack running on the communication device
> @@ -41,32 +54,38 @@ static efi_status_t EFIAPI efi_ip4_config2_set_data(=
struct efi_ip4_config2_proto
>   {
>   	EFI_ENTRY("%p, %d, %zu, %p", this, data_type, data_size, data);
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_ip4_config2_extended_protocol *ipconfig;
>  =20
>   	if (!this || (data && !data_size) || (!data && data_size))
>   		return EFI_EXIT(EFI_INVALID_PARAMETER);
>  =20
> +	ipconfig =3D (struct efi_ip4_config2_extended_protocol *)this;
> +	if (!ipconfig->dev)
> +		return EFI_EXIT(EFI_NOT_FOUND);
> +
>   	switch (data_type) {
>   	case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
>   		return EFI_EXIT(EFI_WRITE_PROTECTED);
>   	case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
> -		if (current_policy !=3D EFI_IP4_CONFIG2_POLICY_STATIC)
> +		if (ipconfig->current_policy !=3D EFI_IP4_CONFIG2_POLICY_STATIC)
>   			return EFI_EXIT(EFI_WRITE_PROTECTED);
>   		if (!data_size && !data) {
> -			memset((void *)&current_http_ip, 0,
> -			       sizeof(current_http_ip));
> +			memset((void *)&ipconfig->current_address, 0,
> +			       sizeof(ipconfig->current_address));
>   			return EFI_EXIT(EFI_SUCCESS);
>   		}
>   		if (data && data_size =3D=3D sizeof(struct efi_ip4_config2_manual_ad=
dress)) {
> -			memcpy((void *)&current_http_ip, data,
> +			memcpy((void *)&ipconfig->current_address, data,
>   			       sizeof(struct efi_ip4_config2_manual_address));
> -			efi_net_set_addr(&current_http_ip.address,
> -					 &current_http_ip.subnet_mask, NULL, NULL);
> +			efi_net_set_addr(&ipconfig->current_address.address,
> +					 &ipconfig->current_address.subnet_mask,
> +					 NULL, ipconfig->dev);
>   			return EFI_EXIT(EFI_SUCCESS);
>   		}
>   		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
>   	case EFI_IP4_CONFIG2_DATA_TYPE_POLICY:
>   		if (data && data_size =3D=3D sizeof(enum efi_ip4_config2_policy)) {
> -			current_policy =3D *(enum efi_ip4_config2_policy *)data;
> +			ipconfig->current_policy =3D *(enum efi_ip4_config2_policy *)data;
>   			return EFI_EXIT(EFI_SUCCESS);
>   		}
>   		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
> @@ -101,6 +120,7 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(=
struct efi_ip4_config2_proto
>  =20
>   	efi_status_t ret =3D EFI_SUCCESS;
>   	struct efi_ip4_config2_interface_info *info;
> +	struct efi_ip4_config2_extended_protocol *ipconfig;
>   	int tmp;
>  =20
>   	if (!this || !data_size)
> @@ -109,6 +129,10 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data=
(struct efi_ip4_config2_proto
>   	if (*data_size && !data)
>   		return EFI_EXIT(EFI_INVALID_PARAMETER);
>  =20
> +	ipconfig =3D (struct efi_ip4_config2_extended_protocol *)this;
> +	if (!ipconfig->dev)
> +		return EFI_EXIT(EFI_NOT_FOUND);
> +
>   	tmp =3D sizeof(struct efi_ip4_config2_interface_info) + sizeof(struct=
 efi_ip4_route_table);
>  =20
>   	switch (data_type) {
> @@ -122,7 +146,7 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(=
struct efi_ip4_config2_proto
>   		memset(info, 0, sizeof(*info));
>  =20
>   		info->hw_address_size =3D 6;
> -		memcpy(info->hw_address.mac_addr, current_mac_addr, 6);
> +		memcpy(info->hw_address.mac_addr, eth_get_ethaddr_from_dev(ipconfig->=
dev), 6);
>   		// Set the route table size
>  =20
>   		info->route_table_size =3D 0;
> @@ -133,8 +157,9 @@ static efi_status_t EFIAPI efi_ip4_config2_get_data(=
struct efi_ip4_config2_proto
>   			return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
>   		}
>  =20
> -		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_ma=
sk, NULL, NULL);
> -		memcpy(data, (void *)&current_http_ip,
> +		efi_net_get_addr(&ipconfig->current_address.address,
> +				 &ipconfig->current_address.subnet_mask, NULL, ipconfig->dev);
> +		memcpy(data, (void *)&ipconfig->current_address,
>   		       sizeof(struct efi_ip4_config2_manual_address));
>  =20
>   		break;
> @@ -197,25 +222,25 @@ static efi_status_t EFIAPI efi_ip4_config2_unregis=
ter_notify(struct efi_ip4_conf
>   efi_status_t efi_ip4_config2_install(const efi_handle_t handle)
>   {
>   	efi_status_t r;
> -	struct efi_ip4_config2_protocol *ip4config;
> +	struct efi_ip4_config2_extended_protocol *ipconfig;
>  =20
>   	r =3D efi_allocate_pool(EFI_LOADER_DATA,

We could use malloc() for allocating memory that is not freed by an EFI=20
application.

> -			      sizeof(*ip4config),
> -			      (void **)&ip4config);
> +			      sizeof(*ipconfig),
> +			      (void **)&ipconfig);
>   	if (r !=3D EFI_SUCCESS)
>   		return r;
>  =20
>   	r =3D efi_add_protocol(handle, &efi_ip4_config2_guid,
> -			     ip4config);
> +			     &ipconfig->ip4_config2);
>   	if (r !=3D EFI_SUCCESS)

Please, free all allocated memory in case of an error.

Please, always fill protocol interface fields before adding a protocol,=20
because there might be a listener installed via RegisterProtocolNotify().

Best regards

Heinrich

>   		return r;
>  =20
> -	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
> -
> -	ip4config->set_data =3D efi_ip4_config2_set_data;
> -	ip4config->get_data =3D efi_ip4_config2_get_data;
> -	ip4config->register_data_notify =3D efi_ip4_config2_register_notify;
> -	ip4config->unregister_data_notify =3D efi_ip4_config2_unregister_notif=
y;
> +	ipconfig->dev =3D handle->dev;
> +	ipconfig->ip4_config2.set_data =3D efi_ip4_config2_set_data;
> +	ipconfig->ip4_config2.get_data =3D efi_ip4_config2_get_data;
> +	ipconfig->ip4_config2.register_data_notify =3D efi_ip4_config2_registe=
r_notify;
> +	ipconfig->ip4_config2.unregister_data_notify =3D efi_ip4_config2_unreg=
ister_notify;
> +	ipconfig->current_policy =3D EFI_IP4_CONFIG2_POLICY_MAX;
>  =20
>   	return EFI_SUCCESS;
>   }

