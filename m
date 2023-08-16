Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F18C001DF
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 08:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D704867C7;
	Wed, 16 Aug 2023 10:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VMAngBlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEE8869AD; Wed, 16 Aug 2023 10:38:51 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE1B84702
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso54138205e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692175128; x=1692779928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jXfcACPpDu/s3d8xo5qOk4+5ukf+7ZeYajJeGGzpAGI=;
 b=VMAngBlj5lo6jBhsBYDGNHtIrbU6STHh/jToWk2q80mwT/o/jS1b6uxuwCvjtbWcNI
 BRgwJT+10KoA1KW77pLM5kK7GhEm61bzWRPQrHjOsUs7GzcnBPule2gDkI5BH6g60+gi
 GnBkn+oPQBXFCiEncTMJZ9AhMsAy7NhXvbFkLomiLWAvSGg1PpfyjaJt9/4aZmanvojP
 geEmOsQz563L0i/9w/ZuZ6i/AUG75EgQ9RZSSiO4Krjpe3BENJOOHknRptmeZ2ZErKUh
 YDSuM0wWOVk56ajqqiuNZGIFZBf1o93RwpTtoA90t7SHz+K/TPjZ9yK0RsEXB9jxjDAK
 bxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692175128; x=1692779928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXfcACPpDu/s3d8xo5qOk4+5ukf+7ZeYajJeGGzpAGI=;
 b=dNBvxFbgiOJsBpuUf+786bKR5mK1uBfRvcrcyLk/PDMUbLJsA1nkg3f8MKDuGHglIX
 Dz6x8VrnCiSmhuRr6kpyaU0edZL/owNCbAT+K5EeIAs/Elin/Yygez3wkl5QcR1nH5t7
 yqzszhRf2gy6k1zfVZi4YsWrvVkt3J8XdHiOrz9cjEM8tHYtIYntLSt0Hec+iYb6v0XI
 y5/A6AFQ92pheshnmqacz3U2ozNPFMOj8Cvr4y1+0CcXCnafhDc7UWKHdBnMLQ756j4J
 uuZboqyUIszTs5OBrlxBR6b9BINbwF5gjaI7ixQS3cn+bEz+DF/cbZjqEo3K+ma+reg9
 86DA==
X-Gm-Message-State: AOJu0Yytq65kKxYdGbGeStIPc0mWyT9vCzEkvLrEtJFQpaPzQHZo4inN
 Bo5+Hu3Pn7a3PToisU/Zf0CrMA==
X-Google-Smtp-Source: AGHT+IGgPCAvJyilr25qRZ2pTpYvS3PXyV+CrxT3RlJXa25eRJ4kDTvU+zxGfsWWFliotW1y9w4/qg==
X-Received: by 2002:a05:6000:11c5:b0:314:36f0:2214 with SMTP id
 i5-20020a05600011c500b0031436f02214mr983764wrx.6.1692175127923; 
 Wed, 16 Aug 2023 01:38:47 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a5d528d000000b003142c85fbcdsm20428742wrv.11.2023.08.16.01.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 01:38:47 -0700 (PDT)
Date: Wed, 16 Aug 2023 11:38:45 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 lwip-devel@nongnu.org
Subject: Re: [PATCHv6 06/14] net/lwip: implement wget cmd
Message-ID: <ZNyLFVRqzZs7O6y5@hades>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-7-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814133253.4150-7-maxim.uvarov@linaro.org>
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

On Mon, Aug 14, 2023 at 07:32:45PM +0600, Maxim Uvarov wrote:
> Implement function for wget command with lwIP variant. Usage and output is
> the same as the original command. This code called by compatibility code
>  between U-Boot and lwIP.
> 


Similar comments to previous patches adding commands

> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> +*
> +*
> +* @addr  start address to download result
> +* @url   url in format http://host[:port]/url
> +* Return: 0 for success
> +*         !0 if error
> +*/

Same here, sphinx needs a different syntax

