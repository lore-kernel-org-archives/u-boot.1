Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CBFD4899A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 12:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECDA482BF2;
	Fri, 16 Jan 2026 13:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AaSk80Nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738C78309A; Fri, 16 Jan 2026 13:44:18 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF3280077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 13:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A67D60167;
 Fri, 16 Jan 2026 12:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B451FC16AAE;
 Fri, 16 Jan 2026 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768567455;
 bh=B/1sIm1O7UcD70G+BRmgwN7ck084pgnVPLuG1hXr748=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AaSk80NukM0BQGIrhYi5R2yJEyBODqJn9uFsJWSxjlBV+4zHQRFawZI61kuSJyUrU
 eN3InuJQn9q9vqaUWrncn9EVINFUJbAPkJiORGxnw7Wpx4GnW71DO5Lf6nVDcIl24p
 DVIImk+9wayP1NY+PXe2S2MQX19Gcb5/UiJGulby3OaZVUfKu9scCOuzD6uiQWJ6Ho
 cHbwgKqK93fXndju5K+EOfPfmwqrSYRfK7COORpExxaGLPJOOmuKOacl/OX/xLqX6N
 Lfx299YqTfVQKTHUbk8rslr7V1AgH8MTi15z4mpPyQ1KC/0NDTAR8kBOOURIzXshpJ
 vRJxhEYhjvxYw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>
Subject: Re: [PATCH RESEND 1/2] phy: samsung: add enum for variants based on
 SoCs
In-Reply-To: <20260103-phy-usb-exynos7870-v1-1-08f3e9814b86@disroot.org>
References: <20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org>
 <20260103-phy-usb-exynos7870-v1-1-08f3e9814b86@disroot.org>
Date: Fri, 16 Jan 2026 13:44:12 +0100
Message-ID: <87y0lxd8wz.fsf@kernel.org>
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

> The variant enum is used to uniquely identify which SoC the PHY block
> belongs to. It is initially set in the match table, along with the
> compatible string, it gets copied to driver data struct during probe.
>
> SoC specific functions must only be called if the respective variant
> enum is set. Add switch-case blocks wherever required.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/phy/phy-exynos-usbdrd.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/phy-exynos-usbdrd.c b/drivers/phy/phy-exynos-usbdrd.c
> index db5815ed184..4ab8da2a08f 100644
> --- a/drivers/phy/phy-exynos-usbdrd.c
> +++ b/drivers/phy/phy-exynos-usbdrd.c
> @@ -66,6 +66,10 @@
>  #define KHZ					1000
>  #define MHZ					(KHZ * KHZ)
