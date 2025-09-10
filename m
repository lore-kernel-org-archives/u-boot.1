Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B92BCA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 08:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E94F830B4;
	Wed, 10 Sep 2025 10:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="iw3nYQUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D43E8318E; Wed, 10 Sep 2025 10:51:55 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D3F82B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 10:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id ACD201F9E5;
 Wed, 10 Sep 2025 10:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1757494312;
 bh=lieQYAFuhZiZhGrFGo5DcEY7xewQe9quhU8hhqdfMRU=; h=From:To:Subject;
 b=iw3nYQUaCu1ZHFa9S1P4y1mgwZweWgLj8W619sOf734+UUEkS2ygIY8EirJJ9KEyq
 uSNam0b3PUtukOmNx7dnWEDO+SwMi2ZJEypJRA5MSSfhfURJS+1CHdRYQt4WxwsP1c
 VRzjs2tkyHOL5k3AXVxBTvqnQfTYhWunpcFs3vZgvXQwE0MrUSZCHjPekp34uBwxoz
 vhkeVodDH6ml4uDOHn+jIXVrHVc0T7tZv0K83qh7KrGB0IOD1ylTaC0pxlKYtPn1kh
 hV0PEvOi5xjkJKUOh9cNk/hRXoaIIl6KZM0o3GK3w7pgWN7adhSqXkExSUqSte0jGS
 sTuI1uoQnI6XQ==
Date: Wed, 10 Sep 2025 10:51:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de,
 Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250910085148.GA9815@francesco-nb>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
 <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
 <20250909154710.GZ124814@bill-the-cat>
 <CAPVz0n0Yk8GzX7Y3qUET2EK=UWyGwn7FLn5HGfLP7i9ms9ht2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0Yk8GzX7Y3qUET2EK=UWyGwn7FLn5HGfLP7i9ms9ht2w@mail.gmail.com>
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

Hello,

On Tue, Sep 09, 2025 at 07:08:34PM +0300, Svyatoslav Ryhel wrote:
> вт, 9 вер. 2025 р. о 18:47 Tom Rini <trini@konsulko.com> пише:
> >
> ...
> > It's a devkit where I'm pretty sure the watchdog exists, so we can
> > enable it there and be done. Just because it doesn't use it today
> > doesn't mean it can't use it in the future if we enable it, the "use
> > watchdog to make sure A/B system configures are stable" is a common use
> > case.
...
> Not sure if changes into colibri_t30_defconfig are needed, but if
> Francesco would like them, then ok.

I would prefer the defconfig not to be touched.

Francesco

