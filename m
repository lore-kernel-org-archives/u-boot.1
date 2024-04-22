Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E6AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C1688421;
	Mon, 22 Apr 2024 13:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="u46laKLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1361C88425; Mon, 22 Apr 2024 13:44:05 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A6F388379
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so3210369f8f.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713786242; x=1714391042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ua3HZjCvGgqW+TLHcRKVX1mFtSngd+vLkTiEqibrhwo=;
 b=u46laKLE0qCUpyFqTtUpEkUnsScNjIkzpQbDo5YMH8FgrBrUnT6i586ROGVV0LaeiD
 3QvbQo/3QsiXzDf3wAbGHldNPqqBzCAhnA+lFQHgozz07SAkVAw2+J4v4T4OlXdpm2JE
 FrVH8q/ZpzsfGnUMW3t6LL1brxJ2bxd/yYE0ROgjhXxmoTBHOMQQCDpZfuTYPBebkZ3V
 KxknydxEuAhUfvvq6oy6+IO0HnyWG1blmnkakxY7/oqW1NL3q1vYlydll/N5xVKpzkNA
 nv7Eao49QcZAp9SvjcQ/oaW1N9QciFdTY4+ZnJuGe9DbOB80G+Nhp9SGzSOYIzLrgWH+
 HQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713786242; x=1714391042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ua3HZjCvGgqW+TLHcRKVX1mFtSngd+vLkTiEqibrhwo=;
 b=WR/qqzoI2A8l2OeqNppuN2gYSJPSFDHDvBv2daztQY6Xd5L8dXZUw0TgNLjIkbPC0m
 AINilxCpgE1mrM1Nu+Fb5EgQzndi/mg+REko3CjvtpuMKuGfCh1WdNqGaQkQPnF8143E
 JbbHymFpUbNdmfYbMiSjYIMVJPGV2yH7mDI5hqtDeiViKoPOZp5Lq2la7Fn0UXamFc79
 NOLd/VXV1uq1F51zVHu05XeOdCfL2R2NHLX5fk61iFozZVmIIjs10oQKaG9cPXnmpoLk
 sy/yu6WndzelAMzXcyKQ0wGjnHu/FgweJTjVJWkTtDv0eSRd4Xo8TDtG4xAmxYCmGycw
 L9Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzmf0ZP7q2wPwrRqLS3fkeoOj1ZR0A2orK+IfGsiFhnS9pY7ggYQWAljbGZDMrrOsWjQqcpWdIZwBwwOwtjjIUTXOV5w==
X-Gm-Message-State: AOJu0YxaQnw7j/wSc32FKhgMhI3JbH+0VAWSFyOmZtpPuptfVSM1BH31
 8JPXTnkmCezbVuOwjfj1Id/x3EMaSpczC5k0Gkw0nxokYklFxR0y+NbPoSXHvDw=
X-Google-Smtp-Source: AGHT+IHJVwv0LiANG7krI0W6xcPGjeFHF4wrtpXwDNJCxCy7Hq3R/9hy+iavelms6ZF/edIz5FrWsg==
X-Received: by 2002:adf:e842:0:b0:343:facf:228a with SMTP id
 d2-20020adfe842000000b00343facf228amr5979947wrn.19.1713786242135; 
 Mon, 22 Apr 2024 04:44:02 -0700 (PDT)
Received: from fedora.. (dh207-14-170.xnet.hr. [88.207.14.170])
 by smtp.googlemail.com with ESMTPSA id
 e5-20020adfe385000000b003455e5d2569sm12022977wrm.0.2024.04.22.04.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 04:44:01 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/5] pinctrl: qcom: allow selecting with ARCH_IPQ40XX
Date: Mon, 22 Apr 2024 13:43:24 +0200
Message-ID: <20240422114359.219762-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

IPQ4019 pinctrl driver was moved to the dedicated Qualcomm pinctrl
directory, but the KConfig depends on ARCH_SNAPDRAGON only and thus
PINCTRL_QCOM_IPQ4019 cannot be selected when ARCH_IPQ40XX is used.

Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq40xx")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2fe6398147..bd2019c866 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_SNAPDRAGON
+if ARCH_SNAPDRAGON || ARCH_IPQ40XX
 
 config PINCTRL_QCOM
 	depends on PINCTRL_GENERIC
-- 
2.44.0

