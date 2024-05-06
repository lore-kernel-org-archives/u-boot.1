Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC4C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2981987D8E;
	Mon,  6 May 2024 16:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715004279;
	bh=nnA3Z53pLGvEK/GNLVnhECFHlfhg2JF1fpc4XYBCnT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DhBmAZmj7fIvUUNwkYycH0ylqwZ8mZxciE1b89jfXgl9U5TKyR9VApoj+pWLkSDd3
	 /9MToLtVmjJuLYgeoyyuIFyU+jN7m6tcpuEep9s/vbtkFF9NZzEs9xTm8UkHuE4o5N
	 noHh8g9PAfFDlkUDURGcP7G42QWVcKX/toO7m8Zk6Xoua+4zyC8XOV1ni5wk/q4uFd
	 MQzKha8Z4pvDpGJOX/AoGzHGf/r+Wxry2fAUvW8Tf7ooH3q8H3JXe8mJOYgOnlfy2h
	 rA5IURx1RS75cNdNfZUsCAvzp99day+8xnOKqjxsVYVIMMdNubN8YbNrvvfnluxA0g
	 BKnnxgHEcvbBg==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E2ACC80E9A;
 Mon,  6 May 2024 16:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715004278;
 bh=nnA3Z53pLGvEK/GNLVnhECFHlfhg2JF1fpc4XYBCnT0=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=vB/48tgVfzUVY4+Dzy+o+jy8lWhLuOXRCjvqiiMaaPd7shHZ/Bbhx5ZCucATFjE2P
 Af52r2LDoBSaLCnZ+o2IrpRgRvyeNATw90tlTvDg4PwJ4lZUTJH01sxcRT77n6sKcs
 tZf0XTH+n/JbD1/40/rMLSFxc4s/LeqAk/3+U9ZIW6TxzaB0Y9yqFrTEr09ggOLHMw
 A+o+3fPMmiT0OBdMGFYVx0CFsZDrzRe7+t9qrnzrhp62G7K9s0j89vrtVmtyLmyN5N
 QbOErxajydKcEQnsY2sfWOboLRz6qgeC3iISuAjBamGrWUQXFJTXhb0MAYGUwHF2jF
 +8kSNdDxBr8LA==
Message-ID: <6ac44ced-60b5-73fc-f696-9f769dbf59cf@denx.de>
Date: Mon, 6 May 2024 16:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 "dario.binacchi@amarulasolutions.com" <dario.binacchi@amarulasolutions.com>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "kmpark@infradead.org" <kmpark@infradead.org>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "dunaev@tecon.ru" <dunaev@tecon.ru>, "sjg@chromium.org" <sjg@chromium.org>,
 "bmeng@tinylab.org" <bmeng@tinylab.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "tobias@waldekranz.com" <tobias@waldekranz.com>,
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>,
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>
Cc: kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
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

On 06.05.24 15:58, Alexey Romanov wrote:
> Hello! Ping.

okay from my side... I think I acked them already

@Dario: IIRC the patchset is delegated to you...

If it is okay, I can apply it in u-boot-ubi and send a pull request to
Tom, but please, send a Acked-by or Reviewed-by and delegate it back to me!

Thanks!

bye,
Heiko
> 
> On Mon, Mar 25, 2024 at 05:41:42PM +0300, Alexey Romanov wrote:
>> Hello!
>>
>> This series adds support for the UBI block device, which
>> allows to read/write data block by block. For example,
>> it can now be used for BCB or Android AB command:
>>
>>    $ bcb load ubi 0 part_name
>>
>> Tested only on SPI NAND, so bind is made only for
>> SPI NAND drivers. Can be used with mtdblock device [1].
>>
>> ---
>>
>> Changes V1 -> V2 [2]:
>>
>>   - Rebased over mtdblock v2 patchset [3].
>>   - Compile UBI partitions support only if CONFIG_BLK option
>>     is enabled.
>>
>> - Links:
>>
>>    [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
>>    [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salutedevices.com/
>>    [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salutedevices.com/
>>
>> Alexey Romanov (6):
>>    ubi: allow to read from volume with offset
>>    ubi: allow to write to volume with offset
>>    drivers: introduce UBI block abstraction
>>    disk: don't try search for partition type if already set
>>    disk: support UBI partitions
>>    spinand: bind UBI block
>>
>>   cmd/ubi.c                   |  77 +++++++++++++++++++--
>>   disk/part.c                 |   7 ++
>>   drivers/block/blk-uclass.c  |   1 +
>>   drivers/mtd/nand/spi/core.c |   8 ++-
>>   drivers/mtd/ubi/Makefile    |   1 +
>>   drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
>>   drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
>>   env/ubi.c                   |  16 ++---
>>   include/part.h              |   2 +
>>   include/ubi_uboot.h         |   8 ++-
>>   10 files changed, 332 insertions(+), 17 deletions(-)
>>   create mode 100644 drivers/mtd/ubi/block.c
>>   create mode 100644 drivers/mtd/ubi/part.c
>>
>> -- 
>> 2.34.1
>>
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
