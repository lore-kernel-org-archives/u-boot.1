Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87470C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 526A440E73;
	Fri, 14 Aug 2026 14:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8endkzjgY1MC; Fri, 14 Aug 2026 14:57:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C36040CF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786719426;
	bh=M+KbQID28XYoNfigxnjVBVxHPlekd/J+0oEi72Hg8Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=unfB1A92edQsV31w++u2UxJ0AzDqAbmHFT2NywFJaHtS7dO+7csg+1mQcKbnUPUwh
	 3oFjOO8ZZl/XFcYjRtX6+nTG4FkAgfWqwTa5PRzF8y6T4Zp55FW1DznR+7ZwsKqW4U
	 rwlmBZ4jp7N/JVARusspopyEH7zFV2CuaJUAo9+HiE0/zsFzoW/CH8BV7PcYVcaIST
	 dIn5DAFiwMXaZW5xfHzwslEYhbSpNMTB28IJcnPmdfjI9437pR76hd/bqDoXoxxHzk
	 cB0rqp+Wxqau/bNRmFS5ENXergdtOucgfFLp+dHPUPnvR1fqmf53jkA0xbosvswv6q
	 KMXm4fiy9qikg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C36040CF1;
	Fri, 14 Aug 2026 14:57:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACB4323F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 930AA40AD0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvQw4_FLUCZN for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C2F0040AC0
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2F0040AC0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fWT7Oj5J
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2F0040AC0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:01 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-446f87b6de1so1190375fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786719420; x=1787324220;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M+KbQID28XYoNfigxnjVBVxHPlekd/J+0oEi72Hg8Aw=;
 b=fWT7Oj5J0JLxi4Vht3DZ41phJ4moII72+m7lIRO9ACKmCKDoTCqQgUCVS44/+7KDXS
 KbxfldYF3ZGOGl/a0ntwYdESDlxHHH9es/aWWXYy7iyy7VhfLgIsS33TOXhmfEboCXmt
 3MkPqmBlzExJemr2Vs5rI5PQalk9dUzdLa3+/MbNUwsZ4QPt21wiSLmpxGc9DTcxXUS+
 iPb/jXLtx56BzLOYg9Zyyr//5qkNs6qOzSnbLZpbV7Hx89HGE0VOI6+PGi7P5c4NUgU2
 0rjdysGw/v7E/QC1bRlzPitcqH9Sdy5g221czmwWXHoYOp+Um0r+fKtnCItVG211adW5
 /mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719420; x=1787324220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M+KbQID28XYoNfigxnjVBVxHPlekd/J+0oEi72Hg8Aw=;
 b=qqeCgHhms7BIsgaP0KA6BllAf/Vft9pGLrpyOnr45HXKasDKxfaEKY6niL5vldSgcF
 OBh5kkUsYwgddAh/N84fuW5YF74kdL7BE50VFUN1lHkU9OUY87pA8U9iG7UhQ+Bq9hAE
 ejXiTOCVzoFde/7an/8tNBNMBW7kdO4XokbswaA2txx9o/IB0s6vuHzbPJDi7hDJ+i+C
 p0qPvLpRiiHnq7Q6mxBx9MgjFaFxGJ7+7bLsc/0DIDXzhRVwO1LA6z1e0nZTl4hObL+k
 mI9N9QA/qrDSes6mZc4H//CShdKqcYz4hHw6oIfHQfU7co7Ndobc1OOvHO0bb6x5JjAl
 ltHQ==
X-Gm-Message-State: AOJu0Yx7aZqYgYF6+fW28vFVtw9LjMz4y0Bb6777FKribGZdyPsnsMQd
 X4CdacfzE/uvdlIj06ytyRrhPhmyO0XNjYeKEHwTti+gpXK1H/bhntJ+FQM1mBCtycQ=
X-Gm-Gg: AR+sD10KijP3vFPXmUtC1Hb4AHiUbzoVprUBAivhtxoC4mxHGvkhpdLzmb/0dCkADFC
 IpSg9ezgWshUv0EaGwC1/C3CVwOC7/9BOGwkm9XwTh4u5YQjrElnLLJCYny/cfj8wbIllHPWcY8
 ZwB43kzVwWcaJeQXSXXNeetqXq0gyzfD/PlSy7DSLLoGGCTlJcCbqN3aTbC1OjBfgyfnTM/CeU+
 Y4OI2iAmO2CAsUIyFDXBrftowQvmXWZyiw29IzLHNT+N487pxzoIcJaH2DSe+NYjgT7MfQOhOAW
 R6YbtHjjx+ApOiGARH8yng0BPPxbC6Iv+0neZ1qlQH5LxWQf9fh/NhEVpCrobbRXTg3T+z4BL7F
 vUyTZWC9tASdPtLLqpGa/itJB1PLnrwCEnC4gFYN2K80Og/CBQkdHS7tG1X13lPqrP5UuRV6nA5
 6QmegBkcHN3WRifUrwoFHYXl+lMGBrninfPI2Qri//yBPmjsbRuWkwLr0e9oL4DGYisA==
