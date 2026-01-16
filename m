Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0033DD4899A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 12:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC2A8389A;
	Fri, 16 Jan 2026 13:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JGwtlFh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C9B838A5; Fri, 16 Jan 2026 13:33:48 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2AC582BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 13:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5968D43CBB;
 Fri, 16 Jan 2026 12:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84A6C116C6;
 Fri, 16 Jan 2026 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768566824;
 bh=umGv1NAyh4hOsM48u3NB9whIRhS2Y/WWuoOUVQO1uFk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JGwtlFh6uYSeLQ3Nhf1+8RKRooIa9cCZW5aKM0WidbXbN/LoGoqq0YT7bbsQoL7S6
 d4c5mwaGg5e+CE9CMEZDxIg9hi0iXpwIdyrEvzoUB5XPJeUyukTLokv06fEPRFDNJI
 vl5TGmykM7BU4G3RCLRNZDVSAW+ngdQfSHhACCC8+GRpt2Wzv4yQRdYjnfKA7UpAPk
 M+CamHu4ALOCtwhUxlfucUKolSWhMMKncbj8OgOgCaA/4y2S0W0nYgNwbi+ZCKDayX
 9hJPObN4IClgBqwRObWUZEJ+C72dEBn+tX0TjY8avU0+m7LTj+9QhXikFWCwD4rAOy
 y1xI/msdf+96g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Kever Yang <kever.yang@rock-chips.com>, Jonas
 Karlman <jonas@kwiboo.se>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>, Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v3 2/2] usb: dwc3-generic: add support for exynos7870
In-Reply-To: <20260108-usb-dwc3-exynos7870-v3-2-343fa1e81e48@disroot.org>
References: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
 <20260108-usb-dwc3-exynos7870-v3-2-343fa1e81e48@disroot.org>
Date: Fri, 16 Jan 2026 13:33:41 +0100
Message-ID: <871pjpenyy.fsf@kernel.org>
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

On Thu, Jan 08, 2026 at 18:03, Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> Exynos7870's DWC3 glue layer is quite simple, consisting of a few
> clocks, which is handled by this driver. Add the compatible string in
> here.
>
> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/dwc3-generic.c | 1 +
>  1 file changed, 1 insertion(+)
>
