Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE9FC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D3D80756;
	Wed, 15 Jan 2025 21:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m2WkE2IA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B6580756; Wed, 15 Jan 2025 21:02:49 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1984780214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6dd43b08674so2269516d6.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971365; x=1737576165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gh5uuTOQwiS/wWi79qxdAAILiUlvtaWABJW0PdF4umM=;
 b=m2WkE2IAy0Pvavx2BbkBR/SmF/XHTW3U65tfrzpR3doNxykimZkw6ijmnqvvCDJbgZ
 Aqpd+NGu4h6fg5yIhPYb7WfzHSNkToue/bLEwfkKNhRwWoD5Tvqdd5Cw4oQ9U3LjHtEb
 0ZEsNIJ7/NOqmP7bdYBHeh5ZcZiHZFhfNexllxcHqq4JVSWQq9barKHj/FSEMCdiIjuG
 u4g7+MWerKIfkXR3rzseFykNdO65EjgbmSWMd/rb6IlsjPNSm0I5z7hFZ71oPe2W+Ht7
 K9eg6bhY8j/CA9krJQHUrNx/GsBvt8A1Oy+IMHrbuBlbYKT4anpTE8vQ73C1mdb3OTOL
 V+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971365; x=1737576165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gh5uuTOQwiS/wWi79qxdAAILiUlvtaWABJW0PdF4umM=;
 b=i8hy0P4Jm2Pofj5x2y9f5jx6PlQ5iZa2DR0Z4dfcyx78CGyZivpRRVSZ6jX44oY1bL
 wy0NpgfkZ6pQaGHD0/zirzvq+GL6wzGTWkmQ7qfldtUHovgHFmIvyAsNQ5+2KqTOl8++
 uDP6PjDwVB4EOWD0f8Rdk+/ZBh3JTWVUF4Hn6wkvl9CdbrA903viAJ7DUQ1ObPwpKvXf
 fedwFeL/DFJZUwdvSXTVjVUNHSC6nl/qE13VwjnzhONw9TLDKHcS+UY+3Guz+rsD0/8g
 fu3zVaRr8D5ng83Bh4poohYql1WAU+2160hlVoeswe1R3t5uD0BBq5krCEoealRrmCi0
 Ml8w==
X-Gm-Message-State: AOJu0YzX3oEwAHzkxBl76bPhcPJVSPSoDE99dBS/0suBmxEa1HGFJv0K
 WVWz8EBQwGFmG0JapWXYJYc0v0V3xlHAxUzRUWTy1/h7XIq3uhib9b+aQblhqRkVDiu8gLyQkU1
 diCo=
X-Gm-Gg: ASbGncvam/lm/gKw4rtG2BvorzsG4TJ2iC46QYFR0JTEo35kWmXIBr6lNWC1IGUA0sO
 7CG5Oz/o58/TSSxJACJDqx/0hIpygg0nXNYt7Ry9h4+p8/PJv0sOQ+YWVKjmuf8laT8ywYjS5Av
 1TfqpLSzTxYgxAPs62I4lVSQF9CL1NDcTqX9YlZOhz0wWWdCjdMBgmdg+34zZbW6NzsRXhvtA/j
 /B5UzpI698y/7tN7OCUIGEzEmoPi5srBUDb0JJKOhs+vfb1rrtp2UYiA1AQ533SSM6OUlq/KZjN
 v3VWd/dJWaGvekEq35JUeHoZuKGWx6Y49uOUrzffX04ZdMF4i3ShvFc=
X-Google-Smtp-Source: AGHT+IGa1BqyuOmpbW7TUXHYwvO8pHLJ7PMsSnAf0+pLhc+tFI2kjNE1Ll66t1tt7Ok2v3ZFvkPJ7g==
X-Received: by 2002:a05:6214:27e9:b0:6d8:a591:fb8 with SMTP id
 6a1803df08f44-6df9b2b3493mr447562856d6.37.1736971365715; 
 Wed, 15 Jan 2025 12:02:45 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:45 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 6/6] board: qemu-arm: select TPM_PCR_ALLOCATE
Date: Wed, 15 Jan 2025 12:01:40 -0800
Message-Id: <20250115200144.951530-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115200144.951530-1-raymond.mao@linaro.org>
References: <20250115200144.951530-1-raymond.mao@linaro.org>
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

Enable PCR allocate and system reboot when algorithms don't match
among the values from TPM device, U-Boot support and evenlog.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 0c7107c1f4..6ba3cb1bbd 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -73,3 +73,4 @@ CONFIG_SEMIHOSTING=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_TPM_PCR_ALLOCATE=y
-- 
2.25.1

