Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D9C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D401680A46;
	Fri, 24 Jan 2025 16:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="TV8EPepz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFA680ADE; Fri, 24 Jan 2025 16:25:20 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F65A809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 83FC21FEBE;
 Fri, 24 Jan 2025 16:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1737732317;
 bh=DtT0Z1FYbOSd8/RKs2/8e3FG5Q09JnAB0OvtiCIHA4M=;
 h=Received:From:To:Subject;
 b=TV8EPepzWVOMvxNTcgZCti8JfjA13qYgRG3wGx847c4YyEwGNYpXhux42U5XbtDoX
 9EtfbID/GBjQTVmZEaNYqAgTGpMFBLyGS7d1S8z33EKsbRH8CqB8johnUa/aVMUE1m
 5gQzwdXcJSJIBTrvgy9CN8FaKW2efJVWwqyQx6rBhICiwhip0IenCLubR/KtHsknF4
 vzCMbpMnLA7tVFs7ykK+h3etyMM4j3pGwoOE9hMBJNCKKc+W3Lhpb1Hgr02Jtd5LWq
 ac4s7sRD7zXhKrdz+oFPTC/8Juv7z5Q9A2zQq2gsDE6m8VuiSuIKcxBf97ynporfoh
 eAV5zOBpk1hPA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 31C5D7F8C4; Fri, 24 Jan 2025 16:25:17 +0100 (CET)
Date: Fri, 24 Jan 2025 16:25:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 joao.goncalves@toradex.com, vitor.soares@toradex.com,
 igor.opaniuk@foundries.io, max.krummenacher@toradex.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: fix switch to user partition
Message-ID: <Z5Ow3fFXZULEqZgf@gaggiata.pivistrello.it>
References: <20250124151443.576075-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124151443.576075-1-eichest@gmail.com>
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

On Fri, Jan 24, 2025 at 04:14:30PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The Toradex configuration block is stored in the first boot partition of
> the eMMC. After reading the configuration block, U-Boot switches back to
> the user partition. Currently, this operation always targets mmc device
> 0, even when the configuration block is stored on mmc device 2.
> 
> This patch addresses the issue by switching the mmc device set in
> CONFIG_TDX_CFG_BLOCK_DEV to the user partition, rather than using the
> hardcoded device 0.
> 
> Fixes: a2777ecb9d11 ("toradex: config block handling")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

