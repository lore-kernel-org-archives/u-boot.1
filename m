Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1F3C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 11:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D698B87656;
	Thu,  2 Nov 2023 12:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VNe5oty6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8767D876AE; Thu,  2 Nov 2023 12:38:41 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C148757D
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 12:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso5106475e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698925117; x=1699529917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oh4ZnVQs6rqEtyH0BQE7bx6b2vAM5JOZBGdRPaRzgoA=;
 b=VNe5oty6hvA26lysNrK+eHxq3hIhiFgiKgxVxUg1WfqM5m/K1p9xFXn6VqpgRKKzbp
 xhcgukfnhcRVhNlE3dksBe3VrystNIRYds74oYM9W+xkdifBeoKKg5qYhxPukIlNUkTm
 sunlfiAGpiiaYySLlgWaAF5+436P3FO4yn/30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698925117; x=1699529917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oh4ZnVQs6rqEtyH0BQE7bx6b2vAM5JOZBGdRPaRzgoA=;
 b=JC/9DO67dwyvDpBPQEoRwVJn1GlnEi68P3t0xE1Ky/r9IpeiuqgC6iI5u6w0QnlnFs
 RPr0sX13Xg7jfp1OiiW/Ii4QorIi2FP3m5Fi2vSE6IGGCyO+Ji5eCU+yty+R6vwwi3K3
 5cRHR+vBUupoQOff2yOGEjMLKqAuOPh+bKnzB26qhtYkLBimziMsYE4gcTLL3FMCgv79
 QRjopY3SCJPJpVPXTExc/8D5dLTKtFi6vRTPjdoeR9m3sNmGk6UB1FODCPU1H1lldsVB
 SB4oBbbi/zScRYesK6wKbVhOAtQyVLrmrCQlGL2kuZmgsVhuUToV+iNDFVmuEIpA5GVJ
 JECQ==
X-Gm-Message-State: AOJu0YzPJSJhQnPEpyTpaWszoLPQcmNLj/pHg/LMmbfuo1/f3cObZPOL
 kWtTzcq26X8NYorOy2kmpgYvIjAmkx+KF1fXX+P/bw==
X-Google-Smtp-Source: AGHT+IGl5c3FDwnJRhjzccW6n5dUZjbttjRNEpkdhWaoJirmfoGn1SafNxftMHoIfw+I9k92kZD4Ug==
X-Received: by 2002:a05:600c:35d5:b0:403:aced:f7f4 with SMTP id
 r21-20020a05600c35d500b00403acedf7f4mr6137909wmq.12.1698925116637; 
 Thu, 02 Nov 2023 04:38:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i..
 (net-93-150-246-117.cust.dsl.teletu.it. [93.150.246.117])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a05600c4f4300b0040531f5c51asm2625181wmq.5.2023.11.02.04.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 04:38:35 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mtd: nand: check nand_mtd_to_devnum() argument
Date: Thu,  2 Nov 2023 12:38:22 +0100
Message-ID: <20231102113829.58852-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If the "mtd" parameter is NULL, the search will definitely yield a
negative result. In that case, it's better to exit immediately.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/mtd/nand/raw/nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index eacd99c4e275..55c00ac815dd 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -41,8 +41,11 @@ int nand_mtd_to_devnum(struct mtd_info *mtd)
 {
 	int i;
 
+	if (!mtd)
+		return -ENODEV;
+
 	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
-		if (mtd && get_nand_dev_by_index(i) == mtd)
+		if (get_nand_dev_by_index(i) == mtd)
 			return i;
 	}
 
-- 
2.42.0

