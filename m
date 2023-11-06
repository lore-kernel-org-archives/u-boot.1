Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4671C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598C286689;
	Mon,  6 Nov 2023 13:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gUbY7h7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709E486489; Mon,  6 Nov 2023 13:19:16 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47735868AE
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6CJ4Rv106392;
 Mon, 6 Nov 2023 06:19:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699273144;
 bh=IInqNSQ/pfjSeS3WO8Dm/j0yfax8zTJIcjmZSYP0CHY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gUbY7h7QpAtGbH6sfk/wXeSa9xxXGwFBmCQzXI1/NKy7cT0DiK3M/+E9yS/o0XoLb
 r43eMYKKsZ/vYAfwWdYOl5yc2/ddYXLJi0vZMMi8ANTkR7SavnzX/zZ1RO4JOpSVpw
 W2uLhgPiV3i7yM1MJLaxwuYlHzWJKIuNau17rlPA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6CJ3PG059984
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 06:19:03 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 06:19:03 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 06:19:03 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6CJ36l084121;
 Mon, 6 Nov 2023 06:19:03 -0600
Date: Mon, 6 Nov 2023 06:19:03 -0600
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Robert Nelson
 <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 03/15] board: ti: j721e: evm: Drop board check for ESM
Message-ID: <20231106121903.aaypmbvfbdb2642u@pupil>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-4-nm@ti.com>
 <251aa1ab-3244-4dac-a14a-7738a8096ea5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <251aa1ab-3244-4dac-a14a-7738a8096ea5@ti.com>
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

On 16:03-20231104, Kumar, Udit wrote:
> 
> On 11/3/2023 6:07 AM, Nishanth Menon wrote:
> > When config is enabled, the esm dt probe makes sense. Simplify by
> > dropping board specific checks.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >   board/ti/j721e/evm.c | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> > index d4f7c1d9f938..75d51a0552c4 100644
> > --- a/board/ti/j721e/evm.c
> > +++ b/board/ti/j721e/evm.c
> > @@ -531,10 +531,8 @@ err_free_gpio:
> >   void spl_board_init(void)
> >   {
> > -#if defined(CONFIG_ESM_K3) || defined(CONFIG_ESM_PMIC)
> >   	struct udevice *dev;
> >   	int ret;
> > -#endif
> >   	if ((IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM) ||
> >   	     IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM)) &&
> > @@ -543,24 +541,20 @@ void spl_board_init(void)
> >   			probe_daughtercards();
> >   	}
> > -#ifdef CONFIG_ESM_K3
> > -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> > +	if (IS_ENABLED(CONFIG_ESM_K3)) {
> >   		ret = uclass_get_device_by_driver(UCLASS_MISC,
> >   						  DM_DRIVER_GET(k3_esm), &dev);
> >   		if (ret)
> >   			printf("ESM init failed: %d\n", ret);
> >   	}
> 
> Nothing related to this patch, but to get esm completely functional
> 
> Second k3_esm probing needs to be added in this file.
> 
> 
> Also, DT changes are needed, in next sync
> 
> https://lore.kernel.org/all/20231013102941.548209-1-n-francis@ti.com/
> 
> 

Understood. no action on the current series, I assume.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
