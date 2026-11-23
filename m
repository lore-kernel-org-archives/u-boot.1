Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BcVkFaXS;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=H3DRu87P
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 678FC60743;
	Mon, 23 Nov 2026 10:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JiDbi94uaAbb; Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A408060721
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429372;
	b=AF3WQxgkhiZQN1OVg3pnX0a98ld63vnP81b5SV5uxH2tYnfZm1P/gv7+5J4Cm039l/Do
	 5XqYtWZvHuTe6MFQ4kF6XbKEmsFzQSJFGWeKL/wVDC63CalRGtqYgLM7HoksC2qVWU9BE
	 Wzum0zfrRXHPuUDNqZzORVo+b+NzIepCNf1xTeBJtoqP5YrEa8wxLrP8fe0FhfuEMjDdi
	 1vDVgXoODXcBienpW1XUHhtyzRXoQMKyfd0Kq/bsknTpKmF9IBpPHzmTmhZNaZII329xd
	 67m0v9xYfZh5Qt6vNSI6dEO2+0X+JPfrEE+6mWYiSnofenFsgzJK3ZFkDFVPzTo2AfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X4QL5c4KwvJtAk79WmjySQnMGVg9FwVbg4bYMJqTJXk=;
	b=laaexjxnidJ5DzxnT6AtUA1gQMze/Tz/+OCsXrfKsQVuyy5j+B4sTb4IR6R6VODSRbsB
	 DP48OWQLiBXyAd5gpx2kHeDPsKcM2pdQzx+q//+BOrYoyeueFatiEeuZAIiHr0IGRQon3
	 Gk2xbWTIJa3l2SGLdB4uiJKVH+1bkq4X3VULi4DagXh9WFdU57tw9/2iU9tx6hRv97fHg
	 81qBl8XCf5OhDd5JfcEofC3qmKGNyV+8q+nf7xypeZWj9zVo6I+oNAiyAFFgY2BevkeHI
	 gamc330nQs7qpu4zlMLHWFzx3S/HoOHIlV0uyzB+7BtftDocYlChy+ZaNwBZVP9lpyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=H3DRu87P;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429372;
	bh=X4QL5c4KwvJtAk79WmjySQnMGVg9FwVbg4bYMJqTJXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BcVkFaXSLPO+vts8xaKySlC+G4KB1SFcha9BZa2jRbPfsIESLfPgwUsYdWjGIP1jz
	 85P7IvypGlxJaTXdnAmvTVjLRlo0HM6Mh6+u5qc6HrF3el1BnxkxPI5HPTNsWdKQ/E
	 ukjjJeI+uf6Or2rG61N5kii6HnVhzpQg8mcnBBeCW5xwfco1eNyhkfe0j7Fl0EmSU3
	 z3dk6hgSRAQaK0LVXqN4rCiK5KBcL8HVQ+dhxoyHh+BpiJrjsE7GNf6/EnySDX+5XV
	 PWOqwJowa24atVusUdZTHIhu7RopSe9jQbfcIXJk8jA1M33JNUGKAcV9cvE473596m
	 FdAxw0PlAwHIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A408060721;
	Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC2F21AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E6526071F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlD82vQc-UuC for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CCE96071E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=H3DRu87P
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CCE96071E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:45 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso28311705e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429363; x=1796034163;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X4QL5c4KwvJtAk79WmjySQnMGVg9FwVbg4bYMJqTJXk=;
 b=H3DRu87PtI+oLvGKE6HaxInmpmxk8UbfX+b2NuWMGM5ZSspu1pA7Mk4OnS10v/1luQ
 5i8UJOr3EVNEDyveUzzSEbe87Vljd5R/wZhZo7pgUkcJi/ZTtmssTpNRXIHWD/Ps4lR/
 UXCeo05vuEEl6kP97KhHbYg+DKS4dp2Abc8HjF7GphwIITkd16GNklD0oyU9w8Kbwstr
 t0GTOcMA/d1Ny29xRSsyEGaO5cvRNQihHoXB0W5kIA6He1KMBDjQNjDB+vTVko7AbpBU
 Uyjwqs29/38rmG+tRm/TJzT8xDudqIKQMagLEWzT9w3M/EZytNnfHP9tu1kEtCqRm0Fq
 rDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429363; x=1796034163;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X4QL5c4KwvJtAk79WmjySQnMGVg9FwVbg4bYMJqTJXk=;
 b=OeGEev34gD2P5IzSC6WDbQ3v+HvdxrO3waCD+y2bF1hinCcoPQ1ufCzgOCl8eSpt7Z
 JbRvXg999wiTNl80ImfgXk0hLDylMIMYfD0FHo/VkQ5zrEP4f5XzrrPhXNFYK9BtNuyY
 7tfljPGvPqPx5xaNStz5xHPdUUeX2dUx+RrcKbTveycEBKM7vXoXe4aE2HeinLG554gG
 D2sz+Z8VJM9K5cTVWgXAnoHWA7HY0fdrwEj8EFDhWmsfPQaurBMQsny2btc7jMdlUbGa
 Okq+fUs03icKj34OvpvBlHeID+Os5+Xh1+2Z6ZfG/z/utpRV1kQpMJyb7i5F2HS8y+8K
 CM5g==
