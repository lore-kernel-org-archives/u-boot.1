Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C316D1AD3E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4D289034;
	Wed, 16 Oct 2024 12:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EX8J3Na/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6E288F35; Wed, 16 Oct 2024 12:05:13 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969AB88D1B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so3254302f8f.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073110; x=1729677910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=EX8J3Na/Jgp1Si+4O7kQ3O9ci02ZzPJ2MbBKVKQeXr6bV4rxA5XUMQHhnq+q2rKAD7
 GYO40wsOfb4xDoDXDK7Fbt0EveJLvL2cwUQxm2xOraHvCQUM1SJJb6dI7x/dIr+aBhJS
 dY2JQOL1GgQGnZUogLnvAc6KeX3mTv/s574dAllOzsM8fcv5ozqLtS868tepuiIG7y41
 NlIgmLt0v/X4apWkChYDOIuzoz+pECvknnmCNZM5jd6etiP5Bt2WJ01OZi7W+3rEcb7V
 Ghm2v+jGYy20BkS3PQf9ba/r9eSOtFMEuHJsd9tA8t+djkS9GeTXzFV0TyNHidxe7/j+
 2tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073110; x=1729677910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=Qa/0kdKIhLjM64ylT7WFZl8u03wP+8uIO80s/C/YzguMiyzOxKaSNVPwLR+M08Ly2p
 lCbSMHyCwe6kYO5eN+Ms5DUFB0/pyX9dcuwGWU5U9+Tdqt5KROw8X37PlHC/4e/QRqOG
 s3M61CJV5kXkkTNNcOSZDWB71GPlcmKWzkmCmUy3D1TVEl1AyR6pBCf9jsxpvegLQjU2
 IXLIYHedCRJaOxJz6NjV/ckMcufeiU8/94dkgCanVfYWF4q4PfFn4SSYu/8mpLmv8iMR
 WuEfkysAIXemrxXzcc1aMXDUOJOtQ/r0z5K/ovVqUAkHQxn92IN/WVGSBxX/ArbT6AlE
 +wVQ==
X-Gm-Message-State: AOJu0YwxnYcryTo9rlpxYCbEJjldA+t2OEY0cUiB18Acka3ZLNO2UHb9
 xsTo3TU4sW+UTcBa1N17ZDhtXavbfWRDhWPD0LwimxYZxIyLWNkVeYb198RDitds2/HLmfCnNNw
 aacD0huU6
X-Google-Smtp-Source: AGHT+IFgC74tGk3TKeDig6VxFUcnLtlGefEjgM9qPU963kqSlfgZjn4b57+yUePBoX5jFEpjEuxlCA==
X-Received: by 2002:a5d:5f93:0:b0:374:c640:8596 with SMTP id
 ffacd0b85a97d-37d86be330dmr2667582f8f.32.1729073109849; 
 Wed, 16 Oct 2024 03:05:09 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:05:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v13 17/21] configs: add qemu_arm64_lwip_defconfig
Date: Wed, 16 Oct 2024 12:04:11 +0200
Message-Id: <9f5ecedd572dea342ec8668b2712d8ea24037b64.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

