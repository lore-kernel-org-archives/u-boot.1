Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EA9C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F094788348;
	Mon, 27 May 2024 19:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PzV3xaXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8923888167; Mon, 27 May 2024 19:12:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6889F88224
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a63036f2daaso1098666b.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716829934; x=1717434734; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vie2XlRXPYNDzkCg+RbgF81aGatbHX57xVfle/ZK7/8=;
 b=PzV3xaXc+z41en9+9FKuY+Q9Xt1z084WNwAmpk7lJCTUoL5ufiXM7fRq+ODN/Mupds
 W9FD1D/UY+TjSLWOlY9zFePMzEJ9NX5kZMKPzgXXqL4C+1cUYVg0qufYtcYFEaC5QJtp
 Jm2jy9m5e/VqTPK6dB6hcuFpqZXmC0KzzaqqthIrsutefU70yfQ2jANTBD3Llcp/bpfz
 jpl+nD+YEfiICzfOWDZKOJRMcQgrn4QPOAxjIg5g4dFcpNBGQj8hW4cnG/N+g2X/VdZz
 NQW2ExJt9zXmSGa/fXySvIY5LejTEuTqmPXdZryRuk7gLw/dRZt6KM06W/z9uAZcu1tM
 pAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829934; x=1717434734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vie2XlRXPYNDzkCg+RbgF81aGatbHX57xVfle/ZK7/8=;
 b=llSZWDpe7noa+m5KAT+fDRCCkvHLOVNvRESmE6Sq29s9zU4TYgG9ndtnamzc7Jzt0M
 XSTJHQLvK1zR5dC0Q57geEiI4zYNaYkuwYCmq1m2+PHQ9IheG69KwfiKhr3o6Qhix58a
 g9zqTq7vKAaXxRB94EFDo9AHoE0Gd/wh5RofBsrbRXD1V44ILzJ5ZMFWboMx+PVlXgl9
 SoHj1Z8MfAnNxcL4nhD57SP7XaHF1YJh9CsV/IH/FpNnSHZExMLltulWCoZkwK80BI+q
 fRoDgPomQ34PnsFQwZ11jPiqy+48enP/QmCs21VOUkveeAAuWZ8lqti3E1TCk04q+LOV
 AbhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl+Q/e4yora/8JrLT8CDCL6jVrPOHsnkvJdSmMPtU8fzBz0I7nSeDJT9g1PbU1zysAh9jlNCV0cIZbzYNRq+kmKJq5qQ==
X-Gm-Message-State: AOJu0YzVwHqzXLu4qVuqWAh1CCitBoXn62ihkCrrbfDwtelnr7O8M10n
 046/PUXLaCUmUUFNpPl6sVc40QhPA/xQxRAYzBlUgzwZgkePRXMlj8ooWFH2jdzy9wNV2mzBNg9
 nSH8drA==
X-Google-Smtp-Source: AGHT+IEZ3VQBm4kslhY2eCa1pzBsXOzVeVigzJhqBNXcCBQaSB/7bWfjnEIxRBTQGLQmrS4U2QNdjA==
X-Received: by 2002:a17:906:fcb7:b0:a59:c209:3e33 with SMTP id
 a640c23a62f3a-a62642daa9emr665539666b.15.1716829934607; 
 Mon, 27 May 2024 10:12:14 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda7cd3sm508009566b.216.2024.05.27.10.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:12:14 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:12:08 +0200
Subject: [PATCH v2 2/2] qcom_defconfig: enable stub clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-clk-stub-v2-2-29013855e343@linaro.org>
References: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
In-Reply-To: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=609;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3jbLgjTFX96+/h/GNL7n9rZTxvtZUEtwrjieI1Xxg6E=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVL7rj55nkDfov1GjIMI7AJOZy3rIvMZBNm1WY
 R6fFcwMB4GJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlS+6wAKCRAFgzErGV9k
 tjRrD/99lyvkIIjYhr+yuENX5vVkiBHXuaBvJxIoKAPlUqTX+p3YbTrkMJZllUjxO25ghiCqKGP
 /8SDZvZ8bALLZukWwo/+xWXf4Ituwg+gTGne+SBBslzffTtdsvWqLB9eqKHWJDd9mAhWzSFuI8q
 CKHCOSBcTmK9Llw89JBylrE7m+rrfyftUe08m3Fo2FmyqfAAVxuvMacdSS5zK4TX4sa6xVBshLG
 Ssccv2YsmL6YpG1c7w97mJbRjjqH8VC7zDnC0VzLOvfpvRdIuoQRjIiBjU5uEld6c7Gr8+keEsR
 uLKvcQJpk+r7HanTsxFp/Zb3wAowq0pOBaeRID3abTQJz29idlSu5ka3TYlIsmqW/NqJqOStnG1
 BSlef+NkfeJaYuA0CvQjHoFQ4PjYGSQExS7uS/q5lpwgIeOmD4zODSV5vjxVm7h97YTWH0+k7f7
 +RY91RcjBGL1pZI8Qd4BB0joKY/HSpFmWucM6AdvA4+835M59SeRWqKqBSPFIyNhbX6YexMC4L2
 uUt2lH9OwbGA0KN6be3n2JcELlUazoBoJAkvKVKo1CxxQNR9K8IhJy3UQFuo5x8Hd0j4oimWiW6
 b6p8ZOBY8Udv7UyERuVrCFC0D7KdYJFK/1OxyWC/W0F1rIjLuGVXvutFYnPYif4sX8SUZ3PRVKo
 WwKsX0toNjjQsUg==
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

Enable the stub clock driver for rpmcc

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 80ad3b32e139..65f13ae7a089 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -43,8 +43,9 @@ CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_STUB=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y

-- 
2.45.0

