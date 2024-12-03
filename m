Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431FFE64A80
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 11:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A395089647;
	Tue,  3 Dec 2024 12:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YT9v92E1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16F58964B; Tue,  3 Dec 2024 12:48:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4D989048
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 12:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733226520; x=1733831320; i=xypron.glpk@gmx.de;
 bh=NIuWhH1kjsVW4F5zaWfEhikgx1yd8wzb7fAF6FucZMk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YT9v92E1JreJscgysv6KwcIOzKlVfxPxqXKTCDo7LENA9wlFPdHpWsCJ7qEvZZgF
 zQ7OAVUtc54KSZzsiUDcsQcbmvZQsFeMpgTPspEkvhpcySl2fM3XuqQrexpNDI9UB
 mxwqz+9DhaO+MJsIFLh8oqty13g3JGT3w3UyOfIiiHC0kDMka3x4F9axnYsKXCVyn
 +Frs5mqv3kbRaSqWNZ5dy0BQp6HyY20v6h3DOEfscTvhgOlFvLIouXOj4v93T/ud0
 8woB56bDCNLZssRxvze3FnBfL0hvkIQUJC4JB/AgAirJ2nIW++wsqhMlzgw0HhdAK
 vp89yOkgPzzRTrUJgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1taNkM0Rd0-014JVh; Tue, 03
 Dec 2024 12:48:40 +0100
Message-ID: <a8a92ac4-ce81-4b5f-82c6-ba2ec4a343d3@gmx.de>
Date: Tue, 3 Dec 2024 12:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] efi_loader: net: add support to send http
 requests and parse http headers
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-10-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128144416.604126-10-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+SdkEPbszK9r6Lx8Q2PK/fR4CUXgrMwOrd510KeTz+QjFqrPWoc
 4cVyqcEvSh24M/GkRkrCjoFeWpHUqqxJR8k1FARzZVFFkNUoDL1PMTQnKK9fzgtAC93DGnE
 X0aGNJb5pdREp2ZjTbiaMcdQXCaFeLztP/vKhEbQxY653uMf20bGRVv3ltgbNadDH1TgMxb
 l+W9SmnqZ75OFicsrXM4w==
