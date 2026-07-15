Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD90CC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84BA84C11;
	Wed, 15 Jul 2026 19:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="JfzhEbHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E3A84C33; Wed, 15 Jul 2026 19:09:27 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BD784BD7
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id D73E5780372;
 Wed, 15 Jul 2026 19:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784135364;
 bh=XQxTGbPJ6BvdziFKaLQPxlUS3u/48tARB7sXRzslGbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JfzhEbHGAAqgBZdg3hzt1mS+At4F94HlNccN8DaB0wlUlolKcH3ouUXBoR2sbbI1Q
 GKOnEyZVmoP5QD6F2FWyURd2Hs4vscJ4wemRvnFu/N5x9hZv1JSfZlxwN0O+DwPpDs
 sAs9XvXSiH6C3ZB98H7SrutezRiBxGohONMHLY9TOQRD0qMf3BdCzlmffIisiTrBpB
 vnoC1DLECBPpxlNdpN2QIg+wjWquhb7CO0YcmZfb5NeBmhu81zNmL4lttixMTcDFAC
 7b5KiR1pf+P+Nqlo+fhFjOHeO0thkX+JUcvpQeBmXhNraP/BkcF/ao+AOPC5oqT5XD
 gxy/S61UDBixA==
Date: Wed, 15 Jul 2026 19:09:18 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v4 3/3] test: py: load: check null_dev_desc_ok dispatch
Message-ID: <ale-vlEwBRNgIWcD@L30177.local>
References: <20260601131311.1163914-1-vjardin@free.fr>
 <20260702144359.1583239-1-vjardin@free.fr>
 <20260702144359.1583239-4-vjardin@free.fr>
 <20260715005625.GA4103122@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715005625.GA4103122@bill-the-cat>
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

Hi Tom,

> OK, but this fails CI with:
> https://git.u-boot-project.org/u-boot/u-boot/-/jobs/40773

It should be fixed now with the v5. By the way, how can I run/check
my series on u-boot's gitlab runners before sending them ?

I did miss it with my local runs !

Best regards,
  Vincent
