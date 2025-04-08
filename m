Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9E5C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 08:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D4A831BB;
	Tue,  8 Apr 2025 10:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744102226;
	bh=A+iSf1f51tcVJ1pp9R6ovreCe64cQOWcai3WhnztmV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dg9FAitvzx/T552l7vrJzLu1fzYW0Hnu/IcA44lr1TeiKkOhapHo1juQEci06Ox6W
	 JGTuBNRr1sE3KgPB3//HKu04+px61mhBDCvJTi2WFmXj7kneZLgNwALn8psug/qyga
	 4VEXOUnV34aStEA/Wkem9bn36PR9T4U5mM5vKrqa8AD8G5gENN7xMKPaurb3TbALb0
	 EjbYdwhx+6pv+xYjufDRmTN7ymm7E+4nAusvEwMBxzP2hmHYQ6FN82ElTWAYGh5haH
	 gJvZRlQ0w73bjNtQUCFo/2BiB4UKwQUTuMYIyvaehgLiDAxF5oO+FgFtq+6d1FB4yB
	 gmZul//NGA+4w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2467831BE; Tue,  8 Apr 2025 10:50:25 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A4482FAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ibdoigTH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B4836102EBA47; 
 Tue,  8 Apr 2025 10:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744102223;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=A+iSf1f51tcVJ1pp9R6ovreCe64cQOWcai3WhnztmV8=;
 b=ibdoigTHXnNaRhKuW6k2CnA/pyaZmg5SbDfHy/QBauNHjuFPHJuS0IhI4whwHHy+YyMuIZ
 sAwsR7HRTXAHsZzgELLpZO9wv4mJyj3UDQ3g90fIpMHrPHSj88kNTDmMWGQF/lG5oY+EnO
 OJrCJzqYUvhSyU8N3keAHg5ok3zioLPChdU0KdKw5et54bEXSSsKv/1v/y9zyjlYBqsqjD
 POEC6YgYnF15YYTzUrD/4tSbbxDpzAw7DcyAOh7nqPkg2Q2n9wlfwCPgLa5N0ELMxcHIYB
 Bx8q17cV/MRn1CZMTJo5OW4K4TNOfTmxW4E9V90HxWg08rkO1+ahXt9toLTgig==
Message-ID: <9dcb2e25-0f4d-b2ab-3ef1-a1d598669c17@denx.de>
Date: Tue, 8 Apr 2025 10:50:48 +0200
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

Applied to u-boot-ubi master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
