Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E6606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0+D9jCUK;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gBo5DTdz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA78760A7B;
	Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKjSEnFQ6wpT; Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A507606D4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033816;
	b=KnUfDJtv9eoTVawWNF7fR0OwTE2Kmdk7WGhDUTK8e08qyenAv4RPjz3/+IsjeEoWN6/i
	 SXIN6zXRkRF3Ibiu4lXoCjkvMM3pw89/ck+z3m0q7fcwLQlyX3vRUN9anO5xa47LZRFqw
	 AjImN0nMsz7gvtvsVVDQTLdxOS1yoeO1xR6KyfQ3PtH53XhFBMgxd4j70oGchuYppAHU4
	 CqqPTqFvkn30HW3YxDwyI2fSRBt5sCds9avterTGKoMCmuesp2gbqsQI0jY5fSGfy1kI3
	 JbZZ7Dwu11E5pj9yqnQgWEi8Ojv8X/PC8sPxpyY8yN0JbbIM1L/3lPNDjkT3TtI/31A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kM0A/VTLLshGntMXv2WQ+mR63kf0CKRbD1eP/ZF2Nwk=;
	b=mzGT14y8ijeEr7Q8nlL4oln8eaZ4L0H6T5uH/bDi4DZXzVjpqtt/6ijGaoN+0bNDwgFS
	 UZMpy+/DzrWZBNUkYsspGZrlq8/UBFHEK7QEIJf+xHQA/wXuIaPFBD4ylTLEqJ3OC1YlX
	 oDRp1h65ZsXfkvwDS7Ngx0qeU7j0tY5eKi1uV4nC4BQIo0pPUv2XQldMOZyIQn/V5/2zM
	 wHhL8/VSBhGcK9PCFGeELNoJbWnOt0YLCDkdO2KLmVUhs2H9L4HMnMiH3+09y9P7fsOFi
	 Ev8roEaYPP6oCthsMkMjxICwN5sd8xD1T0CHWw3c9mSCrr6Furh7BiyNwQWgUPJlvqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gBo5DTdz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033816;
	bh=kM0A/VTLLshGntMXv2WQ+mR63kf0CKRbD1eP/ZF2Nwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0+D9jCUKcPZBFtpYsp3WICSQdz5J8HaNZNSZDlZiPUa1W9QgXPYQBlHFMopX5gd0S
	 wNqaKXUSslzXpFnHT1yu/6ylTMq4PT3sfMqzWFMBN13FN+t7e2JUzco4HCTKC0ptw6
	 GjBx21o456YPiAwGkcfyCwNF9K4tOVaLV2bQnIdL5JIU+11Rfbu7LZFSGcuy4QTtfZ
	 6Nc/uhvS6DYZtHJ2iTLuI5CIViyA30CQCv04cqgNBtdLG8Rmr0TRCsULYB8+BTztJp
	 Ckw0TcqvTD8i3xFq5RtZLdtFsozyQjVxr775BEmd8fcY66v/KLRUEgQHis53hNciNr
	 DvvAbmQOwgltg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A507606D4;
	Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E1B62F1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B27D606D4
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOf27N_qVyH4 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38604607BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gBo5DTdz
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38604607BA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:12 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso14811655e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033810; x=1795638610;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kM0A/VTLLshGntMXv2WQ+mR63kf0CKRbD1eP/ZF2Nwk=;
 b=gBo5DTdz4SVDFUrJEE9QoVEW+HZKJHy2SofuTIDwiuChzTRY1dlvmOZZztkOKxnSeP
 ACU3df3yndFZKlRpTYkInTg0T4ezXUPja8d97Zlf9r3YSBf6b0yEvmRISSHa1DWMh52e
 CaavK7e090467w/H7TSzBpTvlx3Rm/j813+8jYzyVxN0J/Hixxp6QKQnA9RmcHZRRivm
 DgAMMyVwsGlyhVU/ey1ktGeaODxTJYHE5aj6G17y+gaJtLXbZOav/g1RJxN74GHHblIi
 SpKg8tE2L/rhTrp0llacPHU3F4/TcHB7yAK4mfVYue7LyWMW30zNhtUyARHaEtH5H643
 rbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033810; x=1795638610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kM0A/VTLLshGntMXv2WQ+mR63kf0CKRbD1eP/ZF2Nwk=;
 b=nVHRLqmNIpoGtWP5ZttqjNaanYoB1oKa3fgpJWOz+a9IRK9OCMVc1BVcuF6/yWEiOM
 ZRah2QqZCfMfDfDvhXsd9rJcCWQNmEPGPK6WOtd+tKIAo+vyYpkJwlwhLRErXy89dfWz
 gIdhHOnmMb96jjoNetV9XtYCtphwyoaNTO84BeLl/Z2jOPaaok+BfeqdoiLSxhsxGzE2
 /wUf6Ub+tXR1NXNsmq5JsQLBg9j1EjNQcdd2TP+jZ4+Q/qf2Q3cNq/zeehufZf2+rkl+
 GOQpCYIaOSxG4JatXdGOL1Kuxv8Qft4V19ZWur3A2FBUO57PZv58sup3yFEnts58JpQI
 c7yg==
