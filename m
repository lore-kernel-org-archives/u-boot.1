Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DE606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QqmzJRKI;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jDjs8Ee1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19BFE81565;
	Sat,  7 Nov 2026 12:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBn1IjCQi3H2; Sat,  7 Nov 2026 12:50:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3928B814BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055812;
	b=KWanPykEwHIKFZTm/bAGh/kdd4KD7rijVlSyQIIZc2sRAn9mzXfeuSwXbmQhQYssgPBd
	 457Itn5Hxh1KTPUS4msLDJ2rTmWeBGfwrFCBalu3/Vk02A6J/3BMYCRN18jFe8VBDSlnN
	 RlMKq8VcNuA1xIpvk9kUX0HVja1CBjyR3LkClJ84/+cIHrAmkdQV0efv5pCGgx55hoFWe
	 VscRbsI4Z16TMwKej1kKihUG8dKYb1k6w6LdW4qCVYyCqWA0IpEmOz+YT0DZHhoyGYX//
	 0VRlTOxf3G/x+P0E4k5Iw7yxh4ErPks5HKNlQBcHpRGXVHI9uo3QXupCygiLBvi8auw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
	b=J13TgPUF6cFrg1CpdwsFyCbd1m2wSJ+WyfOPJewma/d+h6mpeEG5K55xwshjm0fb3uN1
	 Dd3MiCLwulzeQYw0zjd0/0iuXPCZm8ZC6j8mhRIwNJEuBb0LlPmOAo9FsR743RpyQdFAi
	 mhVGXerL3ktBjHpm0NcXv7mCgqBvTGn7mqIfsAEhlJ0IUorjcoKWD3BGEBQMQ1EVk36GI
	 n97OF+tKODqK2KKoWakgFzdU9vl9jYSrpRivMLyUzdRduD8n1J5SHb3Dzsc0TEIYpTj1h
	 G1C00pbN4umwqCM4wLtXJTzP9k4q4vbdTAX2qwMrfvkkZeeh57zjwIQITzVrZRCPDIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055812;
	bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QqmzJRKIDB10DId3MKS5LXIoDUVl4ORCu0Nv5Di1si+Z4WoIL4+Hb9ZdNGICGzePN
	 5qC/zuACyRQ2PzsAwZi+Hj4lgw6LJ9P76QIJMA1QIJdmoj4vkp9WpssD4dKwS+U9Rc
	 J6rWPhsfYmV0bbkF/LLm3tqrn3BU2VWRv2zVqterkWYCtapQKJru13J5MKbIhDDbkW
	 BETBlY/IVn9g/l6AxQJutWrbBYr+gpjX8oU5xED/MDhgKXFVUCPLAaoxgndApZODr4
	 7LcvtwU6W4f5iJHGJUMbmkoNulFm2kXl+BXFegKl+hMsbFQluWmZRrLtAIwJ2BMhUW
	 PZoezGeiMt7bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3928B814BA;
	Sat,  7 Nov 2026 12:50:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01B8C31F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBB174005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1XOaYK26Dk1 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D425F40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=jDjs8Ee1
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D425F40042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:18 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c499e0e43a9so11897066b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036196; x=1794640996;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
 b=jDjs8Ee1Ps/qB9s8G+e1M+mUa70wNDalFLKt7cRxf3m2kOTkjICtSQfKt4AqZuqivp
 tSI0VD67n4A9s4lzyo1siM2cGbmBn8HGWJUhxSymtwytlZIJ+0Mn4UW7MwNs0jbII9dc
 pf7oKxuL1Xj/SwIO18Iqhsh2l3bimDUwboWWzMLezsKJotsPKFg+Tf07J6eF8ZS8aa0+
 TwiS7o8g4mWARvMTGi7I3T+3lQcd2zm66ory414p0Th2sfLjrN+fJ+nElEdBQoUH99Hp
 yQSRGGNuevPV6COBME0Mx5Negjg8TfB/n3d+DcGj3aCBtj/8L6NABzOzNKUHae2avUMl
 Ponw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036196; x=1794640996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
 b=aqHk6oli4lOHZRvuT1XUoow3PJO2vUFxQR3PD2VVwAnD85eBof2s+eTA7inYMXqYJD
 Vq+EVLHdy2Xhs8Daiz4ujc1GnBsKpOObhHkZqGbtps+QmWrBYVqVPIt8kYKgDNFdkiOr
 zSY8I7SuSC/eoW3eeAgBONg4r1rYTBiKbPP6Tg1aBY0zxqPxc90w72k5QKRYQkdzUT3a
 HXrtMznY6w1VFCKrD0slMjzNjJ+nvJnrsVx+4/U+cT/KPOIbThVNu0wOgV5vIhiL0QrP
 6Ca9xACBVhycY0pbc8Y3OcRuDNid7IB34Mc4P0tz2IP1y54UJ0YstyCyqzQhDl4N/Si7
 Xvzw==
X-Gm-Message-State: APuU4Z8IGfN3psp8JywEc+vtSuRNMsFwI1Nxal8PSewBI40ZKKHlIFLx
 JIHlKCSb+eAvtrWkf+rLTWyKaC2AR25J7Oq9iBbSYaTbU2rz1TgaWS5ivan4R5lQtnbEkwThfva
 pI3Dy
