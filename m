Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D366C61CE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 21:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82218144A;
	Sat,  7 Jun 2025 23:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYcEfBcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B3582B07; Sat,  7 Jun 2025 23:12:07 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B845D80E9A
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 23:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so20903775e9.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749330724; x=1749935524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UbLcTvddLuKXVk4m8+CyxJDGFtOXvUDZoHzzTJ22pkI=;
 b=AYcEfBcIE/Jzc77Xr70Olb6fD+TshCOG7wpSpgw8oCSf1dO8gP2SOo00lUogOS4WRv
 f/MEpR7RtA0mrfyR8c6srQPExeK0qC+8JKiAaieGUd/5NGh1EuEmLFNiE4DsM90XrZvV
 CUQAigNk8nztjrt29/lNpzC3rZ7TQHXRqxRgqfMED/lda0lLjFEFdPxNtZH5KQNwzSOy
 Ivr5f3kDY4K4pUgmssHGQAN9aYiMltUPxRPvM06JZGstuk0y2TJp7wr1TjHpfMPZotEI
 SxMOJUuQeBgtVk85MKB1nejNQCT8JRJkbP6Jz87Xd6FyQMM+euZZCMP02VVGbvtwcqTN
 O/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749330724; x=1749935524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbLcTvddLuKXVk4m8+CyxJDGFtOXvUDZoHzzTJ22pkI=;
 b=BmJbd2sMGdtn0CoUk6Cat2/nIP8kuh31Q5LEiBN/y7uCRXWxcWjn3PBdIaVh4xxecC
 HpNi1oxlfRIGgwgudp9j27NaG95LMNmtstlbKKV6r9dxP7E4E8eZNtdpsbx5AX/AH3g0
 Cx7ItjWqT7rsdyzdPUMzobKPrET4xzNzQQ57m+aJYkF0Eb8yPKRDLacvmsjyL5ADo4hb
 NVwLqUza2ety4nPIH8wGpUlGT5xu4YWsHXj0gwGMZRBTVDM+qhAA5a54pzF7/n5v7udU
 omhRJiWzf0tuNepjr3TePZE/sf2VF22xhS7BlmYvkFMYBQfld3AR+eQXzPUMw47S5vDN
 /J/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdNrNbwVv4kYG699LzzCmAiXS8e7W+HgSvca0hHxRNvqPd1MnhBLfTmwny+QCxJAxZ39jJ5e4=@lists.denx.de
X-Gm-Message-State: AOJu0YzAkYVZYu89dCEAJ+JoO2kMAbuhy9c18L/1JWIKgC8Rlhz/74p2
 y4fD6UPhbc7lqEdU6AYxCo+i6pumgltshg5F9BKRotT5NWx7eRN37K6W
X-Gm-Gg: ASbGncv87hUpQbQ1Of1e7L0WE+xjudGJz6OcVV1I4BYIBZVDTJNEl/jTGnmu/nJ8Qlk
 uv3Ea/AuXaNM+c0sl+CdqQxOsEzqy8lDQoiXcjFDSbuptER1h+sFjvGu518cWQ1xJvH9jZEDwQZ
 VB4rVioSbYiNKXwsyByiD+T5oW6i2ee/vhzTNJMCsjsIin6XdzU5J+Wla678fvPch6i/uHsp6t9
 KG8Y1wErJgdLJ3sHHnRORqwwsQVc9DJF0i0uXCNpCnoSsabHk6FW/LrlS2Mw55z6u96clS42cOR
 BU94TfLbTCzWrxg9O3LWzlzEc8Lx1IaZYrEgtMeEcOqohXFV9mdpenNs7RzBxNUbLqto6IEmmDA
 Xsi7QQnvRSKwGBN+t3dPI
X-Google-Smtp-Source: AGHT+IGWZ/FMxYR0CAA94ZF4XG/1ewPjlm0HRoR6CwNq2/A6hFwY9i1zBqpNBhCAX/Y0Kb9jNWuNbw==
X-Received: by 2002:a05:600c:3b25:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-452013d1b4fmr73202615e9.23.1749330723794; 
 Sat, 07 Jun 2025 14:12:03 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4526e155ce7sm64368245e9.10.2025.06.07.14.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 14:12:03 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 0/5] linux/bitfield.h: sync <linux/bitfield.h> from Linux
 6.15 + winbond
Date: Sat,  7 Jun 2025 23:11:16 +0200
Message-ID: <20250607211133.2005-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

This small series sync linux/bitfield.h from Linux 6.15 and fix all
the compilation error due to a change in the header include.

The sync is needed to make it easier to support the winbond changes.

The changes are CI test with [1]

[1] https://github.com/u-boot/u-boot/pull/777

Changes v4:
- Reorder patch for better bisectability
Changes v3:
- Fix compilation error for remaining drivers
Changes v2:
- Copy the full file instead of cherry-pick Changes

Christian Marangi (5):
  clk: imx: add missing linux/bug.h header for WARN
  iommu: qcom-smmu: add missing linux/bug.h header for WARN_ON
  arm: apple: rtkit: add missing header linux/bug.h and linux/bitops.h
  linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15
  mtd: spinand: winbond: add Winbond W25N04KV flash support

 arch/arm/mach-apple/rtkit.c       |   2 +
 drivers/clk/imx/clk-fracn-gppll.c |   1 +
 drivers/iommu/qcom-hyp-smmu.c     |   1 +
 drivers/mtd/nand/spi/winbond.c    |  13 ++++
 include/linux/bitfield.h          | 103 ++++++++++++++++++++++--------
 5 files changed, 92 insertions(+), 28 deletions(-)

-- 
2.48.1

