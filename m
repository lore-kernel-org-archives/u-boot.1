Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781DFE69EA6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 10:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7082893E8;
	Tue,  3 Dec 2024 11:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TRuxqRq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B87892DA; Tue,  3 Dec 2024 11:51:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA7889481
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 11:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733223111; x=1733827911; i=xypron.glpk@gmx.de;
 bh=AeHmI5Eos9XNI5Hmp30ltSTN3jjVCwU6ye4gX/11XkA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TRuxqRq8kjIh2lDGMFRYfMG6jxdkai4gsk4LLMH8Gu/ZRy917H8hLkMogrbBJLRo
 bhP2FeGozdJcrxcvmA8L9FWCzRSEwcMdyj7QBEsdg+zx7PCFoy2wbUr2ls8owm8I0
 wiz5SGlxMqigJI1eobULc3KwVVuKh2w/cN8bZa4PSfZEwDSFyD4FUxtXha3MqgS+i
 XFAamFDMql+xpKBl9iAFZRbSlnZR1eqldJ7fgavH0UxDu8ynDsCvwXM8R0TSZhYAh
 yVu/7GknSPXVxf0NnixEUMQlFzFvjruYbf06ih6pl0U0YBzLQEjqWXlwrkDHdzPod
 hN1102jiNihjKSW74w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1sy10f0zQA-00RyDg; Tue, 03
 Dec 2024 11:51:51 +0100
Message-ID: <bd88b800-a650-4512-843f-9ac4436169e5@gmx.de>
Date: Tue, 3 Dec 2024 11:51:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-7-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128144416.604126-7-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cqqmtUAxTLM91FG8SdlkH2YW9nvZnklal7DJp6tN4GK7VnMluFe
 wvTSxutOzn8xSS+SK00iB4yZ+T6jTbk3BGsVqsi8ThoikkCWiBzL3PkOoNFpFmekpnOaiJH
 huU9K2ZTmhHpzwBlEFjhX6DyNhIkO9DyFXUo823iG7hTtSjNHA6I2Em8RSAPnOzogPrDsHz
 hImWzYpX3DBjx2XEe+MlA==
