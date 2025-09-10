Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E51ECA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 12:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 895B2831D5;
	Wed, 10 Sep 2025 14:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rSECPpZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665DE8319C; Wed, 10 Sep 2025 14:53:40 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C56830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 14:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ACralr139499;
 Wed, 10 Sep 2025 07:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757508816;
 bh=Ynhv8L2m0iXFgGj6/3TExxWAMdTdc1/cXRMedYvkQHg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=rSECPpZ4ZpOMQg25BFbZfANzihRi6vDzCzNKYzLW11tHG+gQXUruaDarR8oh830Iq
 GvAgs/QuzVNvKcWvaf5KjFA503RM2FenJVRUDHNzkL5KLL58tzcfZ9rAAz2hA2zLOz
 ow0wgw2dfWXIRbG+cqdpLjnEu5BgHhCLTaihmtcA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ACrZQS1155104
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 07:53:35 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 07:53:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 07:53:35 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ACrZaw198861;
 Wed, 10 Sep 2025 07:53:35 -0500
Date: Wed, 10 Sep 2025 07:53:35 -0500
From: "bb@ti.com" <bb@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "d.schultz@phytec.de" <d.schultz@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "kishon@ti.com"
 <kishon@ti.com>, "c-vankar@ti.com" <c-vankar@ti.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Message-ID: <20250910125335.orpc2lrm2amncbwg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
 <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
 <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
 <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
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

On September 10, 2025 thus sayeth Sverdlin, Alexander:
> Hi Bryan!
> 
> On Wed, 2025-09-10 at 07:08 -0500, bb@ti.com wrote:
> > On September 10, 2025 thus sayeth Daniel Schultz:
> > > Hi Alexander,
> > > 
> > > On 8/21/25 18:21, Sverdlin, Alexander wrote:
> > > > Dear Daniel, TI team,
> > > > 
> > > > On Fri, 2025-08-15 at 09:02 -0700, Daniel Schultz wrote:
> > > > > The watchdog requires to have the MCU ESM error source enabled to
> > > > > trigger a system reboot. When booting HS-SE (security enforced)
> > > > > devices, the MMR registers are locked again and all write commands
> > > > > are simply ignored.
> > > > > 
> > > > > Unlock the MMR registers again to successfully enable the MCU ESM
> > > > > source.
> > > > I'm just curious, could you please elaborate a bit, where the registers
> > > > are being locked again if they are being unlocked by ctrl_mmr_unlock()
> > > > in board_init_f() before enable_mcu_esm_reset()?
> > > > 
> > > > Is it TIFS firmware?
> > > > What else could be affected?
> > > > Do we expect to leave General Purpose Control Registers unlocked
> > > > when we return from board_init_f()?
> > > > Does it mean that the whole ctrl_mmr_unlock() has to be re-done
> > > > after k3_sysfw_loader() call?
> > > 
> > > I really can't tell why those registers are locked again. I figured out
> > > they're only locked again after loading the TIFS firmware on HS-SE devices.
> > > So, I also assume the firmware itself locks those registers again as part of
> > > a secure/security feature.
> > 
> > Hmm yeah this is likely a bug or a config issue. Ideally we 
> > (U-Boot/Linux) should be in complete control of when these are locked or 
> > unlocked. TIFS or DM shouldn't be anywhere near these MMRs.
> > 
> > > 
> > > The A53 SPL will unlock those registers again, which will be permanent. Only
> > > the watchdog is problematic because enable_mcu_esm_reset is currently only
> > > called in the R5 SPL (config only enabled in the R5 SPL defconfig).
> > > 
> > > BTW: We have seen the same behavior with the AM68A/J721S2.
> > 
> > Hmm this is strange.
> 
> Thanks for your assessment!
> Do you know who can be contacted at TI regarding this possible problem in
> TIFS firmware? Maybe this has to be fixed in TIFS firmware indeed?

I've started creating some noise internally to see if we can debug this 
faster. Most of these teams are fairly insulated from the outside world 
and can only be reached via e2e tickets.

~Bryan
