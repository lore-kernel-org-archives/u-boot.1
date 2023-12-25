Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5028C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 13:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E418987480;
	Mon, 25 Dec 2023 14:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NEB0NUJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A481B8760D; Mon, 25 Dec 2023 14:11:07 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D598700D
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 14:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2345aaeb05so404319066b.0
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703509865; x=1704114665; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQ5rgkTHAk2Vr08CVnngse/JyY3GvcfBzWebdC668C0=;
 b=NEB0NUJT2jnkbMzPb6I8SdS0Y2s+GUmc+SaTQH5DF56Y3iot967vsCqoW+AZypF0eq
 +KkGZLo2hirLuf0bJx+N5mGcP59IPQ9CKuu+wcesxuNrRM/yt4nSCk3i2u9gY3NINy8m
 6fYCZwG15Ni19bNspodwOlaaCcZvOQd7SPTSOYgLsHelBbOOey/0+mX8S+J/PKOujzWs
 12hzXddgpmq1f5ud3b5mDnqXvQ1w5rvuutz7qn5Ctcu/9nLPSh+tZZWs+5uml/YaVIbm
 xWa3Q11jtmYDRkF7e0lgnNSw/5tUsuvH5uNVS1Objnu3dIrPNcvUBpR4BHHjLVr8qh+t
 jAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703509865; x=1704114665;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YQ5rgkTHAk2Vr08CVnngse/JyY3GvcfBzWebdC668C0=;
 b=qFkOuBzDW4LiKofl58zAv1Ib4UEIp+YCtY62p9Y8KuTnz7q3Xrsb/s44gEuFptqumd
 vH91CZPADD6ZfX6P5R014ezt1Lpla7NaiIoXxa5xopc5kPzfmGznnBGdbwoyE/moTjdZ
 r/9TsAXkYDOqaUk5D9ut6DB99EcfgzjjmBHIR6M0CyOyesTfmvS/0u3rM+R8rmEtBBvB
 c/RdMK+UoJYwzrynl5vQSBZ4WNagyY0oPymemF+rdITYUDRIlUxiuHgt7hrYU7JXTpaj
 T1oa0sgKDjJe8xegpQBXnj8zVpYqFBjJI+TwtiHACRHqqgpyUKMn5yt2VcdQ2q/6MwHS
 MQPA==
X-Gm-Message-State: AOJu0Yye1S8t5qX9L1cieX6IwnKIMtOlL9t5EvER6ILGig1bU1IrcSzj
 PYeZuZOJT4QxJiN5kb1l3iYbu7ELP+ROcA==
X-Google-Smtp-Source: AGHT+IFlU6xAPMSLoVJLV2HE4RMVRyCgArIlB2P03XDeZwT/+LGRvcowrnEWg0K7gvJYIuCY7pxmSg==
X-Received: by 2002:a17:906:95:b0:a26:cdb4:d308 with SMTP id
 21-20020a170906009500b00a26cdb4d308mr1027088ejc.68.1703509864998; 
 Mon, 25 Dec 2023 05:11:04 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
 by smtp.gmail.com with ESMTPSA id
 jt4-20020a170906dfc400b00a2369d8ca07sm4829683ejc.203.2023.12.25.05.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Dec 2023 05:11:04 -0800 (PST)
Message-ID: <7e2f36fa-c201-4c8b-a485-077f65a9a0e1@linaro.org>
Date: Mon, 25 Dec 2023 14:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dt-bindings: nvmem: u-boot, env: add any-name MAC
 cells compatible
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231214153620.23998-1-zajec5@gmail.com>
 <CAPnjgZ31AAauR876W1RmU4JPzKUD8XAMCZrJDumE+Dr4miqABQ@mail.gmail.com>
 <1b4feb5d-f03c-44b3-9474-901534db5eb7@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1b4feb5d-f03c-44b3-9474-901534db5eb7@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 18/12/2023 23:02, Rafał Miłecki wrote:
