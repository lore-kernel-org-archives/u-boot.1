Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59466E9D812
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0258341A;
	Sun,  5 Apr 2026 22:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c7hIJz7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB348394E; Sun,  5 Apr 2026 16:50:43 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E168341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 16:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35c124d2613so1775471a91.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775400639; x=1776005439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1O4kxlTNEZdrFi/3Fm7hpl6xZukfsR6ZSyVGicPSyBw=;
 b=c7hIJz7Dv+jkj80sfC0vB4QNkNTBuYTRU+6+VBWLZV52QrAVo5Jl0Vwc2Tln9fM/jx
 CkFBixdubWVYopBkVqK7JCy/PDoYtsS7cjcDBAmahJeR8Nw04848tAAzze63wImnm9WM
 qsDlBA05APm1Irb0bPuEsehaGzAbMOUcdM55J6p4j1o6Ysm8DKttP+z/1rKvqt2LURlq
 3AAIScvMRYiz1XiD6nQgntBDj1mmQjXwlpCckUbeQTOXC3ZG7PlPXzUDbniTuL1RJ/Dp
 25ynYt8ZnW/It/PWuf96KvgBon/zkiyNUydaU5YEUO3WXuzgGnp6nxPeGCCj+hpUgk3D
 qI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775400639; x=1776005439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1O4kxlTNEZdrFi/3Fm7hpl6xZukfsR6ZSyVGicPSyBw=;
 b=nrvAZjpPUAQvxPKeSN2c5fW1W/S3bkvinH0A24SJMv/P/ENUUI7EzBDLvUpq/PUTr8
 YJFjDhAaN+ksSrT0mZWXoix1sH4X5oTGufXrhj4raS2dez16yJDujL5E1vfg7P372vm3
 rqtlWz3ssawb5g0hBY/e48+KLbtlYdm7Ri3VAsL/pfjlLBgqXfcDI0Gx4Slwz+NULfpY
 bQ8F5wZ62FjhkCyrpw4VrXbsEpcqgk9J2d+5bJQ+8J+yqefbMtkcZTmAUfqLTbPeZxJw
 eVteZ0/Ed81xMocEkV8z2x7Y/6kDxncVLCCs5h/lsm9/qA+EQOtI1XwDZpBjK1UWvuxc
 7u9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbS1xIl6T1eLN8/SzlaY7IToTqD33t4PCPiuk7dATKxEvTLWRwRyokGkfDKb7/A4oMytrM5Ac=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy4ki4uvFgL5zwCaRK2f1+YeFK7jjA672sJ3rBuL9T/dW5DZ1j
 1fnWoZh0kyyNfa1Bmwjr1zGFmiNo/LXAOqAfjwSDH7vcOFLWueAaj6uQ
X-Gm-Gg: AeBDievFJW+1RofuM/41tdkOIaBEe+1Zwe2JNzsR4rGgm1qwgOYWj3viMjB/xZlvGPk
 OxGq1bHEjG1Y6bMolBrHthvaMdM70WuxpGQzfrPn3+xOUFCj+2GBk0o5YUJb6krpl0RtDLtpi/4
 KIIun3iFOPDUquAjpszi/Hroj9bj/Z0/HqYIgfmQEqKlo0+NaOPK22OxQ3dzQwhjIyFZwuCIqEB
 N8Ics+BSarh3WfvNL+hBmY+24ceVtrspBi4ceCw/+KvVNcsvBTtHjcuouWaAajb7IZfotZjVjGs
 e9JjgkaQijj7rSogV8BIOoapONIeMglFLHuvgLHKrT5FCgP+Qef88W4BXDgPPHqEq5cYfFyY6zj
 vEUBpqEDkn64LVhZdXchI7j4QkzNpx4kasUrMUzUkjE4erbjDtPMuaR1F0XaE4YVJ8UdImYZ7ap
 8Rf5CNcXJTy7EFIP4StwIFqAGofjsfSGK9wC+0p/rRWWh6qNTKNqOYzOJWXFcLPwb1Rv1mp68LS
 CuI3LZHR/0BlWgXVbtLl0FpuFCz8ezM
