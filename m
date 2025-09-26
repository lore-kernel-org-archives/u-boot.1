Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DE4CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283BE83869;
	Fri, 26 Sep 2025 17:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WNi3Jh9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0321583869; Fri, 26 Sep 2025 17:31:50 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFEE83858
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-426516e0961so8809415ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900706; x=1759505506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NyFKL1IL2dMF9yhWIYypIy0A6erhFXdidWg4tcyV9DQ=;
 b=WNi3Jh9ZewySp2+cZmIDP3CBjdovXHUPdvwzsicw7xrvTvLW0c1xTRjqnDEKgXTgga
 agqZijhgzXC4/MgJEZ/OQYKRl4ZnYR8FhwWhpZBgX1zkafQrFOnwZMaGbWW3+xSCpFOU
 da93NAI8Jxe8bNXscDS5jLqG+oWrqK6ir5goA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900706; x=1759505506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyFKL1IL2dMF9yhWIYypIy0A6erhFXdidWg4tcyV9DQ=;
 b=nBK6lKADmZZy7RoZQJ+lDMoD7dMplCQv070biwesMWy/mAH1u3cMMdG3YZfzesPwxx
 C7qwiI/Jh6A+o+l65KgFr9oN6f8iQRCnmaDEWofc761Kt3FIvhoOPU+jyIeWOlH42f/b
 I0Ge7/w3LUVoCjudHrDXESopeORn93D1txURYqBbBftH6mAi/bwOef1KWozBFWjn3c91
 wH0ItTNU5oDt4WHKfvW0WyTBr/ApnBKajewar6HDTD7BkGfSrVL9mT3zm3wWFVDTCwyO
 GCwZvOsCQh2XKESfm/NpfwcR68jKJP1IH59DQ7VQ/89f4APxgdxt8yUWTXFLTsfbDaSz
 G6Xg==
X-Gm-Message-State: AOJu0YyJKFnuiI/yG3tR8E6qB7mf8kiRsOwjcyjTeJylfkfjQ2DTprvN
 UmEbC7QDBq6l+X5tuYuLjkYZ+7m1YF1C/wAIF9mcXGpy9THxjVbTdQQWpI/Osz5u8bisD7x2rw8
 IpkbG1OQ=
X-Gm-Gg: ASbGncs7JRcHTrP+VVhvv3uWNen/B1XccAUlmUiav8VTvuxMQc+XBQyCOdcQa2579fc
 YdB9RIAKkJYYVNjes1jr8s6RwBu0YMZ0gUjCl+BsvEqF6RfsrLhI/xxafLZE4tD1Ob0/2bxrIS1
 fo+BmYotD7acmCXnIHB62DSqN95tJXQdM6Ba5P97Mb1TcLNi5AVqtNbupJ4pVq5CgSGEJVntDQO
 pEwDlpu63D0e8kASgmT/DysAHFGRZWYaB7wtiHQRKQ0SCvSs5iQPNXar5ZMg51x1XXlun+app3b
 pyD1Hkapogva02tp8/WC6DRQLTYw4c0Pul0jWYFsSrwth9OqwQFjKAJvzMzKYw3VC3/C2atYENL
 Ha6dGzkU23P8xZjs03qk4wvArcqyOn12c5e3LUPnfx+7VyBkW/OaUtUPcLIlD7IPtEMXvrw==
X-Google-Smtp-Source: AGHT+IE1yWJQarkZdTWp//zYxdOffj+nFUq6/kxGv6Ngii/O223LrRcOgGjBWMSW/vCRBOepdBAD5g==
X-Received: by 2002:a05:6e02:3e93:b0:3f6:5e71:1519 with SMTP id
 e9e14a558f8ab-425955fce57mr112007755ab.4.1758900706415; 
 Fri, 26 Sep 2025 08:31:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff83e0fsm23024855ab.39.2025.09.26.08.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] tee: Rework Makefile logic
Date: Fri, 26 Sep 2025 09:31:44 -0600
Message-ID: <20250926153144.3680937-1-trini@konsulko.com>
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

The intention of how this Makefile was written was to allow for sandbox
to build and test drivers still while otherwise requiring OPTEE to be
enabled. This however didn't work quite right in practice as sandbox
could enable some drivers which would then fail to link. Rework things
such that sandbox will also traverse the optee directory when
SANDBOX_TEE is enabled, but only build one of the optee-specific files
when OPTEE is enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tee/Makefile       | 4 +---
 drivers/tee/optee/Makefile | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index ff844195ae12..5bc5df0d3805 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y += tee-uclass.o
-obj-$(CONFIG_SANDBOX) += sandbox.o
-obj-$(CONFIG_OPTEE_TA_RPC_TEST) += optee/supplicant.o
-obj-$(CONFIG_OPTEE_TA_RPC_TEST) += optee/i2c.o
+obj-$(CONFIG_SANDBOX_TEE) += sandbox.o optee/
 obj-$(CONFIG_OPTEE) += optee/
 obj-y += broadcom/
diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 068c6e7aa1bf..36ac085ef420 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-y += core.o
+obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
-- 
2.43.0

