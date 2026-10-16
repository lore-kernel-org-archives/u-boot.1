Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF624CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E88D6128C;
	Fri, 16 Oct 2026 13:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9WOyaPaQld9; Fri, 16 Oct 2026 13:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA5EF612A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157068;
	b=nevbMGDtHuAY2YCbHrULlpFrpN6fqZzgbUs2+XXR4CCkZ5QnL7q82cL5XlhJoazCycny
	 jvwaclJY569Y0hQ2+xw2g9pE6ysDH1Z1NwcmjTJLj1Hquh7rE+GDJVz4sYv9D/grB1ZKd
	 OKLvqWpkNs2iIE1RtMLUWFuVmeSsPB/72vEE9hlCq6SrWU8BywvWD13HhWTid5+239rsp
	 5QXp4X6ezM70WkPlhv2Ez04DYtA+0AdheD9DFF+pQx8AhwrP1ebA8BSmFECeFkAdfjoiM
	 elhuk0wyc+KlrFlPOl7PyEV1TviiiwlXDgI05LI1qZWlevNPNdoNO1w6/LAlaE1vw4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jzb1jPTx4Lu/VpK6gDrZCHItR5/gwrp2RWkpDE8o1GM=;
	b=cIPLjoxfP1Zyi1i2p3D/0uIx9yfYlBPv0GW06lmtcczjLRSrq6lTIrk+4/43nWoAbbmn
	 rLzOE8fsCGx6oILBvUm5WMngDuhpjApdMduJbphh4fittOrYJPgEWRb8R69jUCq9/RIjX
	 tCChYlm1GI2VFl8jYXKiScEwoIgwuWfHJ9nYG1dnYxTb7layuNDomQ+D6ZNfekonkqYNE
	 Gg4jmvx0M92bcWTYTSLXrtnfHlUzMENQqgsF1/L5LtoUFolfuMqO/rj0Wb3CqotFDsY0j
	 mBq9VN0++0k92gGeHy3sefCKcQ51XGLSK1CNotm3Ko0n6ofrNS5Yaf2yQAzrisKLYqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157068;
	bh=Jzb1jPTx4Lu/VpK6gDrZCHItR5/gwrp2RWkpDE8o1GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WuEftX0u4zqiRgkTlPm5imu+XpViSKA5wOKLz+IUtyvBkQNyjd5xz9CV2ca8ayiPf
	 9o43OqPhKKjd+R8KKOLhh85V5hg5JPJ/YnTA1kAMEPsoyqWKBBpLhdlzpqBFF6UFYy
	 1YO5TGIsAbVsxI+ebDRGAluAvXJPJRQ+nJJ9ZYZ1tZnbzO/2GETy/GohXJNkzAreaq
	 IGkevFuCnz1tN0r+/xAyTH8+MM1+p2gB3+fm806BWZQa8e7VzW0DsNCkuGMoeEYz2R
	 z1CjVUmkhBo7TPKe3BadE3rFFs/Ax6qoxgtxapEO/pwLo2wJR6TvBMIBimXzd+Z/gi
	 Fmxi4uYvffAuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA5EF612A4;
	Fri, 16 Oct 2026 13:24:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C182D2A8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3C8940100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cy6_yhGnPOSn for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 977CD4046E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142231;
 b=nBBS/Ejoj01hgb7O1Woq4fR6/k48T2vo9ppPCAfuT8VgatdoTebbK6+qWGQGRCysx70W
 VGNhLldIdnlNpyagQJwZDCnKxcLaZ5SaaNQmh/TXEIGKa2CE1FMLEEKtnSeq1XFOkpAWh
 FhWZPLZ0v8LFFgyupFA6TTZWkrlbNN4+e+ep28tBG43PTWfiVxigzNuBcq4rSIYJQKAPo
 ZM0ciIT5sVKBTJuGQIP+8pG3w29kFT5c+nNKL9K0hQhBYvHhaoOOikTw3fJhckdNRXt7o
 /+8PkmoJOmwtDvHyurnFfHcjTvHXocRIwI1E/XxkeXYFlZYHvmBGZd9+1H8f5ldApoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142231;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Jzb1jPTx4Lu/VpK6gDrZCHItR5/gwrp2RWkpDE8o1GM=;
 b=m85ZfAGw58puJ/fiTMsbItrmI8uGw/jtWmsOtOg9m2+TdsLu6XRa+h9IOXXH09UR/NPW
 H77kzvAFC1cFCwErFrSSFpoN9BS1uTgNJly48f8rOXQIjJskrrLhIpGYFyar+pTyx1CzH
 rhfjmxHQCVWzz0Qf74Btnptkqenq4KJ4mtDmoZb0T6f6OgfDST1rTOcCfbJrfJu5geALR
 P11vfocga2ZT76ejGb0k93TabcTowm4gJMHCM/fUAT4EQP6uorm6BSX0f7/KUm0HZ0Evs
 fxhKpRju2tt746oKcSeLhr3+mqYh1r+tv4rQoTg8fULD/SksuiXJf9SW56pwgxsmUtA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iSpI4x93; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iSpI4x93
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 977CD4046E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:10 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso3960142f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142228; x=1792747028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jzb1jPTx4Lu/VpK6gDrZCHItR5/gwrp2RWkpDE8o1GM=;
 b=iSpI4x93fIbUV4Y+dAiEDAUUyYTC1rKx+rZGS3Y9U9BbbTjpNpLH8nPxfAnEmvWal5
 pmOnFzx4qc23P3kYIRNcgDP0OJfe51HYVByI3kVLtdHei17VHR2U7WFw+uE2mROi1Q8A
 jmnwoSlGOinD84Ny930EK+COqaGC4MxFJnpyF76FsWhqYkNmrf98XO5r/+FP9BmaCv1s
 N2xkJ38Ioaccsz0+irqD0p+eJ3OL1fvp4OA8JMZyhsTyRbmg6nVCqVE4f9TkramLOnUb
 Phf/ynUImjI5vleXio7PTFOoJCEUV9X3NmA+B1VjP5A4ZmqH4KeMlPm/O2/0kdKMEV/i
 lPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142228; x=1792747028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jzb1jPTx4Lu/VpK6gDrZCHItR5/gwrp2RWkpDE8o1GM=;
 b=LfD700nTHGNQ87am2fFq/E06osOP9J4ab2dkXk1Ps2B1nxiwPm27uxxsuF2htLT7k0
 52q/BPI3sIYveUFZoiXSAvH8/3lPWIJuz5xrTrbDXMaRiHSV8ItySz8jGQFBa8xH9GGE
 Gj8uTBkRRtPHRv0vhMawemWERwZdt75GPNJhTU1gbbpjEqdoIYvX9HNzCYN4U1rZnhBf
 oQrgHcsduIt6l3nqTZjebzPKsIC7BKwPUTBTfxIsM+0dOHXkI92fyQuA3T2ljrp7tAgA
 GeaUDrNTdVQh+IJm+kYY5+k6BZNOMnhL8vX2umjdNpB9JTUUb5Z+f0I3FC1Ha9pyG2ZR
 wF4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX5dpC75z6rr7n+buMTnXYB+0LSEj4NVfPiumKoAcuwxsAT41HDwFVwr54z3oAL0DwEAWcAs4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIhuPPAFR0YkC4qT0iWz4B+XKWydxhGlKTmpOH7xvvT5To3zl0u
 L0WRxt0+UjkuNBy7rqmxzrdp4PAToTdYVdZ/oP1VBWD+syvNPvIal9GA
