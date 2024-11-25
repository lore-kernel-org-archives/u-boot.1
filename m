Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A01D58069
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AF389A3A;
	Mon, 25 Nov 2024 12:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lqcKq/7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D05789A3D; Mon, 25 Nov 2024 12:56:40 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1632C89A31
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so5247405e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535797; x=1733140597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bIeqD+tgm9Gkr/VFzi9SNixE+TBzGIvSZpyuKOO9KU=;
 b=lqcKq/7raHyfKNLdaAwlG9lbQlQ2EG9Us9ENiGF74PwuH0nvu82ACoG7VZfcFeLGAV
 6km8sykQVfC75syH8pwNR44vU24Z0N9fPPyYEOE5QvBMKEW2h2fIFJhQIqpd3DTWckPR
 nBphkaIdc6PTWnXCQuVlnmfIrms9qTuko5H+PxjZr5UPbNGguabViN0WJBazBmZVFGz7
 qhKP5PaWHqdFFrb68xnLn/ptVY0ZTPUcESgSkYx18+mIy9iHDpX55++w/0SSvNyU+reW
 7bQCS1uSc7JLV5gyKGI29Wa6YiiyW3agWXKdunB9tebEjmTquCU0Xz4ghdoxxXoe0b3z
 Houg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535797; x=1733140597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bIeqD+tgm9Gkr/VFzi9SNixE+TBzGIvSZpyuKOO9KU=;
 b=kIVjgh+TwSLP+zXLrnOIEz+EuGk2i2RKRTOimVO3yOpIqAMQ5AlyBllCQ7IAhtk9Jj
 3TAwhVeGI0Iq+aaA1USRMtyolOQOE1+z8tQfZGgvsax8wUnqX0tLNAlMTizDpNVFSduV
 9etrKWa6RxDYsyKZzfHcWbU5rIeNjeM95BuqXocphOmUqxwmihTfGGLQz05DOb9GOcG8
 cBy2zBFEKbCQTo6o7h1dxZeI8/mK0XjAd+9g1KYbCqd/ni3pjRcVlA0lpmI1o4ZqIpj7
 YyFoI/qJfr1fWRPAt3/jB3y6LuJKD7/WDgHLDZrBX3P4ZPCF3PunMcEsc9UXOlc3EBHc
 E4TQ==
X-Gm-Message-State: AOJu0YytKa2RZ7UNttAJHTLNPSPL70TmyZkDxrnolQoKRj3oo/i4aKCp
 5zmwJHWp/c8OWvYMYZ+IAKVP3JShxW52uFH7W3m7VDrx/eW/CTCBXGpPohRAojkUH9gugA/zeDd
 ZhghpeA==
X-Gm-Gg: ASbGncs5qzWIrOtVcP1bJseIt6Q78i17TjKPLlJ3yYEgAOicOWa8oSqqJ160fHnzfug
 PRaurwz4l5QwCKNCMwjAD/aJI8ZY9nzMzDmiq3GuJDGUUmQfGAs6PDFVpavUSn8id4NdRApdSgH
 xGHN2PhPM3sN8gCIoQzfR5unD2GxH1SOqR3+Q0qfXpf2IFNARl/QgEF3ROR/wtGqtjHvKeqynUk
 VAjT1HhtFm2ccTsH6O5dTJG4ss1pyzs2i2L2W5zRyb5dJTtVfFogKbOw+vMn2CTdzJNDQ==
X-Google-Smtp-Source: AGHT+IE6XGqoeXdvAIHZYhcfLuA0kXeTuQ7AJ5VV4zakf1bKQP9kxZ+DfI7SAffGlbE9V5Qri86Tqw==
X-Received: by 2002:a05:6000:2807:b0:382:44e0:c5e7 with SMTP id
 ffacd0b85a97d-38260b6b464mr7079622f8f.26.1732535797424; 
 Mon, 25 Nov 2024 03:56:37 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7b40:ce24:60a6:e419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm10139626f8f.53.2024.11.25.03.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 03:56:37 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Igor Prusov <ivprusov@salutedevices.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/4] sandbox: Correct guard around readq/writeq
Date: Mon, 25 Nov 2024 11:55:51 +0000
Message-Id: <20241125115554.1707080-2-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
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

In include/linux/io.h the declarations of ioread64 and iowrite64
which make use of readq/writeq are guarded with CONFIG_64BIT so
guard the sandbox declarations of readq and writeq also with
CONFIG_64BIT.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

(no changes since v3)

Changes in v3:
This is a new patch in the series at this point.

 arch/sandbox/include/asm/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 3d09170063..f656f361cd 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -39,13 +39,13 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define readb(addr) sandbox_read((const void *)addr, SB_SIZE_8)
 #define readw(addr) sandbox_read((const void *)addr, SB_SIZE_16)
 #define readl(addr) sandbox_read((const void *)addr, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_64BIT
 #define readq(addr) sandbox_read((const void *)addr, SB_SIZE_64)
 #endif
 #define writeb(v, addr) sandbox_write((void *)addr, v, SB_SIZE_8)
 #define writew(v, addr) sandbox_write((void *)addr, v, SB_SIZE_16)
 #define writel(v, addr) sandbox_write((void *)addr, v, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_64BIT
 #define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
 #endif
 
-- 
2.39.5

