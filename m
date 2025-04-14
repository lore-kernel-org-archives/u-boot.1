Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB1BC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 09:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1468205B;
	Mon, 14 Apr 2025 11:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Je/E4Fn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945018209C; Mon, 14 Apr 2025 11:21:40 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF8482054
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 11:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 54FED60007;
 Mon, 14 Apr 2025 09:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A68FC4CEE2;
 Mon, 14 Apr 2025 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744622496;
 bh=htt3BH3Ha13pe7j2ijIqrgLXQM+dAKAVrPB0fRqvMHo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Je/E4Fn5nUjdMj/abfSUsQWAptrXjMyfQPAdSR70PKxBH61HcZpsLCHOvuPGLUR2w
 RWICCWljtc7waePT5Foo4S6BFzzE5E1sgnhJc1MDT01XKISDfmjGaGcuXnPIN1w9g7
 auhdrDUSUk83gdw36TV/ofIlRzzEkAdBuE9mkSzi9x9o25iu3T3SMmHSSiXlQxKAoG
 MN+GD+YXfRzOm+9K2qf72e8K7XgNr14QzHHGMcDUUW/0GF9jUIKaqqOAwwBZ/2wHfW
 3RVOq0mYVTjo6yatM6wKYUe5HlpC8MPVuwNMO78F8yrB1xQQnOmPGytoWHgotNyaxV
 r8gHe7XjgBk9w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v2 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <34a1d183-406d-41e0-8c62-99940b4892ed@linaro.org>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <34a1d183-406d-41e0-8c62-99940b4892ed@linaro.org>
Date: Mon, 14 Apr 2025 11:21:34 +0200
Message-ID: <8734ebdroh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hey Neil,

On lun., avril 14, 2025 at 11:13, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Mattijs,
>
> On 09/04/2025 09:58, neil.armstrong@linaro.org wrote:
>> This serie permits using any block device as target
>> for fastboot by moving the generic block logic into
>> a common set of helpers and also use them as generic
>> backend.
>> 
>> The erase logic has been extended to support software
>> erase since only 2 block drivers exposes the erase
>> operation.
>> 
>> Tests are welcome to make sure this series doesn't
>> introduce any regressions on the emmc backend.
>
> Could you get an eye on this v2 ?

Yes, it's on my radar. I plan to test the emmc backend on Khadas VIM3. I
have not gotten to it yet, but will do this week.

Thank you for your patience.
Mattijs

>
> Thanks,
> Neil
>
>> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v2:
>> - Dropped applied virtio erase patch
>> - Reorganize patches, introducing helpers first, using them in mmc afterwards
>> - Added soft-erase logic
>> - Added move helpers to handle the partitions erase & flash from emmc
>> - Fixed const var on last patch
>> - Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/
>> 
>> ---
>> Dmitrii Merkurev (3):
>>        fastboot: blk: introduce fastboot block flashing support
>>        fastboot: blk: switch emmc to use the block helpers
>>        fastboot: integrate block flashing back-end
>> 
>>   drivers/fastboot/Kconfig      |  20 ++-
>>   drivers/fastboot/Makefile     |   4 +-
>>   drivers/fastboot/fb_block.c   | 313 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/fastboot/fb_command.c |   8 ++
>>   drivers/fastboot/fb_common.c  |  16 ++-
>>   drivers/fastboot/fb_getvar.c  |   8 +-
>>   drivers/fastboot/fb_mmc.c     | 210 ++--------------------------
>>   include/fb_block.h            | 104 ++++++++++++++
>>   8 files changed, 477 insertions(+), 206 deletions(-)
>> ---
>> base-commit: f892a7f397a66d8d09f418d1e0e06dfb48bac27d
>> change-id: 20250408-topic-fastboot-blk-c5e14cd59224
>> 
>> Best regards,
