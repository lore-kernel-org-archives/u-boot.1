Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F44C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8862D87B91;
	Fri, 29 Dec 2023 18:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fMP17v13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54DE87B8F; Fri, 29 Dec 2023 18:43:26 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746FF87B82
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78109a21144so581311985a.0
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871802; x=1704476602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO5wMGyLmtP17mXl6SJk+QUJ9h/FXcc299FuxgH2TWU=;
 b=fMP17v13ZHhT7EbK7Ozft6ZZOiAMkOwdNlqJiYt4XDrUNdnfAnAQDvwtl4RTEXIG9G
 3jYfTTJhBtS6dmqhE3IGvE17GUhR1XUxwv2a+BmK9bLD67jWDp2j27iW/bfauQCoDJyK
 MG2qk0/xmUaG5c1BtIdtFTzPeccCkMxiFCK8AHnLjiDwU2ENIOIx9kwQo0UbNVPPe2oG
 7ganNFIcxhIzNc4hk4y2b/VOCI5vRShl2xPUZa/ONIaJAU6SQr0d76xGLVFYCKE7jtWE
 W9r03MXgAeAsi1mIVQrMn2QfBABgtS9BtOryOoCkS2dnSFgaN2yHMRlMDpQTcjXg1niL
 wDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871802; x=1704476602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO5wMGyLmtP17mXl6SJk+QUJ9h/FXcc299FuxgH2TWU=;
 b=HfrT0arMHNwYDAkEpQS7E+N2axiuOirZrTEBuZ4Wh4FZJNa7zvvdopSW4RSZ+vhxHj
 8Ye2vLM6A94yQKscC+ze1nX5XrwMfc0QD8auW349TMTGzktilc2yuXdliwpy//2iZJaT
 sYsvg7QpfrYjp+rIz4jsTPpn3e3jmaFyYWj2+zAOtp+otifHMQ1EspW5NPcS5T9UMo4u
 EO3EJ4TXX59HiXgRI9rGIRzmlF8IQn3wDHoA97+oyW5fcN4Ybp7RcJO26sRdFrWSSGgC
 z5lK7OM1N4OqG66fA/fpfO8+9MFG/Rvo7CfMOsDqia6XcE+QGAJvyN0KBQoIOtum2YNm
 nMzw==
X-Gm-Message-State: AOJu0YxjOghRqSDCwJOJZtNF2te+evLk4loaAC7vJ1jbhTjHd0REy5zS
 tPxqmAbsuxVSBD8hc89j1VL5no+LGdCZXIyTFjzacu9v9+U=
X-Google-Smtp-Source: AGHT+IFOalf+TflJKOpov8jgjNcysPkXa4B7yFvbtAZr+Ym/VNJVK+TcYPIVcf/Zmso5TGRegGTmkQ==
X-Received: by 2002:a05:620a:448b:b0:77f:b85b:7a62 with SMTP id
 x11-20020a05620a448b00b0077fb85b7a62mr15318928qkp.103.1703871801913; 
 Fri, 29 Dec 2023 09:43:21 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:21 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 04/11] bloblist: Set version to 1
Date: Fri, 29 Dec 2023 09:42:36 -0800
Message-Id: <20231229174244.892818-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229174244.892818-1-raymond.mao@linaro.org>
References: <20231229174244.892818-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

The new bloblist for v0.9 has version 1 so update this value.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 72c785411d..7eff709ec8 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -74,7 +74,7 @@
 #include <mapmem.h>
 
 enum {
-	BLOBLIST_VERSION	= 0,
+	BLOBLIST_VERSION	= 1,
 	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
-- 
2.25.1

