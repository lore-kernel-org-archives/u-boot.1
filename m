Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8046C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFD7981249;
	Fri,  7 Aug 2026 19:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TV4TQS6IM--5; Fri,  7 Aug 2026 19:00:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9FE2812BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786129227;
	bh=fpLDrpBLFrMOjK6pyDtZqhY37pQaWPKwMHUhWLTlJJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3ayDFIr1JLIFvXhFcqfNEQa9OAPAZiRlQpm9BtXGK64CkG9J3chN8og2gUqDz632
	 kPKeTH0frEMWgmCyQHvkyI2sHLM1ctrVHYg34bX/MceSYlMxxgodVPuOP4bHnFjoeG
	 3DzV0r0Hwx02zwFvpdpOxdmeYzxzHA/mjhiAhgtkZocrmKwS1OHIibfcGqnb5zD3w0
	 AhhKM0Cs7BZ1x0Kdmf6LCYzzce/tICQiWTcFqLuAmoI9rS0ohwhRFcKnAlg7BfuEyw
	 XxYTxWGJjv8RFHuHDjbE3wJ3kRvkMHZonWVA8Aq1zQRYI0jSuP2+CDhmiPKEAtvwgh
	 LFfA07JT7OcKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9FE2812BF;
	Fri,  7 Aug 2026 19:00:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7387E2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6528080E6A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9o0HJx8ASVRN for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:00:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 56A96812BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56A96812BE
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56A96812BE
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:24 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-448b89f700fso3534953fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786129223; x=1786734023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fpLDrpBLFrMOjK6pyDtZqhY37pQaWPKwMHUhWLTlJJo=;
 b=AT6e01CHnsIfqKxhyhJ6Z2xJPCs/Hpdt29hgMdyTxuQ87Mgw3+vSuFpBqeg+NvFxjZ
 V+w/jcSxL4KBfRLHxRnCZ3zYp7acP3QKusEvShrE9F2tUk1fR25ZxvFNxXRwqR6l4tQO
 hBuDO6g0QhS13sRBzWXFBfa6/T+zlACJWIKp+kb0bduFsmLoNnEiUq7ZyIf6QeiS3i5E
 KLcF2IfO9AVYoDaaiLMqLEbccf2mR7PYvHm8Q94QjSBbWpnMCLz/Ad7DqRVXHRIrqO1L
 aTN7dEoLSBRAmTXckw0PddvQyAZA4e7r+N7+TtuVhUmzlYfQIDxkjB6JKbBjNU5SFjlO
 +j6g==
X-Gm-Message-State: AOJu0YxxVfGTR3fMhknMDyStmH20ZN8pDXnCDzHWQJv7ghDHpHDxghfX
 frquFWbqODGanR8SxX8g+XYzFJI6do4SW4lv9dbwq+3YP1vTnC5zWzpFChd/hm4NlRA=
X-Gm-Gg: AR+sD1283xz9C62umJcCBusBmbPvGLr1hwHx8m4rZad0lOr+hfoDSvKXTN2dzm/ApLd
 ttMnHkdORq0Zmjpe07FZCePc6OTqtNp0k8WtqToWPZ5ZJ/pin7IIs+5Rl/eqhVemMeTx/tOljbf
 AuBHAGMhLi+tVBbFmPEKVNoHcG4hbMgOlNPlx9a0r46UWU5LwEN0fZFpOJFvrYQKDuzO6JIEARr
 k1dyiVwwss3zluk1ptnJyD/xaFJqSy9G19c6qEon5TKyo4LO+ncq+laUT9yPgs2m3HjREPZCtM/
 RN6Eftve3mIdhG2NIV7BPFOvpLldlbokRIwdp/WxmaXOaktj8nX40oQ+c8Pz22MjE9I2p4UCuOo
 MauXIsXmYnBJ3IU9iM2Z5+4R5gWsg1DqGtgnuxoiXfczN0dYk0jR7HWIrYS/UwwJoy7e1v5Dn4e
 Kkc4GgFlU9JqPsUNaymxHAP8ZCVV5VMveZtjvWlcGWvgEE6fQKSqXF4DEiC7Ir/T85Fxz/6tkfF
 Kg=
X-Received: by 2002:a4a:ee87:0:b0:6aa:d8d9:a4bb with SMTP id
 006d021491bc7-6ae970f14f6mr13478175eaf.36.1786129223144; 
 Fri, 07 Aug 2026 12:00:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be47604sm2679283eaf.10.2026.08.07.12.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:00:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 13:59:41 -0500
Subject: [PATCH v3 3/4] serial: mtk: return error value from clk_get_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-serial-mtk-clock-fixes-v3-3-8cc94d313b57@baylibre.com>
References: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
In-Reply-To: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TxxnP51aCKfjLsoRiIWW6AR88gq6+nG1frASPE8UsK0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdisz6uYRkk5uqRskJxafbvKXhcMqT6rZaIb/s
 T+syzTv6WqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYrMxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmzYH/0itoC1AgbwVpsufFR+jBiSl4A8EEg148lbSWNY
 0zOQAww5awKmOrnYATK3+0/LPW+zY8rhHbv0bCxV8zI5GW5GLudYXsqFNXANZ5oRk0eTkmC3XX1
 4XXhBdwhUYwbAt4tumEmsQ8kyWTNWMEBJrLLOOPOCMHT0WwcjkgmkJcCzFaQJC36om+pXnm0tK/
 suj8eKuBcf8N3wlAu9GVLHLV4A8OH3Z0sIHVKqYPKExoONH7HXPvtP+rSxtJGOl0mYUFAg2Btnh
 n3Ve/+Nvz33RToJs8AbTk/hQmK4lPlUQwZkpvkifeZxbZ/lrMbfyODY1ER4ZRo8X9NUFMgDcd9S
 skvk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786129223; x=1786734023;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpLDrpBLFrMOjK6pyDtZqhY37pQaWPKwMHUhWLTlJJo=;
 b=Mea5cPDdhl0WOFzQPa0tWL15wfLDDjcKKEl/3yOpvTDLgHtKQmSHHW4Dxkf0v20kCW
 vbVxIrc/3HjsSL4blYVA+HszzEZAM7XYKBUJ2FlCqrJIEqK32EMNIVM8ZrpEgAAm5aNM
 0Od8PWDIc9wyMTZ3V/1VDUxyIHhTkMy4NME81BepPGn3P6outCm+pZQURTTaKC3UHekq
 6bwkl/NZsDClLL0tFG/Sof1fNQy24Yhu2TfBnWgnFc0C1i06ZH7edsIIp1VV/EK1+Arf
 E3sSU/iQfnQ2M+vLDu5UpgnGnXVPzdlRbtgeiBw/c1PQysEwTksVYArqJzvR+GvF6Fdc
 /iOw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Mea5cPDd
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

Pass the return value from clk_get_rate() instead of changing it to
-EINVAL. These return values are either ignored or logged, so it should
make debugging easier in the cases where it is logged.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 0f1d3b63f23..3ddac510c21 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -218,7 +218,7 @@ static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 	if (clk_is_valid(&priv->clk)) {
 		clk_rate = clk_get_rate(&priv->clk);
 		if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
-			return -EINVAL;
+			return (int)clk_rate ?: -EINVAL;
 	} else {
 		clk_rate = priv->fixed_clk_rate;
 	}
@@ -290,7 +290,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 		clk_rate = clk_get_rate(&priv->clk);
 		if (IS_ERR_VALUE(clk_rate)) {
 			dev_err(dev, "invalid baud clock\n");
-			return -EINVAL;
+			return (int)clk_rate;
 		}
 	}
 

-- 
2.43.0

