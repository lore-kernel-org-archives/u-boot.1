Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE126C79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 16:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 426F880BC0;
	Sun,  6 Sep 2026 16:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UbqNRQ7wT4mw; Sun,  6 Sep 2026 16:46:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 18C8C80B39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788713206;
	b=ZXgCBZJf8iqW9GsLlV6xHE/v44bDxmm2oQ7nstIdgiX3wFsglEO9O5A0xJgo2f2smbpI
	 UKYdjOB+yoB++q9a5ULp8EE52ONQAtvr8KwVd1znKYJiKQkED/ZXeVe0qkrZJrPH8FNrw
	 5kEcshR0dQwyQiDK8n0cbj54Tc+myreLEADxIJyb+5k2u5KCLvCAwqc+bqqqs2elREzRH
	 r+Pmtd8ZCqhk3wRIFoXqf79TVjdTJEKDWpSjudwXpzt1BN1n1P9Lmg3b+FJhEKD0zRH/S
	 J6bnC5G1qL3pwWmprXN3MWcH6/WiUiu1R1kS9F/PmH8W1MYmdZqqf7f+qTU8xqyJd9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788713206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v4AIZGFB9P1+akage+un7DqMtttHsv80X4qhFSAk7yU=;
	b=GoRF3TqoDLYsgXnyyrQg8LGmG0sor1l2mmPRFQrRBh/vWp2rAv+egEiSERs8NzpI2KxT
	 PGkanb+5xjTv56dhqE9WVvqakBZykxQE7J+KfcRcwQkeOSJVQJHNi4HdK5Bi37JB+f2FZ
	 Qq8S4NgDXXo+F/kqAo6fsmr7gVi/IDtWrbX/d+6SX2sWVS1sJ0WrXVpcy/VocUB9ILMLT
	 S/PnAKtQpPb1KPTQ1KQVt1+rbBtzwnEVU7A9dHqbaLR93NtcE/BKwhe7oz2lKYkmZtBN1
	 8/8nLCgVF/i/7UqEm6yLbIXr8n8k6Yy3VJHGMEamla+gga3HI1+k6HwiN6pqneQOCEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qepHFzJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788713206;
	bh=v4AIZGFB9P1+akage+un7DqMtttHsv80X4qhFSAk7yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jymhs7igE8V7e3Ztf8LuReH1Jzrd+dfalrCisMk8xQ5FSEDGc2YRQaWEqrBoLdLay
	 YIeTiOF/mTvP9BOHoVPj2twPvCgMMrRJvPLfMVJ5hmW49/PORQ8L64X9S8dZ0O3WMZ
	 5KLQntYUueUvLwGPo9BpuOeSULxVqyWdMgyTzSwty91AwlcA9wwyMY5IwhOMwCKgvw
	 2ygryGOw6zkULyH3bCf+sJcYfAt7EU7erQn+RwwqX5taIaLRfy6gxpEAf7OrGebKeS
	 55ppOKDaFDqtkZWyGF2qnKEqaav3cX4BNQRABDfRDbxsBREgpXbFWgcV40G/RvnFRW
	 n0Y1rz+NEsZog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18C8C80B39;
	Sun,  6 Sep 2026 16:46:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA65E118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABCBB80D1B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9TAbDw84ZzQ for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 13:10:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4FA2880D18
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788700247;
 b=DuJ8qk3/iNbOyGAx21i8XI8eaUUsrgSRsRykqpj4r6GSpNjG9T5Oq8uIa+T966LfxY1x
 sJNWLQDdXJpni/fdY3t4u93lYAV1iNXJSp1xFK13q2W9px2h2asjNygnxDKjqxaNJIZQi
 UjGYdQFkZvChZX+JherBukwfMMKlAXkZDkKfDRdG+fIXq8lWwUricBivMnsiDBSH7ShcX
 cQmIVxxkA33l/aV+SJ23jpePnLYOwtLgDJmCv9WZjpjF9c56UxXkPsqCtj4ZXdDqzZIOV
 l9MsTajakpfwiiuANB92mhlj8OFtGfUwb/WADyfBKtKYLZCgdt0a1r6C/dVe7mBIagQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788700247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=v4AIZGFB9P1+akage+un7DqMtttHsv80X4qhFSAk7yU=;
 b=nX6y/10xyk5VJhD/5fCgc/NYKgNo/ZGR0yuNqBwLvWP6qh6Ov5cgJaNmMgMCIdW5MA2e
 x/wqRj16V2GGc7OlvQbViwHgn5Bm0tPIl8/r0OSOozKI60qBNrvn8KYs5+pHWklRJ0zdJ
 I3Z990sI2yH9oLVTdc6OMCqlrpi1DczWKSy5pS70N+tXcxL5vWXkKF8pMnsZWjL2TnsPk
 WkmS0cQvD/j6BC4kn0utMoMCVFxAW2yDCFEWrdchQFxwRfEzHuBMmgFPETUT1RGKBizyr
 VsD3gw8irhwNEjVxH38/fEw+i2gRGzuCb3ew7pK410KoVWaWD2Uei7JTKPOyVCN19Nw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qepHFzJF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=lucienzx159@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qepHFzJF
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FA2880D18
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:10:46 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca80d708489so1903197a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788700246; x=1789305046;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v4AIZGFB9P1+akage+un7DqMtttHsv80X4qhFSAk7yU=;
 b=qepHFzJF9JDuyImac2tcIQ+pXkadFtl5qZ5bHSIHblsz0tvM+Ib8XQx9iQZvpMk4Et
 ndSxisvcP0g3R6IdrUZpoyyqyERsmzXX9jPrDqnu4FytJxoVrtEWWMFrveZRDUy/zhKj
 0/WgllB5r+yJubzsml2uLVsXmwzAJk/n24NCmtf3k6Ywsynu0yW6J8cSBic6hVwcjOXY
 HUstNjJCE15+AXEelNLSN7w3BoEFudOt1nTMD+ajtDYTC0GnbD8fkqyuBMZh5PJkPanP
 wUcijliYp6aUSgRrU7pEJono5nu9ZocvN6JdC/MFP4z38MwflQXlJpJpBysnpS91EXxD
 9/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788700246; x=1789305046;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v4AIZGFB9P1+akage+un7DqMtttHsv80X4qhFSAk7yU=;
 b=E1auPaMKWC9mbXTyZh5TYFXKyqj9wpPqRLMZ0yTvU48fChFKG9eVz+PGw4M/iRz7lr
 ZIM8x2kUQmVoVjTc1JUesPtWThvapXXq+5Wp4FF+vkrBRehF+NLlAwfhy7V3z1LuAI9f
 DplLXKPGVQHthfO4BqlcAUc+67q0nZoaOH6txHOeQp3vLSfsrDDkRWZMAf2ut3KLk+Ah
 RIItWcYWX5Ri0f4iH/LSyLcixkflKWrmnWfhf1wt4+2B+ZKt5hBsEmEX0Qu8K0lbHALC
 Niq5XWJFRclAZBfKNo+4HV+ThRRf5fNVkU1v5CRYrd422NigFZcHAn4ImZ8K2bYr3YMJ
 doXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+i+rY3MSVrQ5Q9YG5GewLjrdusbHafJqN5qGL9yxBwtL5yIUPCAuIWg3AAodGcTa3peyw7lA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mtIdx1bN0DpHXs1Fb2MKn+4KPVjuJcYlgeUmR+Aw/GCKHcV46B
 i3a4zfq9NtRYtKQol2nGGl1CK7bnQ1DsfJEvHLaVPXKPV3hXal8LEIrY
