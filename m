Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839A51076365
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 05:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE0084010;
	Wed,  1 Apr 2026 07:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="iqUEEyGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9E684056; Wed,  1 Apr 2026 07:10:36 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B2A83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 07:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (unknown [185.12.129.176])
 by mail11.truemail.it (Postfix) with ESMTPA id 19E501F940;
 Wed,  1 Apr 2026 07:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1775020232;
 bh=Fq3hOfsVgL9zJxyRb0BXQlrYbcpjwsrY2aTLuD+ZtkY=; h=From:To:Subject;
 b=iqUEEyGe2KrpezKB269r7mt6eLpzzzbFWd9vNRpnASFJA/V343Foyokm85RYiFcGG
 lJnoL+j4AG7TSddAD4OtNLJIJheMgqCAWUNEUmdWmrYkrIDWD7kqiYuIK3d22tPbIL
 j9k+RjGOTfC/HjUKNXeMvvdisMPG5kbntndSMQTGz9JLF7VW1IVdDm5dwH7neVDsXE
 FLBungaSOHTo78tuquq3I0LaCUxqY+JZuinlN5PCaV86qnLdA2uld+adBD9bc8SxHR
 P7hj8RSEqNLFtf6+10LcR8alw36NSrYrnp9J6NpIUbXT+eE+82gPAQa8JzQOAkNeeI
 DtywADf228wJA==
Date: Wed, 1 Apr 2026 07:10:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
Message-ID: <20260401051027.GA4471@francesco-nb>
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
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

On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> With correct POSIX handling, unquoted empty variables can turn the
> expression like
> 	test -n ${fdtfile}
> into
> 	test -n
> 
> The POSIX handling for single argument `test` evaluates it as true,
> so the fallback initialization will be skipped unexpectedly.
> Quoting variable expansions in `test` expressions will always result in
> correct behavior for empty and non-empty values.
> This change was triggered by
> commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
> The aim is to have a less fragile codebase that is not dependent on a
> quirk of the shell implementation.
> 
> Use quoted variable expansions in `test` expressions throughout.
> 
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

