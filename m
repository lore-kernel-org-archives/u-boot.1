Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2970C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 20:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DCF0805C3;
	Tue,  4 Mar 2025 21:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WgagzbSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794DF807D9; Tue,  4 Mar 2025 21:32:42 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C73800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 21:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e589c258663so6484613276.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 12:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741120359; x=1741725159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4jc42Buvv09JAiEZ/ZEouJf9XcmkEsE3KF0Iny476c=;
 b=WgagzbSxIU7BUKlDvLcFY9LjXn5oRtHxo5i3ag4LYI2x0dTanWyrux/xCJsSR11JhT
 NfKych0L/I0VpsgLgFfJMH2Udx1PQW7zqqWi+aLl4rcr1+IzX+lGL7vd3srIJzWa5ITu
 4GCqD1d4yfqLnNDRQbPNIXZhjgqnGmGlCkwYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741120359; x=1741725159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4jc42Buvv09JAiEZ/ZEouJf9XcmkEsE3KF0Iny476c=;
 b=Fr6/CCpqHra6DRcA/375bI+5qvnHkOXAUS8fN7q/xU+s8Lz6vZ/02VBwpa0EGbhhFh
 QOPwZnXbPVyWrGnZui+Mesc2s56oUKlp3lbCXe+gQmwsvqA3BZDuWRgOyluFmlPw+tgI
 owAUUNofypY0TUmsE3zk9dJafFtNxwX7Dp8jjsromx4NQHlCP5rLXtxPgb1kdXcagLLt
 Wq2qPajTuzdH/uXVRJo8FmG0m6l8EJoaRJO6ak/OnBFA8jyiOzXfoI1sf/WSk06LXXd9
 ja4q7a0eNdmneFRRO9t/pNnmgo0uY/vVaABffmNtMOxeN1HebC8dpBAW5N3I3IcZ9Z/+
 FJcg==
X-Gm-Message-State: AOJu0Ywzn3wrmae/mxL0OMeNiKsIVTAPtkc9VVNJNslJ2eItxakY+CXg
 7uL8kP+cFEclXebRRZj9OnIFXRjkJAMDqlspU5D/2jvJg9SKIQhyoQT8cAJcmsowZuJSRBH8jR2
 P
X-Gm-Gg: ASbGnct6sYlZm+OpbPdC+QdEixZ+nTwgmbV2GZaacLLCBJ7AdVo0HxrFEC10TcMJZJB
 aQhH025l/Q5HGnbLtIXsq2C+YXg/3SQZujaYYzHM5B/8h760xCtodC9dQjqq+X/yEqeYJJ/il5p
 8m6MgmC9GgmgBGeANsbIT/QwwwXiBqLx+X0/B6a7Pq4BQcF8kbiainVCgPJ8kWwRQrjl0VNbpw+
 96ab75RDnRZX7C4TOcDLnff50tZ0bBpbnWgXTG+wGXhDk5NfjDP0QdctkJyedPzyhjSvJwvwYcu
 p5tKXb4MZzIkvo2WwuJ8QiP6tb+iFE+XjS4GNZP0nj3WEA==
X-Google-Smtp-Source: AGHT+IFxI4Go8bUayCwmAvRc5pL8MGc/SveQJTYMPpLr5Hrexbq6lKzUvqqYhsioz3vvEP/uVXJI2Q==
X-Received: by 2002:a05:6902:114f:b0:e5b:411a:a824 with SMTP id
 3f1490d57ef6-e611e178440mr1067863276.8.1741120357682; 
 Tue, 04 Mar 2025 12:32:37 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e611b798a53sm220145276.45.2025.03.04.12.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 12:32:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] sandbox_vpl: Enable missing TPL_DM_I2C symbol
Date: Tue,  4 Mar 2025 14:32:35 -0600
Message-ID: <20250304203235.2834031-1-trini@konsulko.com>
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

Currently this platform implicity builds CONFIG_TPL_DM_I2C support
without setting the symbol. Add it for clarity.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

 configs/sandbox_vpl_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index f0315f6ab33f..93a6dd725bfe 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -149,6 +149,7 @@ CONFIG_SPL_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_SANDBOX_GPIO=y
+CONFIG_TPL_DM_I2C=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_DM_I2C_GPIO=y
-- 
2.43.0

