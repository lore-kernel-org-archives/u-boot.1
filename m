Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF52EEA3F00
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 05:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43ABD83CBD;
	Tue, 10 Feb 2026 06:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oCfC7EJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B7E83CEE; Tue, 10 Feb 2026 06:26:35 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C2183CE3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 06:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4571F405D2;
 Tue, 10 Feb 2026 05:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B6C19421;
 Tue, 10 Feb 2026 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770701186;
 bh=kjVdh06CUwi1IfDH+EXNZoA6/vYlwvg84KfWLMP0g2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oCfC7EJIJQOFaJzx3WSFIzA4UTm3XfELNgA79odH7Lo6RrqfSrTbQZw37i/aL9Zn0
 aQDRadq2sAjKci2Q4VrZhT41MqgAK1u63BrXJZ18DVwefNEB0e2yLMG6hHw0CBa+e2
 sz3OeNqEvkzT3hevZllBXUM7tByOSWh9DWU32EcWk3855iEa4mHPl33YHQ0rmIsW5s
 b4Jtr9KLSTZvLfUPtaYnnkkmHjdUm86k/tA11IgwtTNkGMOgqY6G2Zk0+3UXRR4Rq4
 Te43FfAtVUnbQIkeQlj7isNd4/urv0RFgFzB4UbKpy+b2anR8nWPyVaScbCx+dRGC4
 vc5m9XN8t8yng==
Date: Tue, 10 Feb 2026 10:56:18 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Biswapriyo Nath <nathbappai@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bryan Brattlof <bb@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Message-ID: <aYrBejVVr7Ud9xkv@sumit-xelite>
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
 <20260207092845.10421-1-nathbappai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207092845.10421-1-nathbappai@gmail.com>
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

Hi,

On Sat, Feb 07, 2026 at 09:28:38AM +0000, Biswapriyo Nath wrote:
> On Wed, 04 Feb 2026 16:10:51 +0000 Biswapriyo Nath <nathbappai@gmail.com> wrote:
> 
> > This is still RFC because micro SD card does not work with u-boot but it
> > works in Linux. I do not know how to troubleshoot the issue. Any pointers
> > would be really helpful.
> 
> I forgot to add the error message. Here is the output from USB serial.
> 
> => mmc list
> mmc@4744000: 0 (eMMC)
> mmc@4784000: 1
> => mmc dev 1
> Card did not respond to voltage select! : -110
> 

Can you check if recent SD/eMMC fixes merged [1] are included in your tree?

[1] https://lore.kernel.org/all/20251210155454.1561611-1-loic.poulain@oss.qualcomm.com/

-Sumit
