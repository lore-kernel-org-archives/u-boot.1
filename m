Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBCAC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB2D837E4;
	Thu, 24 Jul 2025 11:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PAyZUo5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD1583666; Thu, 24 Jul 2025 11:03:04 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F61836D2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso4792665e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347781; x=1753952581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hu8Mcop5oHsyYfnc05G9Dt9IKwWmHTSu5i1lxRHuwao=;
 b=PAyZUo5T1iAy3h9y9fdDEpkDdNDIbiCgXFkzNLRZRxFOTFS8/dewEXsqhe6xJW7+5V
 8YRiI/0V2Cqxu6gffFjivGW7ya1twlmkj3BqwVxDdaDGpunFz+s86t7VRuhXe7RgYhNC
 ztLsruYay7TQRqoSBaG/HeBIi9oO/Lo7XQYAGI1Btdd8NITDqT9Thr9+1VVed0aCZkZ0
 9Nvl8wG13x2lzc6ADmQw1QY+ZVQ2VFU+6+slFs+pUBdz/kfYj47AJ7ZeEGQ8eVS4DBjJ
 UZIb/mS5Xq5CubfFmF/ge+xblSK3i1aEECMgziggFlPhEzAAL7QixMBpc4F3SKroAIAR
 Ntaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347781; x=1753952581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu8Mcop5oHsyYfnc05G9Dt9IKwWmHTSu5i1lxRHuwao=;
 b=fxtvvIYMcZ3s0gqq+p0Xi2IWrsbryieLyQ6ownLQv/nx6L5FJCazS9a6i5CBctC+cN
 BVDN8+wGUdz5fB5EU9pOMFNUtsVXLBk0rmRrFeQakdb9jBecvgsrQeIx3/EVJGwfCH+y
 xTnaQlh2b2ZcFpfaMUMzMHYtZBWGb2V2EyPz2VziStgH1aXsR70MaAdwlp/U5lSzL0mD
 pAD/Tr3+/hMEUyNrOANZDIVgbUuS3eBG8NQUMXl7j+Bp04hkjekBvCZPAt+r23Ch8tYH
 sqzY7Wfzub/N8qfLUQMfvhffMw/qvMHSpPAg6YP0LY6Zc+mbFGy+Bv2cgOpsUxmzchtA
 2trQ==
X-Gm-Message-State: AOJu0YwGNzva0N3cq47+kC3SM+ft/TFfmHvdw6+BUU7X4isxij65ydaW
 RIWEcyjo6t/DgPv1A8L6KJ1fnOjJ2gPv7pEoUZTH4dyEHPgu+SJIG7slsGcG9w1rG2V/6KbEUZJ
 0+2mxaYQXsQ==
X-Gm-Gg: ASbGncsUjZvW0ibmu5LSztaV3V3VNOFmEikNaXtVke9I/S2D84qOtzysOQMH2RwI2H/
 gB9QmAEJ5MllTeH4CY7SbfgJczJQmxkPdmxSYLyfjOU+qLV+sNFKKsUDeM8pb5EBpPQTBsEP1ng
 7FvXHpc6MXjEz7VMgEnkxN4yZIX0DhJ7+NVXhEVwJslESSZO/H3MfNdYe5+EJLLA1IR4braTbDE
 ouuuidd3swUkHnm1YTzWVRPlNge35ft0pHLuqZImsVn5pzZEmRy9llJs81qyWD62CWqub2uCWqf
 l/8ysyWdf3V/v7LfJmm8uxq+PELLG+U+y1iGLBj+qpjAbnzed+oQRDWJq+K777ZXF/QyoqTIRj/
 99coa8cihwG+5vvTGil/sVq9LLiV6lA==
X-Google-Smtp-Source: AGHT+IFhw2lcjk3/WD7TJAN5sGpr1VgFIoyyNrs+sPgnXuEYqZOV7NBjA46TJkRcTnQmadTUEM3TGA==
X-Received: by 2002:a05:600c:a012:b0:456:1006:5415 with SMTP id
 5b1f17b1804b1-45868c91401mr47309755e9.6.1753347781116; 
 Thu, 24 Jul 2025 02:03:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870577af8sm11958715e9.32.2025.07.24.02.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:03:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] binman: bintool: use apt-get instead of apt
Date: Thu, 24 Jul 2025 11:02:35 +0200
Message-ID: <20250724090247.59221-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724090247.59221-1-jerome.forissier@linaro.org>
References: <20250724090247.59221-1-jerome.forissier@linaro.org>
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

The 'apt' command is not meant to be used in scripts or tools. Please
see the man page [1] for details. Therefore, use 'apt-get' instead.
This avoids the following warning:

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

[1] https://manpages.debian.org/bookworm/apt/apt.8.en.html#SCRIPT_USAGE_AND_DIFFERENCES_FROM_OTHER_APT_TOOLS

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 tools/binman/bintool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 81872db377f..f46bb52a7b3 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -421,7 +421,7 @@ class Bintool:
         Returns:
             True, assuming it completes without error
         """
-        args = ['sudo', 'apt', 'install', '-y', package]
+        args = ['sudo', 'apt-get', 'install', '-y', package]
         print('- %s' % ' '.join(args))
         tools.run(*args)
         return True
-- 
2.43.0

