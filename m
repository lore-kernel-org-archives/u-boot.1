Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E73C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3762382BBF;
	Sat, 10 May 2025 15:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g++6fXj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5443382BAA; Sat, 10 May 2025 15:44:05 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC62382BBF
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad220f139adso276246666b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884641; x=1747489441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BK5uRwtYouIiQMHYOBhTduLGFJrzo5DSGPgNC9CRQR8=;
 b=g++6fXj7toXbgj2+AzI0xT7/7v9UX3ZXXFtDz0hE0AZLfMbLWyEi6U8tcSjvkg2+uB
 +WdwZ6H1cGYKjHU9Jtg9FEUPBiPaPwy1lXFggPbK4x2kPyQgjg/23ec9vD+h+nLHm735
 fpQ4+Nc4GtdXY+ObBUoBtkZZ0iosuJCBSc274=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884641; x=1747489441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BK5uRwtYouIiQMHYOBhTduLGFJrzo5DSGPgNC9CRQR8=;
 b=aU59tsNHu2iRDidiY3uLUL8r7qFP3x4pepocJ5E17z+nq3rIqt9CwJigNg2++DNx/M
 28p00PDaw1481hhL4XswVHg6XYtt6pm4dSv2HXetkyK9ZRVMC866dOXqr2LnauWJYFnZ
 0rTqiUH+yufRrXYesHZuQd46oRYYqDuy8RKPahgynwXxicl2yO1ltjk7eXoGEci0sQmS
 2oyLFvQZ7GnDngx2p+/exCwpIfUXxpSU5Lzbo9XkfXQNtkrMc28jLQhjYJnQgtQWZV8Q
 uLYb/+1GU/B2xZH/5NLFZxct4IeY4lmeFnqnqvbNbwxLxfBY4sRSwuOAVnfMQNWz53Ai
 rtnQ==
X-Gm-Message-State: AOJu0Yys5BCHUWmKCZRHmA+C1jPlssBERdwcZhOjEZSAaxa4LCWi/zqg
 TUTK/pNL+XHZ8ODDWlb8n0Ha5gdBNxMh6bHq0ieWH+welXwqxw4Ah+x/CS1WMTNEAzigSBsFKXH
 NAQaMrd5Pzw==
X-Gm-Gg: ASbGncuu4DE4ez7NsrcHxDRf2JJJS+VQEveJPFYAOOfLdpV/gD3/hThKlJONI1+C6ER
 6zpdK7vh6Z+0m4qsHFEYvHxUTHA0eLhGe7HSVW+Q4+ucsWNwE1eI6Si8pLFIKvVBBpDK8vxxcw/
 HKyBvSdKGPpBI/VsZ/b1xKVd8oBlUv8+N8lG7Q9fsWaboSqAZnjSLGMK/xNeOSRPmraP+z1utV/
 asLgh8U8mRlhCXTIgAJTtfEw3MidFpETWB9h1uDcFnyCHS29tFZmc58flI6FD61YrZ9mXPAPx//
 J7c0V1D/IXZivgI8nGcH6SACI+9feK+zC436AMZCvXQrY3Q7mC/gpsjbaJdmfLN4GgHo
X-Google-Smtp-Source: AGHT+IHooDqFYZmcAHHqj9F3AIjRAyUodSKw2RZ9lL/HxyB9fcOVBWDfrd3Bb9vI351jrDlu5ueg3w==
X-Received: by 2002:a17:906:ee87:b0:ad1:8e6a:5945 with SMTP id
 a640c23a62f3a-ad21911576cmr667849766b.36.1746884641038; 
 Sat, 10 May 2025 06:44:01 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>
Subject: [PATCH v4 13/22] vexpress_fvp: Update to use the new Kconfig options
Date: Sat, 10 May 2025 15:42:11 +0200
Message-ID: <20250510134253.1581164-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

We need to enable CONFIG_BLOBLIST_PASSAGE sand CONFIG_PASSAGE_IN so that
U-Boot is built with support for accepting an incoming standard passage.

Update the defconfig accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to update vexpress_fvp to use the new Kconfig options

 configs/vexpress_fvp_bloblist_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
index 4d52b96202b..fd5f91bc039 100644
--- a/configs/vexpress_fvp_bloblist_defconfig
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -3,3 +3,5 @@
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_BLOBLIST_SIZE_RELOC=0x10000
+CONFIG_BLOBLIST_PASSAGE=y
+CONFIG_PASSAGE_IN=y
-- 
2.43.0

