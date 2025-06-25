Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B92C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7030B82D34;
	Wed, 25 Jun 2025 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CLRvDm7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DCF803CC; Wed, 25 Jun 2025 15:21:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D03803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so5762474f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857690; x=1751462490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YUMuxe7rZ2dVK+dGtIuMJ4qMxxfJXvEVzTi7cLAud4=;
 b=CLRvDm7J7rBIajpmoZblEZpXXAOwrhu+34q95iuepgOZMNt0MS5XnFAsdJ+B1L2PkK
 UHM6oLIqqoopSeWtizXcDvQ96mJgZUYV5ZjYjudDg/YOpOgXtAMdOrLI5VfFb6ytgk14
 UVLsClm42YOS6Iko5pLfiKdpwmcZL4qxRaw55aqoeMZGuNx2iv3o7shN3JPOoVesUUc/
 L8qlOAFVpjG5U5NsPtAlw+8YGgHesuI5GSwPHG6sUrmJr9Hz1+6c9ycyKVU0tpVZmBbd
 2OY45yrBYkBEUcn/LI7HocJPHsldw7FvrdclpNig/iDhWxXuo10ag1yq+VHFkhdb0eC0
 GxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857690; x=1751462490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YUMuxe7rZ2dVK+dGtIuMJ4qMxxfJXvEVzTi7cLAud4=;
 b=vi6ezPUAmVE52DNHI3t7WhF5eAvF/3dDGKpWu0qhb2MVNuGE4UrtB5uCYvJc9IDOVE
 SNOPT2joRYlh+9RiGG+0wKyCaX5vGvaLM/pyETyW1PpozNnC5bcs/WAQAvr6VkuKXCyc
 MssAi/FHTVNwNsF1MXq10NZjKCUwnautPwJ8POaYXIN+vTAWIQnFdQm5x/tgeeoyjtIo
 iIYPc9FBNVrNe/1xjDMHqhn6u+P8wUAuz60CFd5eu+JBpBOMfJkP+UBvWVmQ39rGwS1C
 AfCJUUy5HxtO9MTNaxVNgyPv62HICXRQCH52ORXZtoKJ0HREnRzxutfMMc2uFlB/hKze
 2HEw==
X-Gm-Message-State: AOJu0Ywoa1rCd6GpXmZcG2nOTLBOrVk1FkxSlLhD8zblPdilEUMxxtuS
 cxSvbP3cTT4ahURq4dB0j8zk9eSIhZs2W1htcYIAgc5EA5OgSRj+A10Hko3lFCd9OvR3tDHmjsi
 4hiVdxIw=
X-Gm-Gg: ASbGncvSwH51aWxDFbRXIV7uRVge2hCaU+duFiKcQDZwlm6Kre+jrZj5c09O/RnY76o
 j5KXqpyemWIYnc8gTuJFsYWCAD8LUsxIgBjUJxaWWE0LLvuFp6KkQpNK0dmgArY2ZlzSHxJd0lN
 8oGAoC4vLZHRS68XRAOrnOw2nY/w7qF62UPjrcOhP7GPgFWduKG4BbQ3YQ+gGoSNq/BTayYtH8S
 Z7FBMH6eaRPiWnfKGTw6owYNVbGzqQs5lhMrsTO4Vzq3HGixbXXorN4DR8deoI/DIXbOy9vygf7
 KCaeXgLi5Kt2amg75EhIqDn5QXe/+pgh9beFATshvEXw7nynmtjPwuVzc7/3+bX5tpBfdAg=
X-Google-Smtp-Source: AGHT+IEMfKS8eFOi9gIaGKhvNQW4nnbQOISTQoyhjJ+PeFXp6d81zCILAcIa2oBFMs3jkw0tDeSrEg==
X-Received: by 2002:a05:6000:1449:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3a6ed64ba19mr2566075f8f.39.1750857689563; 
 Wed, 25 Jun 2025 06:21:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/13] lwip: move net/lwip/ping.c to cmd/lwip
Date: Wed, 25 Jun 2025 15:19:11 +0200
Message-ID: <20250625132108.3292932-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

Prepare to split the ping command from cmd/net-lwip.c by moving the
implementation from net/lwip/dns.c to cmd/lwip.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v3)

Changes in v3:
- Move this patch before "lwip: split cmd/net-lwip.c into one file per
  command". Drop a change recommended by checkpatch (uint16_t -> u16)
  which would better be submitted separately, since the purpose if this
  patch is to move code around, not to modify it.

Changes in v2:
- New patch

 cmd/lwip/Makefile        | 1 +
 {net => cmd}/lwip/ping.c | 0
 net/lwip/Makefile        | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {net => cmd}/lwip/ping.c (100%)

diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 6c4ab58d06b..da79b64b5c2 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_CMD_DNS) += dns.o
+obj-$(CONFIG_CMD_PING) += ping.o
diff --git a/net/lwip/ping.c b/cmd/lwip/ping.c
similarity index 100%
rename from net/lwip/ping.c
rename to cmd/lwip/ping.c
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 255c7d018b0..97299d9b542 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,7 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
-obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 
-- 
2.43.0

