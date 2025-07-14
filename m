Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C290C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26F682AC4;
	Mon, 14 Jul 2025 14:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Kmi2n8ag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF45382B07; Mon, 14 Jul 2025 14:02:37 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8201805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56EC2SbX2017886;
 Mon, 14 Jul 2025 07:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752494548;
 bh=scKrct3zhnijq+2L3NpN3LyvGasMSxDA1T6h+4gNQzc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Kmi2n8agEgJDmWt/FmSZtpO2lhWxgKJQ40g+Lz17EV3yCHLb/9A4XGWLwW3zIGre2
 J2TB5hcj5L0sFtNnLhlQk0hllNLaPL3TDlPxz+sL5vMDWwGk7WJDPhg3056fywf7bt
 xKcrFmv31Qv/gTGYsZIcdYgRS4jSVcZ37cSw7XVk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56EC2Srs1712018
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 14 Jul 2025 07:02:28 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 07:02:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 07:02:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56EC2Sld829235;
 Mon, 14 Jul 2025 07:02:28 -0500
Date: Mon, 14 Jul 2025 07:02:28 -0500
From: Bryan Brattlof <bb@ti.com>
To: Yannic Moog <y.moog@phytec.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
Message-ID: <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
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

On July 14, 2025 thus sayeth Yannic Moog:
> To make it work with python 3.5 and 3.6, need type hints from the
> typing module.
> 
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Fixes: 21bc3433a43d ("binman: rework dropping absent entries from packaged image")
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Changes in v2:
> - drop newline changes
> - Link to v1: https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de
> ---
>  tools/binman/etype/cbfs.py    | 3 ++-
>  tools/binman/etype/mkimage.py | 3 ++-
>  tools/binman/etype/section.py | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
> index 5879f377231bf94697bea97c3cfc3a2515665b8f..c5e77f3a0df22ff768aa7254e4dd9ecbe6f81684 100644
> --- a/tools/binman/etype/cbfs.py
> +++ b/tools/binman/etype/cbfs.py
> @@ -6,6 +6,7 @@
>  #
>  
>  from collections import OrderedDict
> +from typing import Dict

It's been a while from my Python days so I'm still trying to understand 
what's going on, but my understanding is the 'typing' module is 
considered deprecated after Python 3.9 with PEP 589[0]

It seems like we're asked to use:

    from __future__ import annotations

~Bryan

[0] https://peps.python.org/pep-0585/

