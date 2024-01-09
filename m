Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B4BC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CE1877D9;
	Tue,  9 Jan 2024 15:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jwJQf/z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1104878CD; Tue,  9 Jan 2024 15:18:58 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53AB87729
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409EIlFi014200;
 Tue, 9 Jan 2024 08:18:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704809927;
 bh=LzctucZ0JyCaroYDC+3QuArrDMXub4M5XkJ8QyDUzVo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jwJQf/z7l6DN+pxPFR2tAZRtfhVJluGNQ9FS70WPiMC0WaGLoGOVekTkH5jGaJb2K
 wAKIGWw+AKTnGuMLaEfO6haGR6kXMWc2CmVx+JCziWSQxRtQIqLHK1WSnPEVFUwmLz
 asSEbhts29qZxfoBMdouPXb4xE8LeMvf4+V7eD4o=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409EIl01034271
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 08:18:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 08:18:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 08:18:47 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409EIksl037398;
 Tue, 9 Jan 2024 08:18:46 -0600
Date: Tue, 9 Jan 2024 08:18:46 -0600
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
Subject: Re: [PATCH 01/10] board: ti: common: Introduce a common fdt ops
 library
Message-ID: <20240109141846.uinqyd2wskvxthvc@sullen>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-2-nm@ti.com>
 <86sf37dz7x.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86sf37dz7x.fsf@udb0321960.dhcp.ti.com>
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

On 20:20-20240108, Jon Humphreys wrote:
[...]

> > +config TI_EVM_FDT_FOLDER_PATH
> > +	string "Location of Folder path where dtb is present"
> > +	default "ti/davinci" if ARCH_DAVINCI
> > +	default "ti/keystone" if ARCH_KEYSTONE
> > +	default "ti/omap" if ARCH_OMAP2PLUS
> > +	default "ti" if ARCH_K3
> > +	depends on ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
> > +	help
> > +	   Folder path for kernel device tree default.
> > +	   This is used along with fdtfile path to locate the kernel
> > +	   device tree blob.
> 
> It's not clear to me why we need the flexibility of specifying a FDT
> filename per board independently of the FDT folder path.  Why can't the path
> be part of the fdt_map?

Because of https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=724ba6751532055db75992fc6ae21c3e322e94a7

This does not happen too often, but the folder paths are irritating and
impact multiple platforms at the same time.

[...]
> > + *
> > + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +#include <env.h>
> > +#include <vsprintf.h>
> > +#include "fdt_ops.h"
> > +
> > +void ti_set_fdt_env(const char *name_fdt, struct ti_fdt_map *fdt_map)
> 
> This function takes a board name and sets the FDT name, so why isn't the
> first parameter called 'board_name' or similar?

Fair enough - board_name is more appropriate.
> 
> > +{
> > +	char *fdt_file_name = NULL;
> > +	char fdtfile[TI_FDT_FILE_MAX];
> > +
> > +	if (name_fdt) {
> > +		while (fdt_map) {
> > +			/* Check for NULL terminator in the list */
> > +			if (!fdt_map->name_fdt)
> > +				break;
> > +			if (!strncmp(fdt_map->name_fdt, name_fdt, TI_NAME_FDT_MAX)) {
> 
> Why do we need a max length?  Shouldn't strcmp() be fine given the
> name_fdt member of the fdt_map is set in code (ie, not read in)?

prefer strncmp to strcmp where possible. it isn't a matter of set in
code or not, it is a possibility of making a mistake - hence the
constant sized string.

> 
> > +				fdt_file_name = fdt_map->fdt_file_name;
> > +				break;
> > +			}
> > +			fdt_map++;
> > +		}
> > +	}
> > +
> > +	/* match not found OR null name_fdt */
> > +	if (!fdt_file_name) {
> > +		/*
> > +		 * Prioritize CONFIG_DEFAULT_FDT_FILE - if that is not defined,
> > +		 * or is empty, then use CONFIG_DEFAULT_DEVICE_TREE
> > +		 */
> > +#ifdef CONFIG_DEFAULT_FDT_FILE
> > +		if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
> > +			snprintf(fdtfile, sizeof(fdtfile), "%s/%s",
> > +				 CONFIG_TI_EVM_FDT_FOLDER_PATH, CONFIG_DEFAULT_FDT_FILE);
> 
> I do not see where any TI platforms set CONFIG_DEFAULT_FDT_FILE, so why
> have logic that checks for it?  We don't use it.  With this patch
> (fdt_map) I don't see why we would start needing it in the future.

You don't need to explicitly set since it is already set by default - check the
.config.

> 
> > +		} else
> > +#endif
> > +		{
> > +			snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
> > +				 CONFIG_TI_EVM_FDT_FOLDER_PATH,
> > +				 CONFIG_DEFAULT_DEVICE_TREE);
> 
> If fdtfile isn't set, EFI bootmeth falls back to the control DT anyway,
> so this is unnecessary duplication of logic.

Wrong translation of what is going on here - it is assuming the
fdtfile _name_ is the same as the board file used for u-boot not the
control DT content(which is the fall back for bootmeth). It is possible
that the content is the same as what U-Boot is using, but the file
name is what is being selected here.

[...]
> > +
> > +#define TI_NAME_FDT_MAX 20
> 
> TI_BOARD_NAME_MAX??

OK - will fix.
> 
> > +#define TI_FDT_FILE_MAX 200
> > +
> > +/**
> > + *  struct ti_fdt_map - mapping of device tree blob name to board name
> > + *  @name_fdt: board_name up to TI_NAME_FDT_MAX long
> 
> If this is the board_name, why call it name_fdt?  Why not board_name?

will replace with board_name
> 
> > + *  @fdt_file_name: device tree blob name as described by kernel
> > + */
> > +struct ti_fdt_map {
> > +	const char *name_fdt;
> > +	char *fdt_file_name;
> > +};
> > +
> > +/**
> > + * ti_set_fdt_env  - Find the correct device tree file name and set
> >     'fdtfile'
> 
> "Find the correct device tree file name based on the board name and "...

OK.

> 
> > + * env variable with correct folder structure appropriate to the architecture
> > + * and kernel conventions. This function is invoked typically as part of
> > + * board_late_init
> > + *
> > + * fdt name is picked by:
> > + * a) If a match is found, use the match
> 
> "a) If a board name match is found, use the match"

OK.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
