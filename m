Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E8CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 06:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C171586C83;
	Tue,  7 Nov 2023 07:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OFvybBAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA8886C56; Tue,  7 Nov 2023 07:13:08 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B407186C56
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 07:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A76CweX079898;
 Tue, 7 Nov 2023 00:12:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699337578;
 bh=jBehKrW9fGJlqnBpSoKl/b7XYjx+oKh2NLl95GfcJrc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OFvybBAXV6YbZMlZqdcJsj6zhQqVfTGtBAu7E6WNDHbK9twJfuCNEdhp1yVxbJwvC
 YB7PA7Xe2CDO8PLhcwX8fCQIJn7AfpXBc+sSGA6KzEUz2jHcSe/BESZQF26pPhksFj
 b1QoMKcDSIluDjeHYvQjOjjv+JzPJUfV0XV32XZg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A76CwP3029346
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 00:12:58 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 00:12:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 00:12:58 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A76CsLM010050;
 Tue, 7 Nov 2023 00:12:55 -0600
Message-ID: <0bb13b15-0f53-4e73-b877-13f271f88dbb@ti.com>
Date: Tue, 7 Nov 2023 11:42:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] board: beagle: Add BeagleBone AI-64 support
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104081103.10607-1-nm@ti.com>
 <20231104081103.10607-3-nm@ti.com>
 <5ef0f949-2ccc-4871-8c3a-3dccc76fca37@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <5ef0f949-2ccc-4871-8c3a-3dccc76fca37@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Andrew,

On 06/11/23 22:34, Andrew Davis wrote:
> On 11/4/23 3:11 AM, Nishanth Menon wrote:
>> Add base support for BeagleBone AI-64 board support.
>>
>> Further information at  https://beagleboard.org/ai-64
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig                      |    1 +
>>   board/beagle/beagleboneai64/Kconfig           |   59 +
>>   board/beagle/beagleboneai64/Makefile          |   10 +
>>   board/beagle/beagleboneai64/beagleboneai64.c  |   30 +
>>   .../beagle/beagleboneai64/beagleboneai64.env  |   19 +
>>   board/beagle/beagleboneai64/board-cfg.yaml    |   36 +
>>   board/beagle/beagleboneai64/pm-cfg.yaml       |   12 +
>>   board/beagle/beagleboneai64/rm-cfg.yaml       | 3174 +++++++++++++++++
> 
> 95% of this patch is just copy/pasting the board-config yaml files. Same
> for other K3-based boards. I'd expect in practice these files to be near
> completely common between boards using the same SoC. Would be nice to
> inlcude a default .yaml from aarch/arm/mach-k3/<soc> and only override
> the couple options one wants changed for their board.
> 
> Neha,
> 
> Is the above something you would be able to help with? I'm a bit out of my
> element with all this board config schema stuff..
> 

Right, apart from the rm-cfg files, everything else is very similar even across 
SoCs. I think we can take action to have a default YAML for each SoC.

> Thanks,
> Andrew
> 
>>   board/beagle/beagleboneai64/sec-cfg.yaml      |  380 ++
>>   9 files changed, 3721 insertions(+)
>>   create mode 100644 board/beagle/beagleboneai64/Kconfig
>>   create mode 100644 board/beagle/beagleboneai64/Makefile
>>   create mode 100644 board/beagle/beagleboneai64/beagleboneai64.c
>>   create mode 100644 board/beagle/beagleboneai64/beagleboneai64.env
>>   create mode 100644 board/beagle/beagleboneai64/board-cfg.yaml
>>   create mode 100644 board/beagle/beagleboneai64/pm-cfg.yaml
>>   create mode 100644 board/beagle/beagleboneai64/rm-cfg.yaml
>>   create mode 100644 board/beagle/beagleboneai64/sec-cfg.yaml
>>

[...]

-- 
Thanking You
Neha Malcom Francis
