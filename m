Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC2C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 16:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7CE80FDA;
	Sun, 30 Mar 2025 18:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VujOSluX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C1B812BC; Sun, 30 Mar 2025 18:14:16 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3040C800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 18:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C20F3F181
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743351253;
 bh=zk8MUWJ8XVOseLPq8MQs68+pnDug1EUN/dU4ufNl2Ds=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=VujOSluXL7NH+5sWLhI0Si9YbjSL+fkfVlS4782gn1MU9OxckUsd2J5/yKol0p+9t
 6NPGohe3bIX6xdQAM0RwXdIEMkSGqtOb6bFh6jy5Y5v5egElCIa7cYcNYBrdYe7Sk4
 Mj5/UkA3UQWTXLGbuiGalf8Yf3/YpXwhI+fhHQdY36ZuwuiMBtL3tveJBTq+MogP1a
 tlrzWe2vNgGSuVuXNoH2tsbDLO/Rtnz/VtXGTPqoD7/W7H3F0e0J3W2v60pR9n9wea
 2PnXtLafyXeb640YaKhvax9kWhQYpGgcauhjKpPbW/e2/KLe88mwS7/1XpSTpMUfQ7
 TPVFvzXA8z9Ag==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so21644745e9.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 09:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743351252; x=1743956052;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zk8MUWJ8XVOseLPq8MQs68+pnDug1EUN/dU4ufNl2Ds=;
 b=KMVcaq7yBeHWtxeh7G1wat8ev+ajVCjXtajGNsu7/zFqGprtZaD6KhkHbAw9YmjT1W
 v6IWCIJl8EakQ0Bz/8K0UhulDdyZUk5sY+WLmHMX/V5CACTEsVOspMN0g/eQAXt6Sjoy
 Qfu9IdkkVeD04gAkoFw6wbGVhLe8dJEC/5FbYf1+XCeI7ffCGDjy7M3oT5nbYMxKm4kp
 gANXSggZTwLKgCzmqLf+4u7ifkBZ2zIf/Dphd26US2pqfuMmZtkAdjOf9aAQ1gIAV0iU
 vRdWo7NYr+wdYxB1kxxTyZYmMuIdNHAXMVQt5Z4/Ap4LinbzynGAyB+uzdpeQwhUcmxi
 oF7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/BrTvNnW9E3wbQcQcp4M0PuoesNYlKsdzNFIgM50SX5CNaeO148QJ/qSN0O8CBfdGdaiiQk4=@lists.denx.de
X-Gm-Message-State: AOJu0YyEIyHfyUA+Ym3Dvb+asSZClo3zsUtI9cx7gq6ebfetx+pv+3M0
 Yj0dEKrBypvO4RxWraOURim065E3UdzS33BljczVPHlVP8V32oPUm6bimDdwYyUi7aoYbTFc78j
 T/qDD2cU8cZxUy9PWTdC6cibBBUX7clXilz2756YJ/0hzQ6i/fw3qCTNIrKdluNI4kHg=
X-Gm-Gg: ASbGnctBDcRWT/NtxjG+ZylkzLXPaGhx2hlDng9bkvyboZ7zCphV54jmkcoC1dqZEzC
 hGjJoueEryWogGaq77AMbk/syAj8Pqz96+baspcoQ6QJd+N1QbPeHyeFjZ1Bcs95cv3+3WubZhO
 Y7z4/lA69Hd/jnx575voBOqRIHxioNpidAyi3NtTQV4O5/Bk+BES/qwNO+SY8RDrqYIMyo/6LVh
 H+ikCKutMYg3j9ZAVkrVIDEJXif5JzSQQoTwEia54U4flYrPmQWtbRCEwjuU7/iv+OFN/4ykGT4
 NjVnUY7ZhgWulwdkse6VucnSeMHlYhBKFK/cXtmhFn4LpJcudR8gWPLybgm512hJ2qWPtpFAeeE
 TyuZj0g7UwS3N
X-Received: by 2002:a05:600c:b98:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-43db61d7b53mr64221835e9.2.1743351252271; 
 Sun, 30 Mar 2025 09:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8vJG31jkG0W6iHyiH9Pr2JgCHQnVWaae8jakg+4+Hjq63RXe5EN0uc6Z0G5U/k2PR8gCmuw==
X-Received: by 2002:a05:600c:b98:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-43db61d7b53mr64221595e9.2.1743351251870; 
 Sun, 30 Mar 2025 09:14:11 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663623sm9005732f8f.35.2025.03.30.09.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 09:14:11 -0700 (PDT)
Message-ID: <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
Date: Sun, 30 Mar 2025 18:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com, u-boot@lists.denx.de,
 E Shattow <lucent@gmail.com>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
 <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
Content-Language: en-US
In-Reply-To: <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 30.03.25 17:15, Heinrich Schuchardt wrote:
> On 23.03.25 16:58, Marek Vasut wrote:
>> Use clock-names property which is accessible via parent clock OF node
>> to look up the parent clock by name instead of depending on unreliable
>> global clock name to perform look up.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.
> 
> To dig a bit deeper I enabled the debug UART for SPL with these setting 
> on origin/master (5e74863ad6613df):
> 
> CONFIG_DEBUG_UART=y
> CONFIG_DEBUG_UART_NS16550=y
> CONFIG_DEBUG_UART_BASE=0x10000000
> CONFIG_DEBUG_UART_CLOCK=24000000
> CONFIG_SPL_DEBUG_UART_BASE=0x10000000
> CONFIG_DEBUG_UART_SHIFT=2
> 
> clk_register: failed to get pll0_out device (parent of perh_root)
> clk_register: failed to get pll0_out device (parent of qspi_ref_src)
> clk_register: failed to get pll0_out device (parent of usb_125m)
> clk_register: failed to get pll0_out device (parent of gmac_src)
> clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
> clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
> 
> Marek assumes that property bootph-pre-ram might be missing for some 
> clocks in arch/riscv/dts/jh7110-u-boot.dtsi.

This change suggested by Marek resolves the issue:

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi 
b/arch/riscv/dts/jh7110-u-boot.dtsi
index ce7d9e16961..4ed764393bb 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -113,3 +113,7 @@
  &sys_syscon {
         bootph-pre-ram;
  };
+
+&pllclk {
+       bootph-pre-ram;
+};

Best regards

Heinrich

> 
>> ---
>> Cc: Adam Ford <aford173@gmail.com>
>> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> Cc: Dong Aisheng <aisheng.dong@nxp.com>
>> Cc: Fabio Estevam <festevam@denx.de>
>> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> Cc: Michael Trimarchi <michael@amarulasolutions.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Tim Harvey <tharvey@gateworks.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-imx@nxp.com
>> ---
>> V2: Rebase on u-boot/next with additional clock patches
>> ---
>>   drivers/clk/clk-composite.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
>> index 1191bdf87df..9e3b5191767 100644
>> --- a/drivers/clk/clk-composite.c
>> +++ b/drivers/clk/clk-composite.c
>> @@ -149,7 +149,7 @@ struct clk *clk_register_composite(struct udevice 
>> *dev, const char *name,
>>       clk = &composite->clk;
>>       clk->flags = flags;
>>       ret = clk_register(clk, UBOOT_DM_CLK_COMPOSITE, name,
>> -               parent_names[clk_composite_get_parent(clk)]);
>> +        clk_resolve_parent_clk(dev, 
>> parent_names[clk_composite_get_parent(clk)]));
>>       if (ret) {
>>           clk = ERR_PTR(ret);
>>           goto err;
> 

