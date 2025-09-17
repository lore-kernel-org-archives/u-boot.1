Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56CACAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25F5837B6;
	Wed, 17 Sep 2025 18:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4128368E; Wed, 17 Sep 2025 18:22:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2FC668365C
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 18:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=debbie.horsfall@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F09A267F;
 Wed, 17 Sep 2025 09:22:24 -0700 (PDT)
Received: from e137876.manchester.arm.com (e137876.arm.com [10.33.10.100])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430353F673;
 Wed, 17 Sep 2025 09:22:31 -0700 (PDT)
From: Debbie Horsfall <debbie.horsfall@arm.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, fenghua@phytium.com.cn, linus.walleij@linaro.org,
 Peter.Hoyes@arm.com, liviu.dudau@foss.arm.com
Subject: [PATCH v2 1/2] vexpress63: Set the DM_RNG property
Date: Wed, 17 Sep 2025 17:22:21 +0100
Message-ID: <20250917162222.1061111-1-debbie.horsfall@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:24:15 +0200
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

Enable the DM_RNG virtio random number generator driver in order to
consume entropy within U-Boot. This allows U-Boot to inject entropy to the
kernel via UEFI, so the kernel can use that early, for instance for
address layout randomisation, or when the kernel does not provide an
entropy driver itself.

Signed-off-by: Debbie Horsfall <debbie.horsfall@arm.com>
---
 board/armltd/vexpress64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index 7e8709444fe..610ab0ac37d 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -21,6 +21,8 @@ config VEXPRESS64_BASE_MODEL
 	imply EFI_SET_TIME if DM_RTC
 	select LINUX_KERNEL_IMAGE_HEADER
 	select POSITION_INDEPENDENT
+	imply DM_RNG
+	imply RNG_ARM_RNDR
 
 choice
 	prompt "VExpress64 board variant"
-- 
2.43.0

