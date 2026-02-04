Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB7E8B383
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 01:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A38F802C1;
	Wed,  4 Feb 2026 02:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z4lNu1xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B64839A5; Wed,  4 Feb 2026 02:27:05 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BF6800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 02:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D5DEA3F5A1
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770168422;
 bh=Hv/ZAQ7EakYAcHL1cJUtjBiCik/Ho8Vcu+U8I2NTt+Y=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Z4lNu1xXZDQGb2RnluthjufnJGZ3v0BjIZhnp7jgoc2eGeXo7o3Xj7jvAijN7ROVn
 iIyM4szK+eLiaQXN/omab/NBLYXuo/ZJYucx+KJhP/ac/ZpSmOVBADnbN2K+q9UxJR
 uE77I6mMPi4KnTAR4M3dAfTF+t0629YchBIZAGReh6O905017LjaRvsWD9qvYInb5v
 xqiKTol/PUkLNMEZWaUauG0X/sC2yplZejH/5XVQnFUwF0UEn5TvVFmuPiqPiyDDXq
 aoxGP+DgKkMkblDF+vymBBzZJZdDnMtp+rkh/yjyMnUbmMqvvbHLBi2VhwC0Efkelm
 iKcwhYkXU5ZcMSS8LywJozhH6+adgI51XY3yuHq8xK+ob2sL/XIadZdk9wqs4zN3zs
 EvqtAd3n0xE9blkfjnItjctNr8l4x/juKyGNtQI4WBX8u/7Vww7ylPAN725SW9p7Y8
 PkzHb0lhHBqdf9Pb8fKZXRJBP8dFQMkElu+ieA24gfafFJr36JSjUM6R+7kLlxsUu7
 8HXDJv7gglwoVupvnrixo5rG+6aSdiY1CUJXA2UHiy0bEXZWkYDUiqpUYRHeO3QdxX
 /r+ctx6RZ6lvOjPg3oLepqpUVYMNeS/d2vmdibKsx6PykAaoPqQVB0fEnoum/SMcpV
 nwddmXz5MypiOeQwnA83u6I0=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48025e12b5bso78568825e9.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 17:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770168422; x=1770773222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hv/ZAQ7EakYAcHL1cJUtjBiCik/Ho8Vcu+U8I2NTt+Y=;
 b=Hjijh0NC6RGV9EA9/8VuDzAldSl2lsXJOw6mEpTieV4f1GQNLQ+aBvLPrdMMntk+E+
 LLtiXMT7Lf7Q4Gu01lo/bkgpWcMoaY6N2aykJQOeEw84LDg/TPFnxucG5vpyoc4YdLpf
 RJ6j6pRj5RQwJMXAngd3PLODMIO1EfrcPAmvVS3ZaDBlr6xOkCshyxfaVSbjvGJBMFGU
 +gJGk2XPEWL8R6dabdLIPWaHa4yIovcem6ueQXpQmCQU6ea2xVlkvkk2k1FG5jlPPJ94
 kp639+2LbtQyGKoWQ+pY/CnYKiDTDMNOqeTgveQqBnk97JVSfi0RGb2dBDtJTBr5sjjb
 zjWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYiDBRLZ3uGjGJDI0wI+tyCUTBuro0m8kUkEnhX9yHc52RA2B+jJ9wVrVXRu7GOEjZUu20Wzk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1ljwdkVgVytJmCRliHNCgZrs/4RN+ego9WDhor/7r9RIkI/XI
 lwjJPoypt2vUG6UdJbak1nYlisnHrgYDcimRIxl4E6BtnBAi+6MVkgqKRI0UbDwbg5pZBDPn47b
 Qs9oLognaOLI5xLuTpReB3sSFqhGuwawSryiEiMa38XqU40QTpUmbGF0hulaKgdSK4M5r528=
X-Gm-Gg: AZuq6aKXlVY2hSENmitdELcUNYgvwlJZloh/hEHhpjMemNPoNsPBMjd0zq9BOfsRcvj
 T+jJMZ5ypwhiMO+tRXeStusSmeZmMFOpJiDtZfDNV5Jm0hgGeY3ccu5x2bs0yqP9vehxTgG4Oda
 3Ud8dwm31t6CpgJrV4mFjp1NFQhYtGxiqttuIYyFBXa/4pjYc36FVI5QasOy7wlW4pxQOu+nLwb
 ZXohXY07qEC3VARz4q6JSgGfD99WIiyQvm3dtMbJGT7l1DT9rdRPp+b5nLplj6W9JCwMxrHG8r1
 B63S+jGqoQxg0ejQ1vBnLMzckFDZ+wiLrUw76KV7xHxdF6sypNzTEtPpp0r5sGGRzRXVtvK0xEq
 V59dVbLYkDgQb243pFzwS3jaNAb44Jf1GNBrXar5ar7pLPTOF7Zh4AjsdCPtS7OJXDSOD5q09mV
 i0Lg==
