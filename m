Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A9C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 09:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7856681E13;
	Tue,  1 Jul 2025 11:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W87s+IjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E53481FEE; Tue,  1 Jul 2025 11:15:15 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9A28006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 11:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5619F2x93585790;
 Tue, 1 Jul 2025 04:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751361302;
 bh=rMOCB8xGJGJdXLR8zm4DC3+E4+AvXDIgLe3sa+HAMlA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W87s+IjG3/AiPWRn/FE2zpaIcJkYNdegPB1nQQ3UAMOvKIBZnBq5e5dTWYpKw6ED6
 8TFLuOKrcYSnJHUBR+hZc9sjRhdidfrGvze54Y9yBOQjn2msvDaC5J8nfwLSak3yxW
 0II9AyhsgdpvkVeXc5yQ4PaVsb8xSitoyOHsl9UM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5619F2Mv2424911
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 1 Jul 2025 04:15:02 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 1
 Jul 2025 04:15:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 1 Jul 2025 04:15:01 -0500
Received: from [172.24.30.31] (lt5cg1457vgj.dhcp.ti.com [172.24.30.31])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5619Ewvi1298168;
 Tue, 1 Jul 2025 04:14:58 -0500
Message-ID: <3049d2ce-6303-4622-be6b-eebb47d21c45@ti.com>
Date: Tue, 1 Jul 2025 14:44:57 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 00/10] Add falcon support for am62a, 62p and 62x
To: Francesco Valla <francesco@valla.it>, <u-boot@lists.denx.de>, Anshul Dalal
 <anshuld@ti.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <2553134.XAFRqVoOGU@fedora.fritz.box>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <2553134.XAFRqVoOGU@fedora.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Francesco

On 6/30/2025 7:35 PM, Francesco Valla wrote:
> Hi Anshul,
> 
> On Tuesday, 3 June 2025 at 16:24:40 Anshul Dalal <anshuld@ti.com> wrote:
>> This patch set adds support for falcon boot on AM62a, 62p and 62x by
>> bypassing A53 SPL and U-boot.
>>
>> Existing Boot flow:
>> R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel
>>
>> Updated flow:
>> R5 SPL -> ATF -> Linux Kernel
>>
>> ...
> 
> I tried this series on a custom device based on AM62P. While it's working
> mostly fine, I noticed that PWM0 is not working after a falcon boot from
> R5F, while it was working correctly after a boot through full U-Boot.
> 
> After a bit of debugging, I noticed that the epwm_tbclk0 is marked as
> disabled in hardware in debugfs's clk_summary even if enabled by software:
> 
>  $ head -n 2 /sys/kernel/debug/clk/clk_summary && cat /sys/kernel/debug/clk/clk_summary | grep pwm
> 
>                                  enable  prepare  protect                                duty  hardware                            connection
>    clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>  clk:86:0                            0       0        0        250000000   0          0     50000      Y   23000000.pwm                    fck                      
>  epwm_tbclk2                         0       0        0        0           0          0     50000      N   deviceless                      no_connection_id         
>  epwm_tbclk1                         0       0        0        0           0          0     50000      N   deviceless                      no_connection_id         
>  epwm_tbclk0                         1       1        0        0           0          0     50000      N   23000000.pwm                    tbclk
> 
> 
> Reading the associated register (0x00104130) returns in fact 0x00000000,
> while writing to it has no effect (and after a write the register reads
> back as 0x00000000).
> 
> 
> Do you have any idea on the reason of this behaviour? I don't think it is
> directly related to the Falcon boot implementation, but probably a side
> effect of it (maybe something that was enabled by A53 SPL?).
> 

My guess is that CTRL_MMR region which hosts TB_CLKEN isn't unlocked. 

We unlock the CTRL_MMR here: 
https://elixir.bootlin.com/u-boot/v2025.04/source/arch/arm/mach-k3/am62px/am62p5_init.c#L156

But its possible that DM firmware that runs after R5 SPL re-locks these
registers and Linux is no longer able to write to those registers. 
So this may need fix in the DM firmware to keep these regions unlocked.

Looking at address of tbclk (0x00104130), it should be under region 4. 
Could you try after running the equivalent of 
mmr_unlock(CTRL_MMR0_BASE, 4); at Linux prompt using devmem2 and then modify the TB_CLKEN? 


[...]

Regards
Vignesh

