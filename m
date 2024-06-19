Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEE4C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 20:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D54B287D83;
	Wed, 19 Jun 2024 22:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GLkazv7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88DA88499; Wed, 19 Jun 2024 22:44:48 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709EC866F6
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 22:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JKigxP096439;
 Wed, 19 Jun 2024 15:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718829882;
 bh=Lr8OkqZfLYH/a1ZenW6yMMQJzzTu6xrm1T3S6IQPf20=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GLkazv7PM6iyCzv0NQdSH4ri4STF6Z3C/fMnYycon9fVaztPt02QXsSy6kd+tPPoC
 5n1H28fo1dCgv1E4ZOqp6GjISdNa+1JIIKc8zrJdojmp8blj5ua+QY2hEErehdjAs6
 kg0dBBCVFRwJeiwN4bBDx9yM8yQXygQWz30iOikU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JKigxb026048
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 15:44:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 15:44:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 15:44:42 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JKif42074451;
 Wed, 19 Jun 2024 15:44:41 -0500
Message-ID: <3f540efd-d428-49e3-bf48-de1e35dd41c3@ti.com>
Date: Wed, 19 Jun 2024 15:44:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: beagle: beagleplay: enable OF_SYSTEM_SETUP
To: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>
References: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 6/19/24 2:12 PM, Bryan Brattlof wrote:
> Unfortunately when enabling FDT fixups for the AM62x family of SoCs and
> moving TF-A to the bottom of RAM we missed the BeaglePlay. This is
> causing Linux's memory allocator to clobber TF-A and break its boot.
> 
> Enable OF_SYSTEM_SETUP to fixup the kernel's FDT to inform it of the
> actual location of the firmware
> 
> CC: Andrew Davis <afd@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Robert Nelson <robertcnelson@gmail.com>
> Reported-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---

Acked-by: Andrew Davis <afd@ti.com>

> Hello everyone,
> 
> Fair warning, this may turn into a philosophical discussion about the
> role of device-tree with SystemReady and U-Boot's role in enabling true
> distribution to be completely agnostic of the board it's running on.
> 
> However substantively this is simply fixing a boot regression Dhruva
> found while testing out the beagleplay.
> 
> Happy reviewing
> ~Bryan
> ---
>   board/beagle/beagleplay/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
> index 7dbd833acb4cc..896a1c1be3010 100644
> --- a/board/beagle/beagleplay/Kconfig
> +++ b/board/beagle/beagleplay/Kconfig
> @@ -12,6 +12,7 @@ config TARGET_AM625_A53_BEAGLEPLAY
>   	bool "BeagleBoard.org AM625 BeaglePlay running on A53"
>   	select ARM64
>   	select BINMAN
> +	select OF_SYSTEM_SETUP
>   
>   config TARGET_AM625_R5_BEAGLEPLAY
>   	bool "BeagleBoard.org AM625 BeaglePlay running on R5"
> 
> ---
> base-commit: fe2ce09a0753634543c32cafe85eb87a625f76ca
> change-id: 20240619-play-fdt-fixup-a92e1ab872fc
> 
> Best regards,
