Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025FBFEFB5A
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FC983E76;
	Fri, 27 Feb 2026 16:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B808883E81; Fri, 27 Feb 2026 16:20:50 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5992D83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 42DE068B05; Fri, 27 Feb 2026 16:20:46 +0100 (CET)
From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH 0/9] ARM: RPi5: Enable PCIe
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Message-Id: <20260227152046.42DE068B05@verein.lst.de>
Date: Fri, 27 Feb 2026 16:20:46 +0100 (CET)
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

Hi Peter,

here is a rework of the RPi5 PCIe changes, hopefully the way you
requested. This first series only enables the BCM2712 root complexes
and allows for PCI enumeration. In order to be useful besides any
already-supported PCIe hardware in a generic adapter, at least one
serious NVMe fix is needed, as well as some device tree trickery,
which I'll both follow up with in order to demonstrate the
functionality.

	Torsten

