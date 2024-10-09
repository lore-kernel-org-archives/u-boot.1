Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D552CEDDA3
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFA988DC1;
	Wed,  9 Oct 2024 16:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UOl4UmXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69008911D; Wed,  9 Oct 2024 16:50:40 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B0F88F4B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37cdbcb139cso5152110f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485438; x=1729090238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=UOl4UmXzWBBpVS7VtPnIYMfso6/Vqdxthh3nG8cDsBJBxANW93QKpuXI21TXiR/waK
 UZ5WQ56dnlhNHrGMxUInKv8nXwwBb6qyyhipbe43BxLHH9Bt226CFDIRWNMRuRrH1aUH
 vbDgYYF6HRneWsRqg5kSyw61zHUo0iyzSflkXqSyOB5G40OaBNwfuw357qKpC8lMfyo6
 WjIeBlC/7CnhdSbuej7aZta3x/+j6WVi6qOzFABJLWBg4ji0H6QRk6ShuAZU0F7rluNU
 vuTtLMsUyWVfFPwyuJWclcjAxMVSEk80nwVBO6DLvzhMY6rtcQe0UhMnIoch1xcNbGPq
 yaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485438; x=1729090238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=mu9YVooO2OvuIdyRfEVjQlDFdyUijxKf54vGV+MRg7UjgRITxLGeF0aReQe2qrQN8R
 ECgPOOFAlyXrVMW6gOFPGbqjJY1+nSb983ADdCOqMVx7Siulzn8lEqjrox3SBLl4gxVC
 kKAZSqzG5dsSNk1RvRoTv5I8YvsTYBVMSiq76IzVcgMGsYXRgd+R6DUTHwxR6QsQJz4F
 Xwlf0yqo2rQUtWe+4UYjDEFmWa4uGe3XQKNGiqW1OxaBEVcthVJNwLFsUFcKHSSBBGe5
 AzQG67NfrrdVCeyD2hT8/dy5zbcCJdpr3LlbGv8ay/IwGZLvFNk9Zfa2d2EXpVQ4v4aX
 3C9g==
X-Gm-Message-State: AOJu0YyD6vSynMpq/kJHbP2QJDp85yOwxwPE+/Wc75t72xVUPdng6kXn
 xIYWLR7hwr/yqIw+pWm8HX6bbZDhFWuzyLoeD67mpjuLgoGSNwS8mMSK4nQBeBWrl/48zRE72Xh
 G5amFZXmY
X-Google-Smtp-Source: AGHT+IFPnfgNyQkESJoj8dsuDKWVhl2m8vooPzP2xiL+L1exLC2wJqdAJBibxHoU92SMQ9TC5kg4Eg==
X-Received: by 2002:a05:6000:247:b0:37c:ca21:bc53 with SMTP id
 ffacd0b85a97d-37d3aa28902mr1701882f8f.26.1728485438182; 
 Wed, 09 Oct 2024 07:50:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:37 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v12 17/21] configs: add qemu_arm64_lwip_defconfig
Date: Wed,  9 Oct 2024 16:49:58 +0200
Message-Id: <50acf54ff287db660b8de96b0efb52b6f7f3683b.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
selects NET_LWIP instead of NET. This config has all the supported net
commands enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 00000000000..d3d8ef16e66
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,9 @@
+#include <configs/qemu_arm64_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_QEMU=y
+
+CONFIG_NET_LWIP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_WGET=y
+CONFIG_EFI_HTTP_BOOT=y
-- 
2.40.1

