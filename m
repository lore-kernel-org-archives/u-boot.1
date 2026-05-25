Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC42DCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 16:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD3C848BB;
	Mon, 25 May 2026 18:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JYIvMrSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B912E848F0; Mon, 25 May 2026 18:12:37 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB111848BB
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 18:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ba6485d219so74443245ad.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779725553; x=1780330353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7cjx3HuKjkCemiI8WzjK8b5T4vWFBnLnLtiZZtXGhHA=;
 b=JYIvMrSO+CjJz2WXofQWuWbeU/DBsLrp/r6JptoezdXEsg8BolONHpENpoe+UiqhAj
 xIVzX8LhGtLLyyS7Yx8lTNaTQO7RYXnItqGDzmWPHbSRFi2MXmftIam4EaKQaiRAWEQx
 jtrB9xvn4N9Wc1kthxn15Zw5xXdlBvHuFJ+Tw1JqeAggvWE6u2MMVGdTVkf+RveYq68w
 3Fjkirb8UFnMJgGZu/GlVAdSVVcpp4sNv6+lTEqk2lroR87R8KWoq6hp8thw5J3w81Yl
 ZA17m1qMgutSOOdMPihGeJ1GP+iMlvAHz5HRdkKsGBg4jMqUJEAqw40SKXRhosAM0Or/
 ovWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779725553; x=1780330353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cjx3HuKjkCemiI8WzjK8b5T4vWFBnLnLtiZZtXGhHA=;
 b=dp8hPpUF0Gi8FFxs95Ddn6ExRF8YxqbslxiRmLvFk7nQn8CcYacwB/uLsFReXFXN/y
 cwI5TmIZ40DHUEOTomp5AoRr1CCn3mgaKSsesXzb3oEqkPMfAbgslqDW0GkHpJfA3lU/
 R0GAdfEx4YygUPISs8IvhtOz9qm0BdOedOXmy0vK+JSVUDcWFDpVNCnIyLr+UQb8Iazh
 c9Ttd6KHE6GNW1eHdvbQ59RyE9kup4N0+TKY41Cc2tJIky8yK+euUvhwkr7ccOZ3iJrn
 +wNfcQqobEbl6EIad40nVyxsZhDzZqAV++6+KduYCu87eO8RrPGC1giyFUvapk8jWx4u
 2t+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vbN7zNsOA1vto3anSrOlEeOSA/OWvCeHodMcC2Vnblff6LkRs9PLJ15Z7iszJwrzHa32FteQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwHM2ftE1i8bgxMAJr9PmG0Rp2gzcAZoL/I3hDrOxWwFaf8DJJd
 wPlamELByLFJwhHtgywOBthKCwP8e+hSu0HTVbZg/xZ2UuSzPM3Iu0ob
X-Gm-Gg: Acq92OFuXrsWPLFYUtpcfdQzXp4C9/sPUyXp7nMgwdng6ebUPKAtQ5YTVlc4jOfxrUs
 LmqZmSI91KavrzfEXjbBVGdrEKaqHUsmpO3jkZfNGOWX6zuMvzcumi/KjOE9g3ZeEAsetwTbkEK
 2Zg2n8MbJZQVxH/pryZvUsprM1FzQiWVEWCupEYALcXEw1nZoZXa9mg1tEwszGFbDNJ8Lj6hkg/
 ztph0HINtpJU0SxqGYVvCeHJVCmnjKkB+akhQrg935WkpdYrV1JfJQrgb36oMur8MCCSuWHYzGw
 TALuf48S4V/k83H2oiNmJUhhu+jW4SPG5OZzxc38h+HemxVp+w+t0Ma4j28CV3QP8WehkoRkTlc
 aPdS5A6I0k9oRbUcKKp6ItTPDVVkHK8j8BUHVoHLE7H0HEZD/eSOG8FcZweIksoNK9yi12bRQcG
 piTOc1A/iR0mIs2PAHMustr4doy2Q0OYgwLJiPzkclhyYS4Allaroc56yua6dzPS9ULI+6bElVd
 ItvC4FVWWPlIexrRYnsqw==
X-Received: by 2002:a17:902:cccf:b0:2b7:a350:463f with SMTP id
 d9443c01a7336-2beb0384f04mr169853725ad.10.1779725552926; 
 Mon, 25 May 2026 09:12:32 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5924211sm92419305ad.84.2026.05.25.09.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 09:12:32 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v5 0/3] phy: add common PHY polarity properties support
Date: Tue, 26 May 2026 00:11:43 +0800
Message-Id: <20260525161146.114432-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 18:27:06 +0200
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

Patch 3 adds sandbox DM unit tests for the new library, ported from
the Linux KUnit test (linux/drivers/phy/phy-common-props-test.c), along
with the 8 sandbox DT test nodes in arch/sandbox/dts/test.dts and the
CONFIG_PHY_COMMON_PROPS=y entry in configs/sandbox_defconfig. 16 unit
test cases (8 for rx, 8 for tx) cover: missing property, single value
with no names array, count mismatches, name-based lookup, missing
default fallback, default fallback, and unsupported polarity value.

Changes in v5:
- patch 3: switch `ret` checks from `ut_asserteq()` to `ut_assert()` in
  PHY common props DM tests to avoid Coverity INTEGER_OVERFLOW false
  positives from signed-to-unsigned promotion in the test macro

Changes in v4:
- Squash former patches 3 and 4 into a single patch to fix bisectability
  (the test code referenced DT nodes that were only added in the
  following patch)
- Add CONFIG_PHY_COMMON_PROPS=y to configs/sandbox_defconfig
- patch 1: replace printf with pr_err for error-condition messages in
  phy-common-props.c
- patch 2: use phy_string_for_interface() instead of direct array access
  phy_interface_strings[] in en8811h_config_serdes_polarity()
- patch 2: remove unused local variables ofnode node and u32 pbus_value
  from en8811h_config()

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

Lucien.Jheng (3):
  phy: add common PHY properties support
  net: phy: airoha: air_en8811: use standard rx-polarity/tx-polarity properties
  test: dm: add PHY common props unit tests and sandbox DT nodes

 arch/sandbox/dts/test.dts            |  60 +++++
 configs/sandbox_defconfig            |   1 +
 drivers/net/phy/airoha/Kconfig       |   1 +
 drivers/net/phy/airoha/air_en8811.c  |  60 +++--
 drivers/phy/Kconfig                  |   8 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 286 ++++++++++++++++++++++++
 include/linux/phy/phy-common-props.h |  69 ++++++
 test/dm/Makefile                     |   1 +
 test/dm/phy_common_props.c           | 319 +++++++++++++++++++++++++++
 10 files changed, 790 insertions(+), 16 deletions(-)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h
 create mode 100644 test/dm/phy_common_props.c

--
2.34.1

