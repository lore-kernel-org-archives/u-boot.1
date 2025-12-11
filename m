Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757E1D41D58
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 15:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62908839E8;
	Thu, 11 Dec 2025 16:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="UyLcgXJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983E38389A; Thu, 11 Dec 2025 16:31:00 +0100 (CET)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F736835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 16:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765467052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d8Syjthhi6f4g+ZUqaQk6KvJXVdBOtGoRJrcxPqoc1k=;
 b=UyLcgXJLaBUxEJrcTU96k9/aiWbRzf7FQRYcPSSJ1O3BzvamXrViLUjAvrGYOvJhpKAXh7
 R2wMF/keSmkqO13F02CrpagRzFHoVzrixsXsxfDWj9BAjkRS5CYszNfpYWdaWfWHqaowrS
 OVZQ55nKKjXd973wGRUYMUZMIRJf8KnZgVga41agH4/Za5qM7Zdm5fB2fUEGHR3+brjF8b
 /Ly9qdxeax4HTa/HJC4D1lE9gpUIrLoBT/VFgAXU1//02hA4oZiEJWypvaOeUvQffSunFN
 RPeTC9ODayzzBi9aVStljoJX95KiwI+uau323v7ZowwKXVvqJYUycWo8X2zM9g==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v3 0/2] Support EFI capsule updates across Amlogic boards
Date: Thu, 11 Dec 2025 15:30:40 +0000
Message-Id: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDjOmkC/3XMQQ6CMBCF4auQrq3pFArWlfcwLkodoFEo6WCjI
 dzdwsoYXf4ved/MCINDYsdsZgGjI+eHFPkuY7YzQ4vcXVMzKaQCISreI/mBWzPS447cgFa5RmF
 UgSx9xoCNe27e+ZK6czT58Nr4COv6T4rAgZdQqaaqC9toPI2ept6EG06e9j60bAWj/EAAvhGZE
 JWbQ42l0sr+QpZleQMOxq4h9gAAAA==
X-Change-ID: 20251007-meson-capsule-a19539e0a54e
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=sPlCRoXdB7zx+wHiXJ8/Q1cHN5lYdxSCXJx7QlHZTQk=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuOkkQ4LAPSB47hKx5sMUOfqfDUdt37HCBYAe
 T1ArqgDQ4OJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrjpAAKCRCEr8vQ14ma
 A31PD/4mdwTiTj73jfnHmVPTO+7WPQ+QdSDWCkMRmoB1Y2WFGQ3c9r8dOvHDscNVUtfToeYvHkk
 zdnMLLuuJPHjxNKFXEg/j4JFXb+NDN0w6EVXGd/vUJsKAfrZsaChVtJJ/poseyj7VOqvSsRIpkF
 WkMHAuVYw8m6cVYg2h4oIUQfqVkha1bsAO0j593ZJtbnzDETSV1dzL+3HapYxAFZpQE4/9bx1KO
 o+9wPg6Gq0pSrFlTvo7GBqyKywnT/SYRSIRYOt613Ro1SGPbhzt+PSmbNbStwu30DROp2PCevy8
 POHhq7DEpwYvJoyLi+dF2x0yLQtEX0YtwccUYxnqMXXMJZUq61TqGVUv6Qn5TONn4IA//baF0aY
 jObqJMu0+T7hH5Ium/wMqQ3hgfCDR6rubFrXpQHscFRCuAj8GekZeoD5KivSjalbcJnq2KStGrA
 YdFCF+KIB1lVz8TsGZB5W2+HBBOHU/V1ZlNTmttnG+UYywNmcjEa1008c/4kAX0LJV5MBB7SGxr
 LLvB5z7TEtGGuu7dW4ayUvMefltZx4/tppwaXXgVL76+sNWlOxwhPugs7GVpCkAyTMs40oyQ6/7
 0Lheyj9oDHBrRI+Vdp2eMoP5BLRwVBvBe5t3WBBZ6CHBXZZz1Y1hLzqASMmrqqviano8HZwYEXo
 YbsGhDj8wOaj+9Q==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Currently EFI capsule updates are only supported on the following
Amlogic-based boards:

 - Libre Computer AML-S805X-AC
 - Libre Computer AML-A311D-CC
 - Libre Computer AML-S905D3-CC

This is done with board-specific configuration in board/libre-computer/.

With this patch, EFI capsule updates can now work on most of the other
Amlogic boards supported by u-boot, such as the Libre Computer
AML-S905X-CC, without the need for board-specific configuration
beforehand.

Please note that flashing to the eMMC bootX partitions is not yet
supported.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v3:
 - Remove board-specific Libre Computer EFI capsule support and use the
   common EFI capsule support code
 - Link to v2: https://lore.kernel.org/r/20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org

Changes in v2:
 - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
   are enabled
 - Coding style fixes
 - Return when boot device is unsupported
 - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org

---
Ferass El Hafidi (2):
      arm: meson: add support for EFI capsule updates
      board: libre-computer: use common Amlogic EFI capsule support

 arch/arm/include/asm/arch-meson/boot.h             |  2 +
 arch/arm/mach-meson/Makefile                       |  2 +-
 arch/arm/mach-meson/board-common.c                 |  5 ++
 arch/arm/mach-meson/capsule.c                      | 61 ++++++++++++++++++++++
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 14 -----
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 13 -----
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 14 -----
 7 files changed, 69 insertions(+), 42 deletions(-)
---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20251007-meson-capsule-a19539e0a54e

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>

