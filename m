Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBB0E7AD77
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 16:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762FA86E4F;
	Tue,  3 Oct 2023 18:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="CRDIdGY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB87D80374; Tue,  3 Oct 2023 17:37:57 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E5686E2C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 17:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=99udZEOtPTNogoqWkNfxXd4A7AlIJlmmrEUmgwdSzpk=; b=CRDIdGY0+UJrr2WYXqOnczPCfI
 GzpUslHPpPWseDxkozm83ssrZt+VJZd93MSWQPiIBHJKTP3rn+3w4yAO/zBrlF8cxY1Jxjm0sPq38
 zYjP8KprBhqc+gJAZhVqFTgrWrY2LRueh3cZpWlo/wgupptkDyEU+P6st/p2fyMaVXB+DYmE66AGd
 2bO+jFJyuyWikG8j5gfhN78J0hNGDBJ24qMdvtaD+LGJcNQs/ZdpMcI6kwp6HF15wwelvJi59+TYv
 Tf2pGlfFfli1Oh1dypC9iesW3y+2r8NnLiXiPbWXOBKmqcEerrO5rwrrbXu5c2bOhRbjpBevAR5S1
 xcDvzmHg==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qnhT4-005oh9-E5; Tue, 03 Oct 2023 16:37:51 +0100
References: <20231001141858.164019-1-tom@tom-fitzhenry.me.uk>
User-agent: mu4e 1.10.7; emacs 29.1
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Eugen
 Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] board: rockchip: add Pine64 QuartzPro64 RK3588 board
Date: Wed, 04 Oct 2023 02:34:51 +1100
In-reply-to: <20231001141858.164019-1-tom@tom-fitzhenry.me.uk>
Message-ID: <87o7hfaf9j.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-BlackCat-Spam-Score: 0
X-Mailman-Approved-At: Tue, 03 Oct 2023 18:49:23 +0200
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


Tom Fitzhenry <tom@tom-fitzhenry.me.uk> writes:

> QuartzPro64 is a Rockchip RK3588 based SBC by Pine64.
>
> UART and booting over SD card are tested to work.

I've found a few issues with this patch, incl. confusion over the
relationship between rk3588-quartzpro64.dts and
rk3588-quartzpro64-u-boot.dtsi .

I will rework this patch as a v2, and include eMMC support too.
