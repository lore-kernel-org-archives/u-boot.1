Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2103DD29C43
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 17:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1353D839DF;
	Mon, 19 Jan 2026 18:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HHYZxEQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32A78397A; Mon, 19 Jan 2026 18:00:34 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0F48003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 18:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7084625ED5;
 Mon, 19 Jan 2026 18:00:32 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pV6YF2Qu7E_T; Mon, 19 Jan 2026 18:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1768842031; bh=edYNyJOnRgNJ18arP7otWZokBJui86ep+IPWIG/Dszs=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=HHYZxEQ6qq0w8ee1ZCdRVGxzZrzP7k0Uo08uwLpd7+D0AMfNzA/T+oPInXYuPP2F2
 ho7GwigPKVPljlBxZt1LfT+Mh0mgIwKDyO9bVQ27iWZpIqCUh2zYipQTwLB5xjHOQd
 TBxX9U1cr1OWFvpWE9gqMnEA7IZo5ZLZIpTagt2KQYOUEgmFTPwmOLy357OyRRyCxp
 uSRGXOsk7DB/lrSGlLrc+flY86zt00N2g76LDCXKx1eLiImxcw2qd1tSsIiBtIe2Ng
 HBrUrzsIpv4IWdGO1J4d4LGWVCG1SxIZb/NXkz2vunA1qa5DX61zO76DFSoPtdxBy1
 E+yHwD4EA74lA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 22:30:24 +0530
Message-Id: <DFSQ602NFWQ7.25DB4BQ6SHEHC@disroot.org>
Cc: "Kaustabh Chakraborty" <kauschluss@disroot.org>, "Lukasz Majewski"
 <lukma@denx.de>, "Minkyu Kang" <mk7.kang@samsung.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Tom Rini" <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] clk: exynos: do not reparent requested clock
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "chiffathefox" <chiffathefoxx@gmail.com>, "Marek Vasut" <marex@denx.de>
References: <20260115031114.220888-1-chiffathefoxx@gmail.com>
 <20260115031114.220888-3-chiffathefoxx@gmail.com>
In-Reply-To: <20260115031114.220888-3-chiffathefoxx@gmail.com>
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
> It would appear the original developer of this driver
> reparented child clock devices to fix the issue described in
> `clk: clk_resolve_parent_clk(): resolve external clocks by id`.
> This hacky fix was the cause of invalid memory access when calling
> clk_get_rate() on a clock retrieved via clk_get_by_index().
> clk_get_by_index() returns a copy of the `struct clk` and
> when passed to clk_get_rate() it may be forwarded to
> clk_divider_recalc_rate(), which will cause the latter to
> run container_of() on a pointer from caller's stack instead
> of the pointer that was kzalloc()'d by the clk-divider driver.
>
> Signed-off-by: chiffathefox <chiffathefoxx@gmail.com>

Tested-by: Kaustabh Chakraborty <kauschluss@disroot.org> # exynos-mobile/ex=
ynos7870
