Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C712C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 22:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FB788C07;
	Sat, 17 Aug 2024 00:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5IBOPNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E03188BAE; Fri, 16 Aug 2024 18:40:03 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1A088A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 18:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so30972201fa.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723826389; x=1724431189; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Il94/x5xsLq08ytPcYX1xdsuJaa6/mjSKYtq8d2Roc=;
 b=Q5IBOPNFH6KbrVAzQRncXTsBeAkvkPKYw4GCrRuUasze/BiulsoiVXP/vSfXbhw5bm
 KHQ2AxICxeKTN0jfEEOo6pE2tDYUbE9AJIJBED7rIV3RhaigvOrCwHoNHiGfpPTu9PFR
 MhZdD2Er4l+qSrAw/hhbimGxQAZ9DmGoRy5RirAH+YKw0IcLUIb4ZhBRE5iQum9Ntep6
 udb57WaF796YtHKc28O5kk3p6bS89zQVeaHgXF1Dse+nYFyT09O0GHj8uubcZ9Gk47Lb
 aaBmxhgv466HLjxVlKe2aJvy8T5A9fepo6AdWgexQus3z0Q9Nv4PO+92YvGVumROy5ja
 uIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826389; x=1724431189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Il94/x5xsLq08ytPcYX1xdsuJaa6/mjSKYtq8d2Roc=;
 b=RIbQru9In/GBSGxtjRLgVkz0UFbHI6or6UMoPBCJcUA3lIQr/PhyfJTNkdt2JqYf1j
 BYR0RbtW5EJ16e6i5EYNp4ynbs9KMLPOetfBtHRoSWJpxAj4dkw1p6o6ntLnhCWCIzRY
 78jIdgtdXthuOfyZ9lUTjI+Tr+d/rIhJfj+HCmU8mUNx7jOfYaA6+tR1MHHLc/SVrvOb
 aOFDnBuZidUhmg4RG75Iwqod9O9rSdSEV7GtoUZg6m6W/Kn7kYK+F4ZNXNXL17OpOOF5
 clSyX91Oy3ZhRIFHR7S4yCZvMK3sbK0vnW6v8jKk/0zZI3v5Td/GcazPIUchLVn6A5NA
 S2Xw==
X-Gm-Message-State: AOJu0Ywdu3mE881K8fgk+G7Z2jfmh9yIh+MBouKAv4Md45uZc415FqjN
 eXGSb96cAgZRq5C/iKqKeu+SRUBJ3u1Ym0vShWvDhYwvsLrWzDMu
X-Google-Smtp-Source: AGHT+IFYWu4Ut5dt41rzpXbnO4SCWsFBps91MH8BkJHL2blxCOM0Flw12oPxBXG/8sFbiUEjQx5hFg==
X-Received: by 2002:a2e:7317:0:b0:2ee:847f:9e9b with SMTP id
 38308e7fff4ca-2f3be5988b1mr24858611fa.28.1723826388588; 
 Fri, 16 Aug 2024 09:39:48 -0700 (PDT)
Received: from [192.168.99.225] ([94.143.197.228])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f3b77055aesm6123191fa.82.2024.08.16.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 09:39:48 -0700 (PDT)
Message-ID: <34abb85b-8860-49e1-9871-943d69882672@gmail.com>
Date: Fri, 16 Aug 2024 22:39:49 +0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] sunxi: H616: dram: LPDDR4: adjust settings
To: Chris Morgan <macromorgan@hotmail.com>,
 Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com, andre.przywara@arm.com,
 jagan@amarulasolutions.com, trini@konsulko.com, ryan@testtoast.com
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-4-macroalpha82@gmail.com>
 <9b7db179-1e08-4690-97f8-b040f1c19f37@gmail.com>
 <66bd1c50.4a0a0220.192aee.024e@mx.google.com>
 <MN2PR16MB2941DD94188EAB2807701C9FA5802@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <MN2PR16MB2941DD94188EAB2807701C9FA5802@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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

