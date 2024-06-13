Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C2C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1356288949;
	Thu, 13 Jun 2024 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LkI58/5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1EE883D3; Thu, 13 Jun 2024 13:10:40 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF898888E8
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6f1dc06298so109815066b.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277038; x=1718881838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0KdW5MS679ufZElXZvy3BWTS2swPQb6aR7NpsA9F4BY=;
 b=LkI58/5Tkv+IOLQNs+UPAvJ09zG8lRHnSjq87P9Imrk0FighdOE6N6oI8OGBPzSbxC
 3KPEFUa55AxsRFeHFHhYqeAYPQcSwTpZ07rNQOA77wAYoiJhzPcDsuHpdVKKFbd1PnrK
 x75J8y2FCcXYnBnZMIZqDuA206oEk+ezruA54DoQ6OvOuX30KAlYv71DkqaNw8tQmqYS
 CvHS/b5o404zGZIgG57Leu+5iloXMgmsi4d7wzuYl7sOI+qe0uWWxt7HgTijapLPwJEf
 ZRpTXPn28g1e8xLGas0/tUvxCNy+kmzK6GMtALK9qmwENLenE1pzRwGNndTG2n1M+Tzr
 emhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277038; x=1718881838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KdW5MS679ufZElXZvy3BWTS2swPQb6aR7NpsA9F4BY=;
 b=VEN2e9c+W+XBConEbJ7guivsUMFDpqf7DoFfVdhIRI6C3MBxZzkTeBurNn7C/p2Ia1
 9K21aN/WOGLrskhElyJCXrIk+QlaysBMniyTZuqgx5uYIyUNzlRKcME+MRyRpldm6fZc
 Um43SSPlVzfVttUn2py0JD6M9gKk6Mm25QGCG07JBA/ohqFIL338JmjUL1smDRzIChmF
 nYWIp4WqDVm5WaPRnlaOWeHivdkEWLKdX565r70iGdCPZ4qiz1wQ7A8bvzfLPL1d1HUX
 b1fJo5kWV+UO+MfWCPiEabiRIsQPaGuee/eLWPFRYzV4aw57t+Tk/hApt5v57uNCzitV
 T9VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQxltNkor1p9EyjRiQZUfFo+Juy7qkPQc6dyARzSp7/lsVsX/4+Bb5rfX+OIOcKEvOgfN1LOFnRJOmlIHnqloMfxrdVg==
X-Gm-Message-State: AOJu0YyVWDvGeBF1XRF1SkrkcSALyf6bNbska6t5bnChGsSe0g+OIx6+
 h5lYRIawICGPSFKgFk8lbssNyeMU+4Xw9eHOvqoiIGlhzR4dVQ39
X-Google-Smtp-Source: AGHT+IHnHJb0+eIzQuS0Es+uYNAg3zRLGkPLDm0wYxdz44H1MWkn9iMksjm2ZJEEsO+cnb8JF/MvXg==
X-Received: by 2002:a17:906:ad84:b0:a6f:1445:9de5 with SMTP id
 a640c23a62f3a-a6f47d5cef8mr256443366b.68.1718277037956; 
 Thu, 13 Jun 2024 04:10:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 14/14] clk: mediatek: mt7986: support alternative
 compatible for fixed-plls
Date: Thu, 13 Jun 2024 13:09:32 +0200
Message-ID: <20240613110949.11076-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

Support alternative compatible for fixed-plls clocks used upstream with
the compatible mediatek,mt7986-apmixedsys.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index b3fa63fc0ab..efc3d4120b7 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -533,6 +533,7 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7986-fixed-plls" },
+	{ .compatible = "mediatek,mt7986-apmixedsys" },
 	{}
 };
 
-- 
2.43.0

