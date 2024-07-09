Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F26C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 16:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D336188609;
	Tue,  9 Jul 2024 18:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ABD588610; Tue,  9 Jul 2024 15:25:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 137F9885CF
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 15:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yeoreum.yun@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32632153B;
 Tue,  9 Jul 2024 06:25:45 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 828753F766;
 Tue,  9 Jul 2024 06:25:18 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: trini@konsulko.com, raymond.mao@linaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, n-jain1@ti.com, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH] bloblist: Fix bloblist convention checking.
Date: Tue,  9 Jul 2024 14:25:16 +0100
Message-Id: <20240709132516.2427654-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 09 Jul 2024 18:36:59 +0200
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

According to recently firmware handsoff spec [1]'s
"Register usage at handoff boundary",
Transfer List's signature value was changed from 0x40_b10b
(3 bytes) to 4a0f_b10b (4 bytes).

As updating of TL's signature, register value of x1/r1 should be:

In aarch32's r1 value should be
    R1[23:0]: TL signature (4a0f_b10b->masked range value: 0f_b10b)
    R1[31:24]: version of the register convention ==  1

and

In aarch64's x1 value should be
    X1[31:0]: TL signature (4a0f_b10b)
    X1[39:32]: version of the register convention ==  1
    X1[63:40]: MBZ
(See the [2] and [3]).

Also, according to architecture, the convention is slight different:

In aarch32:
    R0: MBZ
    R1: see above
    R2: Compatibility location for passing a platform description devicetree
    R3: tl_base_pa

In aarch64:
    X0: Compatibility location for passing a platform description devicetree
    X1: see above
    X2: MBZ
    X3: tl_base_pa

This patch fix problems:
   1. breaking X1 value with updated specification in aarch64
        - change of length of signature field.

   2. previous error value set in R1 in arm32.
        - length of signature should be 24, but it uses 32bit signature.

   3. according to architecture, check register convetion differently.

[1] https://github.com/FirmwareHandoff/firmware_handoff
[2] https://github.com/FirmwareHandoff/firmware_handoff/issues/32
[3] https://github.com/FirmwareHandoff/firmware_handoff/commit/5aa7aa1d3a1db75213e458d392b751f0707de027

Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
---
 arch/arm/lib/xferlist.c |  8 +++++---
 common/bloblist.c       | 11 ++++++++++-
 include/bloblist.h      |  5 ++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index f9c5d88bd4..a6349293bd 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -12,12 +12,14 @@ int xferlist_from_boot_arg(ulong addr, ulong size)
 {
 	int ret;

-	ret = bloblist_check(saved_args[3], size);
+	if (IS_ENABLED(CONFIG_64BIT))
+		ret = bloblist_check_reg_conv(saved_args[0], saved_args[2], saved_args[1]);
+	else
+		ret = bloblist_check_reg_conv(saved_args[2], saved_args[0], saved_args[1]);
 	if (ret)
 		return ret;

-	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
-				      saved_args[1]);
+	ret = bloblist_check(saved_args[3], size);
 	if (ret)
 		return ret;

diff --git a/common/bloblist.c b/common/bloblist.c
index 11d6422b69..2008ab4d25 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -576,7 +576,16 @@ int bloblist_maybe_init(void)

 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 {
-	if (rzero || rsig != (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
+	ulong version = BLOBLIST_REGCONV_VER;
+	ulong sigval;
+
+	sigval = (IS_ENABLED(CONFIG_64BIT)) ?
+			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
+			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
+			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
+			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
+
+	if (rzero || rsig != sigval ||
 	    rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
 		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
 		return -EIO;
diff --git a/include/bloblist.h b/include/bloblist.h
index 7fbdd622bc..f4849f22a0 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -83,7 +83,10 @@ enum {
 	 * Register convention version should be placed into a higher byte
 	 * https://github.com/FirmwareHandoff/firmware_handoff/issues/32
 	 */
-	BLOBLIST_REGCONV_VER	= 1 << 24,
+	BLOBLIST_REGCONV_SHIFT_64 = 32,
+	BLOBLIST_REGCONV_SHIFT_32 = 24,
+	BLOBLIST_REGCONV_MASK = 0xff,
+	BLOBLIST_REGCONV_VER = 1,

 	BLOBLIST_BLOB_ALIGN_LOG2 = 3,
 	BLOBLIST_BLOB_ALIGN	 = 1 << BLOBLIST_BLOB_ALIGN_LOG2,
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

