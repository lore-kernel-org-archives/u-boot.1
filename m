Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F8C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4CA80BAA;
	Tue,  4 Mar 2025 17:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D6A80805; Tue,  4 Mar 2025 17:52:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2CE88807D9
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C6C497;
 Tue,  4 Mar 2025 08:52:38 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.25.152])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 033763F5A1;
 Tue,  4 Mar 2025 08:52:23 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] vepxress64: disable CRC32 by default to prevent aborts
Date: Tue,  4 Mar 2025 16:52:01 +0000
Message-ID: <20250304165204.53097-2-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250304165204.53097-1-harrison.mutai@arm.com>
References: <20250304165204.53097-1-harrison.mutai@arm.com>
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

On fast models, the CRC32 feature is disabled by default. When enabled
in U-Boot, it leads to synchronous aborts due to unrecognized
instructions. This change ensures CRC32 is disabled by default to
maintain compatibility.

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 configs/vexpress_fvp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/vexpress_fvp_defconfig b/configs/vexpress_fvp_defconfig
index 7362c1fc35c..fda0f5283c9 100644
--- a/configs/vexpress_fvp_defconfig
+++ b/configs/vexpress_fvp_defconfig
@@ -2,4 +2,5 @@ CONFIG_ARM=y
 CONFIG_ARCH_VEXPRESS64=y
 CONFIG_DEFAULT_DEVICE_TREE="arm_fvp"
 CONFIG_IDENT_STRING=" arm_fvp"
+# CONFIG_ARM64_CRC32 is not set
 # CONFIG_DISPLAY_CPUINFO is not set
-- 
2.46.2

