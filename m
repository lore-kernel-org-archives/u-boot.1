Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E51CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 10:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F0382C84;
	Mon, 20 Oct 2025 12:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="CrjGsGvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6870382E34; Mon, 20 Oct 2025 12:53:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED60807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 12:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AA43F260AF;
 Mon, 20 Oct 2025 12:53:24 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mrfk6OXmVJtn; Mon, 20 Oct 2025 12:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760957603; bh=vTp2orJ8Wi01yeRRKXyKmXNZhuh6DBnQedw5WBikeMU=;
 h=Date:From:To:Cc:Subject;
 b=CrjGsGvBpmHCFvkYXZXwrAFxnLEsgE20HI0ApDXVp9QqUaucsyPHtaCsXEOyNMhvo
 /TWeH/qlvTPPIVa1BJJlKDvcxU3jIKk6mYAi7YWVhw4uqDZI6lsFsVjWP7upIxfBPD
 IDBqCSrPRxXbehbC2PquNg6JVE5mhapiBhNg8jQmGcZ3T6YG48Fw+Hn5wLYKQCBEAD
 lRCFCOVe/K1adKHRpJwJkroY2Wyd6Z1BOiDyeutthHHx3C+LfnjuVdH7+n8wp9EfJg
 8Ouiz8B0fsFmgIHEBViIpaR/F/G+s+CwisGgWz1AdZxQrNp3bAlczbz4gSRQO79bZ+
 MbKzNmeAjF2iA==
Date: Mon, 20 Oct 2025 10:53:11 +0000
From: Yao Zi <ziyao@disroot.org>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>
Subject: Booting from SD-card on StarFive VisionFive 2 is broken in master
Message-ID: <aPYUlyni65Ux8xpq@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi there,

While testing the behavior of my previous patch on JH7110 platforms,
it's found that StarFive VisionFive 2 fails to boot from SD-card with
current U-Boot master "a58089ad2e4 (fs: semihosting: Use correct
variable for error check, 2025-10-02)" with messages like

	U-Boot SPL 2025.10-00669-ga58089ad2e41 (Oct 20 2025 - 10:29:30 +0000)
	DDR version: dc2e84f0.
	Trying to boot from MMC2
	spl: partition error
	Error: -38
	SPL: failed to boot from all boot devices
	### ERROR ### Please RESET the board ###

Bisecting shows the failure is introduced by commit 27f617019dd (riscv:
dts: starfive: prune redundant jh7110-common overrides, 2025-09-16),
where the U-Boot devicetree overrides are removed since these have been
in the upstream devicetree.

However, this is not totally true: for mmc0_pins, mmc1_pins, i2c5_pins
and their subnodes, the bootph-pre-ram properties aren't present in the
upstream 6.16 devicetree, and a simple removal seems to break SD card
initialization on StarFive VisionFive2 in SPL stage.

A simple (but obviously not acceptable as it modifies files in
dts/upstream) patch could be found here[1]. Manually adding the
bootph-pre-ram properties back to mmc1_pins and its children fixes the
booting process.

I don't think it's good idea to revert the problematic commit since
several follow-up commits depend on it. Maybe we could bring the
overrides back to arch/riscv/dts/starfive-visionfive2-u-boot.dtsi?

Best regards,
Yao Zi

[1]: https://gist.github.com/ziyao233/0bcce16753b3956a30113cf41631e720
