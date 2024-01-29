Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15583C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 16:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E540A87C20;
	Mon, 29 Jan 2024 17:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L5u3oa8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7158787BB5; Mon, 29 Jan 2024 17:11:59 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FF187C87
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TGBphM052896;
 Mon, 29 Jan 2024 10:11:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706544711;
 bh=nIV9okuEF8WJblHVFGk1K69Y79lI6ibJRjbZV/S0ivQ=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=L5u3oa8Ls3LV7ytLX7Hthc++/q5FtTCwajOUCzlqViwCFeHvqGZIVIUOeRDOpacfr
 wwLx3PHyuWZzOs6GbRJkIo7k6jy5cLuuqxaitOJ9O1cx1O052uk6WoMoA5rMSEvDaZ
 Wq+cQY5jaFcp1xWeeI1KMeikBfVk+8fZLlHZABsQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TGBprX042905
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jan 2024 10:11:51 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 10:11:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 10:11:51 -0600
Received: from [10.249.128.48] ([10.249.128.48])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TGBk84016684;
 Mon, 29 Jan 2024 10:11:47 -0600
Message-ID: <c485226f-1223-8d56-139f-825624b7ab5b@ti.com>
Date: Mon, 29 Jan 2024 21:41:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 0/8] Move framebuffer reservation for SPL to RAM end
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
To: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>,
 <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
 <871ec46f-feb6-146f-91f9-6f02c0da3b45@ti.com>
 <CAFLszTiJ6En-jQr_3v4S0d4eUyBvvOt==SeZ8n46ZjLwju6Tdw@mail.gmail.com>
 <416d41aa-397d-2d08-8297-f9d8b4e07752@ti.com>
In-Reply-To: <416d41aa-397d-2d08-8297-f9d8b4e07752@ti.com>
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

Hi Anatolij, Tom,

On 08/01/24 13:32, Devarsh Thakkar wrote:
> Hi Anatolij, Tom,
> 
> On 26/12/23 15:17, Simon Glass wrote:
>> On Wed, Dec 13, 2023 at 2:56 PM Devarsh Thakkar <devarsht@ti.com> wrote:
>>>
>>> Hi Antoine,
>>>
>>> On 05/12/23 21:25, Devarsh Thakkar wrote:
>>>> Move video memory reservation for SPL at end of RAM so that it does
>>>> not interefere with reservations for next stage so that the next stage
>>>> need not have holes in between for passed regions and instead it can
>>>> maintain continuity in reservations.
>>>>
>>>> Also catch the bloblist before starting reservations to avoid the same
>>>> problem.
>>>>
>>>> While at it, also fill missing fields in video handoff struct before
>>>> passing it to next stage.
>>>>
>>>> This is as per discussions at :
>>>> For moving SPL framebuffer reservation at end of RAM:
>>>>
>>>> https://lore.kernel.org/all/CAPnjgZ3xSoe_G3yrqwuAvoiVjUfZ+YQgkOR0ZTVXGT9VK8TwJg@mail.gmail.com/
>>>>
>>>> For filling missing video handoff fields :
>>>> https://lore.kernel.org/all/CAPnjgZ1Hs0rNf0JDirp6YPsOQ5=QqQSP9g9qRwLoOASUV8a4cw@mail.gmail.com/
>>>>
>>>> Changelog:
>>>> V2:
>>>> - Make a generic function to reserve video memory at SPL stage.
>>>> - Add debug prints while skipping framebuffer allocation at uboot.
>>>> - Correct commenting style as suggested.
>>>>
>>>> V3:
>>>> - Change spl_reserve_video to spl_reserve_video_from_ram_top
>>>>    which enforce framebuffer reservation from end of RAM.
>>>> - Use gd->ram_top instead of local ram_top and update
>>>>    gd->reloc_addr after each reservation.
>>>> - Print error message on framebuffer reservation.
>>>> - Update SPL doc with spl splash screen specific info.
>>>>
>>>> V4:
>>>> - Split patches into atomic commits.
>>>> - Remove duplicate check for video blob passed addresses and error out
>>>>    if invalid address/size received from blob.
>>>> - Improve SPL documentation memory reservation scheme and print message
>>>>    for video memory reservation from bloblist.
>>>> - Add Reviewed-By.
>>>>
>>>> V5:
>>>>   - Add comment for filling video handoff size with aligned size
>>>>   - Use PHASE_BOARD_F while checking for U-boot proper stage
>>>>   - Add Reviewed-by
>>>>
>>>
>>> Is it possible to pull this series in if no further comments ?
>>
>> Yes please, this has been pending for a while.
> 
> Gentle reminder. Is it possible to pick this series ?
> 

Gentle reminder.
Is it possible to pull this in for current merge window for v2024.04 ?

Regards
Devarsh
> Regards
> Devarsh
> 
>>
>>>
>>> Regards
>>> Devarsh
>>>
>>>> Test logs:
>>>> https://gist.github.com/devarsht/30a3c1591270c9ebae00714b48d33058
>>>>
>>>> Devarsh Thakkar (8):
>>>>    spl: Enforce framebuffer reservation from end of RAM
>>>>    arm: mach-k3: common: Reserve video memory from end of the RAM
>>>>    board: ti: am62x: evm: Remove video_setup from spl_board_init
>>>>    common/board_f: Catch bloblist before starting reservations
>>>>    video: Skip framebuffer reservation if already reserved
>>>>    video: Fill video handoff in video post probe
>>>>    doc: spl: Add info for missing Kconfigs
>>>>    doc: spl: Add info regarding memory reservation
>>>>
>>>>   arch/arm/mach-k3/common.c    | 17 ++++++++++-----
>>>>   board/ti/am62x/evm.c         | 18 ----------------
>>>>   common/board_f.c             | 41 +++++++++++++++++++++++++++++++-----
>>>>   common/spl/spl.c             | 19 +++++++++++++++++
>>>>   doc/develop/spl.rst          | 37 ++++++++++++++++++++++++++++++++
>>>>   drivers/video/video-uclass.c | 40 ++++++++++++++++++++++++-----------
>>>>   include/spl.h                | 10 +++++++++
>>>>   7 files changed, 142 insertions(+), 40 deletions(-)
>>>>
>>
>> Regards,
>> Simon
