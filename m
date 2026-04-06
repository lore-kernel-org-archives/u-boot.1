Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B572FB5164
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F4C84148;
	Mon,  6 Apr 2026 22:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="N84LYqDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D865283936; Mon,  6 Apr 2026 22:14:47 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044F684106
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbcd92eda5so1652734a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506476; x=1776111276;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wunvxFvyXIkAVH4d1pmR8fyc2psKE9YRFc00IWDE3jw=;
 b=N84LYqDI6FXmNIZD1BHYkLjlxDP8KAzE75QbzP25AmOMLF6BqMXyP0CsofmJ8sLZ/T
 MPFrgKnW9qhFaLGvXW/NSvml9s5FbDBbnH+JLgA4eAxk0bs48FQmZT+SIIrlHarbBOJD
 BvJFzUS5v2lS1tcRh+H8xkIkNoGZPBzrM5SPptOESct48Akq5KlhZkr16LYAZg6bKqB3
 7L0/LYTJ7aFSpHklsty6iHuQDwg/w/BAxBUCJENmSSVpsGTZu7naHGboDncZSyF26zqa
 oMSeabr0yS97nfpq0yaPoWbGhgpjq4T3uxh1IuV1z07+TLEaTM+TYCnlpuATqk6NILDk
 wwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506476; x=1776111276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wunvxFvyXIkAVH4d1pmR8fyc2psKE9YRFc00IWDE3jw=;
 b=eyEJKM7+FKSm/5A9KYbmbN7ZJ023HJbpvym5WmCbmZOlXU1LeBbiiVqm2/pJJ5ULWH
 1EUH5rp56UmKrZrNUdO6QRNu/2lfUQY9DJ5d8MWa8Uybe0G7g3mRzdZ0NOySKAYd8Nyb
 mIeYfAsO1hMVIXsu/IzqAsQnVwP7KLbIhHzCA1e+ZzG4vsukipnkJAtFlLF3innRdjOp
 NvvzbBk/n4X7S9qIaQ69f+2uh3e4eBZhErDdytqzSIzkebkXRLkThL4IlA2kLQLvXW49
 seQb36e7vRbTqa+/sAUXgdyoTDmc6VS6iR7e7lhBxDj9yEMsfJfEk7SqxPe4R3H8yfpA
 9XUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOQc+uep2FE1SRNEcWeNcT0z8o89WuIFesJfTuQEJrVTJKS8vp40i+S52sYW3zW6Gx5LgXwtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9BPHKm0v5xc4w6/yInphPZr90b4fSv1KjcNmEWyWTJK5uTyE3
 xgP/sURM2jnM88uzvmFborvtK+YXXQgq9uxGlpfDQrZqTCKJbu6b9R/PM+u7yMrY8lYFU1DYecv
 Y66TY
X-Gm-Gg: AeBDietSwPbea5IbZyzXBoJTleoE5q/EtfM7HHkrOwv5isMhYF/frdKsnUQMdJugJ3q
 FI5p+GTYePzM940ME2k+WLWXBMEn12XOn+Pc7zrLMTJLKiMl8DEu7/CyXBmZTuEcKEa4UY709V4
 MeSs12o2ylKBADsF69cghevqcyGPvFZi/ln7C+R6ED4ACtjRiflFJyOTJ9V5+l+HTZ9h3Ubhrvn
 v0nE0TX4tIXEpHER57KUhTUEyAoQndAH6fXYa3mjNLdqVoSM7Z4NGMI6QyI0czjkdCsH5diYTBE
 QMS25xf34nap6m23khH/t4u+ELSg9lqRoAvoFXZ/NHZ7E7u+kaXWj+47yVkK1sqSRWpuZhR66SM
 MDoMyJqyoD7P9c4XhnNnPEs0egmyiowG62SlTBQppZaYsdguS3+hSXNNj6HikWicTUmBy5on6X+
 8ca72igYghyVYKSIInjpCxD7l74n8=
X-Received: by 2002:a05:6820:2d08:b0:67d:e0fe:8434 with SMTP id
 006d021491bc7-6821e8625c6mr7709771eaf.27.1775506476462; 
 Mon, 06 Apr 2026 13:14:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:31 -0500
Subject: [PATCH 5/8] spi: mtk-snor: add bounds checking in
 mtk_snor_cmd_program()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-5-66f675cbbd3e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=miK/mxmL+mlMLs31piWOtN7kAAIrkzGe5H/hwQ8fUk0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BQNURxzHhDDtQXAJjFmvmqJBVB0npL1TT/fh
 zC2zuQAPxCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQUDRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ar0AIAJkQgxh8BMiW3m/tYDLXZXDRJ88Y0H9npU9c8ol
 awPTXE/+4NPEqLctet4xJnoyjmOeEYqkrIo1SfPADPSIi8ybBGYJtqUKM9H/CPAn8vKvHh7jjxd
 JUIuccMEkRrfMnzwIAa6BcPcAa+Yl9UC1mm1fEtV8YKLdtD3qbCoMo1lPnTeaNLzodw8dK3lFXg
 PN25XsCEkkocPDVvmWHXcGyRYPBUlLxDMooM9RvHhl+2W0pH8XgoNCPHYdqRu0gJqhV/6OpR/l3
 uaUcWmNFnvxJNRHxe70ZOKduQOxmAvRIfxwOUpwl5uLk0yvm+nM5rZ59urMNTuc/siNSQSgVuAh
 1c2w=
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

Add bounds checking of the various lengths in mtk_snor_cmd_program() to
prevent reading or writing registers out of bounds.

Signed-off-by: Noah.Shen <noah.shen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index babdb4600d5..77f94827568 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -90,6 +90,7 @@
 #define MTK_NOR_REG_DMA_END_DADR 0x724
 
 #define MTK_NOR_PRG_MAX_SIZE 6
+#define MTK_NOR_PRG_CNT_MAX 56
 /* Reading DMA src/dst addresses have to be 16-byte aligned */
 #define MTK_NOR_DMA_ALIGN 16
 #define MTK_NOR_DMA_ALIGN_MASK (MTK_NOR_DMA_ALIGN - 1)
@@ -405,6 +406,16 @@ static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 	prg_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes +
 		  op->data.nbytes;
 
+	/*
+	 * An invalid op may reach here if the caller calls exec_op without
+	 * adjust_op_size. return -EINVAL instead of -ENOTSUPP so that
+	 * spi-mem won't try this op again with generic spi transfers.
+	 */
+	if ((tx_len > MTK_NOR_REG_PRGDATA_MAX + 1) ||
+	    (rx_len > MTK_NOR_REG_SHIFT_MAX + 1) ||
+	    (prg_len > MTK_NOR_PRG_CNT_MAX / 8))
+		return -EINVAL;
+
 	/* fill tx data */
 
 	for (i = op->cmd.nbytes; i > 0; i--, reg_offset--) {

-- 
2.43.0

