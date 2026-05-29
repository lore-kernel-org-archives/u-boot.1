Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6971CD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26ADF84671;
	Fri, 29 May 2026 17:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="BTOEaAbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B085846A3; Fri, 29 May 2026 17:05:51 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3884A844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [78.241.93.90])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id B6B3778050F;
 Fri, 29 May 2026 17:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1780067148;
 bh=Rf2CMVXLi7/XSV5xP/2Gudav7IpLcrR0wcFjqvcBfWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BTOEaAbTt3t2AE6MKCSwNElvyQBgg7Ed/39KlZ6LcXYOCFB4IKQZBpR8LR2VSTRym
 2BLqogZcGlcebT+D27HqPfewYFu/ZzEltCXmixgeG14c2fj2Gmp1Q502hy3tAy66ri
 xF+tHQdcJtP9VqHcYlb0Vm4E3MCp42eCUGPGpMOwYn1JlAtK1Plh0Irq6OE63cpi5B
 Krb9nYedBHMaj5AGcEu5OL3E7Y4K0wZ2DUh2B2mGfhm81iGcZnTtxqQpGYgiUujSLf
 0WBeESJJuq3OCqSg5YHotjqVL8NKkPyEgC5OeKClsRgFqZ/pScY197f7K4sUOKBQdQ
 F+Wg2DajRJB/g==
Date: Fri, 29 May 2026 17:05:44 +0200
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>
Subject: Re: [PATCH v3 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
Message-ID: <ahmrSI5Hf7r1moV-@L30177.local>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778247592.git.vjardin@free.fr>
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

Hi Tom, Stefan,

It is a gentle ping on this v3 NBX10G serie. All 5 have Reviewed-by: from Stefan.

However the Marvell custodian tree (u-boot-marvell.git) hasn't moved since
October 2025, and I see no recent (git pull) from Stefan in the archive.
Could you apply the series directly to denx/master with Stefan's R-b ?

Or, Stefan, if you'd prefer to handle this through your tree, let me know
what timing works for you. What else would you need from me for this serie ?

Thanks,
  Vincent

PS:
https://lists.denx.de/pipermail/u-boot/2026-May/thread.html#617785
https://patchwork.ozlabs.org/project/uboot/list/?series=503396
