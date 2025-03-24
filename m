Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933CDC36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED5281D27;
	Mon, 24 Mar 2025 19:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v2/Uz5M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E65081CAF; Mon, 24 Mar 2025 19:17:54 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CB480F70
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913fdd0120so2595817f8f.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840272; x=1743445072; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wgeQlzf2UMeRgVquXBFZM4RClD8XUzadcxu7FOTANmc=;
 b=v2/Uz5M9Lz0Xn+C3OEz2Xd0sqYVAxYVHq2nCI/zRSkCmkysU900bUa/8/7H4pjO/4U
 rVOwA6ARH4DNDywKhmKoLyJ/qwje7QxTulQu7grtXloiZXxChH9bFXCi0QoVY6GQ9Mmp
 u5xtfUZVkQwwz3U4sbe8JBzmSMWJLoeLRwB6nRkX92SI1pviR00XzfpT4R6PlFJw42Th
 ncmbXoKGx8xvhfGGqxSQxmhUTPLOkcXxoKUbh2gz13tPO11Lhn1RXlNFUkAYRx82lKIt
 /iHbUd/JTQPEfjgf7vSlrEwRztFM4Da+K8OUrW4hknf437bNlLU2l5wo0FbJ+zd/wnW7
 7grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840272; x=1743445072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgeQlzf2UMeRgVquXBFZM4RClD8XUzadcxu7FOTANmc=;
 b=dLINSBZJpXcCCEZx0h6B74wUPMbO7N+BMu99LhJ6yxKU1pyPDnnZJoOCQ846GGwQ0D
 ZU+5UVCOQnOiHl/E9EzTjX/oMGP0MgO6p0RtcecUrVHvYhopLyOfZLxeNKPJOUGtXl/V
 pUS6P8gWpZatzJU+cH3yOS4c52wsyBajge0BCl0HJmSeGllVpOhYXXoff4kbVhehT1P7
 416X+nD7A6Nvoe4rysbuGVmA5JCsuQDqAV5Lngqsu8Blav5yu1ArYKmmMY89x4IUQMSQ
 tWNTVWjWRQXhmnmXKfnSiHCFMSPx09yJbRlBKGC2hfIkC2QwHJzaxuGvVCR9SKMq+W7L
 D9Eg==
X-Gm-Message-State: AOJu0YyH70l/eK+uzhPkysvmtrHhiif+f3Sr5Bj6RtTIv9d/boB+oWZw
 mm8q9B+AzcWScGLalbey7wSif0KQQlJsFq8mPtSZeIL/VN8USbhXVsFdaXwG9+E=
X-Gm-Gg: ASbGnct3QbbQRkWdLQT0hr5N8HC0Sw4T+qQZO0+SsQ0uAzaWbV+GblliBjzMuc6mR+y
 qEXy4gvccO2WM4poJzcNbXZdMGTAXJl3YUsKETpjtkPOkTbTbOvP3fBLZuBE97Jbn3+rlkf7M1l
 j2ywU40RD1r8iQC1QymUGKB7HfGJhZabdUrK4OVDgMHZ0AtgXE9sbSJiZ27ljIgJrK1ijK79tu8
 JfRhpH06JoTByXRjhx4UpQKPi6cO9ya+CjN/b4DxirZwYssXVq8RqHgIQ3FC7aWRA4GOxl3NjI5
 5j3YwfgKkmAXNWro8LO6ge9tBVNiHBUXK4NuDtHMXsscmcCS8s/WXV2NlOUl+L8bpkUvVvVpITC
 t1VcmfXcV4nyZ
X-Google-Smtp-Source: AGHT+IEiBTWYuK6l4vgyPekpnK5ww4Gd4B0ZVaowNaRnV5swK7uig4Wm+Z3m35pauQ7Me/ePr0TShA==
X-Received: by 2002:a5d:47ca:0:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-3997f8fed43mr12843031f8f.18.1742840271948; 
 Mon, 24 Mar 2025 11:17:51 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6450sm11690651f8f.70.2025.03.24.11.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:17:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 24 Mar 2025 19:17:39 +0100
Subject: [PATCH 3/4] mach-snapdragon: enable DM_USB_GADGET by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sdm845-fixes-fastboot-v1-3-d177a10f336d@linaro.org>
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vnPWnise6vpMPcwWHuiMP1a+zy41QpwJzJS0YP5Ac3E=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4aHIMb9HnlqO4VhqfMeFks+buVXAuEDk37Sma
 qZo8ox364aJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+GhyAAKCRAFgzErGV9k
 thZ9D/sGBIdfj72u20gl5nmheHB+K7hTKoJQplODE2PTtDPo4gdE2Uzwn++WVa1Qm67FA2jDqLu
 tg8hn3OyPZt/iug7cw1CuC73rwZm3+FHVzPfF3ZAjJv+W3JF4nvn7iEGSifP92712HPmdZixp7Y
 5PgcRVpeqysiXtIFqtczEvGFRFmkfgwQsYzG95MwxRmgEELAEBPuVWo4F3rJULJpPwJEF2BPdoC
 JiamEhtN++Bw5hcldbmKhjN+E224W7RLbxkJqlpW2afLsfKVgKc2nHO8jx59ZjHN9q8aW5fZyMt
 RKlwy73m5Z+Kuqk+G46ED2fhPF1W1UNyGfKxb1HMHTxhkY1mYT52P4NHot3UWEysr3gebnsw/yn
 R5qYnLfi3ddhXJ5sc1k9rsUrGoOV8dH8Zrh5A0bxy3YMkcr3x8yW5oGbpsDwI/j4uhFur0vb8/q
 K6L/NfFPmwv7GnMVpH9xpiVBOstSzXm4a64/vJDq0cSDutIraJaXQu+DFoJUTOfqlTauTVP0Syt
 trly0MiyoiHzLlpwRm5XbZNRQDA9wfzg3L1akI1qly/CYuZqpr7WxYFcHdXF0toNBDs0pEHgPLM
 8u0vFG92/d2q40NfopaPpoOUMgEaygm7JkcM4+CEGxJD62EqYJmDT/vRBpP2fBA38caLlK2/AKr
 n3EDcm69kgfj11Q==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This is required for gadget modes to work on most platforms. It must be
disabled for dragonboard410c since that doesn't use dwc3. USB on other
MSM8916 platforms isn't supported by qcom_defconfig anyway.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                  | 1 +
 configs/dragonboard410c_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32b80da9869a1647b7b295d3070964fa11f4fc65..63aefeda9575fec8fc57194358df0819397d088e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1120,8 +1120,9 @@ config ARCH_SNAPDRAGON
 	select SYSRESET
 	select SYSRESET_PSCI
 	imply OF_UPSTREAM
 	imply CMD_DM
+	imply DM_USB_GADGET
 
 config ARCH_SOCFPGA
 	bool "Altera SOCFPGA family"
 	select ARCH_EARLY_INIT_R
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 967817f4f58e901fc827b4ed991ddd61d1167efa..5870aae83b4fc8d6897eb0f18cc4eb153d299c11 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -59,8 +59,9 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
 CONFIG_SPMI_MSM=y
 CONFIG_USB=y
+# CONFIG_DM_USB_GADGET is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y

-- 
2.49.0

