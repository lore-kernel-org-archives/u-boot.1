Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A0CC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 15:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4676586EC9;
	Sat, 11 Nov 2023 16:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RDSGPUsQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825E986F63; Sat, 11 Nov 2023 08:43:31 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFA786F59
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 08:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso37293051fa.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699688607; x=1700293407; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDDpxZqK3iYLUVfT+ndftBlL5j7iR7iZla2A+QvCuFA=;
 b=RDSGPUsQ68+ZmVOXcfwuWt1EEkDFP5msE9ZY9Nhe68PaQwEhl3mRBFvbiB1LGNz8Kn
 oTD0VZmg24mTm1rDjhIic+sGqQcWxCQHyHf6b+1Y/Bm5NMCURREK8Kpxd75KqfaJHFb5
 E+8tRqO0OyMkOdHulBl4XGxmQFI+4Zw18LTThwd6nGhKMEp4UMLe7hfq43S0bBnqT9ee
 en6wqMk3NhwvmB2mYAYVAna6NGasfZ0zWGKH/hA48jK7UAHB/OpcPmoWOjKKeuDY7qVU
 uVG7Jh8uWxFvoAXGgObGhQJKpDozfUelAxyG5oE4Z/goX2/kSTST9oehIVOhDA+EplAN
 otPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699688607; x=1700293407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDDpxZqK3iYLUVfT+ndftBlL5j7iR7iZla2A+QvCuFA=;
 b=eEwtDZRmR2KNgxsmL9aIi5sfkj4EZEaZxXcoubajrcjsaaq2QbzlO4li6m4/U349st
 Ogr1EXvN2GwuvWZ22/dOMZYUD4u3+4ZEQEnA4lRW70QmBToSWw9TtIu9v72ObedIdLAj
 5AUfiSfPbLeCbtWvbzidOgNDwXMJaUyUIz/YTM7FdR7RlS2jPhcm29B30R6jokJaBrb4
 mj81SoIaLX3nHXDkAYRQZtlCTKVqsFSLkvtg7eBuEXquJ3BRMKRWmqaeGHrd/bbwjemw
 Ud3kPi51mrCoCOBlhmh7vrcyS7kXOvIKeCK0nMGm346udo0g7R6KiJkXsyb9xt9cZ+gH
 bOBg==
X-Gm-Message-State: AOJu0YzS1OTgKNvRs/4pX/WLnB7fMAg+Yib3VUbxX5sXRdP44hDAFo+s
 2381cW3amtKM866aJKCmtZs=
X-Google-Smtp-Source: AGHT+IFp/X8b6Ie73wLtFEbimMLgshg+Fu7KHDtbyORNIXJS2xevXi7WZwHzNe9GZvpy1YmubcAwww==
X-Received: by 2002:a05:651c:49b:b0:2c8:3b0b:d974 with SMTP id
 s27-20020a05651c049b00b002c83b0bd974mr245259ljc.15.1699688607293; 
 Fri, 10 Nov 2023 23:43:27 -0800 (PST)
Received: from [192.168.101.248] ([193.34.225.90])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a2e9786000000b002ba15c272e8sm154017lji.71.2023.11.10.23.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 23:43:25 -0800 (PST)
Message-ID: <3ff938ac-35c0-4705-86f7-819060ebb2d6@gmail.com>
Date: Sat, 11 Nov 2023 10:43:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] sunxi: H616: add LPDDR4 DRAM support
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
References: <20231104062248.32938-1-iuncuim@gmail.com>
 <20231104062248.32938-2-iuncuim@gmail.com> <2211206.irdbgypaU6@archlinux>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <2211206.irdbgypaU6@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Nov 2023 16:35:46 +0100
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

Hi Jernej,

On 04.11.2023 11:31, Jernej Škrabec wrote:
> Hi Mikhail,
>
> I have some notes on LPDDR4 from a long time ago. It mostly matches to your
> code, but please take a look at comments below.
>
> Note that I have extra code, not included in this patch, for
> mctl_phy_read_training(). At the very beginning, before any other register
> access is done, this should be added:
>
> if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
> 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x800);
> 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x81c);
> }
>
> Maybe that will help with other LPDDR4 boards?

Current H618 and t507 boards do not yet require this feature. Yes, this
feature may be required for future devices. I will add it in the next 
version.

>> @@ -246,8 +251,13 @@ static void mctl_phy_configure_odt(const struct
>> dram_para *para) {
>>   	uint32_t val_lo, val_hi;
>>
>> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x390, BIT(5), BIT(4));
>> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3d0, BIT(5), BIT(4));
>> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x410, BIT(5), BIT(4));
>> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x450, BIT(5), BIT(4));
>
> I don't have above block. Something from newer libdram? Is it applicable to
> all DRAM types?

This function is present in the RE code for all types of memory. Binary 
file dumped from orangepi zero3 nor spi.I paid attention to this area 
code when comparing the sunxi u-boot dump (md.l) with the resulting 
mainline u-boot. Now I checked my tvbox with H616 and LPDDR3 and it 
doesn't have this block. In this case, maybe it would be better to make 
it only for devices with LPDDR4?
>> +	case SUNXI_DRAM_TYPE_LPDDR4:
>> +		writel(0x0, &mctl_ctl->mrctrl1);
>> +		writel(0x80000030, &mctl_ctl->mrctrl0);
>> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> I don't have above block. Maybe difference from newer version of libdram 
> code?

This block was present in the sunxi t507 binaries for which the driver 
was originally intended.  Now I checked original dump from orangepi zero3 NOR SPI.
This is also present here.


>>   	writel(reg_val, &mctl_ctl->odtcfg);
>>   	writel(reg_val, &mctl_ctl->unk_0x2240);
>>   	writel(reg_val, &mctl_ctl->unk_0x3240);
> I have extra "writel(BIT(31), &mctl_com->cr);" after this block for all DRAM
> types. Not sure if it changes anything.
Looks like this has already been done in previous patches.
>> +	u16 trfc	= ns_to_t(280);
> My notes say 180 instead of 280. Did you check if register value matches if
> booted with boot0
I booted from NOR SPI of the sunxi u-boot and made a dump with md.l 
0x047fb064. It show me value 0030006f, where 0x6f trfc value. Based on 
the transformation function - 111*1000/(792/2)=280,30(30) So, obtained 
value looks correct. Best regards,
Mikhail

