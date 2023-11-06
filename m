Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2370CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 05:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD93286470;
	Mon,  6 Nov 2023 06:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IRJQD6tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFD88622B; Mon,  6 Nov 2023 06:54:14 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AE086B0A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 06:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A65rrlb044573;
 Sun, 5 Nov 2023 23:53:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699250033;
 bh=Q+VKH4U7SY3bmTsr3WBbbAw8GUsFSr+AVaBA7XfEgkE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IRJQD6tvddQ+OKHIN02lcjHhbWc6DqZnRzi6cFlmqB1g4fDCsDuEM1rF33umpWdfZ
 D++x5fQzRNdg5ZNhhFVFldj6gwx3o2haBw4IEPptDc2bfGGCMj3qzM6vMtfuM/rCkj
 4G9HFeX58nceuXAmzTssOTZcMr58QkoWeoLvtQog=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A65rrwG058507
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 5 Nov 2023 23:53:53 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 5
 Nov 2023 23:53:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 5 Nov 2023 23:53:52 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A65rpWt002267;
 Sun, 5 Nov 2023 23:53:52 -0600
Date: Mon, 6 Nov 2023 11:23:51 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Andrew Davis
 <afd@ti.com>, Roger Quadros <rogerq@kernel.org>,
 <vigneshr@ti.com>, <jonas@kwiboo.se>, <srk@ti.com>, <bb@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20231106055351.f2fny5ys6avi5qnk@ula0497581>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
 <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
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

Hi Simon,

On 11:22-20231005, Simon Glass wrote:
> Hi Nishanth,
> 
> On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
> >
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
> > Maybe Simon or someone know how the stdboot flow handles authenticated
> > kernel image and dtb boot flow with FIT image?
> 
> Yes you can use FIT configuration verification and things should work as normal.
> 

Could you give any reference documentation for this?

Regards,
Manorit

> Regards,
> Simon
