Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC32606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x0uwt61r;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=IUzQev7Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02EC540D7D;
	Sat, 21 Nov 2026 12:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1zM6YVEhxX2; Sat, 21 Nov 2026 12:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 940D140E10
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264533;
	b=L33ms8lBlrKZForUps9kY7GEeqhnRB6TuQRlVgNmrsQQeMDpGaE+/Hayc9PFzo3GA5mY
	 P0Ollv05h9WlMHEQwjnN9tlTneNuQbzopT0SEFrh+Qo0/k3abE93l/36mn+9hJxyUswEj
	 1qpDqx8HXPN/HSk2sbRTIEjx/QWPVCdysHYN33wyOmAlXP13ozp4nFFaWFKUDo2e5GB+8
	 +bgdHiUtr/2Hby+dzcuOHMouiJqVpQ5Rv/TIqpG4RifCNHcw1vSvUKmeYA5b9jstFApq5
	 yCE02EBuRrPT+wjQsoth7eVBT0X+lYF9VJEKK0TCamaI57Nw5i2WGOoe2W/URiWelNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q9ojRJxSIXeaN3FLRbHtPOqjzRfF/FkW1BmpRAX0qXM=;
	b=ilABgugrEsX9URdJu12mLdLIcITqzRxJA2TQzodNi0PtJ5hGcyiLr6KcTJxoQMgDMaZr
	 UmKDfKzuRtJzTLNY01YH/CMrlQ/Ie+xCkmAsXrRNNWjTrtVrWu2nBPx7F35IyJ1UW+2xL
	 7CVRQdlTLktMPlLRMFUJEUylLjiWv4CAoyreQh5wW/TQiKYGBsC3Ovmb4LQMK8Qr4KbD1
	 7TvVCfbu0S0xgcn8LWOveID4ymdS8nG4NNGRzaDfFN7byWnXFuzHp/51YzsaIOirNi8BM
	 tzOL3DLW/u0GH4QDQGkeOv7E1YycUiEbefPkKAP5C5Dgq5ls7aFGERmZ/u20fKZSb2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=IUzQev7Q;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264532;
	bh=q9ojRJxSIXeaN3FLRbHtPOqjzRfF/FkW1BmpRAX0qXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0uwt61rImC74HORO8GaF7k/d0/rMq5YqLMV7LdLF6T0pbVmnDCRZmVMgXxRU+DNm
	 HEsZRPJS/ItlmwNu1/Xu0k/LGAZhBxpJSsg/8gsdCZysH1AlOfu6mpFTBjxWYnnYw4
	 ATGRkCMonw2Igego7HQIfswF+FS6s06N4FBTaUPGLLFkx6vZrxEHHIgpFNVMIIH1K2
	 6O/qHA/wJeC99UN7ZVmG6OLSe0JIaUx8K2cEiCOT8/LgKh1A9XotRGJpG4nQ8GjfIz
	 uNI1PSVT3IlxejQAM8KJOUHlItPx2SePH0fk+4O+68UwVBtSk/6K2+O0NwDn+FGIhj
	 RB3sRJfPYaKAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 940D140E10;
	Sat, 21 Nov 2026 12:35:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74EE1759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E45F40A4B
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5hI0LcdKZEH for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9960D40D0C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=IUzQev7Q
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9960D40D0C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:21 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so969007f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264519; x=1795869319;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q9ojRJxSIXeaN3FLRbHtPOqjzRfF/FkW1BmpRAX0qXM=;
 b=IUzQev7QHz8Vpy7FYEj6wIT7HhmqO73k7cHVbQYaU/IvQFjiR9LnIxUTkL8I4/h06D
 iZ3IzzwrhJY0QlCHOI3iBlNgB3rN7bVWAWtNBFakmJLFW+KOY4lMuhR2A4XKPgUa256p
 IE7BqXXu++lPU114KpZUSlZTcuUUv9c/ehv2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264519; x=1795869319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q9ojRJxSIXeaN3FLRbHtPOqjzRfF/FkW1BmpRAX0qXM=;
 b=1utXtpKsYPgTtbPo9VflHf0k/j1qp+JWxNCJlDevtRpguwozbXQez0smXXzfc7cEGx
 rphQ+G2jhnyOq96/RfFZTcQwzO1t+qZ334gVNfqV98dRhzA1lerQ5+kP/R+TafFY9zuR
 5231x+l9RgGWklMAl3q6QtsQODOwAJmqTcoioK6k5mMas0SK/kw/aYqLAVErMKuj/67S
 JvhPDiP9PJ5dG0pZnejfVMZExqvOW3kIVHGzFd3ZTKoYSv8JzYTX5ZflvM7QCZkyztyo
 6HFQNMHEho3/QlnFDuapv3OikF5E7Ts6shTp8nudZ+YClWyhKfvhBaLFbzaaCTpqSMM/
 tBFw==