X-Gm-Gg: AYBFou1CsAbuQhHgK9CC+JSvBH50Bu3yypLL1X6Je5H+AQEsNKvxSqgHowOdPPVKUhR
 PElS19he0fXq+st1h6CtZiuxpeOfggQLvhWresmXZOEil/VcuX44jR9q8dDBYnO9V1sW8HqvSjI
 ymkbVUisMsywhe7uMr6fGqnhgtGqqKpKfLcAjpQHNQTAUv6CzZ3y2DFb1GCp6bRSsnjQFKjZbXG
 tkFqqKrPTne1KrabMgb82l0jSHZU86V4lSZXlnzWWO91QcSkJR4wa6nSdBmNTs4yXnEceSMuVK4
 YamhozxSQNuXe/iWd508z+zueqwUjMBwqcU3dxILjCGLdxywgm7bpyr81NP21jy++86EIK33iWa
 a3KllSEMfCDlxxdmOdb53itDTZTjnpE9vReYgzgw3mony97g771xGdlbK8R7/RLi/uqWSiujxGW
 g3geFhhKTG9W7ncp1dDUUkwRZ9gNduSghtMeIDSb+S3XrkPpcRo1M9Nb16DfbLctD1RzB4bkoWJ
 MwSPIqacoEuo3LWFJkQZYKPBFNqWhQb0OQlwZDHBpg5o81p
