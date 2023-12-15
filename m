Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87898C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C9D87BEE;
	Fri, 15 Dec 2023 17:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GTIiLDMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72CF87C21; Fri, 15 Dec 2023 17:40:25 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D156987BEC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 17:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 06D473F5DF; 
 Fri, 15 Dec 2023 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702658423;
 bh=t8Vsc3q0uHvO2DMc8AV3u9DEfR6zMik6CegP5rblUWU=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=GTIiLDMaDjsqgag0kdrasW812tNQNDSMNOBo9NNBc9PN8b1SxreRErsMdx4k3+2gG
 t0/8XpdDJbB9vxiE+iZ1Nd9yPruTn6rGw63usU7qRKka5Lzr8P4BfQX0dvWgdNvmk0
 Q6iv0Ve/6tpwRVmL4yEtlTLiK6YNLYRBnwDxiY8Mcdk5rmwTC3NO2HImtHiiZjeNbE
 aRD694arkJVhGudLxvP77JC7lKkdy1g/CdOYLs679PGndZHmqogF1y8cziYeiJnEEt
 PzZYhd6XpwzwCn01UixfgK4sPKSbIj1KoW4tDma3nRRqGwbDl9C2zS9F/2s967Ymr1
 ybw+59uOxWPIw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] cmd: acpi: fix list_fadt()
Date: Fri, 15 Dec 2023 17:40:13 +0100
Message-Id: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
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
32bit fields.

Don't fill unused fields FIRMWAE and DSDT.

Write an error if the hardware reduce flag is not set for non-x86 systems.

Heinrich Schuchardt (3):
  acpi: fix FADT table
  cmd: acpi: fix listing DSDT and FACS
  cmd: acpi: check HW reduced flag in acpi list

 arch/x86/cpu/baytrail/acpi.c |  8 ++------
 arch/x86/cpu/quark/acpi.c    |  8 ++------
 arch/x86/cpu/tangier/acpi.c  |  8 ++------
 arch/x86/lib/acpi_table.c    |  9 ++-------
 cmd/acpi.c                   | 12 ++++++++++--
 include/acpi/acpi_table.h    |  6 ++----
 6 files changed, 20 insertions(+), 31 deletions(-)

-- 
2.40.1

