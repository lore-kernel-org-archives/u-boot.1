Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184D1CFA773
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4624780AE6;
	Fri,  4 Oct 2024 14:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XEjcX3jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3045D885B3; Fri,  4 Oct 2024 08:51:38 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0171588FCB
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-832525e7449so97213039f.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728024692; x=1728629492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1EzmRFUfZRawOub81lbzkKKMbBpcU+6If5Tkt4mh09w=;
 b=XEjcX3jU+NdxbkuWWFWgZJzb52bO1Kw5zYWcSQyyXOfuEg25RkjML54JGFAjIS2Bq7
 eU3pnkFjKDCNczG6XwA7NLlqz8oyzM+PCnIUJqFik/j5aDrXyC+N+DaoIwsGF6jbiD8U
 V+UTgayo1tWhIzvSz5fDG7EKNaPI3ymHE8py87LL8kMAkppJXFj8wUKQUVDhl2WTqXqT
 qp81fbUu5hT3YrsSiJsIG1VjLKfJ47yOcG1D5dBM+4JJd+8SIinoewryEmFBMgzG2ckk
 /FsKZmitqgkBkMsFs2gEFMg1wJ5IhbPB/rxnG1okdMXVOGEBrqdBkx+AoYi4NuOLKR0E
 JSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728024692; x=1728629492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EzmRFUfZRawOub81lbzkKKMbBpcU+6If5Tkt4mh09w=;
 b=cbfsFyZsad4H8ONBSrSxX3uN2U50DIEJ4FFyEhOzKysqqycWJTE+qcbGyMRpdzcmxb
 fcdILDpGffS2f5vjBy6C4D250XaTca/GC7MgiLJA5om7xciDpYNkHrm4NtxS5QKJdyoI
 BnBJG9LCqB6HMmwcldM5wWPmVGGigjNUZ53Vh2wqn4Cy5cp6b8Rfk7cnt2RLvtLEo8RO
 PQekyaZ41zphK7zoI31/DnkHpyA3B47aeFS5ZnI8b88lx2IgkgCn37vxJnCPoKmamstI
 RixqteoTrIwFT4AsVibucXZ8SM8QTlm2r64ApkPpEOUW1oOEhdTxdTH5NHULqtyQYXwl
 YWGg==
X-Gm-Message-State: AOJu0YwQyV9PUbPQraU3QpD2G9wt1uG8CUaFJlGHZen0UDoXjRnvWiWd
 1TXbuyDoXcNdASaqF+M0aXdyVtebH4nAReQrEG0meEpuuE/i7vaUFciX8s8762kHVSB+6eqULp0
 qqzD/xGU8qyzPiyZam7pOnbrnc3ZCzgWeG3RPXw==
X-Google-Smtp-Source: AGHT+IGsdrCKri+Sej+2U281va4MyZK+jdvdeQNWev6AngU6pw8DtzLmsuCg4uYHqdElQmcaUGcFyJka/MdbjXLOex8=
X-Received: by 2002:a05:6e02:b21:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a375994c89mr16622055ab.9.1728024692568; Thu, 03 Oct 2024
 23:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <122c4866fe98a74dc22b18b048b462cb3564c73a.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <122c4866fe98a74dc22b18b048b462cb3564c73a.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:50:56 +0300
Message-ID: <CAC_iWjJZL_QWaKHprgR0d3+9k2EduqOCp+ku4vtuVKyExfcnWA@mail.gmail.com>
Subject: Re: [PATCH v11 13/29] net-lwip: add DHCP support and dhcp commmand
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Petr Zejdl <petr.zejdl@cern.ch>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@intel.com>, Robert Marko <robert.marko@sartura.hr>, 
 Philip Oberfichtner <pro@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 04 Oct 2024 14:47:11 +0200
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

Hi Jerome,

[...]


> +#define DHCP_TIMEOUT_MS 10000
> +
> +#ifdef CONFIG_CMD_TFTPBOOT
> +/* Boot file obtained from DHCP (if present) */
> +static char boot_file_name[DHCP_BOOT_FILE_LEN];
> +#endif
> +
> +static void call_lwip_dhcp_fine_tmr(void *ctx)
> +{
> +       dhcp_fine_tmr();
> +       sys_timeout(10, call_lwip_dhcp_fine_tmr, NULL);
> +}
> +
> +static int dhcp_loop(struct udevice *udev)
> +{
> +       char *ipstr = "ipaddr\0\0";
> +       char *maskstr = "netmask\0\0";
> +       char *gwstr = "gatewayip\0\0";
> +       unsigned long start;
> +       struct netif *netif;
> +       struct dhcp *dhcp;
> +       bool bound;
> +       int idx;
> +
> +       idx = dev_seq(udev);
> +       if (idx < 0 || idx > 99) {
> +               log_err("unexpected idx %d\n", idx);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       netif = net_lwip_new_netif_noip(udev);
> +       if (!netif)
> +               return CMD_RET_FAILURE;
> +
> +       start = get_timer(0);
> +       dhcp_start(netif);

This can fail. Don't we have to check that and exit?

> +       call_lwip_dhcp_fine_tmr(NULL);
> +
> +       /* Wait for DHCP to complete */
> +       do {
> +               net_lwip_rx(udev, netif);
> +               sys_check_timeouts();
> +               bound = dhcp_supplied_address(netif);
> +               if (bound)
> +                       break;
> +               if (ctrlc()) {
> +                       printf("Abort\n");
> +                       break;
> +               }
> +               mdelay(1);
> +       } while (get_timer(start) < DHCP_TIMEOUT_MS);
> +
> +       sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
> +

[...]

> +       free(pp);
> +       if (err) {
> +               log_err("send error %d\n", err);
> +               return ERR_ABRT;
> +       }
> +
> +       return ERR_OK;
> +}
> +
> +static err_t net_lwip_if_init(struct netif *netif)
> +{
> +#if LWIP_IPV4

Do we ever not set this?

> +       netif->output = etharp_output;
> +#endif
> +       netif->linkoutput = linkoutput;
> +       netif->mtu = 1500;
> +       netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
> +
> +       return ERR_OK;
> +}
> +
> +static void eth_init_rings(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < PKTBUFSRX; i++)
> +               net_rx_packets[i] = net_pkt_buf + i  * PKTSIZE_ALIGN;
> +}
> +
> +struct netif *net_lwip_get_netif(void)
> +{
> +       struct netif *netif, *found = NULL;
> +
> +       NETIF_FOREACH(netif) {
> +               if (!found)
> +                       found = netif;
> +               else
> +                       printf("Error: more than one netif in lwIP\n");
> +       }
> +       return found;
> +}
> +
> +static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
> +                             ip4_addr_t *mask, ip4_addr_t *gw)
> +{
> +       char *ipstr = "ipaddr\0\0";
> +       char *maskstr = "netmask\0\0";
> +       char *gwstr = "gatewayip\0\0";
> +       int idx = dev_seq(dev);
> +       char *env;
> +
> +       if (idx < 0 || idx > 99) {
> +               log_err("unexpected idx %d\n", idx);
> +               return -1;
> +       }
> +

[...]

FWIW dhcp seems to work fine

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
