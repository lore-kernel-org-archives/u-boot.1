Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89694CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 03:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF29B807B1;
	Tue, 14 Oct 2025 05:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UCpRsJKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D58809A5; Tue, 14 Oct 2025 05:58:09 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845CA80422
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 05:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E3w4fP1054249;
 Mon, 13 Oct 2025 22:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760414284;
 bh=qZL2AHMQLFGFg/R1s10g9R9MwGZ2MLEdYdujvERBLQE=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=UCpRsJKfhCoFBzTS97T2uz/7qwZAmbl9K0y6YAcdjgULRGopmYbHP328LiXIWr4zX
 G6j7E18nGdnfQkvQOYBMxv7HSnoZav33nKEny0r/bPDpx/YgxBENYxvy+gDhDRGT4H
 S4Z2v10rY1N9mhtaSVsL5HAb6q4YZcJLM/WxhPO8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E3w4Zv149543
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 13 Oct 2025 22:58:04 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 13
 Oct 2025 22:58:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 22:58:04 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E3w23g3153407;
 Mon, 13 Oct 2025 22:58:03 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Oct 2025 09:28:02 +0530
Message-ID: <DDHQS4TT6S6Y.1N61MTMFVTJBP@ti.com>
CC: <trini@konsulko.com>
Subject: Re: [PATCH] arm: baltos: enable TI_SYSC and CLK drivers
From: Anshul Dalal <anshuld@ti.com>
To: <yegorslists@googlemail.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251013130902.74719-1-yegorslists@googlemail.com>
In-Reply-To: <20251013130902.74719-1-yegorslists@googlemail.com>
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

Hi Yegor,

On Mon Oct 13, 2025 at 6:39 PM IST, yegorslists wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>

Could you explain a bit more about why this change is needed in the
commit description?

Regards,
Anshul

> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  configs/am335x_baltos_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defc=
onfig
> index 5c43503ff32..93a5fb94adf 100644
> --- a/configs/am335x_baltos_defconfig
> +++ b/configs/am335x_baltos_defconfig
> @@ -53,8 +53,9 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
>  CONFIG_VERSION_VARIABLE=3Dy
>  CONFIG_NET_RETRY_COUNT=3D10
>  CONFIG_BOOTP_SEND_HOSTNAME=3Dy
> -# CONFIG_TI_SYSC is not set
>  CONFIG_BOOTCOUNT_LIMIT=3Dy
> +CONFIG_CLK=3Dy
> +CONFIG_CLK_TI_CTRL=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_EEPROM_ADDR=3D0x50

