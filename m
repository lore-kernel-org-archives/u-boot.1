Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57969E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 01:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3608953C;
	Tue,  3 Dec 2024 02:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CB1YvCmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8458933F; Tue,  3 Dec 2024 02:08:10 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20CF8855C
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 02:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa53a3d7f44so84791666b.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 17:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733188087; x=1733792887; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgyXpnVjAzInyR514FXTshlXhTGNrtxfodBpk7mr5QI=;
 b=CB1YvCmENdk87OX/+lu3JeK1XVT91IT2kA02w3uz+4iwcnonGqbXSzr9IPIjvtegss
 6Fbd8t7DhaLHKBa33f+mQ2Pp/a0hmA5zNUtYw/WtSFcWU8Eljx7ncKxrUuCpq2XCGzSr
 zkmPllbOm85svVUHFDIdWxw2V6mn+0b+JPhmR6keL7opdI8XzGtgxCPDNBJgoBY+FLK2
 uK+9a1GGfHtrc8HYBZZ0jv2kHHOUXT715U0v2eUoNC8u9fadWSft23pFQaXBLsJz9dTD
 Bcntpei1rXpMvFQhau0zjKU0mtdSKkupGcz86P8D9M5wNR8RkxZV7abBtSgrPSa18wi7
 W1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733188087; x=1733792887;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgyXpnVjAzInyR514FXTshlXhTGNrtxfodBpk7mr5QI=;
 b=wzjehStWX/8Q4XREN0muMfWx/RA5EUAJ1NEBI2Y4bMACHP60vnPcJ5rawI7a5OQoXt
 ndRan7Zy9YPcIoVHC4y9Ht1C15lFhg72Y5T7Zv5O+LUfbKK2/AIP5otZDVMg0nQd+tMk
 A520X+NV9Gatn+vsMpEjeh58PQGnqi12wlOsnqBd8kdMD1JdaMVh13QMxfC68HSde6O5
 N8N1ChXe+/ntn24zDHgyAsoOb9naYRv4N/zdwk2VT+czAFm+Lns/Jf+W7zPa6bF/ymzc
 a0LrH2/41HNE5LMxD6I46Z93dHDuytMb2SudrrHP14WAsc5NQSDwhCRGKPmMmDorIsAh
 O8fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4TATB//0qvzfxaGUxR6pKUEF5xqanMo3RQ64lOW7AIVCZPjvX0Gd/XwUxKfnt5l1Rl/GH5kU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9rNC6yO09XxAdYcNyCET8ysRmJtR4yX8lgOo/9byH8mxgGHP8
 NkWEYQgpoalbhJlvPMPW6N8oUM0Kfnb2b4h6xDor6/RGFO+NT5hs3SLOqhnZ
X-Gm-Gg: ASbGncvkCv3UlnZmN9s8dUO4sCpxGpXunDjred988Vke6yejSyxoLH0VE/BE2r2bH2b
 KamTQC0+4xOIIpQd4loLuSQhiHp92KpMnDMbKLKqJuAPHXwKBA3CL6qh64uE7u2/tJRPV555SrY
 XOOxpBvKKWi/D12/MUd/+hgQYuZWUxOAFgWsc7ODKM2iM6UQgutAIIazH6o2Qn44ID4Xj8mrvYO
 ooY/AaFTTyvEZyr9Je+MIWyuaYuF750mADwaQYgQ6zR8WbQUhNWd/GI5nj8HT1uZCWVGsfU4v2U
 pWewPGrutHdNBg==
X-Google-Smtp-Source: AGHT+IHToLbcV/yCydd82bZzNB7wxkEIhA2RKGJfNaCt4FV25664Q3sMGvK25Tc5Ty2Gi3qKPfjBwA==
X-Received: by 2002:a17:906:794a:b0:aa5:b1b9:bb3a with SMTP id
 a640c23a62f3a-aa5f7d4da99mr14235066b.6.1733188086949; 
 Mon, 02 Dec 2024 17:08:06 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996d8b7asm558488366b.48.2024.12.02.17.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 17:08:05 -0800 (PST)
Message-ID: <45e5a3b3-3c6e-41ae-8d01-3f8b70d9b881@gmail.com>
Date: Tue, 3 Dec 2024 02:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: remove redundant Rockchip bindings
To: Jonas Karlman <jonas@kwiboo.se>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <71b804a0-ae2a-472c-84c9-ad7c6317e154@gmail.com>
 <c92b3450-4b98-4bf3-8078-0caf410403d6@kwiboo.se>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <c92b3450-4b98-4bf3-8078-0caf410403d6@kwiboo.se>
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



On 12/2/24 23:54, Jonas Karlman wrote:
> Hi Johan,
> 
> On 2024-11-30 22:18, Johan Jonker wrote:
>> Most Rockchip device tree related bindings are converted to YAML
>> and available in the U-boot /dts/upstream/Bindings/ directory.
>> Remove all redundant U-boot entries.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  .../clock/rockchip,rk3188-cru.txt             |  61 -------
>>  .../clock/rockchip,rk3288-cru.txt             |  61 -------
>>  doc/device-tree-bindings/clock/rockchip.txt   |  77 ---------
>>  .../pinctrl/rockchip,pinctrl.txt              | 157 ------------------
>>  .../thermal/rockchip-thermal.txt              |  68 --------
>>  doc/device-tree-bindings/usb/dwc2.txt         |   4 -
>>  .../video/rockchip-lvds.txt                   |  77 ---------
>>  7 files changed, 505 deletions(-)
>>  delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt
>>  delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
> 

> The rockchip,rk3288-cru.txt file is also removed in:
> 
> rockchip: rk3288: Use rk3288-cru.h from dts/upstream
> https://patchwork.ozlabs.org/project/uboot/patch/20241109210427.884888-4-jonas@kwiboo.se/

I'm neutral here, up to the maintainers.
As long as we get rid of it.
If I'm a little more strict I would say that the commit message/title must match the action.
They always say one action at the time.
So when a title says "Use rk3288-cru.h ..." and something else as well...

Just to let you know I plan to do something similar to rk3066/rk3166.

Johan

===

1:
Could someone add mmc aliases to rk3288.dtsi in mainline and remove the mshc ones?

2:
Could these boards upgrade upstream as well?
http://patchwork.ozlabs.org/project/uboot/patch/20220415212145.2276-14-jbx6244@gmail.com/
http://patchwork.ozlabs.org/project/uboot/patch/20220415212145.2276-13-jbx6244@gmail.com/

> 
> Regards,
> Jonas
> 
>>  delete mode 100644 doc/device-tree-bindings/clock/rockchip.txt
>>  delete mode 100644 doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt
>>  delete mode 100644 doc/device-tree-bindings/thermal/rockchip-thermal.txt
>>  delete mode 100644 doc/device-tree-bindings/video/rockchip-lvds.txt
> 
> [snip]

