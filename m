Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3108ACD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1D988120;
	Thu, 11 Apr 2024 06:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="cHiSV5Hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F31B87FA0; Thu, 11 Apr 2024 06:28:08 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39D8881DD
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DYWvP6tVwWZWvoaJzFLYYNKvyFpk0I9S+J3/A26GBw=;
 b=cHiSV5HsRKvAhH/9enYE1xtpNLMbJVxjwvO0hIPCIUfF/HY2Xfm0sEBjfxvNp0ooqA6RlM
 R/vJ+8ZGnP2RBb4szNcm6JMNTAV2wMv5j01QUadCgY8PEzf3ww7SIgL7qV/MFKBMziCW4E
 pli3gUicZbVeabzUlNBw4fEVA4rGKESCwXT3U6TxjC7aoaqaqWsB6wgAAj60cNYVlekUzF
 fmap4AML2CkQXApiaXODxRMWJLh6rX5lhpolkr5nyCKXP/tIMKwHHs4BM7LlVd8ixMT6rd
 7fuAgR8DKEvykAIjN+mJ+PL2w5ru4wcAhr1jIRdALRnmcV1D9CIcnmm9ylSFLw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:25 +1000
Subject: [PATCH RFC 08/15] spl: Add BOOT_DEVICE_SPINAND option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-8-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809565; l=1840;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=fhuuQkcHwce/BjHWvu8VPcm5p8dDPaqvgT9EgHg/xpE=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABATkjk1rbKy5q8VMAZ2CBzbN6
 5/jLyso5eiJQKXKiACsXtldTxejjQcAKJvhk/tVHCb5o2Hh5Xw3UdHe3IFnT0CgUAAOlF
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

Currently there are two different boot device options: SPI and NAND.
One is intended for SPI NOR operation, the other is intended for dedicated
NAND operation.

Add a new option for SPI NAND operation.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/spl.h     | 1 +
 arch/mips/include/asm/spl.h    | 1 +
 arch/riscv/include/asm/spl.h   | 1 +
 arch/sandbox/include/asm/spl.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
index ee79a19c05..92deba8019 100644
--- a/arch/arm/include/asm/spl.h
+++ b/arch/arm/include/asm/spl.h
@@ -22,6 +22,7 @@ enum {
 	BOOT_DEVICE_NOR,
 	BOOT_DEVICE_UART,
 	BOOT_DEVICE_SPI,
+	BOOT_DEVICE_SPINAND,
 	BOOT_DEVICE_USB,
 	BOOT_DEVICE_SATA,
 	BOOT_DEVICE_I2C,
diff --git a/arch/mips/include/asm/spl.h b/arch/mips/include/asm/spl.h
index 0a847edec8..02b580079a 100644
--- a/arch/mips/include/asm/spl.h
+++ b/arch/mips/include/asm/spl.h
@@ -16,6 +16,7 @@ enum {
 	BOOT_DEVICE_NOR,
 	BOOT_DEVICE_UART,
 	BOOT_DEVICE_SPI,
+	BOOT_DEVICE_SPINAND,
 	BOOT_DEVICE_USB,
 	BOOT_DEVICE_SATA,
 	BOOT_DEVICE_I2C,
diff --git a/arch/riscv/include/asm/spl.h b/arch/riscv/include/asm/spl.h
index 9c0bf9755c..56b5bf9d7e 100644
--- a/arch/riscv/include/asm/spl.h
+++ b/arch/riscv/include/asm/spl.h
@@ -18,6 +18,7 @@ enum {
 	BOOT_DEVICE_NOR,
 	BOOT_DEVICE_UART,
 	BOOT_DEVICE_SPI,
+	BOOT_DEVICE_SPINAND,
 	BOOT_DEVICE_USB,
 	BOOT_DEVICE_SATA,
 	BOOT_DEVICE_NVME,
diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index 4fab24cd15..70f8ad4b58 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -16,6 +16,7 @@ enum {
 	BOOT_DEVICE_NOR,
 	BOOT_DEVICE_SPI,
 	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_SPINAND,
 };
 
 /**

-- 
2.44.0

