Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0425ACAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F2C8318E;
	Tue, 16 Sep 2025 18:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gHbbOHTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EC883510; Tue, 16 Sep 2025 18:15:07 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DDB5832DA
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-4240d243340so17687395ab.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039303; x=1758644103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fODve7IwoUZlGkdSY/txOmxvbL+BPlgAHYc2BAzYewU=;
 b=gHbbOHTkEQUKyufiivenmEfzJrH7UVw7+ZQwqPQK5bBIubMrqDcZLDzTE0u6n2yByh
 bBeenB5fdyhRYJFfFZG/h43WvGEY8R0yM1bM6d6qxu56GhRkB2hNcmwmHzyVnSvgO+Eu
 uSZZi/kj5jrG5QYwK3JDXnN/LhzdjXYFikYacmFQrV5uvJTv0abDRHgBSa+q+kCNdEAp
 afC5lMEQW/UMOFhomChmsHTaxPShCBqrb3z9K0esZIf8OMKslwZeQ1p9NBppE6gzrqM5
 FM4SjygF1Hh9rTi3A68Qjopri9e5tgBDy9g/J//ArQythVlnVbxzj/0Mu5exNrYZ9Mio
 pluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039303; x=1758644103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fODve7IwoUZlGkdSY/txOmxvbL+BPlgAHYc2BAzYewU=;
 b=BUMzcy+eNixZbAewFO3Qm/hIETPK7CIfVRrIeRT6sIaTOI+HOhB4YMZnlk1qEN+F8S
 qj1ATL1TuX+Ut0Y3RqIivQ+egZyjQJgN/sl9Jt41LZ1t0ssMfu4pHYg6ZHpb0WS9SxS2
 +vufwENJbGydJOfP+0uC3U1sr/s6SE7L5pVtoKkv3LekkSyoKE6nwr5GP5qkeLPKOnEH
 NNKzMFAaXvQQXCXI+RkyGmVodWLJcBXe4YLSCEyYYtVaJ2qHggXWtlA5NqhJZTmvuNJb
 hGqWsRextJsms9WbFJUh9pg83ZOrtDti/7M/gLjPAf0kpzYurRY7oVnhNw/WJbQMuLA2
 3+2g==
X-Gm-Message-State: AOJu0YzM4zNzpi7YaMjuMKuUX6mcvFnwXSJxxe7kjGzAHwcqkewA7HRM
 H7do57xe8gVI+RAMi/RbtCejznhfKp/uXVXuv8uqGvOMeSa3qMNu1fRq6rnBjdFO1Oa9NS/8Ecc
 yW6v3
X-Gm-Gg: ASbGncsLgUfizq8DV0N9eqT1SQVNos5tLpAYITqc3L9fDz/WV83Yr9NT5MoN+zGKZBC
 6LthnSZEWnkToYnjIoqCBeiu7fOLvEkUHkEOcmorrn3ksiSkF/uG4uefzQDoRn4UHE7+WjJWyqw
 PtMfOagx8+wEjkUr6l6K3q2CaHtJp1ZA1bvK9Vi1HEPBAKJRFQBYcScUaHmpOxf3X1nL92sFOks
 NiWYVEzl4DEmUU+OZqglI2eKtT3rPdRjbv7+aNm/K/J8ROfbaMKIcuxxBsa9hCt0I7E4w8tOIoB
 8ogSve3n48l6lIpdPm8WyFO6KdB5mWf3cvODCA9p+BGmXGonknGnr8Q3MYm4wFZH+CHYCciqyRY
 dHOJX0vmugvFKHHFAyPjRuGFGLnyizDXV44jMr2ql69xom2IMv58JyTOAGbesP3cLJ+Y+6Tyx3+
 7JOQJ4p5EyKA==
X-Google-Smtp-Source: AGHT+IE5H7OTBcfqd13DrOBlmICtMSDZxN+7XBH5souZY962Zu7QL4O9M1BJZdE85nnuvDPhLnLZ1g==
X-Received: by 2002:a05:6e02:4417:20b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-423fcd65736mr94429935ab.12.1758039303212; 
 Tue, 16 Sep 2025 09:15:03 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41f0ea1bdaasm68433615ab.39.2025.09.16.09.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:15:02 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 4/5] configs: select CMD_BLOBLIST for Firmware Handoff testing
Date: Tue, 16 Sep 2025 09:14:20 -0700
Message-Id: <20250916161426.32259-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916161426.32259-1-raymond.mao@linaro.org>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
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

Firmware Handoff tests will leverage the same board type 'qemu_arm64'
with a new board ID 'fw_handoff_tfa_optee', thus select CMD_BLOBLIST
in qemu_arm64_defconfig for running the test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 358bb1aeeb9..0a43abf8fbf 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_BLOBLIST=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-- 
2.25.1

