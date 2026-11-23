Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC62606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tVK5RYAm;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IyaeY8//
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B534580DBB;
	Mon, 23 Nov 2026 10:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFZvgrGBsxk3; Mon, 23 Nov 2026 10:22:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55CC280E19
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429374;
	b=QYQ/UVvWD/2SDAXrfH7XWYpyirsOJUpxHZH9IaAtkCCINMMcIEd8vu08lPOl0RWRtDzK
	 I9Inb5PkvShDuSm7D97bt3lUpmf38ydp1JFEcT4yAQ8qdkl4eX8m2P4kB7t3QrFprLIv2
	 ryM+qceBEdcAuWx3NCN4tK7uV9gjM31QEq7ED1FcW+pt2f8LVnajelFzwLlJKZt7jU9Y5
	 1NemCFFdD+nFIauO6Gv2/Ot+HR/4A1RWZB3hkGoNZF+iQjjyewVCdvGwTaWnHUMk1C674
	 39WWSD5nosefjtjq1Lp7tOACUPMY3wpuclDEbT2mK+Y6GuXikY/YkIc75tQbrNCeB7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ji8VMB+gaclL4rMycJ15erFND40TpBFGjBoB4mbTjRY=;
	b=nMfrvXPF1PvXqkLA1ahwH+3sA0HADeiq2A89k58aEDNBe8/0FdGx5K3XSblzMbj9xAn2
	 awziqGAoRM7gMN1R2aI0wGVK4Y/3tuUkhSTylKdjDcKz7VcBYmFbxq/D/Gm39pASdpZAi
	 fHIu4XhGfycxedJvyksJ60ktlF0ULUI+1GtHoqa7Z7ZFXMksoa6AX4ldeNc1SSJf7UfxX
	 7QX7c+rgz2x+n54YLqVSKc+o3ZFX2R+AgFLf1zLNPp8BIDk1jWXVkzZAiV/n24WX9LJC0
	 9AtfyPd72QXDRsSZX5HtXFvlvW7akejsIcqOUP+PrfE5fm4MhsXQCYhnMdXsQmIQ4zw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429374;
	bh=Ji8VMB+gaclL4rMycJ15erFND40TpBFGjBoB4mbTjRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tVK5RYAmxWpl/3oN3C7CRHGb/6SnCZYmiS3ELlcTuo4yYGxCFx4ckyt4Uud37wVfP
	 gsPi5LzbuiQRlFLwjBSatsudDszeZyrAS1Y82Gc/j4xV3qjePzFmxeqR8RBlrUOhrr
	 TLTaYWzkCLPrIUgG1zIa7+oa2CcRxeqa3f9VXqU8Bl/ZQ3WLk31CF0hZ9tRCUujFg0
	 vAGcZgIDSMe65+w9I/SQ9SWGM4LSs36JWNPVDYaA3ImksYqUfYQvPmW6yfMa1Zedwl
	 tzgi/9o08mIicyepZVNwVKIuQf0TCiFd43zE7koU5/j4gnNtHln15XBv6V+3x90ibV
	 Thv65CuUtn5LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55CC280E19;
	Mon, 23 Nov 2026 10:22:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AF8522B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 705A440208
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o6YWJNrFo8Dk for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BBDF1401BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IyaeY8//
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBDF1401BE
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso37331265e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429364; x=1796034164;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ji8VMB+gaclL4rMycJ15erFND40TpBFGjBoB4mbTjRY=;
 b=IyaeY8//EDC+O+/AiPHr3E6A/I0isSzySRB8zxaElZEaSmGQhNXGXsbrpwsnOFn1Jo
 fd6M1dau7Py53q1I6sFbKzxiMYW5dbjCoBbR700DI7CICj0X/WM2CWR4305KPbOGvR82
 vW5sBnnoXucV+jqtgHsKwRglB9QWz/s0MPE0s5KLYVmZCM9KoWZe7mQSFqu9+rpZqcoH
 V+NJk27iIdnNfFgKc4hV0jomrKa+BQ9jjR7UkucgJbWLl0RTLpajwnNdPczRiNtg/uZ9
 QCd1e2T5KbO3yaztK7jmW21drDVC0S++3TOv4n9i9uJeVZosSRLA+6ocfnNRXBhwJbZ5
 h6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429364; x=1796034164;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ji8VMB+gaclL4rMycJ15erFND40TpBFGjBoB4mbTjRY=;
 b=DVNhbVlXZzM9uYYHS2GawbsaOu/5pK5ELsraVCf+kv/rHLM88PnvrjtVkdDsTHKv+F
 6EXjTY3bbavsamuyRCDKmD5ecfXzHdWS3lwGdW5zR/5Qrf9zSEs0A+QiWtzIwktk5vDg
 5C3SmfMmuf4IdrTP+uv6N33p0Jt6bCazunrWeR/AACH9wTIqV+PHOzvo2Ze9a/ITfMnJ
 /a13HjT2343qMharRU5eSpUnfMTv58tGTq1rVkqYWkISVBw8FXX00OkPh1nUAJTw5eOI
 G6uC9TLjgLmoWhoSslzsRC/3Y8TcXdquQ8Wh77knobr07I9T/RooBETdpTiFcSoYLQ1P
 9qCw==
