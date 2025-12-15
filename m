Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83181D5B878
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 23:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EF8805D7;
	Tue, 16 Dec 2025 00:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QVvucGb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574AE800D0; Mon, 15 Dec 2025 19:38:26 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8780B8003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 19:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4CD3E26125;
 Mon, 15 Dec 2025 19:38:24 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rgUuL04UKtW; Mon, 15 Dec 2025 19:38:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1765823903; bh=PdN3FO9gPvvb5lFU73zXRrAW+B+NNCV1nQYVbWci8b0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QVvucGb8zlr8HAnYekaouI/kYWqz9DvtVZAEfCneYzWAds5Gwvnm9Li7txHWvVD4z
 ugyfZdEixmafphuEQqtUMhScLj/gYR55mP8yZn/AcJU7ywuSyoc1W54WjeYBYvvMky
 tEcBj8Aqi5MuGmaXR2boTn09yyHoWwcUxcGTa7neD0Ij7fBvmKFvxre0Wf0P0kPxOc
 xo5OckY5WmfDxve/4Z5qu5NBOIUsBUqcQqLgkrEwgqDSiWrWRsDTJ7TbOQtG5cG/Kn
 /Kn99fqXAuqUrPDmCEADxFfqLcFI+cTuVG0LZ4aj77gAaeK6yUBTX1biFS/DS8uwta
 1vIg1HzJ9PfOg==
MIME-Version: 1.0
Date: Mon, 15 Dec 2025 18:38:19 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 0/2] Support for Samsung Exynos 7870 USB PHY device in
 driver
In-Reply-To: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
References: <20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org>
Message-ID: <b6016346f84f8f98e452102960efe773@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 00:05:08 +0100
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

On 2025-10-17 15:27, Kaustabh Chakraborty wrote:
> This patch series aims to add support for the USB PHY in Exynos 7870
> devices. This can be accomodated in the existing driver, the patches
> implements the ability of multiple devices to be driven by the same
> driver.

Bumping this series for visibility.
