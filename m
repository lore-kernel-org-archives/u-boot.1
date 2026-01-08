Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C6D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E8284144;
	Thu,  8 Jan 2026 14:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="S5dWc9SQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A6C084158; Thu,  8 Jan 2026 14:42:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B897584113
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1767879718;
 bh=mmSiVYaIHzi8ziY1uriQpGjNVYHwZyUKkb7yzL/tMjs=;
 b=S5dWc9SQuGeNbxfl3qc1InuwfoIfHBoqb+00L+Kda9KtBNPcYhwi5viiuBf4xH+0hn/mi0ME0
 369/MabO9VB6YfxgKD6k5VPG2v09xrUAa46yXqH+/ZFDj/UQimfGI8fERuSdLm7oDWo0uMWq726
 yeU0Ljkgw5u46YlKaqo5kD9U5+npcso50zwxjaCZF/tHSzTPofCy+xsV7D5k1jB/uVEiUv+4yoY
 gqdrIaPhtlktNkpYw1Nv0/X8RsvWxHDAwKR+kSWCf/WEB3IyagqdHSPFM0p/LFJyYa9gAahxlat
 C3sbiNobfype6Rec1Q/1Q00Z59yd6YZw8W9uST2lK1GA==
X-Forward-Email-ID: 695fb4202b5f20405ba81b9f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f6cab27f-e115-49e4-8a3f-a01ceb8500f3@kwiboo.se>
Date: Thu, 8 Jan 2026 14:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] ufs: rockchip: Enable SDRAM-only DMA quirk
To: Alexey Charkov <alchark@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
 <20260106-rk3576-ufs-v3-3-bfe259fd6d17@gmail.com>
 <67576082-d8b0-419e-8365-0f6294fe0ffc@linaro.org>
 <CABjd4YwyVKDRDz16u+rbiorFmPSJtEi7VgKZABr7A+_p2qDA=w@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CABjd4YwyVKDRDz16u+rbiorFmPSJtEi7VgKZABr7A+_p2qDA=w@mail.gmail.com>
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

On 1/6/2026 7:26 PM, Alexey Charkov wrote:
> On Tue, Jan 6, 2026 at 6:09 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 1/6/26 14:57, Alexey Charkov wrote:
>>> Rockchip RK3576 can boot fully from UFS, but as part of the boot
>>> process the SPL needs to place part of the ATF code into PMU SRAM,
>>> which is outside the SDRAM range that the UFSHC can access.
>>>
>>> Enable a quirk to force bounce operation for this case.
>>>
>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>> ---
>>>   drivers/ufs/Kconfig        | 1 +
>>>   drivers/ufs/ufs-rockchip.c | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
>>> index 6c75bb2a0790..2543b5d47c04 100644
>>> --- a/drivers/ufs/Kconfig
>>> +++ b/drivers/ufs/Kconfig
>>> @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
>>>   config UFS_ROCKCHIP
>>>       bool "Rockchip specific hooks to UFS controller platform driver"
>>>       depends on UFS
>>> +     select BOUNCE_BUFFER
>>>       help
>>>         This selects the Rockchip specific additions to UFSHCD platform driver.
>>>
>>> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
>>> index 0384244387da..699460fc4d15 100644
>>> --- a/drivers/ufs/ufs-rockchip.c
>>> +++ b/drivers/ufs/ufs-rockchip.c
>>> @@ -153,6 +153,7 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
>>>               return err;
>>>       }
>>>
>>> +     hba->quirks |= UFSHCD_QUIRK_DMA_SDRAM_ONLY;
>>
>> So you really want to enable this quirk for non-SPL builds aswell ?
> 
> Well I haven't run into any similar issues with the main U-boot, so I
> don't have a strong opinion about keeping it in place there.
> 
> However:
> 1. Having the quirk enabled doesn't cause all transfers to go via the
> bounce buffer. Only those for which the provided destination buffer
> happens to be outside SDRAM (which must be extremely rare if at all
> possible under U-boot, given that it hasn't caused issues for anyone)
> 2. If it turns out that there are indeed cases when the UFSHC needs to
> read or write something outside SDRAM while operating under U-boot (I
> can't think of a reason now, but then I couldn't think about that ATF
> to PMU SRAM thing either, until I ran into it and spent more than half
> a day debugging) then I'd rather spend a couple of CPU cycles on a
> memmove than end up with a hard lock up, a cryptic error message and a
> dump of UFSHC status registers
> 3. It's one line less code this way :)
> 
> Happy to add something like "if (xpl_phase() == PHASE_SPL)" though, if
> that sounds better to everyone.

You should most likely be able to drop this quirk workaround with the
"rockchip: rk3576: Fix DMA transfer of TF-A to PMU_SRAM" series [1][2]
that I just sent out.

Please try if that also solves the DMA transfer from UFS to PMU SRAM
issue, it did for eMMC, SD-card and SPI flash.

[1] https://patchwork.ozlabs.org/cover/2181298/
[2] https://lore.kernel.org/r/20260108133234.4001390-1-jonas@kwiboo.se/

Regards,
Jonas

> Best regards,
> Alexey

