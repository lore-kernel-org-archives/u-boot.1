Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7E3C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 12:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B118070C;
	Mon, 21 Apr 2025 14:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JYpjUfVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 826AC807AE; Mon, 21 Apr 2025 14:22:50 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F8F5805D7
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 14:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53LCMgHC1619738
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Apr 2025 07:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745238162;
 bh=wsEtO+X81tF97tF7zaMo77VizIwELSmXGKXU7Xa51uU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JYpjUfVKvrJD7VQ3ddURzf4cfF4hS04wFmyLuOk7vX20dSatsAjuRjdm5W8PBgeqf
 fqvFqJy/8d576Rw3kagVQ0d9ctHUgLsMR5synU5fVMMqwtHM36RUKVPEw/C4qFzy+4
 oRA44mCq+asnLtWVwM2NHz5Pu4aEu6dr73ZbVz6Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53LCMg7B034431
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Apr 2025 07:22:42 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Apr 2025 07:22:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Apr 2025 07:22:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53LCMf5X044310;
 Mon, 21 Apr 2025 07:22:41 -0500
Date: Mon, 21 Apr 2025 07:22:41 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Beleswar Padhi <b-padhi@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH V2 3/9] beagle: beagley-ai: env: Set up the boot devices
 and boot methods
Message-ID: <20250421122241.mxydfegioouyt52y@power>
References: <20250418193943.953952-1-nm@ti.com>
 <20250418193943.953952-4-nm@ti.com>
 <cdf10124-cb4f-4953-b7f9-b39b91927a77@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cdf10124-cb4f-4953-b7f9-b39b91927a77@ti.com>
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

On 18:40-20250419, Kumar, Udit wrote:
> 
> On 4/19/2025 1:09 AM, Nishanth Menon wrote:
> > We just have a single MMC on BeagleY-AI. So drop all other boot options,
> > 
> > In the meanwhile, we also will use efiboot and standard boot methods
> > consistent with other K3 Beagle products.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Changes Since v1:
> > - None
> > 
> > V1: https://lore.kernel.org/r/20250411225717.3117370-4-nm@ti.com
> > 
> >   board/beagle/beagley-ai/beagley-ai.env | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
> > index 10d62034e1af..db29d13420aa 100644
> > --- a/board/beagle/beagley-ai/beagley-ai.env
> > +++ b/board/beagle/beagley-ai/beagley-ai.env
> > @@ -11,7 +11,8 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> >   	${mtdparts}
> >   run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> > -boot_targets=mmc1 mmc0 pxe dhcp
> > +boot_targets=mmc1
> > +bootmeths=script extlinux efi pxe
> 
> I am not too sure, if pxe boot is supported on this platform,
> 
> Please check once.

What we support is PXE boot at U-boot level. All we need is Ethernet,
which is enabled.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
