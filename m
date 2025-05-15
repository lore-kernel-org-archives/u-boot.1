Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC5EC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 12:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9FB82B6B;
	Thu, 15 May 2025 14:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="MBC+/CMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C2882B70; Thu, 15 May 2025 14:34:45 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE48C82B54
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 14:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id ACC4D1F8DE;
 Thu, 15 May 2025 14:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1747312483;
 bh=SQCL1eIAa9JwI00CS1bZNsr+QnujwucVETH7id9TsRQ=; h=From:To:Subject;
 b=MBC+/CMVIn6GgrQa3AvYRJM1kKTVXlnpENVHL9xQGTK1Nv+OC0XwraNtCkw728SpX
 uaUeMIt4RLWFdxJhyArUQnds9MR/lVf6r4q0pX5rjMuCVOTtKLMYOe94Uj0R7tq+si
 F7fipDjbDsGt0w6fgZCo65LnlTADplFKZo57LhB8uDUlMHmqGC74CHa+5mI3t97KL9
 agBhaljHW6rzgOaUKZieHOd8+Xy1th+04wQcGyC5PGgklCUGRf/YheoBLW4+LNGN1F
 W88ZkQu28ffNF8Jc9slO62Fwp0oBCf1xsjAGEL1Q0CIMy8dQafKLixuy6wkOx6R96k
 ms6u2ntlkBA3w==
Date: Thu, 15 May 2025 14:34:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>, u-boot@lists.denx.de,
 Vishal Mahaveer <vishalm@ti.com>, Chandru Dhavamani <chandru@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-am625-verdin-r5*: Remove clocks from
 main_timer0
Message-ID: <20250515123438.GA59801@francesco-nb>
References: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
 <20250515-b4-upstream-k3-pll-miss-v1-3-e38b89f027b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-b4-upstream-k3-pll-miss-v1-3-e38b89f027b8@ti.com>
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

On Thu, May 15, 2025 at 05:08:36PM +0530, Manorit Chawdhry wrote:
> The commit 79d91e77f4c2 ("clk: ti: clk-k3-pll: Add additional robustness
> steps to the PLL sequence") introduced a change which requires the
> main_timer0 to not rely on it's own clocks which anyways was wrong.
> 
> Fix it by removing the clock dependency for it, also while at it, move
> it from u-boot.dtsi to R5 as that is the only entity that should require
> it as DM isn't up.
> 
> Fixes: 5d1aac358f3c ("arm: dts: k3-*-r5: Remove clocks from mcu_timer0")
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

