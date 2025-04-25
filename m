Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24220C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 20:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E1E82A0A;
	Fri, 25 Apr 2025 22:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qJrQNDon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B646982A25; Fri, 25 Apr 2025 22:03:31 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C858291D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 22:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PK3MaN3018021
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 15:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745611402;
 bh=2PYlAim4wa8WMvv5nImG4VZCAbhih7dawP2/G1P5EKQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qJrQNDonPaST6i/wr0Fh5MIm8A2tEOzBuTHx0wTdW4N+BJ8V032rxLx+DXwCWjUPP
 k41dFkQEnGa5Dx12ZdLaT0RgNKPpg4RiTLGjeULD2Kv5mXUkneJtB3fAQ0SKckXN1X
 B8UjqraF5FFS2pnGKU4xn25ayE3B4a/+K8fHw3J0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PK3MsF035717
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 15:03:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 15:03:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 15:03:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PK3MeU020463;
 Fri, 25 Apr 2025 15:03:22 -0500
Date: Fri, 25 Apr 2025 15:03:21 -0500
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, Andrew Davis
 <afd@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/9] board: beagle: beagley-ai: Cleanups and stdboot
Message-ID: <20250425200321.ogaswcmsckhmgfpu@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250425173120.141503-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250425173120.141503-1-nm@ti.com>
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

On April 25, 2025 thus sayeth Nishanth Menon:
> Spin 3 of the series.
> Just happened to get a BeagleY-AI at desk and happened to test master
> branch (7dd49a9264a6 drivers: scsi: Add 'erase' support), noticed a few
> issues which were rather easy to solve.. so, here we go:
> 
> Current series is based off:
> master 9d3f1ebaf875 ("tools/make_pip: Use venv when invoking pip")
> 
> BootLog: https://gist.github.com/nmenon/d5d761371515ce0e9cc77021533c34d7
>   (nothing interesting changed, so same bootlog)
> 
> Changes since v2:
> - Dropped override of dfu_alt_info.
> 
> V2: https://lore.kernel.org/all/20250418193943.953952-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20250411225717.3117370-1-nm@ti.com/
> 

Look Great!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