X-Gm-Gg: AYBFou3DYttqJbDt8Qrsqm3OgWCnkULOKGCM5+iOaCFOPDxxEw+JlM8h15iTAhecEgZ
 L/HmSx/InXZ5wKppldcfQ5W/Pp73gsx1PJfENIWPV+7uRYspzNPojU0duY0MABRNlHXNuNqv8KM
 IHVwEz2+i7xmV3lh27XbnggRQ0lZnvSK9jv6/Lw5j9PKLy43t+XpobzZIkO0tIi+4brQBCs5lAX
 tfCsQ7ArW+NIjo6kK3bVKn4jwMx97o2rKqjPrIOBVTFzjqjhugPQCVA/S3Edn82HO046A5O4+nY
 EZ0DewKwm4DUb3KSIJa1i45B6w0Wzy9Gigxghf/1NI5MWvLlWxgnXDN/2i9z1rz+fydt3lpdqJc
 IHeU81ggO3VmBJpzB4dGBp/yHFUJh8aPyBS7Xuxp1w5j0lRBFyPC3KkkjqvRERFYWXVmT+jz5fT
 9KTHJPXMmXiDZuCby6VlpXpnRpfGhsIeR7qohZxfel4orsAq4Uvu+5bwUqV7g=
X-Received: by 2002:a05:6000:2209:b0:487:1575:ebef with SMTP id
 ffacd0b85a97d-48dbacf70c3mr41418713f8f.47.1792142228053; 
 Fri, 16 Oct 2026 02:17:08 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:17:06 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH 4/7] clk: sunxi: add the Allwinner B288 gates and resets
