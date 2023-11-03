Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D80C4167B
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 17:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D52E087115;
	Fri,  3 Nov 2023 18:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YWuFovwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928D787115; Fri,  3 Nov 2023 18:58:45 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB708711B
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 18:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A3HwYxb105707;
 Fri, 3 Nov 2023 12:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699034314;
 bh=CTEP/AR9T/G9AoF9mQ2rXYloviAbeP0++RVHYdygBIU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YWuFovwSlWKO4W3ahCG5kB7c39LIg7aza7uHlDiAvj2vd70LeRiOnRrOl9g/WWNMb
 bXRHKZIhfx7AzW34beGRnnEfXPHarWZLIQR0KTNyOcMFuiioxVb8h9Swl9hiHXPxjE
 ox+SLPgz8R+hns4VuNFWZ1aMzxa1ea+Iivb7qJXw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A3HwYLR083963
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 12:58:34 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 12:58:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 12:58:33 -0500
Received: from [10.250.149.140] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A3HwRR7081103;
 Fri, 3 Nov 2023 12:58:28 -0500
Message-ID: <7f18d145-d66f-564c-f6f5-1b81bba839a1@ti.com>
Date: Fri, 3 Nov 2023 23:28:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] video: Skip framebuffer reservation if already
 reserved
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>,
 <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-5-devarsht@ti.com>
 <CAPnjgZ0u9K5NR0apoTHFRKHxksT2O7_GDaOhdbm4sagvvgiBNQ@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ0u9K5NR0apoTHFRKHxksT2O7_GDaOhdbm4sagvvgiBNQ@mail.gmail.com>
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
> On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>>
>> Skip framebufer reservation if it was already reserved
>> from previous stage and whose information was passed
>> using a bloblist.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> V2:
>> - Add debug prints
>> - Fix commenting style
>> ---
>>   drivers/video/video-uclass.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
>> index f743ed74c8..335a1a1828 100644
>> --- a/drivers/video/video-uclass.c
>> +++ b/drivers/video/video-uclass.c
>> @@ -123,6 +123,18 @@ int video_reserve(ulong *addrp)
>>          struct udevice *dev;
>>          ulong size;
>>
>> +       if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
>> +               /* Skip allocation if already received a bloblist which
> 
> comment style
> 
> /*
>   * Skip ...

Oops, thanks for the nitpick, will correct this, I wonder why checkpatch 
didn't catch this :)

Regards
Devarsh

> 
>> +                * filled below fields
>> +                */
>> +               if (gd->fb_base && gd->video_top && gd->video_bottom) {
>> +                       debug("Found pre-reserved video memory from %lx to %lx\n",
>> +                             gd->video_bottom, gd->video_top);
>> +                       debug("Skipping video frame buffer allocation\n");
>> +                       return 0;
>> +               }
>> +       }
>> +
>>          gd->video_top = *addrp;
>>          for (uclass_find_first_device(UCLASS_VIDEO, &dev);
>>               dev;
>> --
>> 2.34.1
>>
> 
> Regards,
> Simon
