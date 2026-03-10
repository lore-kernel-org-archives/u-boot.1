Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F5FD2D65
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 12:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6CA83F2A;
	Tue, 10 Mar 2026 13:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MGugRDck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3955883FD3; Tue, 10 Mar 2026 13:23:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D95C83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fc7c=BL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773145424;
 bh=Xp2e3Sa0zeOc0d5rJwoAO6iWsKkF0EHItjHkfz0N3KU=;
 b=MGugRDckajqKt/xB4T46Z0xOf43p/AupPI1rX5xFdSQKBwu+fRYDVAQic8qtQ1Q+M6FLObxtP
 rD6nFN7EZZ18Gqwd2molzdSLPZZOn5HkmASwK3OtjMexTtpWiAJOlHuYus/IUU3ylxa6707Xz7G
 KU9KI7GPr+LS2PPbmYUI7DInmB0kn4sFIaOVIAWd5XNbI1BdaAt5+WYb0XdKNcuZIBjjIJZHvjs
 rMWtG+IQJHetu4qtJLQxyGH1HK6X62r86kfoA6YRlmm9XyLykL6pR/YsbWE7r7sOOMxicjQTl/r
 LnK6zG/zYSO22j/3bPS1InJA5Xrs3Wpq+F1rOGyG8GWg==
X-Forward-Email-ID: 69b00d4d189e6b521c2d539f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6ae16959-38ef-4fd6-82e0-20d278bc7745@kwiboo.se>
Date: Tue, 10 Mar 2026 13:23:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Enable full UFS boot on Rockchip RK3576
To: Alexey Charkov <alchark@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
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

