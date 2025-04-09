Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBFEC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69556835CD;
	Wed,  9 Apr 2025 16:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pdNWIUWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F768836AC; Wed,  9 Apr 2025 16:17:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1B28353A
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744208252; x=1744813052; i=xypron.glpk@gmx.de;
 bh=QaPjpGVpUhzw86+TrBsf204C8DFulE6hCrDWJZHRqyU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pdNWIUWvRRpIsTlTLuo3uqraOArk7Pc6M6gDHbjQ8+Y8rzd8Rn1UVpzNwGG8mTa7
 Vcn3h6oypxJddoRUYnhHKkvEO/2u1VPPfoIhYcnyZ74mg6ekNUh9entfoc1DmPhVD
 qwIanvtVbYKMfrwOdc10EEoOnRYm/YaWA3bykGcvDXBbdk0PTaQyEixZNpZspNhjm
 x+dHYuR4anVoiyO7dr+GkQQ9NYTueyMK54DEqZn5myIzpa/JMPzf5L2cPu/C0X7Yt
 OnqMXXvYTMSzdDXhvgrHupHl6uncRMbHjs9NfEUe00KtvSqHm+tHdURL7BPNhJ/ME
 SdW1GgA4Pd+sVZ81lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1tfmgw4C5F-00XTnZ; Wed, 09
 Apr 2025 16:17:32 +0200
Message-ID: <7be98569-3565-4db5-aa3f-b6dd68ee8ac5@gmx.de>
Date: Wed, 9 Apr 2025 16:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net-lwip: wget: add LMB and buffer checks
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250409122007.2560668-1-jerome.forissier@linaro.org>
 <20250409122007.2560668-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250409122007.2560668-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ihjvqWdBSyeUUPim1kRcmwmoKJLloGGplmh4Z8RKfB/5Vsqsd2J
 5qWg08YVTMgeiEkvw2tsAVyH9LnKfKOrR8OXP80yYuiNyEfNukZ6yu1AfDRq4PWZCnDxQiG
 2Usu5YC91LcBFOxMcwIGglQtGrTBHty55qW7r5bWi0nedMkk4VgslOeymuI3+lMqTnfAzfv
 cOOdPGRqwnHNxvAedUHhg==
UI-OutboundReport: notjunk:1;M01:P0:Dph56+OPHTQ=;pkQXrwNGSzm/oBsug+SJRRCx4E+
 TzW5S58Gek79GkgLNkti1myh02+HCPEHKjBU3tpVprMIvTyTzw4tZ2EkeKGUooP6748JyzdM1
 +FKyvqKucAUWSllyqwv6MMmuriW9XH/139z5FdFt1NquTWdArFvXgAZVUs5+wteuwfTKk+Yl7
 byOSUbF8dp933yDY9GpIo5xBkKouTS8TkWPrQ2wrt6A2SpFQEtG7zCWjWpCDwHK4l3f5PODzQ
 WQtAQotqtMMjAnjSp2LMBZfXOlUldn3enBbn+cLsC/uDOH3BRnWX7SEZolIWHSMRuVvK5NZIl
 kt0KEIkEqWXMv3GOy7R8C+ZDdO/DKiaAGdxUaR8CIJy/ww2HaZ80msoh1sjB8LzcH6uQQ/Mqv
 VIOekoBxxdj4AJOFqhffMP1hEauTeqFUf0jVo6ldRUBm6IXOXOls/xurkRReQ7y3A0h29C6rM
 O3KHnrb8bc9vKupaU3/6MyPMdhlXbxwMMqmM1Zw8NPhXCJHYF2kcXhh3iMrpDem6gKMbM+pbv
 racDd+c6YIv51Eam+wKMmOjwKpXRyp19g5EelDaFpQN1D/gSSnPgfZ/XNx4G8JLwxbmMbEidX
 yb+oLA9agKbPyxPq/3KPmC/LeY8TOXOzgKoydohxpcwsQlrVuf5QC3SdD61NC4CXPtUIs+nzP
 PGAa0Egz7cxEorTrM1Yuy+U0dhNnfdgRX+RiaSp9XHuJgj051RvoaecBPkhC+dhtraKX7Yj31
 IbPHGN9HlqIzTRAbeFgUQSD5UEh2B6ZarXTR961mnafjiyhcluvtSzGPoSjZHPOkT/Q5PQ6ao
 jMvTZYRcJAgb/3SmCpnfjSxfuzbdg/jNHU/7g0BgFpghczcsK7BF21cFBkpq40LQZ6OjLKyQF
 NKFpo4I3VoG/vSVuWhWzi1cm3XhOGqjHhq9or16odO9DTViP1zrCAj9qUHUQdnMiPn+e87q+k
 qTBrvd7fFCIV/4dz2ZG53LLk94wJ32rIC5++ARSbpklcGpIL4yryiKsf7YrmGfvm1grUBKA0k
 sa42mdkbjtT5LXwrcVuJTNbm/EOcQV1unOubDRSthId19H+K+PLuLL4mgeww6B5aA0voYz4va
 NCRjYYQN0YnSOqqeMU9y8n5XDEdhqbVshjg2nTudCX48Q1e4iWurU5EpGN7uLfgdKfnrkTp5N
 sBwDmqW65mcBmQgV1M6WGOU8jEMAmzb9xOc0Ibt2v7/Zdt8g3uvsOD98+4Lp8mm3wA2W8LLtM
 3UMmI6Enn+FuIk5sG0XBzwMGijWZktcVKE/4VzUsS85S2GTaMN3emuHb2QpPSsK/gVZ5441N1
 oI/XiL3MJmLpgLsUHfHSOYBCURrti9kDXLhxsRYaCkwxydrZNjtmHfl5wCRUzbzSm5e7fNa+/
 JKCft3Eq7C72w6Y8GKPxqmTizYmYYm4Swt97POIDjJanc6En5TS3BEDbZszWBs/JaNB9imcbv
 PkJPcNQYiMuCNB8e/O9gUw1ege58=
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

