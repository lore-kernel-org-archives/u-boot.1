Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0058D64074
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E5C88DB2;
	Fri,  8 Nov 2024 18:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oKd6zsBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CE288DB6; Fri,  8 Nov 2024 18:57:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D366988B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731088620; x=1731693420; i=xypron.glpk@gmx.de;
 bh=+COtikIQp9Ts9eFkn3PwbIDE3X3KJM7a0n13rstLQdU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oKd6zsBJCsJD1FT2hPsQWg+LQ1JPm9H7Zm7p2stil0Cp6VI0K5rSW4i7CKWm8Jpc
 oBaKvAiQSuwsYV2Q1YCWflwji2YjKJKkDx5IMxhzcgksWNJoRGw21d26OMyVCwhVJ
 tWVfWTmelpyMM1O6zo1k07E9vDoUz4F7tCYYyrf6D7cfDWLAg+mgD/sZwF6IzEa12
 jJn4F9GI5RW2bhDL5ERzFhFhS9p0Mcv9QZFzT1EV1jVX19gtz/nusvmXGttoX9MF3
 jbCX2TiF86Az+4yN28xfvzw/66SAsE704x6O1s1STzm8ggeXV+iGTGUn4sDurW9BM
 Mk82zIuEHM8V5xe8sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1tjtuS35dk-00lnHx; Fri, 08
 Nov 2024 18:57:00 +0100
Message-ID: <ef243224-fb96-4bfa-bdc2-73a35f98aa11@gmx.de>
Date: Fri, 8 Nov 2024 18:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] net: wget: integrate struct wget_info into legacy
 wget code
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, u-boot@lists.denx.de
References: <20241106130355.211132-1-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241106130355.211132-1-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V0AaOd4vLtngPmRHh/WG+6G50wX0Uykv/wyhOnXL+JzRjmh+HKr
 1dtlnwJkVlZGGEqAhY/qH6JAlcI+6vjxEF6O1EAiz9im7r8mHb98uUpCCBst8pwju59rKSY
 thpe4Asm3HQrS9C1f8nHIFeIfrFCcDTOsbY48LxUjaQhOg96TsTNKHXaqybjKEjKcuMpoUr
 9GUd7wkRw0cM3Em/W4B/w==
UI-OutboundReport: notjunk:1;M01:P0:cSyrklNGya0=;llfxGaDSeMMg4snzZNiDSveTWFU
 8iZRaUgpaeYfleDsowp3s+/ZMHSfH+9M0JXSuEMfULwj7AyDtDGioIJs2JClOrUs2aW/LWi1v
 stLWqpvMq3eC4TeWMouBDD5e8NrcyM81X+v8oBymQ5vOpbJ3MCuGZqJwfF7pLLDigBICkaRuA
 fdIME6aYKLvFNhS8KuCdiAtlIFyrGdKDyuLnvuBdc3XXJ9lABVvDQAtEj8srlQvymeZC7OV+2
 vfC35pOUbaJvieMIE7XASKc9cQlD2dR1lylW7UDRq4phkyHy1tGz2rAzC7IrHmwSeWIeBqkH/
 bjoiPcRzqKHRDUxWV9N5keGlsUsSLtEpVYut/gO7AI+udolabcs6kb43l+KKP5BW1jLnOZaT/
 Iwf+1/w7YoM9y7k8aqKAIoVpE1/tF9mxtzwAR1NfuyQNx7iERj4yFyKnHS3E+1a0bcQzY78zv
 uBh85Xq/en2G9uKrM74SnXkI4VmsbvOixP5NmB1DvQhYnEFhhsDZ7Rf4FMHJmJBjTnOIZniXc
 pERVc7xDhuJEIvcoyZBZToKK69TbhAtu12ST9OCX4j11sNVT9BlolTANX4EDWgkm1hntJfboV
 Ns9QBfzLl1qSldI5tIdn92K0LAn65oNnfCG5i14tEMJahwBJsCrD9fSia4sOUxmjQYF+KRuqJ
 R1VuhtdJF4UBr9F/zvAzq+ZwMwaRWPK1x5Z2YxNFdzC18N9LOSNI1ipg37r+ttTck25sVbawi
 o+RLAC/P9N5ixwPNOJIbxQiFNncK3ktlA8wezNs+lcnvVrSf6m5E6pfU2bE+ki3uVbqQzJRQ+
 BXWfWpGy7B7w+dPa97CIVHMA==
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

On 11/6/24 14:03, Adriano Cordova wrote:
> Each wget request now fills the struct wget_info. Also, the
> efi bootdevice is now set conditionally to the set_bootdevice
> variable in wget_info, and the same holds for lmb memory check.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>   net/wget.c | 88 +++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 67 insertions(+), 21 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 635f82efbb..24be0a4932 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -22,10 +22,10 @@ DECLARE_GLOBAL_DATA_PTR;
>   /* The default, change with environment variable 'httpdstp' */
>   #define SERVER_PORT		80
>
> -static const char bootfile1[] =3D "GET ";
> +static const char bootfileGET[] =3D "GET ";
> +static const char bootfileHEAD[] =3D "HEAD ";
>   static const char bootfile3[] =3D " HTTP/1.0\r\n\r\n";
>   static const char http_eom[] =3D "\r\n\r\n";
> -static const char http_ok[] =3D "200";
>   static const char content_len[] =3D "Content-Length";
>   static const char linefeed[] =3D "\r\n";
>   static struct in_addr web_server_ip;
> @@ -77,7 +77,7 @@ static inline int store_block(uchar *src, unsigned int=
 offset, unsigned int len)
