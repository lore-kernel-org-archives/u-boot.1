Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A587C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 07:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55B787691;
	Fri,  1 Dec 2023 08:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxXSHwV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40286876AF; Fri,  1 Dec 2023 08:12:44 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080898765A
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 08:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 95406B8068F;
 Fri,  1 Dec 2023 07:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECAD7C433C7;
 Fri,  1 Dec 2023 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701414761;
 bh=8N1J3QWe6AzjnB1qNd2Ibpl8hQoVr/uqtIOKzKOJ1dw=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=lxXSHwV6EBOg5MEdIDthqDSp26XFZxuQOerNbvvL6vt3vPnVet4086qZBF53ZiI7p
 +nEqcsNmOVN396+XEUNea2eVuIma+LTM32tWiOKdFVcJa/rd6qqAClBfiM0G3Hj2vo
 HBrbnYdOKvWR233DxP3QMuEQzOfAxG23TBEbPKhlxzmuWh0gxVjRvmUJEDom5mVpE7
 1o02ZsPu9F8xF2lvvn1PXhqbE8YGdkYSjdQnwoW4v+7GVZnArEVAJ/D8F4mVefjelV
 9I+fQY7ZS/yX0uQLJZnhC2ML2tiHWzNiWB5S+nyR5DBv5Xq9BMW7Inbo+a26Jiew72
 DSScIKfqvpGeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CDA27C4167B;
 Fri,  1 Dec 2023 07:12:40 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Fri, 01 Dec 2023 08:12:33 +0100
Subject: [PATCH v2] arm: apple: t602x: Add missing MMIO regions to memmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
X-B4-Tracking: v=1; b=H4sIAGCHaWUC/42NQQ6CMBBFr0JmbU07BIKuvIchTZ2OUiOlaSvBE
 O5u5QQu30v++yskjo4TnKsVIs8uuckXwEMFNBj/YOFsYUCJtVK1FCaEF+vcSlw0L5m91SOPowm
 COqQGkUxHEso+RL67ZW9f+8KDS3mKn/1qVj/7T3VWQgmyp/aGjbJo6fI03pv30XOGftu2L7vGO
 cnDAAAA
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003; i=j@jannau.net;
 h=from:subject:message-id; bh=4FSp+FL6oA+RNFZSKEu4rSlOBmR9+tDcRmnu9XGpMIo=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhtTM9vQlP0Jy9i5Rmv9Ut3ej37U5TVuZxJd//3VGLHvTo
 62O930/d5SyMIhxMMiKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZgI13JGhquG6VNnbZds9mO9
 c2pmn/y5tXukleYGcnIpX2s4ZbhbQ5uR4a9V6MHdD1aofJ3dzckkssptLu/yDIW2gBjXdhGhCLM
 ZLAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

The memory maps for Apple's M2 Pro/Max/Ultra left MMIO space out which
was not used by any driver at the time. The display out exposed as
simple-framebuffer use a power-domain controlled by a device in an
unmapped region.
Add a map covering this region as well as another MMIO region in the
range 0x4'0000'0000 - 0x5'0000'0000. The added regions cover all MMIO
annotated in Apple's device tree in this range.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- use SZ_1G as block size
- Link to v1: https://lore.kernel.org/r/20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net
---
 arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 47393babbc..7a6151a972 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -370,6 +370,22 @@ static struct mm_region t6020_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x400000000,
+		.phys = 0x400000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x480000000,
+		.phys = 0x480000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
 		/* I/O */
 		.virt = 0x580000000,
@@ -471,6 +487,22 @@ static struct mm_region t6022_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x400000000,
+		.phys = 0x400000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x480000000,
+		.phys = 0x480000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
 		/* I/O */
 		.virt = 0x580000000,
@@ -551,6 +583,22 @@ static struct mm_region t6022_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2400000000,
+		.phys = 0x2400000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2480000000,
+		.phys = 0x2480000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
 		/* I/O */
 		.virt = 0x2580000000,

---
base-commit: 43f2873fa98b1da6eb56d756315c7bd7db63db27
change-id: 20231130-apple_t602x_extend_memmap-c82c522ca8c0

Best regards,
-- 
Janne Grunau <j@jannau.net>

