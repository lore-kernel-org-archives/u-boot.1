Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B897C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4E687113;
	Tue, 14 Nov 2023 12:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="kZd4orMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB5BC87468; Tue, 14 Nov 2023 12:03:33 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE5E87468
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 49FDA100023;
 Tue, 14 Nov 2023 14:03:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 49FDA100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959811;
 bh=oV/Hza8j8NWrZ9GBWyIWMlwPOZg08Gg9ztEmAkKToQk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=kZd4orMBNLYHToWOMryZJO2uut8NvkEEhfigh02xJ6i3jub0gMacsKtzJnZ2AyxFv
 4DJlRHi0J9gVwjDuxo7+/s31GlzMc9xsrS1tl6kjlfKaEmcMCH6FTprUy2TsasAv6X
 XMPc2jVrvKwMLAUU9LbcU8wZsrLd78wMClYmGyZtt+pZMHLoes3LIpMwrGdcwlqM9+
 PTV8p9LkmT+HqGW9/U34lfJb+OU7gmK1llQSTzFcrrkXKR+Xgjil4wi9+XqyF8dbRk
 CDfDP7ayk+DYFoNvPK5Pb3d605YY/hg3PvoZsrJy/OK4Vi+EQ6OhMVmVMqLIqnrS0v
 viVC58Wy9ylSw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:31 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:30 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Alexander
 Dahl <ada@thorsis.com>, Balamanikandan Gunasundar
 <balamanikandan.gunasundar@microchip.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: [PATCH 10/13] asm-generic: Import functions from Linux
Date: Tue, 14 Nov 2023 14:02:54 +0300
Message-ID: <20231114110257.2488-11-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114110257.2488-1-ivprusov@salutedevices.com>
References: <20231114110257.2488-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181340 [Nov 14 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/14 07:58:00 #22462416
X-KSMG-AntiVirus-Status: Clean, skipped
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

Currently {read,write}s{b,w,lq}() functions are available only on some
architectures, and there are no io{read,write}{8,16,32,64}_rep()
functions in u-boot. This patch adds generic versions that may be used
without arch-specific implementation.

Since some of added functions were already added locally in some files,
remove them to avoid redeclaration errors.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/mtd/nand/raw/atmel/nand-controller.c |  34 --
 drivers/mtd/nand/raw/nand_base.c             |  33 --
 include/asm-generic/io.h                     | 348 +++++++++++++++++++
 3 files changed, 348 insertions(+), 67 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index fa962ba591..37b0c3a5cd 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -352,40 +352,6 @@ static int atmel_nfc_wait(struct atmel_hsmc_nand_controller *nc, bool poll,
 	return ret;
 }
 
-static void iowrite8_rep(void *addr, const uint8_t *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		writeb(buf[i], addr);
-}
-
-static void ioread8_rep(void *addr, uint8_t *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		buf[i] = readb(addr);
-}
-
-static void ioread16_rep(void *addr, void *buf, int len)
-{
-	int i;
-	u16 *p = (u16 *)buf;
-
-	for (i = 0; i < len; i++)
-		p[i] = readw(addr);
-}
-
-static void iowrite16_rep(void *addr, const void *buf, int len)
-{
-	int i;
-	u16 *p = (u16 *)buf;
-
-	for (i = 0; i < len; i++)
-		writew(p[i], addr);
-}
-
 static u8 atmel_nand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6b4adcf6bd..815ddf5d8d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -245,39 +245,6 @@ static void nand_write_byte16(struct mtd_info *mtd, uint8_t byte)
 	chip->write_buf(mtd, (uint8_t *)&word, 2);
 }
 
