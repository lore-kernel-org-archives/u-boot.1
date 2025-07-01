Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1359C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 10:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C78482A76;
	Tue,  1 Jul 2025 12:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="ysfUls16";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="CxmozPge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D8C82B18; Tue,  1 Jul 2025 12:24:15 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6A781E13
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 12:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=instance-europe-west4-3j3h.prod.antispam.mailspamprotection.com; s=arckey;
 t=1751365450; 
 b=p1qml5S6bYXlAaCJYhou5f2fWs2lGBmAG5zcM6C8G92DpKwpMwGVer0uFHb/sqSxon/PXxBylJ
 JOAS+2fDbTixURZEsnXnix4SnkYo6iQ7RMYAUoa1IN3qF4XEV3Nf46G5r66ZbcW+lMWDIB5ydg
 E5NqpugXheImkOPBDhmz0bb2mEPhwNyG9Io9y9K6KclsS6oyt4FUz/YqLB1ezeBnX39LBHCAb5
 w5yH2NazVCD5oXPuv2FB095jpdbak72r+PjZg/G7E7gHUbpjyjo1BDEVDKgUPL8mPPxvFBe9Mk
 bbmqbUQVNcJK0T6XNoSu+8fvwmB4Q6M/DiptL/ku8Q0HwQ==;
ARC-Authentication-Results: i=1;
 instance-europe-west4-3j3h.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=instance-europe-west4-3j3h.prod.antispam.mailspamprotection.com; s=arckey;
 t=1751365450; 
 bh=U6SUEamUt/MbEkqDNTk2Z2mZJgLIxKQUnAHWgEjsnKQ=;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:In-Reply-To:
 Subject:Cc:To:From:Date:MIME-Version:DKIM-Signature:DKIM-Signature;
 b=HeRq7X1CZoYUqhXozk8hrJoOur/COrxAP4OZnbys8/a7xvtO09f/GSFjT9kYHauZ1wb7fL6JIW
 0dJ8BLfyLa9gn45DtF69sTjdIPXjL1ncVU9fgmqsuLWuYQ/v9uGhdZVbWpHJLnUUfDD1Rlg+Ht
 O+bhbdv7mod5Vo/iOQRZEc3rZu6tuVdN5erD250A8dSfCaIoVE9QfzyJLYf3cKc0n5+a0vFLg1
 knMmbLBMIJ0FV0yVPPxEKMCTke/Rc/F7oPC27XFrFJBsx/GXs9uKK84jib+KgjW14e9Ha0qH8b
 ZZR4wU8H42KpsTT87LwLFICbwRCYHb4jrJdG7Hd7CWZ9zQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To:From:Date:
 MIME-Version:Reply-To:List-Unsubscribe;
 bh=Ne3wE5zofYPu4hbNW99pbRQRCg1NJCsEWItP7QWOrKM=; b=ysfUls16Zof1oHa87SJmeqUT80
 HPMvx/1Bbjswzv1heZFmfu4Av/PjYRVxH0lKN+ISOJLjevsXCfacUUzugtkiE6RQ5tSQpSx2UXQyF
 hr4shJtpsv9NhEtbcLazssBLU/UdjLaXBkkODXFBtjUIOWqrvmbH25vWltoH3WdFuHr8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-3j3h.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1uWY9l-00000005WC5-0P0I
 for u-boot@lists.denx.de; Tue, 01 Jul 2025 10:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=Ne3wE5zofYPu4hbNW99pbRQRCg1NJCsEWItP7QWOrKM=; b=CxmozPge1rfbajhe/VeCDNo2rX
 XhYJxi+ufecfeZAQ1ED7V9ZeI1aHopV5ZFI5ONtoMujVyQnz0q1QIsdo443qOnuFcNt20wrnnEc3p
 TiTX8rmFx4yHmEvc8qKur64ioCLO0Bakc2WaO8uwNcdcFAt78O4lQHKTbUcYKQwUU0nA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]:48558
 helo=esm19.siteground.biz)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1uWY9g-000000005sA-0FkZ; Tue, 01 Jul 2025 10:24:00 +0000
MIME-Version: 1.0
Date: Tue, 01 Jul 2025 10:23:59 +0000
From: Francesco Valla <francesco@valla.it>
To: "Raghavendra, Vignesh" <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, trini@konsulko.com,
 afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, b-liu@ti.com, nm@ti.com,
 bb@ti.com
Subject: Re: [PATCH v7 00/10] Add falcon support for am62a, 62p and 62x
In-Reply-To: <3049d2ce-6303-4622-be6b-eebb47d21c45@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <2553134.XAFRqVoOGU@fedora.fritz.box>
 <3049d2ce-6303-4622-be6b-eebb47d21c45@ti.com>