X-Gm-Message-State: APuU4Z/MpaL3a/0AmYkbMo8ABhWsbZ8XQ7/iG7Obsq2HJoGyQqDYOYPv
 JVYNW4iPqIgAY5R8260itgtzO0k4tm/8ck82nb+FFLiIjDY8iG6gXVaNDx6Q0iOLHtQ9dIg1lIx
 MTNVc
X-Gm-Gg: AZFdTZeOAHJbAzeX7Iqu9eaK2UJeYOhNL0BuaMAwB/dY6WRO3xudaVo0J56bPgKdBiu
 FnmtBb2PANDTUcgKRx0aor8xb93zlo0CHH42mTudRsS15JNmptCTrpt+HzzDG/MLBEnmHvpCcJV
 YvI2Xm2u3lNXSGgvVseQRp7c8lWHsEBS2t6WamU7W4FJCUvNTC0J8HaSEFcl/N+ladWftM5TbDD
 HKCr4FqqmuiAOve8wsCv8JuLdmb6wDIA6mFzKc0OA50/7H35dzQrsm6jSXQ4XRLhBK4cjbsU5lh
 uQbitocbUMRifhQZmWF+ftUFq6eFlB+2BwPKgDwBnduhqVa8lXBmRnCgDCBpnK4wXNVc4lOx/lz
 CiQUtDx/SWbag+r2X9mVUUn2LLPYzTBVB5RVvkPHJZBlNu/TU4+8twIIDbPZJg2Tw/kOu7PcIBO
 d/LHTON2itTHS+cP9fEm5Q2p9c9sHE5u3ite4TMpzvNlIXl2oyynv1mcDq17BX85hgw/nFINbkx
 c3aiPJVNOnw+DVE28JvtUPCcMI4XYmQv2yTe6rhVV9vJN/3ExqTc/Hqw7SbwAzZEZT0zMINpbMf
 3BquuWcltb/9CXiGmdpfAW3SqwsHJdWFY7cBupRk7zrWIuSo09JnvykYjEWwLpv/CXW5lGeBi43
 An0NzslO3EBG3hl1B4Qj8027ociHkGt65pa6/vHVtDtFll9Vz0wY+k6veVrVD70lP8S0tUifJ9B
 tzl/YOKSHjJq5EmMzoONGiXlOWmQ==
X-Received: by 2002:a05:6000:2c0a:b0:4a7:73d5:703a with SMTP id
 ffacd0b85a97d-4abb1ab66d9mr12102204f8f.23.1795264519170; 
 Sat, 21 Nov 2026 04:35:19 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/25] video: Update mxsfb video drivers for iMX8MM/iMX8MN
 display
Date: Sat, 21 Nov 2026 13:34:02 +0100
Message-ID: <20261121123451.2471185-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Update mxsfb for LCD video driver

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Move the coding style fix and the DE polarity change to separate
  patches

 drivers/video/mxsfb.c | 129 ++++++++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 41 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index bc082c334577..55ac99bbbf70 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -21,8 +21,13 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/dma.h>
 #include <asm/io.h>
+#include <reset.h>
+#include <panel.h>
+#include <video_bridge.h>
+#include <video_link.h>
 
 #include "videomodes.h"
+#include <dm/device-internal.h>
 
 #define	PS2KHZ(ps)	(1000000000UL / (ps))
 #define HZ2PS(hz)	(1000000000UL / ((hz) / 1000))
@@ -30,6 +35,11 @@
 #define BITS_PP		18
 #define BYTES_PP	4
 
+struct mxsfb_priv {
+	fdt_addr_t reg_base;
+	struct udevice *disp_dev;
+};
+
 struct mxs_dma_desc desc;
 
 /**
@@ -56,9 +66,10 @@ __weak void mxsfb_system_setup(void)
  */
 
 static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
