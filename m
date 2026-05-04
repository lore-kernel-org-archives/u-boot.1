Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE51CCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 19:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAD9846A1;
	Mon,  4 May 2026 21:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DNrwpGrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F584846B4; Mon,  4 May 2026 21:28:10 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0E6846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 21:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso55664025e9.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777922884; x=1778527684; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NAo+BFnJIRGDTFWhORXL1m8l80w6SDWI767Vl/2XEx0=;
 b=DNrwpGrWWTmiPiNQ9zDzKGXT2epW6ffQPpQCOdaWSsMfhAVGDwTB0EnHmwJa5fNDAn
 SPJ7+OZUP+xHXQkkBlTFq3nPiCAUWwlCzUCvXJ2T9tO9FqXvaLAZ85Ddl2xfh64zv6zN
 OvMRRCMjKVVhCFaz05oaM4fg2e8ijXb8wokzSh+RBz3FzJgEv0YYjzHRr4bdRIXH0htH
 KbSqQ4lFZvs6gvGMGJ6SFMe2pyl7WZIKf+TyctrZF7fxo1CK41aDKdhBjCMpS1w6n8Iz
 KVGxrxaG3Jvq527r5/WAcq9XV8mSD5xicNL+jhPZUwKy1gAZSJF4JIlXrSnMYMR/KV0I
 lGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777922884; x=1778527684;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NAo+BFnJIRGDTFWhORXL1m8l80w6SDWI767Vl/2XEx0=;
 b=djb3a7XDLbCpfQ16ZRmmxGHhbOsTAFiCcLaJSXQM6w2R65sapW5k/fp8cCfe2QMDc2
 NXMy0ptGP1DFRVXv+8pJhmNzd5ejF+uW7t2LAlwoBWziXANGArByw0XCt34BHvfRNGE5
 haPiYczJX6XQhJYeattvLe2q+aDBldO2Fcds0XBQkVzhkKb9CVRPA7kk41++3b+iAYC8
 pEWii/e/77n6RKagml44csx3ZRS6NJ35ULKyFPfNqAwR1h0jfOaSFETWny5AxVR8VUdm
 F4d1fjeGIF+EuP/n0JkTweBDx0wb0BEa8WVrRBlATr5WZbS7DEQsvPtS+jOec/Lmn7rE
 JFqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9M/bh/uq5lByF4fXpm4soC5MKvyA1v5lG4vZ8V2t6aaedjoNJXcrzSCUA2mXT3od2CYDW/hY8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx32JK2l40T1odKU/+NcMMv4VE4OJM89cJMZUxe2ENfZ2GciuM+
 8hS6XNTLLYYps4C0qUlAJvLEmeS7q6x0wyw+Ey0GxMw7BHT70NMKHeu4ya1NKSH8138=
X-Gm-Gg: AeBDievE2qSBm90OZs2tFYOM+zqn0CEO8MkvE7EFMIaQUC9M2zEqVkSLzoBpue2WFpu
 qIvVaJe7w60B8vVdpletnSfWCSHIivGnaCc/tHNsWyB68l2cdv11f9OhuVp/j9pPll2UUjDK5VF
 QXtpcsCQUJuMJFwmwaV5LUrnao4b9GzBakQ55bdrj3tShvBO68DJtuWLFewvgi48TUkyuF+NWQi
 GWAz17oggBuEORCGpBAQSMknRN9+efV0SvAT8JNAjceVxRaaFtolYDi8Ec3UGLF2MmnRZcJXtYO
 rLbWhp6FPBG9vOmjaKNxtnNq42CEGNaGOqEwyOBupSGn/HVulUhbpUA2WtUn6f8bbCQGyhdoOMz
 x4yMMWx0r0qomsz0kXtR9D6Bz/LxMTzqSwmiri6lLWaQJbB8BcHgXsubHwjTBZzaIvkJymaa0q6
 fqzNvOw1JNKG/gTwKz+UKxt4iUbpZkRfEaqgZ/YUp66tsBbLbSKN1A9rseRA+b1tQy7g5D1z5XJ
 ZV2
X-Received: by 2002:a05:600c:797:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-48d035e8304mr80328695e9.28.1777922884249; 
 Mon, 04 May 2026 12:28:04 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebc4201sm471040195e9.15.2026.05.04.12.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 12:28:03 -0700 (PDT)
Message-ID: <e58ae7b3-637d-4169-86e6-f882fb33dce8@linaro.org>
Date: Mon, 4 May 2026 21:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sughosh.ganu@arm.com,
 ilias.apalodimas@linaro.org, gchan9527@gmail.com, mchitale@ventanamicro.com,
 maximmosk4@gmail.com, jonas@kwiboo.se, marek.vasut@mailbox.org,
 quentin.schulz@cherry.de, peng.fan@nxp.com, sajattack@postmarketos.org,
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com,
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com,
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com,
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Aswin, Sumit,

