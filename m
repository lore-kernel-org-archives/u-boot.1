Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A151C2BA12
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 01:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCED98801A;
	Sun, 16 Jun 2024 03:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QzpZ5AzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A1087F52; Sun, 16 Jun 2024 03:55:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8277588027
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 03:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45G1tblY086043;
 Sat, 15 Jun 2024 20:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718502937;
 bh=IW9Lq4uyKFpXlFxDxFiagjN2DQCOpHUZZglYOJy8OG4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=QzpZ5AzEMk98RkmonQEsDIdGAfyXrbMVbwBqzrqW1oZjhXsxpZmQvmCWIChRgRwmT
 nZSrU57oJ9bemUwfcUlbZ8QcoPbjYE8Vm+RuUXkRSfgdEJbiXu2FTQIAAyA24htNp7
 TqP2cV0RHSmEr6UR/l7W2rT9ZkrGvRwjRtHI4OUw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45G1tbJ1066307
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 15 Jun 2024 20:55:37 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 20:55:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 20:55:37 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45G1tbLm053113;
 Sat, 15 Jun 2024 20:55:37 -0500
Date: Sat, 15 Jun 2024 20:55:36 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vibhore Vardhan
 <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Nishant Menon
 <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Judith Mendez <jm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
Message-ID: <20240616015536.7qqiwnipnnp7m37t@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240613080604.3828083-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240613080604.3828083-1-d-gole@ti.com>
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

On June 13, 2024 thus sayeth Dhruva Gole:
> The Kernel Image and DTB files are supposed to be picked from the rootfs
> of the SD Card, this fails in legacy boot flow because bootpart is set
> to 1:1. Fix it.
> 
> Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_* 
> defconfigs and env file")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  board/beagle/beagleplay/beagleplay.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> index bbf6b925d02c..190181c8ad0c 100644
> --- a/board/beagle/beagleplay/beagleplay.env
> +++ b/board/beagle/beagleplay/beagleplay.env
> @@ -11,7 +11,7 @@ set_led_state_start_load=led led-0 on; led led-1 off;
>  	led led-2 on; led led-3 off; led led-4 on
>  boot=mmc
>  mmcdev=1
> -bootpart=1:1
> +bootpart=1:2
>  bootdir=/boot
>  boot_targets=mmc1 mmc0
>  bootmeths=script extlinux efi pxe

Shouldn't the fix be to just drop 'script' from bootmeths. These TI 
scripts needed to go away years ago.

~Bryan
