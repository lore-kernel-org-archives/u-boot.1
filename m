Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58201C5475B
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F7F87F0D;
	Sun,  3 Mar 2024 14:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EWCBENF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 225D487F0C; Sun,  3 Mar 2024 14:01:29 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139BF87CDB
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 241363F280; 
 Sun,  3 Mar 2024 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709470885;
 bh=c/MOiLwoH8JzVoooQC0IJQu36Bs8Wry7Rh5HOnCxLX8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=EWCBENF6pLIONcO7yIYm4KmM0ZQZy3J2yU9b/Cpm3a3bRpUvHJZbfUT6yYKNKWg3L
 BNWc5KMjzU7TYFFa7WOOCRrMQwtFDlT37Kz2BFjgEQygXnxGHakld4ui6xZQYlhzHj
 FY7zZPl5Me3rkuS6BzdOlmmK/PgX1abW88JVbe1tIv7jE39en9zGjqJAhLa4O9lAHd
 92mY4vr3EvtGRM6nDdK0W1jtmQttMVbhWpUuJrKijcoyxB3XOIHULZI1kCJpOABKvA
 orHJbu/F+0VkF+TTDTa+zoqiOP5wGLP5OvVDqrTd4eGtq6uPTXIM22YC8J6JeY0WMm
 /iXgM+NaxB+PQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 0/5] riscv: add support for Milk-V Mars board
Date: Sun,  3 Mar 2024 14:01:17 +0100
Message-ID: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The Milk-V Mars board is technically very close to the StarFive
VisionFive 2 board.

With this patch series the VisionFive 2 U-Boot SPL will detect that it
is runing on a Milk-V board and patch the device-tree accordingly.
This is the same approach that has been taken to handle the differences
between the Visionfive 2 1.2B and 1.3A revisions.

An alternative approach would use a separate defconfig and separate board
files. As this would incur a higher effort I chose the SPL approach.

Heinrich Schuchardt (5):
  eeprom: starfive: function get_product_id_from_eeprom()
  riscv: set fdtfile on Milk-V Mars
  board: starfive: support Milk-V Mars board
  riscv: starfive: avoid including common.h
  doc: describe Milk-V Mars board

 arch/riscv/include/asm/arch-jh7110/eeprom.h   |   9 ++
 board/starfive/visionfive2/spl.c              | 102 +++++++++++++++---
 .../visionfive2/starfive_visionfive2.c        |  44 +++++---
 .../visionfive2/visionfive2-i2c-eeprom.c      |   9 +-
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/milk-v_mars.rst            |  93 ++++++++++++++++
 6 files changed, 230 insertions(+), 28 deletions(-)
 create mode 100644 doc/board/starfive/milk-v_mars.rst

-- 
2.43.0

