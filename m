Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D4ED42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DB189383;
	Tue, 12 Nov 2024 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kTq3Ulni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D70A893C2; Tue, 12 Nov 2024 14:51:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A641A891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731419497; x=1732024297; i=xypron.glpk@gmx.de;
 bh=k1tZCz0sckNJvpzUYjAQio6UVAuXcPzyIeQyZSaKrWI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kTq3UlniuIchOy4eQFaPc3at4I8Jy/u4YtHJMD6J4uXIzOQ8MDsoMExYdAk/KRZl
 hAb/KYNueJNpdQqdWi8/fj0cvQRkZD8BAetjh+7UbGbiN/R5FThiiCbeQ/EL+Dm3e
 c5wTTp1mT6tTYdoyJFaU0lMcwLEircRe9QBZ+JGA6ZwGaNS2NdDtJ4sYjXDljmk2v
 0/j2G/eb9UJvq2wkQiI8ypBppMyZzQdKXOi5IOkMy96hMNvPWA3ybgUdMtYwhHBwp
 /N3r7wsr20Q3e4YuASd8VMY/o8J0byxbFtZTp1yI5jHAXKRYIaNZ2CMQGGRpJJZd4
 Lb8Wmq+Xzal5KXQExQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wys-1t7XOH1s9M-002TMI; Tue, 12
 Nov 2024 14:51:37 +0100
Message-ID: <49ee4d70-3c1c-443f-b778-1e50e8430487@gmx.de>
Date: Tue, 12 Nov 2024 14:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] efi_loader: net: add support to send http
 requests and parse http headers
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-11-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111210959.560738-11-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BDIS/O+fKEpMuSgTK+WOtLi+sO+poxA3X6gQZlNpdj55qIjpHkr
 Ctex1d8KEvSO6sKH6clPkteD7vx3/kF2l2pIvsDKGGVFdeRFxb+ZCu0Z9U1MFVAOUOZDeX1
 rdxdE5/pVg1/9qVP7AyATV8nYmksm57aTtBxmfzu9bU5gdq516MSpclVTv5ZGTrahGhooLE
 M1oFTnk8SVPTiG1lrpTVA==
UI-OutboundReport: notjunk:1;M01:P0:Fgf+WiXiKAg=;QwIW4Gj8vRxiwaGmKf3K2/HcgMb
 xyCP/R6w1m/I+6CcW0wlhnlTXl75mGSt5EwZHZ5CbWcj3uRjJp9eng/Hg7Wctq/M7iOux+tpP
 jVIko7GAPGg/YXg6N/tEGI3S9POZ3oMG/hVU4pvykBawmEz85Q6KyZU/bnDddnVbWLJ68xXWS
 ydjPJN5SAQa2J5BtIbaop8Scx1VPrK3f95PASuLEEGTAcsoAM3Bc5tW3gSyCkDodYluxPQv2M
 OOvofU9oGUxiyzKQIhNnqLMp4ruBZzOWHX/NkJUl8UkYTvfmfclEnfkmf6jXStsDPueiO+Vwb
 EXYBjMduZ6qyHfmfkXVNyuIyk6O1sMGzrDyArk78QWYq1jFpb0ktFyS8OvJZ4ZeTqkyVhSQ4b
 jU9A1Q2yk5yaqKpBQ+9VuG2TWTmJ/lK2n283azMAVaUG7jtMySPvTXo37LJhUDd0cspRP/krx
 t8ZKi4rMZoc4IuCv0mXhP2LkIq9pHaRwkkS7x3rHx2ABmEqhC35tZubHlpKRHdZChLJcw815W
 vE5bg6rNT01/6eMQSD/AGV/hW9MA/slUQVV0DjujT4mUDIG24gyNPJT3DD8KSf7SanyKF+Zs6
 fDkMJDzIRWl13lbstUkJq4xdfgcD9NakgTWB1zuJ/NqomKYeineaJGTDcp5JwEgXhSWYiWfNK
 ZmYJzDzp4TCnsenauFWE48Vt/gwZ2l3c9Y66QMLD0wgYziuiCf6R0cB/BWeNCjOE8pRpQER5f
 PjQgG131SEKOcsHHeLzOaHLr3nLsOMGJZ9JKxMaKVW+h6NmwgjW4G9pvEXGoJRl/+ZnQe8VJW
 OFHTKcBU6FToRCz1Mx4W+j/w==
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

