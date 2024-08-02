Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A021C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64B088BFC;
	Fri,  2 Aug 2024 15:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kvZCNnfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C5088BE9; Fri,  2 Aug 2024 15:15:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8723688BD5
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368380828d6so5245701f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604509; x=1723209309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=kvZCNnfB5nRgZTDFszOapKF9jPDMb2Gjybr9d/5WGYaM7VWJ66TcphHvEqMDBTfjb6
 HYbAHSLZ1hOT4ta1uSZru2jDG3wh8AeY+3Mzo/tSn1kF0ByOpJDGRGeV1uwUfwsA8iUf
 Mx8l0V25Byfl9KJK2AwDb6Btqc0qfcFJUiTQtVgC8yAt8iQ6btgkUzJ3z6S+EGM5aV1m
 xHiOgP8jIUVLYsLi9WMJKP4PssaY85/RQWiM+MLSL0/kVD0dWo7zxiFjDqy6AeWJKNdp
 r+HbHF/2W0FQod0CAqRLdIIi4r0iQv0WB219qJEmnY3FVgV88ViuXOTTHzNWbGtTYsFv
 oI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604509; x=1723209309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WNv4mpJ6VyNsS2SIbAVCWQUZxVTVTsg01B6GTJaE+A=;
 b=q5dhG059CEDi19g+/gnAPkGv767CF/XSm328NqUxJH750WvgEU9jHp5BCThK0oKcVe
 pocc41J7HeIsHWQx+IqP2S8LDA8v+aBdeQX1zXE3Dhk3r770jKsp0Usvv7V9azcPCNCg
 sujN/vty2rj1mirc7OSm7rQ0zAgQj7jVEhBuMSFKvWoFjFHxr+mDmP/L9cMFUJKhn/LC
 +qsdMWrxIsHo7CpA1ldU43wV+LP5ALVOyChG4uj4DjcKMf8f6/xbsvSqArBXlFlHukSx
 PsxIDk5RuIRPkqrrBbFqbnfZ05R1GN4MvUzTxOrXOPfXXOJdrOEAcW8G3Apti8ZYsGE0
 xxDg==
X-Gm-Message-State: AOJu0YxSpy759uvuE7cus2IP+1n55wCrrnwoU/BNPGyUROsKTnIGnkR4
 gnHlP1QY/ClDMJLlbu+gdWdsCf5UHyYrwinBz4nCMJd80zlUdPD4GOpR4INMTHL3nrPcLBxD74A
 zOyPoIgKU
X-Google-Smtp-Source: AGHT+IH2UCjxdg2FeAT4tHsQuN/dcdBoNTxtHhjbwLVeAFG5YgaiKM5fiLBpDtdbXt0bF3QGofuFOQ==
X-Received: by 2002:a05:6000:18c1:b0:369:ba89:a577 with SMTP id
 ffacd0b85a97d-36bbc0ff65amr2241632f8f.34.1722604508742; 
 Fri, 02 Aug 2024 06:15:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 16/20] configs: add qemu_arm64_lwip_defconfig
Date: Fri,  2 Aug 2024 15:14:03 +0200
Message-Id: <33a5eccdf0d884e6eca23be6c10683959324cf8a.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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

