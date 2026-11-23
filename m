Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CC606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rsyOORhk;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oeHKLFml
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C97480E0D;
	Mon, 23 Nov 2026 10:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Ip_-tdltJXh; Mon, 23 Nov 2026 10:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 563FD80DC8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429370;
	b=sbs/J84XrHWGPNGbgttztSlonFopA0jNPF63FVx2X1Z4nN5WN5J0FxZF1VtO0uGkqoUt
	 3uA7bhVJ/WAf1mm4KSTl3sycdSFg3AML58pdBIgPNNfbSKVnGFYpHZp+dZpUbPrQWotIg
	 vtMFEf2EOMiT9/lmAlZ+qSHndowE+LJfBgjr1kdGSl0DgJK86xspVRM5a48BSc+wzUzEu
	 +L/BZaKzI4YadcHzbXo/Z/b+uQuE283+YDXhqFo/XDxXicUNNTHf9QZKXYAtpyxEgrsRm
	 OmiiDqKjr7mzsZplmDvkOz36gC3aqZin3S37EO/1UEj0Ad8pThXWKm1rhEWvarn/T5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XvHziay/5sflgi3ZAIc/qYlHKDMMCQEAnTa8j4oPhkc=;
	b=dK8AYR6Lu46PW7Mq+yWGI0CFlD1Uu1jH4/JeOqlpG0ROq/v6RUFoBAGlNVJV7j+vdQ+e
	 X3pxxappIatacE16LRW+TE9BSD7KgXeE/XUcBdlgA2wjmSSuDHs2SyARcMdpLhCktW2Hr
	 5mR6URHzSksWxbVmFjH8cOpyhO3bV7I9wuTQfZqoZYLGAnzcHyUZ7HbwV2K4sJkkMnYj2
	 s1vmMHU5zxJUANR9zmOQSy7ghn+se6WL2LTnQfhfopRxJjCORJ2603vXxBbm2mutpCkco
	 4n5dtrknkBsxkBl+Gd9aMc4H49fuGHevb82ux4AtSPU5GTG0Sht3O68LlQfxtNx/uQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429370;
	bh=XvHziay/5sflgi3ZAIc/qYlHKDMMCQEAnTa8j4oPhkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rsyOORhkpb4RRI8PmCgC2nxzamJzfi7lkU+sHVQR3S7grvMrEoiKPy3+NdtJAsNof
	 AF6PuiWniAQd6YnUFug9SuRW0D3u/OcxOFgh8rQpZHrCAdM57rdR0xYfPrK4IJNBd9
	 DpDKwlrLShkUozDAiI/wP8jiN2aBSLbNPg5hA00/3l84Zse2YG+eobXPneoxSLK2f5
	 WKiARONU6Vg+XXJmT/LrtsEMLkKRUNeDtLdFpv0QcVtgvaKPW+tinoOXTfv6ZU1YBy
	 XODrAvDh/G4hZlKh9iGv1M3QXVJsfQR4tLxx1lZmw3wKBd3V9xqWDh8ISRedhk7//Q
	 Verf0RN6GjZcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 563FD80DC8;
	Mon, 23 Nov 2026 10:22:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D37E260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 524A96071E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uziWS0Gd7f6P for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B03F60721
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oeHKLFml
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B03F60721
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:43 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso28311365e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429362; x=1796034162;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XvHziay/5sflgi3ZAIc/qYlHKDMMCQEAnTa8j4oPhkc=;
 b=oeHKLFmlXu8b2sfeLLzINCRZ2MqugQK1+EsbTZlWHEw8bGWKci7nYqulGlmdecAFOG
 mVDVctfW95uoA6RQ14FpLH+C/fdCGGrEEk4LQR73KvQ7IWnOOyO1ETOrGK+Jh+cN4XjM
 0/veP8BCxG9zjKMlJa+fk4dFzDxFdt1BSmvCClZt5SXCdCfKrEFa9f9CTdkQqHFKN9sp
 aDuZa74iG8teagIGter5Sgz6qfNkCbSjhGA0l5bMGvFJvas049g4TsU1tQRqm/DMSfnS
 Rha+NJ8f5JjjF3jIBp5ASv+Ub8hZXZjWbGBTFLLXRTAmluT3OTUu6CvqFqT8iHNZQDPa
 QQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429362; x=1796034162;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XvHziay/5sflgi3ZAIc/qYlHKDMMCQEAnTa8j4oPhkc=;
 b=wr3DwKUcTMLbVzBDjF9guTXmRwP1ptEP9NjnUuSAsAHK0x4lg05+4dJwfpLUm6qLM7
 D/bBRrIyWzkufY/++qsHQGN4c51lhQ5LZOPuCCv6WIiomOrc5YUsTZ7jAFiJcQGfl6Ja
 0BalQLFp+XUptuI2EBhHUQIyUxQryf4B6iLSvSpYuG0CXw3lloyA02dlIoAnUdja8Zny
 7iI1tohriPdXD6FTnqXms0Lgqb2RO2epG0YQS5q4Z6rIqnIZdLdHZms5WvN8lOw8bQuP
 BhmP86SBL+WE4sxYZ4lPLiBB2cUhSXo3xD5yeSE1Rgonb6lRStXuCbcpahurXkzV4rEB
 IMQw==
