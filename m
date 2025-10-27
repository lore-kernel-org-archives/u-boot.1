Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4103BCCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 14:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 318AF83710;
	Mon, 27 Oct 2025 15:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="reEfIQC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB51F82E34; Mon, 27 Oct 2025 15:17:22 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FED8352B
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 15:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59REHDMN2425071;
 Mon, 27 Oct 2025 09:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761574633;
 bh=HZTn04S0LhBCrORhOYoKwlgqjrEDRjm3S7t6sgT+PEw=;
 h=From:Subject:Date:To:CC;
 b=reEfIQC7H4GV/uyYY9wOPAEl08te8OPVrtkEdx6gA/wku0oa1TEtEzBCSdmRA+d4r
 GEl+JM4wBU2hMK4eX7mMCZatVF/NwoXDJdpTuZvyUnLM3CoKePaRhyCrM0t/r+gWUT
 IZA/y/h3G1KE0xX3oVjWLqsS8KwAJIkgNFv672tQ=
Received: from DFLE215.ent.ti.com (dfle215.ent.ti.com [10.64.6.73])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59REHDjv1035774
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 09:17:13 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 09:17:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 09:17:12 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59REHBcK791161;
 Mon, 27 Oct 2025 09:17:12 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH v10 0/2] Remove usage of CMD_BOOTx from SPL code
Date: Mon, 27 Oct 2025 19:47:01 +0530
Message-ID: <20251027-fix_cmd_bootx-v10-0-10487e907710@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1+/2gC/12Py27DIBBFfyViXaLhZSCr/kdVRRgPNVJtUiBWq
 sj/XuKmUZXlPM7RvVdSMEcs5LC7koxLLDHNbWDwsiN+dPMH0ji0BeHAFQMuaIiXo5+GY59SvVC
 Ljg2dDWBQkMacMraHTfj23uaQ00TrmNE9LCDBMMmk6PaacWE0ZdTNZTx/Dq817n2a7qKMX+cWq
 P7aSO8K0nadYj3sLFgpDfdOK90ZrXveB+eU9ga18AF7JbpgektuIcZYasrfW8nFbLJ7HflUZzE
 UKBcQNHiFKpi/RDfNYv+j6hm1DR28D+AcKKPDA13X9QckWsS1aAEAAA==
X-Change-ID: 20251023-fix_cmd_bootx-9ea1d69f08e3
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Vignesh R
 <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761574631; l=3502;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=tU+QEYl0Kh0sDNqcfikhZxRQbxbs3NChPVPThonRPNQ=;
 b=2GYeajvePnEvplb/nKJnwe62IbORq8ZT8Or++1+oDA//faguCRgfoMxpNgJXNDZIEq2MeQSxX
 LpSX6EVO2JUDtwr8HsznFCx297WBORSNZn+jylhnSR+47dWwUU48A9e
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi all,

We currently make use of CMD_BOOTI and CMD_BOOTZ in the SPL boot flow in
falcon mode, this isn't correct since all CMD_* configs are only meant
for U-Boot proper and not the SPL.

Therefore this patch set adds new LIB_BOOT[IMZ] configs that allow for
more granular selection of their respective compilation targets.

Additionally, this also allows us to more easily disable support for
raw images from secure falcon mode (SPL_OS_BOOT_SECURE) by doing the
following:

  config LIB_SPL_BOOTI
    ...
    depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
    ...

Regards,
Anshul

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v10:
- Remove unused CONFIG_XPL_BUILD check around $(PHASE_)LIB_BOOTM
- Link to v9: https://lore.kernel.org/r/20251025-fix_cmd_bootx-v9-0-dccf0aa0587f@ti.com

Changes in v9:
- Update commit message in the patch [1/2] to reflect updated symbol names
- Use CONFIG_LIB_$(PHASE_)_BOOTM in arm/lib/Makefile
- Link to v8: https://lore.kernel.org/r/20251024-fix_cmd_bootx-v8-0-230f70c5e5f8@ti.com

Changes in v8:
- Use CONFIG_$(PHASE_)LIB_BOOT[IMZ] instead
- Drop the patch migrating falcon configs
- Drop the patch for colibri_vf
- Link to v7: https://lore.kernel.org/u-boot/20250408141436.712387-1-anshuld@ti.com/

Changes in v7:
- Change SPL configs from SPL_HAS_* to SPL_*
- Change library symbol names from LIB_BOOTx to just BOOTx
- Add BOOTM for compiling boot.c
- Link to v6: https://lore.kernel.org/u-boot/20250403215522.1284502-1-anshuld@ti.com/

Changes in v6:
- Add LIB_BOOTx library symbols
- Update existing configs ensuring no change in size or build failure
- Link to v5: https://lore.kernel.org/all/20250314035505.4029331-1-anshuld@ti.com/

Changes in v5:
- Remove imply clause for CMD_BOOTZ instead add default y for SPL_HAS_BOOTZ
- Update commit message to reflect the changes
- Remove 'More info' link
- Link to v4: https://lore.kernel.org/u-boot/20250313032842.1189977-1-anshuld@ti.com/

Changes in v4:
- Don't set SPL_HAS_BOOTI for sandbox by default
- Updated prompts for SPL_HAS_BOOT[IZ]
- Removed check for SPL_HAS_FRAMEWORK from Makefile
- Link to v3: https://lore.kernel.org/u-boot/20250312124757.789013-1-anshuld@ti.com/

Changes in v3:
- Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
- Fix broken check for bootz_setup
- Link to v2: https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com/

Changes in v2:
- Add SPL_HAS_BOOT[IZ] configs
- Link to v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/

GitHub CI: https://github.com/u-boot/u-boot/pull/757

---
Anshul Dalal (2):
      spl: remove usage of CMD_BOOTx from image parsing
      configs: disable SPL_BOOTZ to preserve spl size

 arch/arm/lib/Makefile                | 10 ++++------
 arch/riscv/lib/Makefile              |  4 ++--
 boot/Kconfig                         | 18 ++++++++++++++++++
 cmd/Kconfig                          |  5 +++++
 common/spl/Kconfig                   | 16 ++++++++++++++++
 common/spl/spl.c                     |  5 +++--
 configs/imx28_xea_defconfig          |  1 +
 configs/imx6qdl_icore_mipi_defconfig |  1 +
 configs/imx6qdl_icore_mmc_defconfig  |  1 +
 configs/imx6qdl_icore_rqs_defconfig  |  1 +
 10 files changed, 52 insertions(+), 10 deletions(-)
---
base-commit: 9094482ca7576877b2bfaa57c8e73cfeb536f8b9
change-id: 20251023-fix_cmd_bootx-9ea1d69f08e3

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

