Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96446606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vYyUuRoj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ORD1HIX/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69F6180956;
	Mon, 23 Nov 2026 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMPUJq_DUC_U; Mon, 23 Nov 2026 10:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9647980DBC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429367;
	b=prLjj1g9VskdaRl9CYRRkshbGpjWoR3avlgqAae4WMpqzloMq1zyh6DlLVEzXQcwTY60
	 rCIVAdmEucIexuWMKjbxHoa+kJ7RtOQ6QzvT6JqoUcqg+B7uNYGvSx9zOleSqcAqyN7nN
	 SkJIMYtJpnVCqR5MBP02Ep46007YfcosvL6kCxXrW+ZrINEs/Xh2+4U1AbXw4kC4wSPIf
	 MOaLK/1AzCAJywA7kMPtI/T4LvK2wX9vUha6op5dGBesI+y9bQLAEypGfhTlLb1Zk/M3Q
	 B4jzZn8d2Muc+MOhhsdqd8yO6Mcac4kgK9pFwOXiOjJ7utXPpODWE+o7n4pa09BA+cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jsZkg95ofQK012mMokos8/TIw0lj1qsH1GU0kHZR6sE=;
	b=K2nDYGzU2fPD+L180xn5gfywbq4TdvU80zIJNtLPE03ZV4bvXPPVLS9dUhRc3ymvbCfB
	 TlQvCQKPONM9lpY8QnE0di/5lNTf+V5qaeN/U9FGmj9T96Y5abdkUMzjjniqnm8bRRVU7
	 dRx6lwIzViV+w9kaF9KRnljDhIr4W+3f1F/Q6iqnQk0QHvOQF/CtMYj6ltd8kbQ0cSiZe
	 uLq1YH2QmER+3USvcsdlX2EHvxnQjG6bNRkG83UD4TzZCJATXe/qt1VQJmhJdaR8xYoik
	 v2QNLKxjUiixlsG7xHQQKkFbjUoxaUhRSZePUYuJVvEy6d6KZu40BNhOZvwUZJQCCQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429367;
	bh=jsZkg95ofQK012mMokos8/TIw0lj1qsH1GU0kHZR6sE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYyUuRojFI/ZxobMbSSpaWNfPSo/bi736qpsr1C0mGvqgxgxHGrPBYwh1ANph8lR5
	 IfQw6SDWVNuvL+lLfap15boc33uuGU4kin/0bOE16i2bM7VymZAmNVUSZ7cdUj4Pep
	 hELmoWgA5xV178mLOS+x/VRIBl5x3wLb8wH05bRKfLv2Db1w+vWX3sshtioiuUBsVd
	 vvW+eWAf5bAuWiysRB+yZcf2O2pNkRo6Ww/wsRlCoQHGAbelaGSHm8dmLVan88o9OA
	 kTVgEw7lsC6TZvxEBfnLmyDTPP1fOqvkAritjUvA3rTih7/kA1PT2Grd6Kd2tY/KU7
	 3n0JrbT9KEnkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9647980DBC;
	Mon, 23 Nov 2026 10:22:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23EC4371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09DE960726
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vzAtfuM-gqaS for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 286E36071E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ORD1HIX/
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 286E36071E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:42 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so25466315e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429361; x=1796034161;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jsZkg95ofQK012mMokos8/TIw0lj1qsH1GU0kHZR6sE=;
 b=ORD1HIX/2roLGD/mXZu7LJorAfYFh7ZebRl4ek5/bByftBbdF+FS8Ng5pjluzT0n/6
 8p2WjO+A9mACYqqXsfgZwZsQpC89cf3j4Ax+Vzf9uP/+iASyIglFMtWyPh9tam4KQG0F
 Woim9Nq/8Y4GtQUcInUYVWcDIrD3Bo3yQFxn2cHl+QSDfM9+eFWF5g4zsYlEV5qUuZ3Y
 ZlKQRDQcTMjk9m/k8haS+lk9XwMd52BhGFGm6eedOPhelfFZYxtwsF2R/smBUeBlqs5x
 5rglNnl3bMM3czwOh3bw14QscpOx+u38MuYE7Mvc1rBUpH8Eoa9xvsJEIvv+j+4XkdPF
 Rsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429361; x=1796034161;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jsZkg95ofQK012mMokos8/TIw0lj1qsH1GU0kHZR6sE=;
 b=LRcyJjWV5jp6077MqWSDLSbLZ5fxEqDRNxJW5Nvr/LoHb0bcGbzPSJKXcgCKUHuJVY
 mcsVII2IUDTPfG4tER5vCbELBTMPfFRjVRBOSFSsN6uVWDBc+fv9RKwzbLONoIRMMiGm
 GgTIjeGlwe44VEiYPWDApb+X8FinxZR6Y5jitVUwC3P7jfl1SVmTlOa4T4BPPB13iHoJ
 IMhtgEnIxXSOD3PIRNf21JsQ9lhTs2QiVeaegZBGHYzY0peKhg5VDeamD5fl9y6JCC6V
 M9Z4o9Gvl4K1eH+Cl6M9EL7Pid5ySi8ocpQIHqaUEFZVKmInTJ1uB2PjJOSMlCV3qx1u
 nStw==
X-Forwarded-Encrypted: i=1;
 AL+hErEFd09gSx4j8iA0JJwhgm0+x8JEVJOcXRLWhiLaWsmKsH13ZNq8DNcShG8oLGyyMgEktBkgmQw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Pf+XBet8FVzOU8uVSaSH+nLjCicsK0khrtEVfFCaBSsoJGsad
 NO2ogB2ZOM2j+f4srpuNOFaGhm2CWQaluPpIfl/hlBcido5MHNIeiPeqDwhAqRNTmBU=
