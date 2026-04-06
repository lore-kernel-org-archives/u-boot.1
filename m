Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C2DFB5165
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C23584198;
	Mon,  6 Apr 2026 22:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jEV9KdUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA998415C; Mon,  6 Apr 2026 22:14:50 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B45840B0
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbd23bc684so1107056a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506475; x=1776111275;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YiN9f9S0C/srNIAZNOMjkjZJ5/kwdKorA/UiXS05XLQ=;
 b=jEV9KdUKCcB5wmgQRFlDwPo3Gir/F47pLfz21B8dIs+tl5fkLVTBfqpiIkMFJVMWx9
 csxqRmvxNCiOcHQicwUoyKiKTZ0Nt4kRVSZxTj17UA9WLCjIWzw56YjCib1eFQQD1Vek
 +I70jNbnO8Vk++oT6lH+kkTnna52NXw7KC5/sEux0t6OU7tMnF78b/7snq6YqigGGYeu
 4HEZDy0zMU+CxffjYucmmS4JQ8XrATw0TwXh9iNii+usuBi7F7L8urVMjtskCJO4NRcx
 ZDZVjAsLhn5jJ/4tn+2v/GRmtD5vLjV++JmaYpDTncuploZ+Ex9ZwCNNnA0FwLpbotae
 f/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506475; x=1776111275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YiN9f9S0C/srNIAZNOMjkjZJ5/kwdKorA/UiXS05XLQ=;
 b=Xg0Vgoj/Dy7VCKxymfi0DLjaYCtTzPeIoYOQ8Mq4fCiI03DmjFW8avXiyhqON0FwEB
 WzCdrOTt4ngNukcNLRIaHP7uZz7QP3CKuWC1BfStvd51OcscovxlN48bR63BAqM/7TNq
 I24tsC7YnKOM9l8X52YlSGd/PuXSzYUS9Ud2ZamED7csCnivs0TRMmeExATsSLzRQ7r7
 /hYeMMW+zBXBcSqYtV+nekLNFjeyZx4neCzwGTPPj4oVQs9x/tWlHU0i/r0a/qy8SR4H
 sEKeiMxLb+tumlMZjbtBjuczYLWmMuaL/pK9du1cDI3abzT+2BM4fSCqg2nsvMcxBNwq
 YaeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0lrSwdNjTNJ3RaHRVjCamk1sU/MVB7b5KJpB6V/O8uYpJ9AHjCNbVuPZw/Qp/Y7zVEN6zTBc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7FDuPnnwBAv9Eln16qWy2gnV10Oddgm2vdZwqA0PehELITv32
 ruO2QGK4T/6kGmqKYmA7zk/UpdI1qRtFx/4B6ATJnCbbj3thjYXKIrZ0I110JDSj077vo0tCW2k
 yhtS3
X-Gm-Gg: AeBDievMR0ZrklWRTLta/SmbZ55MWiVJZIjatOi3VFmzvsbafw8TAmr59uZUiT1S5Kz
 B8XcQSVoadnq/kGCLYvzUUdfnKrwhvAOoEvdhRf99I80a/In5AcyH1/w/8Z6xW9LQrp+unfHGl6
 GuL4yt63Wx0Dsk1UPO0xT2jz+63UUkdgpmFBsXug8qs9DDlUhNJyWLWjeJ73tTh29b+OFE9fy1a
 C6ZP3mln2aGhqOz4h8qXVfg7CLTvyzchItEhbPU04Wo/PnCQtey5Dc+nYUQvGTC9lK3znBxSgIf
 p7iNnAJdPbK65nSs9bikr2T9TTutz9oVGp7+oR6D2QLt32oMt4DnuNbuXHCjSqy+J8n18FH41gq
 z/gRrAfaNZH64EeSV/YnrTRB1ESnSrf380EaAU1oDDNvbRWXeuYOQSdlCUkNp4V1SM7lWdXuUKg
 cfc5Tsk/u57WbAX3BRM/ZKJdP/aA8=
X-Received: by 2002:a05:6820:2218:b0:686:d107:285c with SMTP id
 006d021491bc7-686d1073854mr1592151eaf.27.1775506475501; 
 Mon, 06 Apr 2026 13:14:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:30 -0500
Subject: [PATCH 4/8] spi: mtk_snor: check return value of mtk_snor_cmd_exec()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-4-66f675cbbd3e@baylibre.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, "Noah.Shen" <noah.shen@mediatek.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BEgMHMX3xCXQDXqUYr0m/JBrE33O2zVhysyHsrMiEZM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BQFYjagVrBq5Xxv7wY3pov44McppGe/qcfd/
 Wxztb0/ODqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQUBRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwvoH/0SY/4Szr96vsKbPTZPkkVFetgLqCkYO0eAib0S
 J82DJ5d7PTH/aGRT4Iz56S2t0oPECJs8E/mXFhDiUW5LrjvO6Vr149wG50lrOhwoGIF28AfFok0
 994KRhL22akH5JXtb238beIqtGpqfkrcLTzC8nfJRpsyF+90I4fg538lFRXRZvfg8RgyfX53c60
 hDCGKcN7N+2rZnzgIKfWiVxMUWwqI5yMtjbcbPH+J8f5Ck+CvF4A24/8/asUvy91k1MZWRbgNe1
 mHMAkyPTwAimECpeTBEQd7TAGkL3s0t113t4OW5N2nmhUjJIsL7wQKkgvLqBsTr/E2QCYgn2fsK
 uK70=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: "Noah.Shen" <noah.shen@mediatek.com>

Always check the return value of mtk_snor_cmd_exec() and propagate the
error.

Signed-off-by: Noah.Shen <noah.shen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 674e723db01..babdb4600d5 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -362,8 +362,12 @@ static int mtk_snor_pp_buffered(struct mtk_snor_priv *priv,
 		      buf[i];
 		writel(val, priv->base + MTK_NOR_REG_PP_DATA);
 	}
-	mtk_snor_cmd_exec(priv, MTK_NOR_CMD_WRITE,
-			  (op->data.nbytes + 5) * BITS_PER_BYTE);
+
+	ret = mtk_snor_cmd_exec(priv, MTK_NOR_CMD_WRITE,
+				(op->data.nbytes + 5) * BITS_PER_BYTE);
+	if (ret)
+		return ret;
+
 	return mtk_snor_write_buffer_disable(priv);
 }
 
@@ -386,7 +390,7 @@ static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 	int rx_len = 0;
 	int reg_offset = MTK_NOR_REG_PRGDATA_MAX;
 	int tx_len, prg_len;
-	int i;
+	int i, ret;
 	void __iomem *reg;
 	u8 val;
 
@@ -435,7 +439,9 @@ static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 	/* trigger op */
 	writel(prg_len * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
 
-	mtk_snor_cmd_exec(priv, MTK_NOR_CMD_PROGRAM, prg_len * BITS_PER_BYTE);
+	ret = mtk_snor_cmd_exec(priv, MTK_NOR_CMD_PROGRAM, prg_len * BITS_PER_BYTE);
+	if (ret)
+		return ret;
 
 	/* fetch read data */
 	reg_offset = 0;

-- 
2.43.0

