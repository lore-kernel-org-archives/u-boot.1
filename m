Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90853C369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562A28214F;
	Sun, 20 Apr 2025 13:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="G35qYduG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AAD88214F; Sun, 20 Apr 2025 13:58:28 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE7F82054
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 05eb66d9-1ddf-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 05eb66d9-1ddf-11f0-beb8-005056992ed3;
 Sun, 20 Apr 2025 14:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=oODLS6VKTv0U3wdHJFgx8Fk2qZoStpoNG/UO1OKdg4A=;
 b=G35qYduGv/+Ixne+UJXfFiewc7AH85MqDC7WbrG0VOyhYp9Oms0gs8dYciONBgpxeLkUyrajH362E
 IGfXqqJuHZ848qbi+I2YMMQKs+fk/X443Q3rsjf5KQG4We4C3z+gELanA2URdTillbQU4y9HvYy4SC
 vrTkg0/XByEMUDjE=
X-KPN-MID: 33|YiO+qyCuTkfYLHThbLeqcGbX5N7/x8u6iIUGWjNIrWzYi4+QX6bRwRf22yVcKSk
 IpsdC2T/wIfdvks8OzXqQ1ER2J4iefQaObC/rNt0RskY=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ZbugyT7sB/L906/UZLZybWOJDxuV7FB/TYMXQ9KymrEy364Hl5WGLP8tBGM1dRr
 s/S3a0BCxpAWCiRfBXa8vZA==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c414ff0d-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:25 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 6/6] arm: apple: rtkit: Support allocating OSLog out of SRAM
 in helper
Date: Sun, 20 Apr 2025 13:58:08 +0200
Message-ID: <20250420115808.94272-7-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420115808.94272-1-kettenis@openbsd.org>
References: <20250420115808.94272-1-kettenis@openbsd.org>
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

From: Hector Martin <marcan@marcan.st>

The new OSLog region in MTP (firmware 13.3+) persists on handoff to
Linux. To avoid having to come up with some weird DART handoff or DAPF
tricks, let's just steal some of the coprocessor's dedicated SRAM. This
keeps it happy and Linux doesn't need any special handoff then.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/mach-apple/rtkit_helper.c | 50 +++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-apple/rtkit_helper.c b/arch/arm/mach-apple/rtkit_helper.c
index 3b755008195..b7d60e15700 100644
--- a/arch/arm/mach-apple/rtkit_helper.c
+++ b/arch/arm/mach-apple/rtkit_helper.c
@@ -16,12 +16,60 @@
 #define REG_CPU_CTRL		0x0044
 #define  REG_CPU_CTRL_RUN	BIT(4)
 
+#define APPLE_RTKIT_EP_OSLOG 8
+
 struct rtkit_helper_priv {
 	void *asc;		/* ASC registers */
 	struct mbox_chan chan;
 	struct apple_rtkit *rtk;
+	bool sram_stolen;
 };
 
+static int shmem_setup(void *cookie, struct apple_rtkit_buffer *buf) {
+	struct udevice *dev = cookie;
+	struct rtkit_helper_priv *priv = dev_get_priv(dev);
+
+	if (!buf->is_mapped) {
+		/*
+		 * Special case: The OSLog buffer on MTP persists on Linux handoff.
+		 * Steal some SRAM instead of putting this in DRAM, so we don't
+		 * have to hand off DART/DAPF mappings.
+		 */
+		if (buf->endpoint == APPLE_RTKIT_EP_OSLOG) {
+			if (priv->sram_stolen) {
+				printf("%s: Tried to map more than one OSLog buffer out of SRAM\n",
+				       __func__);
+			} else {
+				fdt_size_t size;
+				fdt_addr_t addr;
+
+				addr = dev_read_addr_size_name(dev, "sram", &size);
+
+				if (addr != FDT_ADDR_T_NONE) {
+					buf->dva = ALIGN_DOWN(addr + size - buf->size, SZ_16K);
+					priv->sram_stolen = true;
+
+					return 0;
+				} else {
+					printf("%s: No SRAM, falling back to DRAM\n", __func__);
+				}
+			}
+		}
+
+		buf->buffer = memalign(SZ_16K, ALIGN(buf->size, SZ_16K));
+		if (!buf->buffer)
+			return -ENOMEM;
+
+		buf->dva = (u64)buf->buffer;
+	}
+	return 0;
+}
+
+static void shmem_destroy(void *cookie, struct apple_rtkit_buffer *buf) {
+	if (buf->buffer)
+		free(buf->buffer);
+}
+
 static int rtkit_helper_probe(struct udevice *dev)
 {
 	struct rtkit_helper_priv *priv = dev_get_priv(dev);
@@ -39,7 +87,7 @@ static int rtkit_helper_probe(struct udevice *dev)
 	ctrl = readl(priv->asc + REG_CPU_CTRL);
 	writel(ctrl | REG_CPU_CTRL_RUN, priv->asc + REG_CPU_CTRL);
 
-	priv->rtk = apple_rtkit_init(&priv->chan, priv, NULL, NULL);
+	priv->rtk = apple_rtkit_init(&priv->chan, dev, shmem_setup, shmem_destroy);
 	if (!priv->rtk)
 		return -ENOMEM;
 
-- 
2.49.0

