Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BD0E743FE
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 09:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D9E85E44;
	Fri, 29 Sep 2023 11:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IYD3oQgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353738652B; Fri, 29 Sep 2023 11:23:54 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A2780EF7
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 11:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38T9NlBO093500;
 Fri, 29 Sep 2023 04:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695979427;
 bh=vR+j63t7c/pf0JC8tcJ9VjCXYWC/Ls7Jij5qs4usUEk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IYD3oQgy+QaPuycPdWJccHx4XFPSLednFpz4pMFJCSj2mbnfGV5vQiFTioT5xKb9j
 s/FEDbUewXLzG8ry6z30mgVB3Zj9X6OVG5izOXvVJsPu1PFa9LV45pCXp8KLS1juEN
 9kb8ZCU1rWCgYODehkhwxUCnEtq1urC5PUtSUUpY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38T9Nlx5005634
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Sep 2023 04:23:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Sep 2023 04:23:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Sep 2023 04:23:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38T9Njpo013408;
 Fri, 29 Sep 2023 04:23:46 -0500
Date: Fri, 29 Sep 2023 14:53:45 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20230929092345.7h3wevfzyqwaznvt@ula0497581>
References: <CAPnjgZ32+7B0SVvpE+r_c9ZyCXpkFErRJRf0uCAx-aCMuJc2ow@mail.gmail.com>
 <20230924211451.GK305624@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230924211451.GK305624@bill-the-cat>
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

Hi Tom, Simon

On 17:14-20230924, Tom Rini wrote:
> On Sat, Sep 23, 2023 at 01:52:55PM -0600, Simon Glass wrote:
> 
> > Hi Tom,
> > 
> > This is for the -next branch
> > 
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17836
> > 
> > 
> > The following changes since commit b05a184379631d13c4a49e423aa1324dc1ae6158:
> > 
> >   Merge tag 'x86-pull-20230922' of
> > https://source.denx.de/u-boot/custodians/u-boot-x86 into next
> > (2023-09-22 11:16:22 -0400)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.denx.de/u-boot-dm.git tags/dm-next-23sep23
> > 
> > for you to fetch changes up to ae84514feee209091d331a8baaa344ed8d8e905b:
> > 
> >   kontron_sl28: Use u-boot-update.bin instead of u-boot.update
> > (2023-09-23 12:31:25 -0600)
> > 
> 
> Applied to u-boot/next, thanks!

The following merge breaks K3 boards somehow, All have the same failure
signature, putting the logs here of J721e for your reference.

U-Boot SPL 2023.10-rc4-00487-g90c81f407dd4 (Sep 29 2023 - 12:27:00 +0530)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.6--v09.00.06 (Kool Koala)')
ESM init failed: -19
Trying to boot from UART
Cicate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Loaded 1008063 bytes
Loading Environment from nowhere... OK
init_env from device 7 not supported!
Starting ATF on ARM64 core...

NOTICE:  BL31: v2.9(release):v2.9.0-dirty
NOTICE:  BL31: Built : 14:12:59, May 22 2023
I/TC:
I/TC: OP-TEE version: 3.20.0 (gcc version 11.4.0 (GCC)) #1 Fri Jan 20 15:42:54 UTC 2023 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.6--v09.00.06 (Kool Koala)')
I/TC: HUK Initialized
I/TC: Activated SA2UL device
I/TC: Fixing SA2UL firewall owner for GP device
I/TC: Enabled firewalls for SA2UL TRNG device
I/TC: SA2UL TRNG initialized
I/TC: SA2UL Drivers initialized
I/TC: Primary CPU switching to normal world boot

U-Boot SPL 2023.10-rc4-00487-g90c81f407dd4 (Sep 29 2023 - 12:27:45 +0530)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.6--v09.00.06 (Kool Koala)')
Detected: J7X-BASE-CPB rev E3
Detected: J7X-VSC8514-ETH rev E2
Trying to boot from UART
Certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Loaded 1270887 bytes
[end]

Regards,
Manorit

> 
> -- 
> Tom


