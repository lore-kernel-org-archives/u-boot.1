Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308C9C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBA3740623;
	Mon, 27 Jul 2026 06:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iddxwl7mzENT; Mon, 27 Jul 2026 06:59:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E07240607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135578;
	bh=xGg+fqLXaT8hj/QnY9jDvL8ij3iAAIrOTEwB2tzqAJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcNr3HxyU/oieSL8LFxSw+MVuniSOAi9LfduKd/kC61y8DaEFTAyBB7Kh7WgsQm6B
	 utGgy4ShnNpdEFnoSRAJ45mvLkgNFQ6SUjqsAdTIfjM887aC28D7gQJB/XAw8EOcYJ
	 +omgG5dLKrHYe5UNIX/Qgz5bR7Z2w7qcwyGXfwKSOcVZZ61OcYOhJ9g+zo4GAWsiuY
	 cOiHxiTwJ8XQ2KvYXGzTah5caXOuqH9WJMQ5g+DvbVXI4EedUyDOpRoVgxAeNG9VpH
	 4Nk+glBcdrlrKB/19IlGPo5OnrVJGwcbeTZfZPuvO+5KMrMWaRWNKWB1pyAhAeQ7Xl
	 4xnbTj6WmsDPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E07240607;
	Mon, 27 Jul 2026 06:59:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E45B469
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E274B40607
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjXxTixe1kmP for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:59:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DE9F1405E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE9F1405E9
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE9F1405E9
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:35 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso2380303a91.2
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135575; x=1785740375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xGg+fqLXaT8hj/QnY9jDvL8ij3iAAIrOTEwB2tzqAJo=;
 b=Efqs2sBCoJhuFLXls9U3+zSkuxIEegNLeFW1JDB3K6HwVpWGwhM9Y9sFGAuK2V6Wgi
 zVWQDE6rhFk5KwpQmIUdnuOvGlgTMM11g4PYHvOPnHa0pjsZHrg6csMtCAWqnPW1ddgY
 VjCGDzqM6bZTO8Xz00zAnBuNQF20seer1oUoQL9xQdBJl/5UKviHwF5XyDl+iaEUpGw+
 UzTKzO22Z2jOA4WoVy4Mql7/4m5o8boFpT8uxHaRjtmC0q8dh+CRIEXqbQQMs7DSjEYs
 MExEooT+x/Euqz78Ee3j1I0W1F4BmAQF095ohka279FLl8Ac5n7Uo3BozzMt/4rh5ulV
 TWPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzaB84CV9Le0y1auCSkALCp8jh5Ojdy+ETkg3za5SgcafYU1M8TlygTvoH5ChodT/9M6luAWc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwNe+6JY92OPWiCxtpjW+53Ur58M1LVsZGlxIvMQy6FaCDz1fyq
 fwIsR1RTtBVKQPEcgsc5RjpxWfU3HwahYYop03FM1F/94t0+EKIxXFR5xu//I36XKmw=
X-Gm-Gg: AR+sD108oqxiqMxVgP6vvUaM01kodrYXxiASkyIMKrjEfhTvNJtLVHGCBeAvOjHvSJG
 dQXFaJaFwoLhfMKxNWYJeO2uUfWufXAsW2w/bQnCVyHh+23ewEowgg5/BhYeJ01L0epkb2Tn70n
 7gdV4OoD4A2911rG8WPp0WZ6UfawPR1ygivVyBzVtIFuHZq/webZwBusQmYl17XkdczMOV3Ajw4
 V5o8TB0Znwk8lsGlAbI3YLJ05d9idTOXG9wyOkDDHdnn2L4+4LisMFWxTlNyQcRxsMXDYSnLd+M
 opm286DTVeltGuZmsoK8/oJ0bsGqWq2dfp8maa0GSKiTpOMorHCFqaSw0oqHdaoC9KHIZ+s91V4
 dQdFALIrgJRLc4WUAyXQaBAjg+8K4Ofb6QTVGnAZlfrkT03GOJ+dn36K3b4v8r+8qlXjC35dlC6
 5OIJTNOh2FJ5wFQcQMfrsex3dg6hYjkQ/wBuWPSWcKxIR567ch/gkSM6s8Ct457OfhwL1TFVbBI
 OKqC4uGl0ZNlDV/l6pVTmCrUZB1xGQOiMkBjt2zc8E=
X-Received: by 2002:a17:90b:4d:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-38f293cf43emr7258933a91.8.1785135575173; 
 Sun, 26 Jul 2026 23:59:35 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:59:34 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:05 +0800
Subject: [PATCH v6 03/11] pinctrl: k1: fix pull-up/pull-down configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-3-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135575; x=1785740375;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGg+fqLXaT8hj/QnY9jDvL8ij3iAAIrOTEwB2tzqAJo=;
 b=mpTBOw0tX7Rj/k40YZbpBdEBqJQkNRhL+89tVexnqeOpYsFJ62Dt/OEYnaqWLgY3rw
 31rnlIauQLgKqzJM+I0UIicKmVwcIOxnX4Vtk0S/sCjRvqQYAD2UqAkcK73s+o1qjiQU
 EHIJTvQufMa5eH0QZBVEqpQNp4koS4IG++fEpcTz11AOPBob52tufiKKT8vXLAi8Ny/I
 4bk9xeSLT7y2ooxVrjFC4B0HX8gjAWQYlw5hziobicvr8Vntea08XK/D33Pm0puj7MLh
 3Bdz1jsyeYQYjP591bSAOelhx61kf6ugHqrHfGbpvJkY740E7iGsWhrdtq2D0lXKPAzA
 AEdA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=mpTBOw0t
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

Fix pull-up/pull-down configuration to honor the argument parameter:
when argument is non-zero, enable the requested pull direction;
when argument is zero, clear all pull bits to disable.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v6:
- Fix pull-up/pull-down configuration.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 6ed511879da..454bc307ba3 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -425,11 +425,17 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
+		if (argument)
+			clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
+		else
+			clrbits_le32(addr, PAD_PULLDOWN | PAD_PULL_EN);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
+		if (argument)
+			clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
+		else
+			clrbits_le32(addr, PAD_PULLUP | PAD_PULL_EN);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		io_type = IO_TYPE_1V8;

-- 
2.51.0

