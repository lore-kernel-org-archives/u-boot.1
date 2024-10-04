Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB65CFA776
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFC688CEB;
	Fri,  4 Oct 2024 14:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gR268mo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426FD88F6B; Fri,  4 Oct 2024 10:43:07 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F98B8901A
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 10:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fac9eaeafcso22361791fa.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728031382; x=1728636182; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1iBed1qVdqd+z901qgw/BUWCc5EJ3lbKgZ+m7UYnG9s=;
 b=gR268mo5XsbwjFMivWQAQAMRf7h+Y4RN89gCrwWgrvLapE1Sn9b4WZyrwYizhe3yOZ
 3TC/bmprlVDkI4fEwkmtn4TVjtlzMxOGlKl580Igg+b1WuAwPyeCy6CMzAHi0fu2zFlI
 L6iCJ8Q/JLGQvIfvRLHK79KXCecwSFwgXPeZn/delCY6Vx3tispjk0CjmMb3yYmnyeDe
 o1aNSh0S1k8/FqMkvXjdYKuSr+bAm9/LVT28lK1PFWgIqytAGafRAhwT1x+pQT1Rx0pz
 21tTOPEymM+vbQaULA/bEWPVu4bYCCmTa9VLC61/oFmzpzrZJwFrX1x+NShVanenrLn+
 FYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728031382; x=1728636182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1iBed1qVdqd+z901qgw/BUWCc5EJ3lbKgZ+m7UYnG9s=;
 b=Ww3POcGQaClxBo08+cR+mBCo9S5zV6cFGUKirFdVX/RvfMOOSde6Df3AKEOlTkTOGl
 YVU4rwuz7+MWCxzLyCwNrDq9uaJHnFHsCDcOnJPKS5k+bccrcJgtQGaoQwjMucNNi/jl
 kcLk3zIMgZDPWhNt04715CD0wL/FCnFYLwo7REIaNFFobLgPKrNPxx8LTRHLHhPXZGLi
 7UBknxqWeX+iKfFSlLOo63Ma+FSLm5iGQwb57JlnK2foUq6eyWIktLG+UAEC2hTr+QcF
 V7bbMqAUAOoG/VX27dV4vGBwfsE+ccrhXK5BwYPG9om8dQvI6yucwJETARyx334q5TxT
 HTIg==
X-Gm-Message-State: AOJu0YwgX6l37hbAwXZlyifyxYh/DBDaTZ0D7EMEJKIFwgZjXsXM5nk+
 QGEe8P6bDEVT+DkTc0hP23Dc0GJCwnyAUQeYwNiJWkElUjP3q6vtkmNDe4NOKO0=
X-Google-Smtp-Source: AGHT+IGl/OFqbYRhgRhEvrBgo6OQwThfN9rCCJwzq922qe6IazG0TNTOYmxECfYfnv3ttloWYGR4/Q==
X-Received: by 2002:a05:651c:1549:b0:2fa:d772:1009 with SMTP id
 38308e7fff4ca-2faf3d70bdcmr10316141fa.34.1728031382206; 
 Fri, 04 Oct 2024 01:43:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8ca4f7379sm1595124a12.93.2024.10.04.01.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 01:43:01 -0700 (PDT)
Message-ID: <3615af41-0cbf-4de3-9ce6-8ed83f66ad0a@linaro.org>
Date: Fri, 4 Oct 2024 10:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/29] net-lwip: add DHCP support and dhcp commmand
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>,
 Gilles Talis <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>, Petr Zejdl <petr.zejdl@cern.ch>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Yang Xiwen <forbidden405@outlook.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Robert Marko
 <robert.marko@sartura.hr>, Philip Oberfichtner <pro@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <122c4866fe98a74dc22b18b048b462cb3564c73a.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjJZL_QWaKHprgR0d3+9k2EduqOCp+ku4vtuVKyExfcnWA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJZL_QWaKHprgR0d3+9k2EduqOCp+ku4vtuVKyExfcnWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 10/4/24 08:50, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> [...]
