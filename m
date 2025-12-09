Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C051D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 677D483CB9;
	Tue,  9 Dec 2025 16:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tyJY+u8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CF083CB9; Tue,  9 Dec 2025 16:03:32 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BE883C9F
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so1094697166b.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292595; x=1765897395; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHYxJlgPQPORW+h8AfvV8cRlKMeumufTCbjgnvwf6Tk=;
 b=tyJY+u8W6b95BmUxtUPxkNYM7L7jdNAUPJ3nEBEvDz7+W7ZT9xXKrmiYuIGUy7iRk0
 l5/H3bTYhsdz5llIJayGpHft4PKW8HJ8H5pLyFQeIYU2SW5wJTeG7UHyQCZhqTaJ/vA0
 6K+RQsKT5QzVE/0SXZo95eDOdUnrfeZFKZO1y/aoWOg/LLaxmAJ469N/jlDhw131YnQj
 z5AH/GG6LWd/tVjlcykaoPxC0BZZZfbTubZ93APS43/LqtweP9LARrG3DIb6jf6L841r
 FbGyIcfUpi3JTarq9v68SVHeEJDbassvBYeig/zlox8ak4vvLZBilFip5J1a50Xj3QLQ
 EkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292595; x=1765897395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHYxJlgPQPORW+h8AfvV8cRlKMeumufTCbjgnvwf6Tk=;
 b=nxPLf1mmT9jsvc6PHgOtybkJHb/98iuuWYG73H5cc+SsreV0N941+C+hyv89TKYOo/
 jgnRPmYLlJgbS/pbj6Ep5l5wtAAm2F6rlNZ2c+3k32ccdUkEaFDuIpGZVybcAnsvaWBQ
 wxcC79jSW3eJ9slUb+qFLfaHvYwXaJnF4dKgCemrC1IRJe9TGN7X8hxOUo6LmmLblmpG
 xvjCM/Px4BO6icfMaU3+JVpZTWylultdsOM+k01yMRGvZIKS+WiQx5/EAqDveNhCj1IV
 D1Sf98wyFI6ilDUOBaIT/NFaEOvY/G5BlRqNT8XvzjyBHqqD4Ur+V1sgMUYRKi7YoNMn
 H7QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfmn9yQLJY+JaSv+LkJZsPhRfVadYPK4c5vrd9ivGhXVXktPp+ZtvLJMuTgSkJAT7MYZyZG+A=@lists.denx.de
X-Gm-Message-State: AOJu0Yw74hx/AHKtU2ij0YkMMosNicOroM5sBSrJLmgFcJPyi7P0383V
 SmoxGPs/j/NIrBKmohXydAncbIYD1O22BiF6Gkz7zOIb9fUwKlh83IJ7/jYXPfTeuUo=
X-Gm-Gg: ASbGncs8+uOS618WyM4rL4DYRrVMewVYeg3aVt4hKqzkzADUeHmeVDD2zy5i8YmbSJe
 +h/Z9B0Uw0TzusxD+QasMdgL9Di8VFqJBYvfFaf9KY/0tpz0ksfoAKsbTe3y89OqPwYuQbCt0ul
 QRluU0uocZnxi1qwId5JhxI8RkrEtjMlDb1YjurJZAx8ZMqP2yYAxseswUfeimrGp0gIan24rsZ
 Hr55MnIqJUDonv8D2BYqjgZ7MQNj6FKtFVTa74QIlBrahGL5yetUxD0u54stFrP5aJ9sRabVy5W
 YCXK4Jb09TqgbvK9abAZg9wMm5pnw1xECtFUq+MihjVS5/ku9s7Rtg78SK7raK+cI3BgD7cwlNB
 GG770mmJLoruD+31yf615mN+NUJxR+IFMM4wCOt6jwFcSgFfc/VCKcmwac2HZ6+RBFt/KHtyRUX
 m/oSosLmHg1IcfJ72zG6eR3w==
X-Google-Smtp-Source: AGHT+IGXdd1OqvSH6G0L1rNUTlPfqYUKQntyRn32xzl+H1YXnbRa4cRW3b52EK7rVFpfZcch9Qsy+g==
X-Received: by 2002:a17:907:2d87:b0:b76:2f40:a307 with SMTP id
 a640c23a62f3a-b7a24817ae2mr1298429866b.57.1765292595019; 
 Tue, 09 Dec 2025 07:03:15 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4976732sm1417015566b.43.2025.12.09.07.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:03:14 -0800 (PST)
Message-ID: <98449760-4266-4575-91e4-1b84fc634251@linaro.org>
Date: Tue, 9 Dec 2025 16:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: Move some variables to net-common files
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <20251208-lwip_nfs-v1-2-1f5d31e15d00@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-2-1f5d31e15d00@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Andrew,

On 12/8/25 13:52, Andrew Goodbody wrote:
> Make some variables available to be used by either the legacy network
> code or LWIP by moving them into the net-common files. This also allowed
> removing a small number of duplicated variables from the LWIP code.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  include/net-common.h | 21 +++++++++++++++++++--
>  include/net-legacy.h |  9 ---------
>  net/lwip/net-lwip.c  |  5 -----
>  net/net-common.c     | 18 ++++++++++++++++++
>  net/net.c            | 21 ---------------------
>  5 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/include/net-common.h b/include/net-common.h
> index d7a0f7dff7e50527e77419ead9a9ff30deeea545..ea43c72ab06a782c621f61811b9774c1185d88fc 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -132,13 +132,30 @@ static inline void net_set_state(enum net_loop_state state)
>  }
>  
>  extern int		net_restart_wrap;	/* Tried all network devices */
> -extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
> +extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
> +extern uchar		*net_rx_packet;		/* Current receive packet */
>  extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
> -extern char	net_boot_file_name[1024];/* Boot File name */
>  extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
>  /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
>  extern char *pxelinux_configfile;
>  
> +/* Our IP addr (0 = unknown) */
> +extern struct in_addr	net_ip;
> +/* Server IP addr (0 = unknown) */
> +extern struct in_addr	net_server_ip;
> +/* Our subnet mask (0=unknown) */
> +extern struct in_addr net_netmask;
> +/* Our gateways IP address */
> +extern struct in_addr net_gateway;
> +/* Boot File name */
> +extern char	net_boot_file_name[1024];
> +/* Indicates whether the file name was specified on the command line */
> +extern bool	net_boot_file_name_explicit;
> +/* The actual transferred size of the bootfile (in bytes) */
> +extern u32	net_boot_file_size;
> +/* Boot file size in blocks as reported by the DHCP server */
> +extern u32	net_boot_file_expected_size_in_blocks;
> +
>  /**
>   * compute_ip_checksum() - Compute IP checksum
>   *

AFAICT the following variables are NOT used by lwIP and should
therefore stay in net-legacy.h/net.c>: net_rx_packet, net_server_ip,
net_netmask, net_gateway, net_boot_file_name_explicit.

Thanks,
-- 
Jerome
