Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C5CC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E4182B07;
	Mon,  9 Jun 2025 10:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gJgru6av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B1A82B0E; Mon,  9 Jun 2025 10:02:51 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1006F82A65
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55982WOE736299;
 Mon, 9 Jun 2025 03:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456152;
 bh=lUBnHal8NYeeCB1jWF/YDGiiupteMM5F8PpMj1ORW5Q=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gJgru6av/EskQSIBuBf/u2yPKqYEkz4pBk/R89PMbrevhjyeicTr0RZ1AzCQEdteM
 ONBUF9vfX133MgegOBNONr9404h6n+w/flr5Bg1a2Y10oa4V8t+guzB5FKPnE3lqdz
 tQTxtoCeiBxJUUFyDQVVYDQkoWNlalDwUEgL1W3M=
Received: from DFLE20.ent.ti.com (dfle20.ent.ti.com [10.64.6.57])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55982WJd4118044
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 9 Jun 2025 03:02:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Mon, 9 Jun
 2025 03:02:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:02:31 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55982VBW944715;
 Mon, 9 Jun 2025 03:02:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 13:31:57 +0530
Message-ID: <DAHUFPAGK5AM.1RQ2R5MRYQUZN@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Alexey Brodkin
 <alexey.brodkin@synopsys.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 <uboot-snps-arc@synopsys.com>
Subject: Re: [PATCH 08/12] arm: imx: remove unnecessary volatile qualifiers
 from "save gd" variables
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604195612.2312979-9-ravi@prevas.dk>
In-Reply-To: <20250604195612.2312979-9-ravi@prevas.dk>
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
> Now that the global gd pointer is no longer volatile-qualified,
> there's no reason for the temporary variables used for
> saving/restoring it to have that qualifier.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Tested-by: Anshul Dalal <anshuld@ti.com>
