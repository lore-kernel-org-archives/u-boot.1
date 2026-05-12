Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AE5CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9671980F0E;
	Tue, 12 May 2026 14:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MfKUG1n7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEE4803C6; Tue, 12 May 2026 11:15:44 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC5280398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-83d31ac4017so1857626b3a.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778577340; x=1779182140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wh5s8j9Y0wahn/nQavgMrt74JBNlIPFYNrxSCi15HrU=;
 b=MfKUG1n7uZvZ5s1IQ9F7j21L7xaIa3s7sztRzz7a8RND7wtwGjmtu8jgbkFAU59R0J
 dhra9HCgSK1TsSey3WTqs0kGjpfitDuP6SxlhZySdm1brWcZAmKuLw+Bt1/udAtoP9sT
 1OWKIQ7pgMaKg4v6RoHeUggZ8OzKaCtRDsk4YFbUsN4VDoO1+lFnSc2evDVWN3cY2Fpg
 6V0R97RrZzyWFk8GgIv5NX23CFRY9N64Hk4IrkFZO5/fQxWYO08l7GmlQ3zx2BaVOcwP
 hg2bquI5DkGcmgWx0Zn4MPdIi6/zX4k6Uz8O2v5uG0zcZ0/eQzageDBlBQBxXoNZ9MSQ
 krew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778577340; x=1779182140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wh5s8j9Y0wahn/nQavgMrt74JBNlIPFYNrxSCi15HrU=;
 b=foZfMxNBSwJbgQCAmgW6crc9R8RfwbGK68RGxGSQufja7FOnkNxXIhqKmIzle85e03
 eA05a/YOoJKfGhaNfTq3nU9NF5RO8o4pwPSc3+2VnVpfdAFG64rxNE9uyEfVx7ABgqjg
 /lvM0+knhHPjDGexQAjoDxjVpo8/1umbLWHRRWDJRtKjal1RPzoDck5ecrBc+wkO/kvt
 hbTeTfc9I/dX2CHxxzU6gQw67um4OQClVcF4/cQNKLZzztv92TnselXgjjLpQw1uVBa3
 o6KLWQMHUQ95HsY2d6iV/DPVlJ5j6gwG+5v385s9VCvCui0sM94KoAUwoNrzjNFUkh3T
 8Aow==
X-Gm-Message-State: AOJu0YxV/VUTkt9z9I7CW9vitQl0hiWpFSTtVZC8la2Uc3dWUEdytjhK
 pI1+7eG2f10ibpTMr7eWJjYoL9dj+K8noPFMKacuMUcuqmhmqFPSCUtN
X-Gm-Gg: Acq92OHf1v43CSkKfqyZn0neDUve0+dKO9mFpvE5qs37VCMpgOHcxEkYW9H6TUazowa
 xpCwDy7KUs9Na19sgvuQ7ZaliCfJxG6oSCrqF6iIo/soY/ZV3ce0PRFU3Zq49uB+aso9SyZ40ko
 2joaKFHELN+nT6LVLEy3z0L8RlygYYH3YMjr0ebUOWZtxgpJ6X2Pq+M2JjljXrWJq4Xwr+6Hp3h
 hodbRAAY5kxIOzvEtbA9pxwosFBvNYJb+j2TPUn8qOLExeheileemYayWLRA4K1whUv6NcXIkpr
 yJ6tldnPEBqIJCI9yM+/jRj/HJg/ijQt6wzMxZVWWeVNIja2ITS48hLQ8wbe/txS4IwLVz+TWF0
 FPtx8e0z5rEfc4q2Yqsw8Q7DMjLRvUEXut8IzkOchQ5zPhftuHd9foQJFaOJ3nUKZX5v4myhFCk
 lV18pmdzwaBm8F
X-Received: by 2002:a05:6a00:4655:b0:838:29b3:9ed1 with SMTP id
 d2e1a72fcca58-83a5dc5f969mr27279370b3a.41.1778577340246; 
 Tue, 12 May 2026 02:15:40 -0700 (PDT)
Received: from jjmdeMac-mini.lan ([2a09:bac5:3981:e6::17:35a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83ce94a0e93sm12354494b3a.37.2026.05.12.02.15.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 02:15:39 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Liangbin Lian <jjm2473@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joseph Chen <chenjh@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 0/1] rockchip: rk3568: Add support for LinkEase EasePi R1
Date: Tue, 12 May 2026 17:15:31 +0800
Message-ID: <20260512091532.97256-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 May 2026 14:37:47 +0200
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

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---

Liangbin Lian (1):
  rockchip: rk3568: Add support for LinkEase EasePi R1

 arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi |  7 ++
 board/rockchip/evb_rk3568/MAINTAINERS     |  6 ++
 configs/easepi-r1-rk3568_defconfig        | 82 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
 create mode 100644 configs/easepi-r1-rk3568_defconfig


base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
-- 
2.51.0

