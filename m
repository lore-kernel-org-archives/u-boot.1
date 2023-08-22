Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60242EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 23:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B07E8643C;
	Wed, 23 Aug 2023 01:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i9XDY640";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBBC86421; Wed, 23 Aug 2023 01:34:05 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D26846C0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MNXwJ8000598;
 Tue, 22 Aug 2023 18:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692747238;
 bh=MFl1hFB6O10NYNDZDhT6099LxAwSRN7/Heliy/IKlG8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=i9XDY640nfoNiRap6g87FY/QMj7Ht/pEM+yfREzJWY1sz4O4QqzeEJzjGacBwb+vj
 lH7faV5sA85qi/himHSHZDhMxL+PFOa+ZovX+79b4AaloYM1B38SyJBW3hguEY6mrb
 X7n82cDU1tm9V1BuhAeuZfIrFN/nXnHhZnz1Q2WI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MNXwPP002809
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 18:33:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 18:33:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 18:33:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MNXwo3124229;
 Tue, 22 Aug 2023 18:33:58 -0500
Date: Tue, 22 Aug 2023 18:33:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
Message-ID: <20230822233358.geaqdn2vi34a5no2@uniformly>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
 <CAPnjgZ0p5YkgvYM_F0j97bvAoM1qieafyjFQ_neyUoDuNFyN2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0p5YkgvYM_F0j97bvAoM1qieafyjFQ_neyUoDuNFyN2g@mail.gmail.com>
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

On 17:16-20230822, Simon Glass wrote:
> Hi Nishanth,
> 
> On Tue, 22 Aug 2023 at 12:41, Nishanth Menon <nm@ti.com> wrote:
> >
> > CFG_EXTRA_ENV_SETTINGS is set in common board config files, This allows
> > for majority of the settings to be set in a common manner. However, the
> > minor variations between various board can be addressed by the board.env
> > files. The board.env files are converted into CONFIG_EXTRA_ENV_TEXT.
> >
> > However, this creates a minor problem. For example:
> > distro_bootcmd.h and used by ti_armv7_common.h uses it as:
> >  #define BOOT_TARGET_DEVICES(func) \
> >         func(MMC, mmc, 0) \
> >         func(MMC, mmc, 1)
> 
> OK, but we should be using bootstd for new boards.

Agreed, and I think I am using bootstd[1] unless I am missing something
completely.

we still have a problem with EXTRA_ENV_SETTINGS and ENV_TEXT. This patch
helps enforce priority of ENV_TEXT.

But overall, I agree that we need to move off from EXTRA_ENV to text..
probably in stages, I guess.

> >
> > Which in turn generates:
> > boot_targets=mmc0 mmc1
> >
> > And this probably works fine for most boards, However when the
> > boot_targets need to be reversed, the preferred behavior would have been
> > to define it in board.env file as:
> > boot_targets=mmc1 mmc0
> >
> > By changing the order of the inclusion, we allow for the
> > CONFIG_EXTRA_ENV_TEXT to have a higher priority in the definition.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> >
> > New patch
> >
> >  include/env_default.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/env_default.h b/include/env_default.h
> > index b16c22d5a28c..714dfa9e845e 100644
> > --- a/include/env_default.h
> > +++ b/include/env_default.h
> > @@ -112,12 +112,12 @@ const char default_environment[] = {
> >  #ifdef CONFIG_MTDPARTS_DEFAULT
> >         "mtdparts="     CONFIG_MTDPARTS_DEFAULT         "\0"
> >  #endif
> > +#ifdef CFG_EXTRA_ENV_SETTINGS
> > +       CFG_EXTRA_ENV_SETTINGS
> > +#endif
> >  #ifdef CONFIG_EXTRA_ENV_TEXT
> >         /* This is created in the Makefile */
> >         CONFIG_EXTRA_ENV_TEXT
> > -#endif
> > -#ifdef CFG_EXTRA_ENV_SETTINGS
> > -       CFG_EXTRA_ENV_SETTINGS
> >  #endif
> 
> and text environment

Could you clarify what I am missing?

[1] https://u-boot.readthedocs.io/en/latest/develop/bootstd.html
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
