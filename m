Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B3CEEB597
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 06:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3290C86E16;
	Wed, 13 Sep 2023 08:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wx/N12R8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B482786E47; Wed, 13 Sep 2023 08:07:43 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B3986D43
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401b393df02so74887015e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694585260; x=1695190060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yvi2enkeknRpWU3WNJnw1jdJ/b1uVVa7uY/AnaskXIE=;
 b=Wx/N12R8/mYb+EX5lCNoiza6vK/R263+OdLn34qHR1vl0fuWcmlruys4PxB+sv5W2S
 GOIx5oyl/n0A5PwlzJ/ffwWiLOXBRy568dobw9HBIFC/qw3KcGJI4lVXqayJ85H1spGm
 s7PgUeT908g8zb1u5wLbZ4/lmm0EIyBvjpYNOnp8Djlntkd6Y4CvewAlN6AkpZDbIkrX
 Yx3usrYoiRhzVUlV/0jwIwaEn1yj31KCCIl09gDbwWZKuGTXEMOf8m+A779nVVmzW9VF
 pmAvh88cqvFT7NUTzv0cM3U7ilGlPDuP3J70fkCmeztgcFlMugUH/Sa02jNZnZKGjy9U
 +Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694585260; x=1695190060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvi2enkeknRpWU3WNJnw1jdJ/b1uVVa7uY/AnaskXIE=;
 b=eh79VWyWIepE4oTjJOBdf1WtbCzLmHc2GU3GGO/bMKt46dWNCXdEYQUw7IU5UcCW0L
 XSHXgfTgF7plVvNuwWy9LK/gnLJ7yyT8wHZdDzQRAq0SKnJIcO7WGStJ34ma/aB63heb
 Cgk/TWEF0l6vEeS+GZKM92toagrFIKOgRUU/TE+9pQHvFSJaOHinRSeu82p4Dy2bNoe+
 737EU1jEiuJCSCwVzJZIohlFsFbOYvX6N31ZnmQN/N6rRUXB8zV07Jh4B4RtZQOkvrDT
 jm9b4mDnYSP1paEDwDMDyzFAD/kxlvuR1AAZ03LmaUZvBeE56RJrwEfHjwzY3QKTXPgc
 g8pg==
X-Gm-Message-State: AOJu0Yyh0MYdvPd9tMbuEDdVTolBF+qrRx28F8h6DZL3X71vPxO8a+bX
 otoMYDSEUq+k+jVy/6Kfyg1XyQ==
X-Google-Smtp-Source: AGHT+IE7ma7eoTMnqOuocDcKvhs5vZBVpzQewosU1i+7Lhc2v1xKbSlwMDF0BuabVcdw6ZzyAgfULA==
X-Received: by 2002:a05:600c:24c:b0:401:b2c7:34a4 with SMTP id
 12-20020a05600c024c00b00401b2c734a4mr1276140wmj.11.1694585260607; 
 Tue, 12 Sep 2023 23:07:40 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a7bc854000000b003fee6f027c7sm970849wml.19.2023.09.12.23.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 23:07:40 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:07:38 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 04/15] net/lwip: implement dhcp cmd
Message-ID: <ZQFRqo+wPifYRCg/@hera>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-5-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-5-maxim.uvarov@linaro.org>
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

On Fri, Sep 08, 2023 at 07:53:09PM +0600, Maxim Uvarov wrote:
> +
> +#include <common.h>
> +#include <command.h>
> +#include <console.h>
> +
> +#include <lwip/dhcp.h>
> +#include <lwip/prot/dhcp.h>
> +#include "lwip/timeouts.h"
> +
> +#include <net/eth.h>
> +#include <net/ulwip.h>
> +
> +#define DHCP_WAIT_MS 2000

Is this the time we wait for a dhcp reply? If so we should bump it to
something higher

> +
> +static void dhcp_tmo(void *arg)
> +{
> +	struct netif *netif = (struct netif *)arg;
> +	struct dhcp *dhcp;
> +	int err = 0;
> +
> +	dhcp = netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DHCP);
> +	if (!dhcp)
> +		return;
> +
> +	switch (dhcp->state) {
> +	case DHCP_STATE_BOUND:
> +		err += env_set("bootfile", dhcp->boot_file_name);
> +		err += env_set("ipaddr", ip4addr_ntoa(&dhcp->offered_ip_addr));
> +		err += env_set("netmask", ip4addr_ntoa(&dhcp->offered_sn_mask));
> +		err += env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
> +		if (err)
> +			log_err("error update envs\n");
> +		log_info("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp->offered_ip_addr));
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +int ulwip_dhcp(void)
> +{
> +	struct netif *netif;
> +	int eth_idx;
> +
> +	eth_idx = eth_get_dev_index();
> +	if (eth_idx < 0)
> +		return -EPERM;
> +
> +	netif = netif_get_by_index(eth_idx + 1);

Why is the +1 needed here?

> +	if (!netif)
> +		return -ENOENT;
> +
> +	sys_timeout(DHCP_WAIT_MS, dhcp_tmo, netif);
> +
> +	return dhcp_start(netif) ? 0 : -EPERM;
> +}
> --
> 2.30.2
>
