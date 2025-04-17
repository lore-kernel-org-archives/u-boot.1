Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA10C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 11:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A325D82C8A;
	Thu, 17 Apr 2025 13:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L2C6fG/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC76082CA8; Thu, 17 Apr 2025 13:30:18 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A0D82BA4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 13:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HBUD7D2949662
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 06:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744889413;
 bh=W+a7Ud8uzPwYGuxW0fgvPWeoKDHkZH6JBgBfiS4RHyE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=L2C6fG/lV+X7IhLw4kp4EQfKrpxJ3CV5ou6fG3t859Qhq9lFxVOOifcah8JZZ3fTh
 Btk2OEhXkcYWHor55sBP9hyaClL2XDgMU7zEQYTnVqET4x3bIpt0NYfPKjan0cC81P
 SMUMDf6droDw3M6nBDF3ovoOYNB02BEsS0Sp8LtY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HBUDbC057830
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Apr 2025 06:30:13 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 06:30:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 06:30:13 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HBUD7R096551;
 Thu, 17 Apr 2025 06:30:13 -0500
Date: Thu, 17 Apr 2025 06:30:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
Message-ID: <20250417113013.mrlhl65farooaiq2@extradite>
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus>
 <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
 <20250416150506.ws22odswwkjn2wth@deflected>
 <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
 <20250416195113.mtfdclfvb756vpll@scoreless>
 <D98SY3X7C15U.15HUGCO6FK1T0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D98SY3X7C15U.15HUGCO6FK1T0@ti.com>
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

On 14:51-20250417, Anshul Dalal wrote:
> On Thu Apr 17, 2025 at 1:21 AM IST, Nishanth Menon wrote:
> > On 11:38-20250416, Andrew Davis wrote:
> >> > > > 	How about u-boot documentation?
> >> > > 
> >> > > I will update that in the next revision along with any feedback I
> >> > > receive on this patch.
> >> > 
> >> > IMHO, This change is too intrusive and impacts downstream customers
> >> > including inflight production devices.
> >> > 
> >> 
> >> Could you elaborate a little?
> >> 
> >> They do not even need to update their TF-A version, if they want to
> >> use their current version they simply recompile it with a single
> >> extra build flag:
> >> 
> >> PRELOADED_BL33_BASE=0x822000000
> >
> > For folks who are trying to boot linux from TFA, they could do the same.
> 
> This change would allow us to support both standard boot flow and falcon
> mode from the same upstream source. With the only downside being the

Other than trivial usecases, no you cannot. There is a lot of
monkeying of dtb that u-boot does with mac address, HS-FS based dt node
enable/disable etc. In effect, at a product level it ends up as a different
flow.

> slight overhead added by the jump-stub (~1.7KiB added to tispl.bin and
> two extra instructions to jump to u-boot from older ATF builds).

The boot flow is already a complex flow at the moment. If we go down
this road, U-boot will have no choice but to support both variants of
TFA for all eternity - any fallacy that people will upgrade U-boot and
TFA baselines in sync is wrong.

> 
> And we can remove the stub altogether once all the customers have
> migrated over to the new address.

When would we know? There are gazillion usage models we are not aware
of. U-boot is not the only game in town for bootloaders. Barebox, and
other bootloader ecosystems will also need to pony up, that too hand in
hand with migration to new address proposed in TFA.

> 
> In addition to that this also frees up the bottom of DDR which allows us
> to more easily support low memory systems (512MiB or less) as we can use
> the freed up space for more tightly packing OP-TEE, DM etc.  instead of
> having the binaries loaded at scattered addresses like we do now.

Now, we are suggesting an entire memory map revamp impacting more
s/w components. For platforms with low DDR capabilities (e.g.
PocketBeagle2), please do the necessary changes when introducing to
mainline.

> 
> >> 
> >> They should have no reason not to be able to do this. But even *if*
> >> they cannot do that, the whole point of the jump-stub here is to
> >> save them even having to do a simple compile.
> >> 
> >> IMHO "downstream customers including inflight production devices"
> >> should not be a reason to block good and useful changes here in
> >> upstream. But again, this change doesn't break anything for them in
> >> the first place, so why bring that up?
> >
> > I dont see a specific value here. U-boot just works. For folks who want
> > direct TFA to kernel jump (which is a niche fast boot usecase), go ahead
> > and use TFA with the mentioned build option.
> 

IMHO, there is a simpler alternate solution - build TFA, dtb etc in the
model of your desire. let us leave the defaults be.

I will let Tom and other U-boot maintainers make their choice, as TFA
maintainer, I have already rejected the approach. it is already
PRELOADED_BL33_BASE ?= 0x80080000 which allows for override at build
time instead of all the massive rework and downstream ecosystem impact.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
