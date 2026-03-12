Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C98FED2F8
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EAD383F14;
	Thu, 12 Mar 2026 10:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="OnOAmN93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A9B884051; Thu, 12 Mar 2026 10:48:12 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADA783F00
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8698B214D9;
 Thu, 12 Mar 2026 10:48:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1773308888;
 bh=34ebIKuxS1TlDX/SbjIwilKgPFBEQ+aPfytwqwY2Vx8=; h=From:To:Subject;
 b=OnOAmN93Rg4CHt0vIOHO7RWN9742jGVvQhAl9Mg1sESJL1hyjhFMtq8kvvqthxb9I
 7eWvy1ODFsUf7DTETFduM82G5KM4WHbd0M4I47M1nwmzmFjbFHwvqpyEDMGusYPvt+
 1U1jA7OtmzMh/5M+Dfs1xXwD4t0P9CorIaWwuUKJaO1aHKdy1bv7VzV+EFaInQNvmL
 51JPAXOH1QNSeYVmAJ6ttlyzvCKknK/R1GtXswp2tHw0qqexZL2Vr/T8qfu89IgI1E
 5TKkYLs5+i1X9uQL8HiuXsJi8Fg6KQbykqYP6RwZ0mT8k3ieH8ou394HZkQAemm+mr
 GaUKwVZ9p37iw==
Date: Thu, 12 Mar 2026 10:48:04 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] doc: board: fix OPTEE args for TI SoCs
Message-ID: <20260312094804.GA29066@francesco-nb>
References: <20260312-optee_args_fix-v1-1-55972621c005@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-optee_args_fix-v1-1-55972621c005@ti.com>
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

On Thu, Mar 12, 2026 at 03:02:49PM +0530, Anshul Dalal wrote:
> CFG_WITH_SOFTWARE_PRNG=y was added as an OPTEE argument to workaround
> some bugs related to TRNG which have been fixed now[1]. Therefore this
> patch drops the redundant argument from the documentation.
> 
> [1]: https://github.com/OP-TEE/optee_os/commit/e313f4765fd0478bb66985827441411793433773
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62

