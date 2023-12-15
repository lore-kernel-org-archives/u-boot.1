Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C44C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8E087C44;
	Fri, 15 Dec 2023 19:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GZqXKlv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E628287C3E; Fri, 15 Dec 2023 19:27:10 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BA287BF3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 084AB3FADA; 
 Fri, 15 Dec 2023 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702664828;
 bh=HQMbnh4VrZp9lV/fq2vYm2F5tjvhh2FaaF7JiNeGSxw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=GZqXKlv1jROxLkuRrL5SJBhMwhH3Pv3xLqXX4oS77t4HlbyQ/HLdyjd+35TmZxdFv
 oVqMZz9rcjo7c/uiS2mjVvYt8UpdIvYKsjPwSzBI9Wavic0eiOoLpi3MA1JWQ3DFEZ
 dtIRlK9GIavbo9ft8BvGF3FvYPFSXMAIIHkFInY3bboERRnF+F1K2nIJOONbJYQ0AW
 IgdIRFS9yCcOdKne0ZWhVrw8J6sTHbhdHHygXyZDMbGqmIg9Gs6XWuXTpmrh6oh3No
 2N5WceAdYMM5xeujP1HlMhLFmvpeLy0lWstieCVZMDQuwWBhO+5q83oFtHOogyidBx
 or/K51NjwpIYg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] cmd: acpi: correct handling of DSDT and FACS
Date: Fri, 15 Dec 2023 19:26:54 +0100
Message-Id: <20231215182658.187516-1-heinrich.schuchardt@canonical.com>
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

v2:
	check FADT table revision
	correct dumping DSDT and FACS

Heinrich Schuchardt (4):
  acpi: fix FADT table
  cmd: acpi: fix listing DSDT and FACS
  cmd: acpi: check HW reduced flag in acpi list
  aci: fix acpi_find_table() for DSDT and FACS

 arch/x86/cpu/baytrail/acpi.c |  8 ++------
 arch/x86/cpu/quark/acpi.c    |  8 ++------
 arch/x86/cpu/tangier/acpi.c  |  8 ++------
 arch/x86/lib/acpi_table.c    |  9 ++-------
 cmd/acpi.c                   | 12 ++++++++++--
 include/acpi/acpi_table.h    |  6 ++----
 lib/acpi/acpi.c              | 29 ++++++++++++++++++++++++-----
 7 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.40.1

