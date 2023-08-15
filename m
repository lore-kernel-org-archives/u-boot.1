Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A945C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 09:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C60A8685D;
	Tue, 15 Aug 2023 11:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nzt/jnCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26B686970; Tue, 15 Aug 2023 11:23:50 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A4B86384
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 11:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37F9NcpC076742;
 Tue, 15 Aug 2023 04:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692091418;
 bh=w2JOluwxgtgZrnSQt+IWmNn7hi0bS/DamDDgA4KZOpI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nzt/jnCAlgy+ncUs7t6eVqnVatwAg/0hGxRITV2Pw9XVoB1Qy+kaYXWv1oQG3XyQ0
 jvGoe48YM3sGbDPQRw9dvY0VdOxXzxTy4aWyoNIF9RRVFg/OTXMeilr1uKKzVTJZ1A
 mrBNgW5OIPTHayfGJH+yY3eNM12ZQAtGuYGq4fTM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37F9NcG7016907
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Aug 2023 04:23:38 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Aug 2023 04:23:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Aug 2023 04:23:37 -0500
Received: from [10.0.2.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37F9NUh1004937;
 Tue, 15 Aug 2023 04:23:32 -0500
Message-ID: <99f81e66-9295-8e4c-1693-86e3d81a302c@ti.com>
Date: Tue, 15 Aug 2023 14:53:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/9] board_f: Fix corruption of relocaddr
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Nikhil M Jain
 <n-jain1@ti.com>, Anatolij Gustschin <agust@denx.de>, Michal Suchanek
 <msuchanek@suse.de>, Ovidiu Panait <ovpanait@gmail.com>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
References: <20230731160008.82342-5-sjg@chromium.org>
 <CAEUhbmXn0VQ6B8Qfs+XWEBuPKQ0mtVbzNeH7ZmT+V1Yh1r5qWw@mail.gmail.com>
 <CAEUhbmU14kY-DpNEZyXJEWX4vbqFY-ANgEZZskqY_gxVv4rD5Q@mail.gmail.com>
 <CAEUhbmXMfoiKa7UXoLQNVPN0w59_Y+4Q4U6HzHoq63mH8930vA@mail.gmail.com>
 <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ1zSe6dL0Y5bKPPp_7VFXVqGzHTdm-rcgDvJo+iM-YrkA@mail.gmail.com>
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

Hi Simon, Tom,

On 15/08/23 04:13, Simon Glass wrote:
> Hi Devarsh, Nikhil, Tom,
> 
> On Wed, 9 Aug 2023 at 09:29, Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> On Thu, Aug 3, 2023 at 7:03 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>
>>> On Thu, Aug 3, 2023 at 6:37 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>
>>>> On Tue, Aug 1, 2023 at 12:00 AM Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> When the video framebuffer comes from the bloblist, we should not change
>>>>> relocaddr to this address, since it interfers with the normal memory
>>>>
>>>> typo: interferes
>>>>
>>>>> allocation.
>>>>>
>>>>> This fixes a boot loop in qemu-x86_64
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> Fixes: 5bc610a7d9d ("common: board_f: Pass frame buffer info from SPL to u-boot")
>>>>> Suggested-by: Nikhil M Jain <n-jain1@ti.com>
>>>>> ---
>>>>>
>>>>> Changes in v3:
>>>>> - Reword the Kconfig help as suggested
>>>>>
>>>>> Changes in v2:
>>>>> - Add a Kconfig as the suggested conditional did not work
>>>>>
>>>>>   common/board_f.c      | 3 ++-
>>>>>   drivers/video/Kconfig | 9 +++++++++
>>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>>> index 7d2c380e91e..5173d0a0c2d 100644
>>>>> --- a/common/board_f.c
>>>>> +++ b/common/board_f.c
>>>>> @@ -419,7 +419,8 @@ static int reserve_video(void)
>>>>>                  if (!ho)
>>>>>                          return log_msg_ret("blf", -ENOENT);
>>>>>                  video_reserve_from_bloblist(ho);
>>>>> -               gd->relocaddr = ho->fb;
>>>>> +               if (IS_ENABLED(CONFIG_VIDEO_RESERVE_SPL))
>>>>> +                       gd->relocaddr = ho->fb;
>>>>>          } else if (CONFIG_IS_ENABLED(VIDEO)) {
>>>>>                  ulong addr;
>>>>>                  int ret;
>>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>>>> index b41dc60cec5..f2e56204d52 100644
>>>>> --- a/drivers/video/Kconfig
>>>>> +++ b/drivers/video/Kconfig
>>>>> @@ -1106,6 +1106,15 @@ config SPL_VIDEO_REMOVE
>>>>>            if this  option is enabled video driver will be removed at the end of
>>>>>            SPL stage, beforeloading the next stage.
>>>>>
>>>>> +config VIDEO_RESERVE_SPL
>>>>> +       bool
>>>>> +       help
>>>>> +         This adjusts reserve_video() to redirect memory reservation when it
>>>>> +         sees a video handoff blob (BLOBLISTT_U_BOOT_VIDEO). This avoids the
>>>>> +         memory used for framebuffer from being allocated by U-Boot proper,
>>>>> +         thus preventing any further memory reservations done by U-Boot proper
>>>>> +         from overwriting the framebuffer.
>>>>> +
>>>>>   if SPL_SPLASH_SCREEN
>>>>>
>>>>>   config SPL_SPLASH_SCREEN_ALIGN
>>>>
>>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>>>
>>> applied to u-boot-x86, thanks!
>>
>> Dropped this one from the x86 queue per the discussion.
> 
> I just wanted to come back to this discussion.
> 
> Do we have an agreed way forward? Who is waiting for who?
> 

I was waiting on feedback on 
https://lore.kernel.org/all/3b1e8005-f161-8058-13e7-3de2316aac34@ti.com/ 
but per my opinion, I would prefer to go with "Approach 2" with a 
Kconfig as it looks simpler to me. It would look something like below :

if (gd->relocaddr > (unsigned long)ho->fb) {
      ulong fb_reloc_gap = gd->relocaddr - gd->ho->fb;

      /* Relocate after framebuffer area if nearing too close to it */
      if (fb_reloc_gap < CONFIG_BLOBLIST_FB_RELOC_MIN_GAP)
             gd->relocaddr = ho->fb;
}

Regarding CONFIG_BLOBLIST_FB_RELOC_MIN_GAP
-> This describes minimum gap to keep between framebuffer address and 
relocation address to avoid overlap when framebuffer address used by 
blob is below the current relocation address

-> It would be selected as default when CONFIG_BLOBLIST is selected with 
  default value set to 100Mb

-> SoC specific Vendors can override this in their defconfigs to a 
custom value if they feel 100Mb is not enough

Also probably we can have some debug/error prints in the code to show 
overlap happened (or is going happen) so that users can fine tune this 
Kconfig if they got it wrong at first place.

I can re-spin updated patch if we are aligned on this,
Kindly let me know your opinion.

Regards
Devarsh

> Regards,
> Simon
