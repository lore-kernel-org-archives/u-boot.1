Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD2EEDF055
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 08:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD4E83A47;
	Thu, 12 Feb 2026 09:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="mC55RvPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2E883CBD; Thu, 12 Feb 2026 09:25:26 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1558367F
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 09:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A7F1C1F952;
 Thu, 12 Feb 2026 09:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770884723;
 bh=9lpoyoCTh4jSNoEK4894+GBrJwuoxPXWKA8aM1mrFw0=; h=From:To:Subject;
 b=mC55RvPdhDpLYbZV0rUjY3PsGPjS0iLdKetVaM2YreMrlHaMcI77/9TJoGqGOReDI
 dADwg905dNWhipo8sYOsVOOLSlS3KIDFC5uyp6t/PzrDjPtLERdkKDzVsAmF1ckVGT
 w5m+YlcjUrFITXiIKg8YzeqefYhdo5VsIpfIJsuoRb4ESGtMMBAKwed+GeTtrKD87V
 OsRr9eNlKH5jiZM748xg/FJw7ZAQvs885h2dOiKedQrM1M4/Im7sYnX1AlSQDU7rsh
 rN9DvTagnYsPXlddtm1nfco5vcC0Q0EHh6LPbK1uidkspsZMWdcV5/S7FxX52pV/57
 EGu5HQz3oRtAQ==
Date: Thu, 12 Feb 2026 09:25:18 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Suhaas Joshi <s-joshi@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com
Subject: Re: [PATCH 1/1] board: toradex: Make A53 get RAM size from DT in K3
 boards
Message-ID: <20260212082518.GA366331@francesco-nb>
References: <20260211111328.1481562-1-s-joshi@ti.com>
 <20260211111328.1481562-2-s-joshi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211111328.1481562-2-s-joshi@ti.com>
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

Hello Suhaas,

On Wed, Feb 11, 2026 at 04:43:28PM +0530, Suhaas Joshi wrote:
> `dram_init()` is called by R5 SPL and U-Boot, both. It starts by
> computing the size of the RAM. In verdin-am62(p), it does so by calling
> `get_ram_size()`. This function computes the size of the RAM by writing
> over the RAM.
> 
> When R5 computes the size of the RAM, it does not update the DT with
> this size. As a result, when A53 invokes `dram_init()` again, it has to
> compute the size through `get_ram_size()` again.
> 
> Commit 13c54cf588d82 and 0c3a6f748c9 add firewall over ATF's and OPTEE's
> regions. This firewall is added during the R5 SPL stage of boot. So when
> A53 attempts to write over RAM in `get_ram_size()`, it writes over the
> protected region. Since A53 is a non-secure core, this is blocked by the
> firewall.
> 
> To fix this, do the following:
>     * Implement `spl_perform_board_fixups()` function for verdin-am62
>       and verdin-am62p. Make this function call `fixup_memory_node()`,
>       which updates the DT.
>     * Add an if-block in `dram_init()`, to ensure that only R5 is able
>       to call `get_ram_size()`, and that A53 reads this size from the
>       DT.
> 
> Signed-off-by: Suhaas Joshi <s-joshi@ti.com>

I was able to test it on a verdin am62, with 1GB of RAM, and it works as
expected. I also agree that get_ram_size() should be called only on the
R5 SPL.

There is a small change that I would do however, please see the inline
comment in the code.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin AM62


> ---
>  board/toradex/verdin-am62/verdin-am62.c   | 10 ++++++++++
>  board/toradex/verdin-am62p/verdin-am62p.c | 11 +++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> index 069aa6c7909..1aa106afbd9 100644
> --- a/board/toradex/verdin-am62/verdin-am62.c
> +++ b/board/toradex/verdin-am62/verdin-am62.c
> @@ -24,6 +24,9 @@ DECLARE_GLOBAL_DATA_PTR;
>  
>  int dram_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> +		return fdtdec_setup_mem_size_base();

change this to

if (!IS_ENABLED(CONFIG_TARGET_VERDIN_AM62_R5) || !IS_ENABLED(CONFIG_SPL_BUILD))

this way is clear that we want the get_ram_size() only on R5 SPL. It
will make the code and the intention more clear, with no changes on the
generated code.

> diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
> index 7c631f380ff..12693c1a46b 100644
> --- a/board/toradex/verdin-am62p/verdin-am62p.c
> +++ b/board/toradex/verdin-am62p/verdin-am62p.c
> @@ -18,6 +18,7 @@
>  #include <k3-ddrss.h>
>  #include <spl.h>
>  #include <linux/sizes.h>
> +#include <mach/k3-ddr.h>
>  
>  #include "../common/tdx-cfg-block.h"
>  
> @@ -57,6 +58,9 @@ static void read_hw_cfg(void)
>  
>  int dram_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> +		return fdtdec_setup_mem_size_base();

same comment here

if (!IS_ENABLED(CONFIG_TARGET_VERDIN_AM62P_R5) || !IS_ENABLED(CONFIG_SPL_BUILD))

with these 2 small changes also add

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Thanks for the support on solving this regression.

Francesco