UI-OutboundReport: notjunk:1;M01:P0:mM3CpH3Kz1c=;AgQHPS1qx9EHjmD7IriolfhD8AA
 Svrw6uwyxPDVtQK2+A1+5TsVxk4y1Br6VlL2GeqTE3ZNLX5vNRIsAUwT95i90cyGycZQuZo8S
 0n6vGy9G9gaZKEOHV5N/pWML0UnB1tAm21EGbNIlk2pIXx6nGNPUaofCQ7Spxy7U+CZJcWE0p
 b3LMe6UMoyjmah5RhVu3JV9GA2ZkhPb1O5bDcRmCFlYGWSepgZpmb1PwWJSxByyLnTc7jFqiJ
 LeYOTEhEvXFrhFfKSTSFADe6RhvgkULs1e18fR2vuwwcdbpSBOZbZxIixPw03b398tY8sAj48
 P0Jm6Z04sbTzCVJyluo0P8DAba9iwfsG2RDjjgjCIumi6GWR5jUkTW59yiQbPPiQEgmLB3fZn
 sYN+A8xYC7bPq8X+sjNG3c6NOXtoJ4I+okM+j7ThfsGEMrLBLiyA3jct+2eBxBMWZdM/bQX0C
 C0VL47gy6x85bEAjJZ6VBy0KlNu653v7eyhfAJ/nQoT6vzowpT2oCYNDiFEwJrkefHFwPzOJW
 qmA8kS60ydnlnuVl6bsFETkkH2iBUYncERQS/HmsxL51yg+hhIUXGF5yn+Vxcg25r1Xnuk6RB
 +covCK9j+ZbDKUcJEXeAFQ69uiMgyDgLGyuR1zjDNcHfYtJbgFX9fqR3wcFB27M1suX9q4BIP
 9f5ANvQWX4gjeN/hF5yFBTgYeOwdyb0HzsSNMJfoRrtr+nr2yAjIZD1pzLsFoTXsMavlpM/Sx
 pEm1zrYHMSubjze4dqJRgiJwEtIaey+g6drqoi02eMyqVREl0J6cW6zB+OqkUhHw0bwkU42UQ
 5n48Q1LttQwzNnEMKyG1PGhcrWy/zRPajnW8O9A0UBKM2qtj+qesAiWFBVbo4GJvQZeDUT1Kw
 UwcTNRBn5QdMcFspfm0PdX5CA40+iSOY2v0cDBvwuTa7uBFwvtEle2l+cS5+HjFHYjvABwGrB
 rsiqF89UHzoPSTQJA2Qj67tkpdJu+MVcn4h0/eaB7qSzgJir6qLtjGsPWyXuYX/5KA+SJ5POS
 cVktV9n+UyEksQFKzIN1pPUOW/9vYN741O5GjPmDooFuJs5Mx0QVWVr34xuzEOKXr9rk2h0+e
 HVK8vM/e5+f4djBoD17tuGVky/xT7H
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
> Add the functions efi_net_set_addr and  efi_net_get_addr to set
> and get the ip address from efi code in a network agnostic way.
> This could also go in net_common, or be compiled conditionally
> for each network stack.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> (no changes since v5)
> Changes in v5:
> - When possible use sizeof in memcpy instead of hardcoded value
>
> Changes in v4:
>   - Removed unnecessary casts
>   - Changed char *ipstr by char ipstr[].
>
> (no changes since v2)
>   include/efi_loader.h     |  16 +++++
>   lib/efi_loader/efi_net.c | 125 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 39809eac1b..612bc42816 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -125,6 +125,22 @@ static inline void efi_set_bootdev(const char *dev,=
 const char *devnr,
>   				   size_t buffer_size) { }
>   #endif
>
> +#if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> +void efi_net_get_addr(struct efi_ipv4_address *ip,
> +		      struct efi_ipv4_address *mask,
> +		      struct efi_ipv4_address *gw);
> +void efi_net_set_addr(struct efi_ipv4_address *ip,
> +		      struct efi_ipv4_address *mask,
> +		      struct efi_ipv4_address *gw);
> +#else
> +static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
> +				     struct efi_ipv4_address *mask,
> +				     struct efi_ipv4_address *gw) { }
> +static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
> +				     struct efi_ipv4_address *mask,
> +				     struct efi_ipv4_address *gw) { }
> +#endif
> +
>   /* Maximum number of configuration tables */
>   #define EFI_MAX_CONFIGURATION_TABLES 16
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 7cd536705f..3491d4c481 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -17,6 +17,7 @@
>
>   #include <efi_loader.h>
>   #include <malloc.h>
> +#include <vsprintf.h>
>   #include <net.h>
>
>   static const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_G=
UID;
> @@ -997,3 +998,127 @@ out_of_resources:
>   	printf("ERROR: Out of memory\n");
>   	return EFI_OUT_OF_RESOURCES;
>   }
> +
> +/**
> + * efi_net_get_addr() - get IP address information
> + *
> + * Copy the current IP address, mask, and gateway into the
> + * efi_ipv4_address structs pointed to by ip, mask and gw,
> + * respectively.
> + *
> + * @ip:		pointer to an efi_ipv4_address struct to
> + *		be filled with the current IP address
> + * @mask:	pointer to an efi_ipv4_address struct to
> + *		be filled with the current network mask
> + * @gw:		pointer to an efi_ipv4_address struct to be
> + *		filled with the current network gateway
> + */
> +void efi_net_get_addr(struct efi_ipv4_address *ip,
> +		      struct efi_ipv4_address *mask,
> +		      struct efi_ipv4_address *gw)
> +{
> +#ifdef CONFIG_NET_LWIP
> +	char ipstr[] =3D "ipaddr\0\0";
> +	char maskstr[] =3D "netmask\0\0";
> +	char gwstr[] =3D "gatewayip\0\0";
> +	int idx;
> +	struct in_addr tmp;
> +	char *env;
> +
> +	idx =3D dev_seq(eth_get_dev());
> +
> +	if (idx < 0 || idx > 99) {
> +		log_err("unexpected idx %d\n", idx);
> +		return;
> +	}
> +
> +	if (idx) {
> +		sprintf(ipstr, "ipaddr%d", idx);
> +		sprintf(maskstr, "netmask%d", idx);
> +		sprintf(gwstr, "gatewayip%d", idx);
> +	}
> +
> +	env =3D env_get(ipstr);
> +	if (env && ip) {
> +		tmp =3D string_to_ip(env);
> +		memcpy(ip, &tmp, sizeof(tmp));
> +	}
> +
> +	env =3D env_get(maskstr);
> +	if (env && mask) {
> +		tmp =3D string_to_ip(env);
> +		memcpy(mask, &tmp, sizeof(tmp));
> +	}
> +	env =3D env_get(gwstr);
> +	if (env && gw) {
> +		tmp =3D string_to_ip(env);
> +		memcpy(gw, &tmp, sizeof(tmp));
> +	}
> +#else
> +	if (ip)
> +		memcpy(ip, &net_ip, sizeof(net_ip));
> +	if (mask)
> +		memcpy(mask, &net_netmask, sizeof(net_netmask));
> +#endif
> +}
> +
> +/**
> + * efi_net_set_addr() - set IP address information
> + *
> + * Set the current IP address, mask, and gateway to the
> + * efi_ipv4_address structs pointed to by ip, mask and gw,
> + * respectively.
> + *
> + * @ip:		pointer to new IP address
> + * @mask:	pointer to new network mask to set
> + * @gw:		pointer to new network gateway
> + */
> +void efi_net_set_addr(struct efi_ipv4_address *ip,
> +		      struct efi_ipv4_address *mask,
> +		      struct efi_ipv4_address *gw)
> +{
> +#ifdef CONFIG_NET_LWIP
> +	char ipstr[] =3D "ipaddr\0\0";
> +	char maskstr[] =3D "netmask\0\0";
> +	char gwstr[] =3D "gatewayip\0\0";
> +	int idx;
> +	struct in_addr *addr;
> +	char tmp[46];
> +
> +	idx =3D dev_seq(eth_get_dev());
> +
> +	if (idx < 0 || idx > 99) {
> +		log_err("unexpected idx %d\n", idx);
> +		return;
> +	}

The same logic can be found in LWIP's dhcp_loop(), get_udev_ipv4_info().

After this series I think it is time to carve it out into a function.

It is unclear to me form where the idx > 99 in the LWIP stack is
derived. struct udevice device defines seq_ as integer.

> +
> +	if (idx) {
> +		sprintf(ipstr, "ipaddr%d", idx);
> +		sprintf(maskstr, "netmask%d", idx);
> +		sprintf(gwstr, "gatewayip%d", idx);

@Jerome,

The usage of environment variables ipaddr#, netmask#, gatewayip# by the
LWIP stack should be documented in doc/usage/environment.rst. Could you,
please, provide a patch.

For this patch

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +	}
> +
> +	if (ip) {
> +		addr =3D (struct in_addr *)ip;
> +		ip_to_string(*addr, tmp);
> +		env_set(ipstr, tmp);
> +	}
> +
> +	if (mask) {
> +		addr =3D (struct in_addr *)mask;
> +		ip_to_string(*addr, tmp);
> +		env_set(maskstr, tmp);
> +	}
> +
> +	if (gw) {
> +		addr =3D (struct in_addr *)gw;
> +		ip_to_string(*addr, tmp);
> +		env_set(gwstr, tmp);
> +	}
> +#else
> +	if (ip)
> +		memcpy(&net_ip, ip, sizeof(*ip));
> +	if (mask)
> +		memcpy(&net_netmask, mask, sizeof(*mask));
> +#endif
> +}

