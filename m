Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F1EC001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 09:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F7B86954;
	Wed, 16 Aug 2023 11:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T3IGShpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97452867E2; Wed, 16 Aug 2023 11:01:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EAF86954
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-319e93a1594so497188f8f.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692176506; x=1692781306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/9hSdIa1pF12ebr5EOJ9zT9BWgE3Wpg6xW+ScaD2Pp8=;
 b=T3IGShptjUihP6VlYB72kuBfMvzRLN+gzc/y6wpfwtGI9FyLTLOCpT5HfpDkdP8w68
 FB4zlB5+ygsKeZjMqP7O1USjwqqznElegKg5clXIwgFeLspybaVAQKrkvMGpzH1fnaq7
 cvHzeZSEO736XloPcXDvs1FGkCMi6Uv6pBwh6qROQ/ia1bpts8d7nodRsJYcLBCsQzmF
 LUmOL+7dNDo/zQZBGjRFVbTJRuYvTKxVoIwwe7c5GzkiJNXdP0BkOZM75XmNcuizy7em
 WUZv+PEFlKacOl6Z4NQ3xgE78hcsbAXM2gFCydzdC9w9vWyMNwGu96kMUQXLaChgtGD9
 L8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692176506; x=1692781306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9hSdIa1pF12ebr5EOJ9zT9BWgE3Wpg6xW+ScaD2Pp8=;
 b=i04r8vA/LpExt94DGYajPZEZfq9hbzRVNw++WEnW5asH0tYTjrEEc76c3EQP9ln8qL
 Q3FIpE5BH26Tnsr1lEGtj5zRnOD9bNwcm+AW4voECY8Yq9wK+7Wn948ogqK1xXmp6HNz
 b7s75dw5menEGEzb8iCD0ZuM7cCUY5mEuQ1oY1+bmf7rK3blObfDmgChmqYY4iJuLh/s
 brM2FeXZBrasB2Rovjv1LdEjTuCq4J11/d2+YBK8UZrYaWei2hp1oHEjc1IkNUMdaVHD
 2CWeaDSt9GxfHCuBlST0HtrWAxr1Ux+wAbAsgik459mATY+hPoqj0PFSdWG2ZsG5IOz3
 khfw==
X-Gm-Message-State: AOJu0YwQdJIbzc32MiJxF4D9K3Z9dHSHhF6gaTw9JvjTG7reculp2DHj
 GIR4/KJggHDOluB5AsnAZkD+WA==
X-Google-Smtp-Source: AGHT+IEYFKbRq0iPbS/qfSG1e9CYV7/OLUA16McUoUF1d/nsPpzm9t/PNmfKA1++F7IA7nwqMX4vBA==
X-Received: by 2002:adf:fe0d:0:b0:319:7abf:d8e2 with SMTP id
 n13-20020adffe0d000000b003197abfd8e2mr927254wrr.24.1692176506087; 
 Wed, 16 Aug 2023 02:01:46 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 b11-20020adfde0b000000b003197e3520ddsm7580604wrm.109.2023.08.16.02.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 02:01:45 -0700 (PDT)
Date: Wed, 16 Aug 2023 12:01:43 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 lwip-devel@nongnu.org
Subject: Re: [PATCHv6 09/14] net/lwip: implement lwIP port to U-Boot
Message-ID: <ZNyQd/ACGjraW139@hades>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-10-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814133253.4150-10-maxim.uvarov@linaro.org>
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

On Mon, Aug 14, 2023 at 07:32:48PM +0600, Maxim Uvarov wrote:
> Implement network lwIP interface connected to the U-boot.
> Keep original file structure widely used fro lwIP ports.
> (i.e. port/if.c port/sys-arch.c).

What the patch does is obvious.  Try to describe *why* we need this 

> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  net/eth-uclass.c                      |   8 +
>  net/lwip/port/if.c                    | 260 ++++++++++++++++++++++++++
>  net/lwip/port/include/arch/cc.h       |  39 ++++
>  net/lwip/port/include/arch/sys_arch.h |  56 ++++++
>  net/lwip/port/include/limits.h        |   0
>  net/lwip/port/sys-arch.c              |  20 ++
>  6 files changed, 383 insertions(+)
>  create mode 100644 net/lwip/port/if.c
>  create mode 100644 net/lwip/port/include/arch/cc.h
>  create mode 100644 net/lwip/port/include/arch/sys_arch.h
>  create mode 100644 net/lwip/port/include/limits.h
>  create mode 100644 net/lwip/port/sys-arch.c
> 
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index c393600fab..6625f6d8a5 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -32,6 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  struct eth_device_priv {
>  	enum eth_state_t state;
>  	bool running;
> +	ulwip ulwip;
>  };
>  
>  /**
> @@ -347,6 +348,13 @@ int eth_init(void)
>  	return ret;
>  }
>  
> +struct ulwip *eth_lwip_priv(struct udevice *current)
> +{
> +	struct eth_device_priv *priv = dev_get_uclass_priv(current);
> +
> +	return &priv->ulwip;
> +}
> +
>  void eth_halt(void)
>  {
>  	struct udevice *current;
> diff --git a/net/lwip/port/if.c b/net/lwip/port/if.c
> new file mode 100644
> index 0000000000..625a9c10bf
> --- /dev/null
> +++ b/net/lwip/port/if.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <net/eth.h>
> +#include "lwip/debug.h"
> +#include "lwip/arch.h"
> +#include "netif/etharp.h"
> +#include "lwip/stats.h"
> +#include "lwip/def.h"
> +#include "lwip/mem.h"
> +#include "lwip/pbuf.h"
> +#include "lwip/sys.h"
> +#include "lwip/netif.h"
> +#include "lwip/ethip6.h"
> +
> +#include "lwip/ip.h"
> +
> +#define IFNAME0 'e'
> +#define IFNAME1 '0'

Why is this needed and how was 'e0' chosen?
Dont we have a device name in the udevice struct?

> +
> +static struct pbuf *low_level_input(struct netif *netif);
> +
> +int ulwip_enabled(void)
> +{
> +	struct ulwip *ulwip;
> +
> +	ulwip = eth_lwip_priv(eth_get_dev());

eth_get_dev() can return NULL.  There are various locations of this call
that needs fixing

> +	return ulwip->init_done;
> +}
> +
> +
> +struct ulwip_if {
> +};

Why the forward declaration?

> +
> +#define LWIP_PORT_INIT_NETMASK(addr)  IP4_ADDR((addr), 255, 255, 255, 0)

Why are we limiting the netmask to a class C network?

> +
> +void ulwip_poll(void)
> +{
> +	struct pbuf *p;
> +	int err;
> +	struct netif *netif = netif_get_by_index(1);

First of all netif can be NULL. Apart from that always requesting index 1
feels wrong.  We should do something similar to eth_get_dev() and get the
*active* device correlation to an index

> +
> +	p = low_level_input(netif);
> +	if (!p) {
> +		log_err("error p = low_level_input = NULL\n");

This looks like a debug message.
'Network interface undefined' or something else, which is more readable. 

> +		return;
> +	}
> +
> +	/* ethernet_input always returns ERR_OK */
> +	err = ethernet_input(p, netif);
> +	if (err)
> +		log_err("ip4_input err %d\n", err);
> +
> +	return;
> +}
> +
> +static struct pbuf *low_level_input(struct netif *netif)
> +{
> +	struct pbuf *p, *q;
> +	u16_t len = net_rx_packet_len;
> +	uchar *data = net_rx_packet;
> +
> +	/* We allocate a pbuf chain of pbufs from the pool. */
> +	p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
> +	if (p) {

if (!p) and reverse the logic 

> +		/* We iterate over the pbuf chain until we have read the entire
> +		 * packet into the pbuf.
> +		 */
> +		for (q = p; q != NULL; q = q->next) {
> +			/* 
> +			 * Read enough bytes to fill this pbuf in the chain. The
> +			 * available data in the pbuf is given by the q->len
> +			 * variable.
> +			 * This does not necessarily have to be a memcpy, you can also preallocate
> +			 * pbufs for a DMA-enabled MAC and after receiving truncate it to the
> +			 * actually received size. In this case, ensure the tot_len member of the
> +			 * pbuf is the sum of the chained pbuf len members.
> +			 */
> +			MEMCPY(q->payload, data, q->len);
> +			data += q->len;
> +		}
> +		// acknowledge that packet has been read();
> +
> +		LINK_STATS_INC(link.recv);
> +	} else {
> +		// drop packet();

Is this a commented function that's missing?

> +		LINK_STATS_INC(link.memerr);
> +		LINK_STATS_INC(link.drop);
> +	}
> +
> +	return p;
> +}
> +
> +static int ethernetif_input(struct pbuf *p, struct netif *netif)
> +{
> +	struct ethernetif *ethernetif;
> +
> +	ethernetif = netif->state;
> +
> +	/* move received packet into a new pbuf */
> +	p = low_level_input(netif);
> +
> +	/* if no packet could be read, silently ignore this */
> +	if (p) {
> +		/* pass all packets to ethernet_input, which decides what packets it supports */
> +		if (netif->input(p, netif) != ERR_OK) {
> +			LWIP_DEBUGF(NETIF_DEBUG, ("%s: IP input error\n", __func__));
> +			pbuf_free(p);
> +			p = NULL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static err_t low_level_output(struct netif *netif, struct pbuf *p)
> +{
> +	int err;
> +
> +	err = eth_send(p->payload, p->len);
> +	if (err) {
> +		log_err("eth_send error %d\n", err);
> +		return ERR_ABRT;
> +	}
> +	return ERR_OK;
> +}
> +
> +err_t ulwip_if_init(struct netif *netif)
> +{
> +	struct ulwip_if *uif;
> +	struct ulwip *ulwip;
> +
> +	uif = malloc(sizeof(struct ulwip_if));
> +	if (!uif) {
> +		log_err("uif: out of memory\n");
> +		return ERR_MEM;
> +	}
> +	netif->state = uif;
> +
> +	netif->name[0] = IFNAME0;
> +	netif->name[1] = IFNAME1;
> +
> +	netif->hwaddr_len = ETHARP_HWADDR_LEN;
> +	string_to_enetaddr(env_get("ethaddr"), netif->hwaddr);

What if ethaddr is not set?

> +#if defined(CONFIG_LWIP_LIB_DEBUG)
> +	printf("              MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
> +	       netif->hwaddr[0], netif->hwaddr[1], netif->hwaddr[2],
> +	       netif->hwaddr[3], netif->hwaddr[4], netif->hwaddr[5]);
> +#endif
> +#if LWIP_IPV4
> +	netif->output = etharp_output;
> +#endif
> +#if LWIP_IPV6
> +	netif->output_ip6 = ethip6_output;
> +#endif
> +
> +	netif->linkoutput = low_level_output;
> +	netif->mtu = 1500;
> +	netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
> +
> +	ulwip = eth_lwip_priv(eth_get_dev());
> +	ulwip->init_done = 1;
> +	if (IS_ENABLED(CONFIG_LWIP_LIB_DEBUG)) {
> +		log_info("Initialized LWIP stack\n");
> +	}
> +
> +	return ERR_OK;
> +}
> +
> +int ulwip_init(void)
> +{
> +	ip4_addr_t ipaddr, netmask, gw;
> +	struct netif *unetif;
> +	struct ulwip *ulwip;
> +	int ret;
> +
> +	ret = eth_init();
> +	if (ret) {
> +		log_err("eth_init error %d\n", ret);
> +		return ERR_IF;
> +	}
> +
> +	ulwip = eth_lwip_priv(eth_get_dev());
> +	if (ulwip->init_done)
> +		return CMD_RET_SUCCESS;
> +
> +	unetif = malloc(sizeof(struct netif));
> +	if (!unetif)
> +		return ERR_MEM;
> +	memset(unetif, 0, sizeof(struct netif));
> +
> +	ip4_addr_set_zero(&gw);
> +	ip4_addr_set_zero(&ipaddr);
> +	ip4_addr_set_zero(&netmask);
> +
> +	ipaddr_aton(env_get("ipaddr"), &ipaddr);
> +	ipaddr_aton(env_get("ipaddr"), &netmask);
> +
> +	LWIP_PORT_INIT_NETMASK(&netmask);
> +	if (IS_ENABLED(CONFIG_LWIP_LIB_DEBUG)) {
> +		printf("Starting lwIP, IP: %s\n", ip4addr_ntoa(&ipaddr));
> +		printf("               GW: %s\n", ip4addr_ntoa(&gw));
> +		printf("             mask: %s\n", ip4addr_ntoa(&netmask));

log_info()

> +	}
> +
> +	if (!netif_add(unetif, &ipaddr, &netmask, &gw,
> +		       unetif, ulwip_if_init, ethernetif_input))
> +		printf("err: netif_add failed!\n");
> +
> +	netif_set_up(unetif);
> +	netif_set_link_up(unetif);
> +#if LWIP_IPV6
> +	netif_create_ip6_linklocal_address(unetif, 1);
> +	printf("             IPv6: %s\n", ip6addr_ntoa(netif_ip6_addr(unetif, 0)));
> +#endif /* LWIP_IPV6 */
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +/* placeholder, not used now */
> +void ulwip_destroy(void)
> +{
> +}
> diff --git a/net/lwip/port/include/arch/cc.h b/net/lwip/port/include/arch/cc.h
> new file mode 100644
> index 0000000000..55f7787ce1
> --- /dev/null
> +++ b/net/lwip/port/include/arch/cc.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#ifndef LWIP_ARCH_CC_H
> +#define LWIP_ARCH_CC_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +//#include <stdlib.h>    /* getenv, atoi */

Please dont leave comments like that 

> +#include <vsprintf.h>
> +
> +#define LWIP_ERRNO_INCLUDE <errno.h>
> +
> +#define LWIP_ERRNO_STDINCLUDE	1
> +#define LWIP_NO_UNISTD_H 1
> +#define LWIP_TIMEVAL_PRIVATE 1

Should those be defined in the LWIP config header instead?

> +
> +extern unsigned int lwip_port_rand(void);

This is like the forth time we go through this and it's a repeating
pattern.  Why do we need this extern? Can't we just include the proper
header files?

> +#define LWIP_RAND() (lwip_port_rand())

This seems quite useless. Just use the function directly

> +
> +/* different handling for unit test, normally not needed */
> +#ifdef LWIP_NOASSERT_ON_ERROR
> +#define LWIP_ERROR(message, expression, handler) do { if (!(expression)) { \
> +						    handler; }} while (0)
> +#endif
> +
> +#define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
> +
> +#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at line %d in %s\n", \
> +				    x, __LINE__, __FILE__); } while (0)
> +
> +#define atoi(str) (int)dectoul(str, NULL)
> +
> +#define LWIP_ERR_T int
> +
> +#endif /* LWIP_ARCH_CC_H */
> diff --git a/net/lwip/port/include/arch/sys_arch.h b/net/lwip/port/include/arch/sys_arch.h
> new file mode 100644
> index 0000000000..92a8560d49
> --- /dev/null
> +++ b/net/lwip/port/include/arch/sys_arch.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#ifndef LWIP_ARCH_SYS_ARCH_H
> +#define LWIP_ARCH_SYS_ARCH_H
> +
> +#include "lwip/opt.h"
> +#include "lwip/arch.h"
> +#include "lwip/err.h"
> +
> +#define ERR_NEED_SCHED 123
> +
> +void sys_arch_msleep(u32_t delay_ms);
> +#define sys_msleep(ms) sys_arch_msleep(ms)

