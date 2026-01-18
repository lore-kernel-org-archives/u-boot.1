Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC037D4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AAA183BC4;
	Sun, 18 Jan 2026 14:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="mdsnK2yO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB088313B; Sun, 18 Jan 2026 09:58:06 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0FE82BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 09:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768726641; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XBc//sPO0/874vEgXuS62U73D5BzeTRc1N2dACP4idz0+ecxpAvtkpEVg2xH3qF0Epbjb9i/KRYY+wG6deo/iSvDf/7SPXEgA6INwaK2xWCjDPqunMdyTrTqMl/ZVZpyu8DwLjUSR6zK6I6VEPABJ5tFgPRpI9GBMCGYWyq10FU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768726641;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YZ1of0P6/1iaRMhmWndq42GQ1xHkF8IS0mAxUyXswsY=; 
 b=ccVz+WVoae5kUEDQpM0+kskQjRTL4eOFzeamY1BCiDr/u2tIZOuNLbzRKh5iDAwCSrn+7qdaLQChwHPfnK5udNORM/tZZQHDInZAaTA8A7waomNfhfSoulfWIgtYtOIRgkoPQnTJE8rqxzApXvOHfddLhok3kNtaWetJLIk430M=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768726641; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=YZ1of0P6/1iaRMhmWndq42GQ1xHkF8IS0mAxUyXswsY=;
 b=mdsnK2yOysDBtI0Wvs6Z+0O+MMF9pbGU3BnHlVk3SMcKmjc4OnsZ5tAFG0ZPUA/g
 2eAnvq2xveV1HOU4d1RsiYAtPA7/CGog8UyGzzen5EALvW6/GOiS0Dzi225Z36xxPCo
 QQ40T5UylqeeGN2g96O3Q2wuRnT1vS6tRbnQ1rnw=
Received: by mx.zohomail.com with SMTPS id 1768726638859265.9650403719214;
 Sun, 18 Jan 2026 00:57:18 -0800 (PST)
Date: Sun, 18 Jan 2026 08:56:59 +0000
From: Yao Zi <me@ziyao.cc>
To: Yixun Lan <dlan@gentoo.org>, Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com,
 Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Samuel Holland <samuel@sholland.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH 06/17] dts: k1: import dts file from upstream folder
Message-ID: <aWygW3_b9P3MyknW@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-7-raymondmaoca@gmail.com>
 <20260117230357-GYA47382@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117230357-GYA47382@gentoo.org>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aWygW3_b9P3MyknW@pie>+zmo_0_me@ziyao.cc
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

On Sun, Jan 18, 2026 at 07:03:57AM +0800, Yixun Lan wrote:
> Hi Raymond,
> 
> On 14:01 Sat 17 Jan     , Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> > 
> > Import K1.dtsi from upstream folder.
> > 
> Can you explore the possibility of using OF_UPSTREAM?
> which should get rid of this copy & paste

This is probably impossible with the current in-tree reset driver, since
it follows a different devicetree ABI.

> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> 
> -- 
> Yixun Lan (dlan)

Regards,
Yao Zi
