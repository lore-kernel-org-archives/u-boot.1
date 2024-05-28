Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5683DC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 19:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5D788571;
	Tue, 28 May 2024 21:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UXsTrU//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F7488555; Tue, 28 May 2024 21:15:20 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A5288555
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 21:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2bf196037a7so232621a91.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716923717; x=1717528517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UC7yxqpyjmhSjoo97An3s2I7CS2+n9Ltr90L1w2oRSo=;
 b=UXsTrU//uWigRdXtLu6eoOPvi3uHq4ufQMIQQ5qI6mP7kd2QUWRHrfNxYz35iPT2DC
 wQdOldY7Od9A6VNp0NVj65X5g60KUFRTET/RRPAZwuSaZIeVRCbIXrIFgIgfsADFuOHf
 796U84eHu01m/10snAwQoI0qfgHeXdcj8bhCPL/ffrs9PSrH6lmYda3m6wflWCd4oS5U
 IuzzcIyXeecTW2QVGsgazGqI0EKdoeoDPZGQXjYPA7+rJ+p0m3+OeXJ9qP+0nXEIVbD3
 PTvv6c82gjazRQv8EylucD6rGrzfCFGkQNqc+w/8bFUoH3Iba5ZOceBW3wHjufvLAywv
 U4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716923717; x=1717528517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UC7yxqpyjmhSjoo97An3s2I7CS2+n9Ltr90L1w2oRSo=;
 b=BNZoUKCMa//WmjR+ClGHgYX090aoXVyTtdL5F+eMzHQvRNCWnPK3CCvIcd30+D0lCR
 uawZc/weMIsuwGDnyoE2g2FkFxgtzoc0snVGyCT21712I+Y3cfr/lXQ87jd4vs78shR1
 DQEYaORu0iTHdkm8gtn1VCpnU4ViEMQaz8eu++dwuhENpkfMuAFIMVRSMMAYYYeSnDgy
 jJwp4KIUO0wdnFRz6q3hMLlRK3ZwJcH8St9/bZn/knxJGrxMvfiB/CcPl8Qd5EoVVZRi
 TxoNSIJ/j2jaR/QuRbgrxQ/wVCVcUMC5CMAdd6qtn0fGyvX/x+7yDdNJDT2AfKk39C24
 Xs2Q==
X-Gm-Message-State: AOJu0YwS407GNKI5xanwMuy4OICkN/OczdTsWr0Zs2rE4Q4frHrtwcdK
 +pJu+4u3sgaCnvpjeVnAZTCFuuCSQktGirXl4KZwES4Se1SiOOOY
X-Google-Smtp-Source: AGHT+IENcpPkDWGpB65tkHZRnw552zKSc4MgrD5QUASpkPJiFqSAdEsmhjYKudFbfzt97hvX5L7P+Q==
X-Received: by 2002:a17:90a:be0b:b0:2af:d64:4887 with SMTP id
 98e67ed59e1d1-2bf5f50f7c2mr12233184a91.4.1716923716911; 
 Tue, 28 May 2024 12:15:16 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:dfd9:2d9b:ff9d:4f57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf92de8b86sm6127952a91.45.2024.05.28.12.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 12:15:16 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: paul.liu@linaro.org
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] imx8mm-cl-iot-gate: Add support for Samsung 4GB DDR
Date: Tue, 28 May 2024 16:15:09 -0300
Message-Id: <20240528191510.1366328-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Newer versions of the imx8mm-cl-iot-gate boards may come populated with a
Samsung 4GB DDR model.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c b/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c
index b230478b611a..f1048a1ab2ab 100644
--- a/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c
+++ b/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c
@@ -47,7 +47,9 @@ struct lpddr4_desc {
 static const struct lpddr4_desc lpddr4_array[] = {
 	{ .name = "Nanya",	.id = 0x05000010, .subind = 0xff,
 	  .size = 2048, .count = 1, .timing = &ucm_dram_timing_01061010},
-	{ .name = "Samsung",	.id = 0x01061010, .subind = 0xff,
+	{ .name = "Samsung",	.id = 0x01061010, .subind = 0x04,
+	  .size = 4096, .count = 1, .timing = &ucm_dram_timing_ff000110},
+	{ .name = "Samsung",	.id = 0x01061010, .subind = 0x02,
 	  .size = 2048, .count = 1, .timing = &ucm_dram_timing_01061010},
 	{ .name = "Kingston",	.id = 0xff000010, .subind = 0x04,
 	  .size = 4096, .count = 1, .timing = &ucm_dram_timing_ff000110},
-- 
2.34.1

