Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4211BC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 10:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C07846F8;
	Mon,  6 Jul 2026 12:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="TID3kVe7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A94846FD; Mon,  6 Jul 2026 12:24:28 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6FB84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 12:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 19FBB780372;
 Mon,  6 Jul 2026 12:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783333465;
 bh=qTgTM3YKymjaAUqg+Ycx/CdgDFEm/es5IQ+bD+3/Tn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TID3kVe79KF8gIl7pQdQxFA0XI/O3QN4cOGuTg0oyDjou96SvO6zBVNgwoFLN9Nn0
 jfQ+s19HvIuInCHmVCTgtc8nBUAd/62VFyC2fNAhSr9jIScSNhVVhf8WMxqI2vw9my
 mtA8gKDZr2DVmZssmgN46dWn4ncQW8rP8MCxO2VzF/0oHTDer1lEOyJbsH+AWFDlB1
 4B6T1rfXQjKQJU1xpVXkmLBvcgH6qaH2L/US6pNUNERkvFk1ysyoqPevb5qVs1QMpd
 isBa0ay6TOZVWxp3JrgdFApdiWc4E1Z9ZuSjMG4qpMvKgBhaCU1WvCk3Wy8edQUukD
 Y48ASaTt6p1Vw==
Date: Mon, 6 Jul 2026 12:24:20 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 3/7] power: regulator: add MPS MPQ8785 PMBus regulator
 driver
Message-ID: <akuCVBhismyHYvqX@L30177.local>
References: <20260702195619.1857591-1-vjardin@free.fr>
 <20260702201438.1861442-1-vjardin@free.fr>
 <akskcZJXYtDjWzBR@nxa18884-linux-1.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akskcZJXYtDjWzBR@nxa18884-linux-1.ap.freescale.net>
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

Hi Peng,

Thanks for your comments, see below.

> Per reading the driver, only one MPS[X] is supported here.
> Are there cases that need multiple MPS?

No, mulitiple MPS can be used and are supported, eaching having
its own i2c/bus addresses/DT node. For instance, you'd need a
MPS for the lx2160 and another MPS for an ASIC.

What is somehow unique is the CLI concept of "active" chip:
  'pmbus dev'
selects one deviec for the following subcommands (telemetry,
status, dump, etc...).
In fact, it follows the same way than i2c dev or mmc dev that I
get inspired from.

> >Adaapted from Linux code.
> 
> Typo.

Thanks, it'll be fixed into the v3 serie.

best regards,
  Vincent
