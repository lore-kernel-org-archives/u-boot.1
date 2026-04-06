Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D8DF46C7C
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021BF84101;
	Mon,  6 Apr 2026 22:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="i5QdGLTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644C783FA3; Mon,  6 Apr 2026 22:14:45 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA92183936
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40946982a78so1300313fac.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506475; x=1776111275;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ImF7ETlJ17SJOnDKQIoOd1dK414rrbCe3DpDaDCBbnM=;
 b=i5QdGLTdrEHGU85ncLcWnwG9+Uyc/4PdjITVLZb2NbgP6JydpSUTWgTGhSJIqeI3vy
 CmzJ8aR6ZLArE8f41xEILKMF4yyBoYffaquWmiBarkkJe/kVlbfH74eEpUbJ9V5dA9ZA
 dkGUO2GFiyGx6RE6Q3MhdyURaLu7vMon4v+R9sCHM558cvPPr2qsVVU59kck6x5k4ZAY
 75TTuAh2G6tP5cWiG+Xu5INNMOdQtx4xfBTn9wVsBAUIA64BqS9XG9hE2NJ27NOa3rsI
 wCa1u6ui7IyKzOXv3KIGh6ipNFWYZqNXyf0NdgG1M4KmSvj5OYx1q6fCydcWuIeBvyx3
 dIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506475; x=1776111275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ImF7ETlJ17SJOnDKQIoOd1dK414rrbCe3DpDaDCBbnM=;
 b=X9jsu/T7TCCXVrYu8bO94IRSkK5eqiQB9bvKIWr/RTuFdhOCOUWyFp3yqsPX7yyDiK
 inXHhpl6h/PFkd0+XWTDWAASAyPmSZoBMzEHR+wa0IHtczt+Yd8DWT2tsblYyc6DAJfE
 yCUo0mwG62oFfvWnvKNLbFENoZ0z6J82+lBZkHj7kx4qN6PGiwZ5y2pJjGucIxFBssd2
 Do8W4a9VVczRHW/YTMclLqyPzTFg26tMgnwePfH8XPJmaTpJ10rFFpRf8drSYmZru9np
 qek7lei+4aJpg0aJMjzfTEzAqq/0oO/BxdV7ATUY/V1O4hb4n4m7a/NEv/6ZaDQgKDE4
 /Ivw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHjeSbBXsl35vKV3NvWkTOmuawEVsS5uQD9du1yjzCxHPRMK07n5royagqiQX1E/GaKMQ8Nq8=@lists.denx.de
X-Gm-Message-State: AOJu0YxhALB8JqZpANAdg6bEqzF8rQLBporJY746zJlQnM6bphb+7rCl
 744GKAGpIl1ok46P6x09KWFQxaHwxjiQv6kv766N3v+9NaekvzVmIUxX3yqK/yoAg90qZUQ2ZCJ
 dQ7zo
X-Gm-Gg: AeBDiesiHmBIoJvDnZnO0Tjp7gWGQS+XCrSdeR0kZEUfoVikqwj6Sksju02BSqQw39B
 4+JCTmZID/jVq4lkWEbRwjpMnfVLU6mAAkLarAiB7Jd2eKMHacz5riZchD+CHLQRAq9UuyI9voR
 wbDiKmwhqG/bg4U3SCBIYuodH9x0XGJ8NQd9GtJD7zGmNkL84LbsjonFOUFQ7n+e9rS2MykR1Bb
 i93OEHz4lNU1MkxLXzMVduk9oiWxCOUiyvN7U9o6MZF12gF6rs6ziLsQ+O8VMNk9pFmHgNU562X
 lCbse8FNkbkKHMbsheDhCOD5sCsSYXbaC3ZPRd4XOJp9IExxsk2Mqb9HTSfcdyQBD2wiijbfTJ9
 l94RAs9Rz0Ua9z6gdVoiuzUoMT4nD/qvlF6fMr9MlOhwhuzf+pIEv/im3tROqPE+Bdsy7GTlFFf
 i48U2Je71p2lyyaaC84avNWsZDmnY=
X-Received: by 2002:a05:6820:198c:b0:67d:f55b:a992 with SMTP id
 006d021491bc7-6822152ac2emr7976286eaf.46.1775506474576; 
 Mon, 06 Apr 2026 13:14:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:29 -0500
Subject: [PATCH 3/8] spi: mtk_snor: conditionally copy tx/rx data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-3-66f675cbbd3e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0GVKm8oGpajxQoyxghfzk4OPul0gB7mx+9rPiJw9bjY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BP/qFhbnXi6GoeJFQivOFzYGNR9hVZBHv47O
 cQEXEWAl8qJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQT/xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AA0MIAJtpunQxr0WujqkcWdJmxXBDHoAcb2Kl7DqwP8S
 nEZ3qTH4XUE4LLSmRAxcXAbKY4eLff3Sx9XRcZCakgzhxFByC5urSa1iDpN1kEgLb9PmXl8QLXU
 c2L4g9RKQYgz57lQvD3X50CEcnYQn/3NuXUYptBcskhGeRVpVRt2my3xhCXwWpjW/kqy/pC6UNa
 51/fp3ok6x5lGk6qJPb3wDsQemmmRy+qUpbRJA/gZGK0Vx4AJguUVuCynp2M/77CAUT6LBsFjIb
 wkpwvTL5iFQvDvup6gZvbbDRb6I4oWSrWs221d25+KPFUsaxIW20pMBFDbZF7XNLSVZusYR6NCB
 2C48=
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

Only write out data for OUT command and read in data for IN commands.

Signed-off-by: Noah.Shen <noah.shen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 0ff4a8b23d5..674e723db01 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -415,14 +415,16 @@ static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 		writeb(val, reg);
 	}
 
-	for (i = 0; i < op->dummy.nbytes; i++, reg_offset--) {
-		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
-		writeb(0, reg);
-	}
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		for (i = 0; i < op->dummy.nbytes; i++, reg_offset--) {
+			reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+			writeb(0, reg);
+		}
 
-	for (i = 0; i < op->data.nbytes; i++, reg_offset--) {
-		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
-		writeb(((const u8 *)(op->data.buf.out))[i], reg);
+		for (i = 0; i < op->data.nbytes; i++, reg_offset--) {
+			reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+			writeb(((const u8 *)(op->data.buf.out))[i], reg);
+		}
 	}
 
 	for (; reg_offset >= 0; reg_offset--) {
@@ -437,9 +439,11 @@ static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 
 	/* fetch read data */
 	reg_offset = 0;
-	for (i = op->data.nbytes - 1; i >= 0; i--, reg_offset++) {
-		reg = priv->base + MTK_NOR_REG_SHIFT(reg_offset);
-		((u8 *)(op->data.buf.in))[i] = readb(reg);
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		for (i = op->data.nbytes - 1; i >= 0; i--, reg_offset++) {
+			reg = priv->base + MTK_NOR_REG_SHIFT(reg_offset);
+			((u8 *)(op->data.buf.in))[i] = readb(reg);
+		}
 	}
 
 	return 0;

-- 
2.43.0

