Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C578C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFFA88D72;
	Wed,  7 Aug 2024 19:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GADgpdns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939AC88D71; Wed,  7 Aug 2024 19:13:26 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2CD288D5C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3683329f787so40882f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050803; x=1723655603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=GADgpdnsG4RURWZp8qoxwe2kQo2Id9WpQcHwazN/ayrGI8FU3zIyQErXBIMr9a6A+L
 aw7Im8sK6IyuENr7BrbRZu8MHIxmU+fZWkUxO4rTiTYuYZgQaQcQcS1KShBQclaS7/Nh
 H8wsfKBvEJRKVtSkiLHzpBDzbnhyho/1MoazushlE8bKhHwKSoLJ5U/uoXU0qbLOltv8
 vfoRW//YELidKpfrDTJKJgGAWA8ecqDWV7j+MfBDuvgGsrnAVFO6vme8cHexQtGdPwsv
 ElnO9vXRd36HJk7oaPFbTSKVfelcAaXw7bMmg03sWVlXOnndRDj80JgYoMgUcOpqSZZA
 TXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050803; x=1723655603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=Q3l/6iS9RqTD4o7ljOkynLjGZayVoXuctYndOGV4bKWh0MsSqak3N0mKUZQNkKHLCV
 h385+M64+kdDmX2PS08YhEu1Wvh22EwpwHhCr8Wg4xxjBJ2tZpNHlhFKHmtyyKMIM14T
 VzQ852R2CzrYcyOLRsmAz3VtKOqqEkBQKCB61vnXNKP0CxwpUavM3r9xOTqmYP+uTh9a
 a4DK/fwuwg/r8JKLheT19eRua6vhbU0Q+sBXXezb6kyNlqfVagti2B64eyrWsVG74plh
 SbbIoy7aiYZGmhOrjQpqkX+dsHALXTCpfhOzaJxQ783J1/VDKMG9BrfAvUL7QYoF2WpD
 0o1Q==
X-Gm-Message-State: AOJu0YwH0F/lxquY1z08DakjrYPTpna5AjovdKzhScC+D5dNsOQtk2rr
 +CRKWMqb7HX+6GZL7kSCanzDK/nA3O5axLQFSQh1fWq6er/K9CqTAIy6iY0j7pLJM6QEqcEI8wl
 LjkhJ7fuu
X-Google-Smtp-Source: AGHT+IHBZzWZVcbZL99OcogSXRixBMIu5jE2oRZdvQYbECurU1de/zTnqbIDrhitEbolfJg1ZYrkBw==
X-Received: by 2002:a5d:6c62:0:b0:368:87ca:3d8e with SMTP id
 ffacd0b85a97d-36bbc0c6ec3mr15144285f8f.4.1723050803150; 
 Wed, 07 Aug 2024 10:13:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:22 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 18/23] configs: add qemu_arm64_lwip_defconfig
Date: Wed,  7 Aug 2024 19:12:02 +0200
Message-Id: <b71c32cc9e5611ba8a8862add2f862cc43a277f0.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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

