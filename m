Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890F8CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070AD83AA4;
	Wed,  5 Nov 2025 17:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5139683AAB; Wed,  5 Nov 2025 17:35:59 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B5B83936
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 15F2A227AAC; Wed,  5 Nov 2025 17:35:53 +0100 (CET)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
    Elaine Zhang <zhangqing@rock-chips.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
    Heiko Stuebner <heiko@sntech.de>, Huan Zhou <me@per1cycle.org>,
    Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jan Čermák" <sairon@sairon.cz>,
    Jerome Forissier <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
    Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
    Kever Yang <kever.yang@rock-chips.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
    Marek Vasut <marek.vasut+renesas@mailbox.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
    Patrick Delaunay <patrick.delaunay@foss.st.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
    Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
    Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
    Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Quentin Schulz <quentin.schulz@cherry.de>,
    u-boot@lists.denx.de
Subject: [RESEND PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Message-Id: <20251105163553.15F2A227AAC@verein.lst.de>
Date: Wed,  5 Nov 2025 17:35:53 +0100 (CET)
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

Hi all,

here is the requested resend of the first mini-series with the fixes,
now hopefully with all interested people involved. I regenerated it
using get_maintainer.pl on part1 and part2, for the heads-up.
I also added Oleksii's refreshed review tag.

Part2 takes actually longer to rework than expected; documentation on the
PCIe bridges is not so opulent, mildly speaking.

This set should apply cleanly on 2025.10 and on master [1c250e444ad].

	Torsten