X-Received: by 2002:a17:90b:48c6:b0:35d:a22b:80cb with SMTP id
 98e67ed59e1d1-35de68ec484mr8674493a91.16.1775400639516; 
 Sun, 05 Apr 2026 07:50:39 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe959358sm15333261a91.13.2026.04.05.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:50:39 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v3 0/4] phy: add common PHY polarity properties support
Date: Sun,  5 Apr 2026 22:49:40 +0800
Message-Id: <20260405144944.41074-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:12 +0200
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

This series ports PHY polarity inversion support via generic device tree
properties from Linux kernel, synchronizing with Merge tag 'phy-for-7.0'
of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.

Patch 1 introduces a new PHY_COMMON_PROPS library providing helper
functions (phy_get_rx_polarity, phy_get_tx_polarity, and their
"manual" variants) for PHY drivers to read standard polarity properties
from the device tree. The PHY_POL_NORMAL, PHY_POL_INVERT, and
PHY_POL_AUTO constants are consumed from dts/upstream/include, which is
already on the compiler include path.

Patch 2 updates the Airoha EN8811H PHY driver to use the new standard
rx-polarity and tx-polarity properties, with backward compatibility
fallback to the now-deprecated airoha,pnswap-rx and airoha,pnswap-tx
boolean properties.

Patches 3-4 add sandbox DM unit tests for the new library, ported from
the Linux KUnit test (linux/drivers/phy/phy-common-props-test.c). Patch 3
adds the build rule in test/dm/Makefile and 16 unit test cases (8 for rx,
8 for tx) covering: missing property, single value with no names array,
count mismatches, name-based lookup, missing default fallback, default
fallback, and unsupported polarity value. Patch 4 adds the corresponding
8 test DT nodes to arch/sandbox/dts/test.dts.

Changes in v3:
- patch 1: fix ofnode_get_u32_prop_for_name() to apply default_val and
  return 0 when the polarity property is absent, instead of returning
  -ENOENT; update @node and @default_val kdoc accordingly — this aligns
  the "missing property" path with the behaviour expected by
  phy_get_manual_rx/tx_polarity() and is validated by the new unit tests
- Add unit tests for the PHY_COMMON_PROPS library (patches 3-4), ported
  from Linux KUnit test linux/drivers/phy/phy-common-props-test.c
- Add test/dm/Makefile build entry gated on CONFIG_PHY_COMMON_PROPS
- Add 8 sandbox DT nodes to arch/sandbox/dts/test.dts covering all test
  scenarios; include <dt-bindings/phy/phy.h> in test.dts

Changes in v2:
- Drop DT binding patches (v1 patches 1 and 3): already merged via
  the DTS upstream subtree merge (tag 'v7.0-rc2-dts')
- Drop creation of include/dt-bindings/phy/phy.h: the header is now
  provided by dts/upstream/include/dt-bindings/phy/phy.h, which is
  already in the build's include search path

Lucien.Jheng (4):
  phy: add common PHY properties support
  net: phy: air_en8811h: use standard rx-polarity/tx-polarity properties
  test: dm: add PHY common props unit tests
  sandbox: dts: add PHY common props test nodes

 arch/sandbox/dts/test.dts            |  60 +++++
 drivers/net/phy/airoha/Kconfig       |   1 +
 drivers/net/phy/airoha/air_en8811.c  |  58 +++--
 drivers/phy/Kconfig                  |   8 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 286 ++++++++++++++++++++++++
 include/linux/phy/phy-common-props.h |  69 ++++++
 test/dm/Makefile                     |   1 +
 test/dm/phy_common_props.c           | 319 +++++++++++++++++++++++++++
 9 files changed, 789 insertions(+), 14 deletions(-)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h
 create mode 100644 test/dm/phy_common_props.c

-- 
2.34.1

