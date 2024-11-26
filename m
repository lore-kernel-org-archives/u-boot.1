Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E058D5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AB389655;
	Tue, 26 Nov 2024 06:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QGKaMz/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54235896C3; Tue, 26 Nov 2024 06:40:47 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0741388E6B
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ5eXKj786868
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 23:40:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732599633;
 bh=M3vx6KXuzJpb8G2S79bnd+DGWvGZLvgPtOdoXijBZFQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=QGKaMz/hm5xKVrAl3FoxTAnaWY0IqzQpQ4fh7MN0zVu5JV7C2pAzIGtyqFEtbUGZv
 soM9rZqVCqEV8H4uV8An7cEeBsxFyw7Rn5T6ymINZ1OnIqHyoXcI4yvgywzG7cT2Vu
 mOGptE90w/ZeocLsyFBbQb+vNWJM47ubY8kqOJR0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ5eX6F122279
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 23:40:33 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 23:40:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 23:40:33 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ5eVv1116277;
 Mon, 25 Nov 2024 23:40:32 -0600
Date: Tue, 26 Nov 2024 11:10:31 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <u-boot@lists.denx.de>,
 <srk@ti.com>, <rogerq@kernel.org>, <sjg@chromium.org>, <nm@ti.com>,
 <j-humphreys@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <trini@konsulko.com>, <bb@ti.com>
Subject: Re: [PATCH v2 1/5] board: ti: am64x: evm: Set "dfu_alt_info" only if
 interface is Serial Flash
Message-ID: <bfd7ki4e2rtw5cnyp5phrqfxxkm27u7jkaqgbqcea7ahxe3uhn@oon3ag6iosjp>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <20241124070828.617558-2-s-vadapalli@ti.com>
 <f348c51f-3f34-406d-8013-9c4185c8d40b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f348c51f-3f34-406d-8013-9c4185c8d40b@ti.com>
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

On Tue, Nov 26, 2024 at 10:33:30AM +0530, Vignesh Raghavendra wrote:

Hello Vignesh,

[...]

> > +	/*
> > +	 * Since the EFI Capsule support is enabled only for Serial Flash,
> > +	 * update the "dfu_alt_info" environment variable only if the
> > +	 * interface happens to be "sf" (Serial Flash).
> > +	 */
> > +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> > +	    (strcmp(interface, "sf") == 0))
> 
> IIUC, EFI_HAVE_CAPSULE_SUPPORT is probably only functional at U-Boot
> proper and not at SPL (I dont see any SPL_EFI_* options), so would this
> work instead?
> 
> 	if (CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT) {
> 		...
> 	}

This works! Thank you for the suggestion.

Regards,
Siddharth.
