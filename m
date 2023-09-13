Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E5EEB599
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 06:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF00B86E50;
	Wed, 13 Sep 2023 08:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nz1Vdl2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2D186E51; Wed, 13 Sep 2023 08:26:02 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B00F86C47
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso69913765e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694586359; x=1695191159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zxj+KmGux1Bi2Zlg7K/ecJ+B4CJ4Ij1UoFRHHS+pORY=;
 b=Nz1Vdl2XgYxf63f/EmnZXdvN81KdA4cO9zWuAH8arwohKLPLpCguCsdQBmp9WHkloR
 mNNCXGKL6oW1l/Kmzfe/rNcxlt2tIGDZyXePTu3q6WqGm7xtPu8IO6MAl9gboHH0ngPh
 ejSGMyq84AXCWe1V+WHFhHgoaNBQ00jlWl7nu/UbafTX92em+TjO7U82D4zv4Mezyjo0
 NlV8ImuE3z3JXaP0nSQHTNhKbw4Bg++s+F0XkDYfJhkbIKm+liKkxluMeQ7avT1HCl/G
 BKYbTF81DBuAJepvq3otZEbDWwtYei4RJnDAdL6d+Hl4ghhWli4EGFCU06Q0Y12gc+tA
 hXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694586359; x=1695191159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxj+KmGux1Bi2Zlg7K/ecJ+B4CJ4Ij1UoFRHHS+pORY=;
 b=a44qYJmK+D0li1DHdCRaxZFnTNEmVz3UVMe2YnCko+wB8opkWZitX3NESY1bqcv9Tg
 z/LDU784kThkBpQ/lu9QeOp4M3lZj+qX4ln5ztvOstSMx83HFEJPAv96hwtmOt1Tq0jP
 jOlnvAVrG29cj18THnWYvmPaTX7EAI20kyfcNjRuEAG+j3TNLWjHZPwTldsBGBcmMzDn
 y2nl4y+kXP9yV4XaCFYhG4Kj1bWMi1la2aOP6ww8VFBVsh+Tp1o4TenzY0nnsN3bbGx3
 GCooR+anhrXBCJtVTjC/rBXHKM/V9Pzh18rLh8PUG1azuS5uzkBmM+MBg/3fRnRmsw4D
 jFlg==
X-Gm-Message-State: AOJu0YyH5EOPyMjKndxaMF/e+eydxgMK8a5QuUxA4HfeBBsp4/4OY110
 PHZgOoX71lT0ksq6V8cy4q1yew==
X-Google-Smtp-Source: AGHT+IH2Lu7/DD3FTX8HQv5cNsn13Z0D4sUdTAbWsQtL33jdBSxSq+cEqlMdiw0K2IgkGd0Pdwcrzg==
X-Received: by 2002:a05:600c:2804:b0:3fe:22fd:1b23 with SMTP id
 m4-20020a05600c280400b003fe22fd1b23mr1203595wmb.34.1694586358818; 
 Tue, 12 Sep 2023 23:25:58 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a1c7407000000b003fef19bb55csm989698wmc.34.2023.09.12.23.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 23:25:58 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:25:56 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 06/15] net/lwip: implement wget cmd
Message-ID: <ZQFV9DcSKIDAwx4I@hera>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-7-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-7-maxim.uvarov@linaro.org>
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

>  4 files changed, 128 insertions(+)
>  create mode 100644 net/lwip/apps/http/Makefile
>  create mode 100644 net/lwip/apps/http/lwip-wget.c
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index c9e2982a78..85f08343fd 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -28,6 +28,7 @@ int ulwip_dns(char *name, char *varname);
>   * Returns: 0 if success
>   *         Other value < 0, if error
>  */
> +int ulwip_dhcp(void);

This seems unrelated to wget changes

[...]

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
> +#define HTTP_PORT_DEFAULT 80
> +
> +static err_t httpc_recv(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
> +			err_t unused_err)
> +{
> +	struct pbuf *buf;
> +
> +	if (!pbuf)
> +		return ERR_BUF;
> +
> +	for (buf = pbuf; buf != NULL; buf = buf->next) {
> +		memcpy((void *)daddr, buf->payload, buf->len);
> +		log_debug("downloaded chunk size %d, to addr 0x%lx\n",
> +			  buf->len, daddr);
> +		daddr += buf->len;
> +	}
> +
> +	altcp_recved(pcb, pbuf->tot_len);
> +	pbuf_free(pbuf);
> +	return ERR_OK;
> +}
> +
> +static void httpc_result(void *arg, httpc_result_t httpc_result, u32_t rx_content_len,
> +			 u32_t srv_res, err_t err)
> +{
> +	if (httpc_result == HTTPC_RESULT_OK) {
> +		log_info("\n%d bytes successfully downloaded.\n", rx_content_len);
> +		env_set_hex("filesize", rx_content_len);
> +		ulwip_exit(0);
> +	} else {
> +		log_err("\nhttp eroror: %d\n", httpc_result);
> +		ulwip_exit(-1);
> +	}
> +}
> +
> +/* http://hostname:port/url */

The format doesn't expect a port (for now we can change that once we add
https)

> +static int parse_url(char *url, char *host, u16 *port)
> +{
> +	char *p, *pp;
> +
> +	p = strstr(url, "http://");
> +	if (!p)
> +		return -1;
> +
> +	p += strlen("http://");
> +
> +	/* parse hostname */
> +	pp = strchr(p, '/');
> +	if (!pp) {
> +		return -2;

-1, -2 -3 etc should be mapped to proper ERRNOs

> +	}
> +
> +	if (pp - p >= SERVER_NAME_SIZE)

Can you change this to p + SERVER_NAME_SIZE >= pp ?

> +		return -3;
> +
> +	memcpy(host, p, pp - p);
> +	host[pp - p + 1] = '\0';
> +	*port = HTTP_PORT_DEFAULT;
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
> +	if (err)
> +		return -ENOENT;
> +
> +	log_info("downloading %s to addr 0x%lx\n", url, addr);
> +	memset(&settings, 0, sizeof(settings));
> +	settings.result_fn = httpc_result;
> +	err = httpc_get_file_dns(server_name, port, url, &settings,
> +				 httpc_recv, NULL,  &connection);
> +	if (err != ERR_OK)
> +		return -EPERM;
> +
> +	if (env_set_hex("fileaddr", addr))
> +		return -EACCES;
> +
> +	return 0;
> +}
> --
> 2.30.2
>

Thanks
/Ilias
