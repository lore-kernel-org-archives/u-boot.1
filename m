Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7B4C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4AF81DCF;
	Tue, 28 Jan 2025 14:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="ceTbr/P2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCE281DD3; Tue, 28 Jan 2025 14:22:33 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBA381DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738070545; bh=zaWkP4buzzHXCn3GM7sykboGAZKpc/oIBCeGFYoeimE=;
 h=From:To:Cc:Subject:Date;
 b=ceTbr/P2uc4T/MeBbFCJ/EkXWxs9o6iYsjMFd/LRsIzafzhcyuoJFadaF+AxUPIMs
 UDZcKNWaWfOddgCjDl5IqF0fEPhSzsTZBvgRAadF/ncuXnHsnJJTPZbfy42IPdmibu
 MRgPafTCBgXowg/u8ghcA3b2PSwJ86mu+D+HE2rE=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 59695212; Tue, 28 Jan 2025 21:22:22 +0800
X-QQ-mid: xmsmtpt1738070542t1akyhvw4
Message-ID: <tencent_607C0C7A7607E3D8AC82FF80743097266109@qq.com>
X-QQ-XMAILINFO: NA7PUccRIKCogd/WXRfAzaSgJSIUiugiHi66/eMJi30o0MJJgupKgarHtiqSAE
 H9xmVlXqrfKhKyIzEsXE8GTfQmUndCThkU5Z4a/ILq0ifb6qmTvbuSmXHqrxs7NfHL5718WJ5nNg
 3fThwg7Dw4bTyYBXn47KsR/PrO6wD9lML3tP7FFS4VFH2ztzc4pnwJjN95wDREfZQKzekte0BCBt
 Szcy9y8ZeZms5byX6fP6ogZGcCCr2veJjHEHn9azfZfPRHYfxGyfEISaHPJmbBXAAeLOhYBuquFH
 ppJylEWBX3L5GYSd7uSKuD4pox+etJokPRgecS3AVbLHoaT+cxO4NcP85FpCyn0qRo+BJ8gL8Qm/
 5hPEGpQehViYw3uwDm0OTvNIXf0QZl2Ot4ubCZEEDFYRXTClbSYFgM6DJeecVi4ArVzwSriaJYwZ
 jZUze73hgF4+KQ+6B5I2eheOd6WVPoKvOntkaNJKDasS+JWbQM7va7PMb6n3O0VOMg2MKesTg//7
 1kQ+SPOcBTrdx46CTcE4bvZ/miPshtlaroszetUfWOUTT+DjKT/Foh0FlEmaSWEqErBY+7mVk5vV
 qcatXtd+78yoCrXuemIktDRgOQgkaELmlm701r2FZV9fqWqP4qkstChjKFrd022Yc1GrwbeqNZpR
 iUbBPGmpG9X22KQWj63ZzQhvY1q03RmTjMTj9LpM4G6kd5EHJumC7dpGH0qQHrl0T3k2tYj7/8DZ
 BFJBOpwu4NCC7kN66esoTlFzGTlz0W9UBLplNNXwQO9nsc62FQyiYGuuITgnY11zhSX8Pf6nNA+F
 gXyrojE262U1yuSh1ckNFl6k0d68NEbheTX3V6TLo+LxNIdHWDgRjIpc+JpcZIgBAfMN4oZ+OOHZ
 ug/if3cyY1Jf4KKoQ29XvtjgcgJ4M8VmlYUCUQup6kOn0H1+Bl9kV0bM8TCOBkeme7GDz8C0Rbna
 nSNg9cviT//vhFFigrAPUAR+WvpT85ZxjUKj0hlXgM2ACCzmMP1P4/gIl8RjAJJz5YLM01dJ0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Subject: [PATCH] armv7m: kconfig adds the NVIC option and masks the GIC option
 when NVIC is selected
Date: Tue, 28 Jan 2025 21:22:15 +0800
X-OQ-MSGID: <20250128132215.186723-1-1425075683@qq.com>
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

From: Liya Huang <1425075683@qq.com>

ARMv7-M architecture uses NVIC instead of GIC.
NVIC is an interrupt controller specially designed for
ARM Cortex-M series processors.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 arch/arm/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 314916527c9..c88b3b2aa43 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -108,6 +108,9 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	  The value subtracted from CONFIG_TEXT_BASE to calculate the
 	  TEXT_OFFSET value written to the Linux kernel image header.
 
+config NVIC
+	bool
+
 config GICV2
 	bool
 
@@ -117,6 +120,7 @@ config GICV3
 config DRIVER_GICV2
 	bool "ARM GICV2 driver"
 	select IRQ
+	depends on !NVIC
 	help
 	  ARM GICV2 driver.
 	  Basic support for parsing the GICV2 node and generate ACPI tables.
@@ -124,6 +128,7 @@ config DRIVER_GICV2
 config GIC_V3_ITS
 	bool "ARM GICV3 ITS"
 	select IRQ
+	depends on !NVIC
 	help
 	  ARM GICV3 Interrupt translation service (ITS).
 	  Basic support for programming locality specific peripheral
@@ -134,6 +139,7 @@ config GIC_V3_ITS
 
 config GICV3_SUPPORT_GIC600
 	bool "ARM GICV3 GIC600 SUPPORT"
+	depends on !NVIC
 	help
 	  ARM GIC-600 IP complies with ARM GICv3 architecture, but among others,
 	  implements a power control register in the Redistributor frame.This
@@ -193,6 +199,7 @@ config SPL_SYS_DCACHE_OFF
 
 config SYS_ARM_CACHE_CP15
 	bool "CP15 based cache enabling support"
+	depends on !CPU_V7M
 	help
 	  Select this if your processor suports enabling caches by using
 	  CP15 registers.
@@ -200,6 +207,7 @@ config SYS_ARM_CACHE_CP15
 config SYS_ARM_MMU
 	bool "MMU-based Paged Memory Management Support"
 	select SYS_ARM_CACHE_CP15
+	depends on !CPU_V7M
 	help
 	  Select if you want MMU-based virtualised addressing space
 	  support via paged memory management.
@@ -350,6 +358,7 @@ config CPU_V7M
 	select SYS_CACHE_SHIFT_5
 	select SYS_THUMB_BUILD
 	select THUMB2_KERNEL
+	select NVIC
 
 config CPU_V7R
 	bool
-- 
2.25.1

