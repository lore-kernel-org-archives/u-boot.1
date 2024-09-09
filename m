Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4DDCE7AB0
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 07:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F06A889EB;
	Mon,  9 Sep 2024 09:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="J0lCzv7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A3788D20; Mon,  9 Sep 2024 09:04:23 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE31088972
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=975437dda=Nicolas.Ferre@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1725865461; x=1757401461;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=u/TZc7BIMZzKIJxu4ftFlI09bdHhJuyD04RdQM8eHdo=;
 b=J0lCzv7D9zoGBvYy/WtHuGvY2tuf4ryEIs69VYJiYOpttAY0In7mKPmp
 x4TjvnYYxREvk0Iw0ZwrpuRieQct2AgNfdtiuQF95REd3+Q82+9qOU4e8
 l/3pFtU8ImZ46k4rKI5jTaJJiTBksUOPc0BZtv3IecI1lxE3L/h1bWTEt
 r7V1wLb5t1F7f+kdkcmMdNw/PafQTKS4ZoHYKaXsLfYnmAEqVeXLOvW3B
 y0o8s+//mteN7xp0Jmzc6kK7s1Y0jf0Y6x6xJ3arSdddL2UdmXlrMAyAj
 tQMFQHJXgF1d/vv95HJHGMUFf7DpUH3bXEtFk2R+H0Uv+rZxtRsEGSbqy g==;
X-CSE-ConnectionGUID: NzPC+/wSSiWdZilXWWmGPQ==
X-CSE-MsgGUID: 6YksDOvWQ5KqIo1XbHCp5w==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; d="scan'208";a="31492046"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Sep 2024 00:04:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 00:03:56 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 00:03:55 -0700
Message-ID: <b0431751-671f-48c2-b538-9673a99b3cda@microchip.com>
Date: Mon, 9 Sep 2024 09:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove ethernut5 board
Content-Language: en-US, fr-FR
To: Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Harald Kipp <harald.kipp@egnite.de>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
References: <20240907222013.10298-1-trini@konsulko.com>
 <01020191d55419f4-a227619d-862f-4a38-8189-201657cba472-000000@eu-west-1.amazonses.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <01020191d55419f4-a227619d-862f-4a38-8189-201657cba472-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 09/09/2024 at 07:49, Eugen Hristev wrote:
> On 9/8/24 01:20, Tom Rini wrote:
>> As per the maintainers at egnite GmbH, they are no longer interested in
>> supporting this board. Go and remove the platform here. Furthermore,
>> this is the only AT91SAM9XE platform in-tree so remove supporting code
>> for that as well.
>>
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> Cc: Harald Kipp <harald.kipp@egnite.de>
>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> 
> CC: Alexandre Belloni, Nicolas Ferre

Fine with me, thanks for letting me know:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

>> ---
>>   arch/arm/dts/Makefile                         |   2 -
>>   arch/arm/dts/at91sam9xe.dtsi                  |  60 ----
>>   arch/arm/dts/ethernut5.dts                    |  96 ------
>>   arch/arm/mach-at91/Kconfig                    |  24 --
>>   arch/arm/mach-at91/arm926ejs/Makefile         |   2 -
>>   arch/arm/mach-at91/arm926ejs/eflash.c         | 255 --------------
>>   arch/arm/mach-at91/include/mach/at91_dbu.h    |  37 --
>>   arch/arm/mach-at91/include/mach/at91_eefc.h   |  47 ---
>>   arch/arm/mach-at91/include/mach/at91sam9260.h |  12 +-
>>   arch/arm/mach-at91/include/mach/hardware.h    |   3 +-
>>   board/egnite/ethernut5/Kconfig                |  12 -
>>   board/egnite/ethernut5/MAINTAINERS            |   6 -
>>   board/egnite/ethernut5/Makefile               |  10 -
>>   board/egnite/ethernut5/ethernut5.c            | 198 -----------
>>   board/egnite/ethernut5/ethernut5_pwrman.c     | 323 ------------------
>>   board/egnite/ethernut5/ethernut5_pwrman.h     |  51 ---
>>   configs/ethernut5_defconfig                   |  87 -----
>>   doc/board/atmel/at91ek.rst                    |   4 +-
>>   drivers/bootcount/Kconfig                     |   1 -
>>   include/configs/at91sam9260ek.h               |   6 +-
>>   include/configs/ethernut5.h                   |  88 -----
>>   21 files changed, 6 insertions(+), 1318 deletions(-)
>>   delete mode 100644 arch/arm/dts/at91sam9xe.dtsi
>>   delete mode 100644 arch/arm/dts/ethernut5.dts
>>   delete mode 100644 arch/arm/mach-at91/arm926ejs/eflash.c
>>   delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbu.h
>>   delete mode 100644 arch/arm/mach-at91/include/mach/at91_eefc.h
>>   delete mode 100644 board/egnite/ethernut5/Kconfig
>>   delete mode 100644 board/egnite/ethernut5/MAINTAINERS
>>   delete mode 100644 board/egnite/ethernut5/Makefile
>>   delete mode 100644 board/egnite/ethernut5/ethernut5.c
>>   delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.c
>>   delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.h
>>   delete mode 100644 configs/ethernut5_defconfig
>>   delete mode 100644 include/configs/ethernut5.h

[..]

