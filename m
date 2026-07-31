Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A3DC5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBE32411AA;
	Fri, 31 Jul 2026 19:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGVjClYZSvki; Fri, 31 Jul 2026 19:39:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D6474117E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526763;
	bh=wcZRAa5yHkrkEOkqad650vh9u0oB/2TKoJbV7Rnr9t8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQd03uZlZzEBluzTHKbHiEwE3QnIKQQY5Le3tlxudk6dc+6Z23tIig78cFXHcrNd5
	 H19r0yTJjgxrWkHBaicUC5EaNj1GI8NwQ99QbFMbvP79US6aT9Q+wXMP9PMJ8Olm9S
	 hSaYBJtJNoqTvj0w8U9qeWNlPoDmbTc3x6lyMn4cUplJvngwShZyb96xRX8smMlSHO
	 mPzGBJZ2iu0318E4bFrQrTWL+z7SVMG2pUlHBZ8XSYRoBIjZtRdZ3QMfjpKt/mXV0w
	 3+sdOaLg/OprHQH2ElX4WtjTB2L4G2BqPCJJaIvc5rj1r/r6dqMevpNtWUmMgFeSQe
	 3q8k9+x5rW1bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D6474117E;
	Fri, 31 Jul 2026 19:39:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56C6736E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 490F7400C5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1XpbHEPw3Cs for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:39:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 926A94007F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 926A94007F
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 926A94007F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:19 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7ee4399c3abso1001799a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526758; x=1786131558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wcZRAa5yHkrkEOkqad650vh9u0oB/2TKoJbV7Rnr9t8=;
 b=p1axIRAm0vVxy5/EtaWEALPZg2apLqjVTjKXUqsYbIJsYgBhiD4ROhRdIrQkUSkt9P
 lom+GJrxMSdErYFnjFEK2Ccvexve+MrcSOXIHY46s21xRFijOzN7kV0JrNG4uJludFye
 jZr9w040C0dAuC3u6J5Sax3WxudLkQQEBFDrwqzAKE5rZvdrpq3tZilKfk3TKT1S+41j
 Q/QEv9jPFjTB2by5HAYSTPCQokF5fyQNfflO4oCdM1Vwx2vx5NshzLGBA9C4WmKi65aN
 nX5XIoxdEAocbW0OT4Xkt3xj3ECcQ9L6vbTTaTnqtOpRR9iuXtu8pFE1H37N8A5FRcJ9
 ppqQ==
X-Gm-Message-State: AOJu0YyJC/fQRhuQVT1pqacuy5SJ8BUZCYyUCBkcpIruYWSPxelFov/C
 LPCRcNtYIXypTI65jl1BxDbOE8iICSQFcq5yOoiW8RiO9d986osFUmVjFTRCIFioriUguzT/loH
 403Ph
X-Gm-Gg: AR+sD12EWkKUNWkK7XMi41150zJR6fhYGAtxpmctr2akViRz23GOasO1E6gLS07ee0q
 6mbV7jLJs822nrw92NzyiQqv0rDesVpnr0hf2fIZQE89ZYZ3m7rXbOLIX8dQaZfr2IHhe4NXth1
 lP1rPvyDBuqAObnj0WQzzvpgAB0KyxvvqZeCyVwSoxwGDyWqMWnyt7cM3OdAg7b+1tqMcqIE9rk
 6RAJFa4Qh5bDab/PQXU+NB73BO3AOQDjwmDqBSX3cAyVr2Zu1AEeg5xtzPkE1+OrWbxGKMEJ1pw
 ZZ648NpKXyXF+lasTbvbbeA+4X8wku8UGDaTqjZhq+9iejpciZ5NPZTl837K2lQpR4k+CFgiSWw
 KDs7xjlMDfZasZgZwQD9XRsIeBsn+eHPu7COeH0YFuOS2u3+6KGqrhpOcM4YX5k9H35b0TpZmSq
 bHExDjqnQMPa4UCm3dZP2ZRm0cXjTCQRop14yjIx1MzvtmY9h9tIEWBAo41mkcBU4E3Q==
X-Received: by 2002:a05:6830:6993:b0:7e6:f2ef:e231 with SMTP id
 46e09a7af769-7f196b5d10cmr2730159a34.2.1785526758451; 
 Fri, 31 Jul 2026 12:39:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3e91bsm1359205a34.4.2026.07.31.12.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:39:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 14:38:40 -0500
Subject: [PATCH v2 3/3] serial: mtk: return error value from clk_get_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-serial-mtk-clock-fixes-v2-3-022110a9ec3e@baylibre.com>
References: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
In-Reply-To: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QXek817xms1knzISDdM5xaFALhikwrSUQHrllnmCFjg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbPnaFPpTkz1ZqR1Beup2ZsomX9EIUEUs8H1yg
 hrNqrbF5deJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamz52hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AapsH/jpfpyFNMzZgu5rX/l1BqmPhcgx4mUtn1Tp/3nb
 ANNy8pHmNakpJEyTVfZXIhLXm7SpimFOTwNmBKiAg11FRSuJk+chpnSRr+hLyT2VxHZo4vM9eWJ
 MabiuIzfPs5NPlQBLK6Ix3C04nPIht3jyNLS4/pMs36+thRZx553rtl0GSC7HBU9gryJViKNrnR
 WHldvIA2/9CJd8UdGYEvRPNQ0LfEP0YDYWayqwSYCCZOE+JlZnfr4zWkhCko+5sdApaIFHfBV4E
 sjs3mw62TND9K09crgpofuAoTPm6WrieDsMYMfLs0GAC6x2Qh9Qe5f3Sz/hb0PKKkXYStzzwf8Y
 KcL0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785526758; x=1786131558;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wcZRAa5yHkrkEOkqad650vh9u0oB/2TKoJbV7Rnr9t8=;
 b=Xyoir9BS1D1BWTpBdMY30lu9IYdmJQPIFoZjqsWUbGw0IOWpzaCy8L0uj66YLm4r5V
 wzYZCGnv7ib88u7g9KfIv9v8labnajrYEdgwWob3ZIoA+BSwXW+TlkeOT7xdYwHNwlxz
 of+2krrL+s/8M6ytSCc1mS0C73EZLiALrOPYhUbuwXhrMJiG9wKNtMGEKevJo7+QKer2
 rra3v5m1rhUBM/8nMK93bXXHQLenw0wQR8Oik1u3TJfW5S3WYvf+vka2LHh59bdQ7L2L
 E65+hUdGG/cjA6t1EXDDWqUVbKvOa613BFJWhPt5D4t00wr84Zp5TDiuEN1/4rFizaBU
 s0yw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Xyoir9BS
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index fff2f639cf6..b20e84fe63e 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -218,7 +218,7 @@ static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 	if (priv->clk.dev) {
 		clk_rate = clk_get_rate(&priv->clk);
 		if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
-			return -EINVAL;
+			return (int)clk_rate ?: -EINVAL;
 	} else {
 		clk_rate = priv->fixed_clk_rate;
 	}
@@ -291,7 +291,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 		clk_rate = clk_get_rate(&priv->clk);
 		if (IS_ERR_VALUE(clk_rate)) {
 			dev_err(dev, "invalid baud clock\n");
-			return -EINVAL;
+			return (int)clk_rate;
 		}
 	}
 

-- 
2.43.0

