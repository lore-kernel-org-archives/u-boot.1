Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A12CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7A4831D6;
	Mon, 11 Aug 2025 18:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="YNPX46wH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3E9831D6; Mon, 11 Aug 2025 18:11:14 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEE3831BE
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=zP14iCqM4PnoniOhXjUndp4kJt6ih1R1oLj75lG2j2Y=;
 b=YNPX46wHOgTnC/Or8w+4pT5WVKerAoVnUX+17PTVhbsN9ZfiRxMQIXLW8xINL7gzHkmAkCVOG5EFq6WdUm6SFNsCjMp9zfbl16xNawoRgH8sUUnndhzufOzYCkUGKql/6wFgr/Fb4lU77AcgJv8qGyME/EKgElmqxzmk6qKKPoU=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Mon, 11 Aug 2025 18:11:10 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] sunxi: support signed images in SPL without SPL_DM
Date: Mon, 11 Aug 2025 18:10:32 +0200
Message-Id: <20250811161035.2703435-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds support for signed SPL/U-Boot FIT images on Sunxi
platforms and removes the unnecessary SPL_DM dependency for RSA
verification.

Patch 1 allows FIT signature verification in SPL to work on boards
that do not enable SPL_DM by falling back to the software RSA
implementation when no hardware modular exponentiation driver is
available.

Patch 2 extends sunxi-u-boot.dtsi to add conditional nodes for
hashes and signatures, following the same approach used in the
Rockchip u-boot.dtsi.  This enables secure boot flows where SPL can
verify U-Boot and associated binaries before handing over control.

Tested on a Sunxi board with CONFIG_SPL_FIT_SIGNATURE enabled and
SPL_DM disabled, verifying a signed U-Boot image successfully.

Lukas Schmid (2):
  rsa: allow operation without SPL_DM by falling back to software
  sunxi: u-boot.dtsi: add support for signed SPL and U-Boot images

 arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++++--
 boot/Kconfig                   |  2 +-
 lib/rsa/rsa-verify.c           |  4 +-
 3 files changed, 67 insertions(+), 7 deletions(-)

-- 
2.39.5


