Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEA3E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 06:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D6798036B;
	Tue, 31 Dec 2024 07:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h/yM8Kz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F358037B; Tue, 31 Dec 2024 07:28:37 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBC88021D
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 07:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BV6SWZK1887123
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Dec 2024 00:28:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1735626512;
 bh=uPHue1HaXGwFv4l8Xybc2VEqzhZNJWkDAAjXPIAqOWI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=h/yM8Kz73v/3Fx4BjZ9WrBPWuJSmx8yY2Pp82/2g8b/ywqoMiHgVX5mCEvccv6Eyl
 wxRM07rQEBvJcjfuJ4kDhqCfT1itBM8yMoz8a8i0xbawN7Tdftm7oHdd4y6g/L9qp4
 bNsQuMt+ZojKy6fRu19FTYIbqwg53W7XIS7E9M40=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BV6SWLn120061
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Dec 2024 00:28:32 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Dec 2024 00:28:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Dec 2024 00:28:31 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BV6ST30038953; 
 Tue, 31 Dec 2024 00:28:30 -0600
Message-ID: <228b234e-9483-4102-8cf3-5cf8c893381d@ti.com>
Date: Tue, 31 Dec 2024 11:58:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with "Cleanup dma device in spl and move dma channel[0]"
 series and am64
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <s-k6@ti.com>, Prasanth Babu Mantena
 <p-mantena@ti.com>
References: <20241230174203.GD3476@bill-the-cat>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20241230174203.GD3476@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi, Tom,

On 30/12/24 23:12, Tom Rini wrote:
> Hey all,
> 
> As part of testing the SPI fixes, I tracked down a problem on my AM64X
> SR1.0 GP to the above series. With the series applied, I get:
> => sf probe
> jedec_spi_nor flash@0: non-uniform erase sector maps are not supported yet.
> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
> => sf read $loadaddr 0 4000
> device 0 offset 0x0, size 0x4000
> ti-udma dma-controller@485c0000: k3_dmaring Ring probed rings:288,
> sci-dev-id:30
> ti-udma dma-controller@485c0000: dma-ring-reset-quirk: disabled
> ............................... (never ends).
> 
> With the series reverted:
> => sf probe
> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total 64 MiB
> => sf read $loadaddr 0 4000
> device 0 offset 0x0, size 0x4000
> SF: 16384 bytes @ 0x0 Read: OK
> =>

A fix for this issue has already been provided (not merged yet).

Patch: 
https://lore.kernel.org/u-boot/20241218130045.2070314-1-p-mantena@ti.com/

With this fix:
=> sf probe
SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, 
total 64 MiB
=> sf read $loadaddr 0 4000
device 0 offset 0x0, size 0x4000
SF: 16384 bytes @ 0x0 Read: OK
=>

Regards,
Santhosh.

> 
