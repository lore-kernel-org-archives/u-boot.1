Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F70D1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 18:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFDB8415D;
	Thu,  8 Jan 2026 19:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E0A8415E; Thu,  8 Jan 2026 19:52:14 +0100 (CET)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by phobos.denx.de (Postfix) with ESMTP id A1191839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=macro@orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 1684E92009C; Thu,  8 Jan 2026 19:52:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 0F1A192009B;
 Thu,  8 Jan 2026 18:52:11 +0000 (GMT)
Date: Thu, 8 Jan 2026 18:52:10 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 7/7] MAINTAINERS: Update m68k entry
In-Reply-To: <20260105165221.1816070-8-visitorckw@gmail.com>
Message-ID: <alpine.DEB.2.21.2601081848050.30566@angie.orcam.me.uk>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-8-visitorckw@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 5 Jan 2026, Kuan-Wei Chiu wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf85f642a8d..57e8fd5bd8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1045,9 +1045,10 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
>  F:	drivers/clk/
>  F:	drivers/clk/imx/
>  
> -COLDFIRE
> +M68K
>  M:	Huan Wang <alison.wang@nxp.com>
>  M:	Angelo Dureghello <angelo@kernel-space.org>
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
>  F:	arch/m68k/

 The list is sorted alphabetically, so you'd have to reorder entries on 
this occasion, preferably in a separate step from adding yourself so that 
the addition stands out rather than being buried in the move.  Or perhaps 
use "COLDFIRE, M68K" for the entry instead?

  Maciej
