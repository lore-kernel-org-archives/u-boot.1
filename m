Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A91D29C43
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 17:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0CA802C1;
	Mon, 19 Jan 2026 18:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bmiHVoXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1358397A; Mon, 19 Jan 2026 18:00:02 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8328003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 18:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C538625E08;
 Mon, 19 Jan 2026 17:59:59 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VU62spl_REqy; Mon, 19 Jan 2026 17:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1768841999; bh=+Z7ThlMMeAIQnsDjv94/7LQrW2Tht+VZ2af+eh4/35g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bmiHVoXtXvqZqjPOEfpAHnp50cSMheP05PvkdM0WPzIu54CcqqvABA6VNilO6liCw
 Z5aQjsHKcW4CA/i+wxJcN4zfRyklFfk/K52qBzbsYiqPTwA2l9sM+Oj8mcVkhd+G1x
 +Ae53yNDwIwRY0hRvM191vtVYgBiOs4FzyZbe00ivmI6Rfj2RGZloKp3ocqPvon3Oi
 zKxAzuV1orlXXL+A7wGQ3SDzvT/LvfAAuvmaERvCzV3O+mvsNFTyiTs+/vhGAf5U7d
 5B5/+WKp6h9rfQFKvzUFzP3Kwx0Qp79fEeSEb7h28lzjgk0aPl/+MYIdoYWCdksMw8
 Q1o5XMJ0bgyWg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 22:29:51 +0530
Message-Id: <DFSQ5KRJ79JB.1N3LK2G2G2FDG@disroot.org>
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "chiffathefox" <chiffathefoxx@gmail.com>, "Marek Vasut" <marex@denx.de>
Cc: "Andrew Goodbody" <andrew.goodbody@linaro.org>, "Christian Marangi"
 <ansuelsmth@gmail.com>, "Kaustabh Chakraborty" <kauschluss@disroot.org>,
 "Lukasz Majewski" <lukma@denx.de>, "Maksim Kiselev"
 <bigunclemax@gmail.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>, "Patrick Delaunay"
 <patrick.delaunay@foss.st.com>, "Tom Rini" <trini@konsulko.com>, "Ye Li"
 <ye.li@nxp.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] clk: clk_resolve_parent_clk(): resolve external
 clocks by id
References: <20260115031114.220888-1-chiffathefoxx@gmail.com>
 <20260115031114.220888-2-chiffathefoxx@gmail.com>
In-Reply-To: <20260115031114.220888-2-chiffathefoxx@gmail.com>
X-Mailman-Approved-At: Mon, 19 Jan 2026 18:03:29 +0100
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

On 2026-01-15 05:11 +02:00, chiffathefox wrote:
> When referencing clocks in DTS registered by another driver,
> clk_resolve_parent_clk() is supposed to return the name
> of the child device that provides the requested clock.
> However, in reality, it returns the name of the parent DTB
> node (e.g. clock-controller@1a240000). Such devices, for
> instance the exynos7870-cmu-peri driver, do not store any
> clock information in their dev->uclass_priv_ because they
> expect you to call dev->ops->get_rate with the appropriate
> clk->id. So when you try to resolve a clock that depends on
> an externally referenced clock, the resolution fails on the
> parent clock because it doesn't have a  dev->uclass_priv_.
> With this change clk_resolve_parent_clk() will take an
> extra step to actually resolve the child device.
>
> Signed-off-by: chiffathefox <chiffathefoxx@gmail.com>

Tested-by: Kaustabh Chakraborty <kauschluss@disroot.org> # exynos-mobile/ex=
ynos7870
