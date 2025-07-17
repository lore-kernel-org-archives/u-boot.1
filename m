Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27185C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 13:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EC683323;
	Thu, 17 Jul 2025 15:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H82QCHaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC50833BF; Thu, 17 Jul 2025 15:01:09 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D715682BA7
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 15:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45629703011so7004645e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752757267; x=1753362067; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ywRGAwcjp8ZYwcJ7YKRGfQ7+aRI5PNAuQBIKhYnSR/Y=;
 b=H82QCHaGo7JHiBIyNkfYCkIoDSRqyY7ijZsFPvL42Nk+0osg+PhG4r8anJ/nZ+gUCK
 Iol078dugTubJZVACIdmDYZzSkMc7bJqBHrqPKv+XPCs758aiBNoGLWS/CziD170Kh3X
 9k5YtKTHizWvrAi+frt1xgmajggIIihfTx551gFgAJBcRdrf0Yvt6BOV0bhT56WjTdCi
 WQKt3o7o9SuuKvsBCUbV3TyiGMUAeK/WbKS+UU7OX/VrNXIUpDDp2AFuQ5NhHyI72nvI
 EvkzC/U73Ek68F//CuWgzK5NA0lSQcFrg1fmk9/KC9e3qXPQmZIuG9uTjq1oWwNuxVVl
 bTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752757267; x=1753362067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywRGAwcjp8ZYwcJ7YKRGfQ7+aRI5PNAuQBIKhYnSR/Y=;
 b=RXdi5r5/mlqY+KbCdAhvAssRl81A0AeF+eh4zLNmCwyklBm4LIM2erpqSVeID9v3f3
 d622GaTwRwuHjbWd4nb+JQfRVIqGp40rkNWPlDiISgB4ZU/R+uHSWqJUeUZABxRDyLmz
 kiZEp0LsHkjNuRxgl3XwrXvlNPG6gCQ2iCRTdzlCtDD2Bmhn/xGXBuIE/pYOnAF7ggo7
 dAZSMPC65yhJVYkICLZKx88n4uOS+eYuV1djuey+GZQbVL6CKIyUCMX4V50fXrECb9ce
 g2+jJFz/59Hr8XboVJT2G3z5eqoIXWlNE5j5W5NEcNy7I+LiI+eF3ZU0jVNPNuMHxE8d
 Ti3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKhREf5kdgU6znkTKJTiZ/E2+5NRrCf0i7WCGKFBBwAck5TEKLnmIl0X3peei2IobXFMuebnA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywv7IvR3KRRveJR6U/4cmhBQzjaugHJ6lTSRht+Ga8FPpAHBVKX
 6rYv+8HYpn0YKR7tmTmu9X0OAvkEfiukOnL02OkyFy4N4AMVdxdAX8tcOyjbByyLuX0=
X-Gm-Gg: ASbGncv1lEp2qgv57v71k31m4J+hD3w5yy+4ACSiOsaMU53Fv7IGQV9d7ayoBH8b6sK
 ZVG0GWsLKdmpi7I9AAHPiKj9YDrab0gK7gMvYXcexxkQWtAM9kUK06DK8+30T1lAPKvPTUakpvf
 8wCcCkpmDugn5Iwav1tEu91jhHze1DB/G3KMH5BMhTNyf2dItR/IgJf5VtUFX+3F/Wvt9BrFNpx
 5Gfri9R/r6MxXIoNdIW+flFX8NijLUg5OSHjVeaiGc4pV78Pvtx1rBzkV/J91dHl2w2/LDyhUKm
 P/2ELlGlGccbxOSHnmemkZ8rqbWivGpY2GxFykH5HnnVIpUYHfFzoiXUivg5Rd1WA7rn1LL7ZRl
 1d/97hLLXMa1HM5NScGArJP6sjTW/v14VUIsNU3Torewr4C9iN7o/U2sRB0xzAApn
