Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF420D5B878
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 23:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D87A80325;
	Tue, 16 Dec 2025 00:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="aP+Dtlde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E359F800D0; Mon, 15 Dec 2025 19:37:50 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174598003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 19:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CBDC0263AD;
 Mon, 15 Dec 2025 19:37:48 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Gf_ve_wXMIx; Mon, 15 Dec 2025 19:37:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1765823868; bh=iSRfRAsl139OATfhOmGrr0eQis6OtUkt4rXJ1GsXfwM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aP+DtldekNGcBsKUKpCLxsMekgXzSvlV4VrRpQxHqZNj1dlvQwT2UnFNAh0sMWK25
 JV318C77TMJeoW1bAoKGrwhIxdH8JdLAvMYKTivUh5OppFObvhtR7knuh3GdB2OPAN
 F/nOKFTt8UohzdY+kax2C5gVaLH6aWwkLvXRGP++P6tfxvplibJHE6fYNdcC8Y7TeJ
 gXiw1FMAIvM1yjxU0tyISqqlRmFXLlwSnPn6ZwvFSgt1YMiAk0TwaT3TnqwRbEqHSm
 El6CwN1s7wTVxnI/GqRLZ6khzcOEC9hI72cc0Uf8CaJrEeNEV9izd9ZFXqV/pWpFGV
 gpqS5LgcxgCHw==
MIME-Version: 1.0
Date: Mon, 15 Dec 2025 18:37:47 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 0/2] Support for Samsung Exynos 7870 DW-USB device in
 controller
In-Reply-To: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
Message-ID: <e0697d9ba9ba130c071fcaad967253bd@disroot.org>
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

On 2025-10-17 15:30, Kaustabh Chakraborty wrote:
> This patch series aims to add support for the Samsung Exynos 7870 DW-USB
> controller. The support is added in the dwc3-generic driver.
> 
> This also has a patch which allows the driver to fall back to "otg"
> dual-role mode when none is specified in devicetree.

Bumping this series for visibility.
