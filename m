Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29EBC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F29A81304;
	Fri,  7 Aug 2026 12:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqg4O-BiDN1B; Fri,  7 Aug 2026 12:57:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7CE081100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786107460;
	bh=AXTYyoZRQVDaRnVscAc0pf1/PIbtvGXu29PuQo0tctk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0xtZXL9HJAxq4HmDabcGPw5H85qiXWv4eHtaTGGKujOiUwIgru1y/QwtoFik+k2y
	 FZkifxKf+W0+Ho4Y0pToS1q7jC6QUzEI+NS5GzXjOQfCGP1u+oibRnfk5ACC9Umy1/
	 LvlfRfWkxh9SG2f/P480BviT80DH+ei5z5Kf62VM8fOa7xp97A8bawnGBkFBEQci6e
	 Uokjdni7k/HPm+8VI0aE4ZY+FxKHxx4TalX6sGt++yUTK6e86bW8Z3SWQx0SuZOxYm
	 iEUCgQ2rEos39/3sEEGW2aPuRjXkubkh5nmTO/mBFPlhhLljWibQjal4Yy6htQLth2
	 prHcygUQDAR5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7CE081100;
	Fri,  7 Aug 2026 12:57:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 121D7D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0408481100
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ftYQ6nhabjf for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:57:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B7F5D810D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7F5D810D2
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7F5D810D2
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:57:37 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4a071495be0so2050333b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 05:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786107456; x=1786712256;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXTYyoZRQVDaRnVscAc0pf1/PIbtvGXu29PuQo0tctk=;
 b=Piw6alJK72xKOyOVqHn5yn4FT0IWsy1KxsaXao9dx9y44lSR790kdskI/lqJmSe1x8
 KhiLqHD48UT2kFLFHkf0oX7DdwwB+zxgN8OOUoLfnaCmv9EVX4ev0TeEARZle0Y7a1GI
 dsEh9pOAnSkNbTDznXLOETxxN5KeYs+Ls5yhMiob+5U2kcWbLtZvX3u6yKtUuS1imIIz
 lBtAULPgpcGHMuBbYfXBVtiU9/d7/6+G+Yi9D5y09T6ttKWACtUWbIFMtQwOLs4+9/KR
 xSGi0LbkXLSLCGxCu4CRNcaPD8SYkPJbva6xwxvnHZozjVXi1bzL77l7oJovar9g7oR+
 AtLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgqdKwL5/qKD7PnHe0sdlnTKETzKjFWHaaqiM579bjdeFzCSdk8A4BmFTnypnW7paUla+b4N0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxpmTQ2uL9u8RgRVxcikLm6rbPpjY8in8wmaROy5f6kVVWF6oFo
 A0muHp3d9UDX+W56npVE1nGNzE6l2rduzjJ26wrd2BJ7JSDCl0GAoAeSaN0bUl55izc=
X-Gm-Gg: AR+sD120F1ARwebP6KSpaQrmzknCfjXnW0u1NUDCFRCTxWtrO8zEQOdXcQERFI54Ss7
 gYCo+myVrnxeLq7N6MOzNCyzkiEHkiWTVpyLQknHcsQChqmcWb3Krr8NRNssZi2DH7JdpaYni23
 GQukHHuc0tPvCpNF3RxIfCopAtFq+HV3a/aER56kjO1Aj/vTESkXUFrf45AIff9dC/GWusNGLOG
 ZG7uVyIuDYpuT3VlSA9p8NOnSNokVJIFN8UJNfWOzTGvaPd/rscsCyldHM/ezGmpqXQa+1S2lpd
 ztJomQlR6oFX3B2V4m159jILpF+s7vXp8J43PlYXyiVqpMCAm8kmsgWU5zGy7uJO4Y+2JR8KUM5
 dHro1IPOICETynsPYASAj22nGnOb7V44hq/uk3HNrKclV4DZ/sHKukb7mEa4QADMusNibOemZFb
 wGBMb6XnEFHprwTL93WeTlIbMctq+y/O/57ysgCbA3kgbwV0QoMzbJSXqhJVcYw/KVxEVZSP9u3
 j2chQQdh0uokVYyMwGv7VSjPMy9JN17PQbE
X-Received: by 2002:a05:6808:14cc:b0:492:5b42:ab02 with SMTP id
 5614622812f47-4b1a08de5a3mr1609437b6e.0.1786107456233; 
 Fri, 07 Aug 2026 05:57:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2?
 ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae7fceadsm6822639b6e.18.2026.08.07.05.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 05:57:34 -0700 (PDT)
Message-ID: <e7e67d6e-2b8c-4ba9-ad2b-f5811a8b5453@baylibre.com>
Date: Fri, 7 Aug 2026 07:57:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pinctrl: mediatek: select PINCONF
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>,
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Mingming lee <mingming.lee@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>, u-boot@lists.u-boot-project.org
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
 <20260803-mtk-pinctrl-kconfig-cleanup-v1-1-fef1ff69d1cc@baylibre.com>
 <CAEHHSvaNS0P1E=URTzVMSC2YgX7W_xOv_0_hovT9tdu_mpLWpQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvaNS0P1E=URTzVMSC2YgX7W_xOv_0_hovT9tdu_mpLWpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786107456; x=1786712256;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AXTYyoZRQVDaRnVscAc0pf1/PIbtvGXu29PuQo0tctk=;
 b=dKG370OE7bcD72iQuVmXO1vgzmeG+hGeSZ9/IbL9ee8qu/8vZ8pmEz6dCGA+uBsoJf
 yUvjEUDcy33FzWDeSmj32ahpYW/7wg2WD0QKwT+LEj4CACn86w28luQg6Mqf/lMeUWNW
 ceYIQnFzwXqQC98NYcOT+UUzOxz0mP+rfWv1rbx39+E91VqHfWDTBw4wKKnWpx6pPIHy
 oNR+V5jPfDw7h4AsEq2Z+cuLF8SlP1UCv7kGOPwak21BA7PfZC7hRr+xoB+YviG6GRiu
 WDrHU8gcXsqQD45iEDI+bgfbLNQeU6SXSONDuGpYR8DgwvZ6WGkoh1YqO3sJR0ErDcHz
 PNzA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dKG370OE
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/7/26 7:15 AM, Julien Stephan wrote:
> Le lun. 3 août 2026 à 22:57, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> All MediaTek targets include pinconf registers so we should just always
>> select PINCONF instead of requiring each config to explicitly enable it.
>>
> 
> This is not true for MT8518 (see diff on patch 4 that removes only
> CONFIG_PINCTRL_MT8518).
> So after this series, MT8518 will enable PINCONF by default. Is it
> intentional? Did you test it?
> Maybe  select PINCONF if !TARGET_MT8518  ?

I don't have hardware to test but I did compile it. The driver actually
has push/pull and drive registers defined, so it makes sense to enable it
on this target. I think best would just to mention it in the commit message.

> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/pinctrl/mediatek/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
>> index 5a90d74a9e1..42c7c8b8c80 100644
>> --- a/drivers/pinctrl/mediatek/Kconfig
>> +++ b/drivers/pinctrl/mediatek/Kconfig
>> @@ -2,6 +2,7 @@ if ARCH_MEDIATEK
>>
>>  config PINCTRL_MTK
>>         depends on PINCTRL_GENERIC
>> +       select PINCONF
>>         select REGMAP
>>         select SYSCON
>>         bool
>>
>> --
>> 2.43.0
>>

