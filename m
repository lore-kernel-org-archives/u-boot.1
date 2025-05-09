Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2886DC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAF18211F;
	Fri,  9 May 2025 09:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cS+Y0485";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BFE8212F; Fri,  9 May 2025 09:03:19 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B648210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so1539990a12.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774196; x=1747378996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rrnqO1PcmSsEx5X5C4JBpKRne+7TmvU4oiR4j7CnMys=;
 b=cS+Y0485fy/++eEifxTmPbIurYR/ZccvwszkaJoV4kO4eDrQ7CLuRedcmjFsgAI5Fo
 TsXwwTnNhKOebIcmsamyRaJGzuVZhfrjo0IMhxFd93VsWyuA/bTJoh818c7XF6prx/1o
 0uqGlSJy4b4qH0o9qj2tWbZSSsenWQrOsRJWZRSg8MUD1CJRzrf5M9tDGEM+6M+kFYp2
 /pt8QSb46swq5ajqEoHGLpYjkr3139ciigFccTSjDDxWHw64vbnk44+aqshwGTjmYLjs
 +2KP7CFdwYw9eWb5LhaDNNSVKzCg1zq+ZfnJOOlP9WHrG3HY+dDOi3MTXSdNtbmaf1mt
 2CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774196; x=1747378996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrnqO1PcmSsEx5X5C4JBpKRne+7TmvU4oiR4j7CnMys=;
 b=T5HI8QO68SJZUeN27bRxqOs40Q/d3jkUGvGl6zEsy1j9F6+ZHb9BcxIlg69AyBN1D4
 VCw45WjI7nCNPeYt/7NscriUTjvec69B7SGYZzMXYHIP1a2q2hczriyeJZPRybkO2SGw
 3x6lwlg4lm8sPwPYgr4otKKP7nP9CbYKh3FU2upwpE/x4mtrlmNCwjNdgM7gYFE91zZR
 tq3irqfBMgn7ybXCKjpII7qR4cONwBP8Rcbbrp+D639Zm/nWyzOlEIDQEVBSGA6Ug2Vd
 zM99ntAs0jkMJcidzNkcJc/KC470Nnmlz3YmRZiOZ7xvKM/z5zm6Cgy34558NDF91F2V
 U4XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL+7sqKAivRYIgd1eMyN8Ufy4C0UlMa21pboiidu/mGqUcXbd/dULYc6LDWiq6YlCfyXaH1Ow=@lists.denx.de
X-Gm-Message-State: AOJu0YylHLHv/+Wpq5NUxfv6Jp4IxFMB8o/YsV8n+TSnX7pX8VG+INGk
 si2u7CcgcTjFbi73S+e3+M1hKHWocx+zwtp9UOQ48aI7gFCLs6iB
X-Gm-Gg: ASbGncuObSVQf1X+9Vwyq+D2NAz4C/q5MlXYXyLFNWJ2RhrqGL6X/rPvbKMC9DNRP9s
 P2rLMolQ0Zdfo7jnruk8OFluoRBC4sPqnb/uYWURJ6fKbviVD6sgDW+1tvTo026Vzjdyhf7j7jj
 pS5uzSqVJF2oP9GfH0tBSGsT1SSlrdbaXAqk5OP2MzgzgkhsFpyJslCTqc2jywFjo3Q3ao8K95n
 E+t/DHKLFvf5RWigIquvKs6GbbMGRKeIThQkXoyIQJhxHJfPUZyRafOQ1LlWPTmYLjHDmVX8hG6
 6O+W12Xwd2zm3g5yHHYBjlvbVeOrZjdR2r4abmMm0Qs8XxXAfMg4
X-Google-Smtp-Source: AGHT+IHMqI/Ij42tnHEvtNvfyRy0NK3CpXcQbgvVYelys9Z/7cTY9G4V3b5lpwBe43XQjB26yzRj9Q==
X-Received: by 2002:a17:90b:1a89:b0:305:2d68:8d57 with SMTP id
 98e67ed59e1d1-30c3cc11062mr3691077a91.5.1746774193508; 
 Fri, 09 May 2025 00:03:13 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:03:12 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de (open list),
 u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 0/7] common: usb_onboard_hub: Add support for Odroid onboard
 USB hub reset
Date: Fri,  9 May 2025 12:32:05 +0530
Message-ID: <20250509070258.5077-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Odroid C1+/C2/C4/N2/N2-plus devices have an onboard USB hub
controlled by a reset GPIO pin. Adds changes to the onboard USB hub
driver to perform a proper reset of the USB hub.

Added conditional compilation for I2C initialization based
on CONFIG_DM_I2C for failed to compile.

Thanks
-Anand

Anand Moon (7):
  usb: onboard-hub: Add support for Genesys GL852G hub
  configs: odorid-c2: Enable Onboard HUB driver
  usb: onboard-hub: Add support for Genesys GL853G
  configs: odorid-n2: Enable Oboard HUB driver
  usb: onboard-hub: Add support for VL817 USB hub
  configs: odorid-c4: Enable Oboard HUB driver
  usb: onboard-hub: Add conditional compilation for I2C initialization

 common/usb_onboard_hub.c    | 28 ++++++++++++++++++++++++++++
 configs/odroid-c2_defconfig |  1 +
 configs/odroid-c4_defconfig |  1 +
 configs/odroid-n2_defconfig |  1 +
 4 files changed, 31 insertions(+)


base-commit: 48db49b0977cc1c9c9abf82c0fb704238fcef4fd
-- 
2.49.0

