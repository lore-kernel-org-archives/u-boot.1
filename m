Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7AAC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F149787D04;
	Fri, 19 Jan 2024 16:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qz3bZKMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF14B87CFF; Fri, 19 Jan 2024 16:12:46 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB00687D01
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-681922a61baso7579746d6.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677163; x=1706281963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsFoFiFJFdTM63u/auxH+O3T6fcEUW7OB0tALJkqxAw=;
 b=Qz3bZKMomTHP5xaiM9utzgfCADyILRNNegougGg4MgXXem+LSKsTaQBkFYnuAZ35ZV
 w1DxCPedmohZDJXLSJSF7m8+bmraEMqW6dJM/loyDfrCAISxmTNOJG1WmvUeKt6wvRtx
 Hk9un+mdW9q2+1K/ZXlY98moU1RwqHnXhruy7KyWMkEh3BPEsnNl7O2+DGFsRa0IR+Fo
 3JAMSVx6g/8q3r+o1aQUAdhMzMpQoAtCfpShbLoZp9Jj0y5JRdDhYKOd+jrNs8AbaejK
 zizeFuPMBW0/33DRxUF5fFrAcmcPN4uon7SaSfRNnycr8qWg/Lzqp45O5RmTxOHqXQxa
 3bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677163; x=1706281963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsFoFiFJFdTM63u/auxH+O3T6fcEUW7OB0tALJkqxAw=;
 b=PmLueZUny9QPRCafZzcH3Iw8jEXydzd26kod5KHFAz8BMnlVtc96+/sXYQRhbq2+tu
 ruZT9w4FRUHTwjlRMSdevzzET1+xXS6pYR7EYqYCdb07Ow19/E+DEaM+7MD38uBiUMDJ
 MGBZbcJP9l/0eO3MVHgV29OFkhbYmVtWEVUKnnAyXzVHlSFvh724uCcZ8NyHTtgMlmhy
 90gl9BAA05h98+i/pOdSx3G8zgW7Isn00HJwybGS6UGexawhJbkiOI6ySwwgv+VuX6k4
 glgRwJ4v6rSHrfTnF0mWvUf1P+KLyNqFL4JDLezvCYHl/Pr6YUXGf3fMlC5D5S2KKmTo
 oBnQ==
X-Gm-Message-State: AOJu0YwSmLy8FvtGLJuClzotIt8iTr+UCCnYOMsV5iYcQIdVJz8K4OUx
 F5TiUpRdnx5fpPrxipVXvtU5EMVtcfRkykOiNTyKb7WnpPPHZy9YMCBxLEvd+CAqQec8cgSQCAK
 6
X-Google-Smtp-Source: AGHT+IEC9miKt7l6P7Ec4hKBqLkTmLJdXDQmcNKAVptx9E0VPHFpexmmUR5PP2ul2AtOHQFaOpwg9Q==
X-Received: by 2002:ad4:5d46:0:b0:681:59c7:6606 with SMTP id
 jk6-20020ad45d46000000b0068159c76606mr2211672qvb.44.1705677163363; 
 Fri, 19 Jan 2024 07:12:43 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:43 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v7 8/8] dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
Date: Fri, 19 Jan 2024 07:10:04 -0800
Message-Id: <20240119151007.715348-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

When BLOBLIST is enabled, FDT is expected to be from bloblist
carried from previous stage, instead of from OF_BOARD, therefore
only enable OF_HAS_PRIOR_STAGE when BLOBLIST is disabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in V7
- Initial patch .

 dts/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff89..def0e17241 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -121,6 +121,7 @@ config OF_BOARD
 
 config OF_HAS_PRIOR_STAGE
 	bool
+	depends on !BLOBLIST
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
-- 
2.25.1