On 09.04.25 14:20, Jerome Forissier wrote:
> Legacy NET wget invokes a store_block() function which performs buffer
> validation (LMB, address wrapping). Do the same with NET_LWIP.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   net/lwip/wget.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 14f27d42998..746c8164d66 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -6,6 +6,7 @@
>   #include <display_options.h>
>   #include <efi_loader.h>
>   #include <image.h>
> +#include <linux/kconfig.h>
>   #include <lwip/apps/http_client.h>
>   #include "lwip/altcp_tls.h"
>   #include <lwip/timeouts.h>
> @@ -201,11 +202,44 @@ static int parse_legacy_arg(char *arg, char *nurl,=
 size_t rem)
>   	return 0;
>   }
>

Please, add Sphinx style descriptions to all functions.

> +static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
> +{
> +	ulong store_addr =3D ctx->daddr;
> +	uchar *ptr;
> +
> +	/* Avoid overflow */
> +	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len=
)
> +		return -1;
> +
> +	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
> +		if (store_addr + len < store_addr ||
> +		    lmb_read_check(store_addr, len)) {
> +			printf("\nwget error: ");
> +			printf("trying to overwrite reserved memory...\n");

Output while an EFI application is consuming the HTTP protocol should be
avoided as it is not compatible with the EFI console.

If you want console output in the wget command, please, implement it
there and not in a library function called by efi_net_do_request().

> +			return -1;
> +		}
> +	}
> +
> +	ptr =3D map_sysmem(store_addr, len);
> +	memcpy(ptr, src, len);
> +	unmap_sysmem(ptr);
> +
> +	ctx->daddr +=3D len;
> +	ctx->size +=3D len;
> +	if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +		printf("#");

ditto

Best regards

Heinrich

> +		ctx->prevsize =3D ctx->size;
> +	}
> +
> +	return 0;
> +}
> +
>   static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pb=
uf *pbuf,
>   			   err_t err)
>   {
>   	struct wget_ctx *ctx =3D arg;
>   	struct pbuf *buf;
> +	err_t ret;
>
>   	if (!pbuf)
>   		return ERR_BUF;
> @@ -214,18 +248,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp=
_pcb *pcb, struct pbuf *pbuf,
>   		ctx->start_time =3D get_timer(0);
>
>   	for (buf =3D pbuf; buf; buf =3D buf->next) {
> -		memcpy((void *)ctx->daddr, buf->payload, buf->len);
> -		ctx->daddr +=3D buf->len;
> -		ctx->size +=3D buf->len;
> -		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> -			printf("#");
> -			ctx->prevsize =3D ctx->size;
> +		if (store_block(ctx, buf->payload, buf->len) < 0) {
> +			altcp_abort(pcb);
> +			ret =3D ERR_BUF;
> +			goto out;
>   		}
>   	}
> -
>   	altcp_recved(pcb, pbuf->tot_len);
> +	ret =3D ERR_OK;
> +out:
>   	pbuf_free(pbuf);
> -	return ERR_OK;
> +	return ret;
>   }
>
>   static void httpc_result_cb(void *arg, httpc_result_t httpc_result,

