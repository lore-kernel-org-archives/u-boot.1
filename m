Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0394C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618CE8863C;
	Fri, 26 Jul 2024 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZvQHfT4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085BF82BA7; Fri, 26 Jul 2024 14:08:22 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BDA884CC
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso202245766b.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721995697; x=1722600497; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqgA/mz1ubTJ7pH8diEJHmREFgkYo82fVmsFQT3e7a0=;
 b=ZvQHfT4QCozuARaBLOuXtWvAc295RjFZvSrlXQlwrM5uJeQW0xg0APNDs4VN62Q9Y8
 P6aXFgaKFyQj5DqGoBI+X11qj13EVIQT62uRcIZ4elSkBguWJT7OzdFZMrADa81sX+ra
 uk6cHLNB6rwcWlgMktT3AVgcvQaYaio9HPjS2Nle0QRxhT1HGpEt0DSQ8zc36coc4EH8
 55w7Mn9TBN/h+b/5T/oNToFRjdtxlTouPaIsmD3J13Qcyhj0w/kDvgwF9iul3ZCbM8dt
 ICrPpJxeytQNxDzSuhS1tSwlyUQMqJ8hamyoruP/cGq0y7SkX94NkZ9k/YcmggnhFWTL
 cQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721995697; x=1722600497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqgA/mz1ubTJ7pH8diEJHmREFgkYo82fVmsFQT3e7a0=;
 b=jiWmZxYONryioeO3V5uxPiZeDW8VbTHEXZ9GyrQSjtmxGf2gSotVw1xb0gyU22Nd3z
 C5Bs6PeQ+u7aIOZS+7326c2yWAoqEZTSnzGjzK59yCXGjAHP2Tji1bE6guT4YeaMngVp
 XvuOIfh0igIQBEdrVki4F4bhY/oFKNC6DUJ99XP8YBxxYUa9HYyT39SG+E6ccfawYgvX
 vzCN2dkKPkLNlH68GrMBRDuyRvMGIitTJd3T4hwb98CbebKZXJNWoxdyUhw+IWMycfTH
 NIb9iYKXfarfban5F/E5shsLZFbXGHiW9g4Ep19d0lErK4V7MsRC4PWXtd98ErXpcZZK
 LxVg==
X-Gm-Message-State: AOJu0Yyd+9jImcgSM0cbe+a39Eh299Bup+iiNwlke2TsgdY1WTWQA9Jd
 oP46yzUz9BTQkIXOXGR82cIaNkP13XQVR3nPM7fSELp9qmstMh2BIOR0rE5yAk4=
X-Google-Smtp-Source: AGHT+IGR4u9t97P0KkXk+18Xm5KQuhNi242nq9kBB6pVYP3LJSlKTOZ+IW/I8gsJuswbU84i5w2x0Q==
X-Received: by 2002:a17:907:3e91:b0:a7a:c619:5105 with SMTP id
 a640c23a62f3a-a7acb51e25emr402961666b.40.1721995697276; 
 Fri, 26 Jul 2024 05:08:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa?
 ([2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab28249sm168425866b.30.2024.07.26.05.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 05:08:17 -0700 (PDT)
Message-ID: <44223a7d-805f-4882-842a-8e5fa1814d39@linaro.org>
Date: Fri, 26 Jul 2024 14:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/20] net: introduce alternative implementation as
 net-lwip/
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bo Gan <ganboing@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 John Keeping <jkeeping@inmusicbrands.com>, Shengyu Qu
 <wiagn233@outlook.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng@tinylab.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>, Samuel Holland
 <samuel@sholland.org>, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>, Ion Agorria <ion@agorria.com>,
 Yang Xiwen <forbidden405@outlook.com>, Boon Khai Ng
 <boon.khai.ng@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
 <20240725161754.GW989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725161754.GW989285@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 26 Jul 2024 14:43:57 +0200
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



On 7/25/24 18:17, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 02:57:23PM +0200, Jerome Forissier wrote:
> 
>> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
>> adding a new net/lwip/ directory and the NET_LWIP symbol. Network
>> support is either NO_NET, NET (legacy stack) or NET_LWIP. Subsequent
>> commits will introduce the lwIP code, re-work the NETDEVICE integration
>> and port some of the NET commands and features to lwIP.
>>
>> SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
>> that are part of NET (such as arp_init(), arp_timeout_check(),
>> arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
>> added later.
>>
>> Similarly, DFU_TFTP and FASTBOOT are not compatible with NET_LWIP
>> because of dependencies on net_loop(), tftp_timeout_ms,
>> tftp_timeout_count_max and other NET things. Let's add a dependency on
>> !NET_LWIP for now.
>>
>> As for SANDBOX, NET_LWIP cannot be used either because of strong
>> assumptions on the network stack. Make NET_LWIP depend on !SANDBOX so
>> that the NET_LWIP alternative is not visible in make menuconfig when
>> sandbox_defconfig is used.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> [snip]
> 
> Here in net/Kconfig you do..
>> +if NET || NET_LWIP
>> +
>> +config BOOTDEV_ETH
>> +	bool "Enable bootdev for ethernet"
>> +	depends on BOOTSTD
>> +	default y
>> +	help
>> +	  Provide a bootdev for ethernet so that is it possible to boot
>> +	  an operating system over the network, using the PXE (Preboot
>> +	  Execution Environment) protocol.
>> +
>>  config SYS_RX_ETH_BUFFER
>>  	int "Number of receive packet buffers"
>>  	default 4
> 
> But we must have SYS_RX_ETH_BUFFER defined even in the NO_NET case as
> otherwise previously <net.h> and now <net-common.h> cannot be used, and
> untying that is another big mess. We include <net.h> in common areas for
> function prototypes where their usage is guarded. But we use PKTBUFSRX
> in some structs that aren't guarded. Trying to build for example for
> am62x_beagleplay_r5 with this series blows up in a lot of places.

I have moved SYS_RX_ETH_BUFFER out of the 'if NET || NEW_LWIP' in v6.

Thanks,
-- 
Jerome
