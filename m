Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7453C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4B0809D4;
	Thu, 24 Apr 2025 10:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="D0WkR5kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD9180F9C; Thu, 24 Apr 2025 10:41:45 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9A78070C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 93CDE1F972;
 Thu, 24 Apr 2025 10:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1745484102;
 bh=XIcAuN4r9I2wVnSFBnair80S/3ygxvtJBLrNsrWgeF4=; h=From:To:Subject;
 b=D0WkR5kqWVs46RnumRN2fwpTUGaEfOBPWmR1TVQp6f6QupmFrFCGqgMlpndf9VMVw
 J+jsX63gCG33oxaRu7YmuWBHc7aO4HX7HToNIP/oFH2tlnWOsL0nW2us5+sE/bje8r
 B8ElWrLJ8cNBpuxSZXehdBw+jwi1pFyme3Uqhb0662VgU8smcXJB96LLzX4hYlxDXc
 moYVnxqA5e0W+7LO1HRSLpemzX3kTuVidDDNprFbShoCtGevUcNeUbHwPqNdGmWru2
 kC0D6tv1e1qOQNPZK29Hr+EJ3CTBYEoVEYu1njHi02Tq/aGbnkMuw1/+x+ZkYgUHFg
 q/ZMVcVg4i84Q==
Date: Thu, 24 Apr 2025 10:41:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: fix verdin imx95 sku 0089 pid4
Message-ID: <20250424084137.GA22638@francesco-nb>
References: <20250424082909.1396771-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424082909.1396771-1-ghidoliemanuele@gmail.com>
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

On Thu, Apr 24, 2025 at 10:28:59AM +0200, Emanuele Ghidoli wrote:
> The memory size of the 0089 SKU is 8 GB instead of 16 GB.
> Fix PID4 0089 Verdin iMX95 definition, in the configuration block.
> 
> Fixes: ce53f46f33b4 ("toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

