Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737B6C83F16
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71A186B2C;
	Sat, 26 Aug 2023 11:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4E186B2C; Sat, 26 Aug 2023 11:07:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 96B2086AFE
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DDBB1FB;
 Sat, 26 Aug 2023 02:07:40 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 179653F740;
 Sat, 26 Aug 2023 02:06:57 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Date: Sat, 26 Aug 2023 14:36:28 +0530
Message-Id: <20230826090633.239342-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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


Provide a way for removing certain devicetree nodes and/or properties
from the devicetree. This is needed to purge certain nodes and
properties which may be relevant only in U-Boot. Such nodes and
properties are then removed from the devicetree before it is passed to
the kernel. This ensures that the devicetree passed to the OS does not
contain any non-compliant nodes and properties.

The removal of the nodes and properties is being done through an
EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
behind any Kconfig symbol.

I have only build tested this on sandbox, and tested on qemu arm64
virt platform. This being a RFC, I have not put this through a CI run.

Sughosh Ganu (5):
  dt: Provide a way to remove non-compliant nodes and properties
  fwu: Add the fwu-mdata node for removal from devicetree
  capsule: Add the capsule-key property for removal from devicetree
  bootefi: Call the EVT_FT_FIXUP event handler
  doc: Add a document for non-compliant DT node/property removal

 cmd/bootefi.c                                 | 18 +++++
 .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
 drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
 include/dt-structs.h                          | 11 +++
 lib/Makefile                                  |  1 +
 lib/dt_purge.c                                | 73 +++++++++++++++++++
 lib/efi_loader/efi_capsule.c                  |  7 ++
 7 files changed, 179 insertions(+)
 create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
 create mode 100644 lib/dt_purge.c

-- 
2.34.1


