Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0216FC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 05:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A35878A5;
	Fri, 12 Jan 2024 06:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TCvJIZcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3151E874CC; Fri, 12 Jan 2024 06:29:35 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98457878A5
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 06:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40C5TFSc034411;
 Thu, 11 Jan 2024 23:29:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705037355;
 bh=bb61htvXhY2a7wGjJSgUV7LsJ4+W5dztrG6LKp4jZos=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TCvJIZcDqg44olKf+3HsfXjVlUahEyZczK9E9+1pquaAvnDCFB8/+XogBqpuyfpah
 dpA7ch/M3jucQeUIZjB0T46P6V56m3DPURrqcpVBPaKzwdM0JjFKKfleGMd+UvfU4v
 POIlESSu4srbqGPM62zWBapJw9yAoSV/2z4jTK4o=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40C5TFxK006188
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 23:29:15 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 23:29:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 23:29:15 -0600
Received: from [172.24.227.70] (a0503533.dhcp.ti.com [172.24.227.70])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40C5RdcO104577;
 Thu, 11 Jan 2024 23:29:12 -0600
Message-ID: <39ce3cd8-a96b-4981-9ad4-1860a8b519fe@ti.com>
Date: Fri, 12 Jan 2024 10:59:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH V6 00/10] Update SPL splashscreen framework
 for AM62x
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <devarsht@ti.com>,
 <vigneshr@ti.com>, <nsekhar@ti.com>, <sjg@chromium.org>,
 <samuel@dionne-riel.com>
References: <20230718085736.17337-1-n-jain1@ti.com>
 <CAMty3ZBPuYFwQTFT9JwwETGdLSvz1i6NvYFsTcv0SV1iVOjQYQ@mail.gmail.com>
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <CAMty3ZBPuYFwQTFT9JwwETGdLSvz1i6NvYFsTcv0SV1iVOjQYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jagan,

On 11/01/24 15:50, Jagan Teki wrote:
> Hi Nikhil,
>
> On Tue, Jul 18, 2023 at 2:27 PM Nikhil M Jain <n-jain1@ti.com> wrote:
>> This patch series aims at updating SPL splashscreen framework for AM62x.
>>
>> This patch series depends on
>> https://lore.kernel.org/u-boot/20230504225829.2537050-1-sjg@chromium.org/
>>
>> This series:
>> - Fixes compilation issues in case splash related configs are not
>>   defined in SPL.
>> - Does page table setup, dram initialisation and dcache enabling in
>>   one function call spl_enable_dcache.
>> - Allows passing of framebuffer from spl to u-boot, eliminating flicker.
>>
>> V6:
>> - Add patch [1] from Samuel Dionne-Riel fixing CMD_BMP/BMP dependecy.
>>
>> V5:
>> - Change A53 SPL DDR layout from ASCII table to tabular format.
>>
>> V4:
>> - Fix commit message.
>> - Introduce patch defining DDR layout in A53 SPL.
>> - Add Reviewed-by tags.
>>
>> V3:
>> - Fix spacing issues.
>> - Add Reviewed-by tag.
>> - Replace #if with if in patch
>>   common: spl: spl: Remove video driver
>> - Add link to updated memory map.
>>
>> V2:
>> - Update cover letter.
>> - Fix commit message.
>>
>> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20230709231810.633044-1-samuel@dionne-riel.com/
>>
>> Nikhil M Jain (9):
>>   common: spl: spl: Update stack pointer address
>>   arch: arm: mach-k3: common: Return a pointer after setting page table
>>   board: ti: am62x: evm: Update function calls for splash screen
>>   include: video: Reserve video using blob
>>   common: board_f: Pass frame buffer info from SPL to u-boot
>>   drivers: video: Kconfig: Add config remove video
>>   common: spl: spl: Remove video driver
>>   configs: am62x_evm_a53: Add bloblist address
>>   doc: board: ti: am62x_sk: Add A53 SPL DDR layout
>>
>> Samuel Dionne-Riel (1):
>>   common: Kconfig: Fix CMD_BMP/BMP dependency
> I'm trying to use this to print splash in SPL. Look like the SPL video
> is not initialized in a general way like U-Boot proper does via
> board_f.c  in reserve_video() correct? do you have your board code to
> initialize the video for SPL?
>
> Jagan.

Yes we do have a board code to initialize the video for SPL.

The video_setup function in the below patch initializes video driver

https://lore.kernel.org/u-boot/20230718085736.17337-4-n-jain1@ti.com/
Thanks,
Nikhil