Sorry it's taken a while, you should have the new version of the SMEM
revamp in your inbox now (or here
https://lore.kernel.org/u-boot/20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org/)

I used the header from this series with some cleanups. You should be
able to rebase on that and we can get this series moving forwards a bit
more.

On 17/04/2026 14:09, Aswin Murugan wrote:
> This series adds dynamic device tree selection from FIT images for
> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> appropriate DTB based on hardware parameters detected from SMEM.
> 
> Qualcomm fit based DTB format is documented in [1]
> The fit image contains only DTB, while the kernel will be part of UKI image.
> 
> The implementation consists of three parts:
> 
> 1. SMEM cache infrastructure: Provides cached access to commonly
>    used SMEM data (socinfo, RAM partitions) to avoid redundant
>    lookups during boot. Includes socinfo header from Linux kernel
>    for SoC identification.

I think this abstraction is at the wrong layer, you shouldn't be
accessing SMEM in a hot path, it seems more like your "cache" here is
just the state of the FIT parsing state machine? In which case it would
be much better modelled as a state object rather than spreading the
state around a bunch of wrapper functions.

> 
> 2. FIT multi-DTB selection: Implements the core selection logic
>    that reads hardware parameters from SMEM, parses metadata DTB,
>    matches FIT configurations, and loads the selected DTB with
>    overlays. Integrates with EFI boot flow by setting fdt_addr.

The way this code is currently laid out generally makes it quite
confusing to parse, as with my previous point I think you should rewrite
this to first get all the data you need together in one struct and
translate it into suitable formats (e.g. if you only need a few things
from socinfo then just get those and don't carry around a big socinfo
pointer where it isn't clear which properties are actually used).

Stuff like the IMEM cookie should be in it's own abstraction maybe under
drivers/soc/qcom that only exposes the properties that actually make sense.

This would then let you bring down the size of this huge file so it's a
bit more manageable.

Some properties like the mem_card_type from IMEM would be extremely
useful for simplifying the capsule update code for example, so having
this as a separate abstraction would greatly improve things.

Thanks and kind regards,

> 
> 3. mkimage: add fatfs image type for FAT partition images
>    Added fatimage.c handler that uses mkfs.vfat and mcopy to create
>    FAT images from a directory.
> 
> [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md
> 
> ---
> Changes in v3:
> 1. Runtime IMEM address lookup via DT: Removed CONFIG_QCOM_IMEM_SIZE Kconfig option.
>    Added qcom_imem_table[] mapping SoC compatible strings to IMEM addresses.
> 
> 2. Split SoC version sources: SoC hardware version now read from TCSR register via
>    qcom_read_tcsr_soc_version(). The soc_info->plat_ver from SMEM is stored separately
>    as board_version. Added socver and boardrev metadata node matching for finer-grained DTB selection.
> 
> 3. qcom_load_fit_image() returns int: Changed return type from efi_status_t to int,
>    returning standard Linux error codes for consistency with the rest of the driver.
> 
> 4. Code cleanup: strtok() replaced with strsep(); memcpy + manual null-termination replaced with strlcpy();
>    DDR thresholds use SZ_* macros; compatible matching and FDT loading extracted into dedicated helpers.
> 
> 5. image: add IH_TYPE_FATFS image type: Added new fatfs image type to represent a raw FAT
>    filesystem partition image, registered in the image type lookup table.
> 
> 6. mkimage: add fatfs image type for FAT partition images: Added fatimage.c handler that
>    uses mkfs.vfat and mcopy to create FAT images from a directory.
>    New --fat-extra-space, --fat-type, --fat-volume-id, --fat-mkfs-opts long options added
>    to mkimage.
> 
> 7. doc: document mkimage fatfs type and Qualcomm multi-DTB: Updated 'doc/mkimage.1' for the new
>    fatfs type and options. Added 'doc/board/qualcomm/multi_dtb.rst' covering FIT ITS configuration,
>    QCOM metadata format, socver/boardrev guidelines, and image creation steps.
> 
> Link to v2:
> https://lore.kernel.org/u-boot/20260129184817.224101-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v2:
> - In v1, a combined DTB format was used for multi-DTB support. Based on
>   feedback, v2 implements FIT-based DTB selection instead.
> - Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/
> 
> Aswin Murugan (7):
>   mach-snapdragon: Add generic SMEM cache infrastructure
>   mach-snapdragon: Add FIT multi-DTB selection support
>   configs: snapdragon: Enable FIT multi-DTB and configure IMEM
>   image: add IH_TYPE_FATFS image type
>   mkimage: add fatfs image type for FAT partition images
>   doc: document mkimage fatfs type and Qualcomm multi-DTB
>   mach-snapdragon: Reorder header includes
> 
>  arch/arm/mach-snapdragon/Kconfig             |    8 +
>  arch/arm/mach-snapdragon/Makefile            |    1 +
>  arch/arm/mach-snapdragon/board.c             |  123 +-
>  arch/arm/mach-snapdragon/qcom-priv.h         |   24 +
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1103 ++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  189 +++
>  arch/arm/mach-snapdragon/rampart.h           |  225 ++++
>  boot/image.c                                 |    1 +
>  configs/qcom_defconfig                       |    2 +
>  doc/board/qualcomm/index.rst                 |    1 +
>  doc/board/qualcomm/multi_dtb.rst             |  352 ++++++
>  doc/mkimage.1                                |  103 ++
>  include/image.h                              |    1 +
>  include/soc/qcom/socinfo.h                   |  114 ++
>  tools/Makefile                               |    1 +
>  tools/fatimage.c                             |  495 ++++++++
>  tools/fatimage.h                             |   25 +
>  tools/mkimage.c                              |   21 +
>  tools/mkimage.h                              |   15 +
>  19 files changed, 2793 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
>  create mode 100644 arch/arm/mach-snapdragon/rampart.h
>  create mode 100644 doc/board/qualcomm/multi_dtb.rst
>  create mode 100644 include/soc/qcom/socinfo.h
>  create mode 100644 tools/fatimage.c
>  create mode 100644 tools/fatimage.h
> 

-- 
// Casey (she/her)