-			 struct display_timing *timings, int bpp)
+			 struct display_timing *timings, int bpp, bool bridge)
 {
-	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)MXS_LCDIF_BASE;
+	struct mxsfb_priv *priv = dev_get_priv(dev);
+	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)priv->reg_base;
 	const enum display_flags flags = timings->flags;
 	uint32_t word_len = 0, bus_width = 0;
 	uint8_t valid_data = 0;
@@ -109,7 +120,7 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 	}
 #else
 	/* Kick in the LCDIF clock */
-	mxs_set_lcdclk(MXS_LCDIF_BASE, timings->pixelclock.typ / 1000);
+	mxs_set_lcdclk(priv->reg_base, timings->pixelclock.typ / 1000);
 #endif
 
 	/* Restart the LCDIF block */
@@ -142,9 +153,13 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 		LCDIF_CTRL_BYPASS_COUNT | LCDIF_CTRL_LCDIF_MASTER,
 		&regs->hw_lcdif_ctrl);
 
-	writel(valid_data << LCDIF_CTRL1_BYTE_PACKING_FORMAT_OFFSET,
+	writel((valid_data << LCDIF_CTRL1_BYTE_PACKING_FORMAT_OFFSET) |
+		LCDIF_CTRL1_RECOVER_ON_UNDERFLOW,
 		&regs->hw_lcdif_ctrl1);
 
+	if (bridge)
+		writel(LCDIF_CTRL2_OUTSTANDING_REQS_REQ_16, &regs->hw_lcdif_ctrl2);
+
 	mxsfb_system_setup();
 
 	writel((timings->vactive.typ << LCDIF_TRANSFER_COUNT_V_COUNT_OFFSET) |
@@ -198,10 +213,10 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 }
 
 static int mxs_probe_common(struct udevice *dev, struct display_timing *timings,
-			    int bpp, u32 fb)
+			    int bpp, u32 fb, bool bridge)
 {
 	/* Start framebuffer */
-	mxs_lcd_init(dev, fb, timings, bpp);
+	mxs_lcd_init(dev, fb, timings, bpp, bridge);
 
 #ifdef CONFIG_VIDEO_MXS_MODE_SYSTEM
 	/*
@@ -212,7 +227,8 @@ static int mxs_probe_common(struct udevice *dev, struct display_timing *timings,
 	 * sets the RUN bit, then waits until it gets cleared and repeats this
 	 * infinitelly. This way, we get smooth continuous updates of the LCD.
 	 */
-	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)MXS_LCDIF_BASE;
+	struct mxsfb_priv *priv = dev_get_priv(dev);
+	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)priv->reg_base;
 
 	memset(&desc, 0, sizeof(struct mxs_dma_desc));
 	desc.address = (dma_addr_t)&desc;
@@ -229,9 +245,9 @@ static int mxs_probe_common(struct udevice *dev, struct display_timing *timings,
 	return 0;
 }
 
-static int mxs_remove_common(u32 fb)
+static int mxs_remove_common(phys_addr_t reg_base, u32 fb)
 {
-	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)MXS_LCDIF_BASE;
+	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)(reg_base);
 	int timeout = 1000000;
 
 	if (!fb)