> +int ulwip_wget(ulong addr, char *url);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 0337d82cf5..4c6df94807 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
>  obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
>  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
> +obj-$(CONFIG_CMD_WGET) += apps/http/
> diff --git a/net/lwip/apps/http/Makefile b/net/lwip/apps/http/Makefile
> new file mode 100644
> index 0000000000..3e92b0ef1b
> --- /dev/null
> +++ b/net/lwip/apps/http/Makefile
> @@ -0,0 +1,13 @@
> +ccflags-y += -I$(srctree)/net/lwip/port/include
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
> +ccflags-y += -I$(obj)
> +
> +$(obj)/http_clinet.o: $(obj)/http_client.c
> +.PHONY: $(obj)/http_client.c
> +$(obj)/http_client.c:
> +	cp $(srctree)/net/lwip/lwip-external/src/apps/http/http_client.c $(obj)/http_client.c
> +	cp $(srctree)/net/lwip/lwip-external/src/include/lwip/apps/http_client.h $(obj)/http_client.h
> +
> +obj-$(CONFIG_CMD_WGET) += http_client.o
> +obj-$(CONFIG_CMD_WGET) += lwip-wget.o
> +
> diff --git a/net/lwip/apps/http/lwip-wget.c b/net/lwip/apps/http/lwip-wget.c
> new file mode 100644
> index 0000000000..73d82225a2
> --- /dev/null
> +++ b/net/lwip/apps/http/lwip-wget.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <console.h>
> +#include <vsprintf.h>
> +
> +#include "http_client.h"
> +#include <net/ulwip.h>
> +
> +static ulong daddr;
> +static httpc_connection_t settings;
> +
> +#define SERVER_NAME_SIZE 200
> +
> +static err_t httpc_recv(void *arg, struct altcp_pcb *pcb, struct pbuf *p,
> +			err_t unused_err)
> +{
> +	struct pbuf *q;

Please change the p/q stuff to something that's actually readable and hints
on what those variables represent 

> +
> +	if (!p)
> +		return ERR_BUF;
> +
> +	for (q = p; q != NULL; q = q->next) {
> +		memcpy((void *)daddr, q->payload, q->len);
> +		log_debug("downloaded chunk size %d, to addr 0x%lx\n", q->len, daddr);
> +		daddr += q->len;
> +	}
> +	altcp_recved(pcb, p->tot_len);
> +	pbuf_free(p);

Why is this freed here?
If the caller allocates this, he should also be responsible for freeing it 

> +	return ERR_OK;
> +}
> +
> +static void httpc_result(void *arg, httpc_result_t httpc_result, u32_t rx_content_len,
> +			 u32_t srv_res, err_t err)
> +{
> +	if (httpc_result == HTTPC_RESULT_OK) {
> +		log_info("\n%d bytes successfully downloaded.\n", rx_content_len);
> +		env_set_ulong("filesize", rx_content_len);
> +		ulwip_exit(0);
> +	} else {
> +		log_err("\nhttp eroror: %d\n", httpc_result);
> +		ulwip_exit(-1);
> +	}
> +}
> +
> +/* http://hostname:port/url */
> +static int parse_url(char *url, char *host, u16 *port)

I think we discussed this already.  If the existing wget application
doesn't support configurable ports, just skip it on the initial patch and 
add it in the future 

> +{
> +	char *p, *pp;
> +
> +	p = strstr(url, "http://");
> +	if (!p) {
> +		printf("err: no http://!\n");
> +		return -1;
> +	}
> +
> +	p += strlen("http://");
> +
> +	/* parse hostname */
> +	pp = strchr(p, ':');
> +	if (pp) {
> +#define PORT_STR_SIZE 5
> +		char portstr[PORT_STR_SIZE];
> +
> +		if (pp - p >= SERVER_NAME_SIZE)
> +			return -2;
> +		memcpy(host, p, pp - p);
> +		host[pp - p + 1] = '\0';
> +
> +		p = pp + 1;
> +		pp = strchr(p, '/');
> +		if (!pp) {
> +			printf("wrong url\n");
> +			return -3;
> +		}
> +
> +		if (pp - p >= PORT_STR_SIZE)
> +                        return -4;
> +		memcpy(portstr, p, pp - p);
> +		portstr[pp - p] = '\0';
> +		*port = (u16)dectoul(portstr, NULL);
> +	} else {
> +		pp = strchr(p, '/');
> +		if (!pp) {
> +			printf("wrong url\n");
> +			return -5;
> +		}
> +
> +		if (pp - p >= SERVER_NAME_SIZE)
> +			return -6;
> +		memcpy(host, p, pp - p);
> +		host[pp - p + 1] = '\0';
> +		*port = 80; /* default */
> +	}
> +
> +	return 0;
> +}
> +
> +int ulwip_wget(ulong addr, char *url)
> +{
> +	err_t err;
> +	u16 port;
> +	char server_name[SERVER_NAME_SIZE];
> +	httpc_state_t *connection;
> +
> +	daddr = addr;
> +
> +	err = parse_url(url, server_name, &port);
> +	if (err) {
> +		log_err("error parse_url\n");
> +		return -1;
> +	}
> +
> +	log_info("downloading %s to addr 0x%lx\n", url, addr);
> +	memset(&settings, 0, sizeof(settings));
> +	settings.result_fn = httpc_result;
> +	err = httpc_get_file_dns(server_name, port, url, &settings,
> +				 httpc_recv, NULL,  &connection);
> +	if (err != ERR_OK) {
> +		log_err("httpc_init_connection failed\n");
> +		return err;
> +	}
> +
> +	env_set_hex("fileaddr", addr);
> +	return 0;
> +}
> -- 
> 2.30.2
> 

Thanks
/Ilias
