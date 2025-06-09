Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCAFC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AD482B07;
	Mon,  9 Jun 2025 10:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sXoYhosa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314EB82B0E; Mon,  9 Jun 2025 10:02:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A463382A65
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598236c715143;
 Mon, 9 Jun 2025 03:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456123;
 bh=herV5SynpO2EQRbejIvTt5T07Cfitf8YqN9rlLFqXrU=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=sXoYhosaWKZeC/9oTDkXBv3e3Lb6fnG10i3bUJ5kGFsiHtDTCwxMzzF7j4iwpRQu4
 tsJSwKzK9ZxEAUED9qhufGZ12RUOogUowi6/oHd/16drryyhiS0ZKBcaNZ5wmoK3+r
 G/Sh4gTbVJ1eUquUp9J5x9OPqoIdXwdtPDlRDy7I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559822br3655566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:02:02 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:02:02 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 9 Jun
 2025 03:02:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:02:02 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559821GG943891;
 Mon, 9 Jun 2025 03:02:01 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 13:31:27 +0530
Message-ID: <DAHUFBJN5ZTA.2E25DKSIL1QOS@ti.com>
CC: Tom Rini <trini@konsulko.com>, Alexey Brodkin
 <alexey.brodkin@synopsys.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-snps-arc@synopsys.com>
Subject: Re: [PATCH 01/12] arm: drop volatile qualifier from gd pointer
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604195612.2312979-2-ravi@prevas.dk>
In-Reply-To: <20250604195612.2312979-2-ravi@prevas.dk>
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

On Thu Jun 5, 2025 at 1:26 AM IST, Rasmus Villemoes wrote:
> There's a bunch of other places where this qualifier should be
> dropped, e.g. in the set_gd() prototype and for various variables used
> for stashing the value in the mach-imx/ directory and elsewhere. But
> that will be done in follow-up patches.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Tested-by: Anshul Dalal <anshuld@ti.com>
