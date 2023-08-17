Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21162EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4904A86AE6;
	Thu, 17 Aug 2023 13:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hc9XHrqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B58786ADB; Thu, 17 Aug 2023 13:46:36 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F4E86ADF
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HBkU3b029841;
 Thu, 17 Aug 2023 06:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692272790;
 bh=A6ncq6ef0ckQONF1SOYUHBLejlpLRRivRxtkayiYWt8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hc9XHrqL6uIe0gb9xZ/vDrWw74UVF9bEdpTpno4+apsf8p2SmL6pxC4Rrnma1wGRs
 L18aHVqZhDUrHeqvmbLNr6YdmPeQFAgGKcnxezUPTB+EPwD/DsR585B29ZCiPziK6W
 4CF9j4Xespx/B/08cBAuY9aM5MJ6DZ1yJHXbCP54=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HBkUHQ125123
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 06:46:30 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 06:46:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 06:46:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HBkTnY007734;
 Thu, 17 Aug 2023 06:46:29 -0500
Date: Thu, 17 Aug 2023 06:46:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] k3-j721s2: Sync from linux-next tag next-20230815
Message-ID: <20230817114629.clyw4lqj7mocfcf2@swirl>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
 <20230816114445.c4c7rgdp5arhmiaq@polyester>
 <20230817063120.kdaaszy7qja2kfrk@ula0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817063120.kdaaszy7qja2kfrk@ula0497581>
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

On 12:01-20230817, Manorit Chawdhry wrote:
[...]
> > 
> > Is there a reason to go with proc-board instead of som-p0?
> 
> I see the same in k3-am625-r5-sk.dts..
> 
> #include "k3-am625-sk.dts"
> #include "k3-am62x-sk-ddr4-1600MTs.dtsi"
> #include "k3-am62-ddr.dtsi"
> 
> #include "k3-am625-sk-u-boot.dtsi"
> 
> And I believe the reason must be so that all the Linux fixes get
> propagated to R5 dts as I mentioned in the commit message.

if you are asking about the ordering - yes it is much easier to read and
understand the include order. eventually the u-boot.dtsi will disappear
once we have the boot phase properties merged into k.org (like I think
j784s4 just did in the kernel Pull Request I sent out earlier this week
for 6.6-rc1) leaving a minimal r5.dts (for the processor view
differences) around.

> 
> > >  [snip]
> > >    - Include k3-j721s2-common-proc-board.dts file
> > >
> > >        Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
> > >        include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
> > >        to U-boot.
> > >  [snip]
> 
> Let me know if the reasoning is wrong..

If you are asking me for the reasoning of using board.dts vs som-p0.dts
change, I am asking your rational since you did the change. ;) I think I
see the reason that the common-proc-board.dts is the more accurate
representation of the board. you can definitely argue that
CONFIG_DEFAULT_DEVICE_TREE is using common-proc-board and som was a
mistake.


> > >  
> > >  &mcu_ringacc {
> > 
> > I see that you are overriding &mcu_udmap -> But I have not seen kernel
> > patches to clean that up to introduce reg-names "rchan" "tchan" and "rflow".
> 
> I believe the patch is posted Nishanth if you are asking about mcu_udmap, 
> I had added that in the cover letter, You can have a look at [0].
> Vignesh is handling adding those nodes in Linux.
> 
> [0]: https://lore.kernel.org/all/20230810174356.3322583-4-vigneshr@ti.com/

Thanks. Good to know this is being worked on.

> > 
> > Move the #include "k3-j721s2-common-proc-board-u-boot.dtsi" 
> > to the top.
> > 
> > The order should be:
> > 
> > #include "board.dts"
> 
> I see that you are also using board.dts here and not som-p0.dts, let me
> know what should be done about it. As I recall you having a previous
> comment mentioning about this.

Hope the explanations helped.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