>   	ulong newsize =3D offset + len;
>   	uchar *ptr;
>
> -	if (CONFIG_IS_ENABLED(LMB)) {
> +	if (CONFIG_IS_ENABLED(LMB) && wget_info.set_bootdev) {
>   		if (store_addr < image_load_addr ||
>   		    lmb_read_check(store_addr, len)) {
>   			printf("\nwget error: ");
> @@ -132,8 +132,17 @@ static void wget_send_stored(void)
>   			IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
>   		offset =3D ptr;
>
> -		memcpy(offset, &bootfile1, strlen(bootfile1));
> -		offset +=3D strlen(bootfile1);
> +		switch (wget_info.method) {
> +		case WGET_HTTP_METHOD_HEAD:
> +			memcpy(offset, &bootfileHEAD, strlen(bootfileHEAD));
> +			offset +=3D strlen(bootfileHEAD);
> +			break;
> +		case WGET_HTTP_METHOD_GET:
> +		default:
> +			memcpy(offset, &bootfileGET, strlen(bootfileGET));
> +			offset +=3D strlen(bootfileGET);
> +			break;
> +		}
>
>   		memcpy(offset, image_url, strlen(image_url));
>   		offset +=3D strlen(image_url);
> @@ -193,6 +202,47 @@ static void wget_timeout_handler(void)
>   #define PKT_QUEUE_OFFSET 0x20000
>   #define PKT_QUEUE_PACKET_SIZE 0x800
>
> +static void wget_fill_info(const uchar *pkt, int hlen, struct wget_http=
_info *info)
> +{
> +	const char *first_space;
> +	const char *second_space;
> +	char *pos, *end;
> +
> +	if (info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
> +		strncpy(info->headers, pkt, hlen);
> +
> +	//Get status code
> +	first_space =3D strchr(pkt, ' ');
> +	if (!first_space) {
> +		info->status_code =3D -1;
> +		return;
> +	}
> +
> +	second_space =3D strchr(first_space + 1, ' ');
> +	if (!second_space) {
> +		info->status_code =3D -1;
> +		return;
> +	}
> +
> +	info->status_code =3D simple_strtoul(first_space + 1, &end, 10);
> +
> +	if (second_space !=3D end)
> +		info->status_code =3D -1;
> +
> +	pos =3D strstr((char *)pkt, content_len);
> +
> +	if (pos) {
> +		pos +=3D sizeof(content_len) + 1;
> +		while (*pos =3D=3D ' ')
> +			pos++;
> +		content_length =3D simple_strtoul(pos, &end, 10);
> +		debug_cond(DEBUG_WGET,
> +			   "wget: Connected Len %lu\n",
> +			   content_length);
> +		wget_info.hdr_cont_len =3D content_length;
> +	}
> +}
> +
>   static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>   			   u8 action, unsigned int tcp_ack_num, unsigned int len)
>   {
> @@ -241,7 +291,11 @@ static void wget_connected(uchar *pkt, unsigned int=
 tcp_seq_num,
>   		initial_data_seq_num =3D tcp_seq_num + hlen;
>   		next_data_seq_num    =3D tcp_seq_num + len;
>
> -		if (strstr((char *)pkt, http_ok) =3D=3D 0) {
> +		wget_fill_info(pkt, hlen, &wget_info);
> +		debug_cond(DEBUG_WGET,
> +			   "wget: HTTP Status Code %ld\n", wget_info.status_code);

Why is status code defined as long in

   include/net-common.h:537: ulong status_code;

I have never seen a status code with more than 3 digits.

Cf. RFC 2616 (https://datatracker.ietf.org/doc/html/rfc2616) and
RFC 9110
(https://www.rfc-editor.org/rfc/rfc9110#name-overview-of-status-codes).

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +
> +		if (wget_info.status_code !=3D 200) {
>   			debug_cond(DEBUG_WGET,
>   				   "wget: Connected Bad Xfer\n");
>   			wget_loop_state =3D NETLOOP_FAIL;
> @@ -251,17 +305,6 @@ static void wget_connected(uchar *pkt, unsigned int=
 tcp_seq_num,
>   				   "wget: Connected Pkt %p hlen %x\n",
>   				   pkt, hlen);
>
> -			pos =3D strstr((char *)pkt, content_len);
> -			if (!pos) {
> -				content_length =3D -1;
> -			} else {
> -				pos +=3D sizeof(content_len) + 2;
> -				strict_strtoul(pos, 10, &content_length);
> -				debug_cond(DEBUG_WGET,
> -					   "wget: Connected Len %lu\n",
> -					   content_length);
> -			}
> -
>   			net_boot_file_size =3D 0;
>
>   			if (len > hlen) {
> @@ -397,10 +440,13 @@ static void wget_handler(uchar *pkt, u16 dport,
>   	case WGET_TRANSFERRED:
>   		printf("Packets received %d, Transfer Successful\n", packets);
>   		net_set_state(wget_loop_state);
> -		efi_set_bootdev("Net", "", image_url,
> -				map_sysmem(image_load_addr, 0),
> -				net_boot_file_size);
> -		env_set_hex("filesize", net_boot_file_size);
> +		wget_info.file_size =3D net_boot_file_size;
> +		if (wget_info.method =3D=3D WGET_HTTP_METHOD_GET && wget_info.set_boo=
tdev) {
> +			efi_set_bootdev("Net", "", image_url,
> +					map_sysmem(image_load_addr, 0),
> +					net_boot_file_size);
> +			env_set_hex("filesize", net_boot_file_size);
> +		}
>   		break;
>   	}
>   }

