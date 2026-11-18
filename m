Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAB606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JNvryEeE;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ClpagO/R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 887CD8116A;
	Wed, 18 Nov 2026 20:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRd_cvUWBzS3; Wed, 18 Nov 2026 20:30:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 641718111E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033814;
	b=O2qAG2F03u6HRGCP7/4xATQ9iBZ/9wAUGduaMDCSbc9rIkjMrDyVuXHG10AdCz9BPSSd
	 HeXcLE0GWXreTDKHxHXlQQlEOzPYeO/Nzo4VKIh6uwsofcq/JQQfyKevKyGSRF4ZkIw9U
	 9ZNYl87mBXnD2o+m/JrRd7u8jRha8oXp+jY/CoLjpIKHnDFcLt1ce2x3Jf5H1PLQSccyw
	 05rn7WeT9ceOkTaLf+BzrPAFWD24O/9kq3UCpt7Znb0Xo0vq3ugcnyNQ2KHZsjvNiQO3+
	 OJ+YRgAUpgXSTeevRG4HMTqNo64N28R3Cu0dJZJqfNdHzz4952ENMwPlTTb+D2h29Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rye11o6iYXy933LjHdbpkdx/oFJ06zUWybirKcSfWy8=;
	b=MV0gEnPvlQP1/8JYbTvlhFOljWaeHMZQ6Nur5NDAhRs0c1cHcf+T+4niOSqTSHPzGNHg
	 LqyeKCDpzprzRsqtLKFiZouR68FWUgPmlCTH/E8F+UkWaxM2bPekIotcBwZ24SjCBAf6U
	 8wLyPJ/eMVR/yzonFsFM/GxWueiW+NLDEBGQYSSUlRpRCMTTGD8vS3+YQEVoeWVMD2BtP
	 k/3Q5Ci5lthUHeBdj/n+8oaxoZcrDgxq5xA6JF8YO54DIJ5QFmu8Yty+TGiO6wvlZ3Fyp
	 C8EcSV/khGcFrC+T/rUJOazBNwXAsFfhCa6XnEiiivkLKKKKRlWSotaWyljyfjwV10Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="ClpagO/R";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033814;
	bh=Rye11o6iYXy933LjHdbpkdx/oFJ06zUWybirKcSfWy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNvryEeElCKKVrAhfvzQ2TUmuNuwVeOPzSQydkQRm68WbxIpCzohxC+4XZOrwZjej
	 5W3HtYyumdpEGWMYMtbg0dMRqm/yv+HRxPC6qJfn6ydGxfbtmppVqI3m9I8RzNX2ye
	 WyR8hvMZC1IwRtrETxzVH33Ah3SD5GgQ1UHkdqN5mhR+Sg9cNj91ELphy1w35jGRG5
	 k/tR+SmIt/qgz7wlKTZqvnM0CUEqstlw6brzLyELNFgfjknOB7dDdM5oWlR+L7ePVK
	 zTz3P0UkNDV9evPEHnaFHpoixnIC2p+QZ0X6R5YBMv8KinsV+hfALtFAz55NBL500P
	 dIGsDB22WOlkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 641718111E;
	Wed, 18 Nov 2026 20:30:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E26F849B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D49978111E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HwLDGGeDMoDt for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7633280E66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ClpagO/R
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7633280E66
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:10 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so754506f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033808; x=1795638608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rye11o6iYXy933LjHdbpkdx/oFJ06zUWybirKcSfWy8=;
 b=ClpagO/RXgS1CyM22JYGGRuV876xO2MHcqJFET0rXeKCzeum+7IMgKyzrLqWs2incc
 mrXdcbaIcthMzYFwb14Lk5tlpON82mqkSKNbl1vmbDo1OaSGWpC8VoVL5Yj3QmwUO9TM
 dr5AOpNwNbCl/lZysJ65Zz7amKnimkC85jraOa37rWR5u0D0J0jrWA1diHGSw7riMa5K
 eQwwTqMgRYiKFjQz8o+iZqImuCA2KjVD7G06EgFBs6UQthreMzRfp42V6rb9vmqz14NQ
 txGazw/3998BZrnB53c+cORM79X0ONEOU4R+aEomGtxv49UE9ODBFIT9dQF5kiFfCd0L
 Geog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033808; x=1795638608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rye11o6iYXy933LjHdbpkdx/oFJ06zUWybirKcSfWy8=;
 b=l/nKMohEfTWIlp0AhYQu0gTZ9qNmS5VMZI7l//li+2aETAgeRYf4UEvOSmVeGqPKqt
 lrNU5A6V7DEzu+JccK9vwfupUV2sczttZdVVMrXPUnbzga8bnRD1WHEyGIfVnJYSlSvn
 2S+gL2gXie4xmD3lLQf1W6o3hMjEf1MTiWbj03P7igsRhj53uZjCnSkNrbsvBs37d7gE
 iB9n0AO5cyCnGHR4m+Lc5z24R+c7/QDw4ial0Jwa9J4FRxtNSS695j5KcqDwP5ngIteu
 5G6fJ15jYcbHb/rOsMPW6lkxdbt1gHob0XQ4Fx7knXl5Daz5iH6FddBY8PDHfQVxhyzq
 EJgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF1J2h63Nwsnt2vrDM4rrDXPhSAJSbE5lpPrn8gJfC/pMZhT8ooT+g2Su3Y0PEeN5xkI7JMpOY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/utU0ODxglX57c5b3zPkrvQPJo58/q1BebrQuunFxk3rPG3LXi
 R4o1h+24Z6enKhcivWJgNvH02VC9PbOXXuH1YNubLY4CMsm5TD5A2SeVhUXvjoRZoVo=
