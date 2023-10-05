Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE65EE92719
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745FE86C8E;
	Thu,  5 Oct 2023 19:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d4CYLnq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D3586C8E; Thu,  5 Oct 2023 19:28:45 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC53886B67
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395HSZCE093849;
 Thu, 5 Oct 2023 12:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696526915;
 bh=xn/y/PJvbxlxurJa30VbIaK+B/wKFV1uReWH1QNmcno=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=d4CYLnq/9+BqFvR7xV8Akh13y6vduiKWoUsM/Zga7cPj5HqCH6OhY5Qurwa9CNJFq
 b/KQ9MSv+J3rwOakBOOTphj7Ui+EwQiOlZIBxoZGRynZunZjMKYtqSuN2vcS3J7eVx
 t+NJwWf0Brumx3i0n+J1b+zPwQnk0TowsnO9pT7c=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395HSZrw024164
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 12:28:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 12:28:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 12:28:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395HSYoN093184;
 Thu, 5 Oct 2023 12:28:34 -0500
Date: Thu, 5 Oct 2023 12:28:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, <sjg@chromium.org>,
 <jonas@kwiboo.se>, <srk@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20231005172834.epqqt3oe74wn7hss@overbill>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
 <bfe21d76-344c-45fe-8bca-a5677c8db464@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bfe21d76-344c-45fe-8bca-a5677c8db464@ti.com>
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

On 12:22-20231005, Andrew Davis wrote:
> On 10/5/23 12:16 PM, Nishanth Menon wrote:
> > On 12:10-20231005, Nishanth Menon wrote:
> > > On 12:36-20231005, Tom Rini wrote:
> > > > On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> > > > > On 10/4/23 8:54 AM, Nishanth Menon wrote:
> > > > > > On 08:48-20231004, Andrew Davis wrote:
> > > > > > > On 10/4/23 8:23 AM, Roger Quadros wrote:
> > > > > > > > ti_mmc is not a valid boot_target for standard boot flow so
> > > > > > > 
> > > > > > > Is there some way to make it into a valid boot_target? Otherwise
> > > > > > > how do we use uEnv.txt files, or boot from FIT images with overlays?
> > > > > > 
> > > > > > envboot takes care of uEnv.txt file (see
> > > > > > https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> > > > > > 
> > > > > > Early remote proc loading and FIT image is a question for stdboot itself.
> > > > > > 
> > > > > 
> > > > > If stdboot is missing these features then we shouldn't switch until it
> > > > > has them. I'm all for switching to this, but only if it is complete.
> > > > 
> > > > Depends on what you mean?  Did you mean an option to run scripts
> > > > (exists) or an option to do what TI needs done, via
> > > > boot/bootmeth_something.c ?  If the latter, someone from TI needs to
> > > > figure out what that should be and do (but plumbing-wise everything it
> > > > needs should exist).
> > > 
> > > Andrew is generalizing here (on the wrong patch though).
> > > 
> > > On am62x platforms, there is nothing regressing with this series. The
> > > challenge is early remote_proc loading which is done for J7* platforms.
> > > 
> > > How that is initiated as part of bootmethods is something of a gap.
> > > 
> > > The other gap has been support for uEnv.txt -> which we can workaround
> > > at the moment by using CONFIG_BOOTCOMMAND="run envboot; bootflow scan
> > > -lb" in defconfig (This series from Roger already does that - hence I am
> > > saying that Andrew is complaining on the wrong series).
> > > 
> > > Ideally, we should just have CONFIG_BOOTCOMMAND="bootflow scan -lb" and
> > > uEnv.txt remoteproc loads and the various standard bootmethods should
> > > "just work".
> > 
> > 
> > I forgot to add: FIT image authenticated boot flow. That is really what
> > ti_mmc distroboot method was trying to solve.
> > 
> 
> Right, FIT (and remote proc loading) are handled in ti_mmc, and this
> is the patch removing that (so I do believe I am complaining on the right
> patch here). I know that needs removed before we switch to stdboot, but
> we cant remove it until someone has the the alternative in place.
> 
> Simply dropping it and hoping someone else comes along later and re-adds
> the features isn't a good idea. Even if, as said above, the plumbing we
> need should already exist, it needs done first.

As simon stated:
https://lore.kernel.org/all/CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com/
FIT is already supported.

remoteproc support was not yet added for am62.. so there is no real
regression, that said, even then, it can still be handled by envboot
till we solve that aspect. There is no real reason to hold back stdboot
as the standardization is very valuable at this point.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
