Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CDDC38147
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 08:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560B187A68;
	Sat, 16 Dec 2023 09:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Qkv6qGGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7315D87AD2; Sat, 16 Dec 2023 09:12:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6115387620
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3C974400F2; 
 Sat, 16 Dec 2023 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702714329;
 bh=7EyoBuJUfEBJkaSHfiGtl0xDCKyjRBdgnULcjGsc7mE=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Qkv6qGGBdPbNqpIwusr+UjHkODmnqylwyp0HBAiSvGFmbnmuL5eTT3O+PWmbiavpj
 kXl4Lm7UB66KWti47Xy1aB7po3vzoFOjf/Ts67M0mnM9mhO58J3OU9RkE4cO6sC+Z8
 P8NFcEGNXucDlCG2Q2XlY+9d889VXc3QL3YlDUgc24UOzEDRUUVGg2DKHqTg7g2heK
 dZEWoaTO7x6MknDZRFzbOi6s1G8xugksKtRAX+W3riylgUpMlOBCS/cf8gPmU6Dh0i
 xVbmGjTvkRZ9+zFWoCKX/rR13NcGDiIWRnvh3hmzLumc6AoTyyS38gwoSRZD/MYR1H
 HYfPznzPLgTOw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/4] cmd: acpi: correct handling of DSDT and FACS
Date: Sat, 16 Dec 2023 09:11:56 +0100
Message-Id: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Fields X_FIRMWARE and X_DSDT in the FADT table must be 64bit.
Fix the definition in our include.

The 64bit fields X_FIRMWARE and X_DSDT take precedence over the respective
32bit fields. Consider this in the 'acpi list' and 'acpi dump' commands.
The fields only exist for FADT table revision 3 and above.

Don't fill unused fields FIRMWAE and DSDT.

Write an error if the hardware reduce flag is not set for non-x86 systems.

v3:
	fix subject lines of patches 1 and 4
	use map_to_sysmem for pointer to address conversion
v2:
	check FADT table revision
	correct dumping DSDT and FACS

Heinrich Schuchardt (4):
  acpi: use 64-bit addresses in FADT table
  cmd: acpi: fix listing DSDT and FACS
  cmd: acpi: check HW reduced flag in acpi list
  acpi: support 64bit in acpi_find_table for DSDT and FACS

 arch/x86/cpu/baytrail/acpi.c |  9 +++------
 arch/x86/cpu/quark/acpi.c    |  9 +++------
 arch/x86/cpu/tangier/acpi.c  |  9 +++------
 arch/x86/lib/acpi_table.c    |  9 ++-------
 cmd/acpi.c                   | 12 ++++++++++--
 include/acpi/acpi_table.h    |  6 ++----
 lib/acpi/acpi.c              | 29 ++++++++++++++++++++++++-----
 7 files changed, 47 insertions(+), 36 deletions(-)

-- 
2.40.1