X-Received: by 2002:a05:600c:3542:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-4830e8d0d8fmr20470285e9.0.1770168422415; 
 Tue, 03 Feb 2026 17:27:02 -0800 (PST)
X-Received: by 2002:a05:600c:3542:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-4830e8d0d8fmr20470075e9.0.1770168421969; 
 Tue, 03 Feb 2026 17:27:01 -0800 (PST)
Received: from ?IPV6:2a02:3033:68e:ac1a:a48b:f69d:aaae:5c64?
 ([2a02:3033:68e:ac1a:a48b:f69d:aaae:5c64])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483109278adsm6090505e9.13.2026.02.03.17.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:27:01 -0800 (PST)
Message-ID: <7364338c-1a72-43ce-806f-5e413bf72c1d@canonical.com>
Date: Wed, 4 Feb 2026 02:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
To: E Shattow <e@freeshell.de>
Cc: Marek Vasut <marex@denx.de>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
 <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
 <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
 <CAFLszTh7-9a7F9h+knc1CMNvm8C=gXLZhLZ+W5eJDEZ_e5pc2A@mail.gmail.com>
 <cb4bdf54-35cd-4638-8ce0-3fa9c0b5260d@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <cb4bdf54-35cd-4638-8ce0-3fa9c0b5260d@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/27/26 05:36, E Shattow wrote:
> Hi Simon,
> 
> On 1/26/26 18:55, Simon Glass wrote:
>> Hi Heinrich,
>>
>> On Mon, 31 Mar 2025 at 05:14, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> On 30.03.25 17:15, Heinrich Schuchardt wrote:
>>>> On 23.03.25 16:58, Marek Vasut wrote:
>>>>> Use clock-names property which is accessible via parent clock OF node
>>>>> to look up the parent clock by name instead of depending on unreliable
>>>>> global clock name to perform look up.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>
>>>> This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.
>>>>
>>>> To dig a bit deeper I enabled the debug UART for SPL with these setting
>>>> on origin/master (5e74863ad6613df):
>>>>
>>>> CONFIG_DEBUG_UART=y
>>>> CONFIG_DEBUG_UART_NS16550=y
>>>> CONFIG_DEBUG_UART_BASE=0x10000000
>>>> CONFIG_DEBUG_UART_CLOCK=24000000
>>>> CONFIG_SPL_DEBUG_UART_BASE=0x10000000
>>>> CONFIG_DEBUG_UART_SHIFT=2
>>>>
>>>> clk_register: failed to get pll0_out device (parent of perh_root)
>>>> clk_register: failed to get pll0_out device (parent of qspi_ref_src)
>>>> clk_register: failed to get pll0_out device (parent of usb_125m)
>>>> clk_register: failed to get pll0_out device (parent of gmac_src)
>>>> clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
>>>> clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
>>>>
>>>> Marek assumes that property bootph-pre-ram might be missing for some
>>>> clocks in arch/riscv/dts/jh7110-u-boot.dtsi.
>>>
>>> This change suggested by Marek resolves the issue:
>>>
>>> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi
>>> b/arch/riscv/dts/jh7110-u-boot.dtsi
>>> index ce7d9e16961..4ed764393bb 100644
>>> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
>>> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
>>> @@ -113,3 +113,7 @@
>>>    &sys_syscon {
>>>           bootph-pre-ram;
>>>    };
>>> +
>>> +&pllclk {
>>> +       bootph-pre-ram;
>>> +};
>>
>> I just hit this as well, thanks for the post.
>>
>> However, -master still does not boot for me on vf2:
>>
>> U-Boot SPL 2026.04-rc1 (Jan 26 2026 - 19:52:48 -0700)
>> DDR version: dc2e84f0.
>> Trying to boot from MMC2
>> spl: partition error
>> Error: -38
>> SPL: Unsupported Boot Device!
>> SPL: failed to boot from all boot devices
>> ### ERROR ### Please RESET the board ###
>>
>> Regards,
>> Simon
> 
> Is this to be expected? ref:
> https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#zero-stage-bootloader
> 
> The JH-7110 has enough SRAM to contain the unfiltered devicetree if you
> would like to experiment without filtering to reduce size for the SPL.
> 
> Meanwhile though the uses of "sd card image" for U-Boot SPL to access
> MMC are not anymore supported; transition to instead use the remaining
> supported methods SPI Flash or UART Serial.
> 
> -E

The JH7110 boot ROM did not change. Why would anybody remove the SD-card 
support from SPL while distros are still using it for preinstalled images?

Best regards

Heinrich