X-Google-Smtp-Source: AGHT+IG8B1C1hMvhEcZI8gdlGEKYUHG2uK5XnVUClTUrJyiKx9vuUkEZSk7zzfsyz8xHnTUxsufM+A==
X-Received: by 2002:a05:600c:1546:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-4562e283d99mr51543495e9.23.1752757266836; 
 Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dcd2.dip0.t-ipconnect.de. [79.195.220.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f6c8c7sm21666255e9.18.2025.07.17.06.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 06:01:05 -0700 (PDT)
Message-ID: <cb99663c-07c7-4267-8cc9-d915e815bcf6@linaro.org>
Date: Thu, 17 Jul 2025 15:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Enable fastboot support for IPQ9574 based boards
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marek.vasut+renesas@mailbox.org,
 bhupesh.linux@gmail.com, alexeymin@postmarketos.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
 <7f4689e8-e727-438a-95c1-b1dd49890cea@linaro.org>
 <aHcxIj299SjS8wzG@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aHcxIj299SjS8wzG@hu-varada-blr.qualcomm.com>
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



On 16/07/2025 06:57, Varadarajan Narayanan wrote:
> On Tue, Jul 15, 2025 at 02:30:09PM +0200, Casey Connolly wrote:
>> Hi Varadarajan,
>>
>> On 7/15/25 12:15, Varadarajan Narayanan wrote:
>>> This series enables MMC based fastboot flashing for IPQ9574 boards.
>>> For this the following are added/enabled
>>> 	* USB2 & USB3 phys support
>>> 	* USB Gadget support, Fastboot-MMC related configs
>>> 	* Flashing related documentation
>>
>> This is awesome! Glad to see you have the superspeed phy working. I'm a bit
>> confused though since the of_fixup code in mach-snapdragon configures all
>> the usb controllers for high speed only and removes the reference to the
>> superspeed phy, is there some missing commit to adjust this?
> 
> CONFIG_EVENT is not defined in ipq defconfig. Hence of_live_build() doesn't
> notify the EVT_OF_LIVE_BUILT event and qcom_of_fixup_nodes -> fixup_usb_nodes
> is not called.

ohh I see, hmm

> 
> 	=> bdinfo
> 	. . .
> 	fdt_blob    = 0x000000006fe3b5e0
> 	. . .
> 
> 	=> fdt addr 0x6fe3b5e0
> 	Working FDT set to 6fe3b5e0
> 
> 	=> fdt print /soc@0/usb@8af8800

Just fyi, the fdt command won't show changes to the live tree, it does
direct FDT parsing whereas the live-tree is an internal representation
in U-Boot (which is what makes it faster to access and modify).

> 	usb@8af8800 {
> 		compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> 		reg = <0x08af8800 0x00000400>;
> 		#address-cells = <0x00000001>;
> 		#size-cells = <0x00000001>;
> 		ranges;
> 		clocks = <0x0000000c 0x0000005c 0x0000000c 0x0000005b 0x0000000c 0x0000005d 0x0000000c 0x000000d1 0x0000000c 0x00000060>;
> 		clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
> 		assigned-clocks = <0x0000000c 0x0000005b 0x0000000c 0x00000060>;
> 		assigned-clock-rates = <0x0bebc200 0x016e3600>;
> 		interrupts-extended = <0x00000001 0x00000000 0x00000086 0x00000004>;
> 		interrupt-names = "pwr_event";
> 		resets = <0x0000000c 0x0000002c>;
> 		status = "okay";
> 		usb@8a00000 {
> 			compatible = "snps,dwc3";
> 			reg = <0x08a00000 0x0000cd00>;
> 			clocks = <0x0000000c 0x00000060>;
> 			clock-names = "ref";
> 			interrupts = <0x00000000 0x0000008c 0x00000004>;
> 			phys = <0x0000001d 0x0000001e>;
> 			phy-names = "usb2-phy", "usb3-phy";
> 			tx-fifo-resize;
> 			snps,is-utmi-l1-suspend;
> 			snps,hird-threshold = [00];
> 			snps,dis_u2_susphy_quirk;
> 			snps,dis_u3_susphy_quirk;
> 			dr_mode = "peripheral";
> 		};
> 	};
> 
> Initially, I manually overrode the 'phys' and 'phy-names' to just have the usb2
> phy and it didn't seem to work. Only after bringing up the USB3 phy did it work.
> Not sure what the relation is between the two.

Hmm, you don't even get high speed USB? probably an issue with clocks then.

> 
> Thanks
> Varada

-- 
// Casey (she/her)