X-Forwarded-Encrypted: i=1;
 AL+hErGAg/LcI2GsNapsUzWXCzs7LjUrV+B8/1iMti3CQcbEUfq3pJR3sv2XZTdij59U9mrd6EYWpEo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/HGZ7fSxaWbyvxowsmcTqPy8xQwdXIUiQDS3/cuNJROBtRSKfu
 oj9SxKjMgpPx8vfxSNwxozpVH5+09OABNcIydk+cbe0PsViR4G8WlqJc265wvl3T1T8=
X-Gm-Gg: AZFdTZcQIdvDk8NHjVOp59JxAAUJMBxFV0FPraRwNcpaCJfGB0nFt9WPydkN9knZiWa
 20JI1TJLFY8f6IlCEvZ+x5OQcmY/bfGFvIaFaILHcfq0MVIv8LZTn/GPPzI+DgOs5dbwVRnQWrf
 DrnZD+bxmOP1G7xFuSL9Hz1PPIM4nXKcL0rfu5Kudo9FozJULnCd8GY92b5R2q68OGprToCERhI
 SqtDM0cR5zUxOcnK93h0TzoIJ7+AGrYh6z4htV3xm4ROfYzDdLX3hb3T+DyYgHgVp+7/gjt/pcg
 szFIbYy3CEMfIz6rOKEJ4PWESJvmOeOz8hqKxUcxT3VuObzlfOpFZlhDwKQP8gHoyc6bLfHGDlG
 xMMZtbqKPXXczZWMhU4VXCl23H79Fs9C2XCeYFHxvse6mMOrcgC14CrEtrbBZo2qSvKFksaB5eM
 1RCN10JRNRLJH85ETqtJ8dJaF4yOybEN+F9xYZHYcsCZmy5SnISiz7j3jC0borT8c+v3ro460KQ
 +pG7UsSROFE8U024WdiIO5D2Ea66HUlliBTq0xiEziOjbZS5N/p2KefIOFeDlJldfG0dQTwbXwT
 CAEmK1vkGVBUH1Ftz7dKh3oLPdPCSV+8G8bFW7V93lyXp9TTXusj+UDR9/PUle0+jltk1N/o8nj
 zfdCAfJBFtLwcF3/6QvyCXJxrGEiK4J5Iniz774fBSlw9MQ9L5nkLoTy9og57DK0BZAI=
X-Received: by 2002:a05:600c:848d:b0:4bb:6687:5386 with SMTP id
 5b1f17b1804b1-4bb8880c7f1mr242479025e9.19.1795429364371; 
 Mon, 23 Nov 2026 02:22:44 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:43 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:19 +0100
Subject: [PATCH v2 4/8] i2c: mediatek: support the MT8188 controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-4-7d3f843db7ef@baylibre.com>
References: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
In-Reply-To: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 720 uses the MT8188 I2C controller. Add support for its
register layout, bus timing and DMA handshake. Restore the bus timing
registers after a controller reset.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 324 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 316 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index dd158c6d32..e36705d7a5 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -16,8 +16,34 @@
 #include <memalign.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+
