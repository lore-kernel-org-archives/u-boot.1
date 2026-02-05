Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C088ECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BA28341A;
	Thu,  5 Feb 2026 23:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B5BBObTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A58283B72; Thu,  5 Feb 2026 22:13:40 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23C083AA7
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfd6f321b5so893134a34.2
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326016; x=1770930816;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=B5BBObTReE0Za1JMdv4JkoVZzYTHO7Kv8Wbu3n2GEpL5cySP0xb1H0ovzuCvOvG3Yr
 LQ5NFKCsaMoaJxAw8Gc3CHhTsscnsNAa69YWDUsPGR+r+MMJAOmR1j6d4KjkrnpJMk5g
 GDItlrKkhnChgWwYLSGjn7ij9enqd881O8jSYvDPcsLZd1w5XdQY/fOjnRXseuUfUgYO
 GwfHjxviRk426P7UMa6mnrbhdHyenAXhdl77fsMnCT8Yhwvz52ehEvgRhBRHlYSB4FsJ
 nCNQoMDYTkapphBvOvH8PXsnaxh4BJ0ZuNKbC2id+N5NV9S96cgdIwbHjSm7yWqMY1tf
 6PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326016; x=1770930816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=BnA6vAJ6Lc4yGbIfWKkEdm1f1PYyKEupqtGvS5lOuiWIVIKxLaqvueVr/caX6N/oBc
 8andxgECz4+sXoFP7Mkc6zoq2CNX5leLjjoU7//iM/rYMQXDNfIWVxo+GxIh5IRWbxcT
 RTo13xQajGqT3xVYfA3vPYAkek98rvzcWqH9ul2ev+b/tHa2/egKUCHaXPpfORfEGdo3
 NH0LHSQCnRE32SIXgVZ5+Z6YsagNE3g12uJ+j6cEClJqpYhu34WL2M73KcOu82aEllNP
 G7wXKLqOofwesbWUWLHMPsSzkM2esGh7cejEvd8ra3Zc3MmaBZuPtBP+1pVXzTxXUse4
 MHXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdmOvx+ogMprdHQERHYFf6oeaHGyLwxgqc9xr6+5u/P5C4EZ0caST2oGLbnphJ90hbGxq/8/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YztywGvBXRbPz3OshjgcsNmgaVdWVSYmoSvxm24apROBypwMRYO
 nHsqDNwMZKdHfB4Bb5dB4Mqx268I9qEXLATpDcyspHL9S8hgfkp0+ho2dEEjscyp/kc=
X-Gm-Gg: AZuq6aLfvSrHHjSzkWvj/57JlxWiXd9tzlZCJ7D4dlI6SwG4ASxvASNMPc3dMZ0DFzv
 yRMGLLGI/KaJTuQenz0f6HKo3r3nDB6TO1MGtRGdrex4lVVMwOhYzgh4FAgSKD7hj4TfU3JzLPp
 TYr9MtI43TQaAQwr2HJ6vDL1jpKJLV51aRdBlZk+m1hbLz4GQ/TmDKbxw6DxwtDu5eTXOfdCA/a
 2iD2HNjJ6TPWdlHoMKuUpnVjU1hF0Oqt5rhijFzX9TeNfzM+itIj3JWw01PC+uO/l1wWi/+Hswg
 0AXQkmQINjJjekvVWpLWi2jvNFTmS3ujVd3V/CTpRWMMF/Zg8cB+m3vdHqhQ3/NBMy9lJ04NUj8
 UyDLJ+JbQ9O7ExcabXpuiqtb13/XHx0TBS1t9SPsr2gZA7DRIxF3FNtlVOt1Nyp6zb+gJ+TmDcy
 Xaa5NXME+Fl83Cq2h9BXKMDweT6w==
X-Received: by 2002:a05:6830:82e1:b0:7c7:6479:38ce with SMTP id
 46e09a7af769-7d464485aa9mr211304a34.18.1770326016691; 
 Thu, 05 Feb 2026 13:13:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 15:12:36 -0600
Subject: [PATCH 1/7] clk: mediatek: use correct struct type for infrasys clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mt8189-clocks-v1-1-bbac40932c2a@baylibre.com>
References: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
In-Reply-To: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3SvhRcBSx6wfg31/2N2Df6aq5Y7l5XCklhamn77ImMQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphQfQG/0Zev3uFa3kt/49mO8S0Y76fSJx6HreJ
 Qyy7MekaNuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUH0BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHO4H/RAcv+p0wcI65mODGpNLlqLqVRNkmVutYSLWEUd
 ysNAPDq9bDSMi00VxbGrvlspZJpTapF407EkecZmb6KdSH1GrB/floIY72tkGh6grIzO/By75qV
 NX/9y9S//wXqg+xUGzJwzLKh++tzefLog8OVnWrDBwvYTidyXtdlK1bVyjhNmJ5y0noFfMjXjJC
 fRvLXO9X2ZmwzLW4rubGJ+0XfFkqiCpBo7b7i6dUHS5FUEvzs5iTbWLBD2vAkzTV9oiUQc7adDD
 UQeagscT4oQmkI82Ad9z3nEJ74cshas8DPFNem3bBEPsPhKuKBkjIrQJfOxu0t9SYEMWxRQ1qG4
 KOUs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:06:53 +0100
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

Fix the private data type struct type in a couple of infrasys clock
functions.

struct mtk_cg_priv is a superset of struct mtk_clk_priv and has the same
layout at the beginning so there was no compile errors or runtime bugs.
This could only be found by inspecting the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b4de38719e1..b3f05bf5a21 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -933,7 +933,7 @@ static const int mtk_infrasys_of_xlate(struct clk *clk,
 
 static int mtk_clk_infrasys_enable(struct clk *clk)
 {
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
@@ -946,7 +946,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
 
 static int mtk_clk_infrasys_disable(struct clk *clk)
 {
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */

-- 
2.43.0