X-Gm-Gg: AYBFou11ZtpT0L6sqZGEcx2MvIODy7nqH2Rv67EKzp5q8kIvtSk7WUrPfiqB1ypmVui
 FuvkbKbz9LQxymPHgFx7OM2SHDS+0m/0ybllYk3tq9ilLx71lLUqNyETIlx20o0oF6D6md8ijor
 jrlc9cIn8eHqUrdLw13/M1Af0pDLyvafWLT4yFcNhmrHvM8O2D2R2WmXIO0X3oyaf22XYYrVCBT
 NJKYWb7aMi6uhMgNa8a1Qcv0WWPOtHFIgHSlk++Ciy6+T/MxoMH+rf39TmfEpHJimqBYm2RkFUI
 s1aREHwdYmAzANieCJ3JaU9KgqiZbg/urOxaayY6CgxxXa20hIuXEl293oTWiq+A1uUiseD/4VQ
 rkwmeL5dyuDnp6/Ptu0VWMF0Xmuw+fA0WaB6L9GlgE39pvG6WxXl64geuxkYgNVBnz8uu1isuc7
 00DviKpvgCMcUczZt2P0TZaUZ+3kOwzHA7nAeiAk7Xw2oznHiiUMbEX0rJS28Ct7elTvrCdyhZ7
 Hc8IHMDFr/ESFY39aER8iGJntDR7VXpC1okydUNzlzkz29oVxI0BEu0E/ULUMHrC0RJWJCrwZ0R
 naEtvbmNIxxIkWkckYQ1XVVHE4AYL4Zmw22AJnTh/Mpad3b5j8mQfu/UBm1EKLKnC00nLiqxlfO
 jqbQ9pj01NQ==
X-Received: by 2002:a17:906:6053:b0:c32:8cbb:fac with SMTP id
 a640c23a62f3a-c4d3531f6bemr376917666b.3.1794036196426; 
 Fri, 06 Nov 2026 23:23:16 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:16 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 11/30] usb: dwc3: adapt io.h, the Makefile and the TI glue
Date: Sat,  7 Nov 2026 08:22:05 +0100
Message-ID: <20261107072224.3492260-12-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drop the trace calls from io.h and bring back dwc3_flush_cache() and
dwc3_invalidate_cache() from the old io.h. The gadget code uses them.

Drop the linux-compat.h include from dwc3-omap.c and ti_usb_phy.c. The
restore commit removed that file.

The Makefile stays the U-Boot one, since the kernel one lists files we
do not import, like dwc3-qcom.c, host.c and drd.c. Build gadget.o and
ep0.o as part of dwc3.o, like the kernel does, and sort the glue
drivers.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/Makefile     | 11 +++++------
 drivers/usb/dwc3/dwc3-omap.c  |  2 --
 drivers/usb/dwc3/io.h         | 36 ++++++++++++++++++-----------------
 drivers/usb/dwc3/ti_usb_phy.c |  2 --
 4 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index a619cd374fb4..e0b63791c321 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -3,16 +3,15 @@
 obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
-
-obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
+dwc3-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
 
 obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+= dwc3-am62.o
-obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)	+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
-obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
-obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
 obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
-obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 4b219c35eb35..9de8ecff3adc 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -25,8 +25,6 @@
 #include <linux/usb/otg.h>
 #include <linux/compat.h>
 
-#include "linux-compat.h"
-
 /*
  * All these registers belong to OMAP's Wrapper around the
  * DesignWare USB3 Core.
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 1e96ea339d48..23bf1f1b43a5 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -11,10 +11,10 @@
 #ifndef __DRIVERS_USB_DWC3_IO_H
 #define __DRIVERS_USB_DWC3_IO_H
 
-#include <linux/io.h>
-#include "trace.h"
-#include "debug.h"
-#include "core.h"
+#include <asm/io.h>
+#include <cpu_func.h>
+
+#define CACHELINE_SIZE CONFIG_SYS_CACHELINE_SIZE
 
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
@@ -27,13 +27,6 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 */
 	value = readl(base + offset - DWC3_GLOBALS_REGS_START);
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
-
 	return value;
 }
 
@@ -45,13 +38,22 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * However, the offsets are given starting from xHCI address space.
 	 */
 	writel(value, base + offset - DWC3_GLOBALS_REGS_START);
+}
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
+static inline void dwc3_flush_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
+}
+
+static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
 
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/dwc3/ti_usb_phy.c b/drivers/usb/dwc3/ti_usb_phy.c
index f0ecdea958ae..f1ddc0086945 100644
--- a/drivers/usb/dwc3/ti_usb_phy.c
+++ b/drivers/usb/dwc3/ti_usb_phy.c
@@ -27,8 +27,6 @@
 #include <asm/arch/sys_proto.h>
 #include <dm.h>
 
-#include "linux-compat.h"
-
 #define PLL_STATUS		0x00000004
 #define PLL_GO			0x00000008
 #define PLL_CONFIGURATION1	0x0000000C
-- 
2.53.0