X-Received: by 2002:a17:90b:5585:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-39b27c8ebdcmr13671679a91.7.1788700245932; 
 Sun, 06 Sep 2026 06:10:45 -0700 (PDT)
Received: from [192.168.0.3] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c397b1sm21061582a91.8.2026.09.06.06.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2026 06:10:45 -0700 (PDT)
Message-ID: <8461e750-ddac-4079-8d2d-52e285b7eb38@gmail.com>
Date: Sun, 6 Sep 2026 21:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: mediatek: add BPi-R3 Mini eMMC board support
To: Frank Wunderlich <frank-w@public-files.de>, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, jbx6244@gmail.com, msp@baylibre.com,
 u-boot@lists.u-boot-project.org
Cc: daniel@makrotopia.org, skylake.huang@mediatek.com
References: <20260906120756.8290-1-lucienzx159@gmail.com>
 <4c03ad9a-1314-4cae-b2ff-bbf84a6f4b4e@public-files.de>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <4c03ad9a-1314-4cae-b2ff-bbf84a6f4b4e@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Sep 2026 16:46:42 +0000
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

Hi Frank

My apologies for not citing your Git repository as the source for the 
DTS file.

I'll make sure to attribute you using the 'Co-developed-by' tag. Sorry 
about the oversight!

I will double-check your commit and what you mentioned about 
'compatible' earlier, and try to make the next commit.

Thank.

