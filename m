Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66961C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06E6877FD;
	Tue,  9 Jan 2024 15:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oIKsTzqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F006878E9; Tue,  9 Jan 2024 15:25:42 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AADA877D9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409EPWUu107138;
 Tue, 9 Jan 2024 08:25:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704810332;
 bh=6aVvJuhPOuv+91Cr9oI4Q+TmpxTctlGdua2jCJp6CiY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oIKsTzqIi33FuO/2YE4p6m/rQWVAoAf/tmgwOWhCzZFJFWvIMLiODcO3w8coHJxPv
 kImRQYLBOokzzjq/7qKi9upshU03XkcXz4V8alpkFXIDBNiu8hgMeCFjSh0ojc6ap6
 KGLWNw96Y84cBlZFGx9EjZd5osYfZB5j55gx8hYc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409EPWFN039280
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 08:25:32 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 08:25:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 08:25:32 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409EPW32045129;
 Tue, 9 Jan 2024 08:25:32 -0600
Date: Tue, 9 Jan 2024 08:25:32 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH 04/10] board: ti: am64x: Set fdtfile from C code instead
 of findfdt script
Message-ID: <20240109142532.gx4w6rdbkl2kowed@debating>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-5-nm@ti.com>
 <ec2ead48-0aaa-44fd-be71-545a7e3d59e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec2ead48-0aaa-44fd-be71-545a7e3d59e1@kernel.org>
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

On 15:08-20240109, Roger Quadros wrote:
[..]
> >  #ifdef CONFIG_BOARD_LATE_INIT
> > +static struct ti_fdt_map ti_am64_evm_fdt_map[] = {
> > +	{"am64x_gpevm", "k3-am642-evm.dtb"},
> > +	{"am64x_skevm", "k3-am642-sk.dtb"},
> 
> "am64x_gpevm" and "am64x_skevm" strings are used multiple times in this file.
> see setup_board_eeprom_env()
> 
> Please use a MACRO for them.
> 
> What is the logic of choosing this name and can it be updated at this point?
> e.g."gp" is misleading in the board name as the boards are now shipped with
> HS-FS chip and are no longer GP.

Intent of the series was to get rid of findfdt - it was not meant to
cleanup existing name usage in the files. If there is a desire to do so,
please - patches are welcome.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
