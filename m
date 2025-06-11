Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFD3C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C7082BA7;
	Wed, 11 Jun 2025 14:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ad5ijnBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43CD82B97; Wed, 11 Jun 2025 14:39:04 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC1382BA7
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55BCcxKb2584751;
 Wed, 11 Jun 2025 07:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749645539;
 bh=y+0H+NY/RwgBBDsZ7i8JrwpkQZJQyPtfc+OjOIrby+E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Ad5ijnBqOkgifPwpTV9TaMqov6dQ+QGGsaJbMmWQjp3VxyaErs8yqet1JXXfICnFI
 t6uMtuwc+cqNnkCTu/CCG3lPi3VRrsX+cXqf0PKLtc2UAIcblF7hU8rTxQn81hHsyD
 nB8NMfnagft07te0CSWES63HM8uCWlaQP4t2xrDM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55BCcxRd2861290
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 07:38:59 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 07:38:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 07:38:59 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55BCcxnT500153;
 Wed, 11 Jun 2025 07:38:59 -0500
Date: Wed, 11 Jun 2025 07:38:59 -0500
From: Bryan Brattlof <bb@ti.com>
To: Yannic Moog <y.moog@phytec.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Jan Kiszka
 <jan.kiszka@siemens.com>,
 <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] binman: migrate from pkg_resources to importlib
Message-ID: <20250611123859.zcxl52fz2ugakjrg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
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

On June 10, 2025 thus sayeth Yannic Moog:
> pkg_resources is deprecated, use migration guide in [1] to migrate to
> importlib.resources.
> Keep the Python 3.6 backwards compatibility.
> This also fixes the binman version test which failed for setuptools
> versions that print the deprecation warning.
> 
> [1] https://importlib-resources.readthedocs.io/en/latest/migration.html
> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
