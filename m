Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF0FC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 12:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1768713D;
	Thu, 30 Nov 2023 13:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kdmZ7aI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA37C875AA; Thu, 30 Nov 2023 13:42:38 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A01870E4
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 13:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 64701B841EC;
 Thu, 30 Nov 2023 12:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD906C433CA;
 Thu, 30 Nov 2023 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701348155;
 bh=Z0eTcOUkARHWoMivYgEpN1jqXgonnIfH6QVc7V86jok=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=kdmZ7aI5SNTRSvWeHWj+7Xm/Ms8/pnH0+JErXUt0n/BZWcwwDCg5VjnF4rVDyUmDX
 K51/tnQM5fu4vIfER1F/h0oIAss73L0EqceOJCAzU6iAOs40/HsRrMlBn+ga4IYQZp
 k9EpACb0haiVJufe+GnXu8Gvup05KT5LGI/T1APXcFjwJ6hbSb7se0iY7iWOztkHnh
 eycwRt74jGVQm0kW15rq45oJzT+m3GNhjsOTZIvFoI6UPyYYkg8uvgR0YubRsvkUe8
 sKMl+fkl794nH5d+G/K5BMEUfkh2kAXlrBIL2JymoNZ15hZuGXQPBWTsphJD/ZGqRv
 AHaJjD32yM19w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A1ECCC07CA9;
 Thu, 30 Nov 2023 12:42:35 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Thu, 30 Nov 2023 13:42:22 +0100
Subject: [PATCH] arm: apple: t602x: Add missing MMIO regions to memmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net>
X-B4-Tracking: v=1; b=H4sIAC2DaGUC/x3MQQrDIBBG4auEWVfQCQ0hVylFZPK3GYhWNBQh5
 O6VLr/FeydVFEWlZTip4KtVP6nD3QaSLaQ3jK7dxJZH50ZrQs47/DFZbh7tQFp9RIwhG5lZ7sw
 SZrHU+1zw0vZ/P57X9QPVnBPOawAAAA==
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=j@jannau.net;
 h=from:subject:message-id; bh=BdZFDD0ocvWdf4L8IT2OEBDK4E8bBAFq03bgl1BRcDE=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhtSMZqv9kW/cMvOvs661u+Uae/kI75ZJKzuv7MufV33HI
 XR52K7pHaUsDGIcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACbyIo7hv+dcjqijiu7RUqb7
 r/yabGgRlFSy+e6d73mH5p87c1Hbo5/hn4Kx5qM1hz5afjL1n/BsW8NWOdeItZ8fXD0i83FrWce
 jFEYA
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
 arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 47393babbc..e05ec431bc 100644
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
+		.size = SZ_512M,
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
+		.size = SZ_512M,
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
+		.size = SZ_512M,
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

