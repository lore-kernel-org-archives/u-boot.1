Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BF5CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 05:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF3180B9B;
	Thu, 21 Aug 2025 07:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qDIlZFxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A7981E13; Thu, 21 Aug 2025 07:22:29 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DAF80422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 07:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57L5MOlZ413797;
 Thu, 21 Aug 2025 00:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755753744;
 bh=fS+mdBJJ9vVxx7NaUb1g5aF+hfJh0ktrOvU+PKgz9Fk=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=qDIlZFxuSQgghgwm+748bVRvDIYu8oZ63eG3aMQbhKSCDx1QYNuijwTos00QYmbdc
 foVzQ2bgAXkK4tgzYcT9rPDu43XPOGFmQGGD5RG6f3javwNj2ih5vv2eOnLDy/Fam7
 Rvm80+A+l0fWw1O7c62/NGcWJu+0dI8M/xtLnQZg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57L5MOHI1890231
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 21 Aug 2025 00:22:24 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 00:22:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 00:22:24 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57L5MNGg1351079;
 Thu, 21 Aug 2025 00:22:23 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Aug 2025 10:51:15 +0530
Message-ID: <DC7UQFE2NX5R.2LQIJH6G4LXMO@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] mach-k3: am62*: Fix backup from eMMC boot mode
From: Anshul Dalal <anshuld@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820215634.52880-1-jm@ti.com>
In-Reply-To: <20250820215634.52880-1-jm@ti.com>
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

Hi Judith,

On Thu Aug 21, 2025 at 3:26 AM IST, Judith Mendez wrote:
> Currently logic in spl_mmc_boot_mode only lookes at main devstat
> to determine the bootmode to return. Thus, when using: 'eMMC boot'
> as primary boot mode and 'MMCSD boot from eMMC UDA' as backup
> boot mode, 'eMMC boot' is always selected. Add check for bootindex
> to determine if ROM boot via backup boot mode and return MMCSD_MODE_FS
> which is the only supported backup bootmode with eMMC device.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
[snip]

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Thanks for the patch!

Regards,
Anshul
