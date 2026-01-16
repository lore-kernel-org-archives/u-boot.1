Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0068D489A3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 13:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D8482BF2;
	Fri, 16 Jan 2026 14:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qh/vGQGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C018309A; Fri, 16 Jan 2026 14:07:07 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F337E80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C110436F5;
 Fri, 16 Jan 2026 13:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC5CC116C6;
 Fri, 16 Jan 2026 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768568822;
 bh=VciXfs7GnNEpqFiU4GwqcIyOVccCJaJ5uEKeJ6DLv1Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qh/vGQGN7/7hxELl8US4813XsIgmHjRMo47bE6PpD5WkfnnU+NdDXQ3oilgamYPC3
 AqVwFfvVRvYexI3YOIIBvQV0qSEyGNExbIVrYGk1fWnn7zaXsqeet82v7Noe6UOjwD
 RnK/3tCxLdtl75FRcRWOFW7/omGi1/DQUR6L5DcTjFaaJsTZT1iEZEGgNMfry3OAR3
 du1vL90cAj+ynfTxfCV+y3UuGigtXdUF/VaSI8izRoYw0zPflLAhKy2t8vlj99CSec
 X7IOwQZpltRtzaVjbkgw2Svhhd2bhwlcBEdW8TSv7BFW1QBIz/QUGicj3Ktp9UFNlt
 NVC9WTfGoN9EQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>
Subject: Re: [PATCH RESEND 2/2] phy: samsung: add support for exynos7870 USB
 PHY
In-Reply-To: <20260103-phy-usb-exynos7870-v1-2-08f3e9814b86@disroot.org>
References: <20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org>
 <20260103-phy-usb-exynos7870-v1-2-08f3e9814b86@disroot.org>
Date: Fri, 16 Jan 2026 14:06:59 +0100
Message-ID: <87v7h1d7v0.fsf@kernel.org>
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

Hi Kaustabh,

Thank you for the patch.

On Sat, Jan 03, 2026 at 18:22, Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> The USB PHY used by the Exynos7870 SoC has a single USB 2.0 interface.
> Add its dedicated variant enum, compatible, and init/exit functions.
>
> The PHY enable bit of Exynos7870's PHY is different in contrast to that
> of Exynos850 and most Exynos PHYs. To allow this change, a simple if
> condition is added in exynos_usbdrd_phy_isol() which changes the
> bitmask. Since the variant enum is required, the function argument is
> changed to accept the driver data itself.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

I've compared this with the linux driver and I don't see anything
surprising.
Looks good to me !

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/phy/phy-exynos-usbdrd.c | 246 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 238 insertions(+), 8 deletions(-)
>
