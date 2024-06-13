Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12197C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 827D388914;
	Thu, 13 Jun 2024 14:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S12KLCES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882668820C; Thu, 13 Jun 2024 10:09:43 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8755C888DD
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 10:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=c-shilwant@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D89crS006737;
 Thu, 13 Jun 2024 03:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718266178;
 bh=yDkSum6twfay2ydqaLecv/jrkd+neJAECpk886Sk4WM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=S12KLCESTvQk9yXnH6kUm3LsQ15fStSH1Mv4DUJ9O3ZkKlIx8yw8vwTVy1wuIk3s6
 hQS/bxniMfS21YN8kOxHSwNfUiiYjs3/sB0EK+69p9gcgGYqWAcCfh1eKnl8Dg5/2W
 RaTSTnUpr3atwkJZqboWpYwxqlYke6LelEimwmhA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D89cr0064196
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Jun 2024 03:09:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:09:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:09:38 -0500
Received: from [172.24.227.238] (chirag-hp-z2-tower-g5-workstation.dhcp.ti.com
 [172.24.227.238])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D89YmK028439;
 Thu, 13 Jun 2024 03:09:35 -0500
Message-ID: <d6243760-fddb-4fc6-baec-56e2dc66cdf6@ti.com>
Date: Thu, 13 Jun 2024 13:39:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: <u-boot@lists.denx.de>
CC: Vibhore Vardhan <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Nishant Menon <nm@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Judith
 Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Dhruva Gole <d-gole@ti.com>
References: <20240613080604.3828083-1-d-gole@ti.com>
Content-Language: en-US
From: Chirag Shilwant <c-shilwant@ti.com>
In-Reply-To: <20240613080604.3828083-1-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:44:27 +0200
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

Hi Dhruva,

On 13/06/24 13:36, Dhruva Gole wrote:
> The Kernel Image and DTB files are supposed to be picked from the rootfs
> of the SD Card, this fails in legacy boot flow because bootpart is set
> to 1:1. Fix it.
>
> Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>



Acked-by: Chirag Shilwant <c-shilwant@ti.com>



> ---
>   board/beagle/beagleplay/beagleplay.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> index bbf6b925d02c..190181c8ad0c 100644
> --- a/board/beagle/beagleplay/beagleplay.env
> +++ b/board/beagle/beagleplay/beagleplay.env
> @@ -11,7 +11,7 @@ set_led_state_start_load=led led-0 on; led led-1 off;
>   	led led-2 on; led led-3 off; led led-4 on
>   boot=mmc
>   mmcdev=1
> -bootpart=1:1
> +bootpart=1:2
>   bootdir=/boot
>   boot_targets=mmc1 mmc0
>   bootmeths=script extlinux efi pxe
