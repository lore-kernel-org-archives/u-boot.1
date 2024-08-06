Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AF1C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9D6889AA;
	Tue,  6 Aug 2024 06:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6aP0oFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3A38898E; Tue,  6 Aug 2024 06:39:11 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13627889B8
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ff4568676eso3686265ad.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919143; x=1723523943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dJua7/v5vqeUZTPDRhBrBECI3dd3NVeXh5BlD/7ZKQE=;
 b=S6aP0oFM2Mzub2EJwrTSNDTUkwcmmLtjGUqk+quS+6c/4L2i+dFZG9Lb9PfVglRzO1
 PpbAr+i8x9XSH7QBjEHagcyfXfrkJOxuwXN/2BOKOBV95ENGtSnFRUVL0cfcnZubBAnv
 57IGN+8aTJdKGvU93UqvQbSuCJjW89G70Rxxr1qg3cRQPR59lDHQz17VL7FXxXazfRkA
 0JWarQIDZnd+tQLNqGcgOEhrb32BkC7zpG1wF/iWIYgTb8RP614REghr0YFh9ph5Icqm
 TyGR2E9JphTcyhK5Kcowa7C+T/MJYRIAz+tPvx7ktdLwF8n9grza0E/fQGDTdX78hKZu
 xchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919143; x=1723523943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dJua7/v5vqeUZTPDRhBrBECI3dd3NVeXh5BlD/7ZKQE=;
 b=E1xZ8X9SjO2yWpobJO75WQdxe7RPYfDOaK1RLKObQwR/IXR74Jhz7N6fXsYxRL3/fB
 d5lJk5Tq8HFey6xZvrVHaOu5rCmRxn7EyysrDu+JSTGTfEOwmvm/iyfRfMtBHBwDAgjv
 5TOmAM2WSgkVYrkDGEx/qGaqBJDkS6ivvdEA75ZkwNrGiq1fFfuoXpjs2sbxkRDACAvh
 UR2PJd+dOBExAfoFGMM2ziivSMed4sBJhK2tNB8MaJ5+fMO4XSAmZsHoEP+vqlmefT5Z
 hBVmtsN8TS3DP1n2Er/4rNHoWFtLuS1gchyK62IP0OhbKhvmDKwvGMKXsClT2577JKBZ
 vF5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAzTO67Ei+IaE7TLQgeUlgxGLo08+oh3v9eG4iZx2HYXC8dtzXmBtVv7c3GCRVQScGKReDSILvVwndG0Smtu29BtHzyw==
X-Gm-Message-State: AOJu0Yx83umC/c+vC7M/3g83IyCV6BsEuS/v1EdFuCY2/k/HPCSDdAtW
 QxC7edF6ahBVMh08Tso+Yk/i7pde/FNxGD/dhNR8nvLwh6Xkly44
X-Google-Smtp-Source: AGHT+IGBoo2BN6vnflqUo76Mk1RyQ/HTP3qO2AiCEnTS3NqxuBNHkinnKVlxcfTKvbZ4/U40He4v2g==
X-Received: by 2002:a17:902:ea10:b0:1fd:74ac:e6b6 with SMTP id
 d9443c01a7336-1ff57281c3fmr153628695ad.24.1722919143181; 
 Mon, 05 Aug 2024 21:39:03 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:02 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 00/12] Bind Syscon driver with OF_REAL
Date: Tue,  6 Aug 2024 04:38:37 +0000
Message-ID: <20240806043849.3607-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.46.0
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

Bind syscon driver with dm_scan_fdt_dev
As OF_PLATDATA is no longer enabled, the related
code is removed.

Compiled and tested on RK3399 and RV1126 board.

Thanks
-Anand

Anand Moon (12):
  arm: rockchip: rk3399: Remove unused syscon drivers code
  arch: rockchip: rv1126: Update syscon driver binding method
  arm: rockchip: rv1126: Remove unused syscon drivers code
  arm: rockchip: px30: Remove unused syscon drivers code
  arch: rockchip: rk3066: Update syscon driver binding method
  arm: rockchip: rk3066: Remove unused syscon drivers code
  arch: rockchip: rk3368: Update syscon driver binding method
  arm: rockchip: rk3368: Remove unused syscon drivers code
  arch: rockchip: rk3188: Update syscon driver binding method
  arm: rockchip: rk3188: Remove unused syscon drivers code
  arch: rockchip: rk3288: Update syscon driver binding method
  arm: rockchip: rk3288: Remove unused syscon drivers code

 arch/arm/mach-rockchip/px30/syscon_px30.c     |  31 ----
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  34 +---
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  34 +---
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 157 +-----------------
 arch/arm/mach-rockchip/rk3368/syscon_rk3368.c |  41 +----
 arch/arm/mach-rockchip/rk3399/syscon_rk3399.c |  45 -----
 arch/arm/mach-rockchip/rv1126/syscon_rv1126.c |  27 +--
 7 files changed, 14 insertions(+), 355 deletions(-)


base-commit: 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212d2
-- 
2.46.0

