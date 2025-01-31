Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CA3C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8632A80FC2;
	Fri, 31 Jan 2025 23:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/FcXgOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D0480FB5; Fri, 31 Jan 2025 23:05:22 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D67180FD5
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d89a727a19so34309916d6.0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361119; x=1738965919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MjdaY+pd44UGg9L2JSrD/5rG3+/rW2XlDTslWGel6H0=;
 b=s/FcXgOY7NGYAxB4mjvxnNS2PMFPXdZVYDvx0q5M6Xp5CFVBshG/3vgR/TPhoi4dqT
 L7VxfdnMp3Q/enQIoDtPVRV7b+ppD2IajF3hvxgk5VH9ssLF+/s1x0pr4O8a0buPgcpx
 U8S51p1SCfaBkdDZnubnNesJQbAs4nuGxgVkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361119; x=1738965919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjdaY+pd44UGg9L2JSrD/5rG3+/rW2XlDTslWGel6H0=;
 b=pGTCqpDJUzguM4xrkO9evhU4Ie92ohZzbthnPVKJRKwE3F8Fwg6tN/cHZAjXoc22A/
 zmwFnmU+Lcs7PqlCdWtlnn7QcVqwTcStGHtZ31DH0eaIzjleFWvq1c56Y4Pu70MYJ8zS
 sdkM8ZMEKTutig4mD7m/1p96i6r+4ipJoXz00Q5lJ5K0WGztMGf33gXkIjUIg4t8NcTn
 xpTme4syz/Mz0sxlihtNSDREzdbDk/ehaiQj8d8qtd3rCENvqIv6p98SbrlSc/iYunPo
 uJpY7eo20PnnJ7pPVD/PTHLGxLt+sawMoYhtD5Ck9WtGMUjVob8PTPhumHapIYSsBoH5
 qjYQ==
X-Gm-Message-State: AOJu0Yy9JnwEayuEokpXw6qItl+bZlcwl/FIvJndpNthaz5qZzOK1vjX
 l+2AxTwqTB1k/2ZQ2hGkR7mA9nnjZLlyX9reBlpw0XeRAprnnVJKmD67nzOkOE8I5wg5O+51M8C
 5
X-Gm-Gg: ASbGncutLWvZ8JQLRWnW+pXjlTQrPh4sYMAzbaNXOxc8gjXRxObZtgu5fx7dMmy9F+G
 sf6hnvdAjTAQyfeF5ydRGafK8HrYMLxoHGGYfvkg10EcvIyv9cQZF2fOZX4RhZKb9rgGiXwW7Y4
 m0Z6U1TRGL28K2vlUVV0p9eIYsIKJwdrf2lGPZ9wr09W0+xaRcMsOFqb3LRu21IhKeEJPApvti5
 dWYIJs9YRXk4B2AYOGWcmLa7KNBL3HwSRcGgMvfUyK1Yr1x6Jn0gVX/6Y2KpLMyzRqdXy/PzGQ6
 hvYK+Jv+QhAyVprssA==
X-Google-Smtp-Source: AGHT+IHEAhgCylaS75Pxti6FlnL5fNZt93HsbPrxsPzHHnM4sKhGudw6shAk2d7tqNAb83EzZaOepg==
X-Received: by 2002:a05:6214:4005:b0:6d4:ac4:c1cd with SMTP id
 6a1803df08f44-6e251b45231mr150593236d6.8.1738361118568; 
 Fri, 31 Jan 2025 14:05:18 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254941306sm22156326d6.107.2025.01.31.14.05.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:05:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: sifive_unleashed: Rename "spi-nor_qemu" variant to
 "spi_nor_qemu"
Date: Fri, 31 Jan 2025 16:05:15 -0600
Message-ID: <20250131220515.3060059-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Given how files are searched and parsed, we need to use the
"spi_nor_qemu" variant name not "spi-nor_qemu".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index db471e67107c..444f6988758f 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -500,7 +500,7 @@ stages:
           TEST_PY_TEST_SPEC: "not sleep"
         sifive_unleashed_spi-nor:
           TEST_PY_BD: "sifive_unleashed"
-          TEST_PY_ID: "--id spi-nor_qemu"
+          TEST_PY_ID: "--id spi_nor_qemu"
           TEST_PY_TEST_SPEC: "not sleep"
         xilinx_zynq_virt:
           TEST_PY_BD: "xilinx_zynq_virt"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a93703fdcea2..4f5a9b8336f5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -478,7 +478,7 @@ sifive_unleashed_spi-nor test.py:
   variables:
     TEST_PY_BD: "sifive_unleashed"
     TEST_PY_TEST_SPEC: "not sleep"
-    TEST_PY_ID: "--id spi-nor_qemu"
+    TEST_PY_ID: "--id spi_nor_qemu"
   <<: *buildman_and_testpy_dfn
 
 xilinx_zynq_virt test.py:
-- 
2.43.0

