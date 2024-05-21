Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0B1C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EC688702;
	Tue, 21 May 2024 12:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="gMfBTjCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6E1880A5; Tue, 21 May 2024 12:12:08 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E33D88690
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 2FD0B1FA6E;
 Tue, 21 May 2024 12:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716286324;
 bh=5rbDwC8DW597jl4FJ2IHHc0pzPTZtB3Crzxu4yfoIWs=; h=From:To:Subject;
 b=gMfBTjCBxqCYQecLnMMtzuEw6/+/t7Dv+wV7dbUhVm7UqvPEQNigdfYz6/p5vlyvD
 ToPgcn5zDu9vcPlcmWdSh5+R9G3Sk7Ee51cv7qkjPxJqiLj5NvicAC5GS96sREL7ez
 gbwzqpYli07L6DkINw5wAXQ0XHCR2YsDgmw0F9EMWU07wxMZtCSPOI4eVLF51zWf+v
 knqWwdVk2TLMXqXoAoTeZuLG98Q7JfzcNwvR2RcngTULHJ2RTXBM8ciYQb56vVIclZ
 pL2rKv2GJV244xX7M5WbN3fej7QGfSfOuXCSw8KLZIiwtMsQ7FaeHW1qqUpLUQCkqi
 9cohj9dXw0g/A==
Date: Tue, 21 May 2024 12:12:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] ARM: imx: Increase PHY auto-negotiation timeout to 20s
 on MX8Menlo
Message-ID: <20240521101200.GA12495@francesco-nb>
References: <20240521093950.8810-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521093950.8810-1-marex@denx.de>
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

On Tue, May 21, 2024 at 11:39:38AM +0200, Marek Vasut wrote:
> The ethernet PHY on MX8Menlo board takes a while to come out of
> reset, increase the auto-negotiation timeout to prevent it from
> timing out in case the ethernet is used right after the board was
> reset.

Is this specific of MX8Menlo or something we should have on
verdin-imx8mm instead? I am not aware of any report on this issue on the
verdin, on the other hand the verdin imx8mm has normally only one
ethernet interface, and this is the one from the verdin SOM.

Francesco