On 11.11.24 22:09, Adriano Cordova wrote:
> Add network-stack agnostic way to send an http request and
> parse http headers from efi drivers. This uses wget as a
> backend and communicates with it via efi_wget_info.
>
> The function efi_net_do_request allocates a buffer on behalf of an
> efi application using efi_alloc and passes it to wget to receive
> the data. If the method is GET and the buffer is too small, it
> re-allocates the buffer based on the last received Content-Length
> header and tries again. If the method is HEAD it just issues one
> request. So issuing a HEAD request (to update Content-Length) and
> then a GET request is preferred but not required.
>
> The function efi_net_parse_headers parses a raw buffer containing
> an http header into an array of EFI specific 'http_header' structs.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> Changes in v3:
> - Add a struct wget_http_info efi_wget_info for efi_net to pass to wget
>    when issuing wget requests, instead of using the old wget_info (see v=
2
>    of the series 'wget: Expose wget to applications').
> - Let a pointer to the http status code be passed to efi_net_do_request
>    for it to fill it for the client after a request.
>
>   include/efi_loader.h     |  13 ++++
>   lib/efi_loader/efi_net.c | 158 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 171 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f49f8e6be0..4d05c08441 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -16,6 +16,7 @@
>   #include <image.h>
>   #include <pe.h>
>   #include <linux/list.h>
> +#include <linux/sizes.h>
>   #include <linux/oid_registry.h>
>
>   struct blk_desc;
> @@ -136,6 +137,18 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
>   void efi_net_set_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw);
> +efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, u=
long *buffer,
> +				u32 *status_code, ulong *file_size, char *headers_buffer);
> +#define MAX_HTTP_HEADERS_SIZE SZ_64K
> +#define MAX_HTTP_HEADERS 100
> +#define MAX_HTTP_HEADER_NAME 128
> +#define MAX_HTTP_HEADER_VALUE 512
> +struct http_header {
> +	uchar name[MAX_HTTP_HEADER_NAME];
> +	uchar value[MAX_HTTP_HEADER_VALUE];
> +};
> +
> +void efi_net_parse_headers(ulong *num_headers, struct http_header *head=
ers);
>   #else
>   static inline void efi_net_set_dp(const char *dev, const char *server)=
 { }
>   static inline void efi_net_get_dp(void **dp) { }
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index d4570d4d7c..30234ae1c7 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -17,6 +17,7 @@
>
>   #include <efi_loader.h>
>   #include <dm.h>
> +#include <linux/sizes.h>
>   #include <malloc.h>
>   #include <vsprintf.h>
>   #include <net.h>
> @@ -34,6 +35,12 @@ static int rx_packet_num;
>   static struct efi_net_obj *netobj;
>   static struct efi_device_path *net_dp;
>
> +static struct wget_http_info efi_wget_info =3D {
> +	.set_bootdev =3D false,
> +	.check_buffer_size =3D true,
> +
> +};
> +
>   /*
>    * The notification function of this event is called in every timer cy=
cle
>    * to check if a new network packet has been received.
> @@ -1003,6 +1010,10 @@ out_of_resources:
>   	return EFI_OUT_OF_RESOURCES;
>   }
>
> +/**
> + * efi_net_set_dp() - set device path of efi net device
> + *
> + */
>   void efi_net_set_dp(const char *dev, const char *server)
>   {
>   	if (!strcmp(dev, "Net"))
> @@ -1011,6 +1022,10 @@ void efi_net_set_dp(const char *dev, const char *=
server)
>   		net_dp =3D efi_dp_from_http(server);
>   }
>
> +/**
> + * efi_net_set_dp() - get device path of efi net device
> + *
> + */
>   void efi_net_get_dp(void **dp)
>   {
>   	if (!net_dp)
> @@ -1019,6 +1034,10 @@ void efi_net_get_dp(void **dp)
>   		*dp =3D efi_dp_dup(net_dp);
>   }
>
> +/**
> + * efi_net_get_addr() - get IP address information
> + *
> + */
>   void efi_net_get_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw)
> @@ -1068,6 +1087,10 @@ void efi_net_get_addr(struct efi_ipv4_address *ip=
,
>   #endif
>   }
>
> +/**
> + * efi_net_set_addr() - set IP address information
> + *
> + */
>   void efi_net_set_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw)
> @@ -1117,3 +1140,138 @@ void efi_net_set_addr(struct efi_ipv4_address *i=
p,
>   		memcpy((void *)&net_netmask, (void *)mask, 4);
>   #endif
>   }
> +
> +/**
> + * efi_net_set_buffer() - allocate a buffer of min 64K

Please, describe the parameters.

> + *
> + */
> +static efi_status_t efi_net_set_buffer(ulong *buffer, ulong size)

Please, use size_t for sizes.

All invocations use size =3D 0. So we should drop the parameter.

> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +
> +	if (size < SZ_64K)
> +		size =3D SZ_64K;
> +
> +	efi_free_pool((void *)*buffer);
> +
> +	*buffer =3D (ulong)efi_alloc(size);

efi_alloc() returns a pointer.

There is no good reason to store pointers in ulong. Please, use void *
for pointers.

Patch 13/15 shows the resulting confusion:

In efi_http_send_data() you assume http_load_addr is a sandbox virtual
address:

   ptr =3D map_sysmem(inst->http_load_addr + inst->current_offset,
transfer_size);

And a few lines below you assume that it is a pointer:

   efi_free_pool((void *)inst->http_load_addr);

