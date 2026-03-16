Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948D4F506D5
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 14:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A188407E;
	Mon, 16 Mar 2026 15:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N0wlq6Pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396C08407F; Mon, 16 Mar 2026 15:34:19 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F207284073
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 15:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d7b8461c32so215837a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773671655; x=1774276455;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qESSFsNvXZWXvSEtdaRm19zSytJWl2FQLSfukIH+YB0=;
 b=N0wlq6PiKSQAAzZ2H1+KFXSWhurJhJMdnl8Edyp00Lx+nO2QonjvXNqXqoKCEEnojX
 +D/2mKi10swQl2fJXm6QskeYrKU1T+PMcJ/mvex6X+6i/019MNAjlmnZRCvUggDO8a6P
 EdmcIiwx4wy2ibFquPcO9dv94n2VhWHszDrdinW/lq7H//wb5XbM/mFOwL+r8zjXrWXO
 cbFe/hj6Vm9talKJuFtsUuv1Az/SkwY4Lo8N1fWjz0zzJsIRAATsTmD1JjNl0gqVSiXE
 BXLTUEqGh06WfEX6khGrKs/hFdK4W+PgDqZGJWVzMDjh0Qt769gCzBjcS64P24tUglqR
 1gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671655; x=1774276455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qESSFsNvXZWXvSEtdaRm19zSytJWl2FQLSfukIH+YB0=;
 b=rqcZ4T7vhJvVk6V6gxl78M1xAVtelHnvYjiG7/Voa1cFlIUKMJcWfSse3J5W+0Vjr+
 iDY6Ze3X/FEJ7Wwh7XgqnU314veTziJHraMqgocsGXDHDYuWebu9RFxhZFFMQgPh9xre
 TPuaW3sZ3CtkamaGB1cbb9zjF4yEuT7EHerDytrZUw2mQdTzOfm5eGW68/kcegFhF8MB
 ndbwbhEH1886jydFUBBYR3Vy9M0RAgeOnfNsx3xmP1qaoRz4wxvJEn6sJVH92lP6abBU
 ktScaZPIDyX1BQUrMhTNv3lpaujTfuHz0YZspAn5pFY9sF3rzQDyQt8JT7u+5R+oYIhk
 4L4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnRVLu+9j1KeQWmRnu8W/xayDnupSqEB4PI68cZ0QarhiCyqcbStw2A85T2UKKRUYFj0ifI+c=@lists.denx.de
X-Gm-Message-State: AOJu0YxdbdGBSyLUMMcEfP7IO4sIN3fg6KWMZZayD1siBo00VlpMUn5i
 2pHslOk98blH7pu+vYJpaUKLaJNp8dOoMQdTF/GdVWBONKB47ApBkyNRv59xZm6EX/c=
X-Gm-Gg: ATEYQzxAWwHZ61N4pHR+omOqEyOH8VBNmcVvLrqh0WHjHnsqRcfNqKrUcbqmYT+eUGY
 jTbY4NeMjL953DToy0NfxvtFjspDrr0TBfJRyx/qgZ3mzDu4Vn/mpa19ckxLglxBhq+XygYeDSL
 NBO9YcR361mJGesaj37W2ZrDlNgCbDwRMKRrTIkSPW6IZKyBkJsCewrgo6aN3hqs8P4jt4D3Kzo
 sD0GVekDn/Wda7DFRcRrqfn2+MYrz20+twC7svSR3RAn08EspV7l3GtAG/1rqSMRSSe5CPOU7oT
 aRlL0GPN5r7RVXOHtwR8oyyFh/K6RovxacHROQrczI3G6TuLeqFtQph7E7yAh8MvG1zB5tdvz74
 iwqkF6wa5BgTdjXkUjvoOvkNLVf//LQsMZRxkmlnNeojf/JkGmVL+mju9AUxsQcW9dL60ji3TmH
 iEjDVS2tfqOM6BUmyxizb3zD0ZwDJjF+mNKZLSnh/qElpZATMm8iiWE2Fxk0SwJvEcj9PfM8syc
 A==
X-Received: by 2002:a05:6830:488f:b0:7cf:d9bb:63a1 with SMTP id
 46e09a7af769-7d782500482mr9265948a34.16.1773671655451; 
 Mon, 16 Mar 2026 07:34:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664?
 ([2600:8803:e7e4:500:e504:a034:1152:a664])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a55dsm13794922a34.13.2026.03.16.07.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 07:34:14 -0700 (PDT)
Message-ID: <38e5929d-4d95-45db-be93-28232a9de954@baylibre.com>
Date: Mon, 16 Mar 2026 09:34:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
To: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
 <20260310-mtk-mt8391-initial-support-v2-6-1dc862d58532@baylibre.com>
 <CAEHHSvbduE9Naebb8hk3xu+0ZEwRuO8yuh_1GUM9QFOP=BA2vQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvbduE9Naebb8hk3xu+0ZEwRuO8yuh_1GUM9QFOP=BA2vQ@mail.gmail.com>
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

On 3/16/26 7:38 AM, Julien Stephan wrote:
> Le mer. 11 mars 2026 à 01:17, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>>
>> Add basic defconfigs for Genio 520 and 720 EVKs.
>>
>> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  board/mediatek/MAINTAINERS             |  7 +++++++
>>  configs/mt8189.config                  | 34 ++++++++++++++++++++++++++++++++++
>>  configs/mt8371_genio_520_evk_defconfig |  4 ++++
>>  configs/mt8391_genio_720_evk_defconfig |  4 ++++
>>  4 files changed, 49 insertions(+)
>>
>> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
>> index 446a9e8e53c..4f371592059 100644
>> --- a/board/mediatek/MAINTAINERS
>> +++ b/board/mediatek/MAINTAINERS
>> @@ -1,3 +1,10 @@
>> +MT8189/MT8371/MT8391 EVK
> 
> Hi David,
> I would not put MT8189 here since there is no MT8189 EVK
> 
>> +M:     Macpaul Lin <macpaul.lin@mediatek.com>
>> +S:     Maintained
>> +F:     configs/mt8189.config
>> +F:     configs/mt8371_genio_520_evk_defconfig
>> +F:     configs/mt8391_genio_720_evk_defconfig
> 
> Any reason to have genio_520/genio720 in the defconfig name?

The upstream devicetree name will have "genio-720" in the name, so
find it strange to call the defconfig something that doesn't match
the devicetree.

If there is a (not Genio) MT8391 EVK I would expect it to have a
different devicetree and therefore a different defconfig.

> All other boards we are currently upstreaming don't specify it in
> their defconfig name:
> mt8365_evk_defconfig/mt8370_evk_defconfig/mt8390_evk_defconfig ...
> 
