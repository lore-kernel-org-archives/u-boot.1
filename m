Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98567CA0EEC
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 14:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332AE86D83;
	Tue, 12 Sep 2023 16:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uPdFMRzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BDC86D83; Tue, 12 Sep 2023 16:35:34 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0BC86C23
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 16:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CEZMtW075492;
 Tue, 12 Sep 2023 09:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694529322;
 bh=NPI1H6pq8DMMtahjUZxltr1nFt+x47oJPePUMm1p7ZE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uPdFMRzAILYHd6yvTLd37wFHbjQ4sJzqTS5awJyF1KsgWjweR94bwM0yXw8FP2rXY
 m/Ja3ZCT0PE5UY7aIj8abMqt4MTk/bXaqgWf/cXtWcceKqqW2JjzgSnujS9tkRppMn
 ul5Bw+7vXK4eldRQ1w7U3IW57Aq+HDmf/yguI9jk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CEZMAc029857
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 09:35:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 09:35:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 09:35:22 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CEZIfE013770;
 Tue, 12 Sep 2023 09:35:19 -0500
Message-ID: <ece7bb9b-29da-93d6-2aa9-746b296b1464@ti.com>
Date: Tue, 12 Sep 2023 20:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nikhil M Jain <n-jain1@ti.com>, Anatolij Gustschin <agust@denx.de>, Michal
 Suchanek <msuchanek@suse.de>, Ovidiu Panait <ovpanait@gmail.com>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
References: <20230731160008.82342-5-sjg@chromium.org>
 <CAEUhbmXn0VQ6B8Qfs+XWEBuPKQ0mtVbzNeH7ZmT+V1Yh1r5qWw@mail.gmail.com>
 <CAEUhbmU14kY-DpNEZyXJEWX4vbqFY-ANgEZZskqY_gxVv4rD5Q@mail.gmail.com>
 <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
 <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
 <99f81e66-9295-8e4c-1693-86e3d81a302c@ti.com>
 <CAPnjgZ2EjOn86eQ-BdGH5F67Op3bSwG0BZb-LAbPOw955Srg0g@mail.gmail.com>
 <328fb0cf-5f98-019f-49f8-30674c9d34e1@ti.com>
 <20230817151032.GG1515023@bill-the-cat>
 <CAPnjgZ0Mb-4Fcq+j-nRJbpN9gr9=SFsTtDQUx2WqVzbjAqFPXw@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ0Mb-4Fcq+j-nRJbpN9gr9=SFsTtDQUx2WqVzbjAqFPXw@mail.gmail.com>
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

Hi Simon,

