Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FA2C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EEA788C5C;
	Fri, 23 Aug 2024 15:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y2GiaJ9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87B5886E7; Fri, 23 Aug 2024 15:50:10 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBB788C0F
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37189d8e637so1073955f8f.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421008; x=1725025808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ojnSnXWSx4hAnWO4s8nLdkuHVSQzYxXK5vU09NYpDM=;
 b=y2GiaJ9I4UrYJ9AIiZ+QJ4vXU96i6/eq+pcCuJq67Hzj7bf88wonY0oLxVXaLOJ3pp
 HfJ2+uNS5v04her5mSaUmPY0INIEpc7aRaVsE/kvkUDGC7AtaiP4ZHOYN5l2oMwJZWDz
 rQy4tFkXJKe0mQa02qHzfiPZqfMd0z2ulhsxNaF7bsfCsF43Y0RyNWdlqjrGdYZauWDx
 Gw9eXAvmxX/7UDdg1LaR0FRmb8Uc8bQ1kAy8gkYZO/F+lE5RK6dHRRS+b6BofRFSzzb+
 L6GUV5ZWhbM44E10VTCGKcD7rbuEYIhI7Wvl4NwRiaAD+Obi0IxJUMxA/DSe1iWg2cm4
 +xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421008; x=1725025808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ojnSnXWSx4hAnWO4s8nLdkuHVSQzYxXK5vU09NYpDM=;
 b=XYdWVW41mcwbpkgAGBJ84oTdNRHjE4eKvOcxvL5QIc+7gi3Tvv3RHPuipFHVy0Pj6l
 lVxQ2b9zpLAB7HIO4Mbza1ed8OMw6jo09nzXfC234QLyVGTM2JK1qDXEnOvWuMVeYA2u
 mLrMKgm4RMqq2Dvmg6TOEWjJcYZ/TQQ8fMxn9+xGpLlYAvwnHtTdZjOeLSF12fyOJib9
 jsaeDHOltu0RoqV++mxb5oBAgGizwDS+RPCOEFJRVrO5qN6NTKgtUvB102frOlEYJV/B
 dvwfk4O09Mk8K9TYFpUEQofsxAUmnxGCUpMprVjYuN4SgO/wV4J3rp/7aNWK27XRsLmy
 3J3g==
X-Gm-Message-State: AOJu0YzlKIcjFbqWKcbexFsh4nFR5yDPFAkk5Te+CPWCc2/lJECpdeY6
 eTwzmEdEwpAX0iPWgpFsmgVNGJSR7y7p/Wm7bgivIkn0HoTHlRB7lYJs1Y1Wh20hyTrZSQIEXgU
 w59DYFg+x
X-Google-Smtp-Source: AGHT+IHJKrTP9JUKeUQ22XoNicLgK9eCJolk6Zj/5Y+64rMvqwhLYp/L1g8hoEpqN92aFc68ADlwFg==
X-Received: by 2002:adf:fac6:0:b0:371:8c9c:d97f with SMTP id
 ffacd0b85a97d-373118580c3mr1438450f8f.10.1724421008196; 
 Fri, 23 Aug 2024 06:50:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 28/37] configs: add qemu_arm64_lwip_defconfig
Date: Fri, 23 Aug 2024 15:48:32 +0200
Message-Id: <3d55a61d399cf5f863b1ca372b45bc1b833715fb.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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
 configs/qemu_arm64_lwip_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 00000000000..c7198340592
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,10 @@
+#include <configs/qemu_arm64_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_QEMU=y
+
+CONFIG_NET_LWIP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_WGET=y
+CONFIG_EFI_HTTP_BOOT=y
+CONFIG_LWIP_TCP_WND=8000
-- 
2.40.1

