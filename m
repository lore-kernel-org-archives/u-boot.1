Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043B606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TE9idYdJ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=abk/6KN5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CC2B606EA;
	Sat, 21 Nov 2026 13:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3K0_jxDyroep; Sat, 21 Nov 2026 13:14:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA170606AE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266877;
	b=JDUmWpiFTsOAdKHB2zWyWGzeBCCvs5lQH4WRKm8M9qNND4wAQzeZhZry/Tyx7WlVtElx
	 oojgN/DfttPuV0SmYFHkZqDuXzcfGmcSI7HGW6so78e62BvcsP9bjXOJihWGNA7Ar6RFS
	 /CKqgInufwQqAWF0odSvuXikiSQdaUAs9e1kH1olch66TWVOVJf0FCm0JfbmXK03Z8Xat
	 nObhV4cDUy9zOJLQiCAAiT3i/PW5wrDvf1BPVaD/oY942bk1fJ+lqwDGyKnx0AC340udo
	 LNGqmFM4g2T+m40HBgDbadQA15A99mk8ab8uWKklDt+59hGUzardYURwRSWTROCJQLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266877;
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
	b=qIgSDCDs4GpazDNhCZEQK+eSGdWg/TPILYSTgcnnvb2UkEuPNUp/pjFV016evgrLguyI
	 HlQLbq/qIMrR10s4HwA65jtdyRrSryFD7yxw95Axr1P7xsoWpRoaBSoW+9cqPo1l1vkuV
	 6j68CdxYA1GpG58HilBGnncAk+boWtORsRm+yZrC/JjbcHtcx7QihMcL8Rpu+R5zaAb9B
	 ORR3VhhBam3+7v4Kcno8C+ZesFiHe5pHpxpUgYRLGgiVC9y9THIJMzIFzXjlFg8QP82kV
	 uG634cd53iOj0Jyu5l8ZjWWxpS+ZlUunWbtcmjO1oSbHBbiuZA4Su6tP3PxgahEGK2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266877;
	bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TE9idYdJ+U2j2Rx0oAt7LWIV0NtBf8r0mBOcMQ+Zahd3jfNrz2l6dp5Ip1JULwZsX
	 WJAjK8WY4w51j3xR+PiPQQiZaELI/bIq+CZWfGCrKN91GNawLU4V6RXh4V2yv+V1qM
	 VDi2fF5pD0+RTryhkQqBczjzxQZI9b9/BgM8ow8dijQz8YICrNwjYq2il+LO/yv5uI
	 KvnT7hbECYVTCWhUhlL2E1ZfcPF0lVGDxA/WOvdcoZT5nt7fNu8CLAlrQreTLH0ouu
	 L/IZstGH5YrcDI6Vc40M/TIBpiibaFYKJcfXqVQNiqkiv/cwvhNWhGAta9FRopymKm
	 YFLYMJ6MB4oAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA170606AE;
	Sat, 21 Nov 2026 13:14:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DB3E15D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8445B405AC
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2c6TocVpJ9gO for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 821C040596
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=abk/6KN5
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 821C040596
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:41 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50692e6c0aso30406866b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262080; x=1795866880;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
 b=abk/6KN5f1jie0Hz9jg9NH9rbDgzfCZbgj/KgWfhSYhTiVT6hgQsRPg5bbx5DPIr3p
 VizrYKffWsdNFFUwp3Exq/7wl5VeD7KXCNfTIQhWLM4FVSsxTyriidz4DyhAqfQMWNwI
 ZJzypZ6ZAA8KdHuw++6NKoiEQg3pajOfA5UKVJhrckg8k6RzP508t8PddwW4EKo8j/oo
 zIU7wtT9pHR+GjLNY/6UsHHtFEjxVhPn9mCj6hE5g1QWEzWFFdhFkeEGlwYnMh7ha2Kp
 MsdeNS2UOVNtUHmkuKhcTLlMQbKMLjJ1vdFLyHW1075AOskRAefnmbQkr5Q2sgfe4e9N
 8CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262080; x=1795866880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zThY7NI8KmF3WXeV7fevNI8BU3GJnH4iMgUWz7lQAJw=;
 b=uYuNa86/VvJgu3lBmNySFTHS1FKLHKj6Ck569bJV+7Xrg/j8ZkaLqjHTbsA2ZWdZxU
 XpfAIC9TXVsp4XakQmCcBW+IOV3DKZ2exmfZnIfsVBHnZ2QYZP1hjW6raIwHH5HlbyRL
 iD/8WRFni3gps9JZyj9g5tJFWBxanwn6ROyIwAsAo8nTqbSmzbN0rrYyL+A+CXMCE/n8
 gmVRKhnj2LYKlAq5c9MRIw7Yxj48pUXfCXhMhgwgP37fapyPRw10qPooNkwiEZfwlgSJ
 ou9O2idf9s5tmfPT1b7zFa00bwfS804ObpNSuAkRNHzteJCZTP2v1kBkHUl9AONFm9/z
 sIaQ==
X-Gm-Message-State: APuU4Z+Q3yLfe4oyh1MeF9PcGO0sjJjj4QKn5RnB3tr0vbeQW7DgNW5/
 jjsN2r21LFp219kigrcuSTWw8QYn1ATXVuNZXj3qTjJyYnWzWzpEQlFMxx0LNQhGtQfk5Pdqg8X
 25NmY
X-Gm-Gg: AZFdTZcVH/qgi+D2L2UOAjxHUyV77nL332PDb7PctEV1bIvV3Rm1btvibE+AsxDJFTD
 DwplHHysPweJuKRA/+/P5v4DjtITBr7egrGucAlgi5SbpKUzTHkP8Ehc3wLU8qpnRmYYqCtj8zj
 5BfvBNrwzxFwYfAghTpvkqYJa8Xq4xHgCcuP4qQ6/BfL8n6b94TQFbzulzQ94Yzbfkib7iBes56
 rwFASq0BY0msN9+K/Kd7J8h9VwtIJZ3g5kPAdwTRXNiRo2AZkba16VvZ+gkoC0exgy3dxWiO4zB
 omsPHnz9Jn6wK5Qw7W0s0HDrwq2Kx1SEg/souLvZ5w7k4z+6r6wMqG/ztmKV0C1Z768EDsBDMtO
 qOEBibG6AwMj4lW8hAL4Ah6u7Sx7sIA5nEgMIPNufnfytkJJBWAzRly44bZ/mnA+GQtvi5sbuIi
 YriN4ycFhLF7sKs6gPu1gWDH5lXBk3ioP4gB2l0ADqp3/CpF5cDPv6jHme84zKtgsdgHI2wQfGQ
 4oMgz8JaatLy5C02hQZ6ubigmMzFbFKtowiP4AugJUQ4dwX1zxXx1eVuoPY5cgqbtfjae9k1dLg
 BrVhdQ6DiD9CtIg86Vw1OK4nIgcGYBp+zda+TfTMTBSy5MndlJTzo617U5+cT7eI9WAD0jyy7ac
 NqHshMjpbxbfBT+2WmxJsyDqmpPr+SQA=
X-Received: by 2002:a17:906:c311:b0:c51:45d1:eca6 with SMTP id
 a640c23a62f3a-c5145d1f0a6mr365648266b.2.1795262080076; 
 Sat, 21 Nov 2026 03:54:40 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:39 -0800 (PST)
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
Subject: [PATCH v12 12/31] usb: dwc3: adapt io.h, the Makefile and the TI glue
Date: Sat, 21 Nov 2026 12:53:16 +0100
Message-ID: <20261121115335.548142-13-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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

