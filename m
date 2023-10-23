Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F8EC25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 19:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA6686FD1;
	Mon, 23 Oct 2023 21:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF1886FDC; Mon, 23 Oct 2023 21:10:49 +0200 (CEST)
Received: from mx1.tinet.cat (mx1.dipta.cat [195.76.233.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F56186F97
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 21:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1698088244-12aaf2620319d30001-4l7tJC
Received: from smtp01.tinet.cat (smtp01.tinet.cat [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id Qv1n4VkAei5kLpCJ;
 Mon, 23 Oct 2023 21:10:44 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp01.tinet.cat[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (191.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.191])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 56FED605DE48;
 Mon, 23 Oct 2023 21:10:44 +0200 (CEST)
Date: Mon, 23 Oct 2023 21:10:33 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
Message-ID: <ZTbFKfUbEwLpPDnE@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
X-Barracuda-Connect: smtp01.tinet.cat[195.77.216.131]
X-Barracuda-Start-Time: 1698088244
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 954
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5054 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.115780
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
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

El Sun, Oct 22, 2023 at 07:47:07PM +0200, Heinrich Schuchardt deia:
> diff --git a/drivers/sound/tegra_ahub.c b/drivers/sound/tegra_ahub.c
> index 495a29c513..28f392504d 100644
> --- a/drivers/sound/tegra_ahub.c
> +++ b/drivers/sound/tegra_ahub.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+159
> +// SPDX-License-Identifier: GPL-2.0-or-later159
>  /*
>   * Take from dc tegra_ahub.c
>   *

What does this 159 mean (or meant) ?

> diff --git a/lib/errno_str.c b/lib/errno_str.c
> index 2e5f4a887d..9bae8ecb11 100644
> --- a/lib/errno_str.c
> +++ b/lib/errno_str.c
> @@ -1,8 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 2014 Samsung Electronics
>   * Przemyslaw Marczak <p.marczak@samsung.com>
> - *
> - * SDPX-License-Identifier:	GPL-2.0+
>   */
>  #include <common.h>
>  #include <errno.h>

Should be replaced, not supressed.
the tab might be replaced by one space too.

