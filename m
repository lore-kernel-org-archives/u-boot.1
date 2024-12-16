Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF01AE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 18:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5949D80250;
	Mon, 16 Dec 2024 19:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ic5I7GcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED86800D2; Mon, 16 Dec 2024 19:07:57 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1891F800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43618283dedso43405585e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734372474; x=1734977274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bIeqD+tgm9Gkr/VFzi9SNixE+TBzGIvSZpyuKOO9KU=;
 b=ic5I7GcRV832TFwbBGSyPJBa7g6dE8lXIR8Df/aF5+GZ75jyiSTpxRN65a9c3Ikiwl
 F+H8KGB/qrnApy4JUMjg25ZIVcFCx7Gb5fwt/NUFfaXV7oxQIRy9K2fycd2417O/nzYs
 03lFHeU2TjWebaNO9q3ReDFb4FjmLyAyPdeM/6TFO855TYpTy1ae+zHNZaUTWleHjE1E
 qbzlZDTpzFJLrMF2SYSxThnaH4x06FcWJwEbTvjSdzu1cgN+xY+LCdnQXdStDqXrn0j9
 p+J/IQh1guFVXKVx1h+VBsseCpoYjmV6YQ8RrevbFImsgoTyOSEjKsNLmY4haKYS6HO8
 ZDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372474; x=1734977274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bIeqD+tgm9Gkr/VFzi9SNixE+TBzGIvSZpyuKOO9KU=;
 b=dgfotstuz+S0PNSd8r9/8+MIM+S9FdJ7VRNZg6mUlkJiS48wd1j7MRJAZXDo0vdjHh
 FsSSkHgzXUtppSxq7ngPUmEdEDQ7bhmQqBpsHDLDYtqFYVY18cDqf5tH1UX4b5hoZAo2
 umc8tlCLL8u751EHp6JKNu7sJ7tsFveAtOTOXDKx9Qn5rUAMbNizzLkUcwZ3dHQ+wQ+H
 NucRMDr/D9gvWJPe7LB4pvXT1k3X8zUhvZCwPZiecOXDqhjtKmuP+YCGsKE2YDct0gw9
 itIfMomoaGwjLMVuxcVjDvfkRg+2ank/RgIL0+1a8j+RjDsYaUFBwLRJT8CAhWfvWSIb
 ZJTg==
X-Gm-Message-State: AOJu0YxOnu6fxbiqdKhZd2iTxEbT+5iQWHfMajrTyXChkT9Cfxr6u/6W
 Dh00+KZYDV6fuK3SMTWRBAeKdyPiHJF21cPJwqpdMZoWfGEr86T9wXem2DyB4Ni5MZlIGVDqR2f
 ASgs=
X-Gm-Gg: ASbGncvJrVU/e15UZQ2OMmoOaK8vKHiW8mKEBcGO8BKSBojNLNsG/UnKcdXob7nsbwl
 Af9Lclqtfc0n3Ma/xp1pmE2XhD+ijuSmbvl8Y/ahibODCgDB/wVQ+mng+Uf89ZTGI7NZVt+23hE
 Ttw8wBZ1mKGVdgIWKvkZUQKST012Og2m7BTMhdCFUYMAsbZfuGcxoRlaMKIagoqZZ7dKczJ83g8
 mngtG8eL3kb0vgNUIqMSUuxg2EQ8chnm2tnSoum7DXkhz1JyHvbs2SYkB9+Qa2QwIyEQfypthPw
X-Google-Smtp-Source: AGHT+IGz2ZXOhg/FVxi3ININn/0qMWF6gXenBPAvGBCjISJMJZJMY0TXzmXjxt2JdFgQ+I/VB6fPhg==
X-Received: by 2002:a05:600c:cc9:b0:434:ffd7:6fd2 with SMTP id
 5b1f17b1804b1-4362aa26cdbmr119223065e9.7.1734372474607; 
 Mon, 16 Dec 2024 10:07:54 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:ee3:c001:477a:6a2a:86f6:a454])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436360154absm91501605e9.2.2024.12.16.10.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:07:54 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 1/4] sandbox: Correct guard around readq/writeq
Date: Mon, 16 Dec 2024 18:07:33 +0000
Message-Id: <20241216180736.1933807-2-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
References: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
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

