Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C195CC83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 07:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BACD83287;
	Fri, 18 Jul 2025 09:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="VwvND9a+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E2883564; Fri, 18 Jul 2025 09:25:47 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76FC82C87
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 09:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A0E671FBDC;
 Fri, 18 Jul 2025 09:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1752823544;
 bh=aO++6uYW6035RfjinPv++EwS8K53/SkzVnKMq9wY+uc=; h=From:To:Subject;
 b=VwvND9a+8Mmg1WAWvwIrfwPIJo9Ly2UPuRXhK40xWSRn9+tum/HeHXspp+yHM+Fdg
 cK+80IZGNCmTk5HhxpPEzpekEOCLND3RXxH59ehC0PKlYZZaFISsKOpenpU5r8Lim5
 0YCMMrxHZ2KqmL0XpaPQ6s3R0LurbXgo48yfg9LKndHQQQzsrX0ZADBjBrOxTfA/dG
 S9dI7nSWbYrjansff3gAWIuil515EoQ14ZPFJoMe2wG2eZeuZu4fWuawFPT2aF1KuY
 s+bIwkSVh16dq4A0Csmsz60i/WZmSwOM1BvqUBIKW7GfU23paOER15wDhyIY1gPnH3
 NTWtat22aqpYg==
Date: Fri, 18 Jul 2025 09:25:41 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: add verdin i.mx8m mini 0216
 pid4
Message-ID: <20250718072541.GA26717@francesco-nb>
References: <20250717110210.443381-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717110210.443381-1-ivitro@gmail.com>
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

On Thu, Jul 17, 2025 at 12:02:08PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add PID4 0216 Verdin iMX8M Mini Quad 2GB WB IT to config block handling.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