Frank Wunderlich 於 2026/9/6 下午 08:59 寫道:
> Hi Lucien,
>
> it seems you try to upstream the DTS from my repo [1] (i did not do it 
> because of OF_UPSTREAM discussion/requirement) only with minor cleanup 
> (e.g. dropped my attempt to define regulators as such - was not 
> working in my tests but imho more logical).
>
> But it would be great if you mention me as Co-developed-By or similar.
>
> Not sure if upstream-discussion is still valid (new downstream DTS 
> were rejected there), it needed many other driver patches and some 
> hacks at DT level (my last state [2]).
>
> btw. compatible should be changed to upstream one [3]
>
> regards Frank
>
> [1] 
> https://github.com/frank-w/u-boot/blob/2024-04-bpi-r3mini/arch/arm/dts/mt7986a-bpi-r3-mini.dts
>
> latest version: 
> https://github.com/frank-w/u-boot/blob/2026-07-bpi/arch/arm/dts/mt7986a-bpi-r3-mini.dts
>
> [2] https://github.com/frank-w/u-boot/commits/2026-01-bpi-ofupstream/
>
> [3] 
> https://github.com/frank-w/BPI-Router-Linux/blob/7.3-rc/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dts#L21
>
> Am 06.09.26 um 14:07 schrieb Lucien.Jheng:
>> Add device tree and defconfig for the Bananapi BPi-R3 Mini, an
>> eMMC-only variant of the BPi-R3 board built around the MT7986A SoC.
>>
>> The board dtsi enables the MT7986 eMMC controller, SPI-NAND flash,
>> PWM, and the on-board Airoha EN8811H 2.5G PHY via mdio.
>>
>> The mt7986a_bpir3_mini_emmc_defconfig enables the drivers needed for
>> this variant: SPI-NAND (MTD/UBI), USB xHCI, PCIe Gen3 with NVMe, the
>> Airoha EN8811H PHY driver, and RNG/pstore support.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>> ---
>>   arch/arm/dts/Makefile                     |   1 +
>>   arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts | 236 ++++++++++++++++++++++
>>   configs/mt7986a_bpir3_mini_emmc_defconfig | 139 +++++++++++++
>>   3 files changed, 376 insertions(+)
>>   create mode 100644 arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
>>   create mode 100644 configs/mt7986a_bpir3_mini_emmc_defconfig
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 1b533721bb4..b62a4334750 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -1080,6 +1080,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>>       mt7981-sd-rfb.dtb \
>>       mt7986a-bpi-r3-sd.dtb \
>>       mt7986a-bpi-r3-emmc.dtb \
>> +    mt7986a-bpi-r3-mini-emmc.dtb \
>>       mt7986a-rfb.dtb \
>>       mt7986b-rfb.dtb \
>>       mt7986a-sd-rfb.dtb \
>> diff --git a/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts 
>> b/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
>> new file mode 100644
>> index 00000000000..18320b20be8
>> --- /dev/null
>> +++ b/arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts
>> @@ -0,0 +1,236 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/dts-v1/;
>> +#include "mt7986.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +
>> +/ {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +    model = "Bananapi BPi-R3 Mini";
>> +    compatible = "mediatek,mt7986", "mediatek,mt7986-rfb";
>> +
>> +    chosen {
>> +        stdout-path = &uart0;
>> +        tick-timer = &timer0;
>> +    };
>> +
>> +    memory@40000000 {
>> +        device_type = "memory";
>> +        reg = <0x40000000 0x80000000>;
>> +    };
>> +
>> +    gpio-keys {
>> +        compatible = "gpio-keys";
>> +
>> +        button-reset {
>> +            label = "reset";
>> +            linux,code = <KEY_RESTART>;
>> +            gpios = <&pio 7 GPIO_ACTIVE_LOW>;
>> +        };
>> +    };
>> +
>> +    leds {
>> +        compatible = "gpio-leds";
>> +
>> +        status_led: led-0 {
>> +            label = "green:status";
>> +            gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
>> +        };
>> +
>> +        led-1 {
>> +            label = "blue:wlan2g";
>> +            gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
>> +        };
>> +
>> +        led-2 {
>> +            label = "blue:wlan5g";
>> +            gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
>> +        };
>> +    };
>> +
>> +    reg_1p8v: regulator-1p8v {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "fixed-1.8V";
>> +        regulator-min-microvolt = <1800000>;
>> +        regulator-max-microvolt = <1800000>;
>> +        regulator-boot-on;
>> +        regulator-always-on;
>> +    };
>> +
>> +    reg_3p3v: regulator-3p3v {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "fixed-3.3V";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        regulator-boot-on;
>> +        regulator-always-on;
>> +    };
>> +};
>> +
>> +&eth {
>> +    status = "okay";
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&mdio_pins>;
>> +
>> +    mediatek,gmac-id = <0>;
>> +    phy-mode = "2500base-x";
>> +    phy-handle = <&phy14>;
>> +
>> +    phy14: eth-phy@14 {
>> +        compatible = "ethernet-phy-id03a2.a411";
>> +        reg = <14>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&en8811_pwr_a>;
>> +        airoha,pnswap-rx;
>> +
>> +        reset-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
>> +        reset-assert-us = <10000>;
>> +        reset-deassert-us = <20000>;
>> +    };
>> +
>> +    /*phy15: eth-phy@15 {
>> +        compatible = "ethernet-phy-id03a2.a411";
>> +        reg = <15>;
>> +
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&en8811_pwr_b>;
>> +        airoha,pnswap-rx;
>> +
>> +        reset-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
>> +        reset-assert-us = <10000>;
>> +        reset-deassert-us = <20000>;
>> +    };*/
>> +};
>> +
>> +&mmc0 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&mmc0_pins_default>;
>> +    bus-width = <8>;
>> +    max-frequency = <200000000>;
>> +    cap-mmc-highspeed;
>> +    cap-mmc-hw-reset;
>> +    vmmc-supply = <&reg_3p3v>;
>> +    vqmmc-supply = <&reg_1p8v>;
>> +    non-removable;
>> +    status = "okay";
>> +};
>> +
>> +&pio {
>> +    en8811_pwr_a: en8811-pwr-a {
>> +        pins = "GPIO_11";
>> +        drive-strength = <MTK_DRIVE_8mA>;
>> +        bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
>> +        output-low;
>> +    };
>> +
>> +    en8811_pwr_b: en8811-pwr-b {
>> +        pins = "GPIO_12";
>> +        drive-strength = <MTK_DRIVE_8mA>;
>> +        bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
>> +        output-low;
>> +    };
>> +
>> +    mdio_pins: mdio-pins {
>> +        mux {
>> +            function = "eth";
>> +            groups = "mdc_mdio";
>> +        };
>> +    };
>> +
>> +    mmc0_pins_default: mmc0default {
>> +        mux {
>> +            function = "flash";
>> +            groups =  "emmc_51";
>> +        };
>> +
>> +        conf-cmd-dat {
>> +            pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
>> +                   "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
>> +                   "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
>> +            input-enable;
>> +            drive-strength = <MTK_DRIVE_4mA>;
>> +            bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +        };
>> +
>> +        conf-clk {
>> +            pins = "EMMC_CK";
>> +            drive-strength = <MTK_DRIVE_6mA>;
>> +            bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +        };
>> +
>> +        conf-dsl {
>> +            pins = "EMMC_DSL";
>> +            bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +        };
>> +
>> +        conf-rst {
>> +            pins = "EMMC_RSTB";
>> +            drive-strength = <MTK_DRIVE_4mA>;
>> +            bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +        };
>> +    };
>> +
>> +    spi_flash_pins: spi0-pins-func-1 {
>> +        mux {
>> +            function = "flash";
>> +            groups = "spi0", "spi0_wp_hold";
>> +        };
>> +
>> +        conf-pu {
>> +            pins = "SPI2_CS", "SPI2_HOLD", "SPI2_WP";
>> +            drive-strength = <MTK_DRIVE_8mA>;
>> +            bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
>> +        };
>> +
>> +        conf-pd {
>> +            pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
>> +            drive-strength = <MTK_DRIVE_8mA>;
>> +            bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
>> +        };
>> +    };
>> +
>> +    pwm_pins: pwm0-pins-func-1 {
>> +        mux {
>> +            function = "pwm";
>> +            groups = "pwm0";
>> +        };
>> +    };
>> +};
>> +
>> +&pwm {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&pwm_pins>;
>> +    status = "okay";
>> +};
>> +
>> +&spi0 {
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&spi_flash_pins>;
>> +    status = "okay";
>> +    must_tx;
>> +    enhance_timing;
>> +    dma_ext;
>> +    ipm_design;
>> +    support_quad;
>> +    tick_dly = <1>;
>> +    sample_sel = <0>;
>> +
>> +    spi_nand@0 {
>> +        compatible = "spi-nand";
>> +        reg = <0>;
>> +        spi-max-frequency = <52000000>;
>> +    };
>> +
>> +};
>> +
>> +&uart0 {
>> +    status = "okay";
>> +};
>> +
>> +&watchdog {
>> +    status = "disabled";
>> +};
>> diff --git a/configs/mt7986a_bpir3_mini_emmc_defconfig 
>> b/configs/mt7986a_bpir3_mini_emmc_defconfig
>> new file mode 100644
>> index 00000000000..411ad11d6a7
>> --- /dev/null
>> +++ b/configs/mt7986a_bpir3_mini_emmc_defconfig
>> @@ -0,0 +1,139 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARM_SMCCC=y
>> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>> +CONFIG_POSITION_INDEPENDENT=y
>> +CONFIG_ARCH_MEDIATEK=y
>> +CONFIG_TEXT_BASE=0x41e00000
>> +CONFIG_SYS_MALLOC_F_LEN=0x4000
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_ENV_SIZE=0x80000
>> +CONFIG_ENV_OFFSET=0x300000
>> +CONFIG_DEFAULT_DEVICE_TREE="mt7986a-bpi-r3-mini-emmc"
>> +CONFIG_TARGET_MT7986=y
>> +CONFIG_DEBUG_UART_BASE=0x11002000
>> +CONFIG_DEBUG_UART_CLOCK=40000000
>> +CONFIG_SYS_LOAD_ADDR=0x46000000
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_DEFAULT_FDT_FILE="mt7986a-bpi-r3-mini-emmc"
>> +CONFIG_LOGLEVEL=7
>> +CONFIG_LOG=y
>> +CONFIG_SYS_PROMPT="BPI-R3M> "
>> +CONFIG_SYS_CBSIZE=512
>> +CONFIG_SYS_PBSIZE=1049
>> +# CONFIG_BOOTM_NETBSD is not set
>> +# CONFIG_BOOTM_PLAN9 is not set
>> +# CONFIG_BOOTM_RTEMS is not set
>> +# CONFIG_BOOTM_VXWORKS is not set
>> +# CONFIG_CMD_ELF is not set
>> +# CONFIG_CMD_UNLZ4 is not set
>> +# CONFIG_CMD_UNZIP is not set
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_GPT_RENAME=y
>> +CONFIG_CMD_LSBLK=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PART=y
>> +CONFIG_CMD_READ=y
>> +CONFIG_CMD_PING=y
>> +CONFIG_CMD_SMC=y
>> +CONFIG_CMD_FAT=y
>> +CONFIG_CMD_EXT4=y
>> +CONFIG_CMD_FS_GENERIC=y
>> +CONFIG_PARTITION_TYPE_GUID=y
>> +CONFIG_ENV_OVERWRITE=y
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_REGMAP=y
>> +CONFIG_SYSCON=y
>> +CONFIG_CLK=y
>> +CONFIG_MMC_HS200_SUPPORT=y
>> +CONFIG_MMC_MTK=y
>> +CONFIG_PHY_FIXED=y
>> +CONFIG_DM_MDIO=y
>> +CONFIG_MEDIATEK_ETH=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCONF=y
>> +CONFIG_PINCTRL_MT7986=y
>> +CONFIG_POWER_DOMAIN=y
>> +CONFIG_MTK_POWER_DOMAIN=y
>> +CONFIG_DM_REGULATOR=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_SERIAL=y
>> +CONFIG_MTK_SERIAL=y
>> +CONFIG_FAT_WRITE=y
>> +CONFIG_HEXDUMP=y
>> +# CONFIG_EFI_LOADER is not set
>> +CONFIG_LMB_MAX_REGIONS=64
>> +
>> +CONFIG_AUTOBOOT=y
>> +#CONFIG_BOOTDELAY=2
>> +
>> +CONFIG_FIT=y
>> +CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
>> +CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="uEnv_r3.txt"
>> +CONFIG_HUSH_PARSER=y
>> +
>> +CONFIG_MTD=y
>> +CONFIG_DM_MTD=y
>> +CONFIG_MTD_UBI=y
>> +CONFIG_CMD_UBI=y
>> +CONFIG_CMD_UBIFS=y
>> +CONFIG_SPI=y
>> +CONFIG_DM_SPI=y
>> +CONFIG_MTD_SPI_NAND=y
>> +CONFIG_MTK_SPIM=y
>> +#CONFIG_MTK_SPI_NAND=y
>> +#CONFIG_MTK_SPI_NAND_MTD=y
>> +#CONFIG_MTK_SNOR=y
>> +#CONFIG_MTK_SNFI_SPI=y
>> +CONFIG_SPI_FLASH=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_CMD_MTD=y
>> +CONFIG_DM_SPI_FLASH=y
>> +CONFIG_CMD_SF=y
>> +#CONFIG_MTD_RAW_NAND=y
>> +#CONFIG_CMD_NAND=y
>> +#CONFIG_CMD_NAND_TRIMFFS=y
>> +CONFIG_ENABLE_NAND_NMBM=y
>> +CONFIG_MTDIDS_DEFAULT="nmbm0=nmbm0"
>> +CONFIG_MTDPARTS_DEFAULT="nmbm0:1024k(bl2),512k(u-boot-env),2048k(factory),2048k(fip),65536k(ubi)" 
>>
>> +CONFIG_PHY=y
>> +CONFIG_PHY_MTK_TPHY=y
>> +CONFIG_DM_USB=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_XHCI_MTK=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_USB_STORAGE=y
>> +CONFIG_CMD_ASKENV=y
>> +CONFIG_CMD_STRINGS=y
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> +CONFIG_CMD_BOOTMENU=y
>> +CONFIG_SUPPORT_EMMC_BOOT=y
>> +
>> +CONFIG_FS_LOADER=y
>> +CONFIG_PHY_AIROHA=y
>> +CONFIG_PHY_AIROHA_EN8811=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_PHY_AIROHA_FW_BUILTIN=y
>> +CONFIG_PHY_ETHERNET_ID=y
>> +
>> +CONFIG_PCI=y
>> +CONFIG_PCIE_MEDIATEK_GEN3=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_NVME_PCI=y
>> +CONFIG_NVME=y
>> +CONFIG_CMD_CACHE=y
>> +
>> +CONFIG_CMD_PSTORE=y
>> +CONFIG_CMD_PSTORE_MEM_ADDR=0x42ff0000
>> +CONFIG_CMD_PSTORE_RECORD_SIZE=0x1000
>> +#CONFIG_CMD_PSTORE_CONSOLE_SIZE=0x1000
>> +#CONFIG_CMD_PSTORE_FTRACE_SIZE=0x0
>> +#CONFIG_CMD_PSTORE_PMSG_SIZE=0x1000
>> +
>> +CONFIG_DM_RNG=y
>> +CONFIG_RNG_MTK_V2=y
>> +CONFIG_CMD_RNG=y
>> -- 
>> 2.34.1
