Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4480CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 20:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AE487A46;
	Mon,  8 Jan 2024 21:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xEos32m8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC0687A77; Mon,  8 Jan 2024 21:04:42 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F4A087828
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 21:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408K4WBY022754;
 Mon, 8 Jan 2024 14:04:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704744272;
 bh=3vo6PZIgcoA1Gm6mzRykCfFZqpvdbKhpoby0kkd8k8c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xEos32m8OLz9dOSFeDZC/PZQsoHbiIQ0VMApmLcdr2Wm0R17Xv1h0ycvussRQBF0f
 e7vzEXas6O5Ri4B5WUiLcem7dBgis7oTtMhuttjFtZkHO0M+Sr2kU6kC/BqgDm+P1f
 bS+WMoCrMf62fmy/5qyIOQrY28EUNmgZo7CjiIfc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408K4WXP130968
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 14:04:32 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 14:04:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 14:04:32 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408K4W0j105310;
 Mon, 8 Jan 2024 14:04:32 -0600
Date: Mon, 8 Jan 2024 14:04:32 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon
 Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Bryan
 Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH 08/10] board: beagle: beagleboneai64: Set fdtfile from C
 code instead of findfdt script
Message-ID: <20240108200432.ytukx6r5eybsn7wb@hazard>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-9-nm@ti.com>
 <f94817a7-b81a-479b-bef2-2c255c4e0f1d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f94817a7-b81a-479b-bef2-2c255c4e0f1d@ti.com>
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

On 13:00-20240108, Andrew Davis wrote:
> > +#ifdef CONFIG_BOARD_LATE_INIT
> > +int board_late_init(void)
> > +{
> > +	char fdtfile[50];
> > +
> > +	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
> > +		 CONFIG_TI_EVM_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
> > +
> 
> Why not use your new ti_set_fdt_env() helper? It makes this board

I had it originally, but did not want the code to depend on
board/ti/common functions. So dropped it in later version.

> consistent with TI boards (sets "name_fdt" and adds warning for
> "findfdt" like your commit message says you do..).

Will fix up the commit message in the next revision


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
