Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F66D44D5C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6DF891D2;
	Wed,  6 Nov 2024 14:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zuk7gszy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DCC891D2; Wed,  6 Nov 2024 14:50:33 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934B3891FD
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so52466545e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730901030; x=1731505830; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9MV5WqJhSqq2l46GcwA2DWoiqUYtiUGiEtKTmWehno=;
 b=Zuk7gszyNlglrdL+9wVqrLSdcZamogaXukoG3N5IzlBVeDBfhIvnAvyoS00jzB+Z5s
 KQzHTNHiMQnI6V4Uj6ylpgUtb7HZ5Xgyw5U6vJ1lsXi1mwt67EF6HQt1b3ardW4dzAbn
 G2Eo4EhYBZP+im/scpyztDdDQXFR/B4LYqrVjKSCjdTNFoeVcD2R9jwps8ENS6EaitLb
 0EI7u5lV366XKea5FvHJ4F1UxPqQXjEC2gWQ9vfaLaBdBHNCkwtXqFNBwb8dtboLBvsZ
 KBtW52pbzz8yX7DQNwVGci8ncuRKGJ3wRKlCMwtC/J/eIWFf9pj5Rws0qD/iyZn2SpXM
 R09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901030; x=1731505830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9MV5WqJhSqq2l46GcwA2DWoiqUYtiUGiEtKTmWehno=;
 b=thDMbRHYlv1JKWiF6IkqBNUz4L8eVhEZ7jbmKc/oMJWXuseX/Ro5pgQe6HLACZXhxL
 xPAbpJnSGvM5OleKvZEA9wMP7CeOdgVuuf0tK+iL62Zo8n7s44rmawRAU7Y5FA5euqz6
 9OYDuvMrNIiqoBnKDPbma5UlMd++crAz9BVSPGkgoTztBGEadOstF3qAB3zgdcDURVkj
 8it+Y5gtHkhx8qGMImVBv5VxuS6AQ4nnUT3CLhJAtAxq63DipofsnBAytQnfISTaoW/l
 e1o5CuLNpgm+xp4hLDaqj0vZTVlOArMPwVWaFjAOclt4UCrLPF3W6Bbrk8X3xmpPkOTz
 i/zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQhQfT6G6Igv8RkHs/IIr33qa8ApoUqM7zKPEjJZwQH4Jf8SUhvvVxRKN3AILzmD9e7lEMcmU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbj9sc32hMBhBXmc4y6QWAnfStXcfq5DPo2zSbJLvxP4IWduS8
 7Z4/YBW0Vl/gNAOzcafKeSIV0SaFHejRiF5UciAyOOKhIgEQJCw9GK9DAZifrI0=
X-Google-Smtp-Source: AGHT+IEbPILIBqBcMTfoCz25MlG3PkV8XqxVrCjRQs+B557nank64RW17kqldrSJZi/Ckb6G+kZ6yQ==
X-Received: by 2002:a05:600c:198a:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-431bb9855f6mr252894465e9.13.1730901029914; 
 Wed, 06 Nov 2024 05:50:29 -0800 (PST)
Received: from [172.20.141.182] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa752d2fsm23749885e9.44.2024.11.06.05.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 05:50:29 -0800 (PST)
Message-ID: <fc4c79a4-2a78-41c5-8ea9-2c19e91d64b9@linaro.org>
Date: Wed, 6 Nov 2024 13:50:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: lwip: Enable https:// support for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Ilias,

On 10/24/24 12:24, Ilias Apalodimas wrote:
> With the recent changes of lwip & mbedTLS we can now download from
> https:// urls instead of just http://.
> Adjust our wget lwip version parsing to support both URLs.
> While at it adjust the default TCP window for QEMU since https seems to
> require at least 16384
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  cmd/Kconfig      | 19 ++++++++++++
>  net/lwip/Kconfig |  2 +-
>  net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 91 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 3ee70f31b142..1d90a884e2c1 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2126,6 +2126,25 @@ config CMD_WGET
>  	  wget is a simple command to download kernel, or other files,
>  	  from a http server over TCP.
>  
> +config WGET_HTTPS
> +	bool "wget https"
> +	depends on CMD_WGET
> +	depends on PROT_TCP_LWIP
> +	depends on MBEDTLS_LIB
> +        select SHA256
> +        select RSA
> +        select ASYMMETRIC_KEY_TYPE
> +        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +        select X509_CERTIFICATE_PARSER
> +        select PKCS7_MESSAGE_PARSER
> +	select MBEDTLS_LIB_CRYPTO
> +	select MBEDTLS_LIB_TLS
> +	select RSA_VERIFY_WITH_PKEY
> +	select X509_CERTIFICATE_PARSER
> +	select PKCS7_MESSAGE_PARSER
> +	help
> +	  Enable TLS over http for wget.

s/http/HTTP/
Maybe add "This adds support for https:// URLs"?

