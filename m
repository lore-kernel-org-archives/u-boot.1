Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E76C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 08:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3FE08070C;
	Thu, 27 Mar 2025 09:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743065336;
	bh=5m/ohJsGYT42gtM94G+R81pp3jCr87uyN0A0pQ58EqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uF/KPhjv/f40TzOyBUU01Bprimt1wB2Ubm6kHPgLsM+vPKc11CLk742mNg2pgatHL
	 3AzUYU932Usxo2qYTpKAOC9AwLAmuP8SSQXAdNdHNBG0j7PzZMuwrXUyEV7xJrZAQa
	 xryLgmOiDc8rGZDfS7fwlgDtFNruLNT+cLPuNAfNUfcymks37kgu6heJbFPg0n+0UJ
	 /8TI+36EQRfBPBo5DL8JasUbEBtVwEQB+Js8TeEU/idJ3VyJhHFFoBNQ4quOJ528t9
	 ZrS/uaHJLqOM8AFtVEGakpsIN2RTUTVz+zB6bWYwnrtEpzl8/+rF3pI/Qfz2h9wYJq
	 KghElZJBKacLg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD72181B4B; Thu, 27 Mar 2025 09:48:54 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A4F81951
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TFhVXkpx"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F1F60102901EB; Thu, 27 Mar 2025 09:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743065331;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5m/ohJsGYT42gtM94G+R81pp3jCr87uyN0A0pQ58EqA=;
 b=TFhVXkpxLxjMjWq+HCV2rvbeO2HsKE4Pzh70V7jsiza44oXRL5jGWhiMV2dvdvZn7GdcDU
 spK+d6zBBdCimKCS+o2N6tAaOYaHWkOFAJzcRPUuaiiqN5usoDzwjymsujoJfIcJ452t9b
 guZ1XnNXQVjIXx2flLcp+D2svwwkFJzonDVflaAAGK/n7MMBO825N21JxR2l3/1qIPwHbO
 aDBfd/AJVO1mS5hoTLZc2bIJc1+OPPOS0t+/PZeAUXIFT74Fy2nGaYB9ddh8QeQ4M9HHfn
 +ttxqXL1cyytoKm0CsX2QfpDiME1MiBZlVh+dSoSoiQraNf+9vi2qaI0NJEi3w==
Message-ID: <abb1012e-fb58-c2f3-382b-ed4050fd0459@denx.de>
Date: Thu, 27 Mar 2025 09:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] ubi: fix bug creating partitions for non-existent
 volumes
Content-Language: en-US
To: Oskar Nilsson <onilsson@rums.se>, u-boot@lists.denx.de
Cc: Kyungmin Park <kmpark@infradead.org>,
 Alexey Romanov <avromanov@salutedevices.com>
References: <20250326092257.443785-1-onilsson@rums.se>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250326092257.443785-1-onilsson@rums.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Oskar,

On 26.03.25 10:22, Oskar Nilsson wrote:
> The part_get_info_ubi() function was incorrectly returning 0 (success)
> when a UBI volume was not found for a given partition index. This caused
> the part_create_block_devices() function in blk-uclass.c to continue
> creating devices for non-existent partitions up to MAX_SEARCH_PARTITIONS
> 
> Fix the issue by returning -1 when a volume is not found, signaling to
> the part_create_block_devices() function that no more valid volumes
> exist.
> 
> Before patch, 128 blk_partition are created:
> Class   Index  Probed  Driver        Name
> -------------------------------------------------
> root        0  [ + ]  root_driver    root_driver
> thermal     0  [   ]  imx_thermal    |-- imx_thermal
> simple_bus  0  [ + ]  simple_bus     |-- soc
> mtd         0  [ + ]  mxs-nand-dt    |   |-- nand-controller@1806000
> blk         0  [   ]  ubi_blk        |   |   `-- nand-controller@1806000.blk
> partition   0  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:1
> ...
> partition 127  [   ]  blk_partition  |   |       `-- nand-controller@1806000.blk:128
> 
> 
> After patch, the expected blk_partition are created:
> Class   Index  Probed  Driver        Name
> -------------------------------------------------
> root        0  [ + ]  root_driver    root_driver
> thermal     0  [   ]  imx_thermal    |-- imx_thermal
> simple_bus  0  [ + ]  simple_bus     |-- soc
> mtd         0  [ + ]  mxs-nand-dt    |   |-- nand-controller@1806000
> blk         0  [   ]  ubi_blk        |   |   `-- nand-controller@1806000.blk
> partition   0  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:1
> partition   1  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:2
> partition   2  [   ]  blk_partition  |   |       |-- nand-controller@1806000.blk:3
> partition   3  [   ]  blk_partition  |   |       `-- nand-controller@1806000.blk:4
> simple_bus  1  [ + ]  simple_bus     |   |-- bus@2000000
> 
> Signed-off-by: Oskar Nilsson <onilsson@rums.se>
> Cc: Kyungmin Park <kmpark@infradead.org>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Alexey Romanov <avromanov@salutedevices.com>
> 
> Changed in v2:
>   - Change return from -1 to -ENOENT
> 
> ---
>   drivers/mtd/ubi/part.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko


-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
