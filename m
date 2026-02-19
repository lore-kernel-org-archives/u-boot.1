Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B894E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A013283A47;
	Thu, 19 Feb 2026 11:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eqbSkPGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AAF583CD3; Thu, 19 Feb 2026 11:28:24 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C286B83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 422A043B2D;
 Thu, 19 Feb 2026 10:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC9C19423;
 Thu, 19 Feb 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771496900;
 bh=Bn6ue+pRQZ8ywaNeketM7XFnF0VJtEwN0EvaO+F9MHM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=eqbSkPGGbLyLLKRuYF9MIyKVGQyzA1Rp3ItGrjFUVgCApSK0oSt3MFbsTSgEWoC33
 xSpA9KcEJNleZ9nt2SHRYyDdpCtzDdm+Eqg1gpwqYckGD1ut5NMAW8tjp748JBmnI9
 VGcERvOOZuFCvWetCsSMm4mPitakneGhbOp6kOJx0bZ4o8CXrL/HJQ3G83WQbT93V7
 kTzetUZptBIMRrYSGLiaUIKAv6P8CWdlEzXh2jBnET0+UvI8mOQg+8o8uW0OE1UcaW
 lHJRYcp91+tupHHFkybQm+tqVMUH411qNDw6/5fVHBjaNqCLEhHFFbIqLYkijYcGWK
 QQzOmmYc/9z3w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heiko Schocher <hs@nabladev.com>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260217103604.71029-1-hs@nabladev.com>
References: <20260217103604.71029-1-hs@nabladev.com>
Subject: Re: [PATCH v3 0/2] fastboot: mmc: fix bootloader offset
Message-Id: <177149689755.283428.5784764873863046015.b4-ty@kernel.org>
Date: Thu, 19 Feb 2026 11:28:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 17 Feb 2026 11:36:02 +0100, Heiko Schocher wrote:
> Not for all SoCs the bootloader start at offset 0x0,
> in a hardware partition of an emmc. So we need the possibility to
> set the correct offset, where bootloader starts.
> 
> Example:
> 
> imx8qxp revision C0 emmc Partition layout
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] fastboot: mmc: make boot partition offset configurable
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/24526162338114a8ac6c51280fa672ee1ca72241
[2/2] arch: imx8qxp: Override weak fb_mmc_get_boot_offset function
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/94b7c3b2622ae1e43aae0d92005ac8ca4dd9f134

--
Mattijs