> +
>  endif  # if CMD_NET
>  
>  config CMD_PXE
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> index 8a67de4cf335..a9ae9bf7fa2a 100644
> --- a/net/lwip/Kconfig
> +++ b/net/lwip/Kconfig
> @@ -37,7 +37,7 @@ config PROT_UDP_LWIP
>  
>  config LWIP_TCP_WND
>  	int "Value of TCP_WND"
> -	default 8000 if ARCH_QEMU
> +	default 32768 if ARCH_QEMU
>  	default 3000000
>  	help
>  	  Default value for TCP_WND in the lwIP configuration
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b495ebd1aa96..1a2ecdcddf34 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -7,13 +7,17 @@
>  #include <efi_loader.h>
>  #include <image.h>
>  #include <lwip/apps/http_client.h>
> +#include "lwip/altcp_tls.h"
>  #include <lwip/timeouts.h>
> +#include <rng.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <time.h>
> +#include <dm/uclass.h>
>  
>  #define SERVER_NAME_SIZE 200
>  #define HTTP_PORT_DEFAULT 80
> +#define HTTPS_PORT_DEFAULT 443
>  #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
>  
>  enum done_state {
> @@ -32,18 +36,53 @@ struct wget_ctx {
>  	enum done_state done;
>  };
>  
> +bool wget_validate_uri(char *uri);
> +
> +int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
> +			  size_t *olen)
> +{
> +	struct udevice *dev;
> +	u64 rng = 0;
> +	int ret;
> +
> +	*olen = 0;
> +
> +	ret = uclass_get_device(UCLASS_RNG, 0, &dev);
> +	if (ret) {
> +		log_err("Failed to get an rng: %d\n", ret);
> +		return ret;
> +	}
> +	ret = dm_rng_read(dev, &rng, sizeof(rng));
> +	if (ret)
> +		return ret;
> +
> +	memcpy(output, &rng, len);
> +	*olen = sizeof(rng);
> +
> +	return 0;
> +}
> +
>  static int parse_url(char *url, char *host, u16 *port, char **path)
>  {
>  	char *p, *pp;
>  	long lport;
> +	size_t prefix_len = 0;
> +
> +	if (!wget_validate_uri(url)) {
> +		log_err("Invalid URL. Use http(s)://\n");
> +		return -EINVAL;
> +	}
>  
> +	*port = HTTP_PORT_DEFAULT;
> +	prefix_len = strlen("http://");
>  	p = strstr(url, "http://");
>  	if (!p) {
> -		log_err("only http:// is supported\n");
> -		return -EINVAL;
> +		p = strstr(url, "https://");
> +		prefix_len = strlen("https://");
> +		*port = HTTPS_PORT_DEFAULT;
>  	}
>  
> -	p += strlen("http://");
> +	p += prefix_len;
>  
>  	/* Parse hostname */
>  	pp = strchr(p, ':');
> @@ -67,9 +106,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
>  		if (lport > 65535)
>  			return -EINVAL;
>  		*port = (u16)lport;
> -	} else {
> -		*port = HTTP_PORT_DEFAULT;
>  	}
> +
>  	if (*pp != '/')
>  		return -EINVAL;
>  	*path = pp;
> @@ -210,6 +248,9 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
>  	char server_name[SERVER_NAME_SIZE];
> +#if defined CONFIG_WGET_HTTPS
> +	altcp_allocator_t tls_allocator;
> +#endif
>  	httpc_connection_t conn;
>  	httpc_state_t *state;
>  	struct netif *netif;
> @@ -232,6 +273,22 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  		return -1;
>  
>  	memset(&conn, 0, sizeof(conn));
> +#if defined CONFIG_WGET_HTTPS
> +	if (port == HTTPS_PORT_DEFAULT) {

Does this mean the port has to be 443 for HTTPS to be used? Or that
plain HTTP is not possible over port 443? That would be overly restrictive
IMO.

> +		tls_allocator.alloc = &altcp_tls_alloc;
> +		tls_allocator.arg =
> +			altcp_tls_create_config_client(NULL, 0, server_name);
> +
> +		if (!tls_allocator.arg) {
> +			log_err("error: Cannot create a TLS connection\n");
> +			net_lwip_remove_netif(netif);
> +			return -1;
> +		}
> +
> +		conn.altcp_allocator = &tls_allocator;
> +	}
> +#endif
> +
>  	conn.result_fn = httpc_result_cb;
>  	ctx.path = path;
>  	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> @@ -316,6 +373,7 @@ bool wget_validate_uri(char *uri)
>  	char c;
>  	bool ret = true;
>  	char *str_copy, *s, *authority;
> +	size_t prefix_len = 0;
>  
>  	for (c = 0x1; c < 0x21; c++) {
>  		if (strchr(uri, c)) {
> @@ -323,15 +381,21 @@ bool wget_validate_uri(char *uri)
>  			return false;
>  		}
>  	}
> +
>  	if (strchr(uri, 0x7f)) {
>  		log_err("invalid character is used\n");
>  		return false;
>  	}
>  
> -	if (strncmp(uri, "http://", 7)) {
> -		log_err("only http:// is supported\n");
> +	if (!strncmp(uri, "http://", strlen("http://"))) {
> +		prefix_len = strlen("http://");
> +	} else if (!strncmp(uri, "https://", strlen("https://"))) {
> +		prefix_len = strlen("https://");
> +	} else {
> +		log_err("only http(s):// is supported\n");
>  		return false;
>  	}
> +
>  	str_copy = strdup(uri);
>  	if (!str_copy)
>  		return false;

Thanks,
-- 
Jerome
