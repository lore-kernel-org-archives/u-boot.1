Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14CAC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 04:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FCD87F69;
	Tue, 26 Mar 2024 05:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711426922;
	bh=EiTa9Ev3NxOJYQ/2OYKYLaSzD36SCAM832BAM7Ncpf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=IEYxC79qgIY9RzdZCWxYtCyWEzwFLT97Vof5HL1LiLR3x7xl85v/RAL3OfPgoKSsC
	 5q+HDInsyLDT+XWnsXOaMo0GnHJpEmvtRdx9fDvWBxVtr4TOzwHjumdB+LJxum7L9y
	 KnOZJl+wWHOqWcB3V3DXxfbpvSDMou9fVl4uZzYNvvgzBAWauQQ71yPp3AmLVonB2P
	 TE9lyKVYnWVkf9o92AHJMxsvM0AF+6f+GwTojj5lYILAc6riCBPITaJZezVqgfZ9Jz
	 oxUV9a3NPsrDEiO94en7Teq4BAYDJfmDYTg7BrM1JeLOBigV/Frf55utBagtNXXZNE
	 89fIjUmicEMuA==
Received: from [192.168.1.107] (87-97-112-25.pool.digikabel.hu [87.97.112.25])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF84780E9A;
 Tue, 26 Mar 2024 05:21:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711426920;
 bh=EiTa9Ev3NxOJYQ/2OYKYLaSzD36SCAM832BAM7Ncpf8=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=NI9OJBueEs/RwPrwIQWDvh5L9JlklxsGljA6QIIRt+4JbOuuHFT1I6jg+5Lp6jZxB
 bJZOL60UtBkEpBdS/O14P53x/ysbOCL8cxjk/9Yga6ubqflwaY26IIMvF2nkfxyha7
 U1V//uiuq2ZYPRipEdpDza8HqWoX6o3MGl76bcnqIxVj7XwtaSmdEXTBG/zj/aluAU
 mbWnx5maObvwaat66agf9HLUEaUtV4Llkbke8kEDkqNzHS4qKkeMHGk5OnlqXcOEwv
 6AOwwfSVE0buREOdr1wRy0knScJZmZ2fPUTWiIKsnGhTWQvLyCLlZsOwTT4pNQeZRM
 iQyXat/FGj5gw==
Message-ID: <b5ab190f-6bcd-9cdc-ec91-6a9178ef9d9a@denx.de>
Date: Tue, 26 Mar 2024 05:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de,
 michael@amarulasolutions.com, frieder.schrempf@kontron.de,
 kmpark@infradead.org, joe.hershberger@ni.com, dunaev@tecon.ru,
 sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240325144148.3738195-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexey,

On 25.03.24 15:41, Alexey Romanov wrote:
> Hello!
> 
> This series adds support for the UBI block device, which
> allows to read/write data block by block. For example,
> it can now be used for BCB or Android AB command:
> 
>    $ bcb load ubi 0 part_name
> 
> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers. Can be used with mtdblock device [1].
> 
> ---
> 
> Changes V1 -> V2 [2]:
> 
>   - Rebased over mtdblock v2 patchset [3].
>   - Compile UBI partitions support only if CONFIG_BLK option
>     is enabled.

Thanks!

> - Links:
> 
>    [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
>    [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salutedevices.com/
>    [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salutedevices.com/
> 
> Alexey Romanov (6):
>    ubi: allow to read from volume with offset
>    ubi: allow to write to volume with offset
>    drivers: introduce UBI block abstraction
>    disk: don't try search for partition type if already set
>    disk: support UBI partitions
>    spinand: bind UBI block
> 
>   cmd/ubi.c                   |  77 +++++++++++++++++++--
>   disk/part.c                 |   7 ++
>   drivers/block/blk-uclass.c  |   1 +
>   drivers/mtd/nand/spi/core.c |   8 ++-
>   drivers/mtd/ubi/Makefile    |   1 +
>   drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
>   drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
>   env/ubi.c                   |  16 ++---
>   include/part.h              |   2 +
>   include/ubi_uboot.h         |   8 ++-
>   10 files changed, 332 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/mtd/ubi/block.c
>   create mode 100644 drivers/mtd/ubi/part.c

Looks good to me now.

@Dario: I saw that series is delegetad to you in patchwork.
  From my side it is fine. If you think I should  pick it up, please
  send a Reviewed/Acked-by for the SPI NAND parts, and notify me,
  thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
