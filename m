Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C54C531C9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 23:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F659607C7;
	Mon, 27 Jul 2026 23:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4SseREIlSNR; Mon, 27 Jul 2026 23:25:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F7DE607B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785194729;
	bh=Wssrpae30i7WYzSVP3z9MG3dPhXD8V/qNknwlvqC6Tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lrGqhn3JLxjA+JT2qtrs/z0U+0TEDjknm7szqVQk/j7ccha8LwAJTDVf6eMPTcOVy
	 dwLeMxkO02KLD1PbPIghHqedLWEMWWJL45t7hHSK6bbY0X6i2tHlWuD+onYMHaRI0w
	 Wyx2WOr0/WpAadpRTimCNMy3gE5y81FttG+at1YxgDasuWg4bLQ09VIHFS25rRiti5
	 K01GHbN/MzvjG73q7nOxXXO+13I8/JKTPaRSPsbEPSraHEm3jfXzeIKhKo9I7/7yOG
	 WklNLLhBr0Zmyfunq9FuFUXYFSOLGavNGuW+P0jOMBsZ0xJ7FUO/eP4NuvW5jEXpMz
	 XIlvLQQlcMg5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F7DE607B0;
	Mon, 27 Jul 2026 23:25:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C1A72E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E81040205
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r99fJlacsaDu for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BD39F4015A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD39F4015A
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD39F4015A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-456d267da8cso1370959fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785194724; x=1785799524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wssrpae30i7WYzSVP3z9MG3dPhXD8V/qNknwlvqC6Tc=;
 b=gI0QjBOJCxjG+aUs53uGfDG+xfmb/+pRaOkuUcoEW0iGZn5AswM4ypWXTmyCY7Ibmu
 DTvRoRd612FkFi1smGcL9RyN6i0pKnC8jdtt1+Et0FTFdW/4CiLXlqRayD7+NnCNSN1l
 B/d2p+sGKogOKK6imhS+ehOKulXflOCogs/IMQxQlfcEMcwftbWHtRpt/lbBbBAkukN+
 Hv+TZrtqzogFoc3hmQYfQs5FmSZlU6zmARLv+BwObnERT9uavxiNg8m33Rh0VvcsDJtC
 MtaaS2jjODZlxr+Y0HeP8C3bjaF7rRBf2dp8EXq6BKhpDjPA43/lSqgBU7ZYGixhWoQy
 9ogw==
X-Gm-Message-State: AOJu0YxIFrtOX0Ygd2JAy5o9Q4BsL0XP6n8juwX0xaUq5T+83nWbDvfW
 2Mp8w0UthiXOSOKDJSo7e+rDMAJTs/QOKnQQI/xEzWTFf6Amul1mn4G1AhivAy8n3Hc=
X-Gm-Gg: AR+sD12nJz9kRktthfup+g+ivmkfqVd2NG/ANR/YFwCifr70I6n6jvCRqiJ0kwRiG8R
 nJOi5QU06BLySryvJQPJ5bOuuuaYV0H5CkPpmKs+NyfPMwFAf04+iHT5z1AzK9LgbLEScsgJUJs
 R9GFUHxWxNbh9E6iFDpRjWtRGyB2HxSyQgMgrx2ICnh0VbfJiaRjSLL4kaiPMssNv4KyD3VSjZW
 HvTr0Sc+k+XegdhGK3NbWgxDa3FKcyiP7tFB1BtT3qDhRbJj4AbA2eqHE3sgF8Ej0Yq1kPZwLnp
 QTFjzjW0CCyOKFc8GxLZ7FoYbaQ2zzwNXXpidDFS9QvkqOV6JpgUSQp8gHKNMRbN93A/FiUgNdb
 IjHAoPGHkKSmdUsnTBVHuHEus4+AVbHabbQcy4WoZPq3JXnxZusoeEgO2Gg1Qc0C1hkvkv0vuII
 6YksF6duM=
