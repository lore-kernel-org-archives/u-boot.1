Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF1C4707C
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 18:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28E8876F8;
	Mon, 15 Jan 2024 19:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PM5f8aod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F6987852; Mon, 15 Jan 2024 19:51:28 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBC787626
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 19:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3366ddd1eddso7448984f8f.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705344686; x=1705949486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p1N0BoW7E1W/RVT7zDsuIE1tGK/RlIGl6XW7xYLUJdI=;
 b=PM5f8aodaD77omVYJX89K7jH3MGWtp43ejS7H9dSBzhzDJaXUMN6UH4c19+EzS0FGc
 xhkIR74At2V9EvuyyPwGrnY4+7mf5DR2RhnGSlluiKEjfG+N0VS533/Y174rYhIuEHEG
 5ocr66LBtpZ50EhZauy8QjTBbx5LMS6LlSDfJu1GUYvrnYqksoAnGP91OeP6Evvc5qX2
 syor8CJEywe8XjITuuLKgyEjrkg5SLjbszHYcZ8vLUgUCPoJjBCPFGV+EXzsq/rX3X2d
 8qPNjEptvlOfZbKw1mDn5FKkQp6k3py6i7tPIqkj4cBoaIQg4yeYJMC7NWCoq0kXL9s4
 uwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705344686; x=1705949486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1N0BoW7E1W/RVT7zDsuIE1tGK/RlIGl6XW7xYLUJdI=;
 b=EnA91MNDSg5V7twc2gYLacDMcDk4ezTSr6+ztjuFRU/mwTkSmBxCt4pbjopUYmNcq2
 lFaRwboijNmj+YIhnwkS2gj9pjPjaBEk5T9TTz6foc6lF7m3QBohlPUNJCIXr+D2mbLi
 DNXO4oosR3NEBCmC1PrgMSZK5X1mbPJ+n9m7d2QHn6q5EuMSekZWoQ/hnss3Os+GoWEG
 SUigdOSUNdXW3RcXEhfctbZVL48ZtYJ4dVYjmC7rlVT2P1KbzAcL24oOsKkf5wcWrf7m
 XTwazMZaV05u9g+fy9TspkNMLtWM3ThZaQlM34UzNDzP1fflZnILK7MmHNgWuuMUFf78
 +JfA==
X-Gm-Message-State: AOJu0Yy+uvydpt3lIO1e8abf9v97t7FC2FqAa2Ab9ytM7ozWINYmSr13
 wn5zGYPGt6knUYkMDuYHbEihiMs0vie6TQ==
X-Google-Smtp-Source: AGHT+IEGsntu43GsMpZ/X4RQUa2b0Xk1y87OEQaH6YYOLFdyESSWhy0000yQjfEdTooou4Dm3Z+51Q==
X-Received: by 2002:a05:600c:4683:b0:40e:490f:3f31 with SMTP id
 p3-20020a05600c468300b0040e490f3f31mr1545711wmo.35.1705344686347; 
 Mon, 15 Jan 2024 10:51:26 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 hn33-20020a05600ca3a100b0040e621feca9sm15276689wmb.17.2024.01.15.10.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 10:51:26 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] sandbox_flattree: enable button support
Date: Mon, 15 Jan 2024 18:50:49 +0000
Message-ID: <20240115185122.776217-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.0
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

sandbox_flattree enables QCOM_PMIC_GPIO which now depends on BUTTON. As
a result the button tests now get run, but fail because the ADC and GPIO
button drivers aren't enabled.

Enable them to run the tests for sandbox_flattree.

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/sandbox_flattree_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 0b637727d9f1..ad364f6e128e 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -101,6 +101,9 @@ CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=1
 CONFIG_SYS_ATA_ALT_OFFSET=2
 CONFIG_SYS_ATA_IDE0_OFFSET=0
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_K210=y
-- 
2.43.0

