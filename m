Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B95C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 14:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E55240586;
	Tue, 15 Sep 2026 14:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uodkECI0cnYs; Tue, 15 Sep 2026 14:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F46E40564
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789481334;
	b=m9Mcdj27EGkpg8q26SJ9+V7p0bM/DtJCSCB74WtSPSP7QhsRNExvdLMgF4GZz/brA2g4
	 XkmHScPub0uC3sBztx83IsQX23N9orsCh4upOGGkvqBvqvhQ3mWmEVg8OHkZy+4LS7+CZ
	 jRL2WoAmhmJbdjXLEMo2z8C0cKaQ3z0BoCnzL9pDeR/EfN/WRG9cBN1pJvUgi80uJ4ltc
	 pZ5NpWs+b9QYMwJXt+Mwr8rK3lpAARcPmY6Jv7bDMfWVJ6OeUHyAK+/26RfHvNxULaBI4
	 95xAWWIv6ycri67awZPs6N23gNQxUhJ700Ol6jFVvU73tmCFH9qisSjZvsFtonhR92w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789481334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XJkax6aWETH5ySmsJdj5YTAljjuKRTMkeaDg+ISprUE=;
	b=G2x+H1lmSyhj8KHQNMEhX6YlqLBZcHFRxUxoS12BPJmKhOD9rUNZ9DNBot3ST+0WtV9H
	 zEzffeYXk4qvdJz7tVwwIIqU56pBZ6uIVNDYh9OBx1uYj4u2OWh1GMO9NG9qaWV4XWABv
	 fO8U6xB2PxL5m4oIyz7/VieuhrCM7AUG1w9eFPh3aJWw4PRV5wwY2mZvrEQs/wBYo8pR/
	 ku8nlWH8TAoWXy1XXWLq5DrybEbX3/q4+YdyE1o/DRChAfBH6TFOR0obGmnvhKvAq43eT
	 xhDQMJ6Z6JqxN0pnJXvPuL92Px6Dd7VXGOAanHb//NCnnlpCnvBFA4HhiLtygydwPZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789481334;
	bh=XJkax6aWETH5ySmsJdj5YTAljjuKRTMkeaDg+ISprUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f18WwLSDcH8JgQHjOWrSVFUZPpJA7bjMbzugNurOnlJjFqV3ffvBLWVyi7bBuOiIy
	 a38IMbUKtrYanRfjIfTyoky5gBKm2PXVEpVqa55G+McC5r0zXKm6vzXYrtETeue/lQ
	 z26VB80NVBPXh1KO1NohG4YSVIfTlU5FjSTJkVIW/xS6DK2tOubw+uHLbBoDZ39Qvo
	 EqBDgk7Strpqg5w5D4qjmK5Q8OFKTnm0Zw2Fo5CNtyq4XEWlGD0/Pbx3VSNhJ/JhJD
	 zdorHHNUSzswZwmdCAKH17cRhpnmhjAQVxHbJOOIE3cMsQhV3xsZquibi/3nnZ6XFl
	 /nnXAEkqQJmJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F46E40564;
	Tue, 15 Sep 2026 14:08:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD41F493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAAFE40090
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DmxFg7vqzWCI for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 14:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0CD794002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789481331;
 b=N4eA9Jrs4i4xoFy1QtU69ltM1soho1aU+LKjOJuFPJKg4w9+6ME4TCI/s6jcYjZ0qxKn
 1HS1Fjdp+xrdj+R8dfxHAQK04S/k4W1dUqL8558w10DEZ1aCefKNE0GI/37Qf80kdD2uN
 kjqnikklOYSQhM6ycgs4t4IiiYb7KrGKtUTgjDkEOXHUljtJYMPRClCtKRZelQwtd6gWW
 ZHkJM8vwS9XrCv42bDuQIJOvAbxSRF12aoqvRIUktBPF0N23XIuB9H/lmal35p86zbZf/
 dEoowwsHhUFo2YPVYcsvpaEB5ISi6xCJc+JiFuNrMe8l51B0jFABPxCF9McWCr7vTFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789481331;
 h=X-Greylist:Received-SPF:Received:Received:Received:DKIM-Signature:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=XJkax6aWETH5ySmsJdj5YTAljjuKRTMkeaDg+ISprUE=;
 b=MSKwqHnhZJEHAmfitgx48nqh9PRphQ2/cFDYyjeOWUuxCxRZjgAKb+IsO6tLAIS7SC5b
 cA1MuVPK8ACn/ULX1I1KzBn+T3DnuDPtcsfju+y9IfAHeChSlSn/skh95i2ZVt0LQz1iA
 AQ5t68vuH0GUZGRkVwGzM3WHR7a085kfWzVXHQMxHetAq9T55g2SFcqPCS/ZJt6wcUJsL
 iTjUav9qkL+rV81aeHY/1mvb5cN1CKtbOKcqcSfIe1eVtuFDKH7OXyuNXLi6yfmN23taM
 B9OhqDyv22hm08/mVNllZsp2tGerSpk+iTAeHLf2DhZ46P32o0Z1TQnM9u1UcWRtrww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="Fp5gwd/e"; 
 arc=none smtp.remote-ip=185.171.202.116
