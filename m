Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B7D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8978883FD6;
	Wed, 26 Nov 2025 15:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S9gfKePl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E4783FFE; Wed, 26 Nov 2025 15:22:56 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2084383F2E
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7277324204so1153995166b.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764166973; x=1764771773; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJye3kKzmNrgNXyutgbWd2rH8q8FOZJv0bT8znHz3Tk=;
 b=S9gfKePl8s+ruRMnlAbrnSzyKkfWV32fBjcz9MTS0jfiJc2375jVPlWtUfRDBJoqWE
 bzZTuOs0BqeoMAA/kZCwk+omzbbkb54inWC0sRCaSx15iaB3hCxpJrxG20KL6oEa+I3j
 lIvrOTPUsCdfMeWs7CC8IOhR4NdR5UMXy41J/bU9aOuvtLTIHQ6iHu8AtqvHfJHeKK7K
 13/rrBUJpjg++8O84sxQ+znZh+OEF4cnYDqb9lFpUBk/o3lqMb6fOweTZ3mtK2lTdKPa
 TA+GKw+stMpRK0bov9ZsRsFR4fkT+4hmIXWUHQ/DwKQzAP4ll5WAHnbNGhhPZXEFL/hL
 MARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764166973; x=1764771773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJye3kKzmNrgNXyutgbWd2rH8q8FOZJv0bT8znHz3Tk=;
 b=XSq7qdl+zu+L0Ln6PVH9kNfinrBSCpfPWuzgvTRqAPXnMIFCdVJ3QOngj18B0p8V7d
 a8yD05rgS8MvvDsFC7N3aF7xV2XFZsX3ucl+Y3RTaEzfclKdhN+KinRrLBxOrm1w7ujc
 buGwaXwJtsHN6HD1ptspo4hsjcVge9KFazKLDizk7q/g3or/rPF8KOAcHrA+RjqGlV7B
 7UXrqf8MuJ9FQVADCTlTEFa6e0aGXD/KspeXJWEXMaX9s7oRPWPdazegPrDZcpfdcRam
 VpkNqilJXekv0mUE5vEHir+tPmrG1XghFC8KTSNpxqLyvn0fUBStfFDXko2gZ6FPxNxd
 MB7A==
X-Gm-Message-State: AOJu0YysLHHRfy8ZJZcSaOLxq/kl3GNodSHNvYwzYRScgcqydbk6YFi3
 9y3CFH1uL5eiGtmop9BzuXppHw2A10CjR6q3EwoDYRROgFKM28VJGUyrp2akZ0JqlVQ=
X-Gm-Gg: ASbGncun52M8WSEHXiF2lo893rm+vprEW9fPCbwYkFLxbeck7pxY9S/FCRTqbSiXWcB
 xECAGAkincKpjVxSOWq9XJrWJmpVrdvSUdc7C4ZN9UMzQJMTq7DA9Wy+SjA3/2qPyp+1tOq5+zi
 nMJpxbFNhKXcEJxVdR2HIDqyZDPWFXyL1eQl0hsbn19BihLJCcRl+NL7kCKxGoecSFF+i/Zginx
 Xe0MV4LJMj4IVbbQtlAWsOAFIMcz4YRcNrDHgIPctdLgKJwkHA8ZRBHpZqLhf67yRwZvE9Gtbu+
 bapU10ciAEX4eZ7Kog23wAyn6x3AjKVl0xRsXP+/AODuZX1pnzeoccns63oQbJo+EMYXhTobZB6
 88x8nii3m+6UBU4baaMJWYjjWDZg+bGo+UgxVhjJcPMf51LRj/on6A8fJ6PlocZm4xV/oGqDVsX
 EyywolLt6XlLwIKKt0rCDAZthzevhgvlS4MKLjnNILxo8g0WffwgFLBWNd93R9nFajZA==
X-Google-Smtp-Source: AGHT+IFfVkMvCTChI19UW2Xj3re8rRFIdBur2N/faob96OAktfwugcRWFuc0FG5ud5qDu7+r+1hG8A==
X-Received: by 2002:a17:907:9117:b0:b76:ece3:510a with SMTP id
 a640c23a62f3a-b76ece351cfmr23179166b.21.1764166973506; 
 Wed, 26 Nov 2025 06:22:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:74cf:cf99:df2c:2480?
 ([2a01:e0a:3cb:7bb0:74cf:cf99:df2c:2480])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654fd4e6bsm1861184566b.34.2025.11.26.06.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 06:22:52 -0800 (PST)
Message-ID: <59b26617-ea1d-4a65-a474-de16399f8205@linaro.org>
Date: Wed, 26 Nov 2025 15:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware
 loader
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Zi Yao <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
References: <20251101123401.110681-1-root@infi.wang>
 <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
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

Hi Yun,

On 11/15/25 08:48, Beiyan Yun wrote:
> Hi all,
> 
> Gentle ping. Any comments on this patch?

Since there is no comment I will pick it up and move it to my net-next queue.
Thanks!

-- 
Jerome

> 
> Thanks,
> Yun
> 
>> Beiyan Yun <root@infi.wang>於2025年11月1日 下午8:34寫道：
>>
>> ﻿
>> Hi,
>>
>> This patch series refactors the Aquantia PHY firmware loader to use
>> the generic fwloader framework.
>>
>> The existing loader is limited to loading firmware from an MMC device,
>> which restricts its use on many devices (e.g., routers) that may use
>> other storage like USB or have a UBIFS root filesystem. Migrating to the
>> generic firmware loader allows firmware to be sourced from any backend
>> supported by the fwloader scripting framework.
>>
>> The series is structured as follows:
>> - The first patch prepares current loading code for fwloader.
>> - The second and main patch replaces the custom loader with generic one.
>>
>> This change has been tested on a Buffalo WXR18000BE10P router, loading
>> firmware from a UBIFS volume for Marvell CUX3410.
>>
>> Changes in v5:
>> - Remove fsloader codepath
>> - Drop binding changes
>> - Make script name static
>> - Minor refactor
>>
>> Changes in v4:
>> - Split firmware upload helpers change
>> - Reorder `aquantia_read_fw`
>> - Make `aquantia_read_fw` weak to allow overide
>> - Rename exit label in `aquantia_read_fw`
>> - Kconfig polish
>>
>> Changes in v3:
>> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>>
>> Changes in v2:
>> - Add support for script based loader
>>
>> Beiyan Yun (2):
>>  net: phy: aquantia: refactor firmware upload helpers
>>  net: phy: aquantia: use generic firmware loader
>>
>> drivers/net/phy/Kconfig    |  23 ++++-----
>> drivers/net/phy/aquantia.c | 103 +++++++++++++++++--------------------
>> 2 files changed, 59 insertions(+), 67 deletions(-)
>>
>> --
>> 2.47.3
>>
>> base-commit: 62b45e82bdbf703571450e97f605893fe0d50530
>> branch: aquantia-fsloader-v5