+#define I2C_DMA_WARM_RST		BIT(0)
+#define I2C_DMA_HANDSHAKE_RST		BIT(2)
+#define I2C_DMA_ASYNC_MODE		BIT(2)
+#define I2C_DMAACK_ENABLE		BIT(3)
+#define I2C_DMA_SKIP_CONFIG		BIT(4)
+#define I2C_RELIABILITY			BIT(4)
+#define I2C_HANDSHAKE_RST		BIT(5)
+#define I2C_DMA_DIR_CHANGE		BIT(9)
+
+#define I2C_TIMING_HIGH_CNT		GENMASK(5, 0)
+#define I2C_TIMING_SAMPLE_CNT		GENMASK(10, 8)
+#define I2C_HS_HIGH_CNT			GENMASK(10, 8)
+#define I2C_HS_SAMPLE_CNT		GENMASK(14, 12)
+#define I2C_LTIMING_LOW_CNT		GENMASK(5, 0)
+#define I2C_LTIMING_SAMPLE_CNT		GENMASK(8, 6)
+#define I2C_LTIMING_HS_LOW_CNT		GENMASK(11, 9)
+#define I2C_LTIMING_HS_SAMPLE_CNT	GENMASK(14, 12)
+#define I2C_EXT_HS_START_CNT		GENMASK(7, 1)
+#define I2C_EXT_START_CNT		GENMASK(15, 8)
+#define I2C_SDA_CNT			GENMASK(5, 0)
+#define I2C_SDA_HS_CNT			GENMASK(11, 6)
 
 #define I2C_RS_TRANSFER			BIT(4)
 #define I2C_HS_NACKERR			BIT(2)
@@ -54,6 +80,7 @@
 #define MAX_STEP_CNT_DIV		64
 #define MAX_HS_STEP_CNT_DIV		8
 #define I2C_DEFAULT_CLK_DIV		4
+#define MAX_CLOCK_DIV_5BITS		32
 
 #define MAX_I2C_ADDR			0x7f
 #define MAX_I2C_LEN			0xff
