Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B60B1061B1F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53928403D;
	Mon, 30 Mar 2026 22:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i7YavUfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081878352B; Mon, 30 Mar 2026 22:43:10 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D472D83CE3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso3393828a34.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903386; x=1775508186;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqye4zgq5iUy+dhQbmnvfTVtptP9gDxtiPfJoZB4vrU=;
 b=i7YavUfquOQiOyiN4mZciiy5w/v6786Hr1SJkYrru1w5jzs8V7twXNQc2hqa9XCA/s
 LcySz+YZTFVpMGcpABWgS1h7YzFodWeAYy/VQwdfgIUJtJ6l/DojLI3H6p/kBizcPoPk
 Am1A4vvEZdw5cm2lPxp12cEKB6bkL+L5lR8zBTQjAKPB6+o8K2V75rZv2FPpEo8ouWMc
 8INgvIhqDM9CHDir1/wFdbfhjlsgF/4zekp3G64YtSFSHFSYNShFpPLULFfyL8cVHerg
 +WTy7qen3YLoX3O8WPBZceIGeDLFzyaxl9osxR2nR5gJW34RQVm4WuZ7RE7oLSGnPCvU
 sWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903386; x=1775508186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jqye4zgq5iUy+dhQbmnvfTVtptP9gDxtiPfJoZB4vrU=;
 b=Edr68z5jUzwC3gE2odyu/5yXClZsRi6lNnr6YXEMtG5xhmY2L9GxsV2bBcFIQzIX9b
 fXJn+OF1UNl+tajdy3qwsPDIacMBdeCe3KAnkUmXKFwd+yg33ASaw5Mn9QDy4xVun+dA
 847UyI3htUmYSg2WTy/mzchi0nUw9r1BDxH3USSgw3OOYwf0RGtwEVDnJYoUd1UTW9Bs
 vJgsiOn9ZGlc0fPl6/TaHToJSjLkuFhBlUk0W2nU8IUUzodEQJjK/BCbihZTbIIgoKxL
 Oc4lhTqY4zHKmL7kB/hXVORjdgmbNrMVvpcOu2NXTXr5e/cDD1ga/PIg5wiPRwD0Sf0R
 uqYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEvZcgyxYs0WofICDgk8KXAvorgtWeUZI14+jjzN3KcmVOMxMSOFTAUvVFLqTXL0vLmG/pZqc=@lists.denx.de
X-Gm-Message-State: AOJu0YzI2F8S4jx1ZW8zW1Bq1lokyCO/BcoJnkJZW2We/5RArRvsFjBX
 uMaUraWf7rBQKdbDI3XK9lGfyufObIZECSKgpH2Ki3+KIn0raecx37OHun8Re4QywDg=
X-Gm-Gg: ATEYQzzblbKZkBCBTzPVxhM4o+EfYI6AsjXBtnNtywTo/b50X6J7wqj25zBOl0mS6jX
 YNpn2eK0TdxRV9XRyC+0COFXDpzahE19zN/3BsW4KlCXNXrYnMVfDh8r4IFja7FzXzsFODq1BlY
 cy4ixSAnlcg3z2hQCDG3747R648W3DemkA3mFuhdGXaiE+fBp7JGh5uqDLxKIq2XVF1Hs36ubyL
 DPP+D0/tNkVf1fJFy24nkPPOOha18AW7CqEgfSEausc0yGngyZxsMhkVB6wlhT3AlGVkEDNw21L
 TKToyCVTqwqdCOm8zSslqDkoD/qvNkp4WGlJ84/kUbJEMdHhMdki7UrLWzuskZRKczzdn3T209s
 9TfVkCi2hKrgkrK1AmDPaWuveSH9Rqfq+epgXj33mQWlpK/2gClkBjlc0QnWC2bi4/35Vreq0eC
 xwAURpIZkLod35LujryZJB7rLK7oGE
X-Received: by 2002:a05:6830:6509:b0:7d7:ef0a:1ce5 with SMTP id
 46e09a7af769-7d9fad4ecdemr7487147a34.9.1774903386447; 
 Mon, 30 Mar 2026 13:43:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:42:13 -0500
Subject: [PATCH 1/6] ufs: ufs-mediatek: add mt8183-ufshci compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-genio-720-ufs-v1-1-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TaNSzi+rLQNk+QiFrtpzVV4YOvQ9Gd/F+kF5lnLbihM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuAwS/z0dR1dISapvjeCvm3mPXN7PCzTksNIQ
 BiwZd61hNaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgMBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AoMIH/2ICCustPH59wil6U6571QBIGIhxjTjRWu4Kfyv
 rLNldR1pXIqSREVI62CUDbxkyJ+SxNVCk3HhQEXczw9CLZtWTTp+TRzCuX2ljc44r7lIJf0ipQW
 Z6YeaRyMcXmr7JpeeW6Km+D3ql6vT0iMspDDHYp4zktNUjck+p48I/UTCscUv2cwvNoWg0HZZoh
 yTkmimCbPEC8a6Tpzz7GNBdbQNILFDR7SOn3OkI1PrLsFf/epJ3JF3CRwjHFvA0OMnwPzUu84QH
 Iv1mw6Qh6sskEus9dRRPZ7KrRxhuEJmzKcw1wfPFasB/QbCIuXQHWvURLQBDn2VpxzrwUFnsulN
 3hAs=
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

Add a new compatible match for mediatek,mt8183-ufshci.

This compatible is already defined in upstream devicetree bindings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 252c5fc4318..2cf65a3185c 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -395,6 +395,7 @@ static int ufs_mtk_probe(struct udevice *dev)
 
 static const struct udevice_id ufs_mtk_ids[] = {
 	{ .compatible = "mediatek,mt6878-ufshci" },
+	{ .compatible = "mediatek,mt8183-ufshci" },
 	{ .compatible = "mediatek,mt8195-ufshci" },
 
 	{},

-- 
2.43.0

