Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767E9FD4F07
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC661840EE;
	Tue, 10 Mar 2026 17:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b5VSGatJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D49984137; Tue, 10 Mar 2026 17:28:32 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9D7840EE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3598df39444so6164994a91.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773160108; x=1773764908; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1O/1v0n9j2mB7LDQk1Jpoqq/fHE7oSJ3HGGW4yrqbk=;
 b=b5VSGatJkGz5J6LOy9ypssSgyMsw3oQNFROpNdgXxRrMsw+7qGN6ag6AnF5x4cckhN
 tJs9g5YJNrOc1Lz8pjrJZb++cgzGIE+1nIvk6zvwK8CFoNkfD11c+3fODTKcVRotAx/t
 jv18nQIbMkVgTYKDV2Ix51rGAg6bpcQxPu/l0N/5eTu5YLDWaYFXukxQ7tjL4vHp0LXw
 JJEnqMz0a4/GjlMQ7h92rUu/N6Ixig44Ars+rKIeLZ3l7G1ysr+JZRJXBzFcvFrPtxl6
 5o3HB4T++2bbr8rjw+IVK8eZOoJ34EgXt8hS6v15tIi+Ehl+hiYAOg2mto/t6itD1C3E
 ssLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773160108; x=1773764908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1O/1v0n9j2mB7LDQk1Jpoqq/fHE7oSJ3HGGW4yrqbk=;
 b=Mik0NmV07Ka3lCZJ0tu3PMHIOYoqV1qKr3xjuEG4ILD2A0gaz3kAiaFdoxKF0+ltlG
 zRWaubfrfGsUsxhQoCW9LcbIEjwnyTFAuE3aUi6gJByNqb5yewnrGlkaE29G5wDhbkAh
 l5/uathiyhaENMYIzYJP81LGQBiqkiNo0ph7TX1C/gWGppfvdjeM7iUmwMvjklRhjVFx
 wir2YIw11utMNat1PqyNWGyiS3HBTSamGPn/62nGKPdNucn7MSHJUErR6iQ1aswLTVSC
 99z5JGBpuQhQ2Q0NzLT+VKL0yFmjBUuytYYWJLH41Awsd+1M4INKe4zA7dtiEgRJdqcQ
 076Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkRfuhEB8vhNb6sytg63XHZHK0uQARUWhokZYWanbmuhB8e+EdhEyQ0qhgoEtwxFkwEJDbOys=@lists.denx.de
X-Gm-Message-State: AOJu0YzE8A83e5e+UbmLM4+8UNmrrkRJdA19jALET/cFUbS1HxgZKh48
 TQu9DBUAqpAhTx3oyt6azUUvspJvDPz3sF4zFjWqsYSb7Ozc4LYTdXim
X-Gm-Gg: ATEYQzxCearg/8DZ6rhqnbhpbu/MAam2GYjqPlRHmzB5OsjXXRw+AqRvNwfHQNDwvo+
 VXdCflq7qOX99NMnrnp/dhHc6831a351a+DqwcIz0xJQxFoIyav6EWDWqJ0PIJYlbnNwtqxGAAc
 L450n8OTd3+zkQZs673nKq7S37AU33xKeFMyJIDldcYYJDevPGSf17+jbbo7ea9E/d50ULROunA
 MgNbq3hwnGsgxFUIa5uuqx9scTiQaR/IaNHWYpEYW6pDpr3EvXpxiBs+tBjxbXNckwgkrqppdh7
 gEUUxgH5PX7ulorZKyM1t+iy2qAKRMSpKTU8ebLzTkZoTc0G6qR0GkJhglkXphSamH7Ge0z+wUp
 1OjBoxLw0IOaipgo3MBq7jBaGlOUNim0ZD/7YM/3lIb5Q8iakBvr10ciijK7Sh63y4TSN51KOec
 AlLVkHge8dl8Hhg0FtBtXjBEtED8HKbOALytWt1hvoqRP5kl7TmHJAZ+f3NofDdOLdyYPdCfOYs
 OrfZ2aHYS4=
X-Received: by 2002:a17:903:2c50:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2ae82367c52mr150454825ad.5.1773160107999; 
 Tue, 10 Mar 2026 09:28:27 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83eaef2asm158109335ad.39.2026.03.10.09.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 09:28:27 -0700 (PDT)
Message-ID: <fccd3418-05c8-43cf-83b7-3a2500b449f6@gmail.com>
Date: Wed, 11 Mar 2026 00:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com, kabel@kernel.org,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de
References: <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-3-lucienzx159@gmail.com>
 <20260308140614.50489-3-lucienzx159@gmail.com>
 <20260310082847.sbo7aoqsohij62p3@skbuf>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260310082847.sbo7aoqsohij62p3@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Mar 2026 17:54:39 +0100
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


