Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C21CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C255838D4;
	Thu, 14 Aug 2025 15:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pylauw70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C2F83930; Thu, 14 Aug 2025 15:13:03 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7D2838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2445806d44fso6974605ad.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755177179; x=1755781979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0n6mysQEdYvKvZY6R8FQRbk+OtOTPscCPeAuTaaOiVY=;
 b=Pylauw70oDXptQATZKh88UQv98KTEOmNW4L3FoTKt9Fi+7lgal12nLQF15nHmBEwmN
 3kEflJlW9hflYdA2mMm5EmK77wsgTIBeUO1PrKgV6ho7iZktLM4nnB93iQ3fG7v0sK8U
 btU8cIJMsJMRRxlKo59VQd1b9ZDUSzfvnZSrnMXT+S33ThrvWOLqq203ENRBETSlDp05
 vLq6dUBPsM/au1OHJtCps3ee5Rx+6tmit9433LBA8wVcXJpfinC3M2FrezM/x61ND/Rj
 I/luWvhRdqdIXVDkABnEWOzNSipXjbDWjTOPEGz9YlkPzgUrMyuzeA+rpSugo6oeRzdn
 q+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755177179; x=1755781979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0n6mysQEdYvKvZY6R8FQRbk+OtOTPscCPeAuTaaOiVY=;
 b=eFI76e2oBSQt/w2C5glH1vsKjiU4QQZHZRT6ZSWJbDnljoGqV8Dalk+2nbwJ0A7a6U
 Un5qiavLicBw0WyKGblzU5fIgBGKuAVYipHrqfCoVrinuiuSEXFlW9WGMCurygV7EW2a
 /Hwte1Zdm009tCXfwVMqyJHK98sfhLAGAaC6TgXjwnJYlumxy5vTftNXzMWGMdl/kVGH
 iIbyDiVgCj9Eq0y/7f60b3NW5YXZXw8vsZ8gINs+Htic1SslmmMNDvVX1jDDa70pRAl1
 rdNleWtiAxIitSqxR9hYP7ah1cq/Zk9Kk6QV5Oe4k5mMY1uQN0wVu8dHPhITrQlVcYyW
 gilQ==
X-Gm-Message-State: AOJu0Yz9Vl62yPHM7pfymlPV6XelZldf1G4+9SSAsCKFL4CQ4r+Z7GnP
 W1s1RlLfaEiyEu40L4NOaARhAomzxkIrFNvWwMDRLuzOqTQMEc2h9mIPtOutml8JNgpiCDOn
X-Gm-Gg: ASbGncsgmVC61ZAR/QetvdOJtjeIPH/OEq5I9wrUNvLZUDFD0sRFqnmlipxOxOxEJRo
 c9WFEsd0Rflcdi7+2Z4un817h0Epg6KYF5qT2z2L3F41YVk/+NtvRqGAdktsiCwEfRtHr2qzwR4
 uuUhauZIIRmOH/ZV7cFCKuJ9uO/KZABwpxVzneZOS4RrkfqOjIfQBGvdnSYg0cxYhjOGzsd0mvf
 qxxpeeAyzy3O4gcLHdTqaZDAQMORWWmwnNmQfj4v4PZUpMYTWhZcE5phuC4aL5bVdJLnB+H/Jhm
 FwpEaD6FGc4MmtMAn2WXWrA6qWKTN4l62T4fR+Ir1+paxKVVtg0FPgy7fiu5cDKYbMiNSRC2kng
 iO0TEWH9FlYR9D8EUK9XJwpIw+M8x6ZJ5IaKccQ==
X-Google-Smtp-Source: AGHT+IFnntyoNuSejGbeVmdQjgaBEW+yL+RjXNsXDNjbRM9Gcrfs7+ZGAfmJMMTzXoYVhuf3nQs9Ag==
X-Received: by 2002:a17:903:234c:b0:242:a0b0:3c30 with SMTP id
 d9443c01a7336-244586c6e39mr46072805ad.43.1755177179376; 
 Thu, 14 Aug 2025 06:12:59 -0700 (PDT)
Received: from localhost.localdomain ([104.28.159.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24300f8c9d1sm67902195ad.129.2025.08.14.06.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:12:58 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 0/5] Rockchip RK3368 drivers improve
Date: Thu, 14 Aug 2025 21:12:32 +0800
Message-Id: <20250814131237.8135-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
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

RK3368 clock and VOP drivers are incomplete, some function is missing.

This patchset improved clk and vop driver to make emmc, i2c, vop and
mipi-dsi working normally.

These patches already tested on a RK3368-based board and it works good,
you can review my test log follow the link blow [1].

This patchset with additional board support already submit to my github
repository, you can find it follow the link blow [2].

Link [1]: https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368/
Link [2]: https://github.com/ieiao/u-boot/tree/ymd8_mb

WeiHao Li (5):
  clk: rockchip: rk3368: Add bus clk get/set
  clk: rockchip: rk3368: add SCLK for mmc clock get/set
  clk: rockchip: rk3368: Add VOP clock get/set
  video: rockchip: Add bridge support for VOP
  video: rockchip: add RK3368 VOP support

 .../include/asm/arch-rockchip/cru_rk3368.h    |  34 ++
 drivers/clk/rockchip/clk_rk3368.c             | 342 +++++++++++++++++-
 drivers/video/rockchip/Makefile               |   1 +
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c |  20 +
 drivers/video/rockchip/rk3368_vop.c           |  79 ++++
 drivers/video/rockchip/rk_vop.c               |  92 +++--
 6 files changed, 542 insertions(+), 26 deletions(-)
 create mode 100644 drivers/video/rockchip/rk3368_vop.c

-- 
2.39.5

