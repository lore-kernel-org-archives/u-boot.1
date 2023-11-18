Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADDAC54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDD887125;
	Sat, 18 Nov 2023 23:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OxvLRyUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8B587083; Sat, 18 Nov 2023 23:54:11 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6112786BFA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 036D33F285; 
 Sat, 18 Nov 2023 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700348046;
 bh=096/bAbZqd66xRyQS52kTCgx/KwhDuSAE84vgOwA/B8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=OxvLRyUNhE+5OYC9s3zI1Z19BBD8drvRUiSaV4h3WhJjly7kGFyHxiEAk2R/getjP
 6gd4qx1U0E7S9C/7diTdb/f1nfqydT3eQN5nsmbCGf4QfGzCP0/xwtxwwQoMmAC02m
 MphQOU7tfo9mk5pVAZKGL8OrmSxZNGKRmzSmfemm0pceujtSSy1mIIg/Vr0Bzx6fbi
 T0vpuDWv45tYzRKdnJXgQohuJfiX7JRYLnz8okI3TrFhzqDGcrI4Tz86En2Vr72kgW
 +Vi3BQ/YA/fYcJKOvRz8I1cQgF/Z5DKNYL2Sp7JD0iSg2nLpJxA/Gjr4tzQ7xsmt3Q
 9KBAOQIfDk9vQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/2] cmd: acpi: fix acpi list command
Date: Sat, 18 Nov 2023 23:52:46 +0100
Message-Id: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
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

The size of the ACPI table header is not a multiple of 8. We have to mark
struct acpi_xsdt as packed to correctly access field Entry.

Add a unit test for the offsets of field Entry in the RSDT and XSDT tables.

ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
to check the presence of the RSDT table before accessing it. This leads to
an exception if the RSDT table is not provided.

The XSDT table takes precedence over the RSDT table.

The return values of list_rsdt() and list_rsdp() are always zero and not
checked. Remove the return values.

Addresses in the XSDT table are 64-bit. Adjust the output accordingly.

As the RSDT table has to be ignored if the XSDT command is present there is
no need to compare the tables in a display command. Anyway the
specification does not require that the sequence of addresses in the RSDT
and XSDT table are the same.

The FACS table header does not provide revision information. Correct the
description of dump_hdr().

Adjust the ACPI test to match the changed output format of the 'acpi list'
command.

v3:
	consider map_sysmem(0, 0) != NULL on the sandbox
	adjust signature of list_rsdt() and list_rsdp()
v2:
	merge patch 2 and 3
	remove leading zeros from address output

Heinrich Schuchardt (2):
  acpi: fix struct acpi_xsdt
  cmd: acpi: fix acpi list command

 cmd/acpi.c                | 67 +++++++++++++++++++++------------------
 include/acpi/acpi_table.h |  2 +-
 test/dm/acpi.c            | 28 ++++++++++------
 3 files changed, 56 insertions(+), 41 deletions(-)

-- 
2.40.1

