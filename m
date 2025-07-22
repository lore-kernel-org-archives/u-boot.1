Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF63FC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 14:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC5E83339;
	Tue, 22 Jul 2025 16:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qL6OMI3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F8283898; Tue, 22 Jul 2025 16:10:12 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D008805D7
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 16:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so2964245f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753193410; x=1753798210; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZbFOERsMUe6aQ6iefaYs6nYAF5FfSpfpC2cARj0+3e4=;
 b=qL6OMI3NpM5m+8CMrkfYreWTQ3BPM3vE1QNC1vzgPVpRPWL1xc5vsZOq2vmnhRzbIi
 XO8zZVfyfI3KJMsO0VfvqtBiDTvhDCI9CyEYSC2IzyzbFGL+t1uF9tPk0EtBRm2D4yBN
 zbY9zLXO2WLn9NgqoVSSR3zMc3wxg0LsGjtVu9oLiZcqNgBexU4hcN1nb/Uxbtx93rlh
 LBt1NmiDPQJdznFXwxN6xugy8JK0j5UVZs5gSPGzRBUR2642qqlwu9hzo4FnJtTGfi5f
 p8KXs97GsPBlG9wjzLWhR2eO0gSeQB7A9UaJkZLUS0dHjHusFFu/c4TXt5o6tZXv4+g2
 Ma8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753193410; x=1753798210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbFOERsMUe6aQ6iefaYs6nYAF5FfSpfpC2cARj0+3e4=;
 b=srDQ4TGUKxj3EHQDjtCNNbxuDJF2ifIeLiY8VKlzQ9PuJIxRewe+dlCk+Vph9cLLlR
 uPeHeKS+LHmKdMhMcnOtQl4jnrOOkEYY3vB7J14N1xSE9epUDPwX1UhbHwk6qSqx+Uv/
 SmN+kaH/xoqhiKGZU9oayEQbGNHpwgJH67EgDsH7TnKvaIoxsHs0DrN/ARaC2BuQ+cfe
 yef/ByjHFmC4JkIefPaXjWlgg8VIWn39dKrXEefiouIbWpjQUfAOkyJyaNDpScx3iBuX
 ko/X5UUpI8ogcjNRiNfWelSETkJ16Q5kzMf82xKurWQNiQHWO1G4em1/kATgJzgmRNxo
 v1QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJG1o5/tNArP9QmIn+H5ZjYp/M9+0o7Cq5TfKIZuH9GoT7P8EsFz3Dp/L+YMHPrB/qPdlDU28=@lists.denx.de
X-Gm-Message-State: AOJu0Yyae+ObNzS2Xe4+HdrDI5GHO50Pi7HUwHsl8feoRfFKCJKitidr
 Yx7ooItYAmjSxSpZ/hQA6e9WNQj+fU4NIxDr3B+vXcIkOzOGJJ+W2tEdOm2mfZD/yZ4=
X-Gm-Gg: ASbGnctjAdB+7eM6ChNR8CJ8v5p4AJ/kAQJVUqSd2NvoaZsdHfE9ioAvb3Kwut06ocj
 hUepUfKHPMTGSDqxaGWkI0ePMcmWsAPxme8jv9LkxVE/XGAl1+HNX66H3cMDEndGKz95rd+3K+/
 cKu2Iah55GHwTin8SyD9Dxn0vmQ773gdXvTbaxmpOsVO31bX4MyNfizN7ay67XpONCJqkzBBKzg
 5sCX4zRbLL4UDXDmKmBJpwtUeWTpTiXO5OpjcZJo9LYE4cAEtPwVrPRu99rH88bp70S1C6LhkRr
 abhAGDooXiG5Xbvfp3PEFlR+BMIysIP1JHCQsYw9wQYVxb6LGcExWP5EX4Wm4asIvZ8nrFUZH36
 K8ikalxt/c8c58+hqVapbZQESuB+cb/prUOQB0xqdgn2+yUTLA+94eYnSXIV2rCo=
X-Google-Smtp-Source: AGHT+IGyLzgWTVKH6JI6z8cls+CzrPqiQyNqE2eztCCtnbP2MCwIGXkhIRW1KZT91cSODRqILoR+aA==
X-Received: by 2002:a05:6000:26d3:b0:3a4:febd:39f2 with SMTP id
 ffacd0b85a97d-3b60e523ce1mr17980902f8f.37.1753193409960; 
 Tue, 22 Jul 2025 07:10:09 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c8besm13505706f8f.81.2025.07.22.07.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 07:10:09 -0700 (PDT)