On 16.08.2024 4:03 AM, Chris Morgan wrote:
> On Wed, Aug 14, 2024 at 04:06:23PM -0500, Chris Morgan wrote:
>> On Sat, Aug 03, 2024 at 03:29:17PM +0300, Mikhail Kalashnikov wrote:
>>> On 02.08.2024 01:55, Chris Morgan wrote:
>>>> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>>
>>>> Adjust H616 LPDDR4 DRAM settings to be in line with vendor driver.
>>>>
>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>> Tested-by: Chris Morgan <macromorgan@hotmail.com>
>>>> ---
>>>>    arch/arm/mach-sunxi/dram_sun50i_h616.c        | 35 +++++++++++++------
>>>>    .../dram_timings/h616_lpddr4_2133.c           |  2 +-
>>>>    2 files changed, 26 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
>>>> index a20264d8b4..b6638c519e 100644
>>>> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
>>>> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
>>>> @@ -293,14 +293,22 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
>>>>    	dmb();
>>>>    }
>>>> -static bool mctl_phy_write_leveling(const struct dram_config *config)
>>>> +static bool mctl_phy_write_leveling(const struct dram_para *para,
>>>> +				    const struct dram_config *config)
>>>>    {
>>>>    	bool result = true;
>>>>    	u32 val;
>>>>    	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0xc0, 0x80);
>>>> -	writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
>>>> -	writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
>>>> +
>>>> +	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
>>>> +		/* MR2 value */
>>>> +		writel(0x1b, SUNXI_DRAM_PHY0_BASE + 0xc);
>>>> +		writel(0, SUNXI_DRAM_PHY0_BASE + 0x10);
>>>> +	} else {
>>>> +		writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
>>>> +		writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
>>>> +	}
>>>>    	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 4);
>>>> @@ -859,9 +867,9 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
>>>>    		}
>>>>    		break;
>>>>    	case SUNXI_DRAM_TYPE_LPDDR4:
>>>> -		if (para->tpr2 & 1) {
>>>> -			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
>>>> -		} else {
>>>> +		writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
>>>> +		if (config->ranks == 2) {
>>>> +			val = (para->tpr10 >> 11) & 0x1e;
>>>>    			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
>>>>    		};
>>>>    		break;
>>>> @@ -949,6 +957,8 @@ static bool mctl_phy_init(const struct dram_para *para,
>>>>    		break;
>>>>    	case SUNXI_DRAM_TYPE_LPDDR4:
>>>>    		val = para->tpr6 >> 24 & 0xff;
>>>> +		if (!val)
>>>> +			val = 0x33;
>>> We don't need this as the default value from
>>> arch/arm/mach-sunxi/Kconfigcovers
>>> this case:
>>>
>>> config DRAM_SUN50I_H616_TPR6
>>> hex "H616 DRAM TPR6 parameter"
>>> default 0x3300c080
>>>
>>>>    		break;
>>>>    	case SUNXI_DRAM_TYPE_DDR4:
>>>>    	default:
>>>> @@ -1080,19 +1090,27 @@ static bool mctl_phy_init(const struct dram_para *para,
>>>>    		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>>>>    		writel(0xb04, &mctl_ctl->mrctrl1);
>>>> +		udelay(10);
>>>>    		writel(0x80000030, &mctl_ctl->mrctrl0);
>>>> +		udelay(10);
>>>>    		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>>>>    		writel(0xc72, &mctl_ctl->mrctrl1);
>>>> +		udelay(10);
>>>>    		writel(0x80000030, &mctl_ctl->mrctrl0);
>>>> +		udelay(10);
>>>>    		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>>>>    		writel(0xe09, &mctl_ctl->mrctrl1);
>>>> +		udelay(10);
>>>>    		writel(0x80000030, &mctl_ctl->mrctrl0);
>>>> +		udelay(10);
>>>>    		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>>>>    		writel(0x1624, &mctl_ctl->mrctrl1);
>>>> +		udelay(10);
>>>>    		writel(0x80000030, &mctl_ctl->mrctrl0);
>>>> +		udelay(10);
>>> Looks like something experimental.
>> Should I remove it? Sorry but I'm not super familiar with this specific
>> code.

Unfortunately, I don't know what exactly these changes should change. I 
think it would be right to add only the necessary changes for adding a 
new device. Some devices that use this driver have not been tested yet. 
I think the rest of the changes can be prepared by Jernej when he has time


