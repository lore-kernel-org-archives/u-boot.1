Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB0EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB72388C15;
	Fri,  2 Aug 2024 18:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O8plomQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075D188C08; Fri,  2 Aug 2024 18:28:35 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F2888BCE
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368313809a4so2009227f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616112; x=1723220912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=O8plomQuJV49J/fx8n6pKNxnHvIJcgj/vuQpaXj0ItbInYuz7G7nv61DzYfYX94bHE
 JPFQN74OdLtGcCTKJaIMN3RaIyhRVDbn6Ui5RXd2KtN1e34W7FLPICKNNGEwo3eMKfjT
 V7EXNV1MSNa9SQWauz2IDUMNxyx0GI7Dpelm0wrI0Vmfnlo3c6iKFCvzF+7x0P7O4V9S
 NOZDnoDG4wze0BYnsf7PxoO678Wpd1m7t2TN04ymhVsRXrb6PNrTKX7zbA3OJqkSh0bC
 JLnPpt6dBLLzWfgdY3FaIGA0yVGC1GdvVuf6IiWzrCECdqdhh4rAAZ9oauS8T0sAhRUp
 5AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616112; x=1723220912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=He+n7grAzmXcH5/COQt8ZMnbsOa/8IaABOMvgM7yqmq0Y5rYnOaGQNNeq63Ta/mFe4
 y56zmqRebm+iTTeOj/q9A55iN5u1nUiM2ucsKmomM0HyZimbIwiKgndCuEkUPipUIyGm
 Wf8w8oC/CSOSqpq/4H4UaT7lHK3+VBpclnNe3bdnAzS4AqMcWtHoF5ebBqtVCwe6l+3Y
 Er7z76+HXTm+lbFKGVFNDPSIF5iwgs91qHtjPhHHfKygJMMtfZFeFdBUZFwFY6Oud5oW
 E15YLboh12itvFt3anjTAhaZktS+H1EDhbZIxBmdQ/sNUzuXv3o80GNJmaWQvvDNUHjY
 6v5A==
X-Gm-Message-State: AOJu0YwTUkVmV2HN3riK/+AaZHu3cM4LS6hUNT0CKrieRmMoy50A5q01
 WCUqFkwuw/ZaDobW3gSJZeCb1TlLhUhAAot3FAMkQ6Bm1w616oaIhGydW7hLd8GC0o38uB8mFPS
 OvFqnBLBP
X-Google-Smtp-Source: AGHT+IE2uuC8dUMGDdLKXGRRfdQ3oVyTE5yLRTRbun/iQhaOCMnvr82tBHrLW/Px8A7jGJyxfbIpbQ==
X-Received: by 2002:a05:6000:2b08:b0:36b:bb7b:9244 with SMTP id
 ffacd0b85a97d-36bbb7ba89bmr3560246f8f.1.1722616111944; 
 Fri, 02 Aug 2024 09:28:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 16/20] configs: add qemu_arm64_lwip_defconfig
Date: Fri,  2 Aug 2024 18:26:43 +0200
Message-Id: <e31c2afe97ac81c02221172df573feb9052e3979.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

