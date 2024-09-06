Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9143DCE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC5188D2A;
	Fri,  6 Sep 2024 14:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TOLhmBCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9983E88D2A; Fri,  6 Sep 2024 14:35:20 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF88688D04
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8a5bso15434955e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626118; x=1726230918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ojnSnXWSx4hAnWO4s8nLdkuHVSQzYxXK5vU09NYpDM=;
 b=TOLhmBCjBlhA0nnkcaJIurwpGFCm9KEQZX61VAiHgKr/Igd4oPv/EKjNXasw3gOwfg
 pRN9AAu+3H76UjxvXyzB0GFUggaPPtBn9kjhouJz0I3tmiSniUyv04bT4v5/JbVVjLoo
 zO3Z1D1f3sR5GQyo3L+JztA7sbna11V11QOkkeypylc5sPhPabkO74DqKjGg4pFq4Lhq
 QLEPk7xfaZhtkfxAdfE+avzUJXshWcojqeJUByiUDb5hi7qmCfqQ9MFIl1xKrS9Onwl5
 zWFsfK61CHzkL9t2MIpl91gIF1I0vTbZrAfWMQMyYAFv+PS1Khid5dB0sCCSZ+dfICv6
 UAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626118; x=1726230918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ojnSnXWSx4hAnWO4s8nLdkuHVSQzYxXK5vU09NYpDM=;
 b=elQY1XlV+zqGmL8cSEHC4Ph7i9zBx7iIbUZjA0yXUyBg4KQqzFoUB9s6kQ53jLCmOE
 vT6g0fRZC+uYzaR29bpq5vVci0E6k4758L5LOZ72w5kA2O0OhtFaEv7FJ4e4qbAXnr51
 nVXVP8sbittjuPZH9NNZy0ijnxBZncyAQLvmu1vw8JxNofEoMKnUJXjWNuLBs1t44WOZ
 wxXwrkhxvFbquQfcXaXc0vWFkIv7OHGOZOPOi2SYwlLXWJhjBRZ4Z7pNDjdRJnU1bAku
 XBLpBYW9aMX9lWD1rj7E3rlwhX9dwx4/4W0BxSWELOTiiyiDMzLLjpt/Ce3eW6lsHjDr
 3KIw==
X-Gm-Message-State: AOJu0YylxXSiN8EdCwwmMOSW6QQe3bhB9mzQ4Kkt4tZQH0g8VsE2H+T2
 7Wb6PzA/RzslkhgS+jerD7S0YPT7cMeTARSkEdJhR73XU1cmdPKcdqGi3/Tc1cgL3H671qWAiAS
 TI0JFWD80
X-Google-Smtp-Source: AGHT+IFDws6SVTL17dMj/s8HHh+v+1vWzIuqVMxbNPM/zYBgg0/gUShhieTRtrodXMBsiUak8zLCwg==
X-Received: by 2002:a05:600c:3483:b0:426:5440:854a with SMTP id
 5b1f17b1804b1-42c9f97b8abmr18152775e9.1.1725626118094; 
 Fri, 06 Sep 2024 05:35:18 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:17 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 16/25] configs: add qemu_arm64_lwip_defconfig
Date: Fri,  6 Sep 2024 14:33:32 +0200
Message-Id: <f30be77810ec27fda5ed20742228c36c038ddf49.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