X-Received: by 2002:a05:6820:809:b0:6ae:9712:cad0 with SMTP id
 006d021491bc7-6b0d68b23admr4746879eaf.21.1786719420632; 
 Fri, 14 Aug 2026 07:57:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8668831sm1065949a34.22.2026.08.14.07.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:57:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 09:56:21 -0500
Subject: [PATCH 1/4] power: domain: mtk: add bus_prot_sta_mask field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-power-domain-mt8366-v1-1-6a0bb4a766bb@baylibre.com>
References: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
In-Reply-To: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3221; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=jtOi6EM/nc8BhC1nghd4ejzGjuE98Vy7aHKx2G63YoI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfyyg6NVwAEYUKcwyb0KOkF84qMxhMme2Q9B/x
 jZkgZUqgCCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan8soBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/As1IH/ReS4gtxartgCKy4tt8sJJvc/bZzpVW39sEkp5V
 jacr7H8s+7U+0AWL1KmlRzf6MsocTRw3VTimqrvfCfEi2/ZEdg/61Zffc1cjcpbqDpTgexZPz1X
 4qdtRxBc2ce2ZTTxGyp1wZ74E0vV4mo8ovJ7Bl3Se/xHIiZzH/7b4ChJFNKJ5r4Z32RIXAmjCUK
 gQy5tMQkFa4ZZIkicMsHFrGFU/N4h4Jdwd735TzGUBhaphrGe2+LKp53RntyjmnWEwF2S+7ZQoZ
 AMmA0ZHqQ1k6bsf6tMnvF6ghrosxyOOnhtJ4BPmvA9jwTDXxq911ydohmZPvcXkjlInXi4Vgrr8
 6DG8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a bus_prot_sta_mask field to the mtk_bus_prot structure. This will
be used by power domains that have a separate status mask compared to
the bus_prot_mask.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 8 ++++++--
 drivers/power/domain/mtk-power-domain.h | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 9eef58d2d57..76f86b65f91 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -47,6 +47,7 @@ static int _scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd
 				      void __iomem *reg)
 {
 	u32 val = 0, mask = bpd->bus_prot_mask;
+	u32 sta_mask = bpd->bus_prot_sta_mask;
 
 	if (!mask)
 		return 0;
@@ -56,13 +57,15 @@ static int _scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd
 	else
 		writel(mask, reg + bpd->bus_prot_set);
 
-	return readl_poll_timeout(reg + bpd->bus_prot_sta, val, (val & mask) == mask, 1000);
+	return readl_poll_timeout(reg + bpd->bus_prot_sta, val,
+				  (val & sta_mask) == sta_mask, 1000);
 }
 
 static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
 				       void __iomem *reg)
 {
 	u32 val = 0, mask = bpd->bus_prot_mask;
+	u32 sta_mask = bpd->bus_prot_sta_mask;
 
 	if (!mask)
 		return 0;
@@ -75,7 +78,8 @@ static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bp
 	if (bpd->ignore_clr_ack)
 		return 0;
 
-	return readl_poll_timeout(reg + bpd->bus_prot_sta, val, !(val & mask), 1000);
+	return readl_poll_timeout(reg + bpd->bus_prot_sta, val,
+				  !(val & sta_mask), 1000);
 }
 
 static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 5bf0ca850ec..da7ffa7b722 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -68,6 +68,7 @@ struct mtk_scpsys_bus_prot_data {
 	u32 bus_prot_mask;
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
+	u32 bus_prot_sta_mask;
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
@@ -111,17 +112,21 @@ struct mtk_scpsys {
 	struct mtk_scp_domain *domains;
 };
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
+#define _BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, _update, _ignore) { \
 	.bus_prot_mask = (_mask),				\
 	.bus_prot_set = (_set),					\
 	.bus_prot_clr = (_clr),					\
+	.bus_prot_sta_mask = (_sta_mask),			\
 	.bus_prot_sta = (_sta),					\
 	.bus_prot_reg_update = (_update),			\
 	.ignore_clr_ack = (_ignore),				\
 }
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-	_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false)
+
+#define BUS_PROT_WR_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
+	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, false)
 
 int mtk_scpsys_probe(struct udevice *dev);
 int mtk_power_controller_probe(struct udevice *dev);

-- 
2.43.0

