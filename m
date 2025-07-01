Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E046C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 14:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DBC83043;
	Tue,  1 Jul 2025 16:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="hgE5WqJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF7E83071; Tue,  1 Jul 2025 16:18:14 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BF183018
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 64E6422AF7;
 Tue,  1 Jul 2025 16:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1751379490;
 bh=sgaQSqhnrEracTPJTGneKpDF9MZSfmhAZdCb/IGml3U=; h=From:To:Subject;
 b=hgE5WqJqG2SSJKa3PgK0V7mCgjiGytqNFVIG7cgB1jQdSVNB1Xnz2NDrZNIGdLXWQ
 dbHIBSl3xvlhmbS7zJnCsffJcw87UufaU3HteICC7KLuYVMi6Kj7KkpPOtbXgHEIqs
 Cr0HikPALS+A1KbqukVUSu3/EbE3zsiZRNfmx7F7TZbeHpD2lcZ19kM+wAmIRrr4Be
 guuEmx0gkg4p2mlxkXL54jhrcJVR5C3CjAhrwvNTYiclSBRuPM7G25rtcxcDXgXZs1
 VgaiO8rUIlgKoOKRsL3uVYAYQxxgmkLFQe8sJfFFgcQjEWewTSw4UHJdRonRQwYB9l
 YWGiDuyy3nWPQ==
Date: Tue, 1 Jul 2025 16:18:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/5] configs: toradex-smarc-imx8mp: enable RNG support
 for KASLR
Message-ID: <20250701141809.GC164914@francesco-nb>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
 <20250701134504.1076115-4-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701134504.1076115-4-ghidoliemanuele@gmail.com>
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

On Tue, Jul 01, 2025 at 03:44:58PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