UI-OutboundReport: notjunk:1;M01:P0:y9vqHssIhhQ=;h2M7aHkYDFxhV960kikGPob0/hn
 Ilzm7Z3ZznYJhMSI1PKk5WI+s/hHftVwsDK471tSrnYUlZoXUC04goI4wknVmEAEPpqtqShKV
 +N1SatbMjmnvjoxjH2cUAPWYSAr2aBwew4yBgh5ZsoMFgS+QB7rh7U0hjyBJZu7oy8K4PMQgA
 jrqJ4pHYsJxDBQBcFHwGcfmK8sLIp6cz+294Kiq+ZGp2D5tuYhKgonxzdRO7lxCHfoR4YHsmE
 leRcoS+u3KtMgTs0zCF9OJK15NfXkZrDKIwEKJhJ72xntAMb9Za1WI5ZAUUMpdOqGN16xjlaW
 yGGJVF5BFxNqCVEzpKY5BGG56K16mY3Ss8fNgeWzZUEvPnG2A2LhTzCW8jOVLvjU/YASZmOnD
 reld4NWVGmVEoCQVUSKlfQx3NauiW/aaA8ruHdXvyMERAXzANVC2zhneKBbHtTntoOfy+rVoA
 Z3KjuGFLjVjiAGGKEajL2+OKOdS57PXppQoLL01TKkKk3T37NN4TjCsQJwD6UuTi7vSj/uWaV
 ZJIcSOUD9d1GdfCNXVHQ1alWrIXPZl5Z2VoJlIHmb1E3g5XyBdMrEKZ5WQE/n+QH8yhYIIl9X
 2dmk4kyLtslnhJO9DHNI74ybHL47wGNw5daFMI798TLhYto2VHWGYQQpw2Og6V2yfde9wc/VX
 ytmqPyiG79lJMnMHUaiVKJBxIjs5ijHZGwEfNPzMydPTOfBZ7pbt41MqFUVCgnEvBcCvFDnQi
 M+1SGHN70CUbjLBkdI4nQ8gzBM7W4kFs6+7ZoTNc7OG7Rd2edksWEt5c/1J9vsNQn3KLLeYc/
 yyzNJagGb5pnEKbcSHJEUTEXT+TwftmplKvM5b6bPTuByKgDhNZFkx1CS6RKxTNuCv/d8V+PZ
 geC8leFpCoSzOcboSyZy46F8+buKGge2VcQOGypB9WidyKSlyMbZkZtY6v8nYi6NGcqjB7S5A
 FvJPbYJcGhDsk+o7/Ll71b5pMZsMm8/j9mnBUYV+vd8ZimN/B8AUYSw3ATrB2KTkkxh57GqYM
 c/rMleefd2sPGVOpbjrah1vBzHtid8LInXaYO68yp2Rwog/iKogfFLDq0YNvaI7cpE5Sl000T
 QuBwqwVaBRgepr5EZEN+8uNBpORQhr
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

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v4)
>
> Changes in v4:
> - Remove void* casts
> - Add documentation
>
> Changes in v3:
> - Add a struct wget_http_info efi_wget_info for efi_net to pass to wget
>    when issuing wget requests, instead of using the old wget_info (see v=
2
>    of the series 'wget: Expose wget to applications').
> - Let a pointer to the http status code be passed to efi_net_do_request
>    for it to fill it for the client after a request.
>   include/efi_loader.h     |  13 ++++
>   lib/efi_loader/efi_net.c | 155 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 168 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 0da0248db4..b6f865ca76 100644
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
> +efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, v=
oid **buffer,
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
>   static inline void efi_net_get_dp(struct efi_device_path **dp) { }
>   static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index e8af2e3d95..368f62c5b2 100644
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
> @@ -40,6 +41,12 @@ static struct efi_net_obj *netobj;
>    */
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
> @@ -1175,3 +1182,151 @@ void efi_net_set_addr(struct efi_ipv4_address *i=
p,
>   		memcpy(&net_netmask, mask, sizeof(*mask));
>   #endif
>   }
> +
> +/**
> + * efi_net_set_buffer() - allocate a buffer of min 64K
> + *
> + * @buffer:	allocated buffer
> + * @size:	desired buffer size
> + * Return:	status code
> + */
> +static efi_status_t efi_net_set_buffer(void **buffer, size_t size)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +
> +	if (size < SZ_64K)
> +		size =3D SZ_64K;
> +
> +	efi_free_pool(*buffer);
> +
> +	*buffer =3D efi_alloc(size);
> +	if (!*buffer)
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +
> +	efi_wget_info.buffer_size =3D (ulong)size;
> +
> +	return ret;
> +}
> +
> +/**
> + * efi_net_parse_headers() - parse HTTP headers
> + *
> + * Parses the raw buffer efi_wget_info.headers into an array headers
> + * of efi structs http_headers. The array should be at least
> + * MAX_HTTP_HEADERS long.
> + *
> + * @num_headers:	number of headers
> + * @headers:		caller provided array of struct http_headers
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
> + *
> + * @url:		url
> + * @method:		HTTP method
> + * @buffer:		data buffer
> + * @status_code:	HTTP status code
> + * @file_size:		file size in bytes
> + * @headers_buffer:	headers buffer
> + * Return:		status code
> + */
> +efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, v=
oid **buffer,
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
> +	efi_wget_info.headers =3D headers_buffer;
> +
> +	switch (method) {
> +	case HTTP_METHOD_GET:
> +		ret =3D efi_net_set_buffer(buffer, last_head ? (size_t)efi_wget_info.=
hdr_cont_len : 0);
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +		wget_ret =3D wget_request((ulong)*buffer, url, &efi_wget_info);
> +		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
> +			// Try again with updated buffer size
> +			ret =3D efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_le=
n);
> +			if (ret !=3D EFI_SUCCESS)
> +				goto out;
> +			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
> +				efi_free_pool(*buffer);
> +				ret =3D EFI_DEVICE_ERROR;
> +				goto out;
> +			}
> +		} else if (wget_ret) {
> +			efi_free_pool(*buffer);
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

