Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14381C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1CEE606C0;
	Fri, 31 Jul 2026 19:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGoGhDXK2wTN; Fri, 31 Jul 2026 19:39:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5524606A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526765;
	bh=e4Dc9Ao/2iFFmbszvlmdQi6pAwzboRGUXKJ6xSTV748=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oSRhJ3z2uvNRcfSEgEpg406xZocLFuF3liPOPBMlBwaK8HM82rvhTDo2hbx4339Vi
	 zLjozvLLga6HNReml4H4WJGLjS7Dzme7/daTlcIdwFenFdkrTc6CyOKu626OhtayBQ
	 tWwTT7i3k+O8fnjvKP0uWp1g+KgZozZnyphuzCF6OhnsARwWy2hOicQYmo/thBTX7U
	 p/p/Yhmbe3HOgoievWTOg2ncWEPE/h5x3fjg/zL9lmpMw3kM9iLup0znQ/db+xv7a6
	 O7AWrzGUDBfK6CHLwOqo3pEFNHsYiN8b9Nb6OpNJBiOXpNdSvDZ95G9iTvsAPT4wPg
	 0FMQJXABx0GqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5524606A6;
	Fri, 31 Jul 2026 19:39:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4707B37F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E1FB60698
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynPNP0oPuucE for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:39:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A24E760657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A24E760657
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A24E760657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:18 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb63dbd229so962325a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526757; x=1786131557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e4Dc9Ao/2iFFmbszvlmdQi6pAwzboRGUXKJ6xSTV748=;
 b=WmQ3UpMjyiedhmn7q+w2UA38I4zW0rWdstBd7yM2MN5NfdKbZiJpbWBv0aeTWpV0sz
 bLfH8BB2sigsUlSknPpj/Axg6UQboImwUv+v+k9xvWdmqPM5IYpnI4TrS4twzIEEscMr
 q4inHRZR06MqOHZDeAqJoNNLmRltQGiBESF5FaH0H0HcSEexIEU9k1W286yZLPg3Cgzx
 ROCQZJVdoGGeUwjw8Qkw5brVrXXnRm+6KDkvv689mJdnFWXvUALIM7KWE/oFfV0VpAIh
 gXsVUo25GSeHgJD+DMq7akDipfVAi8f2mBqQQXkhw4ofJJOw3OsGNmiOj9bUhhnqAbTf
 ZcSg==
X-Gm-Message-State: AOJu0Yzc2FOTFYGCnJbi1V4MVJ4XltmpbihrGhABjWMX8q9G3o0WzyCc
 xGSwJupQsxK478lwCVXpbS3VhgGhjQ3HFu+WVA6isi0k1Qn5K6P8mpVayRbjCIRD/aqyDOhUe94
 sjQnk
X-Gm-Gg: AR+sD11Cy6Xex5Jlf+L4xEyIFp09bBuMgI5Enq0xDA1h5MB4F+rB4Ej2QGSSbjMbFaI
 NF2nVEEqImvxMAhKOs2Cl4RLQt5LJ6RkC9EOypYCKc8k/An5eNPK/dTgimMsRT6daqgxwGX2tjO
 SlZB0BxQ8nvCwDBoQELIuGdcYRPZhstefjCZ5ZvCKRGT6ga3ijwetahMzCZ1TV1T42RHMdDMICl
 8mNryEMu1fT+wnBnI/mh0SvOegAAE4qTYo49fX0dg0Q2qKrTA7I4zKaynAsW81je2k90m861KKW
 F6HjVnOb53qD5f/l/YfUJLaElLU1p0W4fr0n0BrHpOy9DaYmBqA96hMKWqpUbVhQgUoynpYNQ+j
 0SUv6IFeJ5ys/21b/hhuzJjM5YDQZxFM5ID5ml/9G9nL7h5iyGDQwkKudUaw1ifkiDKP6NF59cT
 yRhCRdRZC0Bq5L6zZSndHfprAWXuFWAJGQ3CQRK9DqtzY6bU3vfuQkH/Gf9W/2ubew9w==
X-Received: by 2002:a05:6830:6189:b0:7dc:e78b:158 with SMTP id
 46e09a7af769-7f197141383mr902988a34.4.1785526757531; 
 Fri, 31 Jul 2026 12:39:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3e91bsm1359205a34.4.2026.07.31.12.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:39:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 14:38:39 -0500
Subject: [PATCH v2 2/3] serial: mtk: guard clk ops on clk.dev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-serial-mtk-clock-fixes-v2-2-022110a9ec3e@baylibre.com>
References: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
In-Reply-To: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
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
 bh=x7gPvuUbccx0hJR+5rNOz3F8G3mgDj/dBZpWvpzyG6k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbPnUVxOiifMLkeAhQ0kC31OqcTmvSlMCH3gXG
 LlnT7/D3VCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamz51BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0loH/igoIwGZqcG50WlkLvWYUJcknP72C3zwOlY4GCz
 pcpxDwhmRi+/F+T6kRBDJKPfdhGbdHjYUtOpjuGVzQPluFwp/gS7znfFTB29FNmPRNJ3p+pWpdd
 NbAaBTqsAqyM3vi359uF6KR/puGH/E0i1OVPRCR2WJwKBZpPGZzvjljARPQWGSLRBvWdefhMy9u
 6Y/5cVGCcOtuXG0exqJKQbJigTUKFudsc1A44pOC2+gptOecy9Ne5ixBDxkv7/xsN27noxTaJrx
 Y+e2M7/eh3LZEnWlj70zV/VLsr/Lco+1HB/WvOvaFkdetO+BBGBSN8fzf5j4ZMaOJfXb4Az7OG2
 HXUg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785526757; x=1786131557;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e4Dc9Ao/2iFFmbszvlmdQi6pAwzboRGUXKJ6xSTV748=;
 b=FkwC5gTZjG2Zg/jbTZsXlzVGLJ4MGKY6G1pIE0puq4YuiKR/gNzQzFHmojyLuF3eJG
 P81iT2FTw5qIxfwBEIRdW3Iejrb/yVa3OfSukEEebXUsoMokDVj/B8FibJ/wKa1cnDIW
 +fA0kHa+cOdpwmmmGN4zhN5BMSotj54tovlelQVqeMGq+Y36xhkrcUTpO/d76r6ytfFg
 VAVkpCthUf2G0zJ8psoMSbrN83EBPdV6YDNNz40ys6R21rDRCOKigU9tVqQrWWzQWTQ1
 J7FmtfS9hqJSGvWwLAVLAvwCy6v9V2PHVFwQai1Ak6qUT/vcwWoq0V9sn88VRiFhy+Io
 wqqA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FkwC5gTZ
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
index 28e87f485a2..fff2f639cf6 100644
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

