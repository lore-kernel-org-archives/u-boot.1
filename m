Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BE0C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 23:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1364784673;
	Fri,  8 Aug 2025 01:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pgDYaW0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31CF84673; Fri,  8 Aug 2025 01:15:52 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD5C845EC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 01:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577NEcj1848536;
 Thu, 7 Aug 2025 18:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754608478;
 bh=jUVy+Ahepw0eeikRESXusTD6i2JZByBcvGbdZHk3vTA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pgDYaW0R22BS5k9v6gHf6/IVVNbhA8ZHnCnGtfBmLvfpDBqFPs4/ZTuDGymNCqmlh
 AUpNMnV2ZT5yxiNKuxcWHNphcxhniI3qpaR22D+oTo/ZNZmp8AqfnnXR8TQwX/Lr8V
 J99svalOOte97jLn9zu3TdstFfwWNvdbFXd44bRg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577NEckL487670
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 7 Aug 2025 18:14:38 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 18:14:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 18:14:38 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577NEcmC2110357;
 Thu, 7 Aug 2025 18:14:38 -0500
Message-ID: <18f1e05c-2be9-4a6f-af50-904d4a2ed1c2@ti.com>
Date: Thu, 7 Aug 2025 18:14:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add support for AM62P SR1.2
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
References: <20250805161419.1781935-1-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250805161419.1781935-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Peng, Tom,

On 8/5/25 11:14 AM, Judith Mendez wrote:
> This patch series adds support for the AM62P SR1.2 silicon revision by
> adding support in soc_ti_k3 to detect AM62P variants.
> 
> Also disable HS400 support for AM62P SR1.0 and SR1.1 in sdhci host driver.
> For AM62P SR1.2, eMMC HS400 should be enabled by default.

I will have to change these patches due to mirror version of these
patches changed in Linux drastically, mainly, DT patch was dropped which
affects u-boot implementation.

Sorry for jumping the gun with u-boot. I will respin u-boot patches
once linux side is stable [0].

[0] https://lore.kernel.org/linux-mmc/20250805234950.3781367-1-jm@ti.com

~ Judith

