Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3F7C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 17:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217A184A29;
	Sun, 19 Jul 2026 19:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="MgJvWCZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237A284A29; Sun, 19 Jul 2026 19:53:47 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5858494B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 19:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784483620; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VzuDtIDGIKA2W+wEgjCiEC/kQOMVitInIgw79a6C/xt1Buk2TFiTYJI7uAYb9P9qWAxyK9Ao0GetQm3oWisE+KsCcme/JiFVtJv/AKutaI9Lhjm4Nn8G2SX3C8j3SaclZ3INeYVlFFozP/nLgUb85AQKpRgLuDm44bj3g8lEJY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784483620;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/nv1k4OJRqwemeui7G6rCWXgHnslzkUaCGtJWiXwYb8=; 
 b=YBq11M2Id3EklZT+mU2+yT510tOebb5WtnXnHas7BsC8PICLxzZ6aAtPhqcpmQzMkXb/A51TON+SDvhmD1ExdJWwSERZBVkJyHAJjxjImFti2VZn/99s6DVtxsMyfriC5vH/wdAmA2brjDKDQgYOA53CH8tpoiwO4aLwa8yDfvc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784483620; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=/nv1k4OJRqwemeui7G6rCWXgHnslzkUaCGtJWiXwYb8=;
 b=MgJvWCZXhLcZqB4/xumVFCxzdQCJ4nVaPFu+/KiL7mpuumOXEj60p6x1YNTL20cy
 SGo2uGDabBDbqAZ31qrqA7KZMtVm89hK6WF9BIC3oMydLX9vnRs5rlUufSSmZovNbH5
 wPGgJxCCFToVb40f1xf4JWtUiyasNfrP9vN8Kkwc=
Received: by mx.zohomail.com with SMTPS id 1784483617158497.30191750799645;
 Sun, 19 Jul 2026 10:53:37 -0700 (PDT)
Date: Sun, 19 Jul 2026 17:53:25 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v4 05/10] dts: k1: add SD card support in u-boot overlay
Message-ID: <al0PFUe2sanNhJEn@pie>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-5-dbd01185f911@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-m4-v4-5-dbd01185f911@riscstar.com>
X-ZohoMailClient: External
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

On Tue, Jul 07, 2026 at 11:21:46PM +0800, Eric Chung wrote:
> Add the SDH0 controller node and its pinctrl groups to the u-boot
> overlay. The upstream DTS only contains the eMMC node; the SD card
> controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
> missing. Place the new node inside the storage-bus via path-based
> merge so it inherits the dma-ranges from the parent bus.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v3:
> - Fix SD pinctrl as uhs.
> v2:
> - Use vmmc-supply as vqmmc-supply on SD node.
> - Add alias of mmc0 and mmc1.
> ---
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 87 ++++++++++++++++++++++++++++++-
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 82 ++++++++++++++++++++++++++++-
>  2 files changed, 165 insertions(+), 4 deletions(-)

Please note SD-card-related devicetree changes for BPI-F3 and MusePi Pro
have been landed in devicetree upstream, and you should be able to pick
them with tools/update-subtree.sh.

Regards,
Yao Zi
