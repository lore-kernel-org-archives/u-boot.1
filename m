Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA30C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548DB80657;
	Wed, 15 Jan 2025 15:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z09hSKY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5305B806FD; Wed, 15 Jan 2025 15:37:35 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E852880214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ce7f6fdd2aso11289925ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736951851; x=1737556651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=44EKaejuCTMTqCdqsu8FGVOMPB3WZbotIjZnxMLAR5g=;
 b=Z09hSKY4xYKPsQdhpZFXH1C+MNEyUs5JNN98xLVa4Xdsb9yf+COAVGOEaLR4uU8C44
 LWTIN9z751C+uO9rKmsvdEQKZn4VPfDIOwdFwAuMNC6J3mfxcXY7N3RozXUBA6WBs+ug
 dPRljcttoi/uMbpo63bKRfLZpf5Iue7QGywVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736951851; x=1737556651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=44EKaejuCTMTqCdqsu8FGVOMPB3WZbotIjZnxMLAR5g=;
 b=E1aX1ZrN/CU+WvGHdyPbOBT5J7OaOKbjM+1D+FzLUJERQO5rhP6FJx6ZBJGqZ0JpfI
 +BYZcl8opgozn8GhpybxsmiJD1uQxrUuQmXIkHih2xIEWy4sYjISRT72ldOJRT424nR2
 66vXkmt4snlv2TpXT2X/YXTjnUm++Sndtc2PbaXa8ug/qndrp3GseEEShDYe2JGOcrMQ
 8SsHMhafGiSn8BjnHlalrFTKk6lq7PZqeW+3Y0d5o9uBv2Kzir+v3Yva9ZeES940aLFZ
 +Rc/oZiRqDmSiw0JZNVJIeM0ttg/cx4eFT3507jVvpWm7mEUirO99dZ7Vftw3qyuhEA+
 hZ1w==
X-Gm-Message-State: AOJu0YxWCDD1n1z4VDWAQkKMR0BbL4QtFhQb6DUPXr0Jc4wHF9qHJz1j
 MgJkUTnSFRUF4U6GQZEo8nu0fgvK+0u2iCU38L3+AhaYfyjFFe2mIiDTU/238b/5C9I8WnBCKBs
 =
X-Gm-Gg: ASbGnctCsVl4uMOOjt5XxnIW3lmqut3zwQMKKj8bA2+F22Q/HfM/KrYTyYaigXUikem
 AXxRQm4DfAVwn9SwUzU+gNGXnherjh/wLG8mf7PEe48OY/guqgRAHDWmpY8unQafnQVqsABmFoI
 oipsi3AH+O5frGoznB6ME/EG6MQnA01UW3IT36h7ArlnHIITGvMFc81gawqlxCHgNyz1r3uePnR
 gundzOqt9zLQI89oIk1YBBmSV8MiLCgddbL2z1u4CJxB997X2Yhz5DBI3MipWQSV7I2/zfSMqaR
 lefORkyWtoR94/MTqQ==
X-Google-Smtp-Source: AGHT+IESMyXQeBw9PWlTPwHJapCii8lQ8GU5qhSlWxexTtnAxP8GVkP5Hg3vbgXOciPcx1pPV5IMrA==
X-Received: by 2002:a05:6e02:174a:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3ce8ed9cda1mr4906905ab.14.1736951851050; 
 Wed, 15 Jan 2025 06:37:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f83cdsm4115720173.15.2025.01.15.06.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:37:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 17/30] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Date: Wed, 15 Jan 2025 07:36:47 -0700
Message-Id: <20250115143700.851043-18-sjg@chromium.org>
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

QEMU always gets its devicetree from the OF_BOARD mechanism so we should
not depend on !BLOBLIST here.

It's not clear why we need to have any relationship with BLOBLIST so
let's remove the entire condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
---

Changes in v4:
- Drop comment about PRIOR_STAGE logic

Changes in v3:
- Drop entire condition

 dts/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 41a758e83a6..2e88d210bb8 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -191,7 +191,6 @@ config OF_BOARD
 
 config OF_HAS_PRIOR_STAGE
 	bool
-	depends on !BLOBLIST
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
-- 
2.34.1

