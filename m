Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22895CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 14:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7373B883F5;
	Fri,  5 Apr 2024 16:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qovlo5mE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD54883EA; Fri,  5 Apr 2024 16:49:51 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533E088385
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 435EnZFg001144;
 Fri, 5 Apr 2024 09:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712328575;
 bh=s6DcdaEJNezLVptqRUq5GMefi10+iD6xK3z4DXLATVQ=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=qovlo5mEy7+s5AWsuvTPmY1KAtJpZ4HyXE704iNcO2grYyq65p2JeyYpGk0lYXDAt
 FWVq/D4N5EcdFFF9hT3v6n78yWdPvYKYI4h/vKjUP/Cxw5gvltC6LyU4e3fT581MpM
 YNTBjl1NPsndgTfi/q4G6AC/BZUav7taRkoox3dM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 435EnYs4004016
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Apr 2024 09:49:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 09:49:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 09:49:34 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 435EnSVs091047;
 Fri, 5 Apr 2024 09:49:29 -0500
Message-ID: <cf615812-1074-10d6-8867-cbc55c2d21cd@ti.com>
Date: Fri, 5 Apr 2024 20:19:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] Simplefb and fb reservation related updates
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
 <83db0246-18a6-05ab-3e76-472ad0cc688b@ti.com>
Content-Language: en-US
In-Reply-To: <83db0246-18a6-05ab-3e76-472ad0cc688b@ti.com>
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

Gentle Reminder.

On 08/03/24 16:38, Devarsh Thakkar wrote:
> Hi Tom, Anatolij, Simon,
> 
> On 22/02/24 18:38, Devarsh Thakkar wrote:
>> This adds support for simple-framebuffer reservation using video handoff
>> when splash is enabled at SPL stage.
>>
>> Also adds helper function to only enable framebuffer reservation without
>> enabling simple-framebuffer in case user want to continue display
>> bootloader splash without displaying anything else in between until
>> kernel boots up.
>>
>> Lastly, it enables above support on AM62x.
>>
> 
> I saw a RB on first 3 patches so just wanted to check if it looks good to you
> too then is it possible to pull in the first 3 patches if no further comments ?
> 
> Regards
> Devarsh
> 
>> Devarsh Thakkar (4):
>>   boot: fdt_simplefb: Enumerate framebuffer info from video handoff
>>   video: Assume video to be active if SPL is passing video hand-off
>>   boot: Move framebuffer reservation to separate helper
>>   board: ti: am62x: evm: Update simple-framebuffer node in device-tree
>>
>>  board/ti/am62x/evm.c         | 19 +++++++++++++++
>>  boot/fdt_simplefb.c          | 46 ++++++++++++++++++++----------------
>>  boot/fdt_support.c           | 21 ++++++++++++++++
>>  drivers/video/video-uclass.c |  4 ++++
>>  include/fdt_support.h        |  2 ++
>>  5 files changed, 72 insertions(+), 20 deletions(-)
>>
