Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA7BF4612A
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351168408D;
	Mon, 23 Mar 2026 15:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cfr14jfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044B984132; Mon, 23 Mar 2026 15:25:46 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D29583DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1872504cbso3893426a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774275942; x=1774880742;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c1/RqIsUlDiuzdJ9gnssBgtNCVAW3AaaY+xm0GPAO08=;
 b=cfr14jfjjQTw15lDiWSQ3YJWHwmwPsh34R6I5XL3c0sy1KDhepA/S700pXp+mYzwTc
 8wb3Z7C0/RrW4BhZYKyrswfb5jlWdL+rLVniTjIpMXL9HQMrl4yUdy56FX0movV7vNdP
 Wamzj5VMTXyHm2rgGVmZzDH78SNLF8/EJZl55O3lPk0M8DP6cJeO2DaQdAxa2wDwtCHT
 XM0BJVNvy7gt6cLaOj0zu9wK4a0X3LZBPJZQr9ESRuTsQ9m8ZuOuIaYlN0+xXy3pE6EK
 Jp0WYxPzVuuFf3NfOx8q09UaR49iXvKchsgA8Erf5GiZEY7XJecqxv89TUGwhPsdW4uT
 y8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774275942; x=1774880742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1/RqIsUlDiuzdJ9gnssBgtNCVAW3AaaY+xm0GPAO08=;
 b=F5ReVwja0AU7ZdUE+KABn0C19psQeoquxueQ4Qdb5fEspuuVV7sbCmuzjQWRcon0bG
 8M1znJftUJIcld/rkZ4hIFkvYKHHZXkJAV9iOUw2O13oBwJZ7bODlQg5Vc0cS/x56LNc
 85qy4fXsxvOAzVrbP1rcNNdtpz/A7vgS4VtfigK2NkFD0/q64aGFk0z1VZWLTnQohxzN
 d4nc4EANS5pYsNFcU1bxh07nxptjQ4lYiC8j6Z41dKWV8Vjr4+9IynAOaFtYqkxOe4RQ
 ArNQ4+KaM1tsEHkb9mk5PPaBXiPAIykpUBBBUVMtEASawSiafOqsOHAoBqq1+pCgUdnf
 dMpA==
X-Gm-Message-State: AOJu0YxlgE+kr3ubrPez6iTLdO0dEySu42x7IxCePsBOY3NY1T7iJfpU
 iSR7vsGfcxZgog3ImHlmoPU+WQcLvZDVfgrdXpUTSYFsb6D68zcFRve6uM1RqpYOFQQ=
X-Gm-Gg: ATEYQzxCo2KoRFyqBcM3em2BQ/4Zbag5otJSjH3ZX3fW6p3HaQsg8cfJvYgUnDdfpl1
 jQMr3pY95Z1PgzaGIyK+r2QtRjBzc3PTumrwS9Mllv0So9e0wCGsvkElP1onb0Ur5nQQvp3vj1y
 l0fYXCLWRzI/d7MrmQOOJsJVHod8Yzn2o66E6gtODGISczKYjRo/jCRGCFEfiubMbfgstCupSQX
 K6aGfYezJ0LxHbFKbIlh5EhGgbX+foilVhe6XoJs5VuHAdz6pgZc8TrheB1+3UowtkWGgTlc1m8
 TyVgUJeFQoCagY/thIVV2qXGtO9yITTWtjXqWxKyyHDjCpfKqpHyJPJZNiDbULSlBSuWJrpXyRN
 Xk4YXOKNEcnDq3m3MNWve047reXEv7HhbYwDm/KInuk68nw9SygKF9T3pn5JZjDNZPozDogxirX
 nSIkfrsQtOrmCznT5QVlMkkVvUvUisPcr1nBzbOsFsEPBbxrN7WEDoKnXpZHjBu08R9XUp8zM=
X-Received: by 2002:a05:6830:2713:b0:7d7:f73d:bd7f with SMTP id
 46e09a7af769-7d7f73dbde9mr6902204a34.5.1774275941966; 
 Mon, 23 Mar 2026 07:25:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:964:f712:dbc7:4119?
 ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7fbee2c6dsm7101946a34.1.2026.03.23.07.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 07:25:41 -0700 (PDT)
Message-ID: <48da89e0-279a-403a-b96f-ed27f6157fc8@baylibre.com>
Date: Mon, 23 Mar 2026 09:25:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] configs: mediatek: rename genio boards defconfigs
 to match the device tree name
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
 <9060e287-9b77-4051-b378-c68ddba4fa65@baylibre.com>
 <CAEHHSvaFcOzyz1-WkunbYELGOwP11w0z9ZtNOLTGFm5G9qRCHg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvaFcOzyz1-WkunbYELGOwP11w0z9ZtNOLTGFm5G9qRCHg@mail.gmail.com>
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

On 3/23/26 3:36 AM, Julien Stephan wrote:
> Le ven. 20 mars 2026 à 22:33, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> On 3/18/26 11:45 AM, Julien Stephan wrote:
>>> Rename the defconfig file for various genio board to match the name of
>>> the device tree. While at it, do some cleanup:
>>> - introduce mt8188.config to factor genio-510/genio-700
>>> - remove useless SYS_BOARD_CONFIG for genio-700
>>> - set myself as maintainer
>>>
>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>> ---
>>> Changes in v2:
>>> - Split the initial commit into several commits as requested by Mattijs
>>> - Link to v1: https://lore.kernel.org/r/20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com
>>>
>>> ---
>>> Julien Stephan (6):
>>>       configs: mt8390_evk: remove useless CONFIG_SYS_BOARD
>>>       configs: mt8395_evk: rename to mt8395_genio_1200_evk_defconfig
>>>       configs: mt8370_evk: rename to mt8370_genio_510_evk_defconfig
>>>       configs: mt8390_evk: rename to mt8390_genio_700_evk_defconfig
>>>       configs: mt8370/mt8390: introduce mt8188.config to avoid duplication
>>>       configs: mt8370/mt8390/mt8395 add myself as maintainer
>>>
>>>  board/mediatek/MAINTAINERS                         | 18 +++++++-------
>>>  configs/{mt8390_evk_defconfig => mt8188.config}    |  3 ---
>>>  configs/mt8370_evk_defconfig                       | 28 ----------------------
>>>  configs/mt8370_genio_510_evk_defconfig             |  5 ++++
>>>  configs/mt8390_genio_700_evk_defconfig             |  4 ++++
>>>  ...k_defconfig => mt8395_genio_1200_evk_defconfig} |  2 +-
>>
>> How about also including _emmc_ in the name, like:
>>
>>         mt8370_genio_510_evk_emmc_defconfig.
>>
>> Since we will be adding a _ufs_ variant for all of these, similar to [1],
>> then it will be more obvious which one you should pick when booting from
>> eMMC vs UFS.
> 
> But then the name of the defconfig will not match the device tree name
> anymore .. which was the point of this series.

Ah right, I wasn't thinking about that.

> Personally, both are fine for me, so I can update to use _emmc_ if
> this is a strong requirements for you. Let me know.

Both seem equally valid to me, so we can just leave it as-is.

> 
> 
>>
>> [1]: https://lore.kernel.org/u-boot/20260318-mt8195-add-ufs-support-v2-9-f18eeeeb0e72@baylibre.com/
>>
>>
>>
>>>  6 files changed, 18 insertions(+), 42 deletions(-)
>>> ---
>>> base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
>>> change-id: 20260318-rename-genio-defconfigs-bc4070c90e9e
>>>
>>> Best regards,
>>

