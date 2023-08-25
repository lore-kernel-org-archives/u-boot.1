Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D76C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 08:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF0086A67;
	Fri, 25 Aug 2023 10:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="msjk1mxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC3886A57; Fri, 25 Aug 2023 10:22:56 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6FC86A15
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37P8MldD087717;
 Fri, 25 Aug 2023 03:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692951767;
 bh=Y/oNPunj9hgXQuFEFrfw3A7Mmg2DzzRWD9ohJ9lWENw=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=msjk1mxCYXzq0DSFzjPif151wCpVRoOIkN6yURrdoIALwJ/addQrZTvkn0xLRn7H+
 FHvSVf7LyZaaCpdVFne76UQFDgNWQG+HVoqSW/tcxcUVmFhAw6WgRCQeLzixCe6C5Q
 i0kL/yUSik+gtB1XKgka3+WRxv+DMJ9mHc0ILiv0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37P8MlIK017680
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 03:22:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 03:22:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 03:22:46 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37P8Mga2002529;
 Fri, 25 Aug 2023 03:22:43 -0500
Message-ID: <7b5ef454-0fd6-7311-894d-280b45b40247@ti.com>
Date: Fri, 25 Aug 2023 13:52:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 <nm@ti.com>, <joe.hershberger@ni.com>, <robertcnelson@gmail.com>,
 <jkridner@beagleboard.org>, <r-gunasekaran@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
 <20230824182431.GE3953269@bill-the-cat>
 <203072fb-c847-b896-a249-eabe3c2631a0@kernel.org>
 <76153dc4-07e7-3c9b-8c2f-4e50d70b1679@ti.com>
 <834b6e9b-6bfd-db10-5158-3100569400d7@kernel.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <834b6e9b-6bfd-db10-5158-3100569400d7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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



On 25/08/23 13:22, Roger Quadros wrote:
> Siddharth,
> 
> On 25/08/2023 08:42, Siddharth Vadapalli wrote:
>> Roger,
>>
>> On 25/08/23 00:39, Roger Quadros wrote:
>>>
>>>
>>> On 24/08/2023 21:24, Tom Rini wrote:
>>>> On Thu, Aug 24, 2023 at 11:34:29PM +0530, Siddharth Vadapalli wrote:
>>>>> Hello Roger,
>>>>>
>>>>> On 22-08-2023 17:43, Roger Quadros wrote:

...

>>
> 
> This doesn't sound like a clean solution.
> All hardware specific details (like reset ready-time) should come from the
> device tree and not passed around in PHY APIs.
> 
> Why to do such an intrusive change instead of fixing the am65-cpsw-nuss driver
> to properly use the PHY uclass driver model and encode the required delays
> in the device tree?

Encoding delays in device-tree and using them is better. Kindly ignore my
suggestion.

> 

-- 
Regards,
Siddharth.
