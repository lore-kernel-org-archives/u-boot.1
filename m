Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3AE6817C
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 12:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4858F8063E;
	Tue, 17 Feb 2026 13:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iN6lPzRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D18983AC5; Tue, 17 Feb 2026 13:46:44 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDED80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 13:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D8F7441917;
 Tue, 17 Feb 2026 12:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C316C4CEF7;
 Tue, 17 Feb 2026 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771332400;
 bh=W726zx8risFA72+mX19XknK2SjgoAQXbF8+yhY0Yfd0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=iN6lPzRL7+ZUDNFIQQkcTkUbqurXw1dvgRWEMdIQq80hxztBTZZw86iAdoKGSWaMD
 CC0RT1dmUtt/W6Bj5JJVIQgImxmemFxbTWuocJiTv6Zf6Mxr2ergxKhoWmZ49eNgrF
 96nR+3vd7BYDiA42lY6EwKqr7pFApXtsv8Hql3MMxJefcLhxtPa0s5GE1gNjqjtb+W
 TzvI9HXdCZneoAFZ38WhhjNJ5CFB7WjEPqbJSNP2QajFuiXvbAGlJVn4JNTYFQ+KhS
 F2EUu9OdCaYcuXnP9irEdyOgw+kk6BOGPToC2kk+Yb70PmKJ1gR9jH4p5bCgVl0Axq
 DxCW3oRwurLBA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, Fabio Estevam
 <festevam@gmail.com>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Heiko Schocher
 <hs@nabladev.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] arch: imx8qxp: Override weak
 fb_mmc_get_boot_offset function
In-Reply-To: <20260217103604.71029-3-hs@nabladev.com>
References: <20260217103604.71029-1-hs@nabladev.com>
 <20260217103604.71029-3-hs@nabladev.com>
Date: Tue, 17 Feb 2026 13:46:38 +0100
Message-ID: <87h5rfk05t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Feb 17, 2026 at 11:36, Heiko Schocher <hs@nabladev.com> wrote:

> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Add IMX8QXP SoCs specific implementation of fb_mmc_get_boot_offset()
>
> This is needed as bootloader offset is different dependent on SoC
> revision!
>
> For revision B0 the bootloader starts at 32k offset. On offset
> 0x0 the bootloaders environment is stored.
>
> On C0 revisions of the SoC bootloader image starts at offset 0x0
>
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Fabio, Peng, can one of you please Acked-by: so that I can take this
through my tree?

Alternatively, please let me know if you want to pick up the series instead.

>
> ---
>
