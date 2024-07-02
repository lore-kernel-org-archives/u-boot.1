Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE106C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335E787D0A;
	Tue,  2 Jul 2024 20:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="E+BTCVtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A00C87C86; Tue,  2 Jul 2024 20:25:39 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AE788763
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1719944734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFSS9TRu28AZ6CBPkH/Wrhhuw1KnU1QxpuagJ8Czw5U=;
 b=E+BTCVtle06rDzuSFCd/4/G6wez5wUdls30XgnkAfCEtMBzh1pqA97M1hipoYqV243jI84
 iI+dHQuz2aWpcy8tLggm46W5n8EZ7dISZiAYLTQDgCdopWCE6sLPoBGqpXguS2AeLooOCz
 UKNPXW5tZ9UleHOPs9oBzndFOUhtsZcFoqth5XHs42z885uaUZus/FnNJDRir//E4g9zcN
 6PgDu7r0QDiNQiAE6nDkLH349BQGGeVchsfo7cHFJEqvpzQFXBB2IR+UZZsLOROi7s1k7u
 v0Lj/d/OLM+AoM3aBiBJICfAlb7yNTlmJamRYhYCOna0Pu2v7xGcT7AOCbvu7Q==
Date: Tue, 02 Jul 2024 20:25:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
In-Reply-To: <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
References: <20240531153635.246154-1-tharvey@gateworks.com>
 <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
Message-ID: <6f37bd3dd369d3a63be7d8c00666c5e9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Tim,

On 2024-07-02 20:14, Tim Harvey wrote:
> On Fri, May 31, 2024 at 8:36 AM Tim Harvey <tharvey@gateworks.com> 
> wrote:
>> 
>> Modern eMMC v4+ devices have multiple hardware partitions per the 
>> JEDEC
>> specification described as:
>>  Boot Area Partition 1
>>  Boot Area Partition 2
>>  RPMB Partition
>>  General Purpose Partition 1
>>  General Purpose Partition 2
>>  General Purpose Partition 3
>>  General Purpose Partition 4
>>  User Data Area
>> 
>> These are referenced by fields in the PARTITION_CONFIG register
>> (Extended CSD Register 179) which is defined as:
>> bit 7: reserved
>> bit 6: BOOT_ACK
>>   0x0: No boot acknowledge sent (default
>>   0x1: Boot acknowledge sent during boot operation Bit
>> bit 5:3: BOOT_PARTITION_ENABLE
>>   0x0: Device not boot enabled (default)
>>   0x1: Boot Area partition 1 enabled for boot
>>   0x2: Boot Area partition 2 enabled for boot
>>   0x3-0x6: Reserved
>>   0x7: User area enabled for boot
>> bit 2:0 PARTITION_ACCESS
>>   0x0: No access to boot partition (default)
>>   0x1: Boot Area partition 1
>>   0x2: Boot Area partition 2
>>   0x3: Replay Protected Memory Block (RPMB)
>>   0x4: Access to General Purpose partition 1
>>   0x5: Access to General Purpose partition 2
>>   0x6: Access to General Purpose partition 3
>>   0x7: Access to General Purpose partition 4
>> 
>> Note that setting PARTITION_ACCESS to 0x0 results in selecting the 
>> User
>> Data Area partition.
>> 
>> You can see above that the two fields BOOT_PARTITION_ENABLE and
>> PARTITION_ACCESS do not use the same enumerated values.
>> 
>> U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
>> register:
>> EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
>> EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
>> EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
>> EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
>> 
>> EXT_CSD_BOOT_ACK(x)             (x << 6)
>> EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
>> EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
>> 
>> EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
>> EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
>> EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
>> 
>> There are various places in U-Boot where the BOOT_PARTITION_ENABLE 
>> field
>> is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
>> hardware partition consistent with the definition of the
>> PARTITION_ACCESS field used by the various mmc_switch incarnations.
>> 
>> To add some sanity to the distinction between BOOT_PARTITION_ENABLE
>> (used to specify the active device on power-cycle) and 
>> PARTITION_ACCESS
>> (used to switch between hardware partitions) create two enumerated 
>> types
>> and use them wherever struct mmc * part_config is used or the above
>> macros are used.
>> 
>> Additionally provide arrays of the field names and allow those to be
>> used in the 'mmc partconf' command and in board support files.
>> 
>> The first patch adds enumerated types and makes use of them which
>> represents no compiled code change.
>> 
>> The 2nd patch adds the array of names and uses them in the 'mmc
>> partconf' command.
>> 
>> The 3rd patch uses the array of hardware partition names in a board
>> support file to show what emmc hardware partition U-Boot is being 
>> loaded
>> from.
>> 
>> I'm sending this as a series this time around as previously it was
>> repsented as two different patches.
>> 
>> Tim Harvey (3):
>>   mmc: use an enumerated type to represent PARTITION_CONFIG fields
>>   mmc: allow use of hardware partition names for mmc partconf
>>   venice: show emmc boot hardware partition
>> 
>>  arch/arm/mach-imx/image-container.c | 10 ++++-----
>>  arch/arm/mach-sunxi/board.c         |  2 +-
>>  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
>>  board/gateworks/venice/venice.c     | 22 +++++++++---------
>>  board/purism/librem5/librem5.c      |  4 ++--
>>  board/storopack/smegw01/smegw01.c   |  4 ++--
>>  cmd/mmc.c                           | 27 ++++++++++++++++++----
>>  cmd/mvebu/bubt.c                    |  4 ++--
>>  common/spl/spl_mmc.c                |  4 ++--
>>  drivers/mmc/mmc.c                   | 35 
>> +++++++++++++++++++++++++++++
>>  include/mmc.h                       | 26 +++++++++++++++++++++
>>  11 files changed, 123 insertions(+), 35 deletions(-)
> 
> Is there any feedback on this series? I got feedback from several
> people on my first attempt (cc'd) but nothing on this version.

Any chances, please, to provide links to each of the patch and series
versions on https://lore.kernel.org/u-boot/ , together with a brief
changelog and history?  I'm having troubles refreshing my memory on
what patches were actually pulled into what series.

My guess is that other people would also benefit from such a refresher.
