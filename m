Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C008CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 05:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72571831BE;
	Wed, 10 Sep 2025 07:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C6iU5shi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2ED3830A0; Wed, 10 Sep 2025 07:11:11 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948108318E
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 07:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A5B7Pi066471;
 Wed, 10 Sep 2025 00:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757481067;
 bh=6ZnQO11sEb3mw5VzmTa7H5mGciOuXp4zHWWe48ZMfOM=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=C6iU5shi7p2d+CCEy6sqtKJ00s2+McvaHofqeyBdIs1p7Emkid83ktw9EcJ9+TDiy
 Grmzk1afSIDc5DivVyiDpdkDOI5K0woJeNAaXe2l6R68eum9fUclXO23EUXkX0iC91
 scLCb+ZodQSqxtsDsPF+SmUMfqksDahKNDe67ZOw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A5B6Bo906750
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 00:11:06 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 00:11:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 00:11:06 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A5B5Pw4148882;
 Wed, 10 Sep 2025 00:11:05 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Sep 2025 10:41:04 +0530
Message-ID: <DCOV1J6TSSS2.2N4O1QYQEZZOX@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 2/2] configs: phycore_am62ax_a53_defconfig: eMMC boot
 from raw offsets
From: Anshul Dalal <anshuld@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, <ggiordano@phytec.com>,
 <trini@konsulko.com>, <d.schultz@phytec.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250909103654.3341398-1-w.egorov@phytec.de>
 <20250909103654.3341398-2-w.egorov@phytec.de>
In-Reply-To: <20250909103654.3341398-2-w.egorov@phytec.de>
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

On Tue Sep 9, 2025 at 4:06 PM IST, Wadim Egorov wrote:
> From: Daniel Schultz <d.schultz@phytec.de>
>
> Enable CONFIG_SPL_SYS_MMCSD_RAW_MODE and set the offset address to
> boot from raw addresses instead of a FAT partition.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  configs/phycore_am62ax_a53_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62a=
x_a53_defconfig
> index 05849d05be4..27fa4386a21 100644
> --- a/configs/phycore_am62ax_a53_defconfig
> +++ b/configs/phycore_am62ax_a53_defconfig
> @@ -48,6 +48,8 @@ CONFIG_SPL_MAX_SIZE=3D0x58000
>  CONFIG_SPL_PAD_TO=3D0x0
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1400
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_ETH=3Dy

Looks good to me,
Acked-by: Anshul Dalal <anshuld@ti.com>

Regards
