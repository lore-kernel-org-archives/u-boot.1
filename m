Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0565C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 08:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87AD88514;
	Tue, 23 Apr 2024 10:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4AE88514; Tue, 23 Apr 2024 10:10:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AEF64884F4
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 10:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.hoyes@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B80339;
 Tue, 23 Apr 2024 01:11:19 -0700 (PDT)
Received: from e133390.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 771003F64C;
 Tue, 23 Apr 2024 01:10:49 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, andre.przywara@arm.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com, neil.armstrong@linaro.org,
 sr@denx.de, michal.simek@amd.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, patrice.chotard@foss.st.com
Subject: [PATCH 0/2] Optimize udelay for aarch64 boards
Date: Tue, 23 Apr 2024 09:10:03 +0100
Message-Id: <20240423081005.23218-1-peter.hoyes@arm.com>
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

Arm boards currently use the default implementation of __udelay which
consists of a spin-loop. AArch64 however provides an architectural
timer with an event stream which can be enabled and waited upon with
a few lines of assembly. This is more efficient and also avoids
an issue on Arm FVPs where polling the counter frequently takes much
longer than real-time.

Therefore, overrride __udelay for all armv8 boards to use the event
stream.

Macros for the relevant instructions already existed for mach-exynos,
so pull these up to a common header file.

I have tested this patch chain on qemu-system-aarch64
(virt,secure=on), FVP_Base_RevC and a Raspberry Pi 4.

Peter Hoyes (2):
  arm: Move sev() and wfe() definitions to common Arm header file
  armv8: generic_timer: Use event stream for udelay

 arch/arm/cpu/armv8/Kconfig                 |  8 +++++++
 arch/arm/cpu/armv8/generic_timer.c         | 27 ++++++++++++++++++++++
 arch/arm/include/asm/system.h              | 15 ++++++++++--
 arch/arm/mach-exynos/include/mach/system.h | 19 ---------------
 4 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.34.1

