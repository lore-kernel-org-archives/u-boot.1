Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B747FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6CC86689;
	Mon,  6 Nov 2023 13:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bt5SGmw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F6F86489; Mon,  6 Nov 2023 13:21:26 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0E786689
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6CLHeG027576;
 Mon, 6 Nov 2023 06:21:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699273277;
 bh=2Z+bclEsVaE4vBSmyegM2C0EhtlgdYAruKsp8SRYNjI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bt5SGmw1tGen1FtQnNof0uZxTytP7nnpDI4MBT9NJRWeynhiFMGqWuKVwOH2duDqr
 qFFHQJbgr3YB7ErbLwjQkVv+DeEwt7HxNRcKSN3VnvyiLYq8kXQn6JV4vvMihOUbs/
 a7QNmo1EACVEYMLujeKFDQdF55zGbZerC5XwmDPA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6CLH4w129744
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 06:21:17 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 06:21:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 06:21:16 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6CLGmA088319;
 Mon, 6 Nov 2023 06:21:16 -0600
Date: Mon, 6 Nov 2023 06:21:16 -0600
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Reid Tonking <reidt@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 10/15] configs: j721e_evm_a72_defconfig: Switch to bootstd
Message-ID: <20231106122116.g6xwxgl4hrdpcgeh@debit>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-11-nm@ti.com>
 <20231106052826.nbtzqzudnh7v3yix@ula0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231106052826.nbtzqzudnh7v3yix@ula0497581>
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

On 10:58-20231106, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 19:38-20231102, Nishanth Menon wrote:
> > Switch to using bootstd. Note with this change, we will stop using
> > distro_bootcmd and instead depend entirely on bootflow method of
> > starting the system up.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  configs/j721e_evm_a72_defconfig | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
> > index 99e0e168ebf7..98ac7ca59789 100644
> > --- a/configs/j721e_evm_a72_defconfig
> > +++ b/configs/j721e_evm_a72_defconfig
> > @@ -29,10 +29,11 @@ CONFIG_SPL_SPI=y
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_SPL_LOAD_FIT=y
> >  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> > -CONFIG_DISTRO_DEFAULTS=y
> >  CONFIG_OF_BOARD_SETUP=y
> >  CONFIG_OF_SYSTEM_SETUP=y
> > -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> > +CONFIG_BOOTSTD_FULL=y
> > +CONFIG_BOOTSTD_DEFAULTS=y
> > +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
> 
> Coming back to [0], AM62x didn't have early remote procs but j721e does,
> do you have any alternatives in place before migrating J7 platforms to
> stdboot?

As I have stated before. distro boot support for remote proc has been
hacked up atm. what needs to happen is standardize it. Which is
independent of this series.

Please discuss with stdboot folks how to get it in. WORST case, envboot
is still supported, so in effect, what is achieved today can still
continue to occur with envboot.

> 
> Regards,
> Manorit
> 
> [0]: https://lore.kernel.org/u-boot/20231005171010.zvza7uqyn4mcgp5g@handsaw/
> 
> >  CONFIG_LOGLEVEL=7
> >  CONFIG_SPL_MAX_SIZE=0xc0000
> >  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> > -- 
> > 2.40.0
> > 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