> 
> 
>> +#define DHCP_TIMEOUT_MS 10000
>> +
>> +#ifdef CONFIG_CMD_TFTPBOOT
>> +/* Boot file obtained from DHCP (if present) */
>> +static char boot_file_name[DHCP_BOOT_FILE_LEN];
>> +#endif
>> +
>> +static void call_lwip_dhcp_fine_tmr(void *ctx)
>> +{
>> +       dhcp_fine_tmr();
>> +       sys_timeout(10, call_lwip_dhcp_fine_tmr, NULL);
>> +}
>> +
>> +static int dhcp_loop(struct udevice *udev)
>> +{
>> +       char *ipstr = "ipaddr\0\0";
>> +       char *maskstr = "netmask\0\0";
>> +       char *gwstr = "gatewayip\0\0";
>> +       unsigned long start;
>> +       struct netif *netif;
>> +       struct dhcp *dhcp;
>> +       bool bound;
>> +       int idx;
>> +
>> +       idx = dev_seq(udev);
>> +       if (idx < 0 || idx > 99) {
>> +               log_err("unexpected idx %d\n", idx);
>> +               return CMD_RET_FAILURE;
>> +       }
>> +
>> +       netif = net_lwip_new_netif_noip(udev);
>> +       if (!netif)
>> +               return CMD_RET_FAILURE;
>> +
>> +       start = get_timer(0);
>> +       dhcp_start(netif);
> 
> This can fail. Don't we have to check that and exit?

Yes, will fix.

>> +       call_lwip_dhcp_fine_tmr(NULL);
>> +
>> +       /* Wait for DHCP to complete */
>> +       do {
>> +               net_lwip_rx(udev, netif);
>> +               sys_check_timeouts();
>> +               bound = dhcp_supplied_address(netif);
>> +               if (bound)
>> +                       break;
>> +               if (ctrlc()) {
>> +                       printf("Abort\n");
>> +                       break;
>> +               }
>> +               mdelay(1);
>> +       } while (get_timer(start) < DHCP_TIMEOUT_MS);
>> +
>> +       sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
>> +
> 
> [...]
> 
>> +       free(pp);
>> +       if (err) {
>> +               log_err("send error %d\n", err);
>> +               return ERR_ABRT;
>> +       }
>> +
>> +       return ERR_OK;
>> +}
>> +
>> +static err_t net_lwip_if_init(struct netif *netif)
>> +{
>> +#if LWIP_IPV4
> 
> Do we ever not set this?

No. Removed in v12.

 
>> +       netif->output = etharp_output;
>> +#endif
>> +       netif->linkoutput = linkoutput;
>> +       netif->mtu = 1500;
>> +       netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
>> +
>> +       return ERR_OK;
>> +}
>> +
>> +static void eth_init_rings(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < PKTBUFSRX; i++)
>> +               net_rx_packets[i] = net_pkt_buf + i  * PKTSIZE_ALIGN;
>> +}
>> +
>> +struct netif *net_lwip_get_netif(void)
>> +{
>> +       struct netif *netif, *found = NULL;
>> +
>> +       NETIF_FOREACH(netif) {
>> +               if (!found)
>> +                       found = netif;
>> +               else
>> +                       printf("Error: more than one netif in lwIP\n");
>> +       }
>> +       return found;
>> +}
>> +
>> +static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>> +                             ip4_addr_t *mask, ip4_addr_t *gw)
>> +{
>> +       char *ipstr = "ipaddr\0\0";
>> +       char *maskstr = "netmask\0\0";
>> +       char *gwstr = "gatewayip\0\0";
>> +       int idx = dev_seq(dev);
>> +       char *env;
>> +
>> +       if (idx < 0 || idx > 99) {
>> +               log_err("unexpected idx %d\n", idx);
>> +               return -1;
>> +       }
>> +
> 
> [...]
> 
> FWIW dhcp seems to work fine
> 
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Thanks
> /Ilias

Thanks,
-- 
Jerome
