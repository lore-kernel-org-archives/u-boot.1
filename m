Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7766EC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D2987BDB;
	Fri, 15 Dec 2023 15:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p/gu3zEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B162A87B8B; Fri, 15 Dec 2023 15:09:47 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B90687BE5
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-336417c565eso553647f8f.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702649385; x=1703254185;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yCzC92qhmKJtrFOl3mq5lGW3hR8+io9+ksIxptLfT9I=;
 b=p/gu3zEZiIjWvM1PDjU2NkclHp8xXms0n3T100aTV7uhccvWdqZHg4C9YyDD+mX04F
 JYucOAqyx9UX2AZLN0ZCdURmun3L/pzo6sLJXZVZ/oKHH7qLBB9cB4XSyKqLDi8ni1Mt
 3HlhWL+7KW3ca2InfWhVCgM5Oq7PLUSaloWudfBSSkL5oQ7stY37ILI/N0893ux6qAEG
 Of1CCNyM6CJkA+MYENEDFyg3DiRrv3H5eBltqdpavwqzZYy6wM3/XSEQw4wl/5lJS/6j
 ZNuGkGVw38Zw4Iew4FDWhYZlntxI2Aq8eXOU9wMyzrRmESmklx6rgcuVZzQznozMvRWA
 VvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702649385; x=1703254185;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yCzC92qhmKJtrFOl3mq5lGW3hR8+io9+ksIxptLfT9I=;
 b=p4vM+N3kVPAPmzDfN9j7361iivj9OxcZ1w6T1hMy/MvrpmkRtX+gEvsFwI8aoawi98
 lSukJXSDv6+fm11XdoA7mb8Y8lUtRTLc/WqF1xthp9x05GmQVuhiOxTpknhhpFDYvXj3
 xIYKGmxJQ/bXZKy7qQwHcVKpEOskBC9TIvE0kvSaDt8RQNmDQVbAnt/iR6nt4w8eI/cW
 /5Wcse6V/rYqwbHrLv8NONuCmg/a6xephTdTA9kaQBtcHRxRLr/4dEvqMKuN8ACpItF2
 8jyf2j5CiowLyaUoEk1P60A8f+eebq36+Cx10LDZHJ2RF1LSb1Kdbu/PLKqFfr9xx8ev
 tcLQ==
X-Gm-Message-State: AOJu0Yza0mxsZBHNQ72Ztchn3PMnSxVDzIfPojhWr5Q9h36G5KbCqZGs
 1HdENg2Nf719d+K0eM27aQFRBny6NWiQYRxEU2Q=
X-Google-Smtp-Source: AGHT+IGdlqBLWC+wgDgUowi86+D9F8w5Gc8lHvRK92Q6oPsg+gGnsLCcLp3DB84nVUpH3m7xO0yg6w==
X-Received: by 2002:adf:f8cd:0:b0:336:4b7c:a72a with SMTP id
 f13-20020adff8cd000000b003364b7ca72amr952061wrq.14.1702649384657; 
 Fri, 15 Dec 2023 06:09:44 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31]) by smtp.gmail.com with ESMTPSA id
 s5-20020a5d4245000000b003364c3d846esm2933844wrr.85.2023.12.15.06.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 06:09:44 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2] clk: fix clk_get_rate() always return ulong
Date: Fri, 15 Dec 2023 15:09:43 +0100
Message-ID: <87o7erv9p4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

When we call clk_get_rate(), we expect to get clock rate value as
ulong.
In that case we should not use log_ret() macro since it use internally
an int.
Otherwise we may return an invalid/truncated clock rate value.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
Changes in v2:
- remove local var ret (fix warning)
- Link to v1: https://lore.kernel.org/all/871qcj5frz.fsf@baylibre.com
---
 drivers/clk/clk-uclass.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3b5e3f9c86..3cbcb2d033 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -478,7 +478,6 @@ void clk_free(struct clk *clk)
 ulong clk_get_rate(struct clk *clk)
 {
 	const struct clk_ops *ops;
-	ulong ret;
 
 	debug("%s(clk=%p)\n", __func__, clk);
 	if (!clk_valid(clk))
@@ -488,11 +487,7 @@ ulong clk_get_rate(struct clk *clk)
 	if (!ops->get_rate)
 		return -ENOSYS;
 
-	ret = ops->get_rate(clk);
-	if (ret)
-		return log_ret(ret);
-
-	return 0;
+	return ops->get_rate(clk);
 }
 
 struct clk *clk_get_parent(struct clk *clk)
-- 
2.43.0