On 11/09/23 04:44, Simon Glass wrote:
> Hi Devarsh,
> 
> On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Aug 16, 2023 at 09:16:05PM +0530, Devarsh Thakkar wrote:
>>> Hi Simon,
>>>
>>> On 15/08/23 20:14, Simon Glass wrote:
>>>> Hi Devarsh,
>>>>
>>>> On Tue, 15 Aug 2023 at 03:23, Devarsh Thakkar <devarsht@ti.com> wrote:
>>>>>
>>>>> Hi Simon, Tom,
>>>>>
>>>>> On 15/08/23 04:13, Simon Glass wrote:
>>>>>> Hi Devarsh, Nikhil, Tom,
>>>>>>
>>>>>> On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>>>>
>>>>>>> On Thu, Aug 3, 2023 at 7:03 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Thu, Aug 3, 2023 at 6:37 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Aug 1, 2023 at 12:00 AM Simon Glass <sjg@chromium.org> wrote:
>>>>>>>>>>
>>>>>>>>>> When the video framebuffer comes from the bloblist, we should not change
>>>>>>>>>> relocaddr to this address, since it interfers with the normal memory
>>>>>>>>>
>>>>>>>>> typo: interferes
>>>>>>>>>
>>>>>>>>>> allocation.
>>>>>>>>>>
>>>>>>>>>> This fixes a boot loop in qemu-x86_64
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>>>>> Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info from SPL to u-boot")
>>>>>>>>>> Suggested-by: Nikhil M Jain <n-jain1@ti.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changes in v3:
>>>>>>>>>> - Reword the Kconfig help as suggested
>>>>>>>>>>
>>>>>>>>>> Changes in v2:
>>>>>>>>>> - Add a Kconfig as the suggested conditional did not work
>>>>>>>>>>
>>>>>>>>>>   common/board_f.c      | 3 ++-
>>>>>>>>>>   drivers/video/Kconfig | 9 +++++++++
>>>>>>>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>>>>>>>> index 7d2c380e91e..5173d0a0c2d 100644
>>>>>>>>>> --- a/common/board_f.c
>>>>>>>>>> +++ b/common/board_f.c
>>>>>>>>>> @@ -419,7 +419,8 @@ static int reserve_video(void)
>>>>>>>>>>                  if (!ho)
>>>>>>>>>>                          return log_msg_ret("blf", -ENOENT);
>>>>>>>>>>                  video_reserve_from_bloblist(ho);
>>>>>>>>>> -               gd->relocaddr = ho->fb;
>>>>>>>>>> +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
>>>>>>>>>> +                       gd->relocaddr = ho->fb;
>>>>>>>>>>          } else if (CONFIG_IS_ENABLED(VIDEO)) {
>>>>>>>>>>                  ulong addr;
>>>>>>>>>>                  int ret;
>>>>>>>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>>>>>>>>> index b41dc60cec5..f2e56204d52 100644
>>>>>>>>>> --- a/drivers/video/Kconfig
>>>>>>>>>> +++ b/drivers/video/Kconfig
>>>>>>>>>> @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
>>>>>>>>>>            if this  option is enabled video driver will be removed at the end of
>>>>>>>>>>            SPL stage, beforeloading the next stage.
>>>>>>>>>>
>>>>>>>>>> +config VIDEO_RESERVE_SPL
>>>>>>>>>> +       bool
>>>>>>>>>> +       help
>>>>>>>>>> +         This adjusts reserve_video() to redirect memory reservation when it
>>>>>>>>>> +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). This avoids the
>>>>>>>>>> +         memory used for framebuffer from being allocated by U-Boot proper,
>>>>>>>>>> +         thus preventing any further memory reservations done by U-Boot proper
>>>>>>>>>> +         from overwriting the framebuffer.
>>>>>>>>>> +
>>>>>>>>>>   if SPL_SPLASH_SCREEN
>>>>>>>>>>
>>>>>>>>>>   config SPL_SPLASH_SCREEN_ALIGN
>>>>>>>>>
>>>>>>>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>>>>>>>>
>>>>>>>> applied to u-boot-x86, thanks!
>>>>>>>
>>>>>>> Dropped this one from the x86 queue per the discussion.
>>>>>>
>>>>>> I just wanted to come back to this discussion.
>>>>>>
>>>>>> Do we have an agreed way forward? Who is waiting for who?
>>>>>>
>>>>>
>>>>> I was waiting on feedback on
>>>>> https://lore.kernel.org/all/3b1e8005-f161-8058-13e7-3de2316aac34@ti.com/
>>>>> but per my opinion, I would prefer to go with "Approach 2" with a
>>>>> Kconfig as it looks simpler to me. It would look something like below :
>>>>>
>>>>> if (gd->relocaddr > (unsigned long)ho->fb) {
>>>>>       ulong fb_reloc_gap = gd->relocaddr - gd->ho->fb;
>>>>>
>>>>>       /* Relocate after framebuffer area if nearing too close to it */
>>>>>       if (fb_reloc_gap < CONFIG_BLOBLIST_FB_RELOC_MIN_GAP)
>>>>>              gd->relocaddr = ho->fb;
>>>>> }
>>>>>
>>>>> Regarding CONFIG_BLOBLIST_FB_RELOC_MIN_GAP
>>>>> -> This describes minimum gap to keep between framebuffer address and
>>>>> relocation address to avoid overlap when framebuffer address used by
>>>>> blob is below the current relocation address
>>>>>
>>>>> -> It would be selected as default when CONFIG_BLOBLIST is selected with
>>>>>   default value set to 100Mb
>>>>>
>>>>> -> SoC specific Vendors can override this in their defconfigs to a
>>>>> custom value if they feel 100Mb is not enough
>>>>>
>>>>> Also probably we can have some debug/error prints in the code to show
>>>>> overlap happened (or is going happen) so that users can fine tune this
>>>>> Kconfig if they got it wrong at first place.
>>>>>
>>>>> I can re-spin updated patch if we are aligned on this,
>>>>> Kindly let me know your opinion.
>>>>
>>>> I'm just nervous about the whole idea, TBH. Perhaps I am missing some
>>>> documentation on how people are supposed to lay out memory in SPL and
>>>> U-Boot properr, but I'm not really aware of any guidance we give.
>>>>
>>>> Perhaps we should say that the SPL frame buffer should be at the top
>>>> of memory, and U-Boot's reserve area should start below that?
>>>
>>> 1) As per my personal opinion, I don't like putting such constraints and would
>>> instead like to give some flexibility to end user for choosing
>>> framebuffer area as I earlier mentioned, as for that matter if we are using a
>>> predefined address then there is no need of using framebuffer address on
>>> videoblob,
>>
>> I think this is the wrong direction.  We need to offer strong defaults
>> that shouldn't be deviated without good reason, rather than "pick what
>> you want".  Very few cases will deviate from the defaults, and of those
>> it's hard to know if they're being changed for the best, or because
>> someone didn't fully understand the implications and breaks something
>> else.
> 
> So what is next with this? I would like to clean it up...I feel that
> having SPL pass the top of usable RAM (below the framebuffer) is a
> reasonable solution. Does constraining things in that way cause any
> problems for TI?

TBH, I am not fully able to visualize how this fits current arch :

So instead of blob address will we be passing ram_top inside the video blob ?
.Or we will be using separate ram_top blob passing from SPL to u-boot ?

Are we planning to enforce some restriction/hardcoding for framebuffer to be
reserved at specific address (near top of RAM) or it would be just a general
guideline to keep framebuffer near the RAM top ?

Currently don't see video_reserve API put such constraint and user is free to
call it anywhere and it just reserve after previously reserved areas. Now,
with this approach I guess we would deviate from the agnostic behavior of
video_reserve API then if we plan to update the same API ?

Also u-boot proper starts reserving regions for MMU and few other stuff much
before reserving framebuffers so by the time we receive the blob containing
updated ram_top, we would have already reserved those regions from old ram_top
 so moving the ram_top here seems little counter-intuitive to me. In such
scenario, as per my opinion better option seems to be moving he gd->relocaddr
instead.

Lastly, I think as much the user keep framebuffer way from ram_top that much
memory will be lost even with this approach (as ram_top will be moved after
framebuffer for u-boot proper) and same behavior will be observed with
https://lore.kernel.org/all/20230801140414.76216-1-devarsht@ti.com/ too

but if we are planning to put just a general guideline to user to keep
framebuffer near the RAM top then to me above patch looks much simpler than
moving the ram_top.

Regards
Devarsh

> 
> Regards,
> Simon