Date: Fri, 16 Oct 2026 10:16:05 +0100
Message-ID: <20261016091608.121842-5-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The bus clock gates and resets, as in the Linux CCU driver.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/clk/sunxi/Kconfig     |   7 +++
 drivers/clk/sunxi/Makefile    |   1 +
 drivers/clk/sunxi/clk_b288.c  | 101 ++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk_sunxi.c |   5 ++
 4 files changed, 114 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk_b288.c

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 1c1cc82719c..e4fe6f63626 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -52,6 +52,13 @@ config CLK_SUN8I_A23
 	  This enables common clock driver support for platforms based
 	  on Allwinner A23/A33 SoC.
 
+config CLK_SUN8I_B288
+	bool "Clock driver for Allwinner B288"
+	default MACH_SUN8I_B288
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner B288 SoC.
+
 config CLK_SUN8I_A83T
 	bool "Clock driver for Allwinner A83T"
 	default MACH_SUN8I_A83T
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 93b542cebcd..4f278ff551a 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CLK_SUN6I_A31) += clk_a31.o
 obj-$(CONFIG_CLK_SUN6I_A31_R) += clk_a31_r.o
 obj-$(CONFIG_CLK_SUN8I_A23) += clk_a23.o
 obj-$(CONFIG_CLK_SUN8I_A83T) += clk_a83t.o
+obj-$(CONFIG_CLK_SUN8I_B288) += clk_b288.o
 obj-$(CONFIG_CLK_SUN8I_R40) += clk_r40.o
 obj-$(CONFIG_CLK_SUN8I_V3S) += clk_v3s.o
 obj-$(CONFIG_CLK_SUN9I_A80) += clk_a80.o