X-Received: by 2002:a05:6870:71cf:b0:449:bccf:bb67 with SMTP id
 586e51a60fabf-4586c3fbe26mr662fac.5.1785194724459; 
 Mon, 27 Jul 2026 16:25:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766e66674sm14810638fac.3.2026.07.27.16.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 16:25:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 27 Jul 2026 18:24:56 -0500
Subject: [PATCH 2/2] serial: mtk: guard clk ops on clk.dev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-serial-mtk-clock-fixes-v1-2-1d5542de3d28@baylibre.com>
References: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
In-Reply-To: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hLfWlhIIlOwff3c4nkcVGA8x9wn1HqG556++TYqyXGI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqZ+jZuc9QcUctP6Vm8pxdNeACeCh2Gmgq/JEqJ
 5BKtL5GZeqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamfo2RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfswH/04nsR5Y/WqjDcyUv56j+ri5zeQz0szoF8TYDVH
 bgUTU+Yvy0I7aXcSXuWJbgpdF1bERmXuk0QaAxyVhx+uvK6Uw7l8TM9keH6e11zN2dwtZR7MHTW
 edYC/HCmMFHNEyg0WyiJTp9Wp6CND0nv5mPHuH2GNOT7DKcisGJsIuTMPXnfCCjCCGjkq1/31Ll
 gMOX78SxfDWd4Lp3DGqkJ2Ehdz/kRFbSMHWUbTI6wCzXQw9UnODPmGFIUTNtOdteVQdK6Aa36zh
 Lql3w2n/Qe4jGamqZmgQfx3YLePEo524drKqLnvvi0D3P9bgzmqhQFvJPMGOJVa6yW6YvCSTPqs
 IjXA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785194724; x=1785799524;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wssrpae30i7WYzSVP3z9MG3dPhXD8V/qNknwlvqC6Tc=;
 b=g00F29e2+ZoyFfp3J6vZdcKMcOPNEvGELpYQpeWdc/0cZqdPRESdMJoGB8Lz7CBHcs
 Aztgd/fkZONAjJprIPZUaSv74lncyg735OZcQmf94XJudomy3pcZOXXvTEl5uZDSPsLt
 3NiOUS7itlslWm3V3EY4nyzS2eG7nJQzOX7JtAqVsbxJ//2lywsY3CHAQPPulOvSnKJm
 v1x0mZKlRfwKQurZw2EuMeZKxLwSVJp30dLekyt0oXs0BUC0Bm1R42hnOpX/ZBjugeWh
 +NipX/DQ9MVoAUd2yXRGBXm51poAmxh9CvBDC/wyL6YkG1EqsC/hAFnOJL2UbW0gF73U
 RSGw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=g00F29e2
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

From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>

Check that priv->clk has been populated before trying to use it in the
MediaTek serial driver.

The clock is optional and may not be populated in all cases (in which
case it is expected that there was a fixed clock rate provided.)

Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 64b3287f8eb..be09100fe7c 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -215,9 +215,13 @@ static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
 	ulong clk_rate;
 
-	clk_rate = clk_get_rate(&priv->clk);
-	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
+	if (priv->clk.dev) {
+		clk_rate = clk_get_rate(&priv->clk);
+		if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
+			return -EINVAL;
+	} else {
 		clk_rate = priv->fixed_clk_rate;
+	}
 
 	_mtk_serial_setbrg(priv, baudrate, clk_rate);
 
@@ -255,7 +259,8 @@ static int mtk_serial_probe(struct udevice *dev)
 	writel(UART_MCRVAL, &priv->regs->mcr);
 	writel(UART_FCRVAL, &priv->regs->fcr);
 
-	clk_enable(&priv->clk);
+	if (priv->clk.dev)
+		clk_enable(&priv->clk);
 	if (priv->clk_bus.dev)
 		clk_enable(&priv->clk_bus);
 

-- 
2.43.0

