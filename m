Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A8E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22CA8070C;
	Mon,  6 Jan 2025 15:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BVQHCKVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29729806EB; Mon,  6 Jan 2025 15:33:48 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3A78056D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a7e108b491so127789295ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174024; x=1736778824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05oDa3rd73Sd61y5ErCw2hDVIcuFxQvmkw6lTP0K32k=;
 b=BVQHCKVf4TFKIJT8zcZpK8nwmBJMAAsJPVJan4QOT3uFjc6APaLL9zEM/KS2HCIQbS
 8Twz+cbxMbLv+WKlZrimmfe0BMhKaG9oE2tctCS9CdngA+lcIUS6Q0T5ZMeefTuPL+hz
 T9ItZ4z1V4KCH/JGtlAa3VB5+4Dt28+7D5koo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174024; x=1736778824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05oDa3rd73Sd61y5ErCw2hDVIcuFxQvmkw6lTP0K32k=;
 b=NK+LineqCoBZkssy/ORA6iCibnZC8cjZQmO6EpNJIFhxe5Moxd6ahXuJnB/LDPlgVR
 Kk0fqXJwxjzqyQCkBdA+2IAHRzzeR2IkeGv++V0/2+vg876IXpBfOMvmgHYfiQA3xSz+
 nAXKF64waam0avLHvBjQpMoM+FMsK6O3duDzYxRU3X8gwJwsSLei3RDJmZXtSXBZRbdv
 co1wUcp660KXkEeZg0FL1W7x0QzDFO1zezTMnsOu1FSoXTPtjvj5r9kvhZ4BFuBP2tVU
 DPEJbU19PjR05MeIJlzAWThF3WIJ0ZLhfmYX8CoOBTC9oMjfNZbkVXUmwt358ZQ2IO8N
 z6Aw==
X-Gm-Message-State: AOJu0Yy9Nm//GPeMVMkNRnccXFuNRqpyecsfD27s6w9Lqe++2mwbZIm2
 899vX89G624s0y4NricuYch2aNgaeB3KrjwA/6coIfdtygbrSd4z104UaG5sjrc23O5GH8HYs+c
 =
X-Gm-Gg: ASbGncv63Ll+tcb+CQFg6qBVzyixEw4sxlr77vvTID8UYy1I+RuwtS3VPo2uUw653Ot
 3gr1zr+DrmvQUBd20UBwm9CKB72gi08dQpPDipr6X6LDHYWRjMa9NbqCMSuInm/hLDkS2UMOLSN
 gPZwHfQ/isFai2+JWz1C8Wn2ZW2rtsxHQitBEQUCmv3WVsMxNggKQQNsKhgcir4hXy6xTik/u5J
 FzhjqlQv+pAv/YA59saKqfZs5kg1pTfQACueNmBPwN2FpGy97f2/xkk8HnQ2cIKcWizMR3cDoqL
 KxNCU7mJ641+Owqe9g==
X-Google-Smtp-Source: AGHT+IHeKznBJZoaeEmkhKoaLl+0aRuR8tr9LAbcrv9ek0tTeDAi6EcV3pZ6vTPZ0bj8pkQ9swOoyw==
X-Received: by 2002:a05:6e02:174d:b0:3a7:dd45:bca1 with SMTP id
 e9e14a558f8ab-3c2d514f31bmr430113545ab.17.1736174024087; 
 Mon, 06 Jan 2025 06:33:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/33] x86: Create more space for SPL with qemu-x86_64
Date: Mon,  6 Jan 2025 07:32:19 -0700
Message-Id: <20250106143229.3023771-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

The space here is quite tight and there is plenty of room in the ROM.
Move SPL earlier to allow for expansion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 3c0fc7a34fe..39375c76227 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -7,7 +7,7 @@ CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_TEXT_BASE=0xfffd4000
+CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_X86_RUN_64BIT=y
-- 
2.34.1

