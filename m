Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF5DC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 13:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC65833DB;
	Thu, 17 Jul 2025 15:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AmiCvHlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAAE8331F; Thu, 17 Jul 2025 15:08:45 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814A78331F
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 15:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HD7S8B485268;
 Thu, 17 Jul 2025 08:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752757648;
 bh=nsyg8TWytJZ/S1BeeO6muRVSNtIq9VU+wfODApNM+hQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AmiCvHlmGnU0oIH0nDNaMMXR43f+P6ZnN5WW/xVGpNwnvTo63MMiq69D44MCMfoyC
 jblWYuhBmMWoJGzD5FnAZ14VFBfv785mzWMEgTlruwq5QTmEiyY0AL1tLq34PNN86e
 5TbKnewDyrcdCvrY3uYAlDoEVrcFzGM3z2LMMtZc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HD7SwC243017
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 17 Jul 2025 08:07:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 08:07:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 08:07:27 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HD7RpN2213598;
 Thu, 17 Jul 2025 08:07:27 -0500
Date: Thu, 17 Jul 2025 08:07:27 -0500
From: Bryan Brattlof <bb@ti.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Aaron Williams <awilliams@marvell.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Hugues Kamba Mpiana
 <hugues.kambampiana@arm.com>, Ben Horgan <ben.horgan@arm.com>, Adam Ford
 <aford173@gmail.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Anand Gore <anand.gore@broadcom.com>, "William
 Zhang" <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, Linus Walleij
 <linus.walleij@linaro.org>, Thomas Fitzsimmons <fitzsim@fitzsim.org>,
 "Michael Trimarchi" <michael@amarulasolutions.com>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Sergey Temerkhanov <s.temerkhanov@gmail.com>,
 Marek Vasut <marex@denx.de>, Gilles Talis <gilles.talis@gmail.com>, "Tuomas
 Tynkkynen" <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Stefano Babic <sbabic@nabladev.com>, "Fabio
 Estevam" <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Peng Fan" <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, Eric Nelson
 <eric@nelint.com>, Peter Griffin <peter.griffin@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>, Sam Shih <sam.shih@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Fabien Parent <fparent@baylibre.com>, Stanley Chu
 <yschu@nuvoton.com>, Jim Liu <JJLIU0@nuvoton.com>, Tianrui Wei
 <tianrui-wei@outlook.com>, Garrett Giordano <ggiordano@phytec.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, liuhao <liuhao@phytium.com.cn>, shuyiqi
 <shuyiqi@phytium.com.cn>, lixinde <lixinde@phytium.com.cn>, weichangzheng
 <weichangzheng@phytium.com.cn>, Nobuhiro Iwamatsu
 <iwamatsu.nobuhiro@renesas.com>,
 Paul Barker <paul@pbarker.dev>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Sean Anderson <seanga2@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, "Huan
 Zhou" <pericycle.cc@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>, Dillon Min
 <dillon.minfei@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, "Jayesh
 Choudhary" <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Francesco Dolcini" <francesco.dolcini@toradex.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Anastasiia Lukianenko
 <anastasiia_lukianenko@epam.com>, Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>, Michal Simek <michal.simek@amd.com>,
 "open list" <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] treewide: Remove empty board_init() function from all
 boards
Message-ID: <20250717130727.5phynk5x53eubngx@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250717024426.26953-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250717024426.26953-1-semen.protsenko@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 17 Jul 2025 15:23:58 +0200
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

On July 16, 2025 thus sayeth Sam Protsenko:
> Commit 86acdce2ba88 ("common: add config for board_init() call")
> introduced CONFIG_BOARD_INIT option. This option can be disabled for the
> boards where board_init() function is not needed. Remove empty
> board_init() calls for all boards where it's possible, and disable
> CONFIG_BOARD_INIT in all related defconfigs.
> 
> This cleanup was made semi-automatically using these scripts: [1].
> 
> No functional change, but the binary size for the modified boards is
> reduced a bit.
> 
> [1] https://github.com/joe-skb7/uboot-convert-scripts/tree/master/remove-board-init
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

This appears to work for the TI's K3 boards

Tested-by: Bryan Brattlof <bb@ti.com>

~Bryan

