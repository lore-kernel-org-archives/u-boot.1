Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26FFC54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 05:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190A687CDB;
	Sat, 23 Mar 2024 06:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711170168;
	bh=AKo8n/uWeQfaKs+6ZvffkPSJNzZo6TsXUfJHx+z1gdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=tBZrSt2OeXnshzHoNa4Fh0/mNKQwNn8B79YXnCzSpkGRJW60xwsdPsu49uyUeDnyp
	 0f0b309bP+Tv1tqYzyPNJc4KaKfDznp7ehWYvlRFztwZZwiGZ+k7P7VmkBvxnzYAhf
	 C+kwCq7uSf6x9ycCUFlx/EQTt5+EAV1eq4fH34B+cTkwQMSWO7biBxuFTC6+y50GJn
	 I/qwZWguilApiLYIF/IKT/V+Kjn1QxXFiPrIGLmfNPLsMh/oy6I0kGEEgtnT/SKnPt
	 0wqXCvhKZgH3jFkn76YNIY8Lkf9FvF20PI1gdcoFUyOAaM4plQyn24WwNlARW7a05c
	 nM3Pr4Tfj2aPw==
Received: from [192.168.1.107] (82-131-203-241.pool.digikabel.hu
 [82.131.203.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C466F879CC;
 Sat, 23 Mar 2024 06:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711170166;
 bh=AKo8n/uWeQfaKs+6ZvffkPSJNzZo6TsXUfJHx+z1gdA=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=WYewoyOMNzhbjLYnvd1GM0DeAIN5EiksshNDD+DBJzO4w6K7Edsmo1syxRl/+Y+8L
 9yza7IsI84U4juN2nMTFYMa/Lep7eacBD/TmFVkoPGyvjOIBAHkI/pAaNohAFSbRak
 AGoD0pSAJq+Pn3lADzdwljSkdjAJBUWPC7E9ifI6GD5L6BalzHBbpez2KLPVsmy+DP
 OvUq61WQSy1D8ybdZaacAmo/DH3yANevUpnMjvUgFqZVGftxJXXt+oxJSKtGAxxKwL
 vjrixfw/0YwMZRaopvynSvArQaVeSni1LUSJWA3/sW6fG8ur4kXIxrf5cRbQ2yeDL5
 J3P9xg4miZwoQ==
Message-ID: <3a136dc3-209f-70cb-7012-8f1db6a6d601@denx.de>
Date: Sat, 23 Mar 2024 06:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 3/6] drivers: introduce UBI block abstraction
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
 <20240306134906.1179285-4-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240306134906.1179285-4-avromanov@salutedevices.com>
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

On 06.03.24 14:49, Alexey Romanov wrote:
> UBI block is an virtual device, that runs on top
> of the MTD layer. The blocks are UBI volumes.
> Intended to be used in combination with other MTD
> drivers.
> 
> Despite the fact that it, like mtdblock abstraction,
> it used with UCLASS_MTD, they can be used together
> on the system without conflicting. For example,
> using bcb command:
> 
>    # Trying to load bcb via mtdblock:
>    $ bcb load mtd 0 mtd_partition_name
> 
>    # Trying to load bcb via UBI block:
>    $ bcb load ubi 1 ubi_volume_name
> 
> User always must attach UBI layer (for example, using
> ubi_part()) before using UBI block device.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/block/blk-uclass.c |   1 +
>   drivers/mtd/ubi/Makefile   |   1 +
>   drivers/mtd/ubi/block.c    | 130 +++++++++++++++++++++++++++++++++++++
>   include/ubi_uboot.h        |   4 ++
>   4 files changed, 136 insertions(+)
>   create mode 100644 drivers/mtd/ubi/block.c

Reviewed-by: Heiko Schocher <hs@denx.de>
Acked-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