Message-ID: <7105a92f-996c-493f-a093-c312fed9ac03@linaro.org>
Date: Tue, 22 Jul 2025 16:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Enable fastboot support for IPQ9574 based boards
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marek.vasut+renesas@mailbox.org,
 bhupesh.linux@gmail.com, alexeymin@postmarketos.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
 <7f4689e8-e727-438a-95c1-b1dd49890cea@linaro.org>
 <aHcxIj299SjS8wzG@hu-varada-blr.qualcomm.com>
 <cb99663c-07c7-4267-8cc9-d915e815bcf6@linaro.org>
 <aHn1VnPLEkha4XkX@hu-varada-blr.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aHn1VnPLEkha4XkX@hu-varada-blr.qualcomm.com>
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



On 18/07/2025 09:18, Varadarajan Narayanan wrote:
> On Thu, Jul 17, 2025 at 03:01:04PM +0200, Casey Connolly wrote:
>>
>>
>> On 16/07/2025 06:57, Varadarajan Narayanan wrote:
>>> On Tue, Jul 15, 2025 at 02:30:09PM +0200, Casey Connolly wrote:
>>>> Hi Varadarajan,
>>>>
>>>> On 7/15/25 12:15, Varadarajan Narayanan wrote:
>>>>> This series enables MMC based fastboot flashing for IPQ9574 boards.
>>>>> For this the following are added/enabled
>>>>> 	* USB2 & USB3 phys support
>>>>> 	* USB Gadget support, Fastboot-MMC related configs
>>>>> 	* Flashing related documentation
>>>>
>>>> This is awesome! Glad to see you have the superspeed phy working. I'm a bit
>>>> confused though since the of_fixup code in mach-snapdragon configures all
>>>> the usb controllers for high speed only and removes the reference to the
>>>> superspeed phy, is there some missing commit to adjust this?
>>>
>>> CONFIG_EVENT is not defined in ipq defconfig. Hence of_live_build() doesn't
>>> notify the EVT_OF_LIVE_BUILT event and qcom_of_fixup_nodes -> fixup_usb_nodes
>>> is not called.
>>
>> ohh I see, hmm
>>
>>>
>>> 	=> bdinfo
>>> 	. . .
>>> 	fdt_blob    = 0x000000006fe3b5e0
>>> 	. . .
>>>
>>> 	=> fdt addr 0x6fe3b5e0
>>> 	Working FDT set to 6fe3b5e0
>>>
>>> 	=> fdt print /soc@0/usb@8af8800
>>
>> Just fyi, the fdt command won't show changes to the live tree, it does
>> direct FDT parsing whereas the live-tree is an internal representation
>> in U-Boot (which is what makes it faster to access and modify).
> 
> ok
> 
> [ . . . ]
> 
>>> Initially, I manually overrode the 'phys' and 'phy-names' to just have the usb2
>>> phy and it didn't seem to work. Only after bringing up the USB3 phy did it work.
>>> Not sure what the relation is between the two.
>>
>> Hmm, you don't even get high speed USB? probably an issue with clocks then.
> 
> If 'qcom,select-utmi-as-pipe-clk;' is added to the controller DT node it
> works. Should I post a new version
> 
> 	(1) without SS phy + qcom,select-utmi-as-pipe-clk;
> 
> 		(or)
> 
> 	(2) with SS phy + qcom,select-utmi-as-pipe-clk; (i.e. same as
> 	    this series, with just utmi as pipe clock added)
> 
> 		(or)
> 
> 	(3) leave the series as is

sorry for the delayed reply! It would be awesome to get superspeed
working in U-Boot, if you have it working with this series then I'd like
to merge it and start enabling superspeed on the rest of the SoCs.

We can make the of_fixup code smarter by looking to see if there is a
driver available for the superspeed phy and skip the fixup if so (not
relevant for IPQ though I guess).

So I'd say keep the series as-is and I'll give it a review.

> 
> Kindly advice.
> 
> Thanks
> VaradaKind regards,

-- 
// Casey (she/her)

