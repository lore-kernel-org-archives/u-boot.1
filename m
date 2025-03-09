Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305F6C28B2F
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 14:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DE380FD8;
	Sun,  9 Mar 2025 15:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJJljSn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB1080FD8; Sun,  9 Mar 2025 15:07:24 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88698801DE
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 15:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so35640065e9.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741529242; x=1742134042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=B/weoMrtvP4khMzYUv/nvi6uQiOqjh1EtYR/IVe6RZM=;
 b=MJJljSn8ang8mDSmZhYC9xaFswLZj9v1Y1IEKjz92/StkOwtqrWmHm/8s2DMTghdY/
 TfKg5WN1x/keReBnNlEVxJzq34fq1ZESOIykEQK86sq9DO2A2RGpLW7JWbqnZL7QdxOw
 RdRaXxS6+DkKNHIGI6DBlz6VzvuANkfoCfIbM9/rg4BIJ8cJXvthGWzkcALCQHL4OHj8
 7R2qpJz6+/6ow/nzr1ot8FlIis5daxY5CfoSexXall4ED82gvUG+fQyh9BK/O4ZKZb+4
 +MlWl0GeBa1C7WU5fTE4BiVZe8wsfRYW0G4XRl025O5mTdQWSRPsuM6+hLZDWzVv9Nsr
 BfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741529242; x=1742134042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B/weoMrtvP4khMzYUv/nvi6uQiOqjh1EtYR/IVe6RZM=;
 b=ckLhQiGh55vxK+MYxABtzMuZAfR6/uGXHCM15PHn26hIp1tX+CUd7XtZ33mKgzlNt1
 uGYvt+CQikE266Xua9YG+zVvnZDmv0iE+UZqzCRdDp/LQjwUhtmDmgwNRAKriLdx78MO
 kjTAjBlOA/oqBXExfkVArCD4Yrkn30wdxiisSnbcZX/ovCyDU5HmNRpNYWrF5hNFaCgy
 l7HNLBNlG705kYXe5UTBXL/16LLcaeCUp2rb53Ds7Z6bXGXP+ggoXFQDvor5FPkfjdyu
 Y95VBjYOpMbDmbqnHrIZdXYzJ/qbcYDTTe8/Dz4QpwB3+pVhocx/db8udiMD8cYeV+wG
 I4Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf9iG9Ic7q1sghvI6c3xQdYtmjrbqNxsiyKSqbunhf0ouRNu9MLOHxNspYOSENwAAUd7myKXw=@lists.denx.de
X-Gm-Message-State: AOJu0YyPzDBrEBkH7R9zZXWzWAhtoOe9GXT1FtF3bQlJb78eAmDKPwLR
 krqrdFSQJIU58mDHD5Y4ki2qWW5C727GrLpP92GCG2c1dYEBnD84
X-Gm-Gg: ASbGncvaUrOy6HL+sWnDfSaEHv0wrCM03gXYjQMdnhXSsAPNm71Ykbi72zR1i+FiiIG
 5pHHSNEDYlLBaJlCM9tmGEp+2m38ycsEDQ+mltEiAC0nZyBfIBIKIhMQEuCWWoMJPnSl8rXMVNi
 e0FHYOYuHboy5byzAVRnEAOHhKySO0AmzHFbihloflTIMK4aIIYxJ/W9c45mRMXHHFXOxDLh/SF
 GO66JKxiNSaxYeUEhuiN71BMrXIf2CGxG2u/7u3Dqp2lvlmmoMQl57g8ZVxOy7EKKvB3dm4QBs7
 AVhtbLBAD8M9YK9EwodGBrmwkzmUJjKO7G35Mcz4lquHEWXjqUiKNtaYEsynawg0TRi2VfMWGUH
 jhl2bUbgCOL/Jfw==
X-Google-Smtp-Source: AGHT+IFFukGTe70VanYvajAeyEzm5+qUQgwhsqwftCBuuwYCpI2hUEYg78t5+Em8v1UFv+uS/98myg==
X-Received: by 2002:a05:6000:4106:b0:391:47d8:de2d with SMTP id
 ffacd0b85a97d-39147d8e011mr966717f8f.23.1741529241804; 
 Sun, 09 Mar 2025 07:07:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm11946816f8f.0.2025.03.09.07.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 07:07:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 0/4] airoha: Add initial support AN7581
Date: Sun,  9 Mar 2025 15:06:42 +0100
Message-ID: <20250309140652.23543-1-ansuelsmth@gmail.com>
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

This little series adds initial support for Airoha AN7581 SoC.

All driver are created with OF_UPSTREAM support in mind and
the very same binding and include are used as reference.

Posting this to have the targer and the very basic driver.

Ethernet, SNAND and eMMC support is already ready downstream
and will be posted shortly after this gets approved.

Having the first driver ready permits to separately push
dedicate series for SNAND, eMMC and Ethrnet as they all depends
on basic support of clock and reset and nothing else.

Christian Marangi (4):
  airoha: Add initial support for Airoha AN7581 SoC
  clk: airoha: Add support for Airoha AN7581 SoC clock
  reset: airoha: Add driver for controlling reset line of AN7581
  arch: arm: dts: an7581-evb: Add clock and reset nodes

 arch/arm/Kconfig                              |   9 +
 arch/arm/Makefile                             |   1 +
 arch/arm/dts/an7581-evb.dts                   | 162 +++++++
 arch/arm/mach-airoha/Kconfig                  |  44 ++
 arch/arm/mach-airoha/Makefile                 |   5 +
 arch/arm/mach-airoha/an7581/Makefile          |   3 +
 arch/arm/mach-airoha/an7581/init.c            |  47 ++
 arch/arm/mach-airoha/cpu.c                    |  20 +
 board/airoha/an7581/MAINTAINERS               |   6 +
 board/airoha/an7581/Makefile                  |   3 +
 board/airoha/an7581/an7581_rfb.c              |  16 +
 configs/an7581_evb_defconfig                  | 137 ++++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/airoha/Makefile                   |   3 +
 drivers/clk/airoha/clk-airoha.c               | 454 ++++++++++++++++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-airoha.c                  | 173 +++++++
 include/configs/an7581.h                      |  19 +
 include/dt-bindings/clock/en7523-clk.h        |  17 +
 .../dt-bindings/reset/airoha,en7581-reset.h   |  66 +++
 21 files changed, 1194 insertions(+)
 create mode 100644 arch/arm/dts/an7581-evb.dts
 create mode 100644 arch/arm/mach-airoha/Kconfig
 create mode 100644 arch/arm/mach-airoha/Makefile
 create mode 100644 arch/arm/mach-airoha/an7581/Makefile
 create mode 100644 arch/arm/mach-airoha/an7581/init.c
 create mode 100644 arch/arm/mach-airoha/cpu.c
 create mode 100644 board/airoha/an7581/MAINTAINERS
 create mode 100644 board/airoha/an7581/Makefile
 create mode 100644 board/airoha/an7581/an7581_rfb.c
 create mode 100644 configs/an7581_evb_defconfig
 create mode 100644 drivers/clk/airoha/Makefile
 create mode 100644 drivers/clk/airoha/clk-airoha.c
 create mode 100644 drivers/reset/reset-airoha.c
 create mode 100644 include/configs/an7581.h
 create mode 100644 include/dt-bindings/clock/en7523-clk.h
 create mode 100644 include/dt-bindings/reset/airoha,en7581-reset.h

-- 
2.48.1

