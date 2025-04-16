Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2163CC369C5
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 19:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593E482E9F;
	Wed, 16 Apr 2025 21:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V0hrEWMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A30082EAA; Wed, 16 Apr 2025 21:51:20 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845EE82DE7
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 21:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GJpD302753678
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 14:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744833074;
 bh=nzDjy5fAiG4Lms6Nq0SE6NcuZ7IdRPtsTAY8WuxPd4I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=V0hrEWMnV2GjTCIDnC/ye8d8vijHo/gv22V/uH2qUN3W+qr7v5/rCL5+g5wNfsPZD
 RzRqj34sjDVQSBGYPSCBYZa8OEDKVd1LyXFVhZREzLkW7qqqwGApHMbcxqB7jufj0r
 1dFc9BRM0x4O9aRpUpTumrwmBxP0RY9lMWgJbSK4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GJpDcB095159
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 14:51:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 14:51:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 14:51:13 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GJpDfw047539;
 Wed, 16 Apr 2025 14:51:13 -0500
Date: Wed, 16 Apr 2025 14:51:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>, 
 <trini@konsulko.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
Message-ID: <20250416195113.mtfdclfvb756vpll@scoreless>
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus>
 <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
 <20250416150506.ws22odswwkjn2wth@deflected>
 <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
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

On 11:38-20250416, Andrew Davis wrote:
> > > > 	How about u-boot documentation?
> > > 
> > > I will update that in the next revision along with any feedback I
> > > receive on this patch.
> > 
> > IMHO, This change is too intrusive and impacts downstream customers
> > including inflight production devices.
> > 
> 
> Could you elaborate a little?
> 
> They do not even need to update their TF-A version, if they want to
> use their current version they simply recompile it with a single
> extra build flag:
> 
> PRELOADED_BL33_BASE=0x822000000

For folks who are trying to boot linux from TFA, they could do the same.
> 
> They should have no reason not to be able to do this. But even *if*
> they cannot do that, the whole point of the jump-stub here is to
> save them even having to do a simple compile.
> 
> IMHO "downstream customers including inflight production devices"
> should not be a reason to block good and useful changes here in
> upstream. But again, this change doesn't break anything for them in
> the first place, so why bring that up?

I dont see a specific value here. U-boot just works. For folks who want
direct TFA to kernel jump (which is a niche fast boot usecase), go ahead
and use TFA with the mentioned build option.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
