Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A094EC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A78E80E9A;
	Wed,  2 Jul 2025 12:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oUHxlMdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DBA82103; Wed,  2 Jul 2025 12:01:15 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC29800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 562A1AKE3891407;
 Wed, 2 Jul 2025 05:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751450470;
 bh=TLzDixrgGeg5BM6dXMPD1YOkWYxB5QhHmYPo4xToelg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oUHxlMdAXNul3EvaCV/j88raOy4jU1xmx4TLYZ8NMtUgDGnQMQti2PRR8go1OqIqj
 KRdeEk/euGDZRjk68B+ttACczRH9Jh13muUijM3IvbeVIV3QLTxomjnKlG3cqdpi48
 OWotff3Q/vlgrMTNJpOxIZ3fD08Ijq399ytTNu5Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 562A1A0p3442696
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 2 Jul 2025 05:01:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 2
 Jul 2025 05:01:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 2 Jul 2025 05:01:09 -0500
Received: from [10.249.142.58] ([10.249.142.58])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 562A16mZ3221708;
 Wed, 2 Jul 2025 05:01:06 -0500
Message-ID: <66a408e7-3804-4efe-983f-159fa441f198@ti.com>
Date: Wed, 2 Jul 2025 15:31:06 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 00/10] Add falcon support for am62a, 62p and 62x
To: Francesco Valla <francesco@valla.it>
CC: <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <2553134.XAFRqVoOGU@fedora.fritz.box>
 <3049d2ce-6303-4622-be6b-eebb47d21c45@ti.com>
 <07418d43d2ac7ad4b2241e3c0f0bf390@valla.it>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <07418d43d2ac7ad4b2241e3c0f0bf390@valla.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi,

On 7/1/2025 3:53 PM, Francesco Valla wrote:
[...]

> 
> that was exactly the issue, after unlocking the CTRL_MMR region the
> TB_CLKEN bits wrote correctly and the PWM started working again.
> According to TRM, the correct region is number 1.
> 

Ah yes, sorry for the confusion

> These were the issued commands to unlock the CTRL_MMR region 1:
> 
>  $ devmem2 0x105008 w 0x68EF3490
>  $ devmem2 0x10500C w 0xD172BC5A
> 
> and then to write TB_CLKEN for PWM channel 0:
> 
>  $ devmem2 0x00104130 w 0x1
> 
> The clock then is marked as enabled also from a hardware point of view:
> 
>  $ head -n 2 /sys/kernel/debug/clk/clk_summary && cat /sys/kernel/debug/
> clk/clk_summary | grep pwm
> 
>                                  enable  prepare  protect               
>                 duty  hardware                            connection
>    clock                          count    count    count        rate  
> accuracy phase  cycle    enable   consumer                         id
>  epwm_tbclk2                         0       0        0        0        
>   0          0     50000      Y   deviceless                     
> no_connection_id
>  epwm_tbclk1                         0       0        0        0        
>   0          0     50000      N   deviceless                     
> no_connection_id
>  epwm_tbclk0                         1       1        0        0        
>   0          0     50000      N   23000000.pwm                    tbclk
>  clk:86:0                            0       0        0        250000000
>   0          0     50000      Y   23000000.pwm                    fck
> 
> 
> What's the correct path to issue a bug for the DM firmware?
> 

Thanks for the confirmation. I am tracking this internally with firmware
team. Will let you know once the fix is available.

> Thank you!
> 
> Regards,
> Francesco

