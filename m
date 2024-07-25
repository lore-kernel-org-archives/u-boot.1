Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D49C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F56C88381;
	Thu, 25 Jul 2024 14:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="moCyBb2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816B787C38; Thu, 25 Jul 2024 14:59:09 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C72688327
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so5348675e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912346; x=1722517146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRylH2b07WiZnMv3+CCoiVj4W7fQL+Q+CWiOpqbvU0s=;
 b=moCyBb2T0Ik7hJ+pw4J+YxZSIbm3u4uznYsV8R1LbSjq0l1V8eO6knW/bEWLKQTHWe
 3fJen3widv5N6P/2MoVe57V7J4ZfGas8INIi7SRiMFfooS2ImqqPZaXfo0Z7vAFOlBfR
 tmsJA9BxcPGJNQ4AH6a6vJnrAKu6t1d5+duuZwBxOA4DZtUG5P+1XqJN6i0FWhv7bZGs
 k/2FQsMeGSBCB4uR34048iqmeeRdqMUIxEfZdfjuqMlwn0IuZgwbEyDmHx6KORzmxH4M
 4m9iVhBCMGfnDZjfW0yB+AD/P5/hCNOismYMpCLjbfh+6VZv1mq61QJ6izzC/gc2thAZ
 7FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912346; x=1722517146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRylH2b07WiZnMv3+CCoiVj4W7fQL+Q+CWiOpqbvU0s=;
 b=jwSfDqwFABFe6ngHMFlZr91Y1nhM/SpqYXeuheOBkms1awLGsvsc00MMWn/W4OkJA3
 bA1GvvQAi2qykIpHqiAFMlI9F24INRHmCcc0gimHsYrNQUlBOIuhkw7ESKtgD+DOmJ1i
 39M+5tqvqFi0eY1TR6B4NwBaZNYxSKlPtTdHGNczLP0QeqF3bMwirCU2IbwJRWQLImRM
 tLtCWhXK/v3nBPcCW2sZFg2aNhYaVL8lGOQcHau+7Esp78ySVlzuGf7G1xDkfx8O2iNy
 +FEORQwjkJ8AQxg4MKazRuQlfqqgZYAcEhXTVK/AOS8TNQS94oJ5uNobfP20o0fA2HaO
 HAOQ==
X-Gm-Message-State: AOJu0YzYjjwWefD8fupOlXVn0jEMTATSfhXGDb/pSza1QBDVIt0Wkgmb
 MRIIGELMqrzbtAhjeDrN8bCV4xH4soJbcCW5fjEMYOinJDgnPBad25m6/KBWNgVvlEQrNstMDSg
 5qlZVwA==
X-Google-Smtp-Source: AGHT+IFjVH3QRPgrHDVAcO5RwNROcGqYBok04XhFZJfCsCjsRwaw+YiC53igOIxDFtEuPyxTV8e4Og==
X-Received: by 2002:a05:600c:3150:b0:426:67fa:f7 with SMTP id
 5b1f17b1804b1-427f9a07a80mr37766255e9.9.1721912345767; 
 Thu, 25 Jul 2024 05:59:05 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:05 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 16/20] configs: add qemu_arm64_lwip_defconfig
Date: Thu, 25 Jul 2024 14:57:37 +0200
Message-Id: <dcb78f4958be3ad322168ccac6214991af44c884.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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
 configs/qemu_arm64_lwip_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 00000000000..1afef04d7a0
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,5 @@
+#include <configs/qemu_arm64_defconfig>
+CONFIG_NET_LWIP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_WGET=y
+CONFIG_EFI_HTTP_BOOT=y
-- 
2.40.1