X-Gm-Gg: AYBFou0ZJ0H/WrBrhG5+k4ny7n6nClBF8wxnpFbtnrOdsi/d7Cu1ZSAqUuOjE+ZPf3S
 Rc6541jqDgXFN07gHxI3TKMeGBl54LbhnULV1tPENWaKMIO5RBUyBt0TMhR8AyI6793G4XF4dt7
 O/VOdO4E6m8njimkfKaoB4ary/XMNCp56l6WgcOAVfmA04Q6vNTaJppHAgdYqCznTYm1+wi9wBe
 dMfVcyEuBPI33LTpt97tfyx2MtetJ9gMN1MSdXnSC+8c4yk9eXGrP71OKeb4axfgnKNnRH0pF8+
 xcXM2U6UkTJLGpuxmQUP4vOUJuq23e9pGlWCNDfj3fx6i6Dsa2ewnh06hU2w1QCB3Rg48RYAvA7
 maeZ6W8Xxny/KzhINL+Fl/IBpRodqKYqIxzAU3KP7GuUKnGhtV4PR1FkN098Cf6C2kTrEKLmmVT
 V47fvvIohhULUl7EubW6+jHO29JhM0KrfhEAFzDtMVVsonuOK/OBXE/i9Kr+EboN7XdTJhqe3tT
 +qq8UR0PEkwJoSt1/YfmUYcMTn9lvzJZeto/yxTabzeSEAtCuDClClZN7xZ2G0L857b/fQkN0im
 FCM6FQAxizPzlpwIiWAmcgf4q0D4j+ZDcDyNFxGVQEob5Hgl7XU3ETeoO4m7ukdCeWGgXHny7A1
 lBALd34O9YMkMQle3DA==
X-Received: by 2002:a05:600c:a4b:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4bb7da12963mr75328875e9.14.1795033808164; 
 Wed, 18 Nov 2026 12:30:08 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:06 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:48 +0100
Subject: [PATCH 2/7] i2c: mediatek: support the MT8188 controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-2-916dd6cc8d1a@baylibre.com>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 720 uses the MT8188 I2C controller. Add support for its
register layout, bus timing and DMA handshake. Restore the bus timing
registers after a controller reset.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 272 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 767542f42a..54f27d19a1 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -16,8 +16,31 @@
 #include <memalign.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+
+#define I2C_DMA_WARM_RST		BIT(0)
+#define I2C_DMA_HANDSHAKE_RST		BIT(2)
+#define I2C_DMA_ASYNC_MODE		BIT(2)
+#define I2C_DMA_SKIP_CONFIG		BIT(4)
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
@@ -54,6 +77,7 @@
 #define MAX_STEP_CNT_DIV		64
 #define MAX_HS_STEP_CNT_DIV		8
 #define I2C_DEFAULT_CLK_DIV		4
+#define MAX_CLOCK_DIV			256
 
 #define MAX_I2C_ADDR			0x7f
 #define MAX_I2C_LEN			0xff
