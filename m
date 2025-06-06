Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51369C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889E081E25;
	Fri,  6 Jun 2025 09:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMZjPZgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337F382A39; Fri,  6 Jun 2025 09:22:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E644E800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso16459505e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749194525; x=1749799325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IW2ctIEX0S7S6FOtph/uAPQ7tg9VfgMCDhipyCgjZO8=;
 b=JMZjPZgl458PVRyrwueRBnqYpiUvleLS47ei0tPsg3432bXcIUGbPP2VdQaaTsfYmj
 YVFFm2ovw+hFsG/JPZag/hKkwA9M+bB7HlaOOQ97tjgJHE2tC6tQziJw2igHDdLDcuTv
 5Plmukvtym7ylT4awq1h+9HZ/liClH0fFPbx/CQwDQfO8X0Vl6IJO1TNxTxhv+AbuYF7
 vO6toaZ0bLZ7WIMKDh2VKgdVFexaSnikwEdWOFm3Z2gEbOGAtt28Wf//6TU6Jt1/pv0l
 9VjipCrrLUM3YbbwoH2mANgG/C0/ndXh30Ck+1twcJe84681h+hxnzl5a1OK8dZtza9O
 w9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194525; x=1749799325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IW2ctIEX0S7S6FOtph/uAPQ7tg9VfgMCDhipyCgjZO8=;
 b=EZ9/pesB04VdHUp0oxkDvbr/qDPNwY5H/v/WZObfkl3urSGLqKwBG67ChlDNyBBsOm
 H2hObevdUXcQcpn/Rsdh5vKgJpc7i37EplxnmbTUnqdKcYlZPRVHH7zsaVGo9sPpJB5L
 /50AeiP9lfaQ4v4a1cutNF2brYkpjFvjrVtwjHOj20S43M9oUAHKWxgZekHVQjBM/SMY
 IjiqafJcR1oVtyUMkC3myPO/Dc/8NNbxElhuonqIZQ7d2jEM6Icf8qBZqLf2M2U3ALEG
 tKhfE+KqXYkwwMSyLXHcJu9c0y//Mnf62AyW0mAeUnWqerHBLFLEDv5/AmIWa3/tFb5p
 L60g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM/NwABovsnBaVkd+dgOF248HsiaLIigGnOvY3okZfR7334WhlBbk4uWoczbIotEUAtnUTJJs=@lists.denx.de
X-Gm-Message-State: AOJu0YzFoIeQfbRVlXdD8RUcajW/B/ammY+Z+3qAylYdjQK6ejd1Qjpy
 q/zMGiKeCVP3iIyr+ws7/S7mUaQiMWTAgY0D83eLCvP4qwHXqkIjNVmz
X-Gm-Gg: ASbGncvcW2KetLKhfowhmNL8fgdvk0rKr9dfAsU6CmT17boboGFhtTRjrA7d+ai7fiK
 CfruG5CSX+JjjGkbifuMMqROnkW/5gi1jSRGcmCMFNmGisLFvZTN+DdnR+/bQaRYufBiw/7CqUq
 fu4S/aemUNMNI3LyfSijLoRglEotdngzB8xI4auj4JOlAeO/sftIlM8i4VV1PA+vp4mZDaKOBit
 T7A8w4GeCKS3k5xtY+qp34Bd+FYN04mwBBgjYNiOgHDg4gPJa1cFBWPBVb0AiQqqxxtdug2UsgI
 V45K0VP/hzISK/CPi0pt/aMAI5/f8ckWlJXcHsRt5w5ooSgkP2i+nbLWyMTiMHNmPQvVBqTz2s0
 khiD8P0wPp6Iu9ePpN6xc
X-Google-Smtp-Source: AGHT+IGSnftXDHRKZPsSaxMOnrcDryz+4a6jO4YLR+mU8gLjwomPtTAgarXZVlz5sMHtj6K/+tgIKA==
X-Received: by 2002:a05:600c:458a:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-452014ea1ebmr21201215e9.29.1749194525110; 
 Fri, 06 Jun 2025 00:22:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm14666295e9.37.2025.06.06.00.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:04 -0700 (PDT)
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
Subject: [PATCH v3 0/5] linux/bitfield.h: sync <linux/bitfield.h> from Linux
 6.15 + winbond
Date: Fri,  6 Jun 2025 09:21:29 +0200
Message-ID: <20250606072140.18824-1-ansuelsmth@gmail.com>
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

Changes v3:
- Fix compilation error for remaining drivers
Changes v2:
- Copy the full file instead of cherry-pick Changes

Christian Marangi (5):
  linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15
  clk: imx: add missing linux/bug.h header for WARN
  iommu: qcom-smmu: add missing linux/bug.h header for WARN_ON
  arm: apple: rtkit: add missing header linux/bug.h and linux/bitops.h
  mtd: spinand: winbond: add Winbond W25N04KV flash support

 arch/arm/mach-apple/rtkit.c       |   2 +
 drivers/clk/imx/clk-fracn-gppll.c |   1 +
 drivers/iommu/qcom-hyp-smmu.c     |   1 +
 drivers/mtd/nand/spi/winbond.c    |  13 ++++
 include/linux/bitfield.h          | 103 ++++++++++++++++++++++--------
 5 files changed, 92 insertions(+), 28 deletions(-)

-- 
2.48.1

