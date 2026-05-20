Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62792CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 15:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16C684894;
	Wed, 20 May 2026 17:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="M/vDhl3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E220A84897; Wed, 20 May 2026 17:39:53 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA34846E7
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-33-41-61.ip42.fastwebnet.it [93.33.41.61])
 by mail11.truemail.it (Postfix) with ESMTPA id EE2BA1F92A;
 Wed, 20 May 2026 17:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779291591;
 bh=6qoJAGg8APsQPW3TjVMSD5Y6lDH+bKxg2kHtm5DSiAY=; h=From:To:Subject;
 b=M/vDhl3MjH9K8LJm1LmQp9n4N/mtIMsXh5VHlJmaHA10dOlXe0iCf649IWwG0lBOo
 DvP1J2GfbWmaJDtCLtviIs6kXtGzb6KjUCwpnY8pJEpE+iSxoT0ppvgtVD0lqKIj8H
 Rb+2WLEFNXYqZad1RyRMsuv3QsLGgK4MP4lVKxnWEJ9gOZa7a/x7SL4+0GuXM/1woL
 ydM8EtKynn1ggTC+adbxeTk+9OZHlspyrsbgXs36g7qIaqPlnnHp0/CGjCOPOb/IY4
 O5gWfTCjhl1+YNxHdJ4NEk27EABAEYC9Pa5L9KMnu5vC8UjozIiazyGqC+Rf5ZgY+e
 SLKn0OKPPmbsA==
Date: Wed, 20 May 2026 17:39:49 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1] board: toradex: verdin-imx95: fix ram size check
 calculated addresses
Message-ID: <20260520153949.GB125805@francesco-nb>
References: <20260520135138.1047110-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520135138.1047110-1-ghidoliemanuele@gmail.com>
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

On Wed, May 20, 2026 at 03:51:34PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> The ram_alias_checks addresses are 32 bit values. When summed as 64 bit
> values the calculation is done correctly, otherwise, if they are summed
> as 32 bit values, the sum wraps around.
> 
> Fix by adding uintptr_t recast to the base address.
> 
> Fixes: 60d8255d8dc0 ("board: toradex: add Toradex Verdin iMX95")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
