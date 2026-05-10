Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97025CD3447
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0A78488B;
	Sun, 10 May 2026 02:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Q6bf4T0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6FE8488B; Sun, 10 May 2026 02:07:04 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5485284852
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bc85eda6b6so2170315ad.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371616; x=1778976416;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8492OAr4WZlA8k+430WBjvqVf0G30F/hh0yTzlI6jpo=;
 b=Q6bf4T0+g5QTaK1h8VkqYvbtS3+mgTf5F2+mM6iCI+zq+sHkR8CIR8QaZTAnozlxeG
 5Rr/rukMshOWAAwPAjqMIHP3jnWaHX8+hhMPjw6fiOgGR7s0LJOay6Z4KTMbTdKoBgZL
 uQyH17aiOYeSUTdDQgFo+twAhJezYPiQQbYBbcLCsUbMycgLSukfJq2A5xdc6aOJh7rJ
 vh4mG7JznHaDBpBI7XlV+BWXUOD+ZVX6PtS+u9m1cBNPqVgpKfDRuFwDuGF4Ttq/gj7Z
 Q5X0GW/5P1S/oqR6eJQbTFR6SPL3ETfHTEif0NMKUfKn5lWVsCvw3pei+YR/xMoAhlxf
 s0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371616; x=1778976416;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8492OAr4WZlA8k+430WBjvqVf0G30F/hh0yTzlI6jpo=;
 b=ArbqRPl0d6f+Tzu0xu7rfYOoGTkO+itHxI36xHymoeCwicU9qixug4ylSxEr2CSs+1
 dAXa1W5kJnG64r7W4dGCN1U+J5ToixvlqL69gcGpnsCj3sjvqOpG+dGLIRmwmIgzw5TG
 amaLaNoLoNY7tC/meY0TCFH1V+lR0IUhmIYHWS/Eg47Q8dLBf31OtIIZ4uLItp5C8hZZ
 Oe5jkr21b2pmCnGjpAck/i0C2mWN6/Psj5taXfGiH9Cb2J7omJRu7oZLjFUr6CIneSwh
 bKILYXengJu/+I5oqpbu1BF/IiRGpLzx6/O1wHdjVXoVypW2mYE0vcDk/4A3srg8T8di
 k1ow==
X-Gm-Message-State: AOJu0YyK0q6e6rvlN+/q6NGS7l6vyGP4TmV9iPP2B6p4cxxY9xdeXsCB
 3JVRaS+7RtgAsQQEMCHOf6+8FvmnLeKl3ls2lFkX/GjXKKgnDc6Fas7OpdkfoiyNAZc=
X-Gm-Gg: Acq92OFvoHgMiECEpwOhm6jBZpfdH6P62Oa8Q+XWVQQPLBNw8Fb8zXRwHDtqdfHLqdP
 sUB1Z56A/zw+lQ4dhHeqO8vo4VfjpC8Eg9Ueim+3f+Zqd7JNDok16BcylKj6d/gtTQTfc2z7Btw
 KUme0nK1Q/H2QD2XDDUm9rCtOG/4AswkwRssGr1nsPJSwI56j4NWuM/KhJQq9xvmhxj1T3px7TM
 GWXlHEbJfPtKREwMk4tyOnPT/6QG0yw3F4O1nz0yxboB+FRMdZvPsXliUlVzPhuls9mumDp1PVf
 t5fgwP1MwmvMadDsBiC2+akYWz+VZzZtAsrTOoS6NvYcI2M1xGkQUxS/jwdH5YZa7rWHQwiRszX
 dMQYIvuf3xqy+lhaCb0RRv1ZWG7fGJM9TLSbm1Wv0mxIhnOc1BiXAga+vCSe5CfIi1DFuqj+yy1
 JmITfGMLwgpU95K7vD98kRp7Ab6n/V7tIc5p5fcxn5TwvOvsRqmLKJEA==
X-Received: by 2002:a17:903:3808:b0:2b2:5840:80c4 with SMTP id
 d9443c01a7336-2baf0dd61a0mr90271715ad.25.1778371615759; 
 Sat, 09 May 2026 17:06:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:06:55 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 0/8] riscv: spacemit: k1: add clock reset drivers, switch
 to upstream DT