We should keep sandbox specific addresses which need map_sysmem() and
map_to_sysmem() out of the EFI implementation as far as possible.

So let parameter buffer be of type **void here.

We need a test that we can run both on the sandbox and on Q

> +	if (!*buffer)
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +
> +	efi_wget_info.buffer_size =3D size;
> +	//debug("efi_net: set buffer of size %lu at %lu\n", size, *buffer);

It would be fine to have a debug statement here but, please, remove
lines that only where used during your development process.

Nits:
As described in doc/develop/codingstyle.rst:224:

"* Put a blank line before the last ``return`` in a function unless it
is the only line:"

> +	return ret;
> +}
> +
> +/**
> + * efi_net_parse_headers() - parse HTTP headers
> + *
> + * Parses the raw buffer efi_wget_info.headers into an array headers
> + * of efi structs http_headers. The array should be at least
> + * MAX_HTTP_HEADERS long.

Please, describe the parameters.

> + */
> +void efi_net_parse_headers(ulong *num_headers, struct http_header *head=
ers)
> +{
> +	if (!num_headers || !headers)
> +		return;
> +
> +	// Populate info with http headers.
> +	*num_headers =3D 0;
> +	const uchar *line_start =3D efi_wget_info.headers;
> +	const uchar *line_end;
> +	ulong count;
> +	struct http_header *current_header;
> +	const uchar *separator;
> +	size_t name_length, value_length;
> +
> +	// Skip the first line (request or status line)
> +	line_end =3D strstr(line_start, "\r\n");
> +
> +	if (line_end)
> +		line_start =3D line_end + 2;
> +
> +	while ((line_end =3D strstr(line_start, "\r\n")) !=3D NULL) {
> +		count =3D *num_headers;
> +		if (line_start =3D=3D line_end || count >=3D MAX_HTTP_HEADERS)
> +			break;
> +		current_header =3D headers + count;
> +		separator =3D strchr(line_start, ':');
> +		if (separator) {
> +			name_length =3D separator - line_start;
> +			++separator;
> +			while (*separator =3D=3D ' ')
> +				++separator;
> +			value_length =3D line_end - separator;
> +			if (name_length < MAX_HTTP_HEADER_NAME &&
> +			    value_length < MAX_HTTP_HEADER_VALUE) {
> +				strncpy(current_header->name, line_start, name_length);
> +				current_header->name[name_length] =3D '\0';
> +				strncpy(current_header->value, separator, value_length);
> +				current_header->value[value_length] =3D '\0';
> +				(*num_headers)++;
> +			}
> +		}
> +		line_start =3D line_end + 2;
> +	}
> +}
> +
> +/**
> + * efi_net_do_request() - issue an HTTP request using wget

Please, complete the function description.

> + *
> + */
> +efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, u=
long *buffer,

Please, use void **buffer. Below you are assuming *buffer is a pointer
and not a sandbox virtual address.

> +				u32 *status_code, ulong *file_size, char *headers_buffer)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	int wget_ret;
> +	static bool last_head;
> +
> +	if (!buffer || !file_size)
> +		return EFI_ABORTED;
> +
> +	efi_wget_info.method =3D (enum wget_http_method)method;

Parameter method has type 'enum wget_http_method'. Please, remove the
superfluous conversion.

Best regards

Heinrich

> +	efi_wget_info.headers =3D headers_buffer;
> +
> +	switch (method) {
> +	case HTTP_METHOD_GET:
> +		ret =3D efi_net_set_buffer(buffer, last_head ? efi_wget_info.hdr_cont=
_len : 0);
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +		wget_ret =3D wget_request((ulong)*buffer, url, &efi_wget_info);
> +		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
> +			// Try again with updated buffer size
> +			ret =3D efi_net_set_buffer(buffer, (ulong)efi_wget_info.hdr_cont_len=
);
> +			if (ret !=3D EFI_SUCCESS)
> +				goto out;
> +			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
> +				efi_free_pool((void *)*buffer);
> +				ret =3D EFI_DEVICE_ERROR;
> +				goto out;
> +			}
> +		} else if (wget_ret) {
> +			efi_free_pool((void *)*buffer);
> +			ret =3D EFI_DEVICE_ERROR;
> +			goto out;
> +		}
> +		// Pass the actual number of received bytes to the application
> +		*file_size =3D efi_wget_info.file_size;
> +		*status_code =3D efi_wget_info.status_code;
> +		last_head =3D false;
> +		break;
> +	case HTTP_METHOD_HEAD:
> +		ret =3D efi_net_set_buffer(buffer, 0);
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +		wget_request((ulong)*buffer, url, &efi_wget_info);
> +		*file_size =3D 0;
> +		*status_code =3D efi_wget_info.status_code;
> +		last_head =3D true;
> +		break;
> +	default:
> +		ret =3D EFI_UNSUPPORTED;
> +		break;
> +	}
> +
> +out:
> +	return ret;
> +}

