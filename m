Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60636EE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B7087064;
	Mon, 21 Aug 2023 21:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84A486FAA; Mon, 21 Aug 2023 21:59:56 +0200 (CEST)
Received: from zulu616.server4you.de (mail.csgraf.de [85.25.223.15])
 by phobos.denx.de (Postfix) with ESMTP id C393B87067
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agraf@csgraf.de
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 9842A60807C7;
 Mon, 21 Aug 2023 21:59:51 +0200 (CEST)
Message-ID: <e24d94b4-d519-4491-a38b-488510059a2a@csgraf.de>
Date: Mon, 21 Aug 2023 21:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/13] video: Only dcache flush damaged lines
Content-Language: en-GB
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, Anatolij Gustschin
 <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-11-alpernebiyasak@gmail.com>
 <CAPnjgZ2_9s_n9RWO_t_UUJWK1uvjDQSHikpMg7VbpmCn9uuk5g@mail.gmail.com>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <CAPnjgZ2_9s_n9RWO_t_UUJWK1uvjDQSHikpMg7VbpmCn9uuk5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 21.08.23 21:11, Simon Glass wrote:
> Hi Alper,
>
> On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>> From: Alexander Graf <agraf@csgraf.de>
>>
>> Now that we have a damage area tells us which parts of the frame buffer
>> actually need updating, let's only dcache flush those on video_sync()
>> calls. With this optimization in place, frame buffer updates - especially
>> on large screen such as 4k displays - speed up significantly.
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>> Reported-by: Da Xue <da@libre.computer>
>> [Alper: Use damage.xstart/yend, IS_ENABLED()]
>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> ---
>>
>> Changes in v5:
>> - Use xstart, ystart, xend, yend as names for damage region
>> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
>>
>> Changes in v2:
>> - Fix dcache range; we were flushing too much before
>> - Remove ifdefs
>>
>>   drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
> This is a little strange, since flushing the whole cache will only
> actually write out data that was actually written (to the display). Is
> there a benefit to this patch, in terms of performance?


I'm happy to see you go through the same thought process I went through 
when writing these: "This surely can't be the problem, can it?". The 
answer is "simple" in hindsight:

Have a look at the ARMv8 cache flush function. It does the only "safe" 
thing you can expect it to do: Clean+Invalidate to POC because we use it 
for multiple things, clearing modified code among others:

ENTRY(__asm_flush_dcache_range)
         mrs     x3, ctr_el0
         ubfx    x3, x3, #16, #4
         mov     x2, #4
         lsl     x2, x2, x3              /* cache line size */

         /* x2 <- minimal cache line size in cache system */
         sub     x3, x2, #1
         bic     x0, x0, x3
1:      dc      civac, x0       /* clean & invalidate data or unified 
cache */
         add     x0, x0, x2
         cmp     x0, x1
         b.lo    1b
         dsb     sy
         ret
ENDPROC(__asm_flush_dcache_range)


Looking at the "dc civac" call, we find this documentation page from 
ARM: 
https://developer.arm.com/documentation/ddi0601/2022-03/AArch64-Instructions/DC-CIVAC--Data-or-unified-Cache-line-Clean-and-Invalidate-by-VA-to-PoC

This says we're writing any dirtyness of this cache line up to the POC 
and then invalidate (remove the cache line) also up to POC. That means 
when you look at a typical SBC, this will either be L2 or system level 
cache. Every read afterwards needs to go and pull it all the way back to 
L1 to modify it (or not) on the next character write and then flush it 
again.

Even worse: Because of the invalidate, we may even evict it from caches 
that the display controller uses to read the frame buffer. So depending 
on the SoC's cache topology and implementation, we may force the display 
controller to refetch the full FB content on its next screen refresh cycle.

I faintly remember that I tried to experiment with CVAC instead to only 
flush without invalidating. I don't fully remember the results anymore 
though. I believe CVAC just behaved identical to CIVAC on the A53 
platform I was working on. And then I looked at Cortex-A53 errata like 
[1] and just accepted that doing anything but restricting the flushing 
range is a waste of time :)


Alex


[1] 
https://patchwork.kernel.org/project/xen-devel/patch/1462466065-30212-14-git-send-email-julien.grall@arm.com/