Date: Sun, 10 May 2026 08:06:22 -0400
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL50AGoC/yXMwQ6CMAwA0F8hPdtkQ8TorxgPW+mwokjaYUwI/
 87U47u8BYxV2OBcLaD8FpPXWOB3FdAtjD2jdMVQu7p1B+8wNjh4pMeAysYZ58mycnhilw0pJp/
 24XiiFKEUk3KSz6+/XP+2Od6Z8veEdd0A+FRwC4AAAAA=
X-Change-ID: 20260510-b4-k1-clk-reset-upstream-dts-cbf1f3a79cfb
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

Currently U-Boot's SpacemiT K1 ships its own arch/riscv/dts/k1.dtsi and a
spacemit,k1-reset binding that has no node in the upstream
(kernel-mainline) K1 dts. After list discussion [1], this series
moves U-Boot to the upstream DT before further K1 work lands.

In the upstream DT, each K1 syscon provides both clocks and resets.
The kernel's clock driver spawns the reset child via the auxiliary
bus. This patchset does the same in U-Boot: each clock driver
spawns a UCLASS_RESET sibling on the same ofnode.

Patch 1/8 adds the K1 clock driver.
Patch 2/8 adds a new syscon-bound reset driver with no DT of_match. At this
          point, the legacy reset driver and local dts are still there.
Patch 3/8 has each per-syscon clock driver spawn the reset child on the
          same ofnode, the way the kernel uses auxiliary devices.
Patch 4/8 enables the clock driver.
Patch 5/8 switches BPI-F3 to dts/upstream/.
Patch 6/8, 7/8 and 8/8 clean up the legacy reset driver and local dts files.

Old and new reset drivers coexist from 2/8 through 6/8 so the series
is bisectable.

The K1 SPL bring-up [2] and PIN/SPI [3] series will be rebased on
this and resent once it lands.

Link: https://lore.kernel.org/u-boot/20260507140558.GU1614990@bill-the-cat/ [1]
Link: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@gmail.com/ [2]
Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@gmail.com/ [3]

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Guodong Xu (7):
      reset: spacemit: k1: introduce syscon-bound reset driver
      clk: spacemit: k1: spawn reset device from per-syscon clock drivers
      configs: bananapi-f3: enable Spacemit K1 clock driver
      dts: k1: switch BPI-F3 build to upstream DT
      dts: k1: drop legacy local DT files
      reset: spacemit: k1: drop legacy spacemit,k1-reset driver
      dt-bindings: reset: drop spacemit-k1-reset.h

Junhui Liu (1):
      clk: spacemit: Add support for K1 SoC

 arch/riscv/dts/Makefile                       |    1 -
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi     |   30 +
 arch/riscv/dts/k1-bananapi-f3.dts             |   28 -
 arch/riscv/dts/k1-pinctrl.dtsi                |   19 -
 arch/riscv/dts/k1.dtsi                        |  480 -------
 configs/bananapi-f3_defconfig                 |    6 +-
 drivers/clk/Kconfig                           |    5 +-
 drivers/clk/Makefile                          |    1 +
 drivers/clk/spacemit/Kconfig                  |   23 +
 drivers/clk/spacemit/Makefile                 |    7 +
 drivers/clk/spacemit/clk-k1.c                 | 1759 +++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h             |   79 ++
 drivers/clk/spacemit/clk_ddn.c                |   93 ++
 drivers/clk/spacemit/clk_ddn.h                |   53 +
 drivers/clk/spacemit/clk_mix.c                |  403 ++++++
 drivers/clk/spacemit/clk_mix.h                |  224 ++++
 drivers/clk/spacemit/clk_pll.c                |  157 +++
 drivers/clk/spacemit/clk_pll.h                |   81 ++
 drivers/reset/Kconfig                         |    7 -
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/reset-spacemit-k1.c             |  548 --------
 drivers/reset/spacemit/Makefile               |    5 +
 drivers/reset/spacemit/reset-spacemit-k1.c    |  289 ++++
 include/dt-bindings/reset/spacemit-k1-reset.h |  118 --
 include/soc/spacemit/k1-reset.h               |   23 +
 include/soc/spacemit/k1-syscon.h              |  149 +++
 26 files changed, 3384 insertions(+), 1206 deletions(-)
---
base-commit: 24db98cdf911b6ca362209e674bf9412441c1095
change-id: 20260510-b4-k1-clk-reset-upstream-dts-cbf1f3a79cfb

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

