Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B6AC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 18:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBBC8823C;
	Thu,  6 Jun 2024 20:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Aga2rFC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D308A883CE; Thu,  6 Jun 2024 20:46:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35186881A1
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 20:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 456IkPU1067874;
 Thu, 6 Jun 2024 13:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717699585;
 bh=yHgN9UMt+Gu3b+XCwpkG4Mnye9OfjdVzl3ynuVbC89g=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Aga2rFC1LdBbNrQYELVge5hdknZLj5BUyKLEdAy4vecfpFvU3SYxfp0DMBrWECgnU
 8mqrc9n36kx62gvVAtu6edSOAc+eJM8673tG8oJlSgFlPD0ZfjFZJKo1FtvuS2mw1f
 KgFtMOeH/B5cTP101LmpJvRYArWKOxxbI3ZWG7qQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 456IkPqf030889
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Jun 2024 13:46:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 13:46:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 13:46:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 456IkOBJ112496;
 Thu, 6 Jun 2024 13:46:24 -0500
Date: Thu, 6 Jun 2024 13:46:24 -0500
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] arm: dts: am625/am62a7: Switch over to OF_UPSTREAM
Message-ID: <20240606184624.s53zlrdztsiig3qv@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240605152752.1711835-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240605152752.1711835-1-nm@ti.com>
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

On June  5, 2024 thus sayeth Nishanth Menon:
> Cleanup am625 on by switching over the last two platforms (SK and
> beagleplay) over to OF_UPSTREAM, and while at it, switch over am62a7
> (last of the am62* family) over as well.
> 
> This superscedes the previous version of beagleplay only patch[1]
> 
> Test logs: https://gist.github.com/nmenon/ba310d3750a80789aca6a4fd90190135
> 
> Nishanth Menon (3):
>   arm: dts: am625_beagleplay: Switch to OF_UPSTREAM
>   arm: dts: am625_sk: Switch to OF_UPSTREAM
>   arm: dts: am62a7_sk: Switch to OF_UPSTREAM

Looks great to me

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
