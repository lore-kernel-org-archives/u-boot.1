Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440CDC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 06:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F87C84A30;
	Mon, 13 Jul 2026 08:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="aXz/MiUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EF18467B; Mon, 13 Jul 2026 08:05:53 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0347C84A3A
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 51C4D1FA47;
 Mon, 13 Jul 2026 08:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1783922750;
 bh=kreaP1IJXz/zU739CU4W83krI9BKOvNpSCtxF3wCvyE=; h=From:To:Subject;
 b=aXz/MiUkdfHPCSQKxVrfrHjf3ghLng7V0Jw5OPr0DZnFf2VbFieIpn4l1YPnYASp2
 18zXJ3V0thq7U8vwXAoOJ7Mi7na/wmsKpw10xMXfqT15lq9xsExGX6HDm7YHK78c56
 jrWln6IRjMOA0J+ztM/lXodcx5/MqfnDo1nHU8Qjg5Q0uhDT0kyt1m2zUvhPubHxXH
 l2eMt3SzLzxYSd9MfLj/Zsstc03N+n7Tc2cyBMlIi3yxQnsBmCu+fEPNhsQpSjQ3JH
 pHi5Jw3YE1Oj+Yf7SMGLLw+NWumWU9OpkHJ1XCmPZXQzaw7h/df+fdI+tHucM1wrca
 CXc0EZHHBeTrw==
Date: Mon, 13 Jul 2026 08:05:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/7] toradex: tdx-cfg-block: Add new PID4 entries
Message-ID: <20260713060548.GB13102@francesco-nb>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
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

On Fri, Jul 10, 2026 at 03:32:58PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add new Toradex PID4 entries to the common config block handling.
> 
> The series adds new Aquila, SMARC, Apalis and Verdin module variants.
> For the Verdin Wi-Fi/Bluetooth variants, update the board-specific
> variant selection to use the Wi-Fi variant.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

