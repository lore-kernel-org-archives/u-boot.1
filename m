Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E76E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 06:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1133F893A7;
	Mon,  9 Dec 2024 07:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOJ968uN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3014895A7; Mon,  9 Dec 2024 07:44:35 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8698939E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 07:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53f22fd6887so1285506e87.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 22:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733726673; x=1734331473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bzYV8lcdYv11PVFDPoa3UpY/uWNf7zUVurbtZWCwojM=;
 b=bOJ968uNwDRV/+6UFps1bsfHY3gQGgNV/Nlx2eKWfhmrAU+sHR0+s8sKhDkIjLH7Rv
 QGic2MG47u6FYFLY0plt6XPa7BBF82y7BXX5DoZBuhjcOfahzHOpXv1sbglZflyqUtmo
 1ns1XEoJeJmDQ+6HUKcWXOZ6eGkYIzP8AxuUpDS8EWMvwRg0gOaQxF2ngEKLF9zEVATl
 mGTSovxKdBLDrBeP0pGJwXzksu6TASN+q5MDIKD2qn4KpSZyd2z+hcOql9F28XFAohJw
 wMRYvrwmHdq0mWqXOALm13niEqxboVCIL1IFlT996PB9rRUpcxwIHVxdIMx3BppD8aej
 4WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726673; x=1734331473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzYV8lcdYv11PVFDPoa3UpY/uWNf7zUVurbtZWCwojM=;
 b=iqCREFq/W/c0PpnT0uaxGOF0TXypk0myxK0CLLuaPMjgPpjiAjkoyJ4CxxpLMGsvpk
 F3ZTC7en9RdOBaHFVmhiYKvvtoxUZPbu+I5gIUeOOWjMTYq5BtrjPEyu3qvFeIYYBKNm
 R9Qtyw3ZkfWwqdWkFbP40QAz52sExJ9rAvD9OtiadOreHTCCXWQaQror+NXUGct0e9ZM
 Cr2FbMxKKCAxrXwBch5TsSuLgDUGh7g/BJVLkTlSsHbVbI0AXVsd+hQoJJMyjqaH3q1x
 a1p0RiX6ntT2Q17zikA0FVcWXIm9CO9y4ggNWzZtXQFQTSIXvt67tq+Ai8cMU8FjUSrN
 9L3A==
X-Gm-Message-State: AOJu0Ywb65gaPK46+nFlxXwAMtble7kofttuhyb3uzg8nzpJUDXqRHfW
 xwk7lV8MF3CPXarsj3uEiviJyVdHMAa3h/Qo0rCJfnumgqMHSdrY
X-Gm-Gg: ASbGncusrCmrnqAtN014gpd3PqMb+eBRtsS4qslNx9J0NCAdkmeKQdnErxyeQPsav6Z
 pSbeOYzUc6s3lPogJ6b+09QnthVC2eWuaVcsomXIFamne0m/SoPJUu/qNqkHkTO91d1uBq9cxHy
 v40cblACsa6pYRfIG1wDPNYW1vTB1A/2jmFpKpBRiuOpMClXGX8xnQn8pBAlaA9Jhdpqd5kJWKJ
 q2wrwp22Dk6at2AxBk8icxdDJJBSJKStD7NOVaB
X-Google-Smtp-Source: AGHT+IGuKFLesa8kwWI7/804RnB89WSOQHp4eiu0HQlOz+y9ImzDPwfqb7DX5/+VNlfsSspA3ln++g==
X-Received: by 2002:ac2:4e0c:0:b0:53e:1c89:1bad with SMTP id
 2adb3069b0e04-53e2c2b6f22mr3957455e87.19.1733726672920; 
 Sun, 08 Dec 2024 22:44:32 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e313bfb40sm951527e87.222.2024.12.08.22.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 22:44:32 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/2] GPIO: improve and fix pmic gpios behavior
Date: Mon,  9 Dec 2024 08:44:10 +0200
Message-ID: <20241209064413.6282-1-clamor95@gmail.com>
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

First patch makes support of PMIC GPIO children with no dedicated
GPIO node simpler (just add select PMIC_GPIO to PMIC GPIO driver)

Second fixes getting device if correct one was found among PMIC
children.

---
Changes from v1
- dropped the prompt text
- changed the help to star with "Select this option ..."
---

Svyatoslav Ryhel (2):
  gpio: add PMIC_GPIO Kconfig option
  gpio: fix request of PMIC GPIO child

 drivers/gpio/Kconfig       |  8 ++++++++
 drivers/gpio/gpio-uclass.c | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0