@@ -201,9 +228,11 @@ static const uint mt_i2c_regs_v3[] = {
 	[REG_HS] = 0x30,
 	[REG_IO_CONFIG] = 0x34,
 	[REG_FIFO_ADDR_CLR] = 0x38,
+	[REG_DATA_TIME] = 0x3c,
 	[REG_TRANSFER_LEN_AUX] = 0x44,
 	[REG_CLOCK_DIV] = 0x48,
 	[REG_SOFTRESET] = 0x50,
+	[REG_SCL_MIS_COMP_POINT] = 0x90,
 	[REG_SLAVE_ADDR] = 0x94,
 	[REG_DEBUGSTAT] = 0xe4,
 	[REG_DEBUGCTRL] = 0xe8,
@@ -217,6 +246,46 @@ struct mtk_i2c_soc_data {
 	uint dma_sync: 1;
 	uint ltiming_adjust: 1;
 	uint dma_36bit: 1;
+	uint apdma_sync: 1;
+	uint timing_adjust: 1;
+};
+
+struct mtk_i2c_ac_timing {
+	u16 timing;
+	u16 ltiming;
+	u16 hs;
+	u16 ext;
+	u16 sda;
+	u16 clk_div;
+};
+
+struct mtk_i2c_timing_spec {
+	uint min_low_ns;
+	uint min_su_sta_ns;
+	uint max_hd_dat_ns;
+	uint min_su_dat_ns;
+};
+
+/* Timing limits include the margins used by the MT8188 controller. */
+static const struct mtk_i2c_timing_spec standard_mode_spec = {
+	.min_low_ns = 4700 + 1000 / 3,
+	.min_su_sta_ns = 4700 + 1000 / 3,
+	.max_hd_dat_ns = 3450 - 1000 / 3,
+	.min_su_dat_ns = 250 + 1000 / 3,
+};
+
+static const struct mtk_i2c_timing_spec fast_mode_spec = {
+	.min_low_ns = 1300 + 300 / 3,
+	.min_su_sta_ns = 600 + 300 / 3,
+	.max_hd_dat_ns = 900 - 300 / 3,
+	.min_su_dat_ns = 100 + 300 / 3,
+};
+
+static const struct mtk_i2c_timing_spec fast_mode_plus_spec = {
+	.min_low_ns = 500 + 20 / 3,
+	.min_su_sta_ns = 260 + 20 / 3,
+	.max_hd_dat_ns = 400 - 20 / 3,
+	.min_su_dat_ns = 50 + 20 / 3,
 };
 
 struct mtk_i2c_priv {
@@ -235,6 +304,10 @@ struct mtk_i2c_priv {
 	bool auto_restart;		/* restart mode */
 	bool ignore_restart_irq;	/* ignore restart IRQ */
 	uint speed;			/* i2c speed, unit: hz */
+	uint clk_src_div;
+	uint scl_int_delay_ns;
+	bool timing_valid;
+	struct mtk_i2c_ac_timing ac_timing;
 };
 
 static inline void i2c_writel(struct mtk_i2c_priv *priv, uint reg, uint value)
@@ -307,9 +380,22 @@ static void mtk_i2c_init_hw(struct mtk_i2c_priv *priv)
 {
 	uint control_reg;
 
-	writel(I2C_DMA_HARD_RST, priv->pdmabase + REG_RST);
-	writel(I2C_DMA_CLR_FLAG, priv->pdmabase + REG_RST);
-	i2c_writel(priv, REG_SOFTRESET, I2C_SOFT_RST);
+	if (priv->soc_data->apdma_sync) {
+		writel(I2C_DMA_WARM_RST, priv->pdmabase + REG_RST);
+		udelay(10);
+		writel(I2C_DMA_CLR_FLAG, priv->pdmabase + REG_RST);
+		udelay(10);
+		writel(I2C_DMA_HANDSHAKE_RST | I2C_DMA_HARD_RST,
+		       priv->pdmabase + REG_RST);
+		i2c_writel(priv, REG_SOFTRESET, I2C_HANDSHAKE_RST | I2C_SOFT_RST);
+		udelay(10);
+		writel(I2C_DMA_CLR_FLAG, priv->pdmabase + REG_RST);
+		i2c_writel(priv, REG_SOFTRESET, 0);
+	} else {
+		writel(I2C_DMA_HARD_RST, priv->pdmabase + REG_RST);
+		writel(I2C_DMA_CLR_FLAG, priv->pdmabase + REG_RST);
+		i2c_writel(priv, REG_SOFTRESET, I2C_SOFT_RST);
+	}
 	/* set ioconfig */
 	if (priv->pushpull)
 		i2c_writel(priv, REG_IO_CONFIG, I2C_IO_CONFIG_PUSH_PULL);
@@ -317,6 +403,15 @@ static void mtk_i2c_init_hw(struct mtk_i2c_priv *priv)
 		i2c_writel(priv, REG_IO_CONFIG, I2C_IO_CONFIG_OPEN_DRAIN);
 
 	i2c_writel(priv, REG_DCM_EN, I2C_DCM_DISABLE);
+	if (priv->soc_data->timing_adjust && priv->timing_valid) {
+		i2c_writel(priv, REG_TIMING, priv->ac_timing.timing);
+		i2c_writel(priv, REG_LTIMING, priv->ac_timing.ltiming);
+		i2c_writel(priv, REG_HS, priv->ac_timing.hs);
+		i2c_writel(priv, REG_EXT_CONF, priv->ac_timing.ext);
+		i2c_writel(priv, REG_DATA_TIME, priv->ac_timing.sda);
+		i2c_writel(priv, REG_CLOCK_DIV, priv->ac_timing.clk_div);
+		i2c_writel(priv, REG_SCL_MIS_COMP_POINT, 0);
+	}
 	control_reg = I2C_CONTROL_ACKERR_DET_EN | I2C_CONTROL_CLK_EXT_EN;
 	if (priv->soc_data->dma_sync)
 		control_reg |= I2C_CONTROL_DMAACK | I2C_CONTROL_ASYNC;
@@ -324,6 +419,160 @@ static void mtk_i2c_init_hw(struct mtk_i2c_priv *priv)
 	i2c_writel(priv, REG_DELAY_LEN, I2C_DELAY_LEN);
 }
 
+static int mtk_i2c_calculate_ac_timing(uint clk_src, uint speed,
+				       uint scl_delay,
+				       struct mtk_i2c_ac_timing *timing)
+{
+	const struct mtk_i2c_timing_spec *spec;
+	uint sample, step, best_mul = UINT_MAX;
+	bool high_speed = speed > I2C_SPEED_FAST_PLUS_RATE;
+	uint max_step = high_speed ? MAX_HS_STEP_CNT_DIV : MAX_STEP_CNT_DIV;
+	uint max_start = high_speed ? FIELD_MAX(I2C_EXT_HS_START_CNT) :
+				      FIELD_MAX(I2C_EXT_START_CNT);
+	uint opt_div, clk_ns;
+	bool found = false;
+
+	if (!clk_src || !speed)
+		return -EINVAL;
+	clk_ns = NSEC_PER_SEC / clk_src;
+	if (!clk_ns)
+		return -EINVAL;
+
+	if (speed <= I2C_SPEED_STANDARD_RATE)
+		spec = &standard_mode_spec;
+	else if (speed <= I2C_SPEED_FAST_RATE)
+		spec = &fast_mode_spec;
+	else
+		spec = &fast_mode_plus_spec;
+
+	opt_div = DIV_ROUND_UP(clk_src, 2 * speed);
+	for (sample = 1; sample <= MAX_SAMPLE_CNT_DIV; sample++) {
+		uint sample_ns, low, high, start, sda_min, sda_max, sda;
+		uint sample_reg = sample - 1;
+		u64 start_count;
+		int correction;
+		uint mul;
+
+		/* The effective SCL period depends on both dividers. */
+		if (sample == 1)
+			correction = timing->clk_div ? 1 : 0;
+		else if (timing->clk_div < 2)
+			correction = (int)timing->clk_div - 1;
+		else
+			correction = 1;
+
+		step = DIV_ROUND_UP(opt_div + correction, sample);
+		if (!step || step > max_step)
+			continue;
+		mul = step * sample - correction;
+		if (mul >= best_mul)
+			continue;
+
+		sample_ns = div_u64((u64)sample * NSEC_PER_SEC, clk_src);
+		start_count = DIV_ROUND_UP_ULL((u64)spec->min_su_sta_ns + scl_delay,
+					       clk_ns);
+		if (start_count > max_start)
+			continue;
+		start = start_count;
+		low = DIV_ROUND_UP(spec->min_low_ns, sample_ns);
+		/* Timing registers contain the divider minus one. */
+		if (low >= max_step || low >= 2 * (step - 1))
+			continue;
+		if (low > step - 1) {
+			high = 2 * (step - 1) - low;
+		} else {
+			high = step - 1;
+			low = step - 1;
+		}
+
+		sda_max = spec->max_hd_dat_ns / sample_ns;
+		if (sda_max > low)
+			sda_max = 0;
+		sda_min = DIV_ROUND_UP(spec->min_su_dat_ns, sample_ns);
+		if (sda_min < low)
+			sda_min = 0;
+		if (sda_min > sda_max)
+			continue;
+		sda = (sda_max + sda_min) / 2;
+
+		if (high_speed) {
+			timing->hs = I2C_TIME_DEFAULT_VALUE |
+				FIELD_PREP(I2C_HS_SAMPLE_CNT, sample_reg) |
+				FIELD_PREP(I2C_HS_HIGH_CNT, high);
+			timing->ltiming &= I2C_LTIMING_SAMPLE_CNT | I2C_LTIMING_LOW_CNT;
+			timing->ltiming |= FIELD_PREP(I2C_LTIMING_HS_SAMPLE_CNT, sample_reg) |
+				FIELD_PREP(I2C_LTIMING_HS_LOW_CNT, low);
+			timing->ext &= ~I2C_EXT_HS_START_CNT;
+			timing->ext |= FIELD_PREP(I2C_EXT_HS_START_CNT, start);
+			timing->sda &= ~I2C_SDA_HS_CNT;
+			timing->sda |= FIELD_PREP(I2C_SDA_HS_CNT, sda);
+		} else {
+			timing->timing = FIELD_PREP(I2C_TIMING_SAMPLE_CNT, sample_reg) |
+				FIELD_PREP(I2C_TIMING_HIGH_CNT, high);
+			timing->ltiming = FIELD_PREP(I2C_LTIMING_SAMPLE_CNT, sample_reg) |
+				FIELD_PREP(I2C_LTIMING_LOW_CNT, low);
+			timing->ext = FIELD_PREP(I2C_EXT_START_CNT, start) | BIT(0);
+			timing->sda = FIELD_PREP(I2C_SDA_CNT, sda) | BIT(12);
+		}
+		best_mul = mul;
+		found = true;
+	}
+
+	return found ? 0 : -EINVAL;
+}
+
+static int mtk_i2c_set_ac_speed(struct mtk_i2c_priv *priv, uint speed)
+{
+	struct mtk_i2c_ac_timing timing;
+	bool high_speed = speed > I2C_SPEED_FAST_PLUS_RATE;
+	ulong parent_clk;
+	uint div, clk_src, first_speed;
+	int ret, disable_ret;
+
+	if (!speed || speed > I2C_SPEED_HIGH_RATE)
+		return -EINVAL;
+	ret = mtk_i2c_clk_enable(priv);
+	if (ret)
+		return ret;
+	parent_clk = clk_get_rate(&priv->clk_main);
+	if (IS_ERR_VALUE(parent_clk) || !parent_clk || parent_clk > UINT_MAX) {
+		ret = -EINVAL;
+		goto out;
+	}
+	parent_clk /= priv->clk_src_div;
+	first_speed = high_speed ? I2C_SPEED_FAST_RATE : speed;
+	ret = -EINVAL;
+	for (div = 1; div <= MAX_CLOCK_DIV_5BITS; div++) {
+		clk_src = parent_clk / div;
+		memset(&timing, 0, sizeof(timing));
+		timing.clk_div = div - 1;
+		ret = mtk_i2c_calculate_ac_timing(clk_src, first_speed,
+						  priv->scl_int_delay_ns, &timing);
+		if (ret)
+			continue;
+		if (high_speed) {
+			ret = mtk_i2c_calculate_ac_timing(clk_src, speed,
+							  priv->scl_int_delay_ns, &timing);
+			if (ret)
+				continue;
+		}
+		priv->ac_timing = timing;
+		priv->timing_valid = true;
+		priv->speed = speed;
+		mtk_i2c_init_hw(priv);
+		break;
+	}
+out:
+	disable_ret = mtk_i2c_clk_disable(priv);
+	return ret ? ret : disable_ret;
+}
+
+static bool mtk_i2c_high_speed(struct mtk_i2c_priv *priv)
+{
+	return priv->speed > (priv->soc_data->timing_adjust ?
+			     I2C_SPEED_FAST_PLUS_RATE : I2C_SPEED_FAST_RATE);
+}
+
 /*
  * Calculate i2c port speed
  *
@@ -433,6 +682,11 @@ static int mtk_i2c_set_speed(struct udevice *dev, uint speed)
 	uint clk_src;
 	int ret = 0;
 
+	if (priv->soc_data->timing_adjust)
+		return mtk_i2c_set_ac_speed(priv, speed);
+	if (!speed)
+		return -EINVAL;
+
 	priv->speed = speed;
 	if (mtk_i2c_clk_enable(priv))
 		return log_msg_ret("set_speed enable clk", -1);
@@ -486,6 +740,26 @@ exit:
 	return ret;
 }
 
+static int mtk_i2c_reset_handshake(struct mtk_i2c_priv *priv)
+{
+	u32 val;
+	int ret;
+
+	i2c_writel(priv, REG_DEBUGCTRL, 0);
+	writel(I2C_DMA_HANDSHAKE_RST | I2C_DMA_WARM_RST, priv->pdmabase + REG_RST);
+	ret = readl_poll_timeout(priv->pdmabase + REG_RST, val,
+				 !(val & I2C_DMA_WARM_RST), 100);
+	if (ret)
+		return ret;
+
+	writel(I2C_DMA_CLR_FLAG, priv->pdmabase + REG_RST);
+	i2c_writel(priv, REG_SOFTRESET, I2C_HANDSHAKE_RST);
+	i2c_writel(priv, REG_SOFTRESET, 0);
+	i2c_writel(priv, REG_DEBUGCTRL, I2C_RELIABILITY | I2C_DMAACK_ENABLE);
+
+	return 0;
+}
+
 /*
  * mtk_i2c_do_transfer
  *
@@ -524,6 +798,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	bool tmo = false;
 	uint start_reg;
 	uint addr_reg;
+	uint dma_sync = 0;
 	int ret = 0;
 
 	if (!priv->zero_len && (priv->op & I2C_MASTER_WR) &&
@@ -536,10 +811,18 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	if (priv->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
+	if (priv->soc_data->apdma_sync && num > 1 && priv->op != I2C_MASTER_WRRD) {
+		ret = mtk_i2c_reset_handshake(priv);
+		if (ret) {
+			mtk_i2c_init_hw(priv);
+			return ret;
+		}
+	}
+
 	control_reg = i2c_readl(priv, REG_CONTROL) &
 		~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS | I2C_CONTROL_DMA_EN);
 
-	if (priv->speed > MAX_FS_MODE_SPEED || num > 1)
+	if (mtk_i2c_high_speed(priv) || num > 1)
 		control_reg |= I2C_CONTROL_RS;
 
 	if (priv->op == I2C_MASTER_WRRD)
@@ -550,7 +833,9 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	i2c_writel(priv, REG_CONTROL, control_reg);
 
 	/* set start condition */
-	if (priv->speed <= MAX_ST_MODE_SPEED)
+	if (priv->soc_data->timing_adjust)
+		i2c_writel(priv, REG_EXT_CONF, priv->ac_timing.ext);
+	else if (priv->speed <= MAX_ST_MODE_SPEED)
 		i2c_writel(priv, REG_EXT_CONF, I2C_ST_START_CON);
 	else
 		i2c_writel(priv, REG_EXT_CONF, I2C_FS_START_CON);
@@ -589,6 +874,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	/* Clear DMA interrupt flag */
 	writel(I2C_DMA_INT_FLAG_NONE, priv->pdmabase + REG_INT_FLAG);
 
+	if (priv->soc_data->apdma_sync) {
+		dma_sync = I2C_DMA_SKIP_CONFIG | I2C_DMA_ASYNC_MODE;
+		if (priv->op == I2C_MASTER_WRRD)
+			dma_sync |= I2C_DMA_DIR_CHANGE;
+	}
+
 	/*
 	 * prepare buffer data to start transfer
 	 * three cases here: read, write, write then read
@@ -599,7 +890,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		flush_cache((ulong)tx_buf, ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
 
 		/* Set DMA direction TX (w/ or w/o RX) */
-		writel(I2C_DMA_CON_TX, priv->pdmabase + REG_CON);
+		writel(I2C_DMA_CON_TX | dma_sync, priv->pdmabase + REG_CON);
 
 		/* Write the tx buffer address to dma register */
 		writel(lower_32_bits(tx_addr), priv->pdmabase + REG_TX_MEM_ADDR);
@@ -619,7 +910,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 
 		if (!msg_rx) {
 			/* Set DMA direction RX */
-			writel(I2C_DMA_CON_RX, priv->pdmabase + REG_CON);
+			writel(I2C_DMA_CON_RX | dma_sync, priv->pdmabase + REG_CON);
 
 			msg_rx = msgs;
 		}
@@ -752,7 +1043,7 @@ static int mtk_i2c_transfer(struct udevice *dev, struct i2c_msg *msg,
 		}
 	}
 
-	if (priv->auto_restart && nmsgs >= 2 && priv->speed > MAX_FS_MODE_SPEED)
+	if (priv->auto_restart && nmsgs >= 2 && mtk_i2c_high_speed(priv))
 		/* ignore the first restart irq after the master code,
 		 * otherwise the first transfer will be discarded.
 		 */
@@ -800,6 +1091,12 @@ static int mtk_i2c_of_to_plat(struct udevice *dev)
 
 	priv->base = dev_remap_addr_index(dev, 0);
 	priv->pdmabase = dev_remap_addr_index(dev, 1);
+	if (!priv->base || !priv->pdmabase)
+		return -EINVAL;
+	priv->clk_src_div = dev_read_u32_default(dev, "clock-div", 1);
+	if (!priv->clk_src_div)
+		return -EINVAL;
+	priv->scl_int_delay_ns = dev_read_u32_default(dev, "i2c-scl-internal-delay-ns", 0);
 	ret = clk_get_by_index(dev, 0, &priv->clk_main);
 	if (ret)
 		return log_msg_ret("clk_get_by_index 0", ret);
@@ -868,6 +1165,14 @@ static const struct mtk_i2c_soc_data mt8183_soc_data = {
 	.ltiming_adjust = 0,
 };
 
+static const struct mtk_i2c_soc_data mt8188_soc_data = {
+	.regs = mt_i2c_regs_v3,
+	.ltiming_adjust = 1,
+	.dma_36bit = 1,
+	.apdma_sync = 1,
+	.timing_adjust = 1,
+};
+
 static const struct mtk_i2c_soc_data mt8518_soc_data = {
 	.regs = mt_i2c_regs_v1,
 	.dma_sync = 0,
@@ -905,6 +1210,9 @@ static const struct udevice_id mtk_i2c_ids[] = {
 	}, {
 		.compatible = "mediatek,mt8183-i2c",
 		.data = (ulong)&mt8183_soc_data,
+	}, {
+		.compatible = "mediatek,mt8188-i2c",
+		.data = (ulong)&mt8188_soc_data,
 	}, {
 		.compatible = "mediatek,mt8512-i2c",
 		.data = (ulong)&mt8512_soc_data,

-- 
2.56.1

