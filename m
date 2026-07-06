Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14DC44500
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 10:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAE4846F8;
	Mon,  6 Jul 2026 12:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Rjpex3s5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 561A0848D2; Mon,  6 Jul 2026 12:32:48 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEAB84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 12:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 90051780509;
 Mon,  6 Jul 2026 12:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783333966;
 bh=n8iN5i4YYcyyauOBay91WbZuSh8V6p7CdnLALR9CLlw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rjpex3s5Vwi45LKMGMmBSlS7oCeImRXEB+0O9xRSZMeXzqsajiiGTT3lVtVWi5Ruk
 qb2megoy2luaCSe4SLTT7Ry4iQETpC6hOGg6sb+8UgppFTS8EEj4rFvURxxq3ADfML
 /IrEdPjai5IujQEPMRr6lgEO0JJnbXfoUQufuWNC1q0b6OqNH9cevRl6KANhNUv2ZL
 jw85VOtlZDuayTPUtTJehjwqAW0zHx7RfpzcL80cgJvr/T6PV2IOaAtbP3Bw1lOMJA
 PFaoemXPGNYm+bxzhfgmIuSMLdS3lxbA3QTda5QRyC1+M/e1ncqO+tD7uuId8mVQg8
 o6Q38itYXgenA==
Date: Mon, 6 Jul 2026 12:32:41 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 4/7] board: nxp: vid: introduce PMBus framework support
Message-ID: <akuESYGKywIhArm9@L30177.local>
References: <20260702195619.1857591-1-vjardin@free.fr>
 <20260702201542.1861631-1-vjardin@free.fr>
 <aksj2G-G0onkMunB@nxa18884-linux-1.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aksj2G-G0onkMunB@nxa18884-linux-1.ap.freescale.net>
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

> When vid_read_vout_mode() returns 0, the return value here seems
> not correct.

thanks ! , fixed for the v3
