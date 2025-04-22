Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEAAC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 13:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A66781273;
	Tue, 22 Apr 2025 15:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="c2WUTIPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5957812BC; Tue, 22 Apr 2025 15:07:50 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88EB6805D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 15:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 94CD41F99E;
 Tue, 22 Apr 2025 15:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1745327267;
 bh=QnUjblsEoh7cFpGBD2/XX+yEhDy3uk9tU6tAIbeXrLs=; h=From:To:Subject;
 b=c2WUTIPwIYjqGPPnjShA2ITGFj/fSO2bT1IgG5SV+6+K9yUnMbEoiYoiisF5N5B00
 yV0kxB4UH0lrTHJ08mFT4/sPbKBkR35IDBmVfx19eaJG8yUFUvbOva4Ei9dtse8zr8
 WSxYJFnLnPr7AY71438qwkplfOuHBYeqdr+H9zMc5K0r+1pEX5bYRYNNZy4WkA+9L6
 lj5xkcm3i5Q4kT8wNtCwfl916Pi667sKcNPRO3Zv7MS/5qPePWCb0cXPWZXnmQKqKg
 FgiyTIl67BU0/9Wq0vrFEgb2YeAkzEYkF5iWZtLqb0ff6wKgmDWdcNIwgCSm+E5BCI
 UAVH+nkMwrJgA==
Date: Tue, 22 Apr 2025 15:07:45 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.denx.de
Subject: Re: [REGRESSION] [PATCH 1/1] mtd: mtdpart: Support
 MTD_SIZE_REMAINING with unallocated memory area
Message-ID: <20250422130745.GB238494@francesco-nb>
References: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
 <20250422103732.GA117260@francesco-nb>
 <6153415.lOV4Wx5bFT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6153415.lOV4Wx5bFT@steina-w>
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

On Tue, Apr 22, 2025 at 03:05:58PM +0200, Alexander Stein wrote:
> Am Dienstag, 22. April 2025, 12:37:32 CEST schrieb Francesco Dolcini:
> > On Thu, Feb 20, 2025 at 03:58:07PM +0100, Alexander Stein wrote:
> > > If there is an unallocated memory area before the last, filling parting
> > > the size calculation for MTD_SIZE_REMAINING does not take this hole
> > > into account.
> > > Fix this by calculating the remaining size just based on total size
> > > and partition offset.
> > > 
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > 
> > This change introduced a regression on colibri imx7 and imx6ull.
> > 
> > ```
> > Booting from NAND...
> > Partition size must be a multiple of 2048
> > Could not parse device nand0
> > Failed parsing MTD partitions from mtdparts!
> > Partition ubi not found!
> > ```
> > 
> > Reverting commit 1ca97ee90392 ("mtd: mtdpart: Support MTD_SIZE_REMAINING
> > with unallocated memory area") on top of current master fixes the issue.
> > 
> > Any suggestion? I have not looked at the code, I just did a git bisect.
> 
> How does your mtdparts look like?

$ grep mtdparts configs/colibri_imx7_defconfig
CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:512k(mx7-bcb),1536k(u-boot1)ro,1536k(u-boot2)ro,512k(u-boot-env),-(ubi)"

