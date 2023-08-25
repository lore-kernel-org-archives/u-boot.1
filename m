Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7708AC727A1
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 01:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4FC86492;
	Fri, 25 Aug 2023 03:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fOQcHt+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EB686492; Fri, 25 Aug 2023 03:16:34 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B10886429
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37P1GNk8107277;
 Thu, 24 Aug 2023 20:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692926183;
 bh=fE5gpsp7t6sUn3QmPezntLbu/oLA8XK2iWcYQy4WAbU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fOQcHt+l1cDKd3ieTXOC0jNu/rMyGDXsnoEy/rHkZxLlvzet6TuaUm4EzhoH69xmZ
 I75WYtlmCBWTJCEU4+VGqSUoXcK+6VHRBqyQuYNxXY3DX9MM6AOQ9MsF2V6NCO4LqU
 5PRo0pH5sBs07/3oTpOC/jqqL6U45kSSUWl+HeVo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37P1GNxx018757
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 20:16:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 20:16:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 20:16:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37P1GNn2004654;
 Thu, 24 Aug 2023 20:16:23 -0500
Date: Thu, 24 Aug 2023 20:16:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Jan Kiszka <jan.kiszka@web.de>, Neha Francis <n-francis@ti.com>, Simon
 Glass <sjg@google.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] board: ti: am62x: beagleplay: Disable semi-functional
 PSCI reset support
Message-ID: <20230825011623.c74qqidp6wgvc5kl@plaza>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-17-nm@ti.com>
 <c93b19ed-43fe-44a2-9726-371fb9d2f825@web.de>
 <20230824215825.GF3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824215825.GF3953269@bill-the-cat>
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

On 17:58-20230824, Tom Rini wrote:
> On Thu, Aug 24, 2023 at 11:53:17PM +0200, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > At this point, system shutdown is not supported by the DM firmware that
> > TF-A calls. As we can't de-select only this feature, declare complete
> > PSCI reset support as non-functional so that we don't signal incomplete
> > support to the OS via EFI runtime services. This makes power-off under
> > Linux work again when booting via EFI.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  board/ti/am62x/beagleplay_a53.config | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beagleplay_a53.config
> > index 967f794446d..8b0f671bc9e 100644
> > --- a/board/ti/am62x/beagleplay_a53.config
> > +++ b/board/ti/am62x/beagleplay_a53.config
> > @@ -53,3 +53,5 @@ CONFIG_SPI=n
> >  CONFIG_SPI_FLASH=n
> >  CONFIG_SPL_DM_SPI_FLASH=n
> >  CONFIG_SPL_SPI_FLASH_SUPPORT=n
> > +# DM firmware lacks support for shutdown
> > +# CONFIG_PSCI_RESET is not set
> 
> Is this lack of feature for just the beagleplay part of the firmware
> stack or more generically to the TI am62x platforms?

Thanks a ton Jan for digging deep into this and finding this. So much
appreciated.

This is all K3 platforms with the exception of j7200-evm.

PSCI SYSTEM_OFF function is routed by TFA to DM, there is no implementation
on DM side since involved PMIC and team is trying to lock in a manner in
which it is easier for people to describe things.

PSCI SYSTEM_RESET on the other hand is handled correctly by DM.

Even though CONFIG_POWEROFF is disabled, apparently enabling PSCI_RESET
results in EFI runtime services gets to think that poweroff is also
supported. Looking at drivers/firmware/psci.c[1] efi request for
poweroff is via EFI_RESET_SHUTDOWN[2] - so the specification itself
mandates that both reset AND poweroff should be implemented.

Luckily for us we have a broken u-boot reset implementation, which last
I looked was not following the h/w specifications and the intent was to
move to PSCI -> DM for reset so that system can properly reset and not
get randomly hung during reset under certain circumstances.

But, given the circumstances, I can pick this up and do it at am62_evm
level rather than at just beagle level. I will pick this patch up and
roll it up into v6 of the beagleplay series - but will modify am62x_evm
config instead.

[1] https://github.com/u-boot/u-boot/blob/master/drivers/firmware/psci.c#L246
[2] https://uefi.org/specs/UEFI/2.9_A/08_Services_Runtime_Services.html?highlight=efiresetshutdown#resetsystem
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
