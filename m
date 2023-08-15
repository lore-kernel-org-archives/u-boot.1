Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEDBC001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 13:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C7C86797;
	Tue, 15 Aug 2023 15:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P9A8HYky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F3186801; Tue, 15 Aug 2023 15:48:19 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F14E86703
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 15:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b9cd6876bbso1471137a34.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692107295; x=1692712095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MotOVxhttXuojFHNWSO0b55KrsToN4P/RDAl88Bcjcg=;
 b=P9A8HYkyJ/2NA06EGXQEJM/YiPei/OSrZPPM6ezKIQQwtKvtR9zG+yFQ3uBNFtnbsz
 SplB33DNZb6JuXtdnfBlsKFOVs1NhWif1dO7CvQX3gdbR41VTNW4hd0laYXYnkd3tsYg
 /rsowllowf9P8LxpcZ4vMfAmIw9crVfJQBnd8xVK710zQhLZrCckSxZ8OYihESapSfyP
 cHaKlrq9qlox1Ao30inArQjOf8BSkWZ6zc7F7YO1DAJqrTVwK7uxnwku8f+lBpNRvNNi
 RaIh+pN21pFKQa1MbyWvmrUrUiLGwdzy4D9VjxISsgDm3pLXu/gh7i99ivQnVO52ZPHC
 n+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692107295; x=1692712095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MotOVxhttXuojFHNWSO0b55KrsToN4P/RDAl88Bcjcg=;
 b=aLmQn+77SwTyecl0DzJU8qVPAXE0BfjWbhrBALdJe5g/BylPRoxaTS/l3VsULWHUci
 3uhJLm+a/Td/YfbFg5DOnAcjjt+mk0Q+3jU1ekJaGIxohDq5/tSWZLREHEkZWsEH1XrD
 cy89bW+XX+tq7mB/Qbm0sfAP9Vr5Wu/U5K5m3dD3qNQ+YL1uzcuE39GH2dIkLNJlfwda
 MoyM++IwN5J9cU/Y49G/upg3WkCnCfVgB7X24Ssp7z38IUMmAhiw4tsa7IPPeEkzr9FV
 ulW8HG5bxFQgYvVYKa1xdY5p8T3PpH97NxU/sogMils1pYDBMWgiRYeE1hldA9Y9CH9c
 NMTg==
X-Gm-Message-State: AOJu0YyWN4g/TueP4zTCPHCYIpV6p11TF4Q/4L6ATgHs1QpDWrPQN0Qn
 KQco/mOY/2Z1k9e0dVB8sO0=
X-Google-Smtp-Source: AGHT+IEY4DcdEqZM8MgQjOzoin0zYuG4RMdPDXvS6gTUZLcvGz5MJRnwa4YYeN/1RFTSR3A7OQjY4Q==
X-Received: by 2002:a05:6830:4697:b0:6b8:e2bf:c4e8 with SMTP id
 ay23-20020a056830469700b006b8e2bfc4e8mr9577301otb.3.1692107294966; 
 Tue, 15 Aug 2023 06:48:14 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8c5f:174f:a995:4289])
 by smtp.gmail.com with ESMTPSA id
 d22-20020a05683018f600b006b871010cb1sm5300678otf.46.2023.08.15.06.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 06:48:14 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] doc: csf_examples: csf.sh: Remove unneeded export
 ATF_LOAD_ADDR line
Date: Tue, 15 Aug 2023 10:48:01 -0300
Message-Id: <20230815134801.780735-1-festevam@gmail.com>
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

Originally, exporting the ATF_LOAD_ADDR was required, but since binman has
been used to generate the flash.bin, it is no longer needed to do
such manual export.
    
The ATF address is now passed via binman.

Remove the unneeded export ATF_LOAD_ADDR line.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 doc/imx/habv4/csf_examples/mx8m/csf.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/imx/habv4/csf_examples/mx8m/csf.sh b/doc/imx/habv4/csf_examples/mx8m/csf.sh
index d87015f6c4e2..65c143073cbe 100644
--- a/doc/imx/habv4/csf_examples/mx8m/csf.sh
+++ b/doc/imx/habv4/csf_examples/mx8m/csf.sh
@@ -11,7 +11,6 @@
 
 # 1) Build U-Boot (e.g. for i.MX8MM)
 #
-# export ATF_LOAD_ADDR=0x920000
 # cp -Lv /path/to/arm-trusted-firmware/build/imx8mm/release/bl31.bin .
 # cp -Lv /path/to/firmware-imx-8.14/firmware/ddr/synopsys/ddr3* .
 # make -j imx8mm_board_defconfig
-- 
2.34.1

