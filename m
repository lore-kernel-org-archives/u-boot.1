Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2268ECCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 15:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3CA8385B;
	Sun, 12 Oct 2025 17:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t00yqc6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAD583870; Sun, 12 Oct 2025 17:36:17 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14AC835C6
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 17:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cl4MJ6wv7z9t4X;
 Sun, 12 Oct 2025 17:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760283373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZFB1mjKRgR0hmztNnaQPe6qXhxMHbtWkO/QrSw4eYo=;
 b=t00yqc6+Uv1/F+BFthdxy7PFyAXXP8EIESMRX4GNP/KZTdMTfuH1JK8lNUDjtPtjd2AUKR
 gtw80m3z0foCXtJRVrXcOed9fuCqhGvQ8MPX/PClvXKVrsqIqqFw25RT0c1GwkOqcU2YTR
 QWRPQy+vYLFIsIsK5JLMKgvUw6QN788x32YMsPVC2EOfGuPSRtwZLH1CE5I857u2vXirha
 eHAemEF6GfkZz/3Xerx4xInb/DhwBdvYwSQpGAWCP2+yLyz1ki+Fvp4MmFqPr67M9xQkUy
 TiqQbzub8onqh3d+SkOFnqh/RNy9RkWPpQcdzhEiI83bH2Yu+60L18lfI/TJuw==
Message-ID: <7aa3b952-ed53-49a3-9bb3-e40e9a9cf800@mailbox.org>
Date: Sun, 12 Oct 2025 17:36:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
To: Ye Li <ye.li@oss.nxp.com>, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de,
 jagan@amarulasolutions.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com
References: <20250919070156.1497268-1-ye.li@nxp.com>
 <0528b2bd-09ef-45d4-9003-f8c1baab372b@mailbox.org>
 <220c3246-781a-4349-8d16-6eb1dfdc79e0@oss.nxp.com>
 <c019ab11-3f3c-4e3b-9049-5ed31be9c145@mailbox.org>
 <00c8213e-9b2e-4d3a-a265-a92fa956a999@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <00c8213e-9b2e-4d3a-a265-a92fa956a999@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y1gq771tw4w6t346w36e36fstt6uypps
X-MBO-RS-ID: 2f4233f9447669fbac5
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

On 9/22/25 8:48 AM, Ye Li wrote:

Hello again,

I'm sorry for the horribly late reply.

>>> 在 2025/9/19 20:20, Marek Vasut 写道:
>>>> On 9/19/25 9:01 AM, Ye Li wrote:
>>>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>>>
>>>>> Align erase and write on erase block boundary in line
>>>>> with how read was aligned in commit 622b5d35613.
>>>> What is the issue that is being fixed here ?
>>>>
>>> Previous commit 622b5d35613 tried to fix issue that offset is not 
>>> sector size aligned. But it only use the aligned offset read_offset 
>>> for flash read, not use it for erase and write. So still unaligned 
>>> offset send to spi_flash_erase and spi_flash_write.> What is the 
>>> reproducer ?
>>>>
>>> If the address is neither page or sector aligned, we meet issue with 
>>> flash update
>> What exact command do I run to trigger the problem, what is the 
>> failing result without this patch, what is the passing result with 
>> this patch ?
> You can use "sf update" command to reproduce the issue.
> Without the patch:
> u-boot=> sf update 0x94000000 0x10 0x20
> device 0 offset 0x10, size 0x20
> SPI flash failed in erase step
> 
> With the patch:
> u-boot=> sf update 0x94000000 0x10 0x20
> device 0 offset 0x10, size 0x20
> 32 bytes written, 0 bytes skipped in 0.20s, speed 1424 B/s

Thank you for the test case, this helped a lot.

If you want to do a V2, please include the test case in the commit message.

In either case:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H 
Sparrow Hawk

Thank you !
