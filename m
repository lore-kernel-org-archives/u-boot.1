Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C7AC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 19:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F3882AA8;
	Fri, 18 Apr 2025 21:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NmHOH5rY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12982831D4; Fri, 18 Apr 2025 21:06:15 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC5482A81
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 21:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJ68cw354629
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Apr 2025 14:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745003168;
 bh=C1N8pDx9Nfn3L+diTA0IkpXribN8yOhJ8qFCyMLaAaM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=NmHOH5rYoMG7Ecl3wIPl+QMr05n1I9ijNmVvO0JiYPi2ipVF3+4JV08+A5k3Y7IG5
 F04aNph/90pgyfvYqRyrk3V7pYz2hLYUw6xhbGkTjADUj4tT4/r++jwYBfdCzj0hRg
 95XogtKFC9W3GfnIQDZ8FKXLwhmYGleTrsFdsRPo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJ67SA114539
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Apr 2025 14:06:07 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 14:06:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 14:06:07 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IJ67Pm128114;
 Fri, 18 Apr 2025 14:06:07 -0500
Date: Fri, 18 Apr 2025 14:06:07 -0500
From: Nishanth Menon <nm@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 8/9] configs: am67a_beagley_ai_a53: Enable additional
 features
Message-ID: <20250418190607.nw22dzjvirkv6p42@comma>
References: <20250411225717.3117370-1-nm@ti.com>
 <20250411225717.3117370-9-nm@ti.com>
 <86o6wul7be.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86o6wul7be.fsf@udb0321960.dhcp.ti.com>
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

On 18:03-20250417, Jon Humphreys wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Enable basic efi capsule features, switch over to stdboot, enable
> > GPIO, LED and PMIC used on this platform. And enable UHS mode support
> > for SD cards in U-Boot.
> >
> 
> Nishanth, I would update the description to be "Enable basic efi debug
> features, ..." since you are not enabling capsule update.

Thanks Jon. will fix in the next iteration
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
