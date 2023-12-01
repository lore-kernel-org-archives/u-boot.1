Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB17FC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 00:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DDA8774F;
	Fri,  1 Dec 2023 01:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E54587737; Fri,  1 Dec 2023 01:55:26 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id ED0268772B
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 01:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id D9A9B20B74C0;
 Thu, 30 Nov 2023 16:55:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9A9B20B74C0
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: Sean Edmond <seanedmond@microsoft.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <senaedmond@microsoft.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 0/5] Populate kaslr seed with RNG
Date: Thu, 30 Nov 2023 16:54:39 -0800
Message-ID: <20231201005507.2080396-1-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
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


This patch series creates a common API (fdt_fixup_kaslr_seed()) for
populating the kaslr seed in the DTB.  Existing users (kaslrseed,
and ARMv8 sec firmware) have been updated to use this common API.

New functionality has been introduced to populate the kaslr using
the RNG.  This can be enabled with CONFIG_RNG_TPM_SEED.

Changes in v6:
- root_ofnode_from_fdt()->ofnode_root_from_fdt()
- Enclose fdt_rng_kaslr_seed() in "#if defined(CONFIG_KASLR_RNG_SEED)"

Changes in v5:
- include dm/ofnode-decl.h instead of dm/ofnode.h
- cast buffer to (u8 *) in kaslrseed.c
- Always enable OFNODE_MULTI_TREE

Changes in v4:
- Fix compile issue when CONFIG_OF_CONTROL not set

Changes in v3:
- Use event spy to do the FDT fixup
- Populate with RNG device instead of TPM device (this is a more generic solution)
- fix compile error for sandbox for !OFNODE_MULTI_TREE

Changes in v2:
- fdt_fixup_kaslr_seed() uses the ofnode API
- Add root_ofnode_from_fdt() to get the root node from an FDT and
  perform error checking on the oftree
- add comments to exported functions
- Add error checking in image_setup_libfdt() for return from
  fdt_tpm_kaslr_seed()
- uclass_get_device() -> uclass_first_device_err()
- Change default config for OFNODE_MULTI_TREE (y if !OF_LIVE)

Dhananjay Phadke (2):
  fdt: common API to populate kaslr seed
  fdt: kaslr seed from RNG device

Sean Edmond (3):
  cmd: kaslrseed: Use common API to fixup FDT
  dm: core: Modify default for OFNODE_MULTI_TREE
  fdt: Fix compile error for !OFNODE_MULTI_TREE

 arch/arm/cpu/armv8/sec_firmware.c | 39 ++++++++--------------
 boot/fdt_support.c                | 54 +++++++++++++++++++++++++++++++
 cmd/kaslrseed.c                   | 20 ++++--------
 configs/sandbox_defconfig         |  2 +-
 drivers/core/Kconfig              |  3 +-
 drivers/core/ofnode.c             | 29 +++++++++++++----
 include/dm/ofnode.h               | 12 +++++++
 include/fdt_support.h             |  9 ++++++
 lib/Kconfig                       |  7 ++++
 9 files changed, 129 insertions(+), 46 deletions(-)

-- 
2.42.0

