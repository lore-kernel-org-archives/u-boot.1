Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A92D58D5A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 15:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821F289A4B;
	Mon, 25 Nov 2024 16:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S/UZR6qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2020989A4B; Mon, 25 Nov 2024 16:40:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E689E89A31
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732549219; x=1733154019; i=xypron.glpk@gmx.de;
 bh=aDO103CmzQo6oXACplzmzmPye+u1zZCmH9o4zvHViPQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S/UZR6qPxCEejLL/keqDt9fB73vkD5b4UqiA6kTHz0HFk+j0+JlvXL0mdqNUb3Zb
 7cjYT0qQ/fBM+9ZgHKspIlmrwF3sBTTz0a3LIDVQcP8gChZqFztgubTHOIhDWHUZE
 5jRA89lnLOF5py0/GeoeWv5Ti0gSpHKWby5TmnahGPE/IcgL43EDaOHeOncPKPoLL
 LKFlOjdrrSSenwSwsn98ZBkCdgdOVzVs3SRbVaf+/6IIF9mv1XReu4Wq5Qi7HhTy4
 LW3Qy5UkavBTaIJ5nrcOzSCoqIJph2rt8115DQDOdE6KYNJ59+u4YDHJpcIsO/Jya
 m1qWHL6kxUi/4dtrbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1u1KPV0pGA-00eKJo; Mon, 25
 Nov 2024 16:40:19 +0100
Message-ID: <1be0e2ae-5d2d-42a2-ac32-355f42b4dcec@gmx.de>
Date: Mon, 25 Nov 2024 16:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-9-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125005814.236669-9-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hBHFH/KtocGaneNei6HpSmM18UaZbj+QoCGQzejfMi/6BsnFzoy
 +zhfCsLveGN6c/fSFdm2KzVUQe+gE/WxdT+uXO50UGtLwL5EWCe1HSmpU48vM9k0Kwg95Rl
 DNL97zlqsGoXpNkCt/mtvd3itY1tMFS+/O3qLpSiVFbJUDpxtdroTHDWGFBjI0CYa28tAKe
 mZGkl2Z2vDHg4O2ajR46Q==
UI-OutboundReport: notjunk:1;M01:P0:kkBfJ7VdR94=;XUr3i6GxGMBeK/adBhfiRb/eBJR
 NTkIoQ7ucAblT2Y6uSGXd556Ao7avDjFH1smutVB28ivrmvucSG5jeGTcb9/iG1OU2sDmkKGc
 smktOM1hqKam7aUGXnGM0ZcIHIBhPsuQS+eYv3gDU1cyM5Q7JmuxwTV0FnNNRbNSJ549jOelo
 qfWuYqjSzOL2FYZXHH+vOOzUjvo2GMgYT48TGGJv0xEvRMcMZfo3bfWif9xCfn0xLnsOtJ3rp
 B4qdCGer4bqh7UZTfqn+HEZBx2IayHBrLeZk91iXcwLtWjDcmojP2V1ArG/pbfMKoiAfn7G04
 ycnLX5xXtXN6vWsDqh50tm8+sxYZ8zpic0gTiKHDmP9GXYiyZjxmVy5kUY6aorgWyvOcvf0jE
 3y8NjiFhx9IP9zZa2xR+k92P5M8BJ1RyCGUFfwu+BGYf8trjK3eGkaPPtXW0vrgPWRGtCtF06
 ilT1oNwSLchxYcRCB8e+l4zZsvRzF5wz64eoB+kksI+JuVG0zdg155V7owdZHhYnQYyjeiRWk
 NERejCaij5ZTN2IaoyZ2vuK2O1BdqrKdrn+9nlz4oS86tH6o+MCjqiYKf3BaKRfkmSCBMqgDd
 CUPIbayJ0lE3fZK8YyeapU8TzixTGhuWeYvz+uIh4FPJShrLbg7+okvIYDN49FkqYQbipTzlK
 smLU+01rZwnBwy0sWJC87qj0Wg2Zgfcjqp3tRSxiTKygq+LiP4wLTUlCaicQurWyOHv5b0cdn
 CEmt2amLcjtUaIpRdpzmtPcejw8Q3YWsLgtYcpN8WzahBK8M0c5vuIhWBOun9+6j/Vb1We9Gt
 RP12YUoItYe3jQYQkUwNLrqauR8LlIhhGu9O6J97RFHINykx7iawDCEJxPTjrKSo9lPL+FK0w
 /GMBkQQ2vG/jY3oluKVNcfEyy3Nx1ktHVVU+/642eAD+McaIUtk6JKMwZw4b5GK4AmnbTeKHY
 DDfJpgWXGkYL3f6BqFqvOowIhGpPb7BzfbjYZT/A+XQM/wEjVAhZTFo/UTJ/bLAu7CX7keSX3
 TUDYFXAcTB/HwaP5L8RGxlCVC1Ydk7NTTsy+ToDMJagT4dVunMZIIgEtcmRuzoQWYXWjBiu1R
 Ygq7XnWOgIFn4nuh65aHTsAJKwXP/S
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

