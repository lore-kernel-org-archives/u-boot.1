Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5997AC5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 08:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D661808AF;
	Sun,  8 Jun 2025 10:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="XAnaTmVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCE2808AF; Sun,  8 Jun 2025 10:33:23 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16267807B1
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 10:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (adsl-178-39-61-184.adslplus.ch [178.39.61.184])
 by mail11.truemail.it (Postfix) with ESMTPA id 8236A1FEF6;
 Sun,  8 Jun 2025 10:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1749371600;
 bh=Zb412sHLScZXAlUJcqZOqM/ZT/comJqgH+rQ2/yW1Xk=; h=From:To:Subject;
 b=XAnaTmVJidb6DRceNpqwbG3zPP6Lo2R6XvGfqQsRJ1VzsVlLsJlhbBIptoHAeS/cy
 ZqXiDLtNLUOpws0LVJplaj9KNNbnoMdbyX+dUJtbfWRCNXIKxV7Casop74q6u5uEHr
 2HuUuX+dti7rRdxrLRfrL0bhhVFEbw2kyOH9aqLZWK86cYcq/bcSFrJRpDm5wgYQDO
 Sd5UgtSKkJJrG0rQCaoa/aaPJnXacre7KTb9GJ3VXgglIzJr/irUUej7zv7IJPC0m2
 gl2DPS4FOVa0FcJfcbmHuD4wfFypLg8aZENkIerPrIvtV5WYaKrglGYGLhLUv8BQoI
 1h8IyTX/gH14Q==
Date: Sun, 8 Jun 2025 10:33:15 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] verdin-am62p: include linux/sizes.h
Message-ID: <20250608083315.GA91398@francesco-nb>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608074228.12407-2-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,
thanks for the patch.

On Sun, Jun 08, 2025 at 09:42:26AM +0200, Heinrich Schuchardt wrote:
> Avoid build failures
> 
> In file included from include/config.h:3,
>                  from board/toradex/verdin-am62p/verdin-am62p.c:9:
> board/toradex/verdin-am62p/verdin-am62p.c: In function 'dram_init':
> include/configs/verdin-am62p.h:13:33: error: 'SZ_2G' undeclared (first use in this function)
>    13 | #define CFG_SYS_SDRAM_SIZE      SZ_2G /* Maximum supported size */
>       |                                 ^~~~~
> board/toradex/verdin-am62p/verdin-am62p.c:63:65: note: in expansion of macro 'CFG_SYS_SDRAM_SIZE'
>    63 |         gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
>       |                                                                 ^~~~~~~~~~~~~~~~~~
> include/configs/verdin-am62p.h:13:33: note: each undeclared identifier is reported only once for each function it appears in
> board/toradex/verdin-am62p/verdin-am62p.c:65:28: error: 'SZ_1G' undeclared (first use in this function)
>    65 |         if (gd->ram_size < SZ_1G)
>       |                            ^~~~~
> 

Why do you have a build error in verdin-am62p.c, given that linux/sizes.h
is already included there?

The change in verdin-am62p.h is obviously fine, yet I do not understand
what's going on.

I just tried building u-boot next branch, with both
verdin-am62p_a53_defconfig and verdin-am62p_r5_defconfig and I did not
have any build error, using arm/arm64 cross gcc from debian stable on
x86-64.

In any case, given the change in verdin-am62p.h is correct to me,

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

