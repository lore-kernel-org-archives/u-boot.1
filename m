Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E2AE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D2C8021A;
	Thu, 19 Dec 2024 16:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KmfKVa/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0DA8022B; Thu, 19 Dec 2024 16:59:33 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0470B80077
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0604D1F95E;
 Thu, 19 Dec 2024 16:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1734623970;
 bh=YrY3ver7q6pnNum8h/eExcqEufACMk/gpAPuP8kzAjk=; h=From:To:Subject;
 b=KmfKVa/fYrKUwyDTta3YUXKIrT/buFlH4ySOWLX6uF0CLx6muK/3/YUEQ74H10MlH
 CI+cdkufPdEjpxIczBqut4C3poZbzHo/+emNF8UgyZznWUB8q1vQTOThX63F1tFXl8
 Xtse2WTw+Sq1uhRk/B8vxHQmImP+yJf8FoBWPksvu51RWzc7LrjvGDA5um4tJ5/2+/
 dSvk4aHGQw/jDF8hVje328ztDjEG0suETKg+4Vgt6WeJqRQJJ4AQ8mYRs5Rc8W5yLZ
 eImfunW0iHNBCu7I+E4DnmEgtKq471IWu7O96ulqSiE0ywKmxHeZ3/ed1SwbTooaYi
 2zadOU/MpMNGg==
Date: Thu, 19 Dec 2024 16:59:26 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Message-ID: <20241219155926.GA32906@francesco-nb>
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
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

On Wed, Dec 18, 2024 at 11:00:06AM +0200, Ilias Apalodimas wrote:
> commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary")
> tried to adjust the usable memory limits on a 4GB boundary.
> 
> ram_top is described as 'top address of RAM used by U-Boot' and we want
> to preserve that. This is defined as a phys_addr_t and unfortunately
> its size differs across architectures. This has lead us to a weird
> state where 32bit boards define it 'SZ_4GB - 1' and 64bit boards as
> 'SZ_4GB' unless it was otherwise defined.
> 
> With some recent LMB changes and specifically
> commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> the board fails to boot properly although the commit above is correct
> since it's making sure that no memory above ram_top is usable -- but
> added to our memory map so EFI can hand it over to the booted OS.
> 
> The reason for that is that during the LMB init we add all usable memory
> in lmb_add_memory(). In that function any memory above ram_top gets added
> as 'reserved' for LMB. With the current values tha's set to 0xFFFF_FFFF
> for this board. Later LMB is trying to protect the memory area U-Boot lives
> in with lmb_reserve_common(). The latter fails though since it tries to
> add U-Boot top (which is 0xFFFF_FFFF as well) to U-Boot 'bottom'. This call
> will fail since 1 byte of that memory range is already marked as 'reserved'.
> 
> Since we are close to the release, LMB seems to assume that the address
> is rounded up and is the 'next address' and so does parsing and adding
> memory ranges from DT files, bump the ram_top of the board by 1byte.
> 
> In the long run we should change all of the above and have 32b and 64b
> platforms define ram_top identically.
> 
> Add a Fixes tag although the commit is correct, so people can figure out
> the broken scenarios in the future.
> 
> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Fixes: commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reported-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
Closes: https://lore.kernel.org/all/20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com/

Thanks,
Francesco

