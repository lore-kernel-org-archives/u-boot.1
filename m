Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6EDC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 09:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD3C801BE;
	Fri, 11 Jul 2025 11:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgK1tAnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B743F800D7; Fri, 11 Jul 2025 11:44:42 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2AA800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 11:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B9iasJ2005330;
 Fri, 11 Jul 2025 04:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752227076;
 bh=S8z6j9G6z0M9wORmJZ7hBH3JN+cjNnYoayqYBoa4gtI=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=jgK1tAnXYN+M1i5nuDk3KFyIqAnQOsDCcac8Pd1RWO4eR/ze0vQiTMt3qRDwwjBsJ
 QW0EqMG0VBwT5/NHLUoglmFqSRaXn/Jai6Qe7v5NeyX7NkaG6Lvx5BPWsk77DhqZF7
 yknHdDh8BdNXlHI1y0gbbpgbRc01gATznlphjAKE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B9ia9u2162756
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 11 Jul 2025 04:44:36 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 04:44:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 04:44:36 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B9iZHR2971170;
 Fri, 11 Jul 2025 04:44:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Jul 2025 15:13:49 +0530
Message-ID: <DB94N4OKVW9D.28H05SO50F2D4@ti.com>
CC: Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
From: Anshul Dalal <anshuld@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250710171135.669838-1-jm@ti.com>
In-Reply-To: <20250710171135.669838-1-jm@ti.com>
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

On Thu Jul 10, 2025 at 10:41 PM IST, Judith Mendez wrote:
> This removes support from booting from UDA when in eMMC boot.
>
> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
> boot1 HW partitions, we should not boot from eMMC UDA. The current
> logic confuses the end user and mixes two different boot modes.
>

This is correct, we should not be changing the eMMC boot mode based on
what U-Boot config is enabled.

The end user can always use MMCSD as the backup boot mode if they want
a fallback.

> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
> this is not a clean solution and fix will come later for falcon boot.
>
> Logic was also added for AM62X with commit: 664593464634, but this
> logic is incorrect according to TRM [0] under Primary Boot Mode Selection
> for 'eMMC Boot'.
>
> Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
> Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Thanks for the fix,
Anshul
