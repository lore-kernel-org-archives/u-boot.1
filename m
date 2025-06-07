Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AFDC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43DC982C0C;
	Sat,  7 Jun 2025 14:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="PoD+9C4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0605381F0D; Sat,  7 Jun 2025 11:12:00 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F79582998
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=KTIvwc+1R1PJiWe5Kfw1H/KAhZ/jXnkv4sNp9X9ExzI=;
 b=PoD+9C4Q2+Ox9VLVE32z7DawHHxX3MAvpIo+pwtM2d6aXTegRNiCG74Q2bjINfvtXGc+WQfDSB183odmyFqLMQcKSnhR0JKNU+Nz4pnpS4ZY6R+quK6h/qTII/e4F1FYeBkmiKrAnLh4gB6tFJOYQhyZynW+825KkdPow/fD9ME=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Sat, 7 Jun 2025 11:11:47 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH 0/2] sunxi: Add NetCube Systems Kumquat support and fix nvmem
 MAC handling
Date: Sat,  7 Jun 2025 11:11:38 +0200
Message-Id: <20250607091141.439318-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Jun 2025 14:23:24 +0200
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

This series adds a defconfig for the NetCube Systems Kumquat and fixes
and issue with setup_environment ignoring the mac-address loaded using
nvmem-cells

Note: This series is based on U-Boot's `next` branch because it depends
on the `sun8i-v3s-netcube-kumquat.dts` device tree, which was recently
synced from upstream Linux and is not yet available in `master`.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
Lukas Schmid (2):
  sunxi: setup_environment: do not generate a MAC address when one is
    set using nvmem-cells
  configs: add support for NetCube Systems Kumquat

 board/sunxi/board.c                         | 15 +++++-
 configs/sun8i_v3s_netcube_kumquat_defconfig | 57 +++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 configs/sun8i_v3s_netcube_kumquat_defconfig

-- 
2.39.5


