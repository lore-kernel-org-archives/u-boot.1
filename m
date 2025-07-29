Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E2FC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 05:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777D782CFA;
	Tue, 29 Jul 2025 07:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ttj6YPkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317B082D21; Tue, 29 Jul 2025 07:33:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 996D982BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 07:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56T5XQoC2888857;
 Tue, 29 Jul 2025 00:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753767206;
 bh=RwN1RAKgq6F0dBsfMJqk2KVirZJABZwDf68Gb9WobfM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Ttj6YPkBM7Syq1skU5tIRs+0JLhHUP2ehZzqZ4a2vb+RXy9ZptlDG/evk+0W9yJu7
 zzoODmloYJ6XhtFgbYx2OEy8VzkkH/cJNBa1ReP8b75TySj5aj/0SMcE5xTtzQ7cyg
 fvDfyV9Z1vltbqQ4hy4L0jImQ6lEuh7JvXWJOrB8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56T5XQG51582328
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 29 Jul 2025 00:33:26 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 00:33:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 00:33:25 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56T5XOYM2900862;
 Tue, 29 Jul 2025 00:33:25 -0500
Date: Tue, 29 Jul 2025 11:03:24 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Andrew Davis <afd@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, <vigneshr@ti.com>,
 <bb@ti.com>, <nm@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>,
 <j-choudhary@ti.com>, <a-nandan@ti.com>, <a-dutta@ti.com>,
 <anshuld@ti.com>, <jm@ti.com>, <p-mantena@ti.com>, <n-francis@ti.com>,
 <s-k6@ti.com>, <rogerq@kernel.org>, <kamlesh@ti.com>,
 <a-shenai@ti.com>, <c-vankar@ti.com>, <kishon@ti.com>,
 <dannenberg@ti.com>, <h-salunke@ti.com>, <u-boot@lists.denx.de>,
 <praneeth@ti.com>, <srk@ti.com>
Subject: Re: [PATCH 01/45] configs: am335x_baltos_defconfig: Increase aneg
 timeout to 20000 ms
Message-ID: <106bb841-8fb1-490f-bc84-e49877b74db7@ti.com>
References: <20250728145034.225997-1-s-vadapalli@ti.com>
 <20250728145034.225997-2-s-vadapalli@ti.com>
 <a0f6b8ef-ac29-4f53-8d02-c20b1cb0305c@ti.com>
 <9303e5f8-9723-45e4-9ef6-5aef6234bd10@ti.com>
 <20250728165329.GI1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250728165329.GI1807455@bill-the-cat>
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

On Mon, Jul 28, 2025 at 10:53:29AM -0600, Tom Rini wrote:

Hello Tom,

> On Mon, Jul 28, 2025 at 11:36:53AM -0500, Andrew Davis wrote:
> > On 7/28/25 10:33 AM, Kumar, Udit wrote:
> > > 
> > > On 7/28/2025 8:19 PM, Siddharth Vadapalli wrote:
> > > > Increase the PHY Auto-Negotiation timeout to 20,000 ms from the current
> > > > default of 4,000 ms inherited from "Kconfig" for PHY_ANEG_TIMEOUT.
> > > > 
> > > > The motivation for this change is that existing devices will continue
> > > > working as-is (timeout is an upper bound and auto-negotiation can be
> > > > done earlier), while older Hardware connected to the board that might
> > > > occasionally take longer than 4,000 ms for the Auto-Negotiation process
> > > > will benefit from an increased timeout.
> > > 
> > > 
> > > Can we think of using TI_COMMON_OPTION , similar to TI_COMMON_CMD_OPTIONS
> > > 
> > 
> > Or simply change the default in Kconfig to something like:
> > 
> > default 20000 if ARCH_K3 || ARCH_OMAP2PLUS || ARCH_KEYSTONE
> > default 4000
> > 
> > Much better than 45 patches updating each board defconfig individually.
> > 
> > Side question, if this is right for TI plats, why is it not right for
> > all the other platforms? Should this be the new base default timeout?
> > I don't really think so in either case, the point of the timeout is to
> > switch to a fallback port or boot mode in a reasonable time, not sure
> > 20 seconds is reasonable..
> > 
> > (you probably don't need ~50 people in the TO/CC on this one either, not
> > everyone who has ever touched the defconfigs cares about PHY timeouts)
> 
> [trimmed the CC list a bit]
> 
> The other part of this to me is, is this even right outside of "we have
> a big test board farm" ? And since this is read from the environment now
> (yes?) can we instead not just expect big labs to update the
> environment? Or no, too many of these will lack persistent environments?

I have posted a patch to allow overriding the timeout in the form of an
environment variable [0].

I agree that end users should override the config for their use-case and
it is mostly in the Test Farm that we see issues - the process takes
around 8 seconds once in a while and that triggers a timeout. However,
since the "config" is a timeout rather than a delay, it will not
increase the time taken for the auto-negotiation process. So it might be
safe to increase the timeout, except in cases where we wish to detect a
timeout early (if it doesn't complete within 4 seconds, we don't expect
it to ever complete, so there is no point waiting for 20 seconds).

Please let me know which among the following seem acceptable:
1. The patch at [0] is the proper method to override the timeout and the
   config shouldn't be modified.
2. The default value is modified in Kconfig based on Andrew's suggestion:
	default 20000 if ARCH_K3 || ARCH_OMAP2PLUS || ARCH_KEYSTONE
	default 4000
3. Another approach that you may wish to suggest in order to address the
   problem.

[0]: https://patchwork.ozlabs.org/project/uboot/patch/20250724141536.1222764-1-s-vadapalli@ti.com/

Regards,
Siddharth.
