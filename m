Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6281C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567C6871B1;
	Mon, 18 Dec 2023 23:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxfUU9+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7825871CC; Mon, 18 Dec 2023 23:02:27 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D460F870AB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2331caab22so279154466b.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702936945; x=1703541745; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j78u/AxbFW/PvB7ob0xH35r+RLxqVn7NFYykJEfCNm4=;
 b=RxfUU9+ImzPuaVTQeOAh3R18f6ZkoazKTB5t/NEr1ZPaysIn5b3PJAd4QQ9U11rcPm
 4jXGjFo4sl9rVuCz/zZD9Yg42LU1oondhz8IgBx514oQl/Bo+JkpOZLvcubu2w+oRZ4y
 VwgQ5jX4DhjOlxx7jaU9jrQWff+SF3qe8tR8urRMfUv/qW6QN8vKU86Paeeocv9ETGOE
 vgOntGPFShwM6acYLsCPyDTgQ/fEg9qWvbp+TdzypU/X2sthiDzDDyf4ccdZGOonnmmO
 CWJSPfJVXLdVpN1sFKbUcQzeVZ3FVODPJdSk7B9jAvug+GhQpH3PKXpDwTT6Fwkq3KUZ
 QXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702936945; x=1703541745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j78u/AxbFW/PvB7ob0xH35r+RLxqVn7NFYykJEfCNm4=;
 b=ooA+h432Ow49zsih2T8vVRtKiv+u/Jot0ZnYRk5BQ+UmZxAV295l7dxlZs32Jglj2C
 OhMTqkBL+TME1BLtgln2mOr/xV7N2eMnrNeSNK6O9ESOgSV2bUIvOvD9VrChkxa/aLak
 8BJfDv0+ft6t3D07bzoGBXvVMq6VKrIt3GGOsNvU5ry0G8ehyxNbc2zURckxTTLO0nyG
 ImBvoH32ZYmafiWw9d2JcXdLhTPPgWA3lnG0ZnEd2f3x46u5brm+pHTYk1goJOV/CnHW
 rK7ctRTqxN7kI7SPj5bUfTTqiq2rUXgtD5x2FfP2ErzjtKpePHqnWKzDggH9Oc8T4P5V
 6RAg==
X-Gm-Message-State: AOJu0YyM0kvNP78NSArIOgkT138czkDqbacP/gPC3vKfURR+3LXBhPj+
 hFv/SqrSWqLJ+aFTVNBwR2I=
X-Google-Smtp-Source: AGHT+IEPZqXlfacA0u2n1vljM6X29jA54J6/WAEvQI9gh7KtlZMgF3FICfR713o6WiYGui2vKNrWNQ==
X-Received: by 2002:a17:906:7386:b0:a14:b151:72e6 with SMTP id
 f6-20020a170906738600b00a14b15172e6mr7515981ejl.21.1702936945048; 
 Mon, 18 Dec 2023 14:02:25 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.googlemail.com with ESMTPSA id
 tg10-20020a1709078dca00b00a178b965899sm14647993ejc.100.2023.12.18.14.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 14:02:24 -0800 (PST)
Message-ID: <1b4feb5d-f03c-44b3-9474-901534db5eb7@gmail.com>
Date: Mon, 18 Dec 2023 23:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dt-bindings: nvmem: u-boot, env: add any-name MAC
 cells compatible
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231214153620.23998-1-zajec5@gmail.com>
 <CAPnjgZ31AAauR876W1RmU4JPzKUD8XAMCZrJDumE+Dr4miqABQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAPnjgZ31AAauR876W1RmU4JPzKUD8XAMCZrJDumE+Dr4miqABQ@mail.gmail.com>
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