Dont redefine random functions here.  U-Boot should already have all the
sleep functions you need

> +
> +#if SYS_LIGHTWEIGHT_PROT

Is this working? Can we define SYS_LIGHTWEIGHT_PROT?

> +typedef u32_t sys_prot_t;
> +#endif /* SYS_LIGHTWEIGHT_PROT */
> +
> +#include <errno.h>
> +
> +#define SYS_MBOX_NULL NULL
> +#define SYS_SEM_NULL  NULL
> +
> +typedef u32_t sys_prot_t;
> +
> +typedef struct sys_sem *sys_sem_t;
> +#define sys_sem_valid(sem) (((sem) != NULL) && (*(sem) != NULL))
> +#define sys_sem_set_invalid(sem) do { if ((sem) != NULL) { *(sem) = NULL; }} while (0)
> +
> +/* let sys.h use binary semaphores for mutexes */
> +#define LWIP_COMPAT_MUTEX 1
> +#define LWIP_COMPAT_MUTEX_ALLOWED 1
> +
> +struct sys_mbox;
> +typedef struct sys_mbox *sys_mbox_t;
> +#define sys_mbox_valid(mbox) (((mbox) != NULL) && (*(mbox) != NULL))
> +#define sys_mbox_set_invalid(mbox) do { if ((mbox) != NULL) { *(mbox) = NULL; }} while (0)

All these macros seem unnecessary.  Just assign types to NULL directly etc

> +
> +struct sys_thread;
> +typedef struct sys_thread *sys_thread_t;
> +
> +static inline u32_t sys_arch_sem_wait(sys_sem_t *sem, u32_t timeout)
> +{
> +	return 0;
> +};
> +
> +static inline err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg)
> +{
> +	return 0;
> +};

Are those really needed?  Why do we just return 0? 

> +
> +#endif /* LWIP_ARCH_SYS_ARCH_H */
> diff --git a/net/lwip/port/include/limits.h b/net/lwip/port/include/limits.h
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/net/lwip/port/sys-arch.c b/net/lwip/port/sys-arch.c
> new file mode 100644
> index 0000000000..609eeccf8c
> --- /dev/null
> +++ b/net/lwip/port/sys-arch.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <rand.h>
> +#include "lwip/opt.h"
> +
> +u32_t sys_now(void)
> +{
> +	return get_timer(0);
> +}
> +
> +u32_t lwip_port_rand(void)
> +{
> +	return (u32_t)rand();

I dont see why we cant use the U-Boot defined ones directly

> +}
> +
> -- 
> 2.30.2
> 

Thanks
/Ilias