Message-ID: <07418d43d2ac7ad4b2241e3c0f0bf390@valla.it>
X-Sender: francesco@valla.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: ad4b97aaeb342b1c69a09eba0eb0abbb
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1uWY9l-00000005WC5-0P0I-feedback@antispam.mailspamprotection.com
Authentication-Results: instance-europe-west4-3j3h.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Vignesh,

Il 2025-07-01 09:14 Raghavendra, Vignesh ha scritto:
> Hi Francesco
> 
> On 6/30/2025 7:35 PM, Francesco Valla wrote:
>> Hi Anshul,
>> 
>> On Tuesday, 3 June 2025 at 16:24:40 Anshul Dalal <anshuld@ti.com> 
>> wrote:
>>> This patch set adds support for falcon boot on AM62a, 62p and 62x by
>>> bypassing A53 SPL and U-boot.
>>> 
>>> Existing Boot flow:
>>> R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel
>>> 
>>> Updated flow:
>>> R5 SPL -> ATF -> Linux Kernel
>>> 
>>> ...
>> 
>> I tried this series on a custom device based on AM62P. While it's 
>> working
>> mostly fine, I noticed that PWM0 is not working after a falcon boot 
>> from
>> R5F, while it was working correctly after a boot through full U-Boot.
>> 
>> After a bit of debugging, I noticed that the epwm_tbclk0 is marked as
>> disabled in hardware in debugfs's clk_summary even if enabled by 
>> software:
>> 
>>  $ head -n 2 /sys/kernel/debug/clk/clk_summary && cat 
>> /sys/kernel/debug/clk/clk_summary | grep pwm
>> 
>>                                  enable  prepare  protect              
>>                   duty  hardware                            connection
>>    clock                          count    count    count        rate  
>>  accuracy phase  cycle    enable   consumer                         id
>>  clk:86:0                            0       0        0        
>> 250000000   0          0     50000      Y   23000000.pwm               
>>      fck
>>  epwm_tbclk2                         0       0        0        0       
>>     0          0     50000      N   deviceless                      
>> no_connection_id
>>  epwm_tbclk1                         0       0        0        0       
>>     0          0     50000      N   deviceless                      
>> no_connection_id
>>  epwm_tbclk0                         1       1        0        0       
>>     0          0     50000      N   23000000.pwm                    
>> tbclk
>> 
>> 
>> Reading the associated register (0x00104130) returns in fact 
>> 0x00000000,
>> while writing to it has no effect (and after a write the register 
>> reads
>> back as 0x00000000).
>> 
>> 
>> Do you have any idea on the reason of this behaviour? I don't think it 
>> is
>> directly related to the Falcon boot implementation, but probably a 
>> side
>> effect of it (maybe something that was enabled by A53 SPL?).
>> 
> 
> My guess is that CTRL_MMR region which hosts TB_CLKEN isn't unlocked.
> 
> We unlock the CTRL_MMR here:
> https://elixir.bootlin.com/u-boot/v2025.04/source/arch/arm/mach-k3/am62px/am62p5_init.c#L156
> 
> But its possible that DM firmware that runs after R5 SPL re-locks these
> registers and Linux is no longer able to write to those registers.
> So this may need fix in the DM firmware to keep these regions unlocked.
> 
> Looking at address of tbclk (0x00104130), it should be under region 4.
> Could you try after running the equivalent of
> mmr_unlock(CTRL_MMR0_BASE, 4); at Linux prompt using devmem2 and then 
> modify the TB_CLKEN?
> 

that was exactly the issue, after unlocking the CTRL_MMR region the
TB_CLKEN bits wrote correctly and the PWM started working again.
According to TRM, the correct region is number 1.

These were the issued commands to unlock the CTRL_MMR region 1:

  $ devmem2 0x105008 w 0x68EF3490
  $ devmem2 0x10500C w 0xD172BC5A

and then to write TB_CLKEN for PWM channel 0:

  $ devmem2 0x00104130 w 0x1

The clock then is marked as enabled also from a hardware point of view:

  $ head -n 2 /sys/kernel/debug/clk/clk_summary && cat 
/sys/kernel/debug/clk/clk_summary | grep pwm

                                  enable  prepare  protect                
                 duty  hardware                            connection
    clock                          count    count    count        rate   
accuracy phase  cycle    enable   consumer                         id
  epwm_tbclk2                         0       0        0        0         
   0          0     50000      Y   deviceless                      
no_connection_id
  epwm_tbclk1                         0       0        0        0         
   0          0     50000      N   deviceless                      
no_connection_id
  epwm_tbclk0                         1       1        0        0         
   0          0     50000      N   23000000.pwm                    tbclk
  clk:86:0                            0       0        0        250000000 
   0          0     50000      Y   23000000.pwm                    fck


What's the correct path to issue a bug for the DM firmware?

Thank you!

Regards,
Francesco
