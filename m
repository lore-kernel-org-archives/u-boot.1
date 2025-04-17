Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE986C369BD
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 00:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F5082F8A;
	Thu, 17 Apr 2025 02:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56ACE82DB4; Thu, 17 Apr 2025 02:06:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 49D0982DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5771F153B;
 Wed, 16 Apr 2025 17:06:33 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 894A43F66E;
 Wed, 16 Apr 2025 17:06:34 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/3] sunxi: fix return_to_fel() prototype
Date: Thu, 17 Apr 2025 01:05:37 +0100
Message-ID: <20250417000539.3709-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250417000539.3709-1-andre.przywara@arm.com>
References: <20250417000539.3709-1-andre.przywara@arm.com>
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

In some sys_proto header file we describe the prototype of the
return_to_fel() function, which is implemented in assembly.
The order of the arguments listed there is wrong: the stack pointer is
expected in r0/w0, and the return address in r1/w1.

Fix the order to match the code. This is purely cosmetic, as the callers
and the assembly code are already agreeing on this.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/sys_proto.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/sys_proto.h b/arch/arm/include/asm/arch-sunxi/sys_proto.h
index 92c7721a530..43ee0fdd558 100644
--- a/arch/arm/include/asm/arch-sunxi/sys_proto.h
+++ b/arch/arm/include/asm/arch-sunxi/sys_proto.h
@@ -17,10 +17,10 @@ void sdelay(unsigned long);
  * This returns back into the BROM after U-Boot SPL has performed its initial
  * init. It uses the provided lr and sp to do so.
  *
- * @lr:		BROM link register value (return address)
  * @sp:		BROM stack pointer
+ * @lr:		BROM link register value (return address)
  */
-void return_to_fel(uint32_t lr, uint32_t sp);
+void return_to_fel(uint32_t sp, uint32_t lr);
 
 /* Board / SoC level designware gmac init */
 #if !defined CONFIG_XPL_BUILD && defined CONFIG_SUN7I_GMAC
-- 
2.46.3