X-Forwarded-Encrypted: i=1;
 AL+hErFa05P1gmeDyiiSiBhVdxM3rcEDa2iwSYB5O28dIycwyYFlgeZNehykjOM5rU143ioGn0we6fI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Kc5Ldl5nM/Ia9G42q9+4nhRMEEZm5OUg1NhDEjRRtOwDJsTqN
 0JZoM3qG0rV0uW5OWTtBzW/YiPHjgrpaZNIiG8go9HZNswwGN47jr09N3xVGaAIRnak=
X-Gm-Gg: AZFdTZd5tdnmIchOFfJImXkPaloOrKKhdmkGXlhx/aDGrJYKChnK597uVEA43NUpb8X
 PgiV8ijcjhD61O15YhHQ90U8YH04mKN1qiCmqp+k1ZhmA/McmEKBVPAVxwfc1b3G9WxiUfKQbbr
 /E8xquh9uchF3GLNl8GKwiGfDgVFIlfDNeCI4zZA7CgsPJjAhgSpF6/xIKFukKZtlRz3s5DeTYZ
 unNv4D1byRxUt6pwJY04rxzMUCSI7bA6YrwV/h4ZvWv3jcTolbHCWYBO83hZdqQ32t+K8KkbQzy
 RcU1l+cLQCdTLkm8DAwOcodZ8CMYtfbYTMm5QqGy/3gjqHXYJV4J+u0yc6iqMw5i/f7+fL8qWTV
 IxHkK4seWw5JW2JvsJmWZ0ZcXZ+ExsrpN0pMEIEDMKQUv6ElFmGcNB1aA/370vpn9bvQ7ZmMeYq
 ReHXHNyc11M6aHBRSm8Tr4aUUEunRbM/gtCfzadU5FZ6TYG27gLzNCqJ2V4ep3oLMxk/7SwS2Ny
 uRfX9/SINO6FRCBfFwX32ne7FL3andfphr/pXxirqHsSf00XUzdw27mgbUZmKzYkDfRCuWAOQCQ
 haFUV9RjyK4WuRzUl2jwGV7csZwDUYq9vI0DgMM+BF+LEWXef+ZzWFUHr12jfZKnTipmEIhYqGD
 s6qj6lUZQLwuyA6Y72ipilYN1Imdw1EACsFNKlZR+nMAQwA==
X-Received: by 2002:a05:600c:8b5c:b0:4bb:741d:ea0 with SMTP id
 5b1f17b1804b1-4bb8880f621mr233627045e9.17.1795429363206; 
 Mon, 23 Nov 2026 02:22:43 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:42 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:18 +0100
Subject: [PATCH v2 3/8] i2c: mediatek: support 36-bit DMA addresses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-3-7d3f843db7ef@baylibre.com>
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

Program the upper address registers on controllers with 36-bit DMA.
Reject buffers outside the controller's address range rather than
silently truncating the address.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index d8a8f2a4ce..dd158c6d32 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -123,6 +123,8 @@ enum DMA_REGS_OFFSET {
 	REG_RX_MEM_ADDR = 0x20,
 	REG_TX_LEN = 0x24,
 	REG_RX_LEN = 0x28,
+	REG_TX_4G_MODE = 0x54,
+	REG_RX_4G_MODE = 0x58,
 };
 
 static const uint mt_i2c_regs_v1[] = {
@@ -214,6 +216,7 @@ struct mtk_i2c_soc_data {
 	const uint *regs;
 	uint dma_sync: 1;
 	uint ltiming_adjust: 1;
+	uint dma_36bit: 1;
 };
 
 struct mtk_i2c_priv {
@@ -512,6 +515,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	struct i2c_msg *msg_rx = NULL;
 	u64 tx_addr = map_to_sysmem(tx_buf);
 	u64 rx_addr = map_to_sysmem(rx_buf);
+	uint dma_bits = priv->soc_data->dma_36bit ? 36 : 32;
 	uint restart_flag = 0;
 	uint trans_error = 0;
 	uint irq_stat = 0;
@@ -522,6 +526,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	uint addr_reg;
 	int ret = 0;
 
+	if (!priv->zero_len && (priv->op & I2C_MASTER_WR) &&
+	    (tx_addr >> dma_bits))
+		return -ERANGE;
+	if (!priv->zero_len && (priv->op & I2C_MASTER_RD) &&
+	    (rx_addr >> dma_bits))
+		return -ERANGE;
+
 	if (priv->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
@@ -592,6 +603,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 
 		/* Write the tx buffer address to dma register */
 		writel(lower_32_bits(tx_addr), priv->pdmabase + REG_TX_MEM_ADDR);
+		if (priv->soc_data->dma_36bit)
+			writel(upper_32_bits(tx_addr), priv->pdmabase + REG_TX_4G_MODE);
 		/* Write the tx length to dma register */
 		writel(msgs->len, priv->pdmabase + REG_TX_LEN);
 
@@ -613,6 +626,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 
 		/* Write the rx buffer address to dma register */
 		writel(lower_32_bits(rx_addr), priv->pdmabase + REG_RX_MEM_ADDR);
+		if (priv->soc_data->dma_36bit)
+			writel(upper_32_bits(rx_addr), priv->pdmabase + REG_RX_4G_MODE);
 		/* Write the rx length to dma register */
 		writel(msg_rx->len, priv->pdmabase + REG_RX_LEN);
 	}

-- 
2.56.1

