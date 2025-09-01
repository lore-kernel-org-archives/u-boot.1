Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13815CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA7683A13;
	Mon,  1 Sep 2025 19:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b5Jmr4BE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D39583990; Mon,  1 Sep 2025 19:48:05 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F5A83990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 19:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-544bd485420so335475e0c.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756748881; x=1757353681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EafLMbEkLM/zahQku3M0Wk0FyM36qwWWXx5zP0f9ySM=;
 b=b5Jmr4BEmjNDEJhunMJKHMt1FvLTtNWJC42ymUtm50tHFJzC8lnxKoJYdcbj00mEQZ
 fllM5C7u0PFqKwtxOd4Kv/fOnW8SPIIDPpfjFAV+iz2TkDV0mUXLFNrm5u/IOx++AMY3
 J/xS/DIRqXdqqlukvfFaQQ2VmDWiCQveELrdQMDW6dNHPc4DFBePUcjUp+DoSpRrHu1A
 /EIV2fAJZypdANWXK2HGHnCaMytosMhYkUrVbS5hrKzjZjUbMZZPHzkhS3dGqPlktznC
 J+ZztcV8MzQVuCxpqvB+/F59S52Lz/oRgJ1C6LW4wAVvmT0kK5niIRGQzvOV2oXWdYcd
 R80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756748881; x=1757353681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EafLMbEkLM/zahQku3M0Wk0FyM36qwWWXx5zP0f9ySM=;
 b=wCeOKYGKobgeDf46GJgldWBHiMw7NEY82yfxRZ2BTW+HZUplCVyQtp73uQbbwF02Qn
 7glYHQASTN6VXhqb6J7Lx0yEjVITs7JTTh9aA1FsBVfa44cscNfkd7FjPGpR1hltf/Ku
 nS0l6wD1hNjD/GnExEiss4oSTrR5RqwghSHYgrHtCyS0MXbU2evvuLQkQnroc2r0f5TN
 JePuwAFlLpaMUJg9UyrFjNHySpgYC9qHKIeu7NRURmdp/f0Zl6+ooQdhZcN+W7IfXK+i
 hB6TGNlwi/yKrXTjI8u3Y3LU86vkHgkS7Y0B2uZhQJfQyrIO53kO9Yn1zSp58LY8bIdf
 ACQQ==
X-Gm-Message-State: AOJu0YxmBF+NAcLqa9ZvRiPL53BWUwvRa/OHoG0FbNZbP/SzQwsY3Zrt
 tsBM7lUhU30L5/ArJrKfTwZbtykhL7A5M+0QnWufPUsUJHbE9T+knl7uvEbtQ3Fc3mUbhZSLuu0
 bE22T
X-Gm-Gg: ASbGnct6b+DmrXbjFtphQYVP81jd/PuhQpoyd+WxjR/Fvmr3g1fIHpUxEIqkvujnj7b
 FnvlkQzKzOj4zrUJw7mGulCD/ZVb4/0FfE6kXnDkRV/fSsi20sJ/nc/4LJ7ZGYL1IHnO6IaIW2a
 88ddoU2Kx7gW4ZDzPYZyh9QlyYAO6n2LxivIOG4XEGoU8UlCGYZSDcYPhxNpqL+zJRZuCm2N87R
 +mnmoJ56dry+weeFXvDSDsr3Fh93TzxdPrTc5v3MA8AZDUDcQt2gNiCofOVFNIWKtg+fRVjzMkf
 S5Oi7zxH6cAbgisSv6avXppxjBQGwn/WkMzhaYkKYcql4bg3+bU48OKLMpY8ccvUFqrtJ+ZY1gx
 9fzfraGD2P0T7fPJq2pSGz6OKuDzLFu0ZYTZ+Tgq+yqc1QV04
X-Google-Smtp-Source: AGHT+IEdmz3WjLqabqNWt2VURgKHfW0zMhojvze1XXXLi5HuTk1WeAoZw8Vwi/1iMSaY4EtWSSrY2Q==
X-Received: by 2002:a05:6122:a1f:b0:53c:6d68:1cd0 with SMTP id
 71dfb90a1353d-544a02e1a0bmr2163571e0c.14.1756748881171; 
 Mon, 01 Sep 2025 10:48:01 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54491464aebsm4670495e0c.14.2025.09.01.10.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:48:00 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 v2 2/4] tools: zynqmp_psu_init_minimize.sh: Switch to
 clang-format
Date: Mon,  1 Sep 2025 11:47:53 -0600
Message-ID: <20250901174757.166162-3-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901174757.166162-1-javier.tia@linaro.org>
References: <20250901174757.166162-1-javier.tia@linaro.org>
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

Replace the use of scripts/Lindent with clang-format in
zynqmp_psu_init_minimize.sh. This change is made to align with the rest
of the codebase that uses clang-format for code formatting. This ensures
consistency across all scripts in terms of code style and formatting.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 tools/zynqmp_psu_init_minimize.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/zynqmp_psu_init_minimize.sh b/tools/zynqmp_psu_init_minimize.sh
index 5c8b73703bf..f8b729ebc97 100755
--- a/tools/zynqmp_psu_init_minimize.sh
+++ b/tools/zynqmp_psu_init_minimize.sh
@@ -82,7 +82,7 @@ for i in $FUNCS_TO_REMOVE; do
 sed -i "/$i/,/^}$/d" ${OUT}
 done
 
-scripts/Lindent ${OUT}
+clang-format -i -style=file ${OUT}
 
 # Prepend 'static' to internal functions
 sed -i 's/^.*data(void)$/static &/g' ${OUT}
-- 
2.51.0