@@ -201,9 +225,11 @@ static const uint mt_i2c_regs_v3[] = {
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
@@ -217,6 +243,46 @@ struct mtk_i2c_soc_data {
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
@@ -235,6 +301,10 @@ struct mtk_i2c_priv {
 	bool auto_restart;		/* restart mode */
 	bool ignore_restart_irq;	/* ignore restart IRQ */
 	uint speed;			/* i2c speed, unit: hz */
+	uint clk_src_div;
+	uint scl_int_delay_ns;
+	bool timing_valid;
+	struct mtk_i2c_ac_timing ac_timing;
 };
 
 static inline void i2c_writel(struct mtk_i2c_priv *priv, uint reg, uint value)
@@ -307,9 +377,22 @@ static void mtk_i2c_init_hw(struct mtk_i2c_priv *priv)
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
@@ -317,6 +400,15 @@ static void mtk_i2c_init_hw(struct mtk_i2c_priv *priv)
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
@@ -324,6 +416,147 @@ static void mtk_i2c_init_hw(struct mtk_i2c_priv *priv)
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
+
+		step = DIV_ROUND_UP(opt_div, sample);
+		if (!step || step > max_step || step * sample >= best_mul)
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
+		best_mul = step * sample;
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
+	for (div = 1; div <= MAX_CLOCK_DIV; div++) {
+		clk_src = parent_clk / div;
+		memset(&timing, 0, sizeof(timing));
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
+		timing.clk_div = div - 1;
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
@@ -433,6 +666,11 @@ static int mtk_i2c_set_speed(struct udevice *dev, uint speed)
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
@@ -524,6 +762,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	bool tmo = false;
 	uint start_reg;
 	uint addr_reg;
+	uint dma_sync = 0;
 	int ret = 0;
 
 	if ((priv->op & I2C_MASTER_WR) && (tx_addr >> dma_bits))
@@ -537,7 +776,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	control_reg = i2c_readl(priv, REG_CONTROL) &
 		~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
 
-	if (priv->speed > MAX_FS_MODE_SPEED || num > 1)
+	if (mtk_i2c_high_speed(priv) || num > 1)
 		control_reg |= I2C_CONTROL_RS;
 
 	if (priv->op == I2C_MASTER_WRRD)
@@ -547,7 +786,9 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	i2c_writel(priv, REG_CONTROL, control_reg);
 
 	/* set start condition */
-	if (priv->speed <= MAX_ST_MODE_SPEED)
+	if (priv->soc_data->timing_adjust)
+		i2c_writel(priv, REG_EXT_CONF, priv->ac_timing.ext);
+	else if (priv->speed <= MAX_ST_MODE_SPEED)
 		i2c_writel(priv, REG_EXT_CONF, I2C_ST_START_CON);
 	else
 		i2c_writel(priv, REG_EXT_CONF, I2C_FS_START_CON);
@@ -582,6 +823,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
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
@@ -592,7 +839,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		flush_cache((ulong)tx_buf, ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
 
 		/* Set DMA direction TX (w/ or w/o RX) */
-		writel(I2C_DMA_CON_TX, priv->pdmabase + REG_CON);
+		writel(I2C_DMA_CON_TX | dma_sync, priv->pdmabase + REG_CON);
 
 		/* Write the tx buffer address to dma register */
 		writel(lower_32_bits(tx_addr), priv->pdmabase + REG_TX_MEM_ADDR);
@@ -612,7 +859,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 
 		if (!msg_rx) {
 			/* Set DMA direction RX */
-			writel(I2C_DMA_CON_RX, priv->pdmabase + REG_CON);
+			writel(I2C_DMA_CON_RX | dma_sync, priv->pdmabase + REG_CON);
 
 			msg_rx = msgs;
 		}
@@ -744,7 +991,7 @@ static int mtk_i2c_transfer(struct udevice *dev, struct i2c_msg *msg,
 		}
 	}
 
-	if (priv->auto_restart && nmsgs >= 2 && priv->speed > MAX_FS_MODE_SPEED)
+	if (priv->auto_restart && nmsgs >= 2 && mtk_i2c_high_speed(priv))
 		/* ignore the first restart irq after the master code,
 		 * otherwise the first transfer will be discarded.
 		 */
@@ -792,6 +1039,12 @@ static int mtk_i2c_of_to_plat(struct udevice *dev)
 
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
@@ -860,6 +1113,14 @@ static const struct mtk_i2c_soc_data mt8183_soc_data = {
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
@@ -897,6 +1158,9 @@ static const struct udevice_id mtk_i2c_ids[] = {
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

