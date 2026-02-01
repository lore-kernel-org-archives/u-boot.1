Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B2E65266
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 14:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69ADE83B85;
	Sun,  1 Feb 2026 15:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="UF8bqEfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878C583B5E; Sun,  1 Feb 2026 10:51:42 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6458F83B43
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 10:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 14BE4262C7;
 Sun,  1 Feb 2026 10:51:40 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRymx7sAKWKF; Sun,  1 Feb 2026 10:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1769939499; bh=YwWL+3dJMH48DkFDljtKRzZlVyvJpONXmjXyM1ITHsc=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=UF8bqEfBOVm1QR1/q1yNw8iqCwTSI1ViNAn3JIf4Ryh570Pp12nDzWg0EeMkGsVWd
 CS8QXSHpjczbiM/qX+SLcqq8bzNano9a0opa53vWmyi0oJvyENHDGxHh7zfAb1JZvr
 qfOAt9v5mqfTh/QRwhsyz/vKxJ7oqMFurlsUVOTWaZIAe6y7jsclkE89ONGWCIHnN3
 enMButr/P5fV06oV5O92BoAC2hevI3niqN+yd2cWj/OPTbXH9ZobMMqEgYsgxbAO1X
 K1YsFD9CmOoHBAjyQ8RsZiFFYK0UIpgiAPjzE5sDdIkp5OaibK/sw2ViiTLX82suII
 wqloVfRSLfydQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Feb 2026 15:21:31 +0530
Message-Id: <DG3J6PCL3WLX.872U6GFC8HCW@disroot.org>
Cc: "Sam Protsenko" <semen.protsenko@linaro.org>, "Tom Rini"
 <trini@konsulko.com>, "Minkyu Kang" <mk7.kang@samsung.com>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>
Subject: Re: [PATCH RESEND 0/2] Support for Samsung Exynos 7870 USB PHY
 device in driver
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>, <u-boot@lists.denx.de>
References: <20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org>
In-Reply-To: <20260103-phy-usb-exynos7870-v1-0-08f3e9814b86@disroot.org>
X-Mailman-Approved-At: Sun, 01 Feb 2026 15:08:58 +0100
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

On 2026-01-03 18:22 +05:30, Kaustabh Chakraborty wrote:
> This patch series aims to add support for the USB PHY in Exynos 7870
> devices. This can be accomodated in the existing driver, the patches
> implements the ability of multiple devices to be driven by the same
> driver.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Hi, are there any updates regarding these patches? Any movements?

> ---
> Kaustabh Chakraborty (2):
>       phy: samsung: add enum for variants based on SoCs
>       phy: samsung: add support for exynos7870 USB PHY
>
>  drivers/phy/phy-exynos-usbdrd.c | 271 ++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 261 insertions(+), 10 deletions(-)
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-phy-usb-exynos7870-c2f2ac44fd65
>
> Best regards,