X-Forwarded-Encrypted: i=1;
 AL+hErGZLtE00l0AOUcBDTA+KiYZLZAsf3+TRib0WiOGE0TvDt37+wJQ/Pl4n2BUn+7kSN+arhSYUT0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8HZEzeWDN0RIaUP6qH5VxvnMWVjKCxUZK07FzftbYlO0D9Cn0e
 adTZgTsDsu8VXQdjWgGMp4w/m8q6su0Y4Ip2Ko6dHeTXzx3RYZpsUecaweglKkZRSt0=
X-Gm-Gg: AYBFou0uyalt42cF/O6P97G8QK4INct6DSUpbn3i66OHrb3LPlfjptHgEF33dURFkGH
 pEGMJtc4nAZSjvJx2Ur6CLmjTogoI1Dl+TCC/rW6uh12X4xRK9yBGpCSAPbUeKHKOMDiHZEh1q8
 hjn89pFyFMfS0VFp/ulkiz6mWaAgPU1QkXNbnjMsC9bYalo+aWsouHuTSM/0TzVoJdc9JZPxGd/
 BnhwRtDnfnfsv8EfhoPeIitWW8zrWghq4ByYBLGYYKzLGdOlWyMJ+3oD+6gI2i4AzjzSztRMAwm
 SENDHeHcEhwSsy46PtsYrufCl3uNqjhngmxgpaQGJZBsFV6XSpnbKANQJug2XC6qOOkLQ8kksmW
 PVLtJKH9qfMR2qnInYCoj1v513Li0Kis6wmJYII97HgQ0VQUIry2L0whdyfasgwGvZnxZkGiVc/
 ih8mXoK4l2+dbZBOeiuAHS5UJy8l6XgVCU6FOooODLtZG7+09k65SrCVzLPqZubJRdASM41RwWj
 2YSqjrYAXxV5UEZ1aRhtJAJyeDyfZWOdsaxF01EaNXg39EQlLcYvcK8m8+7aii7d+fla0IuKj6V
 ArGSW1zzvPKvU3G5tBGSHrrCqXVgCvkFuGgiuprrOqSfJAEmsMQBS0VTkYK3IzeuCbMeO+g0lDn
 x4z3lxJGvw1f26rYmMQ==
X-Received: by 2002:a05:600c:1c10:b0:4bb:60bd:53b2 with SMTP id
 5b1f17b1804b1-4bb7da1398fmr86628925e9.6.1795033810419; 
 Wed, 18 Nov 2026 12:30:10 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:08 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:49 +0100
Subject: [PATCH 3/7] i2c: mediatek: skip DMA for address-only probes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-3-916dd6cc8d1a@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An address-only probe has no payload. Starting DMA anyway leaves it
active on the Genio 720, so the probe succeeds but the next read times
out. Run the probe with DMA disabled.

Fixes: 9ad71f63401b ("i2c: add support for MediaTek I2C interface")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 54f27d19a1..e57eff970e 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -765,16 +765,18 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	uint dma_sync = 0;
 	int ret = 0;
 
-	if ((priv->op & I2C_MASTER_WR) && (tx_addr >> dma_bits))
+	if (!priv->zero_len && (priv->op & I2C_MASTER_WR) &&
+	    (tx_addr >> dma_bits))
 		return -ERANGE;
-	if ((priv->op & I2C_MASTER_RD) && (rx_addr >> dma_bits))
+	if (!priv->zero_len && (priv->op & I2C_MASTER_RD) &&
+	    (rx_addr >> dma_bits))
 		return -ERANGE;
 
 	if (priv->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
 	control_reg = i2c_readl(priv, REG_CONTROL) &
-		~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
+		~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS | I2C_CONTROL_DMA_EN);
 
 	if (mtk_i2c_high_speed(priv) || num > 1)
 		control_reg |= I2C_CONTROL_RS;
@@ -782,7 +784,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	if (priv->op == I2C_MASTER_WRRD)
 		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
 
-	control_reg |= I2C_CONTROL_DMA_EN;
+	if (!priv->zero_len)
+		control_reg |= I2C_CONTROL_DMA_EN;
 	i2c_writel(priv, REG_CONTROL, control_reg);
 
 	/* set start condition */
@@ -820,6 +823,10 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		i2c_writel(priv, REG_TRANSAC_LEN, num);
 	}
 
+	/* Address-only probes have no data for DMA to transfer. */
+	if (priv->zero_len)
+		goto start;
+
 	/* Clear DMA interrupt flag */
 	writel(I2C_DMA_INT_FLAG_NONE, priv->pdmabase + REG_INT_FLAG);
 
@@ -874,6 +881,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 
 	writel(I2C_DMA_START_EN, priv->pdmabase + REG_EN);
 
+start:
 	if (!priv->auto_restart) {
 		start_reg = I2C_TRANSAC_START;
 	} else {

-- 
2.56.1