On 14.12.2023 22:27, Simon Glass wrote:
> On Thu, 14 Dec 2023 at 08:36, Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> So far we had a property for "ethaddr" NVMEM cell containing base
>> Ethernet MAC address. The problem is vendors often pick non-standard
>> names for storing MAC(s) (other than "ethaddr"). A few names were
>> noticed over years:
>> 1. "wanaddr" (Edimax, ELECOM, EnGenius, I-O DATA, Sitecom)
>> 2. "et1macaddr" (ASUS)
>> 3. "eth1addr" (Buffalo)
>> 4. "athaddr" (EnGenius)
>> 5. "baseMAC" (Netgear)
>> 6. "mac" (Netgear)
>> 7. "mac_addr" (Moxa)
>> and more ("HW_LAN_MAC", "HW_WAN_MAC", "INIC_MAC_ADDR", "LAN_MAC_ADDR",
>> "RADIOADDR0", "RADIOADDR1", "WAN_MAC_ADDR", "lan1_mac_addr", "wanmac",
>> "wmac1", "wmac2").
>>
>> It doesn't make sense to add property for every possible MAC cell name.
>> Instead allow specifying cells with "mac" compatible.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> List of devices and their U-Boot MAC variables:
>> alphanetworks,asl56026) wanmac
>> asus,rt-ac65p) et1macaddr
>> asus,rt-ac85p) et1macaddr
>> belkin,f9k1109v1) HW_WAN_MAC + HW_LAN_MAC
>> buffalo,ls220de) eth1addr
>> buffalo,ls421de) eth1addr
>> checkpoint,l-50) lan1_mac_addr
>> dovado,tiny-ac) INIC_MAC_ADDR
>> dovado,tiny-ac) LAN_MAC_ADDR + WAN_MAC_ADDR
>> edimax,ra21s) wanaddr
>> edimax,rg21s) wanaddr
>> elecom,wrc-2533ghbk-i) wanaddr
>> elecom,wrc-2533ghbk2-t) wanaddr
>> engenius,ecb1200) athaddr
>> engenius,ecb1750) athaddr
>> engenius,epg5000) wanaddr
>> engenius,epg600) wanaddr
>> engenius,esr1200) wanaddr
>> engenius,esr1750) wanaddr
>> engenius,esr600) wanaddr
>> engenius,esr600h) wanaddr
>> engenius,esr900) wanaddr
>> enterasys,ws-ap3705i) RADIOADDR0 + RADIOADDR1
>> iodata,wn-ac1167dgr) wanaddr
>> iodata,wn-ac1167gr) wanaddr
>> iodata,wn-ac1600dgr) wanaddr
>> iodata,wn-ac1600dgr2) wanaddr
>> iodata,wn-ac733gr3) wanaddr
>> iodata,wn-ag300dgr) wanaddr
>> iodata,wnpr2600g) wanaddr
>> moxa,awk-1137c) mac_addr
>> netgear,wax220) mac
>> netgear,wndap620) baseMAC
>> netgear,wndap660) baseMAC
>> ocedo,panda) wmac1 + wmac2
>> sitecom,wlr-7100) wanaddr
>> sitecom,wlr-8100) wanaddr
>>
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 33 +++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
> 
> Are these upstream U-Boots, or just vendor forks?

I guess most of those devices don't have upstream U-Boot support. Please
note that while upstreaming vendors changes would be great in most cases
it doesn't happen. Most vendors sadly don't care and most end users
don't have enough time for that. In practice we often stick with vendor
provided bootloader to flash and boot self build Linux system (like
OpenWrt).

I'm not sure if/how does it help with this PATCH but please note that
upstream U-Boot code also supports few extra variables.

There is generic eth_env_get_enetaddr_by_index() that supports variables
like "<%s><%d>addr" and "<%s>addr". Right now it's used only for
"eth<%d>addr" and "ethaddr" so that mostly limits us to "ethaddr",
"eth1addr", "eth2addr" and "eth3addr".

 From some rare cases: there are also "usbnet_devaddr" and "wolpassword".

So given that U-Boot oficially supports at least 6 env variables for
MAC and there are many used with custom U-Boots and firmwares this
binding would help a lot.
