Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8653CED26E
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 10:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE2783C96;
	Tue, 18 Nov 2025 11:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Og1X1gbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D29683C98; Tue, 18 Nov 2025 11:29:23 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84BD83C65
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8237825F3A;
 Tue, 18 Nov 2025 11:29:20 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioxSg3n7kF3b; Tue, 18 Nov 2025 11:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1763461759; bh=pGwqmuBn+yJW0c8P1bkgtP9sXXFCr6YDRxs5xCciZpQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Og1X1gbzStMGYx0gDOiKOTIop1QxBe9HAXZyH4ClkI0LTCaerhPDcQfI7UAVgRHqC
 KNVxBxeRnPjDFsmRp+BcT1/Fe1MuJE+Up30iLbY1Wx6OrqXHRm48xu5OA7x+eJS78O
 MlUssQ773Gqts0AJBxj684wbtffzBt7i7tMmFIIEeHbtSvHJEc0aBJliGTLG8v4Rm1
 UKShmCIOwCRT9l7/Rc82+oqIJAFnO7obWF3Rwu+i1UXOAARQGm8bHVvU8VhXNiOuAy
 Kq3wf1zNgQlfvR32Wv7VVTykBWf9MssqNt1LRww3WWBEmLS9Eqw9DAALXyOA4TwDCw
 LM5PXxhb7Azkw==
Date: Tue, 18 Nov 2025 10:29:06 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Leo Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] doc: board: starfive: update jh7110 common description
Message-ID: <aRxKcvcc2IP-2dfw@pie>
References: <20251117233603.15409-1-e@freeshell.de>
 <24B5D5B7-0D3F-4091-82B8-A5E2328DE59F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24B5D5B7-0D3F-4091-82B8-A5E2328DE59F@gmx.de>
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

On Tue, Nov 18, 2025 at 08:08:12AM +0100, Heinrich Schuchardt wrote:
> Am 18. November 2025 00:35:51 MEZ schrieb E Shattow <e@freeshell.de>:
> >Updates to the JH7110 common description:
> >- add detailed overview of JH-7110 SoC and boot process
> >- revise descriptions of deprecated StarFive loader modes
> >- refresh build directions grouped with SPL debug advice
> >- reduce usage instructions into common methods shared by supported boards
> >- cite starfive_visionfive2 board maintainer description of StarFive loader
> >- cite published datasheets for ambient operating temperature data
> >
> >Redundant/deprecated sections of each board doc are dropped accordingly:
> >- deepcomputing fml13v01
> >- milk-v mars
> >- pine64 star64 (also add inclusion of JH7110 common description)
> >- visionfive2
> >
> >Signed-off-by: E Shattow <e@freeshell.de>
> >---
> >Changes since v1:
> >
> >By popular request I have expanded on the topic of deprecated boot modes.
> >For those users that rely on this it is now more descriptive about
> >factors contributing to the feature deprecation and naming the U-Boot
> >release version when this change is in effect. Re-introducing these modes
> >is out of scope for this documentation series, however.
> >
> >- reST needs a space between numeric and the substitution
> >- add comment identifying where U-Boot SPL again reads state of [RGPIO1:RGPIO0]
> >  useful to refer to for boards with button+transistors instead of MSEL DIP
> >- cite reference to JH-7110 Boot User Guide BootROM description of StarFive loader
> >- expand on topic of supported and deprecated U-Boot SPL boot modes
> >- cite from published datasheets for ambient operating temperature data
> >- drop not-yet-published OpenSBI version recommendation
> >---

...

> >diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
> >index 4a8058ee5da..2f049b4c327 100644
> >--- a/doc/board/starfive/jh7110_common.rst
> >+++ b/doc/board/starfive/jh7110_common.rst
> >@@ -1,103 +1,560 @@

...

> >+There are additional unexplained GUID references in the JH-7110 MaskROM so the
> >+description given is not complete. Attribution and modifications to the GPL2.0+
> >+source code used in StarFive loader have not been published as of this writing.
> >+Due to the lack of verifiable documentation the upstream Linux devicetree does
> >+not contain hints for mmc0 and mmc1 interfaces to be included in U-Boot SPL. As
> >+of U-Boot release v2025.10 and newer the U-Boot specific devicetree override of
> >+hints for mmc0 and mmc1 interfaces that are required for the deprecated modes
> >+have been dropped marking the deprecation of these boot modes in U-Boot.
> 
> Do you mean upstream  U-Boot will fail to boot from SD-card, which is the Ubuntu default?
> 
> This would need to be fixed urgently. 

U-Boot master has failed to boot from SD-Card on VisionFive 2 for some
time, see my previous report[1] in Octorber.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/aPYUlyni65Ux8xpq@pie/
