Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA91F46C7C
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15518412A;
	Mon,  6 Apr 2026 22:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="g+3I5JXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C8D84101; Mon,  6 Apr 2026 22:14:38 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE7784034
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so4316400a34.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506474; x=1776111274;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VKGm7yhCsjipaFsCGLxtb8PswdRVNpcFQxW+zs2so2M=;
 b=g+3I5JXFhCdBCGoDUhHY6Azv5ox2Nv7YTPqcTUg/LV7k+jbPu+sWULTddVkK0mWQNQ
 a5HNHRhSnT537ISud51Sldhuwiv/rb0iBzIal3t+3aa8u1CRGv8bzCC0d4g5l6lkw61F
 oR70ZaIMx0M+doFaPcPc1PY1OMzuHNlfkyOqHvCneiA6bweNfFfRIEhIdaLn34qrBr0Q
 9l9iAsS3tVmq1qxp/Rb2f1sIMEutiS9uUNKhdwgqzK8ZcsVC1cCIMUGsJXVrfi282Fg3
 ngUt/FmYMilMpp1hC7fyFBmfiJZvD6ne/Y3db4GMAZoq9XwhmEgbdk/uhgXpPyIEyDDL
 Rcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506474; x=1776111274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VKGm7yhCsjipaFsCGLxtb8PswdRVNpcFQxW+zs2so2M=;
 b=cvCGDI0zmzGdNFmHAmv2+PV7L0ypY0PV05NtDIRrBFsw6zwRRSbLSIATp2Ts/iGf7J
 +tpQSldl8EgmvjSeALl+5vKp1TRiBVWsnjE5n5LOSQZCfmYg0gm98xfJnTqxsxzZaGiz
 kWx0PwxzCSmVAnmVAH/vSkhaj/571XhlXPOvfHy09vOd4TDAOsrGM8hZ6xTYgK8657qq
 lAX23nSVCO46tO/BPCuWm8hsSbgfHg7oiWTOXTn7PHpG6d0KSJR8Cymfiic/gKGC/ldw
 3c2gEuegHG5ZOrYiAnIQU4px4O0eKbcF2dDPcN5aCj8B5uy4b8GzVpyDGwKnDVPLygOq
 axFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhyxUdRv4yPCO0i4jB+1uZuGIQdVS0wJWZzS5+G3c2zN54BKKh5csvPCqe/iiUXmkkTI8qqc8=@lists.denx.de
X-Gm-Message-State: AOJu0YzGESilOlYwDq0YbroA5Ntefarxb/+PptnTMYQZp4pV5ptkPpAb
 iDbI/jsnYysg4ozZPZDcnZAiXIvuixUCN9n0576UGadeGz26s/lG6UYtMkfT5mfIWLhhF+zYqMN
 jxcWs
X-Gm-Gg: AeBDievLuELC1IG05mYlnWo9LRPiIZhJlbc4RCnyqz6jEd4FZ8K0iHR23lj1Ermu5WI
 2GX96NOyzaNszjsvg1I4DRJu7J5GPKS7dXXe0Rm4UIaiVwqqAtE2NrhgKfGiAaRH3nwPsMwSXe4
 HhLpqkKoNmiGHSlKp1Tebf+ibsyGvhGZNc0siRD6RzgNWBE/JCi6p4QXZq6LGBKc0GEtHXs76eO
 jbc9sceVTz1sbZnjYOd2QPmHf8IScxF2yR2cO9x9/g3kQbI5hwxt3YnbTdtnsIKqgSBklxdRUx/
 dKDt0QDUe1yhUa71Lq9FCiRKjAgDqLfFxalHli3zLEKtdudYPEAIiLWD0zajM/Yx2bgOAxh1C1A
 zNOnBJLAhg8ic2N7kALAZNMvdUrnfORHnAEl14J5ZiXrZbVywyu6+921EufzO9af/YfjquU0ZkG
 nK5MyAgnNzouTXcU3mL26ESuHI9/A=
X-Received: by 2002:a05:6820:4b86:b0:67b:de4d:f30a with SMTP id
 006d021491bc7-6822094b344mr8024715eaf.46.1775506473708; 
 Mon, 06 Apr 2026 13:14:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:28 -0500
Subject: [PATCH 2/8] spi: mtk_snor: avoid alloc in mtk_snor_cmd_program()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-2-66f675cbbd3e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3788; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=MYJ8+w//x4zsArBlVUGfW1SKOP19RZGZatT9aBchbzg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BP4B8cKoEXEfR9h5+4oV93k3u8g235uQkoZq
 SaqsXICEOSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQT+BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQRoH/iT5YvSSVwzzyjFFuKm4TDFaAWgPIx3yPvN88N6
 0PsYpfiiuOgEUsLxxycLyfMGhl0Cv/QT19WTJSII2wu/iGVTXHkfH0GIS5BqJYZVpHobj9aogSg
 uTDnDOZadBjGqY9mP7dL9iGQqiRhIvrs09Bk2pejiPR1/RuSlb+E+vWomyf/eXk+r0dek0nI10h
 XmTyUGUhET/CgUVbFs52Dj7jwNNGj3jHEkyIyERcL2FX9LAXT/5i33eGWC9qS0Sl7/DcWGMNGOm
 KOP0WSa+44Zo9PZshEhnIlU8zYl22rDiAFAknqStQoE6FZIYKQopTb12noEBK+AQuvHco/ZabSc
 idlQ=
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

