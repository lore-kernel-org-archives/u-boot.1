Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09540C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4974087885;
	Thu, 11 Jan 2024 14:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nxd4Sk5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A388187AAB; Thu, 11 Jan 2024 14:06:30 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2030A877C8
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 626FBB81FC0;
 Thu, 11 Jan 2024 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AEEC433F1;
 Thu, 11 Jan 2024 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704978386;
 bh=xZTv8DtR2wU+DFDg7g0Z9CbKJJJzUuIV0aZJnBgmZYc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nxd4Sk5Muuhd3WPdi1dBHagvmnbBgBKomv/+lZVzARNG1gjusCme1ZQSqqLf8XSqr
 LLgWpKFGbUyXm6MrgsUqcPaP4vqu2mNqNO75UDs1PQwXzREoSSWw/wXY4eRyNevq9H
 DL6LVgxWRwLSlSOa8SHBodtXJ4RDohDwQ+xg9iQwmyRvI0YIoMTZn5svvG6p3QTDWI
 KNz/haWDwiT5dK2igJKgLyMt4zfFMHCPHhCh3XJpaUzPtC+8Fnr7xTdjjXFSKJf8yU
 haiSkEctv4mDR6e1bgmri7oMG27syJ4XfCedBaNG2w1w6XW+jGzSIcyB0j7+atAOjH
 trQcgFdkPVIzA==
Message-ID: <5d79b1c8-4dc8-44d3-bfe7-4514f41c7102@kernel.org>
Date: Thu, 11 Jan 2024 15:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mtd: nand: omap_gpmc: Fix NAND for AM335x
Content-Language: en-US
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com
Cc: trini@konsulko.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de
References: <20231211114600.4414-1-rogerq@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231211114600.4414-1-rogerq@kernel.org>
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

Hi,

On 11/12/2023 13:45, Roger Quadros wrote:
> Hi,
> 
> These patches fix NAND and ELM for AM335x and related legacy platforms
> that use HW BCH and ELM modules.
> 
> All CI tests pass: https://github.com/u-boot/u-boot/pull/453
> 
> Changelog:
> 
> v2:
> - added __maybe_unused to omap_calculate_ecc_bch. fixes CI tests
> - Added Tested-by Tags
> - Explained about omap_elm single sector support in commit log 
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
>   mtd: rawnand: omap_elm: Fix elm_init definition
> 
>  drivers/mtd/nand/raw/omap_elm.c  |  4 +-
>  drivers/mtd/nand/raw/omap_elm.h  |  6 --
>  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
>  3 files changed, 31 insertions(+), 74 deletions(-)
> 
> 
> base-commit: 2f0282922b2c458eea7f85c500a948a587437b63

If no objections can this be Acked and picked up please? 
Without these NAND is broken on some TI platforms.

Thanks!

-- 
cheers,
-roger