> On 14.12.2023 22:27, Simon Glass wrote:
>> On Thu, 14 Dec 2023 at 08:36, Rafał Miłecki <zajec5@gmail.com> wrote:
>>>
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> So far we had a property for "ethaddr" NVMEM cell containing base
>>> Ethernet MAC address. The problem is vendors often pick non-standard
>>> names for storing MAC(s) (other than "ethaddr"). A few names were
>>> noticed over years:
>>> 1. "wanaddr" (Edimax, ELECOM, EnGenius, I-O DATA, Sitecom)
>>> 2. "et1macaddr" (ASUS)
>>> 3. "eth1addr" (Buffalo)
>>> 4. "athaddr" (EnGenius)
>>> 5. "baseMAC" (Netgear)
>>> 6. "mac" (Netgear)
>>> 7. "mac_addr" (Moxa)
>>> and more ("HW_LAN_MAC", "HW_WAN_MAC", "INIC_MAC_ADDR", "LAN_MAC_ADDR",
>>> "RADIOADDR0", "RADIOADDR1", "WAN_MAC_ADDR", "lan1_mac_addr", "wanmac",
>>> "wmac1", "wmac2").
>>>
>>> It doesn't make sense to add property for every possible MAC cell name.
>>> Instead allow specifying cells with "mac" compatible.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>> List of devices and their U-Boot MAC variables:
>>> alphanetworks,asl56026) wanmac
>>> asus,rt-ac65p) et1macaddr
>>> asus,rt-ac85p) et1macaddr
>>> belkin,f9k1109v1) HW_WAN_MAC + HW_LAN_MAC
>>> buffalo,ls220de) eth1addr
>>> buffalo,ls421de) eth1addr
>>> checkpoint,l-50) lan1_mac_addr
>>> dovado,tiny-ac) INIC_MAC_ADDR
>>> dovado,tiny-ac) LAN_MAC_ADDR + WAN_MAC_ADDR
>>> edimax,ra21s) wanaddr
>>> edimax,rg21s) wanaddr
>>> elecom,wrc-2533ghbk-i) wanaddr
>>> elecom,wrc-2533ghbk2-t) wanaddr
>>> engenius,ecb1200) athaddr
>>> engenius,ecb1750) athaddr
>>> engenius,epg5000) wanaddr
>>> engenius,epg600) wanaddr
>>> engenius,esr1200) wanaddr
>>> engenius,esr1750) wanaddr
>>> engenius,esr600) wanaddr
>>> engenius,esr600h) wanaddr
>>> engenius,esr900) wanaddr
>>> enterasys,ws-ap3705i) RADIOADDR0 + RADIOADDR1
>>> iodata,wn-ac1167dgr) wanaddr
>>> iodata,wn-ac1167gr) wanaddr
>>> iodata,wn-ac1600dgr) wanaddr
>>> iodata,wn-ac1600dgr2) wanaddr
>>> iodata,wn-ac733gr3) wanaddr
>>> iodata,wn-ag300dgr) wanaddr
>>> iodata,wnpr2600g) wanaddr
>>> moxa,awk-1137c) mac_addr
>>> netgear,wax220) mac
>>> netgear,wndap620) baseMAC
>>> netgear,wndap660) baseMAC
>>> ocedo,panda) wmac1 + wmac2
>>> sitecom,wlr-7100) wanaddr
>>> sitecom,wlr-8100) wanaddr
>>>
>>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 33 +++++++++++++++++++
>>>   1 file changed, 33 insertions(+)
>>>
>>
>> Are these upstream U-Boots, or just vendor forks?
> 
> I guess most of those devices don't have upstream U-Boot support. Please

We do not document properties used in all possible projects, like vendor
forks. Only upstream U-Boot matters.

> note that while upstreaming vendors changes would be great in most cases
> it doesn't happen. Most vendors sadly don't care and most end users
> don't have enough time for that. In practice we often stick with vendor
> provided bootloader to flash and boot self build Linux system (like
> OpenWrt).
> 
> I'm not sure if/how does it help with this PATCH but please note that
> upstream U-Boot code also supports few extra variables.
> 
> There is generic eth_env_get_enetaddr_by_index() that supports variables
> like "<%s><%d>addr" and "<%s>addr". Right now it's used only for
> "eth<%d>addr" and "ethaddr" so that mostly limits us to "ethaddr",
> "eth1addr", "eth2addr" and "eth3addr".
> 
>  From some rare cases: there are also "usbnet_devaddr" and "wolpassword".
> 
> So given that U-Boot oficially supports at least 6 env variables for
> MAC and there are many used with custom U-Boots and firmwares this
> binding would help a lot.

Please limit this to upstream U-Boot. Drop all custom and firmware ones.

Then, just fix upstream U-Boot to have only one property...

Best regards,
Krzysztof

