Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BEBD49230
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF75835B3;
	Fri, 12 Dec 2025 15:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dOF0dJY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 625F88367F; Fri, 12 Dec 2025 15:41:43 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDAE8334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477770019e4so13365355e9.3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765550501; x=1766155301; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62k/G3sg1ICR7NDJ/qjoRUihscU3RosH3GQMgrX52Ws=;
 b=dOF0dJY/JDd6ErrPZDnulvjyhk4thf/xxUg0A2kFzZ3rT3T0gtrz9itk/ln895+09x
 OmSbvUj9NEAP5eu2o01/CqEdQ4Hunvg+0xOj4RlA3/s1yyZhN/pCTJhT13KbLwkfy9ov
 I2WMEJlSPM06KPQCHKURu20dlsqCMwlEDEwpAnb4H74Q1hPJ9xj8+Ur+NQt2EuwjoB6O
 jmrNfu/Wu9xk2KLRfV3ZkhB3wel2BcU6+vBbDqJJIFbmAmHDgkg0QOT2nvZN1iWq3EgG
 CC8C7xD9R6Fq839zRUvpdO6rmknlaasuMLSbjtEiTjXiqVjXfvIEN2y2ETNTzCQ4USKn
 gdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765550501; x=1766155301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62k/G3sg1ICR7NDJ/qjoRUihscU3RosH3GQMgrX52Ws=;
 b=Ojp3W380iDA8XGhjHRu76fDyHkoytr3hSAdCTFw3ukDkPZO+dyRnkqqgepRg8YY73b
 hCitj0VLB33ACdgU9S6Bq7o1RlR/exKyCnHHd+MLgGDCRqEL3aB16B8e82pSMgSF8Lsf
 Br/CrA6DK2hV7AE+z0YDTTTid5T1XyxxAv/oIXFWZF+hCiad5kMbCxksgtw1GXLytlDx
 4vYu+HWaZRTKthRNCbwvJP29IxKbJfdj6CYnx7ZkQLQxYyts6rGjTSAafm4k3txYhqCH
 G8zGpGGXmvigCu1dybNrIvX1sWk67FYpgwCFbdTIgdtgg8pyyingN0AIWLFdmSmyu3VT
 Hqig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0E/0awSHtLsAsZdhsOIV3pppy3ZOBE98ZqRZXlPRFWK5B1vZoMpWS+qgvhoaLs3FWk3KaaBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7QCiBkxeF6xJXUMuqR5EUdqGdASHaf2GnQYiajbQIKSuNn3lg
 2hAvnucdluCPdcHMNOjfQlxyNVdF4oRo0iuy7WbnwubMsft3d4vRONPAXATyyU+kxBM=
X-Gm-Gg: AY/fxX6XL48kUoRPpvqzB85qaSHLroLIpBhz1OOi0gpiAc/X8AhhBxsV5L+FTfT2v/7
 FKVZg+I0O6qZtT1lwSnMRq8Y6csRgwdDcK+pUdswmUlABR2uqCpPw7uo664VMVTXZFwSbvEfLxa
 lMpm+LdmpL8TCdG2YHr5YpGavXcr0IgwnZXEHy71f61BXoQ5C+7Td8ihMdvQQQv3nnnZu40O4tK
 s4UFH5YoIPSXMHGfrfYTDvKgqAeH7bDnQc9Q/f6/WjhvHNG90XTyK2C/Dl30ORrDvNXK/eDt0Ry
 1fg+LkUDeNiVcxOC/LfEJxsKgvJiEAGJljbvj3OO1MkU2cOvmyJhcDRLXxWHG9MJB7IzYjyoenv
 5ICAcNsYXPav8bV5vXDSU3gJI3Jrpv2DWxtzKL4xM9rkAFh5ea3ubaShOFlr6uE30qdOUYE8jBh
 Abb+Q1ir9Y6EAjYN1huIvm7W3ZZxZ7FJUAs1TTY31SCm82tSJYGq8pQkxiT6QafN8oPBKOGAyY6
 uxM
X-Google-Smtp-Source: AGHT+IFZf/9GDfWKc8EmFVlsp7+a72FVozwWAMwI2S+0UOKnu0dQvIoBttW+vf035v4Svi2dXEvgWQ==
X-Received: by 2002:a05:6000:186e:b0:429:cda2:9ffe with SMTP id
 ffacd0b85a97d-42fb44a38a2mr2298683f8f.7.1765550500526; 
 Fri, 12 Dec 2025 06:41:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b1f1sm12467320f8f.39.2025.12.12.06.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 06:41:40 -0800 (PST)
Message-ID: <51201122-b293-4223-b09e-cd8adaaa3b08@linaro.org>
Date: Fri, 12 Dec 2025 15:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] net: Move some variables to net-common files
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
 Martyn Welch <martyn.welch@collabora.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
 <20251212-lwip_nfs-v2-2-9cb5a60520d8@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-2-9cb5a60520d8@linaro.org>
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

On 12/12/25 12:32, Andrew Goodbody wrote:
> Make some variables available to be used by either the legacy network
> code or lwIP by moving them into the net-common files. This also allowed
> removing a small number of duplicated variables from the lwIP code.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  include/net-common.h | 12 ++++++++++--
>  include/net-legacy.h |  5 -----
>  net/lwip/net-lwip.c  |  5 -----
>  net/net-common.c     |  9 +++++++++
>  net/net.c            | 10 ----------
>  5 files changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/include/net-common.h b/include/net-common.h
> index d7a0f7dff7e50527e77419ead9a9ff30deeea545..f293b21bc0bb3c8e1a04ffd8f5188e5ce67d1d12 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -132,13 +132,21 @@ static inline void net_set_state(enum net_loop_state state)
>  }
>  
>  extern int		net_restart_wrap;	/* Tried all network devices */
> -extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
> +extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
>  extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
> -extern char	net_boot_file_name[1024];/* Boot File name */
>  extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
>  /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
>  extern char *pxelinux_configfile;
>  
> +/* Our IP addr (0 = unknown) */
> +extern struct in_addr	net_ip;

That one is already mentioned above. Please remove.
The rest of the patch looks fine, so with this fixed:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
