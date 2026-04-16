Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5353AF8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF068407E;
	Thu, 16 Apr 2026 11:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="BQxXSpOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300A6840AB; Thu, 16 Apr 2026 11:04:04 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504BE83FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 44FC91F8CC;
 Thu, 16 Apr 2026 11:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1776330240;
 bh=iX5xjLx5QqHavUsSFLc33Tq+J6IlT7b+IRO894SiA78=; h=From:To:Subject;
 b=BQxXSpOOgVgKaGO2TSLBd9IYhWVf3CZF6FZeEpt5zVj2jTIX2oPPlwoEOPyJ3T8GG
 cxZpJpFpTvrPxRfehfRCzXsqoMENvRjEZ1/JlYxaZbkzHL1vi7qGUoZvYVJh7juXNY
 Pu+BU6lxPCB2/PF+55nVai9wbdCNzOYqD+E5x6V60g4s7nclWF1+TJefoasZlFcUJ3
 JtAhcQbcN4R9M3w15l9Aov++hIMJhQH7ALto4xgxYsQuyqtzAry4xHZFhump2Chc9u
 fR7fnpop/ai4Kp3vRJdXYX3NrDHflsFgdNzTAQ06WwR3f0oU235rLcWHu1RDimsC1K
 XgIjwmHflEyTg==
Date: Thu, 16 Apr 2026 11:03:56 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/3] add Toradex Verdin iMX95 support
Message-ID: <20260416090356.GA33737@francesco-nb>
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
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

On Thu, Apr 16, 2026 at 10:45:22AM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> This series adds initial U-Boot support for the Toradex Verdin iMX95.
> 
> It also introduces a new RAM-size probing helper based on alias checks.
> On Verdin iMX95, the first DDR region is reserved for Cortex-M7 firmware and
> the get_ram_size() could not be used to detect the actual RAM size.
> Using explicit probe/alias pairs provides reliable size detection for the
> supported memory variants.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