X-Gm-Gg: AZFdTZcUu9eg4MexvrgDmyJUnTi9avUiIrj2xaQkhiwdJwwzMuHB1RRiE/ugdx368lb
 yxDUxeMT/7YkY61DS+C/W9OLmd80CMQW23+PlQxv6Mo/ZpoEfAQUv8ahEzJK/7J+CCoIqtxFgjm
 S1VUkcqyl1DInnepkGKDqtKbHs7kzWX9/ShjZ7YCXwtJY9VfxYygvgOB8dl3xURWZPIGz6XEFKi
 dftWbowB8uBV7WAHRjC6LKClJkYmiV27NY/TEFVVaGTN6oxQ/XhzrtPO3f+JjoWQ6+fj4Rf6fKs
 bZYmU+Nr9LtTmmXaBM6Ikpw3gRo2E2dz5NiP75RjQnEm/OMLopHM0MqamKTe26mFU219anbSzAL
 zZKrRxN0LZJgc5vnD7PxO1THvpKx2ywJgjMvUCkQSxJCUiIji8h/+VU1euDS+rIjgXHN8S9qLaj
 xCDFiPeaOca/KB3TTj6hZxXvnHQ+wlsZ1tVE6xlX303HjJCvL52wPsRnNJUzuxxbgMFLVqkh3ak
 xgG/mFrjly2PvdYtb3f4TeMOCzy0c08Y94R7HGdX8+Ps6DYk12LnFEVAIQhas3e1hAeVMuabpiM
 N2rH8zqteogjWf4Nl5LgJq0td05ZyQ34+rDq9pF+uNml3zh12ibs2RL3AxU2l7nuA41u8adA6wD
 Db1e0igLUSxh+PHwGhXfJd4XHjuyCilZQTm5H+3MGIBCLNy4=
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id
 5b1f17b1804b1-4bb8880ad4amr220894395e9.7.1795429360997; 
 Mon, 23 Nov 2026 02:22:40 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:40 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:16 +0100
Subject: [PATCH v2 1/8] i2c: mediatek: align DMA buffers to cache lines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-1-7d3f843db7ef@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I2C message buffers may share a cache line with unrelated data.
Use aligned bounce buffers for DMA and invalidate the RX buffer before
copying the data back to the caller.

Fixes: 9ad71f63401b ("i2c: add support for MediaTek I2C interface")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 55381dbece..aad3c4d918 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -12,6 +12,8 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <mapmem.h>
+#include <memalign.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -505,7 +507,11 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 			       struct i2c_msg *msgs,
 			       int num, int left_num)
 {
+	ALLOC_CACHE_ALIGN_BUFFER(u8, tx_buf, MAX_I2C_LEN);
+	ALLOC_CACHE_ALIGN_BUFFER(u8, rx_buf, MAX_I2C_LEN);
 	struct i2c_msg *msg_rx = NULL;
+	u64 tx_addr = map_to_sysmem(tx_buf);
+	u64 rx_addr = map_to_sysmem(rx_buf);
 	uint restart_flag = 0;
 	uint trans_error = 0;
 	uint irq_stat = 0;
@@ -567,32 +573,32 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	/* Clear DMA interrupt flag */
 	writel(I2C_DMA_INT_FLAG_NONE, priv->pdmabase + REG_INT_FLAG);
 
-	/* Flush cache for first msg */
-	flush_cache((ulong)msgs->buf, msgs->len);
-
 	/*
 	 * prepare buffer data to start transfer
 	 * three cases here: read, write, write then read
 	 */
 	if (priv->op & I2C_MASTER_WR) {
+		if (msgs->len)
+			memcpy(tx_buf, msgs->buf, msgs->len);
+		flush_cache((ulong)tx_buf, ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
+
 		/* Set DMA direction TX (w/ or w/o RX) */
 		writel(I2C_DMA_CON_TX, priv->pdmabase + REG_CON);
 
 		/* Write the tx buffer address to dma register */
-		writel((ulong)msgs->buf, priv->pdmabase + REG_TX_MEM_ADDR);
+		writel(lower_32_bits(tx_addr), priv->pdmabase + REG_TX_MEM_ADDR);
 		/* Write the tx length to dma register */
 		writel(msgs->len, priv->pdmabase + REG_TX_LEN);
 
 		if (priv->op & I2C_MASTER_RD) {
 			/* write then read */
 			msg_rx = msgs + 1;
-
-			/* Flush cache for second msg */
-			flush_cache((ulong)msg_rx->buf, msg_rx->len);
 		}
 	}
 
 	if (priv->op & I2C_MASTER_RD) {
+		flush_cache((ulong)rx_buf, ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
+
 		if (!msg_rx) {
 			/* Set DMA direction RX */
 			writel(I2C_DMA_CON_RX, priv->pdmabase + REG_CON);
@@ -601,7 +607,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		}
 
 		/* Write the rx buffer address to dma register */
-		writel((ulong)msg_rx->buf, priv->pdmabase + REG_RX_MEM_ADDR);
+		writel(lower_32_bits(rx_addr), priv->pdmabase + REG_RX_MEM_ADDR);
 		/* Write the rx length to dma register */
 		writel(msg_rx->len, priv->pdmabase + REG_RX_LEN);
 	}
@@ -660,6 +666,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		mtk_i2c_init_hw(priv);
 	}
 
+	if (!ret && msg_rx && msg_rx->len) {
+		invalidate_dcache_range((ulong)rx_buf,
+					(ulong)rx_buf + ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
+		memcpy(msg_rx->buf, rx_buf, msg_rx->len);
+	}
+
 	return ret;
 }
 

-- 
2.56.1