-static void iowrite8_rep(void *addr, const uint8_t *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		writeb(buf[i], addr);
-}
-static void ioread8_rep(void *addr, uint8_t *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		buf[i] = readb(addr);
-}
-
-static void ioread16_rep(void *addr, void *buf, int len)
-{
-	int i;
-	u16 *p = (u16 *) buf;
-
-	for (i = 0; i < len; i++)
-		p[i] = readw(addr);
-}
-
-static void iowrite16_rep(void *addr, void *buf, int len)
-{
-	int i;
-        u16 *p = (u16 *) buf;
-
-        for (i = 0; i < len; i++)
-                writew(p[i], addr);
-}
-
 /**
  * nand_write_buf - [DEFAULT] write buffer to chip
  * @mtd: MTD device structure
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7a2f0dba31..13d99cfb59 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -105,5 +105,353 @@ static inline void unmap_physmem(void *vaddr, unsigned long flags)
 }
 #endif
 
+/*
+ * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
+ *
+ * On some architectures memory mapped IO needs to be accessed differently.
+ * On the simple architectures, we just read/write the memory location
+ * directly.
+ */
+
+#ifndef __raw_readb
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	return *(const volatile u8 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readw
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	return *(const volatile u16 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readl
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	return *(const volatile u32 __force *)addr;
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef __raw_readq
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	return *(const volatile u64 __force *)addr;
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef __raw_writeb
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
+{
+	*(volatile u8 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writew
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 value, volatile void __iomem *addr)
+{
+	*(volatile u16 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writel
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 value, volatile void __iomem *addr)
+{
+	*(volatile u32 __force *)addr = value;
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef __raw_writeq
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
+{
+	*(volatile u64 __force *)addr = value;
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+/*
+ * {read,write}s{b,w,l,q}() repeatedly access the same memory address in
+ * native endianness in 8-, 16-, 32- or 64-bit chunks (@count times).
+ */
+#ifndef readsb
+#define readsb readsb
+static inline void readsb(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u8 *buf = buffer;
+
+		do {
+			u8 x = __raw_readb(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef readsw
+#define readsw readsw
+static inline void readsw(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u16 *buf = buffer;
+
+		do {
+			u16 x = __raw_readw(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef readsl
+#define readsl readsl
+static inline void readsl(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u32 *buf = buffer;
+
+		do {
+			u32 x = __raw_readl(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef readsq
+#define readsq readsq
+static inline void readsq(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u64 *buf = buffer;
+
+		do {
+			u64 x = __raw_readq(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef writesb
+#define writesb writesb
+static inline void writesb(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u8 *buf = buffer;
+
+		do {
+			__raw_writeb(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesw
+#define writesw writesw
+static inline void writesw(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u16 *buf = buffer;
+
+		do {
+			__raw_writew(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesl
+#define writesl writesl
+static inline void writesl(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u32 *buf = buffer;
+
+		do {
+			__raw_writel(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef writesq
+#define writesq writesq
+static inline void writesq(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u64 *buf = buffer;
+
+		do {
+			__raw_writeq(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef PCI_IOBASE
+#define PCI_IOBASE ((void __iomem *)0)
+#endif
+
+/*
+ * {in,out}s{b,w,l}{,_p}() are variants of the above that repeatedly access a
+ * single I/O port multiple times.
+ */
+
+#ifndef insb
+#define insb insb
+static inline void insb(unsigned long addr, void *buffer, unsigned int count)
+{
+	readsb(PCI_IOBASE + addr, buffer, count);
+}
+#endif
+
+#ifndef insw
+#define insw insw
+static inline void insw(unsigned long addr, void *buffer, unsigned int count)
+{
+	readsw(PCI_IOBASE + addr, buffer, count);
+}
+#endif
+
+#ifndef insl
+#define insl insl
+static inline void insl(unsigned long addr, void *buffer, unsigned int count)
+{
+	readsl(PCI_IOBASE + addr, buffer, count);
+}
+#endif
+
+#ifndef outsb
+#define outsb outsb
+static inline void outsb(unsigned long addr, const void *buffer,
+			 unsigned int count)
+{
+	writesb(PCI_IOBASE + addr, buffer, count);
+}
+#endif
+
+#ifndef outsw
+#define outsw outsw
+static inline void outsw(unsigned long addr, const void *buffer,
+			 unsigned int count)
+{
+	writesw(PCI_IOBASE + addr, buffer, count);
+}
+#endif
+
+#ifndef outsl
+#define outsl outsl
+static inline void outsl(unsigned long addr, const void *buffer,
+			 unsigned int count)
+{
+	writesl(PCI_IOBASE + addr, buffer, count);
+}
+#endif
+
+#ifndef ioread8_rep
+#define ioread8_rep ioread8_rep
+static inline void ioread8_rep(const volatile void __iomem *addr, void *buffer,
+			       unsigned int count)
+{
+	readsb(addr, buffer, count);
+}
+#endif
+
+#ifndef ioread16_rep
+#define ioread16_rep ioread16_rep
+static inline void ioread16_rep(const volatile void __iomem *addr,
+				void *buffer, unsigned int count)
+{
+	readsw(addr, buffer, count);
+}
+#endif
+
+#ifndef ioread32_rep
+#define ioread32_rep ioread32_rep
+static inline void ioread32_rep(const volatile void __iomem *addr,
+				void *buffer, unsigned int count)
+{
+	readsl(addr, buffer, count);
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef ioread64_rep
+#define ioread64_rep ioread64_rep
+static inline void ioread64_rep(const volatile void __iomem *addr,
+				void *buffer, unsigned int count)
+{
+	readsq(addr, buffer, count);
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef iowrite8_rep
+#define iowrite8_rep iowrite8_rep
+static inline void iowrite8_rep(volatile void __iomem *addr,
+				const void *buffer,
+				unsigned int count)
+{
+	writesb(addr, buffer, count);
+}
+#endif
+
+#ifndef iowrite16_rep
+#define iowrite16_rep iowrite16_rep
+static inline void iowrite16_rep(volatile void __iomem *addr,
+				 const void *buffer,
+				 unsigned int count)
+{
+	writesw(addr, buffer, count);
+}
+#endif
+
+#ifndef iowrite32_rep
+#define iowrite32_rep iowrite32_rep
+static inline void iowrite32_rep(volatile void __iomem *addr,
+				 const void *buffer,
+				 unsigned int count)
+{
+	writesl(addr, buffer, count);
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef iowrite64_rep
+#define iowrite64_rep iowrite64_rep
+static inline void iowrite64_rep(volatile void __iomem *addr,
+				 const void *buffer,
+				 unsigned int count)
+{
+	writesq(addr, buffer, count);
+}
+#endif
+#endif /* CONFIG_64BIT */
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_IO_H__ */
-- 
2.34.1

