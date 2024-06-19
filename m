Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10042C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C41F88415;
	Wed, 19 Jun 2024 14:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpZlnK7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D6D883F6; Wed, 19 Jun 2024 11:06:46 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497698840F
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 11:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f14af40c2so5308759f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718788002; x=1719392802; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXS3t6XtaPg53HsiTReP/NRgyissTwJLw2RVJaAMZ6o=;
 b=GpZlnK7TJjUlsftLv/zfzUDnZkdbUQEU/Y42Goe6uCqxof+VDc1GNjAc8uJ2IHuvYM
 WoBf7PhT/9fW+jLRIvZEsIJ324AJaHHbjbgCzchrik3rvd4HShlFjUhSEUzLm8nBXL5k
 ZVfYn3RXKaiiQjXlkimXA8VTlBXIDdu3W4px2AWgsjONfZZOWbvn2lOgF2EOe1nN1HnG
 Gz5NByoGoercLuxm+4Dsd2KRnjc2sDBAVlgA8m8jHpjntvY7nkgI/UT3SNisVLVpHeV5
 CHuMTeTytpjznXJeq3VNHRcCc6FdJj7GZ7vzvWcz9Yt8Ml6hY54+gFe6ZsvAGb7ViF2H
 gO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718788002; x=1719392802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXS3t6XtaPg53HsiTReP/NRgyissTwJLw2RVJaAMZ6o=;
 b=ehpt3U39PT34px/DnsSsD9/cM5lfGqIIOh1tIUtl7zBHXnjp6iuT9c3gnrPTjUGJD9
 DCITiKsJY0qbM4qWZEjPwPqQrA6RUsmAnvfsnQ/OhkaiJB+KbSIWupCluoZ2DKmSd8bH
 slexB9K2cDGaBHpvGGvfq4tYtpBpczoNE0q/M8PGwyiWuY3FDDk7YAurgee7NHwzAfVW
 AwBox3cqebD7ynVrC5XNJMsoh5whrktMeHQtJveL5C9cWXh/ymHYnlkrE6eDyhI+OG5B
 qCdsjuQRyK+LddaZUCQuFC5qQf9inw7rpibghuwkIei/qfts8+MptMMyiJKE/KyIieXs
 0A0w==
X-Gm-Message-State: AOJu0YzI0DlnW9eWUd1gEMp2LR/PiBZjLXOEcq0HZAo7AqLvQkJPb2oH
 T/MXJHSk/B9X0jvCxak3JOuojYBvYpqoZ+pLoY/f69tPWVEyKqRtjoY/nE7RC44=
X-Google-Smtp-Source: AGHT+IFAG2ASjyz6qd/6hikWzy4v227ybrYIt6y3S1x/ZBMtkd63eMsqPGhf434ivsMDqXSFP+B5vg==
X-Received: by 2002:a5d:4fc4:0:b0:360:6dc8:4459 with SMTP id
 ffacd0b85a97d-363192d0631mr1035580f8f.50.1718788001485; 
 Wed, 19 Jun 2024 02:06:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b7e0:cc1c:dce0:48f9?
 ([2a01:e0a:3cb:7bb0:b7e0:cc1c:dce0:48f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075114e09sm16510484f8f.117.2024.06.19.02.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 02:06:41 -0700 (PDT)
Message-ID: <b753c9e8-2a70-4856-9a17-09c9319674a2@linaro.org>
Date: Wed, 19 Jun 2024 11:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] net: introduce alternative implementation as
 net-lwip/
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <sean.anderson@seco.com>, Jesse Taube
 <mr.bossman075@gmail.com>, Greg Malysa <greg.malysa@timesys.com>,
 Shengyu Qu <wiagn233@outlook.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ying Sun <sunying@nj.iscas.ac.cn>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bin Meng
 <bmeng.cn@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ion Agorria <ion@agorria.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <f382942cd9d0d62da5204b884c6fa1a59526d262.1718638104.git.jerome.forissier@linaro.org>
 <20240618175933.GV68077@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240618175933.GV68077@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 19 Jun 2024 14:21:41 +0200
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



On 6/18/24 19:59, Tom Rini wrote:
> On Mon, Jun 17, 2024 at 05:32:54PM +0200, Jerome Forissier wrote:
> 
>> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
>> adding a new net-lwip/ directory and the NET_LWIP symbol. Network
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
> [snip]
>> diff --git a/Kconfig b/Kconfig
>> index 82df59f176e..cfe2a6d3eac 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -745,7 +745,48 @@ source "dts/Kconfig"
>>  
>>  source "env/Kconfig"
>>  
>> +choice
>> +	prompt "Networking stack"
>> +	default NET
>> +
>> +config NO_NET
>> +	bool "No networking support"
>> +
>> +config NET
>> +	bool "Legacy U-Boot networking stack"
>> +	imply NETDEVICES
>> +
>> +config NET_LWIP
>> +	bool "Use lwIP for networking stack"
>> +	imply NETDEVICES
>> +	depends on !SANDBOX
>> +	help
>> +	  Include networking support based on the lwIP (lightweight IP)
>> +	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
>> +	  the default U-Boot network stack and applications located in net/
>> +	  and enabled via CONFIG_NET as well as other pieces of code that
>> +	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
>> +	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
>> +	  exclusive.
>> +
>> +endchoice
> 
> For ease of reviewability the next patch in the series should change all
> of the configs with '# CONFIG_NET is not set' to 'CONFIG_NO_NET=y' so
> that they functionally don't change. It's 105 files and so while it will
> be folded in when lwIP is ready for merge, keeping it separate for now
> will make review easier.

OK, done in v6.

Thanks,
-- 
Jerome
