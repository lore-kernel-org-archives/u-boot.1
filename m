Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAC4EE49B2
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C818645F;
	Wed, 23 Aug 2023 17:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ysGUfJju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E625E8646D; Wed, 23 Aug 2023 17:07:06 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D668645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NF6xLX007992;
 Wed, 23 Aug 2023 10:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692803219;
 bh=FyYPYRUt6IMcRs/rhSx5PoIU+rcs9DqpgmsSC0CA+5c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ysGUfJjucalSbqaQqnnuA1K1SW3Z3GjQKXdJ+i3MmhJrpkVzDGyM8Rz+W+gWJCthJ
 a9+otOJyFEentGPbZlpDc6rJ/H64XEPARf/nb8vMxYe3K+MWP/mz++C1bTtlUv15Fv
 8S8P4FB8L45IZlCspWUMB0tb2zSCcmr9OjvUJx8A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NF6xgY028267
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 10:06:59 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 10:06:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 10:06:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NF6w6V025378;
 Wed, 23 Aug 2023 10:06:58 -0500
Date: Wed, 23 Aug 2023 10:06:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>, Praneeth
 <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
Message-ID: <20230823150658.tjfr7svhuhmbx5wt@vertical>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
 <20230823144253.GF3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230823144253.GF3953269@bill-the-cat>
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

On 10:42-20230823, Tom Rini wrote:
[...]

> > diff --git a/include/env_default.h b/include/env_default.h
> > index b16c22d5a28c..714dfa9e845e 100644
> > --- a/include/env_default.h
> > +++ b/include/env_default.h
> > @@ -112,12 +112,12 @@ const char default_environment[] = {
> >  #ifdef CONFIG_MTDPARTS_DEFAULT
> >  	"mtdparts="	CONFIG_MTDPARTS_DEFAULT		"\0"
> >  #endif
> > +#ifdef	CFG_EXTRA_ENV_SETTINGS
> > +	CFG_EXTRA_ENV_SETTINGS
> > +#endif
> >  #ifdef CONFIG_EXTRA_ENV_TEXT
> >  	/* This is created in the Makefile */
> >  	CONFIG_EXTRA_ENV_TEXT
> > -#endif
> > -#ifdef	CFG_EXTRA_ENV_SETTINGS
> > -	CFG_EXTRA_ENV_SETTINGS
> >  #endif
> >  	"\0"
> >  #else /* CONFIG_USE_DEFAULT_ENV_FILE */
> 
> The problem is that I believe we intend for CFG_EXTRA_ENV_SETTINGS to be
> where we can override things in a more final manner.

I am confused - if the intent is to move to text env, it should have
priority over the extra_env settings.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
