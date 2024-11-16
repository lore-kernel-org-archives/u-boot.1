Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22FFD68BF6
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 20:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50AC0896CE;
	Sat, 16 Nov 2024 21:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V+xP8q8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1428896E1; Sat, 16 Nov 2024 21:29:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5428907B
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 21:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731788950; x=1732393750; i=xypron.glpk@gmx.de;
 bh=I1Gc5iHCuKO6mJ85CIMHjv6BSC5LeCnp00jNrDvnSbw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V+xP8q8sbxoZLUdaPBZRljwPW/S01O5GtmhkhOdbeMh+Rn3oG/xPy7+Js2y1cR4q
 LCUo3sp8BsPK7VLDem1OnV/eoOcgQOFMj0GoyZs3MajtTAJSWggOcawVDmAtqSTPn
 UowraaYEed6Woi3kQONkniIbh6Z36iRKmYvkAySZwFjwiTP93RNGggE7DXgnvMWYd
 wrFyHAKkrQumy8epf7clSVULrXXpyR0zWQTJj/yoncZ1yH3ki8BFcZH1iCyggjdaz
 B0uNZ57nHY3kd/wUANg2Q+4LhNm53vX098vIOs0I/+ADuM72nUyPMJlMZfwd7rzmT
 rlewDYPzOXGE6ZVtAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1ttq0I45rb-012X9N; Sat, 16
 Nov 2024 21:29:10 +0100
Message-ID: <4213a834-2628-4b06-adec-8799c412388f@gmx.de>
Date: Sat, 16 Nov 2024 21:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] net: wget: add definition of struct wget_http_info
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241111210901.560691-1-adrianox@gmail.com>
 <20241111210901.560691-3-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111210901.560691-3-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:51oz97p2dpuBvfuHlZScgi+rfVJ+rM0Rck+YJEa4aYwg6iEgCZD
 vgxPcrhl+k5SpjnaLPpCn5Wng0pKDnbdOi8OiBVlve8Fo/srE8uILES8Pc0v0DJxXOxBeTp
 /DtsTglWY54ud/aaRhlcMg7pYLDXd641Y/TTbTvwk7cHXdtbQ69VJ2NjocbFcRTNV0YHrDo
 mNKNszzfHfheIHRJfaP+w==
UI-OutboundReport: notjunk:1;M01:P0:Ba4i46Qu7cc=;3jUQ+eritvt4OfZIgCAnLjYslxK
 z9l/hlBBq90o9QYEa4IE2cN8KZ5oPNbKrjzyAj6O+4gNwnzYghWfoOris2KzQDSbFfjIQJiE0
 A+GwmSbQEav8BsYAbANoBw2xQK0p600ddNwy5LGyohkelaZfTX9KxvyXyPJoB5FKvTiWUNmOc
 qq/0LPgFoqSIFua4iS/B+rZkk2+enCaULmsndo8JKA9+41xX50ozvyKZasvfePDmPam/1sZuv
 tpETY1hiAAJTFpP//HteX0M8eickuTL53zDstxU38d+IGpOmwjSD1ywNDKWqE+YHYQTjDSRbn
 vhQs2awxnfYcwJ5YFGvNji9i63CrcjWdaQwadyWUdwrwiBxTKm0V/WnH/tq+pvShFBBtxKflK
 wrfUIPWDWbklvPy+DvrtTScykJOmcs1JrOpT2yhPFCdyuYQfoAA7ioNWUbsHrS+/dKzyT9A2V
 T+aaoEHSseJSHe5aSyLa7DVToha1+DMMEHa7cEwy78QMd56NGf11zgVCTOcV2GPiOn9xytfum
 /RDpRtxBqAj2SedcV2TCHyUZFarfgCNySQRicuUb5OHQfnVov2zhneZvjbrmHiI1d71swrEja
 uOgQkFQznQVHLJ/eHvHYyWswqmRCA8rHysGQVPb2hNId7Gb62foRQbX4CNri494kddxrvmHMg
 LdqhDhqGuDs2htLVpdnPdzfh8kWgEX+LKUE8mRkFu7eaAUTz87RLI1sUY6MUrPWTpyvyDSdKN
 4L1WZ274kIstkpo/lpcKlFwwzgHwMZOAJ30oD5yKTfN+XexEjOhSKdoEtb2wtYZeO8ULU6FHu
 3Rq6lSD5BMmm2hHr488Vjd3WlTk2xz+Bcj9JY5P/T/f4p4dyTe+v2Ea7Q5fd6Z27G3fZZ1woL
 Tx1SpgLaw7WgbzajK07haG9aVXdfs1Z1fPvFrMLjxJQkB3uiuGC63wizV
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

On 11/11/24 22:08, Adriano Cordova wrote:
> The struct wget_http_info exposes the HTTP information of the last HTTP
> request issued by wget, and it controls whether the efi bootdevice is se=
t,
> and whether the buffer size needs to be checked (lwip stack only). This
> information is otherwise discarded. The wget_http_info struct can be use=
d
> by HTTP drivers to have more control over HTTP requests.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>+

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v2:
> - Add Sphinx style documentation
> - Change status_code in wget_http_info from ulong to u32
>
>   include/net-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index fd7c5e7b48..8985b81c2d 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -8,6 +8,7 @@
>   #include <env.h>
>   #include <hexdump.h>
>   #include <linux/if_ether.h>
> +#include <linux/sizes.h>
>   #include <linux/types.h>
>   #include <rand.h>
>   #include <time.h>
> @@ -506,4 +507,51 @@ int wget_with_dns(ulong dst_addr, char *uri);
>   bool wget_validate_uri(char *uri);
>   //int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const =
argv[]);
>
> +/**
> + * enum wget_http_method - http method
> + */
> +enum wget_http_method {
> +	WGET_HTTP_METHOD_GET,
> +	WGET_HTTP_METHOD_POST,
> +	WGET_HTTP_METHOD_PATCH,
> +	WGET_HTTP_METHOD_OPTIONS,
> +	WGET_HTTP_METHOD_CONNECT,
> +	WGET_HTTP_METHOD_HEAD,
> +	WGET_HTTP_METHOD_PUT,
> +	WGET_HTTP_METHOD_DELETE,
> +	WGET_HTTP_METHOD_TRACE,
> +	WGET_HTTP_METHOD_MAX
> +};
> +
> +/**
> + * define MAX_HTTP_HEADERS_SIZE - maximum headers buffer size
> + *
> + * When receiving http headers, wget fills a buffer with up
> + * to MAX_HTTP_HEADERS_SIZE bytes of header information.
> + */
> +#define MAX_HTTP_HEADERS_SIZE SZ_64K
> +
> +/**
> + * struct wget_http_info - wget parameters
> + * @method:		HTTP Method. Filled by client.
> + * @status_code:	HTTP status code. Filled by wget.
> + * @file_size:		download size. Filled by wget.
> + * @buffer_size:	size of client-provided buffer. Filled by client.
> + * @set_bootdev:	set boot device with download. Filled by client.
> + * @check_buffer_size:	check download does not exceed buffer size.
> + *			Filled by client.
> + * @hdr_cont_len:	content length according to headers. Filled by wget
> + * @headers:		buffer for headers. Filled by wget.
> + */
> +struct wget_http_info {
> +	enum wget_http_method method;
> +	u32 status_code;
> +	ulong file_size;
> +	ulong buffer_size;
> +	bool set_bootdev;
> +	bool check_buffer_size;
> +	u32 hdr_cont_len;
> +	char *headers;
> +};
> +
>   #endif /* __NET_COMMON_H__ */

