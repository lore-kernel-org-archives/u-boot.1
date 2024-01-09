Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4048C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D91878CD;
	Tue,  9 Jan 2024 15:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AKX+oeN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C13E87903; Tue,  9 Jan 2024 15:23:36 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6833F877D9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409ENQAb106050;
 Tue, 9 Jan 2024 08:23:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704810206;
 bh=O/cl0sIjegttHrn3dqXtUlXHcl2vxbjasF7fdDc1AGU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AKX+oeN6mF7sdIt2OGNlZPiXdvNlzjmbTEwkTJc9ez7aEQTfCMfR522fB8k14RQD3
 rg95PnWY5tltwy3P+xfMRbraCn4DXaIfO5ZXAhhT4ODH7d/ojD2kLVMvqJrNAh68Wa
 CSQ/lrb2Olu3Gvn8Xp7Yl0l+gnGT0T3M5FtjXyrM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409ENQ7d108337
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 08:23:26 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 08:23:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 08:23:25 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409ENPjM042990;
 Tue, 9 Jan 2024 08:23:25 -0600
Date: Tue, 9 Jan 2024 08:23:25 -0600
From: Nishanth Menon <nm@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon
 Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/10] board: ti: am62ax: Set fdtfile from C code instead
 of findfdt script
Message-ID: <20240109142325.y2qs35ddagcv4xhu@blooper>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-3-nm@ti.com>
 <86jzojdxxx.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86jzojdxxx.fsf@udb0321960.dhcp.ti.com>
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

On 20:48-20240108, Jon Humphreys wrote:
[..]

> > +
> > +#ifdef CONFIG_BOARD_LATE_INIT
> > +int board_late_init(void)
> > +{
> > +	ti_set_fdt_env(NULL, NULL);
> 
> If a board only has one FDT possible, why not just hard code the path
> here, rather than use the set_fdt_env() logic with NULLs and create/set
> TI_EVM_FDT_FOLDER_PATH config that is only used here anyway?

Centralizing the logic has the additional benefit of standardizing
fall back when maps are not matched. It is better than having each of
the board file introduce random way of doing things.

> 
> If you think we might add additional board types / FDTs later, then
> instead let's formalize the fdt_map concept and create a CONFIG_USES_FDT_MAP
> that will then rely on the fdt_map and call the ti_set_fdt_env(), and if
> not set, then it just returns a hard coded value, which could be based on
> the CONFIG_DEFAULT_DEVICE_TREE config.

Ends up being superflous - there is already a push to reduce the config
options.

[..]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
