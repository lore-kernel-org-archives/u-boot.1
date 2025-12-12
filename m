Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB31D4415D
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 09:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE6E8334F;
	Fri, 12 Dec 2025 10:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tIH+KR61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9921D835B3; Fri, 12 Dec 2025 10:38:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7F1828A2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 10:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db6d=6S=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1765532288;
 bh=57RmfjR4CQMwoL8LuEGrmbSavaK2eR9Mi69VEXqqUC4=;
 b=tIH+KR61Crw8IwKWxsyyL+Fn72zJaDBuLAYGqCIzTY5MPeEFoI/soIXdcVq0mOsbFnFdFeCcf
 PCzN9rL5m4PUYxQePbF1Il/iEmt5mhUFPt7wyVAVVx4NW7kDvgbxkw9T9hLC8/dKSUL/lACBGR7
 NUqex/VYr9aaN6sudIHKyBMgZMSWizvS36Kzzzcc8SiJR82Pxw7HWRtxMflkDtomkGIZ09IRNML
 U2bDxk5515jGTySG1Q2mmsnrJjAJVzH19LTlNK+JfvL9UbYIofG6zcrhLL4X45fGrzd1bY1eZXk
 DOfgZHvrg7aaOcnXGbd7oL4/ApxHl4hesOGndGUOWl4Q==
X-Forward-Email-ID: 693be27ebcfd39afaeb6bc56
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8df41e2b-6b90-4e67-9857-a64144d8d8e9@kwiboo.se>
Date: Fri, 12 Dec 2025 10:38:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] common/spl: fit: Avoid directly loading images to
 load_addr
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
 <20251210-rk3576-ufs-v1-1-a3f9e76eb66e@gmail.com>
 <f616ea88-9d87-4960-bf02-62f0fbd1b206@kwiboo.se>
 <CABjd4YyevgLs4FqzgLTsog2A8h5VSKcFbhR+TABFUCrEBudLyw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CABjd4YyevgLs4FqzgLTsog2A8h5VSKcFbhR+TABFUCrEBudLyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Alexey,

On 12/12/2025 10:01 AM, Alexey Charkov wrote:
> Hi Jonas,
> 
> Thanks for your review!
> 
> On Thu, Dec 11, 2025 at 3:27 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 12/10/2025 9:10 PM, Alexey Charkov wrote:
>>> Load images unconditionally to a known-safe location (which is
>>> CONFIG_SYS_LOAD_ADDR) to be later relocated to its desired load address.
>>>
>>> Some storage devices may be unable to directly load each of the images
>>> listed in a FIT to their desired load addresses, as is the case with
>>> e.g. booting from UFS storage on Rockchip RK3576, where part of the
>>> ATF should end up in SRAM but the UFS controller cannot directly write
>>> there.
>>>
>>> Furthermore, the code down the line does a memmove or image decompression
>>> from the original src_ptr, anyway, so there shouldn't be any performance
>>> implications from this change.
>>
>> If I am not mistaken the memmove will try to move the src_ptr into
>> load_addr and as long as they are same this is a no-op, so I am
>> expecting this will have performance implications.
> 
> If there is no difference in alignment between src_ptr vs. load_addr
> and no image overhead, the memmove down the line should indeed return
> early. You're right that there are after all cases where this change
> will affect performance.

On Rockchip platform the FIT images are always sector (512 byte) aligned
to help ensure source addr and load addr are always aligned and not
needing use of memmove or a bounce buffer.

See commit 5ad03fc77dfa ("rockchip: Align FIT image data to SD/MMC block
length").

I am not sure how the use of a larger sector size for UFS affect this.

> 
>> I suggest we instead try to configure the rk3576 firewall to allow the
>> UFS controller to access SRAM (SYSMEM) similar to how this is allowed on
>> e.g. rk3588. Please see U-Boot rk3576.c and rk3588.c, and also TF-A
>> plat/rockchip/rk3576/drivers/secure/firewall.c.
> 
> Won't this introduce some sort of a security hole? I have to admit I
> don't know how the "trusted" part of "trusted firmware" is enforced,
> but I have a suspicion that there is a security reason why this
> particular segment gets written to a more locked-down SRAM rather than
> system RAM before TF-A code takes over the management of the firewall.
> Would be great to know otherwise, because this sounds like a much
> cleaner (=fewer code changes) solution than the alternatives. Any
> advice from the list would be appreciated!

It is the part of TF-A that uses __pmusram* attributes that will be
loaded into the PMUSRAM, e.g. resume from suspend and other code that
must work in low power mode.

DRAM to SRAM is allowed so I cannot see an issue with allowing U-Boot
SPL to use DMA mode to load directly into SRAM until TF-A takes over.

As an alternative we can also add some option to not use external data
for the FIT image that is not using a load addr in normal DRAM, see [1]
for a hack I made before DMA/PIO mode was fixed for RK3588.

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot/-/commit/3dde83844f43e036283947f015224d2fc740a349

Regards,
Jonas

> 
>> For other Rockchip SoCs we have also used non-DMA mode or a bounce
>> buffer to work around similar issue in the drivers.
> 
> I'll look into a potential non-DMA mode in the driver for use in SPL,
> thanks for the pointer!
> 
>> On a final note I would not fully trust the SYS_LOAD_ADDR addr on
>> Rockchip platform, to my knowledge this is not really used for anything
>> and because of this have not fully been considered when other static
>> load addresses have been picked, so this could introduce some unintended
>> overlaps.
> 
> That should be relatively easy to fix with a quick Kconfig change, but
> I agree it might lead to an unknown number of regressions on platforms
> that didn't use SYS_LOAD_ADDR before. Good point, thank you.
> 
> Best regards,
> Alexey

