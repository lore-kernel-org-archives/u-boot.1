Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40B1C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 22:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F8A88349;
	Fri, 31 May 2024 00:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C7D8872E; Fri, 31 May 2024 00:06:41 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7E387EED
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 00:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sCnuu-0030IF-BW;
 Thu, 30 May 2024 22:06:36 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v5 0/3] automatically add /chosen/kaslr-seed and deduplicate
 code
Date: Thu, 30 May 2024 15:06:31 -0700
Message-Id: <20240530220634.155951-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

This series will automatically add /chosen/kaslr-seed to the dt if DM_RNG is enabled
during the boot process.
    
If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
randomize the virtual address at which the kernel image is loaded, it
expects entropy to be provided by the bootloader by populating
/chosen/kaslr-seed with a 64-bit value from source of entropy at boot.

If we have DM_RNG enabled populate this value automatically when
fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
is enabled as its implementation uses a different source of entropy
that is not yet implemented as DM_RNG. We also skip this if
MEASURED_BOOT is enabled as in that case any modifications to the
dt will cause measured boot to fail (although there are many other
places the dt is altered).

As this fdt node is added elsewhere create a library function and
use it to deduplicate code. We will provide a parameter to overwrite
the node if present.  

For our automatic injection, we will use the first rng device and
not overwrite if already present with a non-zero value (which may
have been populated by an earlier boot stage). This way if a board
specific ft_board_setup() function wants to customize this behavior
it can call fdt_kaslrseed with a rng device index of its choosing and
set overwrite true.
    
Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
but left in place in case boot scripts exist that rely on this command
existing and returning success. An informational message is printed to
alert users of this command that it is likely no longer needed.

Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
randomization and completely ignores the kaslr-seed for its own
randomness needs (i.e the randomization of the physical placement of
the kernel). It gets weeded out from the DTB that gets handed over via
efi_install_fdt() as it would also mess up the measured boot DTB TPM
measurements as well.
    
v5:
 - fixed typo in commit message s/it's/its/
 - use cmd_process_error per Michal's suggestion
 - split into separate patches
 - remove the rng device index noting it as a future enhancement 
v4:
 - add missing /n to notice in kaslrseed cmd
 - combine ints in declaration
 - remove unused vars from board/xilinx/common/board.c ft_board_setup
v3:
 - skip if CONFIG_MEASURED_BOOT
 - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
 - pass in rng index and bool to specify overwrite
 - remove duplicate error strings printed outside of fdt_kaslrseed
 - added note to commit log about how EFI STUB weeds out kalsr-seed
v2:
 - fix typo in commit msg
 - use stack for seed to avoid unecessary malloc/free
 - move to a library function and deduplicate code by using it
   elsewhere

Tim Harvey (3):
  Add fdt_kaslrseed function to add kaslr-seed to chosen node
  fdt: automatically add /chosen/kaslr-seed if DM_RNG is enabled
  use fdt_kaslrseed function to de-duplicate code

 board/xilinx/common/board.c | 40 ----------------------------
 boot/fdt_support.c          | 53 +++++++++++++++++++++++++++++++++++++
 boot/pxe_utils.c            | 34 +-----------------------
 cmd/kaslrseed.c             | 49 +++++-----------------------------
 include/fdt_support.h       | 10 +++++++
 5 files changed, 71 insertions(+), 115 deletions(-)

-- 
2.25.1

