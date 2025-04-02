Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C67C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 22:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173F881DE3;
	Thu,  3 Apr 2025 00:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="izMOucAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2FE81F44; Wed,  2 Apr 2025 23:00:32 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC3B81E6C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 23:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so949325e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743627629; x=1744232429;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQjTGM4AZy26Cg/Z6mPWpaBicyCyJz3n7hNL5yj0q+4=;
 b=izMOucAMp7Bt7xnA1xFsLDSEIknmjmehD3mJliAHdPJhs5jpxu4n6CLDNq4K8pTNCG
 VmBBQzFxOe6fEpO837ggvtJHi2DEIwuZoBIzMbrglZuDZsJtSinG9n0Tv0DMjsIkfiEu
 6f4qPKeVOu/UY7oR8t94bT3ee58AJ2Swcl59deDqY/j86L8e8Qqhq//RZkxSLrsxNOWh
 NpHMBxeJNRH8z04rjMWuN2X33VQdflWHNEU7IaN3Dng7Q0rPStyT+ZktrncPu1VlfsuK
 nUQ8xt4VuHLX2My1q1/l1NzDUlFSKEjwME1+WTCHcNb7C1D3PBDBR3KeMchqX8zyECVy
 PoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627629; x=1744232429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQjTGM4AZy26Cg/Z6mPWpaBicyCyJz3n7hNL5yj0q+4=;
 b=q7wKw640u7qYRUFNgRNzDLtODEa0P7qjClxEn+WVscJYctTfc9tYai18MfSHEXI1Lt
 ElEHJ7OIj8Q/Bi+4xQrjk2WLc5v4aDBervuzy49Sr1hy4IYn0HsTqpsetbImC/z4c08E
 fFr+RxhFNOkVZmuQ07HPO/z2O4tjZt03q+Jk0MpATNB97fssJ1s06Z8xlhd/6C5sqRCI
 vumGfDzKLmo6IKvnwFHYMhxr5HSFSYxfiiSBkebyZxeLwcKHsvjWMsxBHtRwbKA+/EhE
 FiDlKde/6jWEio7IIPXhXtWLeYlWJNZP6PsY4qh1OXrpG71z6zEBzj003wW91a8+SzvY
 3nuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuczLR8CQANGRCDYoPG/rRFuUeBEkSW35NCBPQd4j6IiStsvkgzWAvasTx6GuLHZf8e2TISd0=@lists.denx.de
X-Gm-Message-State: AOJu0YzUhQvltev74JSSoyzu1N4WNO2HpNIJotGtnKIXypXdWw0ph3VU
 AxoqB1SJEPwIlgl2+vT5R/SBxMQYcIMifW4TNoYpltgwZu0K+TQGAkh2ENoyZ4M=
X-Gm-Gg: ASbGncuoglS1U46K8NBIUXEa3YUygp4vgNVCRNch15RZZnK/4BziWRIFQmxqiyk5UwH
 3zCkvXqxCvt4OFaw1tinM/X1XLocXAmf/RdOA/2LkaYAIOhHqd4FhPVv/DlbeNY8CFDsS/6Ivh/
 q+TYCStO4d57Hzn4eHsRfWIz/J5IseS75kLl1QivwraShhjK4SlBZXMQLoiK/b6pRbHVAysoHwM
 noKpoVwuWTI5/MCn8I6Qai1VGFGnpmvZlSwHuueKrnk1qJ8Hzj0oPZlvpQrxeHFmz7Iutz4gs9Y
 Yy5yToVMqdwlOvb6cS2n6QtwrihZA2bn2ZqIgLW64zGtWF3j8WB0Oehs
X-Google-Smtp-Source: AGHT+IEntGwMa8Dh48/Rgkld2ia/xwR3mjxaoJU9MmSADhbHSbi9udzUC3Le94bqIGewvDQ2iuF8+g==
X-Received: by 2002:a5d:64e9:0:b0:390:f9d0:5e4 with SMTP id
 ffacd0b85a97d-39c2f8d339dmr92985f8f.21.1743627628916; 
 Wed, 02 Apr 2025 14:00:28 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4498sm18397477f8f.99.2025.04.02.14.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 14:00:28 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 0/7] watchdog: at91sam9_wdt driver enhancement
Date: Wed,  2 Apr 2025 23:00:20 +0200
Message-ID: <20250402210021.1684179-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-2-admin@hifiphile.com>
References: <20250331191520.1805001-2-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Apr 2025 00:23:30 +0200
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

It looks like cover letter was missing...

This patch series includes some code refactor and adds new device support
for at91sam9_wdt driver.

Instead of add a new driver like Linux kernel, at91sam9_wdt driver is
extended as new watchdog variant is similar to existing one, especially
for the function subset used by u-boot.

1. Remove unused typedef and rename variables for readability.

2. Add SAMA5D4 compatible, it has the same watchdog as SAM9260 except a
new lockout feature is added. Currently this feature is unimplemented.

3. SAM9X60, SAM9X7 and SAMA7 series have a new watchdog variant, some
bitfields bof MR register shifted their position, a new register is added
for timer value.

4. Add DT node to SAM9X60-Currently board

It has been tested on SAM9X60-Currently board:
- Start & stop
- Set timeout from DT node
- Reset kick in with a while(1) loop

Zixun LI (7):
  arm: at91: wdt: Remove unused at91_wdt struct
  arm: at91: wdt: Rename regval in priv data to mr
  watchdog: at91sam9_wdt: Rename priv to wdt
  arm: at91: wdt: Add SAM9X60 register definition
  watchdog: at91sam9_wdt: Add SAM9X60 support
  ARM: dts: sam9x60: Add watchdog DT node.
  ARM: dts: at91: sam9x60-curiosity: Enable watchdog node

 arch/arm/dts/at91-sam9x60_curiosity.dts    |  5 ++
 arch/arm/dts/sam9x60.dtsi                  |  7 +++
 arch/arm/mach-at91/include/mach/at91_wdt.h | 25 ++++++----
 drivers/watchdog/at91sam9_wdt.c            | 55 +++++++++++++++-------
 4 files changed, 68 insertions(+), 24 deletions(-)

--
2.49.0

