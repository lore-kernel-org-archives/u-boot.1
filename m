Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9730AC369AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 02:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6DAD8082A;
	Fri, 25 Apr 2025 04:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745547632;
	bh=9dDC4p2sxMfdwSpbFv7u8tRsPEjVkZNVrw6KAOL6QQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hf9H9rVkyxtw8ELyjPBrt/cJCXBhyw+zMhoy8hT14VWcidJ1Yi4/2tGCwlXD5ztxl
	 qz1zxmtfapgMs/zYoFen9DVSVplP6tu1pOgm97/qskykGb4bm0Xlqqo+Lr2swgLozn
	 Xvewdc+gAwuoW3cSl6MEmAD9XXOF5/Wd3h+yNDjHwwfSHwwyndf+QEODkK+6XyFnJ6
	 5lecKz3br5Wvk97VJNNOgiHdOnDClqMJYV8lzguVKyXQK5QEjhTTZWev3Io00hsiCf
	 4TfYr+LWGV6nhlJMwC6yw9L3JgsNrNTPDi2MJ7pYuh2b3jP/kP5B6IR5wZNDau6caB
	 24BZjr1CrTJiw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2979809D4; Fri, 25 Apr 2025 04:20:31 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C73B68059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gDFAMLSa"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C8CA102E13D0; 
 Fri, 25 Apr 2025 04:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745547628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=9dDC4p2sxMfdwSpbFv7u8tRsPEjVkZNVrw6KAOL6QQs=;
 b=gDFAMLSaGTnWuv1ftrqNNyBYLIIK6AsUI1l3phDPTOn+F26PgIRM9Gap2uZiNz2hMaqv64
 6+4ZN6pUAUPEUMz9+Jov6CUO7JdjYhyEecyzAA/6m3umNtachE7cbptq1XIOQNWJ0uRwgV
 ikchISfmWMCNY4G2h+UObp6cPmnuZplEo5cCWs26Qzf3UNs9EyPUqntluKBSUOkFkIfxTV
 pdxzM36c/SCQo4e9fclI1Pe9I28jwNyYUWveCO/ub8J9KoonrqnWxgaT0YAs/4N6PPF0Jk
 ua5Nvy5DiRS59wYdjUOTepQnxI7K9P7HCGSG0ZXpnzKINXeuZnLtqhzuSinzWg==
Message-ID: <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
Date: Fri, 25 Apr 2025 04:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/25/25 4:02 AM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Sun, Apr 20, 2025 at 4:20 PM Marek Vasut <marex@denx.de> wrote:
> 
>> Can you send that as a fix ?
>>
>> And also, fix this patch up and drop the bogus second half of the commit
>> message and do a V3.
> 
> Sorry for the delay.
> 
> I found another issue on an imx8mm-evk board.
> 
> U-Boot SPL 2025.04-01379-g10f48365112b-dirty (Apr 24 2025 - 22:56:59 -0300)
> No pmic
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> SEC0:  RNG instantiated
> Trying to boot from MMC1
> 
> (Pause here for about 3 seconds)
> 
> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> NOTICE:  BL31: v2.12.0(release):v2.12.0
> NOTICE:  BL31: Built : 15:28:24, Apr 24 2025
> 
> 
> U-Boot 2025.04-01379-g10f48365112b-dirty (Apr 24 2025 - 22:56:59 -0300)
> 
> CPU:   NXP i.MX8MMQ Rev1.0 A53 at 1200 MHz
> CPU:   Consumer temperature grade (0C to 95C) at 37C
> Model: FSL i.MX8MM EVK board
> DRAM:  2 GiB
> Core:  188 devices, 24 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... Reading from MMC(1)... OK
> In:    serial@30890000
> Out:   serial@30890000
> Err:   serial@30890000
> SEC0:  RNG instantiated
> Net:   eth0: ethernet@30be0000
> Hit any key to stop autoboot:  0
> u-boot=>
> 
> The issue above is the long pause after "Trying to boot from MMC1".
> 
> If I manually revert commit b4734c9c333b ("clk: imx: Convert
> clock-osc-* back to osc_*"), then it boots normally, without the long
> pause.
> 
> Applying your patch helped resolve the USB issue, but not the long pause issue.
Probably some timeout in the esdhc driver, maybe some clock are not 
enabled ? I don't see it on the MX8MP.

Did you already apply
Re: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24

?
