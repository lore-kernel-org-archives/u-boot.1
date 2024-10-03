Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D796CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E90788F73;
	Thu,  3 Oct 2024 17:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y0BhCkGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7252288F5E; Thu,  3 Oct 2024 17:47:29 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB8C88EBA
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so9962825e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970446; x=1728575246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZUXRSXDL/APhwEIqrep5SEH02GfIyM2tVPaQe75C/w=;
 b=y0BhCkGO8Yh+gKTMNQr3S+b5s6TIv1SBzhaJm4sOmJzj9HtGRLZwQ9h0PMbi2vZ86A
 1CqXxpnRPgLSfKc+d2wHujZf90McH0oGJVmx0K/64WNmgj+GMWWTvh16NRfBJXyP9kvk
 8+HS0+cQbPH0/or92UXvFEMeLEirv23UiUyXxF2pPxSlakMgKWVBCoX2C86napzex/PN
 qnocldNB9jZj1drWgl/tyrJKk31qg22sYfBHNWm4nEEmy2QtnXqgHzJ/054UE2yupmcV
 lsoLsGAvDhtvBj0PF6CRYI+d2nwY/TdRiQ8/Wxtybuxn/hTS4ACbXxY8VbpAYNfQgO77
 h08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970446; x=1728575246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZUXRSXDL/APhwEIqrep5SEH02GfIyM2tVPaQe75C/w=;
 b=FLDiFav+XuGixLuIfn1BHmJ3bwm1GthHEEKdU1AssnMaM9RteIaB2VWweeYqlvAAIa
 d67Pi5rWcu8gxQahyPHcKihn+MisGlVtOC8UbnYGV+b5/vTH0ZvxQDrwNemg5C25wLMn
 8B1t9lwWO6J6HtceEFtDqfGwlwrCZDQ8aZmzJfTJIktaDnM05ZZCxxnba5Acrva1gXSa
 7VqhvP8+qpqiuubxwK8e4ZQoMkTj7WVBVCLnHt5Bro4MUdjDgY7sLWAbwN6NDWxkMxvj
 yG+lWrOoGZ9KOwuGsymwUl0zhDup+JXb1swmrmhmwiKmgkYASMl6V5c8IlJF0HosuiuD
 JHkA==
X-Gm-Message-State: AOJu0YxGB9X6+CHkle0tQIcAjCGt02Z1IWFYtICte2E+YlYOHI6AK4uq
 uyS2Cy6fcs3s0wm9IgukFEC5JJR3d8wiBfFjEGESiielC1czaNgqeJbhyQ4UrTWRQLHMHOChlo6
 1rcceE0Mn
X-Google-Smtp-Source: AGHT+IHN6fWZjXye3suiByBTBqEyVD0QSP4MfESfGKGMw09LMCRmcSPoOjCld7Kfcv6/YLCWEaChAg==
X-Received: by 2002:a05:600c:4f4d:b0:42f:80a7:84e0 with SMTP id
 5b1f17b1804b1-42f80a787c0mr17237185e9.32.1727970446322; 
 Thu, 03 Oct 2024 08:47:26 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:25 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 22/29] configs: add qemu_arm64_lwip_defconfig
Date: Thu,  3 Oct 2024 17:46:26 +0200
Message-Id: <a7ec9fbf5f2b15c52d6d94faffb0f77dca1bc92d.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