Vladimir Oltean 於 2026/3/10 下午 04:28 寫道:
> On Sun, Mar 08, 2026 at 10:06:14PM +0800, Lucien.Jheng wrote:
>> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
>> index 1a628ede82b..0ec11ba5231 100644
>> --- a/drivers/net/phy/airoha/air_en8811.c
>> +++ b/drivers/net/phy/airoha/air_en8811.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/compat.h>
>>   #include <dm/device_compat.h>
>>   #include <u-boot/crc.h>
>> +#include <linux/phy/phy-common-props.h>
>>
>>   #define EN8811H_PHY_ID		0x03a2a411
>>
>> @@ -660,11 +661,82 @@ static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
>>   	return 0;
>>   }
>>
>> -static int en8811h_config(struct phy_device *phydev)
>> +static int en8811h_config_polarity(struct phy_device *phydev)
>>   {
>> -	struct en8811h_priv *priv = phydev->priv;
>>   	ofnode node = phy_get_ofnode(phydev);
>> +	unsigned int rx_pol, tx_pol;
>>   	u32 pbus_value = 0;
>> +	int ret;
>> +	bool use_legacy = false;
>> +
>> +	if (!ofnode_valid(node))
>> +		return 0;
>> +
>> +	/* Try standard rx-polarity property first */
>> +	ret = phy_get_manual_rx_polarity(node,
>> +					 phy_interface_strings[phydev->interface],
>> +					 &rx_pol);
>> +	if (ret == 0) {
>> +		dev_info(phydev->dev, "EN8811H: RX polarity = %s\n",
>> +			 rx_pol == PHY_POL_INVERT ? "inverted" : "normal");
>> +		if (rx_pol == PHY_POL_INVERT)
>> +			pbus_value |= EN8811H_POLARITY_RX_REVERSE;
>> +		else
>> +			pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
>> +	} else if (ret == -ENOENT) {
>> +		/* Fall back to legacy airoha,pnswap-rx property */
>> +		use_legacy = true;
>> +		dev_info(phydev->dev, "EN8811H: Legacy RX polarity\n");
>> +
>> +		if (ofnode_read_bool(node, "airoha,pnswap-rx"))
>> +			pbus_value |= EN8811H_POLARITY_RX_REVERSE;
>> +		else
>> +			pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
>> +	} else {
>> +		dev_err(phydev->dev, "EN8811H: Error reading rx-polarity: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Try standard tx-polarity property first */
>> +	ret = phy_get_manual_tx_polarity(node,
>> +					 phy_interface_strings[phydev->interface],
>> +					 &tx_pol);
>> +	if (ret == 0) {
>> +		dev_info(phydev->dev, "EN8811H: TX polarity = %s\n",
>> +			 tx_pol == PHY_POL_INVERT ? "inverted" : "normal");
>> +		if (tx_pol == PHY_POL_INVERT)
>> +			pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
>> +		else
>> +			pbus_value |= EN8811H_POLARITY_TX_NORMAL;
>> +	} else if (ret == -ENOENT) {
>> +		/* Fall back to legacy airoha,pnswap-tx property */
>> +		if (!use_legacy)
>> +			dev_err(phydev->dev, "EN8811H: Mixing standard and legacy polarity properties\n");
> Mixing should be perfectly legal. Otherwise there's no way of converting
> an old scheme to the new one without breaking backwards compatibility.
>
> The way in which this is done in Linux is by reading the legacy
> properties first (with a fallback on PHY_POL_NORMAL if absent) and then
> using them as "default" argument for phy_get_(rx|tx)_polarity(). The
> phy_get_manual_(rx|tx)_polarity() are intended for the use case where
> you have no legacy property to support.
>
> I believe doing the same way here would simplify your logic quite a bit.
> No need to look at the specific "ret" value, and no need to duplicate
> the pbus_value modification.

Thank you for your comment.

I think I misinterpreted the code section.

I will re-examine the Linux implementation and refine my code accordingly.

>> +
>> +		dev_info(phydev->dev, "EN8811H: Legacy TX polarity\n");
>> +
>> +		if (ofnode_read_bool(node, "airoha,pnswap-tx"))
>> +			pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
>> +		else
>> +			pbus_value |= EN8811H_POLARITY_TX_NORMAL;
>> +	} else {
>> +		dev_err(phydev->dev, "EN8811H: Error reading tx-polarity: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Apply polarity configuration to hardware */
>> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
>> +				      EN8811H_POLARITY_RX_REVERSE |
>> +				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int en8811h_config(struct phy_device *phydev)
>> +{
>> +	struct en8811h_priv *priv = phydev->priv;
>>   	int ret = 0;
>>
>>   	/* If restart happened in .probe(), no need to restart now */
>> @@ -695,19 +767,8 @@ static int en8811h_config(struct phy_device *phydev)
>>   	if (ret < 0)
>>   		return ret;
>>
>> -	/* Serdes polarity */
>> -	pbus_value = 0;
>> -	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
>> -		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
>> -	else
>> -		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
>> -	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
>> -		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
>> -	else
>> -		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
>> -	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
>> -				      EN8811H_POLARITY_RX_REVERSE |
>> -				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
>> +	/* Configure Serdes polarity from device tree */
>> +	ret = en8811h_config_polarity(phydev);
>>   	if (ret < 0)
>>   		return ret;
>>
>> --
>> 2.34.1
>>
