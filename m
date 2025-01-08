Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BADBE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 22:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9F6800D0;
	Wed,  8 Jan 2025 23:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="weT+O4TK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1170F800D0; Wed,  8 Jan 2025 23:47:29 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966A28006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 23:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 508MlOJq129940;
 Wed, 8 Jan 2025 16:47:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736376444;
 bh=4dE5z6UPI1NAQoexp85Vmv2bm8ly5zk6g2JfqUY8gXY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=weT+O4TKssW+901Qy7/vXRDlxgreexy+5uM8FhTeTy537I5Q2AgoKA9eGEJ4IF+ld
 qevCODfjnk75W6gOPAzur+CHEqiXzgvWuwo1Gk831ZKPBjTr84fFiuW6QkGv/6mL/H
 AjD7HJOgbjAFYwEoV2/Pwh9Si8cFAXY3GLZSiihA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 508MlOQe093420;
 Wed, 8 Jan 2025 16:47:24 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Jan 2025 16:47:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Jan 2025 16:47:23 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 508MlNXd033806;
 Wed, 8 Jan 2025 16:47:23 -0600
Message-ID: <0bd2634c-a741-42bf-a3dc-0e967f720eed@ti.com>
Date: Wed, 8 Jan 2025 16:47:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] am335x* defconfig: Increase u-boot partition in
 mtdparts
To: Tom Rini <trini@konsulko.com>
CC: "Andrew F . Davis" <afd@ti.com>, Hong Guan <hguan@ti.com>, Paul
 Kocialkowski <contact@paulk.fr>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
References: <20250107225055.592941-1-jm@ti.com>
 <20250108165744.GJ3476@bill-the-cat>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250108165744.GJ3476@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Tom,

On 1/8/25 10:57 AM, Tom Rini wrote:
> On Tue, Jan 07, 2025 at 04:50:55PM -0600, Judith Mendez wrote:
> 
>> From: Hong Guan <hguan@ti.com>
>>
>> Fix u-boot NAND partition in MTDPARTS_DEFAULT since the size
>> of u-boot image has grown beyond 1MB and no longer fits in 1MB
>> NAND partition, thus we are failing to flash and boot via GPMC
>> NAND.
>>
>> Increase the size of NAND.u-boot to 2MB since the size of
>> u-boot.img is currently 1.4M.
>>
>> Signed-off-by: Hong Guan <hguan@ti.com>
>> [Judith: extend fix to HS defconfigs and add commit msg]
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> This patch is marked RFC to understand if solution is acceptable
>> since changing partition sizes will not be backwards compatible
>> solution.
>>
>> One other solution was too try to reduce the size of u-boot proper,
>> but removing features (boot modes.. etc) did not seem to get the
>> size of u-boot proper to 1MB with a usable u-boot proper.
> 
> So the big problem here is that we have more space being taken up by
> device trees than U-Boot itself. A quick mkimage -l and adding things up
> shows that we have 851936 bytes of device trees. You should look at
> switching to MULTI_DTB_FIT and enabling some compression, along with
> possibly LTO of U-Boot itself.
> 

Thanks so much for your feedback, I will look some more into this.

~ Judith