On 25.11.24 01:58, Adriano Cordova wrote:
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
> ---
> Changes in v5:
> - Add description of net_dp
> - Change a void** for an efi_device_path**
> (no changes since v2)
>
>   include/efi_loader.h             |  6 +++++
>   lib/efi_loader/efi_device_path.c |  2 +-
>   lib/efi_loader/efi_net.c         | 44 +++++++++++++++++++++++++++++++-
>   net/lwip/wget.c                  |  1 +
>   net/wget.c                       |  1 +
>   5 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 96b204dfc3..8e7f5becbb 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev,=
 const char *devnr,
>   #endif
>
>   #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> +/* Call this to update the current device path of the efi net device */
> +void efi_net_set_dp(const char *dev, const char *server);
> +/* Call this to get the current device path of the efi net device */
> +void efi_net_get_dp(struct efi_device_path **dp);
>   void efi_net_get_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
> @@ -133,6 +137,8 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
>   #else
> +static inline void efi_net_set_dp(const char *dev, const char *server) =
{ }
> +static inline void efi_net_get_dp(struct efi_device_path **dp) { }
>   static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
>   				     struct efi_ipv4_address *mask,
>   				     struct efi_ipv4_address *gw) { }
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index 1e512bf0ea..be0b56d213 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1181,7 +1181,7 @@ efi_status_t efi_dp_from_name(const char *dev, con=
st char *devnr,
>   		dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>   				     (uintptr_t)image_addr, image_size);
>   	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
> -		dp =3D efi_dp_from_eth();
> +		efi_net_get_dp(&dp);
>   	} else if (!strcmp(dev, "Uart")) {
>   		dp =3D efi_dp_from_uart();
>   	} else {
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 3491d4c481..b448dcee51 100644
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
> @@ -999,6 +1009,38 @@ out_of_resources:
>   	return EFI_OUT_OF_RESOURCES;
>   }
>
> +/**
> + * efi_net_set_dp() - set device path of efi net device
> + *
> + * This gets called to update the device path when a new boot
> + * file is dowloaded

%s/dowloaded/downloaded/

> + *
> + * @dev:	dev to set the device path from
> + * @server:	remote server address
> + */
> +void efi_net_set_dp(const char *dev, const char *server)
> +{

If this function is called repeatedly, we are leaking memory.
I could not find where you free net_dp after a transaction.
Maybe here is the right place if net_dp is not NULL.

> +	if (!strcmp(dev, "Net"))
> +		net_dp =3D efi_dp_from_eth();

efi_dp_from_eth() may fail and return NULL.

> +	else if (!strcmp(dev, "Http"))
> +		net_dp =3D efi_dp_from_http(server);

efi_dp_from_http() may fail and return NULL.

How will errors be handled?

> +}
> +
> +/**
> + * efi_net_get_dp() - get device path of efi net device
> + *
> + * Produce a copy of the current device path
> + *
> + * @dp:		copy of the current device path

copy of the current device path or NULL on error

> + */
> +void efi_net_get_dp(struct efi_device_path **dp)

struct efi_device_path *efi_net_get_dp(struct efi_device_path *dp)
would reduce dereferencing.

> +{
> +	if (!net_dp)
> +		efi_net_set_dp("Net", NULL);

efi_net_set_dp may fail. This needs to be handled. E.g. return NULL.

> +	if (dp && net_dp)
> +		*dp =3D efi_dp_dup(net_dp);
> +}

efi_dp_dup may return NULL if out of memory.

> +
>   /**
>    * efi_net_get_addr() - get IP address information
>    *
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 3347a61e74..7bc7c6a2fe 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -217,6 +217,7 @@ static void httpc_result_cb(void *arg, httpc_result_=
t httpc_result,
>   	print_size(rx_content_len / elapsed * 1000, "/s)\n");
>   	printf("Bytes transferred =3D %lu (%lx hex)\n", ctx->size, ctx->size)=
;
>   	if (wget_info->set_bootdev) {
> +		efi_net_set_dp("Http", ctx->server_name);

Error handling is missing.

>   		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0=
),
>   				rx_content_len);
>   	}
> diff --git a/net/wget.c b/net/wget.c
> index 4bb1590410..21d3b8050a 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -442,6 +442,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>   		net_set_state(wget_loop_state);
>   		wget_info->file_size =3D net_boot_file_size;
>   		if (wget_info->method =3D=3D WGET_HTTP_METHOD_GET && wget_info->set_=
bootdev) {
> +			efi_net_set_dp("Http", NULL);

Error handling is missing.

Best regards

Heinrich

>   			efi_set_bootdev("Net", "", image_url,
>   					map_sysmem(image_load_addr, 0),
>   					net_boot_file_size);

