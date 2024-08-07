Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC8EC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7339988CFD;
	Wed,  7 Aug 2024 15:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oAv4PRpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D243088BA5; Wed,  7 Aug 2024 14:41:30 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93DE88BA6
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so2267592a12.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034488; x=1723639288; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNojjHtZho3RgB5MMu1jLhKRPT7xZxFM0Bz6djppXXY=;
 b=oAv4PRpD4njMNl5Hau+Seg638Pc7Am7XBL1+kYnwotntJTp1pnUin7kzstiZyj7vtk
 l3xELnITdILTFFKRC8cVHgA3Wq7UiVTtAE7mRk6veOZmJjoC1nEIL+yeKDknP7XzB1xJ
 Aeq6ts4CbOGjuQTw+oLTzpnudQFC+Q9Nrm8pZZfVX1OwKRrUiBXyyciKuEh4h+EKHp+Q
 WNGpvvmrBzUJ/6R3uBrxiDiKItGMxWLf77B2sAlanIFWjy1Jgilnccan3rH46Syg+Z4h
 ENfB2O3QPOuxJW8NPXNNoMyYWzhJIWaLSYjE0odCvrxs+k1mvlieb2N6HmhaneYhuCPP
 RE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034488; x=1723639288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mNojjHtZho3RgB5MMu1jLhKRPT7xZxFM0Bz6djppXXY=;
 b=F+myUa+GRyVTDoa3RCaSZbpk7RFOiO7mj2jUgyfY5vg7z1nQJshBKg55msOEpwSHVX
 loW/kUnMicCXbJTXqD05fLEuWFoWWdijCbhOZTpzYDpnWcpjT7QsseE9iDK2cU2Shujl
 7ooxC87k17Q8nLAGO8Og1xKYdXvsmWa0xYaok5hGFr8csxs5cHL7ievuBalGE8ovMoJC
 77j6GPLdQyo90fagL80O6YiNdWFzGft3Df58vmZXZ0aWk6fD8PJ2dcsfEwdVsAA0klsw
 H466KBPHICzk6IKl8aoHEVf7TbuHh9qKNrjmPt/4YpUDdGn7AI4gNv6dR7ZDXrqsVfCV
 SkSA==
X-Gm-Message-State: AOJu0YykTdyNK7brICs1KHc/UiLcD3GDntpd3ndyx5FT0pYDO9cZB8wA
 C+6oNadR8PZhaizaQyhur2DKzrFNgrERE67DrXBIeQmqkhYhDMfiFIifQmlcscc=
X-Google-Smtp-Source: AGHT+IG9OZWfL0vzJghgGDRgS5zfyRV37fP5yK95Otb8sMMP1jwHapXXhOWRqOp20kzrbvGvgh9b+A==
X-Received: by 2002:a05:6402:f89:b0:5a1:a469:4d9b with SMTP id
 4fb4d7f45d1cf-5b7f3bcf900mr12526839a12.13.1723034488055; 
 Wed, 07 Aug 2024 05:41:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3c20:d905:6027:2354?
 ([2a01:e0a:3cb:7bb0:3c20:d905:6027:2354])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bb977d661esm1997695a12.28.2024.08.07.05.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 05:41:27 -0700 (PDT)
Message-ID: <9d9978ab-d198-459c-acae-86141039692b@linaro.org>
Date: Wed, 7 Aug 2024 14:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/20] net-lwip: add DHCP support and dhcp commmand
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Gilles Talis
 <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>, Petr Zejdl <petr.zejdl@cern.ch>,
 Shiji Yang <yangshiji66@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Artur Rojek <artur@conclusive.pl>,
 Sean Anderson <sean.anderson@seco.com>, Neal Gompa <neal@gompa.dev>,
 Janne Grunau <j@jannau.net>, Yang Xiwen <forbidden405@outlook.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Robert Marko <robert.marko@sartura.hr>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <46b1fff7bc5088c1b7dfc75a4faca8b229749c68.1722615735.git.jerome.forissier@linaro.org>
 <20240802193328.GP3794063@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240802193328.GP3794063@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 Aug 2024 15:44:15 +0200
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



On 8/2/24 21:33, Tom Rini wrote:
> On Fri, Aug 02, 2024 at 06:26:35PM +0200, Jerome Forissier wrote:
> 
>> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
>> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
>> to this code having an implicit dependency on do_tftpb().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> [snip]
>> diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
>> index 9a70c6095b3..c2492b69a13 100644
>> --- a/lib/tiny-printf.c
>> +++ b/lib/tiny-printf.c
>> @@ -269,7 +269,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
>>  				}
>>  				break;
>>  			case 'p':
>> -				if (CONFIG_IS_ENABLED(NET) || _DEBUG) {
>> +				if (!CONFIG_IS_ENABLED(NO_NET) || _DEBUG) {
>>  					pointer(info, fmt, va_arg(va, void *));
>>  					/*
>>  					 * Skip this because it pulls in _ctype which is
> 
> This is subtly wrong, and you can see for example that _vsprintf grows
> in TPL in pinephone-pro-rk3399.
> 

I see. I wrongly believed that !NO_NET was the same as (NET || NET_LWIP)
since it is a Kconfig choice with only 3 options. But that was ignoring
the SPL/TPL complexity :-/
I will replace all tests on NO_NET with tests on (NET || NET_LWIP) in v8.


Thanks,
-- 
Jerome