diff --git a/drivers/clk/sunxi/clk_b288.c b/drivers/clk/sunxi/clk_b288.c
new file mode 100644
index 00000000000..505fa27f83a
--- /dev/null
+++ b/drivers/clk/sunxi/clk_b288.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner B288 (sun8iw10p1) CCU gates and resets
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <clk/sunxi.h>
+#include <dt-bindings/clock/sun8i-b288-ccu.h>
+#include <dt-bindings/reset/sun8i-b288-ccu.h>
+#include <linux/bitops.h>
+
+static const struct ccu_clk_gate b288_gates[] = {
+	[CLK_BUS_DMA]		= GATE(0x060, BIT(6)),
+	[CLK_BUS_SDMMC0_BUS]	= GATE(0x060, BIT(8)),
+	[CLK_BUS_SDMMC1_BUS]	= GATE(0x060, BIT(9)),
+	[CLK_BUS_SDMMC2_BUS]	= GATE(0x060, BIT(10)),
+	[CLK_BUS_SDMMC3_BUS]	= GATE(0x060, BIT(11)),
+	[CLK_BUS_NAND]		= GATE(0x060, BIT(13)),
+	[CLK_BUS_SDRAM]		= GATE(0x060, BIT(14)),
+	[CLK_BUS_PSRAM]		= GATE(0x060, BIT(15)),
+	[CLK_BUS_SPI0]		= GATE(0x060, BIT(20)),
+	[CLK_BUS_SPI1]		= GATE(0x060, BIT(21)),
+	[CLK_BUS_SPI2]		= GATE(0x060, BIT(22)),
+	[CLK_BUS_USBOTG]	= GATE(0x060, BIT(24)),
+	[CLK_BUS_USBEHCI0]	= GATE(0x060, BIT(26)),
+	[CLK_BUS_USBOHCI0]	= GATE(0x060, BIT(29)),
+	[CLK_BUS_TCON0]		= GATE(0x064, BIT(4)),
+	[CLK_BUS_CSI]		= GATE(0x064, BIT(8)),
+	[CLK_BUS_DE]		= GATE(0x064, BIT(12)),
+	[CLK_BUS_EE]		= GATE(0x064, BIT(13)),
+	[CLK_BUS_ADDA]		= GATE(0x068, BIT(0)),
+	[CLK_BUS_SPDIF]		= GATE(0x068, BIT(1)),
+	[CLK_BUS_DSD]		= GATE(0x068, BIT(2)),
+	[CLK_BUS_DMIC]		= GATE(0x068, BIT(3)),
+	[CLK_BUS_PIO]		= GATE(0x068, BIT(5)),
+	[CLK_BUS_THS]		= GATE(0x068, BIT(8)),
+	[CLK_BUS_KEYADC]	= GATE(0x068, BIT(9)),
+	[CLK_BUS_GPADC]		= GATE(0x068, BIT(10)),
+	[CLK_BUS_I2S0]		= GATE(0x068, BIT(12)),
+	[CLK_BUS_I2S1]		= GATE(0x068, BIT(13)),
+	[CLK_BUS_TWI0]		= GATE(0x06c, BIT(0)),
+	[CLK_BUS_TWI1]		= GATE(0x06c, BIT(1)),
+	[CLK_BUS_TWI2]		= GATE(0x06c, BIT(2)),
+	[CLK_BUS_UART0]		= GATE(0x06c, BIT(16)),
+	[CLK_BUS_UART1]		= GATE(0x06c, BIT(17)),
+	[CLK_BUS_UART2]		= GATE(0x06c, BIT(18)),
+	[CLK_BUS_UART3]		= GATE(0x06c, BIT(19)),
+	[CLK_BUS_UART4]		= GATE(0x06c, BIT(20)),
+	[CLK_BUS_UART5]		= GATE(0x06c, BIT(21)),
+};
+
+static const struct ccu_reset b288_resets[] = {
+	[RST_USBPHY0]		= RESET(0x0cc, BIT(0)),
+	[RST_MBUS]		= RESET(0x0fc, BIT(31)),
+	[RST_BUS_DMA]		= RESET(0x2c0, BIT(6)),
+	[RST_BUS_MMC0]		= RESET(0x2c0, BIT(8)),
+	[RST_BUS_MMC1]		= RESET(0x2c0, BIT(9)),
+	[RST_BUS_MMC2]		= RESET(0x2c0, BIT(10)),
+	[RST_BUS_MMC3]		= RESET(0x2c0, BIT(11)),
+	[RST_BUS_NAND]		= RESET(0x2c0, BIT(13)),
+	[RST_BUS_DRAM]		= RESET(0x2c0, BIT(14)),
+	[RST_BUS_PSRAM]		= RESET(0x2c0, BIT(15)),
+	[RST_BUS_SPI0]		= RESET(0x2c0, BIT(20)),
+	[RST_BUS_SPI1]		= RESET(0x2c0, BIT(21)),
+	[RST_BUS_SPI2]		= RESET(0x2c0, BIT(22)),
+	[RST_BUS_OTG]		= RESET(0x2c0, BIT(24)),
+	[RST_BUS_EHCI0]		= RESET(0x2c0, BIT(26)),
+	[RST_BUS_OHCI0]		= RESET(0x2c0, BIT(29)),
+	[RST_BUS_WLAN]		= RESET(0x2c4, BIT(1)),
+	[RST_BUS_TCON0]		= RESET(0x2c4, BIT(4)),
+	[RST_BUS_CSI]		= RESET(0x2c4, BIT(8)),
+	[RST_BUS_DE]		= RESET(0x2c4, BIT(12)),
+	[RST_BUS_EE]		= RESET(0x2c4, BIT(13)),
+	[RST_BUS_ADDA]		= RESET(0x2d0, BIT(0)),
+	[RST_BUS_SPDIF]		= RESET(0x2d0, BIT(1)),
+	[RST_BUS_DSD]		= RESET(0x2d0, BIT(2)),
+	[RST_BUS_DMIC]		= RESET(0x2d0, BIT(3)),
+	[RST_BUS_THS]		= RESET(0x2d0, BIT(8)),
+	[RST_BUS_KEYADC]	= RESET(0x2d0, BIT(9)),
+	[RST_BUS_GPADC]		= RESET(0x2d0, BIT(10)),
+	[RST_BUS_I2S0]		= RESET(0x2d0, BIT(12)),
+	[RST_BUS_I2S1]		= RESET(0x2d0, BIT(13)),
+	[RST_BUS_I2C0]		= RESET(0x2d8, BIT(0)),
+	[RST_BUS_I2C1]		= RESET(0x2d8, BIT(1)),
+	[RST_BUS_I2C2]		= RESET(0x2d8, BIT(2)),
+	[RST_BUS_UART0]		= RESET(0x2d8, BIT(16)),
+	[RST_BUS_UART1]		= RESET(0x2d8, BIT(17)),
+	[RST_BUS_UART2]		= RESET(0x2d8, BIT(18)),
+	[RST_BUS_UART3]		= RESET(0x2d8, BIT(19)),
+	[RST_BUS_UART4]		= RESET(0x2d8, BIT(20)),
+	[RST_BUS_UART5]		= RESET(0x2d8, BIT(21)),
+};
+
+const struct ccu_desc b288_ccu_desc = {
+	.gates = b288_gates,
+	.resets = b288_resets,
+	.num_gates = ARRAY_SIZE(b288_gates),
+	.num_resets = ARRAY_SIZE(b288_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index 046d5d1605a..5f40f30fe89 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -117,6 +117,7 @@ extern const struct ccu_desc a64_ccu_desc;
 extern const struct ccu_desc a80_ccu_desc;
 extern const struct ccu_desc a80_mmc_clk_desc;
 extern const struct ccu_desc a83t_ccu_desc;
+extern const struct ccu_desc b288_ccu_desc;
 extern const struct ccu_desc d1_ccu_desc;
 extern const struct ccu_desc f1c100s_ccu_desc;
 extern const struct ccu_desc h3_ccu_desc;
@@ -154,6 +155,10 @@ static const struct udevice_id sunxi_clk_ids[] = {
 	{ .compatible = "allwinner,sun8i-a33-ccu",
 	  .data = (ulong)&a23_ccu_desc },
 #endif
+#ifdef CONFIG_CLK_SUN8I_B288
+	{ .compatible = "allwinner,sun8i-b288-ccu",
+	  .data = (ulong)&b288_ccu_desc },
+#endif
 #ifdef CONFIG_CLK_SUN8I_A83T
 	{ .compatible = "allwinner,sun8i-a83t-ccu",
 	  .data = (ulong)&a83t_ccu_desc },
-- 
2.52.0

