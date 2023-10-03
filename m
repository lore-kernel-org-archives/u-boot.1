Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FABFE7544E
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 11:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2E387138;
	Tue,  3 Oct 2023 13:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JXhSAwUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D9387143; Tue,  3 Oct 2023 13:22:25 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C3C86E29
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393BMKlW064266;
 Tue, 3 Oct 2023 06:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696332140;
 bh=LP8zguK04s+fhlvWSjWiXCg/yfQDw5sjWHutQTBHSiI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JXhSAwUN91g6H8z98ue5laIlPmGb5jjXrSVgDBoRcOKsLnVSRJiDm3GRch25tyK6A
 WefavDBjcXfp2dzKuzKuqrAyiFE6gSGW25azwastuhVmYRkpwp+gYeppVnyTIRAN3w
 CYkFgFupfu8rXVKG3nFmHx1V317GRr5dx0qxdf+c=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393BMKCZ011053
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 06:22:20 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:22:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:22:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393BMJEW015034;
 Tue, 3 Oct 2023 06:22:20 -0500
Date: Tue, 3 Oct 2023 16:52:19 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH v2 4/8] binman: k3: add k3-security.h and include it
 in k3-binman.dtsi
Message-ID: <20231003112219.qgie4natzvlfyepo@ula0497581>
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-4-b1a084ec634d@ti.com>
 <CAPnjgZ1siOjfeKtQQgTWjvCV0LvE-R1KOBfwiaZL6pdadwtxmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1siOjfeKtQQgTWjvCV0LvE-R1KOBfwiaZL6pdadwtxmA@mail.gmail.com>
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

On 19:17-20231001, Simon Glass wrote:
> Hi Manorit,
> 
> On Tue, 26 Sept 2023 at 01:59, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > For readability during configuring firewalls, adding k3-security.h file
> > and including it in k3-binman.dtsi to be accessible across K3 SoCs
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  arch/arm/dts/k3-binman.dtsi |  2 ++
> >  arch/arm/dts/k3-security.h  | 58 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> nits below
> 
> > diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> > index 2ea2dd18a12b..71ffa998a59f 100644
> > --- a/arch/arm/dts/k3-binman.dtsi
> > +++ b/arch/arm/dts/k3-binman.dtsi
> > @@ -3,6 +3,8 @@
> >   * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> >   */
> >
> > +#include "k3-security.h"
> > +
> >  / {
> >         binman: binman {
> >                 multiple-images;
> > diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
> > new file mode 100644
> > index 000000000000..e012b7afaf94
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-security.h
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +#ifndef DTS_ARM64_TI_K3_FIREWALL_H
> > +#define DTS_ARM64_TI_K3_FIREWALL_H
> > +
> > +#define FWPRIVID_ALL    (0xc3)
> > +#define FWPRIVID_ARMV8  (1)
> > +#define FWPRIVID_SHIFT  (16)
> 
> drop () on those three and the next one
> 

Would fix those in next revision. Thanks for the reviews!

Regards,
Manorit

> > +
> > +#define FWCTRL_EN     (0xA)
> > +#define FWCTRL_LOCK   (1 << 4)
> > +#define FWCTRL_BG     (1 << 8)
> > +#define FWCTRL_CACHE  (1 << 9)
> > +
> > +#define FWPERM_SECURE_PRIV_WRITE      (1 << 0)
> > +#define FWPERM_SECURE_PRIV_READ       (1 << 1)
> > +#define FWPERM_SECURE_PRIV_CACHEABLE  (1 << 2)
> > +#define FWPERM_SECURE_PRIV_DEBUG      (1 << 3)
> > +
> > +#define FWPERM_SECURE_PRIV_RWCD       (FWPERM_SECURE_PRIV_READ | \
> > +                                       FWPERM_SECURE_PRIV_WRITE | \
> > +                                       FWPERM_SECURE_PRIV_CACHEABLE | \
> > +                                       FWPERM_SECURE_PRIV_DEBUG)
> > +
> > +#define FWPERM_SECURE_USER_WRITE      (1 << 4)
> > +#define FWPERM_SECURE_USER_READ       (1 << 5)
> > +#define FWPERM_SECURE_USER_CACHEABLE  (1 << 6)
> > +#define FWPERM_SECURE_USER_DEBUG      (1 << 7)
> > +
> > +#define FWPERM_SECURE_USER_RWCD       (FWPERM_SECURE_USER_READ | \
> > +                                       FWPERM_SECURE_USER_WRITE | \
> > +                                       FWPERM_SECURE_USER_CACHEABLE | \
> > +                                       FWPERM_SECURE_USER_DEBUG)
> > +
> > +#define FWPERM_NON_SECURE_PRIV_WRITE      (1 << 8)
> > +#define FWPERM_NON_SECURE_PRIV_READ       (1 << 9)
> > +#define FWPERM_NON_SECURE_PRIV_CACHEABLE  (1 << 10)
> > +#define FWPERM_NON_SECURE_PRIV_DEBUG      (1 << 11)
> > +
> > +#define FWPERM_NON_SECURE_PRIV_RWCD       (FWPERM_NON_SECURE_PRIV_READ | \
> > +                                           FWPERM_NON_SECURE_PRIV_WRITE | \
> > +                                           FWPERM_NON_SECURE_PRIV_CACHEABLE | \
> > +                                           FWPERM_NON_SECURE_PRIV_DEBUG)
> > +
> > +#define FWPERM_NON_SECURE_USER_WRITE      (1 << 12)
> > +#define FWPERM_NON_SECURE_USER_READ       (1 << 13)
> > +#define FWPERM_NON_SECURE_USER_CACHEABLE  (1 << 14)
> > +#define FWPERM_NON_SECURE_USER_DEBUG      (1 << 15)
> > +
> > +#define FWPERM_NON_SECURE_USER_RWCD       (FWPERM_NON_SECURE_USER_READ | \
> > +                                           FWPERM_NON_SECURE_USER_WRITE | \
> > +                                           FWPERM_NON_SECURE_USER_CACHEABLE | \
> > +                                           FWPERM_NON_SECURE_USER_DEBUG)
> > +
> > +#endif
> >
> > --
> > 2.41.0
> >
> 
> Regards,
> Simon