X-Forwarded-Encrypted: i=1;
 AL+hErF7ezaCcQJCOTYW3ifghejPpkKAZ76FufTrHV1oLT65+96KUQ0sAofxKdwY/cbVOTbBSyl3mnk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8m4GCDF0mCMy8NgQ/pHyofGIN4WCMtmgtt1asz/WagL57TBMQv
 EZc+dxCUHxgQ5dkO3O7XLJk2kjym0YIWHnPFSiDXuI2a3f+3jOJOuJp4OPbrdoxk+QI=
X-Gm-Gg: AZFdTZfPogeFiCm8cocklZDYOef7+tl30sb1gk/qWdOYnsbd8Izsrwz3teHkG3VmMzz
 xOWmJ/58qRrdqKPopop2P5BpHO+eHOe+uWBzva7psNMeu8AFOKV+TYjD6jTT4uXI/I3lqcdGb85
 u9d4dIPaGzSXPcoDRlaPUz3Nv6HOHMtY5RHYC0NLBc/rXsumHZbMraKqOrqVcy4e2dYtY/xqR1V
 LXW9XO0qA/Dp9mEZS1KTjqKxOFVLbi78I0ztTW00VcxOAUhSLv51gHIqtgnsQS2htPHNyXJVnTQ
 Y1hV+yXV2m486mFWFCI8gaMFE4ZLFURGzJiWGydhG5BPqqg5rqLd4BXoutH8MLt4fKZHKgnPJwQ
 AI9VKYyl1CrpMpHqd7pVor+Vjnu2XNkhQBiVbZP5ezKu6yu5ClGanl4akYdy7Qz/By3icNR+rYY
 /A9A60zlnMTfgweYhcjlr+MbAQy/OCoBr4ux9Ykf2Gmbe22V/KR3bFyihItTb9DoY7A3DNC4sAd
 RXcB8rsQeRZ8dCtFmNQDimHO3hvIiNo4Rsb433wDYcnLwr0gRRo9U5H4tviY2n3u1OqZMFN1hNZ
 HetmdULsTyyG14pvQAZlsLOlkXJuJJmr1VdqOdgnlsJVHRjdrbQDW4AFCU6oKHOtepyiy9LWyET
 SJHwXkYNKgdzd3dw8ey+hzWnMv5YbH/S8p3c3J1m/AlytZA==
X-Received: by 2002:a05:600c:4584:b0:4b8:4af2:88b3 with SMTP id
 5b1f17b1804b1-4bb88817aa2mr226743715e9.22.1795429362091; 
 Mon, 23 Nov 2026 02:22:42 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:41 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:17 +0100
Subject: [PATCH v2 2/8] i2c: mediatek: skip DMA for address-only probes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-2-7d3f843db7ef@baylibre.com>
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

The driver sets TRANS_ADDR_ONLY for a probe but still starts DMA with
a zero-length buffer. On the Genio 720 the probe succeeds, then the
next read times out. Start the controller without DMA for these probes.

Fixes: 9ad71f63401b ("i2c: add support for MediaTek I2C interface")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index aad3c4d918..d8a8f2a4ce 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -526,7 +526,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		restart_flag = I2C_RS_TRANSFER;
 
 	control_reg = i2c_readl(priv, REG_CONTROL) &
-		~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
+		~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS | I2C_CONTROL_DMA_EN);
 
 	if (priv->speed > MAX_FS_MODE_SPEED || num > 1)
 		control_reg |= I2C_CONTROL_RS;
@@ -534,7 +534,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	if (priv->op == I2C_MASTER_WRRD)
 		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
 
-	control_reg |= I2C_CONTROL_DMA_EN;
+	if (!priv->zero_len)
+		control_reg |= I2C_CONTROL_DMA_EN;
 	i2c_writel(priv, REG_CONTROL, control_reg);
 
 	/* set start condition */
@@ -570,6 +571,10 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		i2c_writel(priv, REG_TRANSAC_LEN, num);
 	}
 
+	/* Address-only probes have no data for DMA to transfer. */
+	if (priv->zero_len)
+		goto start;
+
 	/* Clear DMA interrupt flag */
 	writel(I2C_DMA_INT_FLAG_NONE, priv->pdmabase + REG_INT_FLAG);
 
@@ -614,6 +619,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 
 	writel(I2C_DMA_START_EN, priv->pdmabase + REG_EN);
 
+start:
 	if (!priv->auto_restart) {
 		start_reg = I2C_TRANSAC_START;
 	} else {

-- 
2.56.1