X-Greylist: delayed 529 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 15 Sep 2026 14:08:50 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Fp5gwd/e
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CD794002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:08:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 00259C5CD48;
 Tue, 15 Sep 2026 14:00:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6EEFC602B0;
 Tue, 15 Sep 2026 13:59:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E49F011C7AFEF; 
 Tue, 15 Sep 2026 15:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789480797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XJkax6aWETH5ySmsJdj5YTAljjuKRTMkeaDg+ISprUE=;
 b=Fp5gwd/eZWtrAr7CcHu6Pg9Bh+A3nYeKHbakMcJQtmGgdTJbr5B0gGFhMPHPvpi01s34tR
 XOVyzkHIaXhFG31yEWdoTBIpndrYp77iKbx9SbtcUOLV36BWSIWW56QNR2ZKLdyb6sI1N0
 kjRpYOyUiLbGrVignm+dgLgIjlidojqUkvWNMVarob4bYlpJUvEhVlG5Fxc74SSwqP3N6n
 b4oVerSUpu8Nw1ttFCM3E8exu6X3yc6ZWbwkwAxSUV4r8wohoo9YKji1+kXuDwBBzsSBEm
 DbhoJO3ymCUZEbFGmVif4rUvUD7D4GbHt3UtuQ4NLTweVpBXQLq9IzWUc+TNfQ==
Message-ID: <b5556ad4-dce0-445d-bbc5-bc6f27a52abb@bootlin.com>
Date: Tue, 15 Sep 2026 15:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200/J721e SOC
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-16-richard.genoud@bootlin.com>
 <989dd99c-c988-46bc-8833-8a6f3d651684@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <989dd99c-c988-46bc-8833-8a6f3d651684@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 07/09/2026 à 10:38, Kumar, Udit a écrit :
> 
> 
> On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
>> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
>>
>> Add support for resuming from suspend in board_init_f.
>> The resume state of the SOC is identified and lpm resume
>> sequence is followed accordingly.
>>
>> First, add the board specific part of the exit retention sequence for
>> k3-ddrss following the DDR resume sequence:
>>     - exit DDR from retention
>>     - de-assert the DDR_RET pin
>>     - restore DDR max frequency
>>     - exit DDR from low power
>>
>> Then:
>>     - Extract context address from devicetree and send to TIFS.
>>     - Power on the rproc cluster.
>>     - Replay the certificates attached to saved images of ATF and OPTEE.
>>     - Resume sequence for context restore and rproc resume.
>>     - Image entry to DM firmware.
>> (All those steps are done in do_resume())
>>
>> The context address area is firewalled by TIFS to protect it from
>> other hosts.
>>
>> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
>> Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> ---
>>   arch/arm/mach-k3/j721e/j721e_init.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
>> index f9af0288cf66..fce6702be687 100644
>> --- a/arch/arm/mach-k3/j721e/j721e_init.c
>> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
>> @@ -20,9 +20,12 @@
>>   #include <mmc.h>
>>   #include <remoteproc.h>
>>   #include <k3-avs.h>
>> +#include <power/pmic.h>
>> +#include <mach/k3-ddr.h>
>>   
>>   #include "../sysfw-loader.h"
>>   #include "../common.h"
>> +#include "../lpm-common.h"
>>   
>>   /* NAVSS North Bridge (NB) registers */
>>   #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03802000
>> @@ -46,6 +49,10 @@
>>   #define DEV_A72SS0_CORE0_ID 4
>>   #define DEV_A72SS0_CORE0_MSMC_CLK_ID 1
>>   
>> +/* DDR retention bits */
>> +#define DDR_RET_VAL BIT(1)
>> +#define DDR_RET_CLK BIT(2)
>> +
>>   #ifdef CONFIG_K3_LOAD_SYSFW
>>   struct fwl_data cbass_hc_cfg0_fwls[] = {
>>   #if defined(CONFIG_SOC_K3_J721E)
>> @@ -298,6 +305,7 @@ void board_init_f(ulong dummy)
>>   {
>>   	int ret;
>>   #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
>> +	struct k3_ddrss_regs regs;
>>   	struct udevice *dev;
>>   #endif
>>   	/*
>> @@ -410,6 +418,22 @@ void board_init_f(ulong dummy)
>>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>   	if (ret)
>>   		panic("DRAM init failed: %d\n", ret);
>> +
>> +	if (j7xx_board_is_resuming()) {
>> +		/*
>> +		 * The DDR resume sequence is:
>> +		 * - exit DDR from retention
>> +		 * - de-assert the DDR_RET pin
>> +		 * - restore DDR max frequency
>> +		 * - exit DDR from low power
>> +		 */
>> +		k3_ddrss_lpddr4_exit_retention(dev, &regs);
>> +		k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, DDR_RET_CLK, true);
>> +		k3_ddrss_lpddr4_change_freq(dev);
>> +		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
>> +
>> +		do_resume();
> 
> could you check, if caches can be enabled before do_resume() call
I've tested that on j7200 and j784s4, and it fails at resume:
U-Boot SPL 2026.10-rc2-00046-g31003eca655b-dirty (Sep 15 2026 - 15:52:55 +0200)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.12--v11.02.12 (Fancy Rat)')
Initialized 4 DRAM controllers
Skipping authentication on GP device
Starting ATF on ARM64 core...

[   82.967460] Enabling non-boot CPUs ...
ERROR:   Timeout waiting for thread RX_SECURE_TRANSPORT_CHANNEL_ID to fill
ERROR:   Thread RX_SECURE_TRANSPORT_CHANNEL_ID verification failed (-60)
ERROR:   Message receive failed (-60)
ERROR:   Failed to get response (-60)
ERROR:   Transfer send failed (-60)
ERROR:   Request to start core failed: -60
[   83.998938] psci: failed to boot CPU1 (-22)
[   84.003168] CPU1: failed to boot: -22
[   84.006989] Error taking CPU1 up: -22



> 
>> +	}
>>   #endif
>>   	spl_enable_cache();
> 
> 
> 
>>   
> 


