Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208A3C07CA9
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 14:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4698387075;
	Sat, 25 Nov 2023 15:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FyQvHa4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244EF870E7; Sat, 25 Nov 2023 15:27:23 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BD087005
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 15:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APERDvW017038;
 Sat, 25 Nov 2023 08:27:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700922433;
 bh=pWj4wolJ8SMWOSwrX9aad9JFXd/kao+GDTS5JT53EWI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=FyQvHa4y/xxqDXDaBC2tV1Ny1wUfEzx8DOfbihvqR0Fvb5tJENgqCnTqymokMHbwg
 ZT3En7xwFHvGWpl1lXhkaDqinUoUU9AWhZrJd1vygy/Bh4vWEPf5wDQ33bbetniHO1
 4t67yj+g43LjIUbpYuLFwKqpWMd763He4clybAYU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APERDgZ093233
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 08:27:13 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 08:27:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 08:27:13 -0600
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APER93k111104;
 Sat, 25 Nov 2023 08:27:09 -0600
Message-ID: <c97b9ccd-8dd6-6fab-ebb6-b5b6cb2a1c08@ti.com>
Date: Sat, 25 Nov 2023 19:57:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] video: Fill video handoff in video post probe
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>,
 <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-6-devarsht@ti.com>
 <CAPnjgZ1TWnMrKDDbNDdg9TB8bhfW5ga2E7Lpy8HdyvsO46FDsw@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ1TWnMrKDDbNDdg9TB8bhfW5ga2E7Lpy8HdyvsO46FDsw@mail.gmail.com>
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

Hi Simon,

Thanks for the review.

On 13/11/23 01:31, Simon Glass wrote:
> Hi Devarsh,
> 
> On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
>>
>> Fill video handoff fields in video_post_probe
>> as at this point we have full framebuffer-related
>> information.
>>
>> Also fill all the fields available in video hand-off
>> struct as those were missing earlier and U-boot
> 
> U-Boot
> 
>> framework expects them to be filled for some of the
>> functionalities.
> 
> Can you wrap your commit messages to closer to 72 chars?
> 
>>
>> Reported-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2:
>> - No change
>>
>> V3:
>> - Fix commit message per review comment
>> - Add a note explaining assumption of single framebuffer
>> ---
>>  drivers/video/video-uclass.c | 29 +++++++++++++++++++----------
>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
>> index f619b5ae56..edc3376b46 100644
>> --- a/drivers/video/video-uclass.c
>> +++ b/drivers/video/video-uclass.c
>> @@ -154,16 +154,6 @@ int video_reserve(ulong *addrp)
>>         debug("Video frame buffers from %lx to %lx\n", gd->video_bottom,
>>               gd->video_top);
>>
>> -       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(VIDEO_HANDOFF)) {
>> -               struct video_handoff *ho;
>> -
>> -               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
>> -               if (!ho)
>> -                       return log_msg_ret("blf", -ENOENT);
>> -               ho->fb = *addrp;
>> -               ho->size = size;
>> -       }
>> -
>>         return 0;
>>  }
>>
>> @@ -559,6 +549,25 @@ static int video_post_probe(struct udevice *dev)
>>
>>         priv->fb_size = priv->line_length * priv->ysize;
>>
>> +       /*
>> +        * Set up video handoff fields for passing video blob to next stage
>> +        * NOTE:
>> +        * This assumes that reserved video memory only uses a single framebuffer
>> +        */
>> +       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
>> +               struct video_handoff *ho;
>> +
>> +               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
>> +               if (!ho)
>> +                       return log_msg_ret("blf", -ENOENT);
>> +               ho->fb = gd->video_bottom;
>> +               ho->size = gd->video_top - gd->video_bottom;
> 
> should be plat->base and plat->size
> 

plat->size contains the unaligned size actually. While reserving video memory,
the size of allocation is updated [0] as per default alignment (1 MiB) or
alignment requested by driver. So I thought it is better to pass actual
allocated size calculated using gd as the next stage receiving hand-off can
directly skip the region as per passed size. And since I used gd for
calculating size, I thought to stick to using gd for ho->fb too for consistency.

Kindly let me know if any queries.

[0]:
https://source.denx.de/u-boot/u-boot/-/blob/u-boot-2023.07.y/drivers/video/video-uclass.c?ref_type=heads#L88

Regards
Devarsh

>> +               ho->xsize = priv->xsize;
>> +               ho->ysize = priv->ysize;
>> +               ho->line_length = priv->line_length;
>> +               ho->bpix = priv->bpix;
>> +       }
>> +
>>         if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
>>                 priv->copy_fb = map_sysmem(plat->copy_base, plat->size);
>>
>> --
>> 2.34.1
>>
> 
> Regards,
> Simon
