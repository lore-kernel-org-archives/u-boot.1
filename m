Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F63C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 17:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6342586C04;
	Fri,  3 Nov 2023 18:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EycHxiI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0375586E54; Fri,  3 Nov 2023 18:57:44 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE4286BF7
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 18:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A3HvWPs104373;
 Fri, 3 Nov 2023 12:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699034252;
 bh=+cWEF25haxhU3DNdPn7e6dOv7L4LHdldlDnNYRnQtQk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EycHxiI2v8le0nAKQBqnyvum91vnAriP8K759mirU/ZoC2m3mBRVhhLKZ3oJ5203d
 0WsUgakjW3b1R3IlMQLYO/GsN9JEmd3v1A4j7WXO9yjr3GL2aQjDR/Z6yqwKZtR7kD
 fVX6RCPmZu0DzaifOiOGmxnRNYgjSK+ArRsf1jz0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A3HvWSC115291
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 12:57:32 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 12:57:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 12:57:32 -0500
Received: from [10.250.149.140] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A3HvHgf080165;
 Fri, 3 Nov 2023 12:57:18 -0500
Message-ID: <14dd8d68-d5b7-1d2a-9141-53213c0e1ef8@ti.com>
Date: Fri, 3 Nov 2023 23:27:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] common/board_f: Catch bloblist before starting
 resevations
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>,
 <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-4-devarsht@ti.com>
 <CAPnjgZ2n8u6pYNoQ5n1qqQpZkDs-uM4-FMHbT4Pq6aZtt+ixjg@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ2n8u6pYNoQ5n1qqQpZkDs-uM4-FMHbT4Pq6aZtt+ixjg@mail.gmail.com>
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

Hi Simon,

Thanks for the review.

On 03/11/23 04:16, Simon Glass wrote:
> Hi Devarsh,
> 
> On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>>
>> Start reservations needed for init sequence only after catching
>> bloblists from previous stage.
>>
>> This is to avoid catching bloblists in the middle causing
>> gaps while u-boot is reserving.
>>
>> Adjust the relocaddr as per video hand-off information
>> received from previous stage so that further reservations
>> start only after regions reserved for previous stages
>>
>> Skip reservation for video memory if it was already
>> filled by a bloblist.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2: Fix typo in commit title and checkpatch warnings/checks
>> ---
>>   common/board_f.c | 33 ++++++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index d4d7d01f8f..acf802c9cb 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -403,7 +403,7 @@ __weak int arch_reserve_mmu(void)
>>          return 0;
>>   }
>>
>> -static int reserve_video(void)
>> +static int reserve_video_from_videoblob(void)
>>   {
>>          if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
>>                  struct video_handoff *ho;
>> @@ -412,8 +412,34 @@ static int reserve_video(void)
>>                  if (!ho)
>>                          return log_msg_ret("blf", -ENOENT);
>>                  video_reserve_from_bloblist(ho);
>> -               gd->relocaddr = ho->fb;
>> -       } else if (CONFIG_IS_ENABLED(VIDEO)) {
>> +
>> +               /* Sanity check fb from blob is before current relocaddr */
>> +               if (likely(gd->relocaddr > (unsigned long)ho->fb))
>> +                       gd->relocaddr = ho->fb;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Check if any bloblist received specifying reserved areas from previous stage and adjust
>> + * gd->relocaddr accordingly, so that we start reserving after pre-reserved areas
>> + * from previous stage.
>> + *
>> + * NOTE:
>> + * IT is recommended that all bloblists from previous stage are reserved from ram_top
>> + * as next stage will simply start reserving further regions after them.
>> + */
>> +static int setup_relocaddr_from_bloblist(void)
>> +{
>> +       reserve_video_from_videoblob();
>> +
>> +       return 0;
>> +}
>> +
>> +static int reserve_video(void)
[1] Here.

>> +{
>> +       if (CONFIG_IS_ENABLED(VIDEO)) {
>>                  ulong addr;
>>                  int ret;
>>
>> @@ -923,6 +949,7 @@ static const init_fnc_t init_sequence_f[] = {
>>          reserve_pram,
>>   #endif
>>          reserve_round_4k,
>> +       setup_relocaddr_from_bloblist,
>>          arch_reserve_mmu,
>>          reserve_video,
> 
> But you have renamed this function, so how does this commit build?
> 

Sorry I didn't get you, maybe the diff is creating an illusion, this is 
a new function to reserve from bloblist and a wrapper around 
reserve_video_from_bloblist. I created the wrapper so that in future if 
any new blobs are getting passed they can be added inside this (they 
need to be after video region which is from end of ram) and relocaddr 
adjusted accordingly before proceeding with uboot proper reservations.
This is inline with our strategy to have SPL regions reserved from end 
of RAM so that uboot starts reserving right after them.

The existing function to reserve_video is still there [1]

> buildman -b <branch> --board sandbox_spl
> 

I remember testing this with make and also testing the functionality 
part of it, will try check with this command too.


Regards
Devarsh

> might help?
> 
>>          reserve_trace,
>> --
>> 2.34.1
>>
> 
> Regards,
> Simon
