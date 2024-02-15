Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E78C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 08:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1195087D7F;
	Thu, 15 Feb 2024 09:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="UuRMh6Sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310B087D7F; Thu, 15 Feb 2024 09:07:03 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB19879BB
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 09:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 107281F927;
 Thu, 15 Feb 2024 09:06:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1707984417;
 bh=1z9DqBOmzW5YIs7ik+C5oaKA7B50Wu700C/uc1ISR8M=; h=From:To:Subject;
 b=UuRMh6SjuYLCvAeuHGdlPcTklgB7gCR1hlOgWiAbpIaG6h0nHk/GWslNpqbvTwDna
 qKm9dGn1JJYLD21qBZSeGE9Zc/UvgWlpiRm8TEQjs/+UqYlJJai4gUNc4Funnt1un9
 gS2mD/Jw1T6jXac1YX5oHoLBN8e+UBYB3IsNYKW2gO2WdLhK/qHedLGrYvLITSl42s
 Tiv5gtiCH24MmGmVAlUTGJPo3o3qHph7ot8PPijznza1shJIQvCCsd8KqYuNBLNs1A
 iGIaxbc9xF2m2CEjGBl5RxtZ/Jk/2jxZgJGXN74v02H6F7auS7qGLOW1vSN3v94WAI
 g01kcANURsLTg==
Date: Thu, 15 Feb 2024 09:06:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] arm: mach-k3: Move DRAM address of ATF for AM62/AM62a
Message-ID: <20240215080653.GA5107@francesco-nb>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-7-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-7-afd@ti.com>
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

Hello Andrew,
thanks for this series.

On Wed, Feb 14, 2024 at 10:30:09AM -0600, Andrew Davis wrote:
> The current address of TF-A in DRAM is just below the 512MB address line.
> This means if the DRAM in a system is 512MB then TF-A is right at the
> end of memory which is often reused, for instance U-Boot relocates itself
> here. If a system has less than 512MB then that system wouldn't work at
> all as TF-A would fail to load.

Do you expect issue with system with exactly 512MB of RAM? We have such
a board available and this is something that was not on our radar.

The way we handle this is with `verdin-am62.c:board_get_usable_ram_top()`

There is also some other reserved memory just before the 512MB limit,
not just the TF-A.

Francesco