@@ -258,6 +274,7 @@ static int mxs_of_get_timings(struct udevice *dev,
 	int ret = 0;
 	u32 display_phandle;
 	ofnode display_node;
+	struct mxsfb_priv *priv = dev_get_priv(dev);
 
 	ret = ofnode_read_u32(dev_ofnode(dev), "display", &display_phandle);
 	if (ret) {
@@ -278,10 +295,19 @@ static int mxs_of_get_timings(struct udevice *dev,
 		return -EINVAL;
 	}
 
-	ret = ofnode_decode_display_timing(display_node, 0, timings);
-	if (ret) {
-		dev_err(dev, "failed to get any display timings\n");
-		return -EINVAL;
+	priv->disp_dev = video_link_get_next_device(dev);
+	if (priv->disp_dev) {
+		ret = video_link_get_display_timings(timings);
+		if (ret) {
+			dev_err(dev, "failed to get any video link display timings\n");
+			return -EINVAL;
+		}
+	} else {
+		ret = ofnode_decode_display_timing(display_node, 0, timings);
+		if (ret) {
+			dev_err(dev, "failed to get any display timings\n");
+			return -EINVAL;
+		}
 	}
 
 	return ret;
@@ -291,20 +317,58 @@ static int mxs_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct mxsfb_priv *priv = dev_get_priv(dev);
 
 	struct display_timing timings;
 	u32 bpp = 0;
 	u32 fb_start, fb_end;
 	int ret;
+	bool enable_bridge = false;
 
 	debug("%s() plat: base 0x%lx, size 0x%x\n",
 	       __func__, plat->base, plat->size);
 
+	priv->reg_base = dev_read_addr(dev);
+	if (priv->reg_base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "lcdif base address is not found\n");
+		return -EINVAL;
+	}
+
 	ret = mxs_of_get_timings(dev, &timings, &bpp);
 	if (ret)
 		return ret;
 
-	ret = mxs_probe_common(dev, &timings, bpp, plat->base);
+	if (priv->disp_dev) {
+		if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
+			if (device_get_uclass_id(priv->disp_dev) == UCLASS_VIDEO_BRIDGE) {
+				ret = video_bridge_attach(priv->disp_dev);
+				if (ret) {
+					dev_err(dev, "fail to attach bridge\n");
+					return ret;
+				}
+
+				ret = video_bridge_set_backlight(priv->disp_dev, 80);
+				if (ret) {
+					dev_err(dev, "fail to set backlight\n");
+					return ret;
+				}
+
+				enable_bridge = true;
+				video_bridge_check_timing(priv->disp_dev, &timings);
+			}
+		}
+
+		if (device_get_uclass_id(priv->disp_dev) == UCLASS_PANEL) {
+			ret = panel_enable_backlight(priv->disp_dev);
+			if (ret) {
+				dev_err(dev, "panel %s enable backlight error %d\n",
+					priv->disp_dev->name, ret);
+				return ret;
+			}
+		}
+	}
+
+	ret = mxs_probe_common(dev, &timings, bpp, plat->base, enable_bridge);
 	if (ret)
 		return ret;
 
@@ -342,33 +406,9 @@ static int mxs_video_probe(struct udevice *dev)
 static int mxs_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
-	struct display_timing timings;
-	u32 bpp = 0;
-	u32 bytes_pp = 0;
-	int ret;
 
-	ret = mxs_of_get_timings(dev, &timings, &bpp);
-	if (ret)
-		return ret;
-
-	switch (bpp) {
-	case 32:
-	case 24:
-	case 18:
-		bytes_pp = 4;
-		break;
-	case 16:
-		bytes_pp = 2;
-		break;
-	case 8:
-		bytes_pp = 1;
-		break;
-	default:
-		dev_err(dev, "invalid bpp specified (bpp = %i)\n", bpp);
-		return -EINVAL;
-	}
-
-	plat->size = timings.hactive.typ * timings.vactive.typ * bytes_pp;
+	/* Max size supported by LCDIF, because in bind, we can't probe panel */
+	plat->size = 1920 * 1080 * 4 * 2;
 
 	return 0;
 }
@@ -376,8 +416,12 @@ static int mxs_video_bind(struct udevice *dev)
 static int mxs_video_remove(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct mxsfb_priv *priv = dev_get_priv(dev);
+
+	if (priv->disp_dev)
+		device_remove(priv->disp_dev, DM_REMOVE_NORMAL);
 
-	mxs_remove_common(plat->base);
+	mxs_remove_common(priv->reg_base, plat->base);
 
 	return 0;
 }
@@ -388,6 +432,8 @@ static const struct udevice_id mxs_video_ids[] = {
 	{ .compatible = "fsl,imx6sx-lcdif" },
 	{ .compatible = "fsl,imx7ulp-lcdif" },
 	{ .compatible = "fsl,imxrt-lcdif" },
+	{ .compatible = "fsl,imx8mm-lcdif" },
+	{ .compatible = "fsl,imx8mn-lcdif" },
 	{ /* sentinel */ }
 };
 
@@ -399,4 +445,5 @@ U_BOOT_DRIVER(mxs_video) = {
 	.probe	= mxs_video_probe,
 	.remove = mxs_video_remove,
 	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
+	.priv_auto   = sizeof(struct mxsfb_priv),
 };
-- 
2.43.0

