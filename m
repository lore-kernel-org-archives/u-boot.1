Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9781AC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 06:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61A288516;
	Thu, 20 Jun 2024 08:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H3XcLWjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AB088520; Thu, 20 Jun 2024 08:25:23 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F846884F9
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 08:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=c-shilwant@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45K6PDwK075754;
 Thu, 20 Jun 2024 01:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718864713;
 bh=nLOaIolISU/dD0uiHGgUqz4en8zaNnYjvjrvUanKWl8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=H3XcLWjtFlHngu+NX5ZNHjjAGzLRdlHIRp3dt+rc3MVp+fDqM2DpzbONRJOj3sSia
 BKgKMw6DJVeIYSvwEWA4pJgccK57oy0tRJEGwY6VvtKFF17nL9eOUSd7ebzPQ2mMl/
 QIz4A6AfP+TLKDBAus8cya5RJ7grcbxzVp+sMsmU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45K6PDBO013983
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Jun 2024 01:25:13 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jun 2024 01:25:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jun 2024 01:25:13 -0500
Received: from [172.24.227.238] (chirag-hp-z2-tower-g5-workstation.dhcp.ti.com
 [172.24.227.238])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45K6PA1L014783;
 Thu, 20 Jun 2024 01:25:11 -0500
Message-ID: <0777668e-37dd-49c8-9255-8a2a9b8bc8da@ti.com>
Date: Thu, 20 Jun 2024 11:55:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: beagle: beagleplay: enable OF_SYSTEM_SETUP
To: <u-boot@lists.denx.de>
CC: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>, Dhruva Gole
 <d-gole@ti.com>, Andrew Davis <afd@ti.com>
References: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
 <3f540efd-d428-49e3-bf48-de1e35dd41c3@ti.com>
 <20240620055103.jhn4krwido7nqbwr@dhruva>
Content-Language: en-US
From: Chirag Shilwant <c-shilwant@ti.com>
In-Reply-To: <20240620055103.jhn4krwido7nqbwr@dhruva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 20/06/24 11:21, Dhruva Gole wrote:
> On Jun 19, 2024 at 15:44:41 -0500, Andrew Davis wrote:
>> On 6/19/24 2:12 PM, Bryan Brattlof wrote:
>>> Unfortunately when enabling FDT fixups for the AM62x family of SoCs and
>>> moving TF-A to the bottom of RAM we missed the BeaglePlay. This is
>>> causing Linux's memory allocator to clobber TF-A and break its boot.
>>>
>>> Enable OF_SYSTEM_SETUP to fixup the kernel's FDT to inform it of the
>>> actual location of the firmware
>>>
>>> CC: Andrew Davis <afd@ti.com>
>>> CC: Nishanth Menon <nm@ti.com>
>>> CC: Robert Nelson <robertcnelson@gmail.com>
>>> Reported-by: Dhruva Gole <d-gole@ti.com>
>>> Signed-off-by: Bryan Brattlof <bb@ti.com>
>>> ---
>> Acked-by: Andrew Davis <afd@ti.com>


Acked-by: Chirag Shilwant <c-shilwant@ti.com>



>>> Hello everyone,
>>>
>>> Fair warning, this may turn into a philosophical discussion about the
>>> role of device-tree with SystemReady and U-Boot's role in enabling true
>>> distribution to be completely agnostic of the board it's running on.
>>>
>>> However substantively this is simply fixing a boot regression Dhruva
>>> found while testing out the beagleplay.
>>>
>>> Happy reviewing
>>> ~Bryan
>>> ---
>>>    board/beagle/beagleplay/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
>>> index 7dbd833acb4cc..896a1c1be3010 100644
>>> --- a/board/beagle/beagleplay/Kconfig
>>> +++ b/board/beagle/beagleplay/Kconfig
>>> @@ -12,6 +12,7 @@ config TARGET_AM625_A53_BEAGLEPLAY
>>>    	bool "BeagleBoard.org AM625 BeaglePlay running on A53"
>>>    	select ARM64
>>>    	select BINMAN
>>> +	select OF_SYSTEM_SETUP
> Thanks for the quick fix,
> Tested-by: Dhruva Gole <d-gole@ti.com>
>
> Boot logs upto kernel prompt:
> https://gist.github.com/DhruvaG2000/4dc1c1e42207dd98a144f27cc9dff177
>