On 3/10/2026 9:44 AM, Alexey Charkov wrote:
> On Tue, Jan 20, 2026 at 10:09 PM Alexey Charkov <alchark@gmail.com> wrote:
>>
>> Rockchip RK3576 can load its bootloader from UFS among other options,
>> so this series adds the necessary bits and pieces to enable an end-to-end
>> boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).
>>
>> To achieve the above, this series goes through the following:
>>  - Patch 1 introduces arch-independent code to enable SPL images to use
>>    UFS devices, including build system tweaks and a function to locate
>>    a U-boot image at a fixed UFS offset and LUN (SCSI device number)
>>  - Patch 2 adds an option to build the Rockchip reset driver for SPL
>>  - Patch 3 adds device-reset functionality to the Rockchip UFS glue code,
>>    which is required for (at least some) UFS modules to respond to
>>    controller commands upon initial enumeration
>>  - Patch 4 ties it all together for Rockchip RK3576
>>
>> This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
>> BWU3AKC46C256G UFS module. Note that booting directly from UFS masks the
>> issue which patch 3 aims to address, because the boot ROM initializes the
>> UFS module before handing over to U-boot. If, however, one boots SPL from
>> FSPI1 with the same driver code, the module fails to respond unless patch
>> 3 is applied.
>>
>> This depends on Jonas' recent series [3] enabling DMA writes to PMU SRAM,
>> without which the UFS controller will fail to load ATF and end up in an
>> unrecoverable error state requiring a hard reset.
>>
>> Note that in my experience none of the RK3576 boards actually boot current
>> mainline U-boot versions without a single-word SRAM write before jumping
>> to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, to
>> test this series I additionally applied commits 6b152999908b..d43031c4045e
>> from Kwiboo's rk3576 branch [2] (including 6b152999908b), so any testers
>> might want to:
>>
>> git cherry-pick 6b152999908b^..d43031c4045e
>>
>> from there before or after applying this series
>>
>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/d43031c4045ef8aaf29c467b910207e721dabce0
>> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576?ref_type=heads
>> [3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.se/
>>
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>> Changes in v5:
>> - Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
>> - Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quentin).
>>   This also pulls in SCSI to avoid compilation errors.
>> - Split out the patch enabling the Rockchip reset driver for SPL builds
>>   (thanks Quentin)
>> - Reworded the error message when requesting the UFS reset GPIO fails
>>   (thanks Quentin)
>> - Added a note in the commit message about reset-gpios being required by
>>   the DT binding (thanks Quentin)
>> - Dropped the redundant check of GPIO validity in the reset function
>>   (thanks Quentin)
>> - Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
>>   on RK3576 (thanks Shawn)
>> - Dropped "imply" symbols from the arch Kconfig, now that both GPIO
>>   and RESET drivers are explicitly depended on from the UFS driver
>>   (thanks Quentinq)
>> - Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com
>>
>> Changes in v4:
>> - Added a dependency in b4 metadata on Jonas' new series enabling DMA
>>   writes to PMU SRAM (thanks Jonas)
>> - Dropped the bounce buffer quirk altogether, as it now works as-is
>> - Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com
>>
>> Changes in v3:
>> - Added a UFSHC quirk to use the SCSI bounce buffer for addresses outside
>>   SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
>> - Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
>> - Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com
>>
>> Changes in v2:
>> - Rename the SPL UFS read helper function more self-descriptively (thanks Neil)
>> - Add an option to configure the UFS LUN used to look for the U-boot image
>>   in raw offset mode - or rather the SCSI device number, which most of the
>>   time coincides with the UFS LUN as long as the UFS device is the only
>>   SCSI block device the SPL sees (thanks Neil)
>> - Add an option to use a bounce buffer in RAM while loading U-boot from UFS,
>>   which helps avoid changes to common spl_fit.c code which in v1 achieved a
>>   similar result at a performance cost to unrelated platforms (thanks Jonas)
>> - Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com
>>
>> ---
>> Alexey Charkov (4):
>>       spl: Make UFS available for SPL builds
>>       reset: rockchip: make device resets available in SPL
>>       ufs: rockchip: Add device reset support
>>       rockchip: spl: Add support for booting from UFS
>>
>>  MAINTAINERS                                  |  1 +
>>  arch/arm/dts/rk3576-u-boot.dtsi              | 16 ++++++++-
>>  arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
>>  arch/arm/include/asm/spl.h                   |  1 +
>>  arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
>>  arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
>>  common/spl/Kconfig                           | 30 +++++++++++++++++
>>  common/spl/Makefile                          |  1 +
>>  common/spl/spl_ufs.c                         | 49 ++++++++++++++++++++++++++++
>>  drivers/Makefile                             |  1 +
>>  drivers/reset/Kconfig                        |  9 +++++
>>  drivers/reset/Makefile                       |  2 +-
>>  drivers/scsi/Makefile                        |  3 ++
>>  drivers/ufs/Kconfig                          |  4 +++
>>  drivers/ufs/ufs-rockchip.c                   | 22 +++++++++++++
>>  drivers/ufs/ufs-rockchip.h                   |  1 +
>>  lib/Makefile                                 |  1 +
>>  17 files changed, 155 insertions(+), 2 deletions(-)
>> ---
>> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
>> change-id: 20251210-rk3576-ufs-ac3bf4e87156
>> prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
>> prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
>> prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972
> 
> Hi Neil, Kever,
> 
> Now that Kever has applied the patch from Jonas [1] which lets this
> one work without bounce buffers on Rockchip RK3576, would you mind
> giving this series another look?
> 
> Please let me know if I should rebase / resubmit / adjust in any way.
> Would be great to have it merged.

I will test and review this later today, I think we may need to include
the gpio/pinctrl fix in u-boot.dtsi until it has fully landed i
dts/upstream, or possible add a bootph props in soc u-boot.dtsi.

Maybe it would make sense to also enable UFS booting on a board as
part of this series? E.g. on the NanoPi M5 and/or ROCK 4D?

Regards,
Jonas

> 
> Thanks a lot,
> Alexey
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/commit/4015faa32342fd9c494c318c21de106f98dd4674

