Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F452C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEC583BC9;
	Sun, 18 Jan 2026 14:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="fxTYCV7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D73E83956; Sun, 18 Jan 2026 10:11:11 +0100 (CET)
Received: from sender4-pp-e105.zoho.com (sender4-pp-e105.zoho.com
 [136.143.188.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE7488313B
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 10:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768727423; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NU+57nzgyLWGi5URogLpz7VITUhLQGRkN4fICCQ8pKVZ5D2Fn7JgWkmueNR/F/bY/aU1dUDgC6sdKKffYnj8LuDMJdQzYodNvnYNdHsqJymo+ODrxlM0msKgT9mOtxmm86e6OLm/Bjc+zyQbqUkEg5qSMtK0s4u72oHQa1c+Cq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768727423;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UYjftOiisN755jhASRELUuQ7xlF8OLuUuvppoRgDw/A=; 
 b=FMGImiAbgOLIgUVaVBhITcKyF2lTF8eIdewVFPudA5IRRB2CPPXjdv21XPuJ9vbErrOI2d4seW27VtVE+h4Lyoo7lx51MbeGEAF2uE/4CuiXmDG0PCCl7EMsNH0dmRGsNi1bkUn2/FnC1veuCXqyUqb9S0OFc3eJB6VDACKHMAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768727423; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=UYjftOiisN755jhASRELUuQ7xlF8OLuUuvppoRgDw/A=;
 b=fxTYCV7l7WVRfkCsUBwigjzw4FIl3BhiiL2dxODvpNtW9XaftzzqcLr3/snPi73w
 5yXRcEof8Xgi9GYegv8OLjDEvFW+PohWpRClU9sdgW4qvjgxQbbIIni0/4QiQ80oRbo
 bQDjOhXXyjDwpQUDLApkW/qnur+Zpl68cXlxuwVU=
Received: by mx.zohomail.com with SMTPS id 1768727421542868.629710554909;
 Sun, 18 Jan 2026 01:10:21 -0800 (PST)
Date: Sun, 18 Jan 2026 09:10:00 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Samuel Holland <samuel@sholland.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH 04/17] reset: k1: add SPL support and enable TWSI8 reset
Message-ID: <aWyjUHwp2gzZfUYH@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-5-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117190231.977686-5-raymondmaoca@gmail.com>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aWyjUHwp2gzZfUYH@pie>+zmo_0_me@ziyao.cc
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

On Sat, Jan 17, 2026 at 02:01:38PM -0500, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> This commit enhances the K1 reset controller driver:
> 
> 1. Enable SPL support
>    - Select CONFIG_SPL_RESET_SPACEMIT_K1 for SPL builds
>    - Reset controller is required during early boot for
>      proper hardware initialization sequence
> 
> 2. Remove TWSI8 (I2C8) reset restriction
>    - TWSI8 is now fully controllable by reset controller

I don't think you change any real logics in the driver, so what fixes
the function of TWSI8 reset? This deserves more explanation.

> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  drivers/reset/Kconfig             | 7 +++++++
>  drivers/reset/Makefile            | 2 +-
>  drivers/reset/reset-spacemit-k1.c | 4 ----
>  3 files changed, 8 insertions(+), 5 deletions(-)

Regards,
Yao Zi