Rework mtk_snor_cmd_program() to avoid allocating a temporary buffer
for tx data. This improves performance a bit by avoiding the need to
allocate memory and copy data an extra time.

Signed-off-by: Noah.Shen <noah.shen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 77 +++++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index eb36c9dd5e8..0ff4a8b23d5 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -383,50 +383,63 @@ static int mtk_snor_pp_unbuffered(struct mtk_snor_priv *priv,
 static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 				const struct spi_mem_op *op)
 {
-	u32 tx_len = 0;
-	u32 trx_len = 0;
+	int rx_len = 0;
 	int reg_offset = MTK_NOR_REG_PRGDATA_MAX;
+	int tx_len, prg_len;
+	int i;
 	void __iomem *reg;
-	u8 *txbuf;
-	int tx_cnt = 0;
-	u8 *rxbuf = op->data.buf.in;
-	int i = 0;
+	u8 val;
 
-	tx_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-	trx_len = tx_len + op->data.nbytes;
-	if (op->data.dir == SPI_MEM_DATA_OUT)
-		tx_len += op->data.nbytes;
-
-	txbuf = kmalloc_array(tx_len, sizeof(u8), GFP_KERNEL);
-	memset(txbuf, 0x0, tx_len * sizeof(u8));
-
-	/* Join all bytes to be transferred */
-	txbuf[tx_cnt] = op->cmd.opcode;
-	tx_cnt++;
-	for (i = op->addr.nbytes; i > 0; i--, tx_cnt++)
-		txbuf[tx_cnt] = ((u8 *)&op->addr.val)[i - 1];
-	for (i = op->dummy.nbytes; i > 0; i--, tx_cnt++)
-		txbuf[tx_cnt] = 0x0;
+	tx_len = op->cmd.nbytes + op->addr.nbytes;
+
+	/* count dummy bytes only if we need to write data after it */
 	if (op->data.dir == SPI_MEM_DATA_OUT)
-		for (i = op->data.nbytes; i > 0; i--, tx_cnt++)
-			txbuf[tx_cnt] = ((u8 *)op->data.buf.out)[i - 1];
+		tx_len += op->dummy.nbytes + op->data.nbytes;
+	else if (op->data.dir == SPI_MEM_DATA_IN)
+		rx_len = op->data.nbytes;
 
-	for (i = MTK_NOR_REG_PRGDATA_MAX; i >= 0; i--)
-		writeb(0, priv->base + MTK_NOR_REG_PRGDATA(i));
+	prg_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes +
+		  op->data.nbytes;
 
-	for (i = 0; i < tx_len; i++, reg_offset--)
-		writeb(txbuf[i], priv->base + MTK_NOR_REG_PRGDATA(reg_offset));
+	/* fill tx data */
 
-	kfree(txbuf);
+	for (i = op->cmd.nbytes; i > 0; i--, reg_offset--) {
+		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		val = (op->cmd.opcode >> ((i - 1) * BITS_PER_BYTE)) & 0xff;
+		writeb(val, reg);
+	}
 
-	writel(trx_len * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
+	for (i = op->addr.nbytes; i > 0; i--, reg_offset--) {
+		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		val = (op->addr.val >> ((i - 1) * BITS_PER_BYTE)) & 0xff;
+		writeb(val, reg);
+	}
 
-	mtk_snor_cmd_exec(priv, MTK_NOR_CMD_PROGRAM, trx_len * BITS_PER_BYTE);
+	for (i = 0; i < op->dummy.nbytes; i++, reg_offset--) {
+		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		writeb(0, reg);
+	}
 
-	reg_offset = op->data.nbytes - 1;
 	for (i = 0; i < op->data.nbytes; i++, reg_offset--) {
+		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		writeb(((const u8 *)(op->data.buf.out))[i], reg);
+	}
+
+	for (; reg_offset >= 0; reg_offset--) {
+		reg = priv->base + MTK_NOR_REG_PRGDATA(reg_offset);
+		writeb(0, reg);
+	}
+
+	/* trigger op */
+	writel(prg_len * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
+
+	mtk_snor_cmd_exec(priv, MTK_NOR_CMD_PROGRAM, prg_len * BITS_PER_BYTE);
+
+	/* fetch read data */
+	reg_offset = 0;
+	for (i = op->data.nbytes - 1; i >= 0; i--, reg_offset++) {
 		reg = priv->base + MTK_NOR_REG_SHIFT(reg_offset);
-		rxbuf[i] = readb(reg);
+		((u8 *)(op->data.buf.in))[i] = readb(reg);
 	}
 
 	return 0;

-- 
2.43.0

