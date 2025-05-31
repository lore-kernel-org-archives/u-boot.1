Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E889DC5AD49
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA59F82B70;
	Sat, 31 May 2025 05:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Hn1jjpGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5DF82B72; Sat, 31 May 2025 05:11:43 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D3482B6B
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AC1852609A;
 Sat, 31 May 2025 05:11:40 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9GkOBScVrZCh; Sat, 31 May 2025 05:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748661100; bh=0R9xlIOMPo1ghrW7PMv/c7Sldf128Nrwe11Kl9rBSp8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Hn1jjpGmGY63xh0Cvch7aGuxitPSb335seQgkvgQRomhrlG9q5voU7RKn3/FPIDDA
 NiJUEjJSwfYW1xLd0n4wo/oYlshaAOmoquKSyKJC+7Lbml0heyelNm6Ocm6/sn11Tb
 nHnoxkSW092AgzmMU1ZFX1XhohTMOYsZ36DIZx6Meo4WAuLb6aC1GFgqH1HilwZ5J0
 UB+KYxEazNcjPY1EBrcB2wmPnbxZEYAmAZn0xbi/uGAOUKQOT8SlMrb42LC9Rfq/1C
 93rvQHRXmNK7U4wwqtTz3JWxzceSyJIHEMsMq2Bwe4QEN8h6NdnSb15vs8IaaUzCSk
 /U2N2rgN/Y7DA==
Date: Sat, 31 May 2025 03:11:27 +0000
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] scripts/spelling.txt: Sync script with kernel v6.15
Message-ID: <aDpzX0IEJzUEuVPk@pie.lan>
References: <20250530140548.4030025-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530140548.4030025-1-trini@konsulko.com>
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

On Fri, May 30, 2025 at 08:05:48AM -0600, Tom Rini wrote:
> Keep spelling.txt in sync with the version from kernel v6.15.
> 
> Reported-by: Yao Zi <ziyao@disroot.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> Heinrich, adding 'volatge' here makes sense, but also makes sense in the
> kernel I believe (it's wrong in 4 places as of v6.15, and at least once
> in a commit message), can you please upstream that? Thanks.
> ---
>  scripts/spelling.txt | 193 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 191 insertions(+), 2 deletions(-)

Reviewed-by: Yao Zi <ziyao@disroot.org>

Thanks for your quick patch! I do agree it's a better idea to keep it
synchronized than maintaining our own.

Best regards,
Yao Zi
