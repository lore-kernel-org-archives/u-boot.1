Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3E3C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFCC879B0;
	Fri, 12 Jan 2024 14:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JU5sIlfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129CA879C7; Fri, 12 Jan 2024 14:06:35 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422C6877C8
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id CA41AB82253;
 Fri, 12 Jan 2024 13:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F9FC433C7;
 Fri, 12 Jan 2024 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705064792;
 bh=Xb2NLf3kqIReTzYhIGHVqIMLvGyGMeQS4+yAqOY0ozU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JU5sIlfNS6LSHQV4c/giUH997Q8fQaXEsyvQezYz7g/zEzFj5BLszB01O4bXjYCm7
 u2gi0dXGHG9fZTHuqemRV1k7zSiKXX7XGFnZRluQd9OV45jle9AjSLXEHbWgfOUlsh
 6nZvpnBWzIag3Lc+hncLjd1cp2TJd81Js622hL2VqdyTHUDhSQaQJiKgxvuUOcKDUA
 oV1RM7y7cez3ACYfPSrioNXfl2YoTyYzn8v/NqjCp1qWxA5GS3emXuK4I8KknJqssc
 822MOl4yI4tFIajFioL5ob4yrEL3vt93QWvG+Nqly3ZlpT7pqeRYAXrItc4juA41/W
 pN3RPc5MppXAA==
Message-ID: <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
Date: Fri, 12 Jan 2024 15:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: robertcnelson@gmail.com, trini@konsulko.com, marex@denx.de,
 n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240112130233.bflterluncjoyrhy@treadmill>
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



On 12/01/2024 15:02, Nishanth Menon wrote:
> On 14:49-20240112, Roger Quadros wrote:
>> Without correct SERDES MUX and Lane control settings
>> USB0 will be broken. Set the MUX and Lane control devices
>> to be auto probed so they are configured correctly.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> index f83caf7998..017a5a722e 100644
>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> @@ -165,6 +165,7 @@
>>  
>>  &serdes_ln_ctrl {
>>  	bootph-all;
>> +	u-boot,mux-autoprobe;
>>  };
>>  
>>  &serdes2_usb_link {
>> @@ -173,6 +174,7 @@
>>  
>>  &usb_serdes_mux {
>>  	bootph-all;
>> +	u-boot,mux-autoprobe;
>>  };
>>  
>>  &serdes_wiz2 {
>> -- 
>> 2.34.1
>>
> 
> Is this a u-boot thing? or a driver limitation?
> 

u-boot specific. We just want the mux driver to probe
and apply the settings.

from drivers/mux/mux-uclass.c

int dm_mux_init(void)
{
        struct uclass *uc;
        struct udevice *dev;
        int ret;

        ret = uclass_get(UCLASS_MUX, &uc);
        if (ret < 0) {
                log_debug("unable to get MUX uclass\n");
                return ret;
        }
        uclass_foreach_dev(dev, uc) {
                if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
                        ret = device_probe(dev);
                        if (ret)
                                log_debug("unable to probe device %s\n",
                                          dev->name);
                }
        }

        return 0;
}


-- 
cheers,
-roger
