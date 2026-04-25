Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D76BFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662B78452D;
	Sat, 25 Apr 2026 20:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ARVu/KFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E77F8442A; Sat, 25 Apr 2026 19:32:27 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545DD843FB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8a3b0242631so110930186d6.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777138344; x=1777743144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vfCOgci2KjRyQNAd9VtT5VLhB2Mtt5RuvN3YGz7O3so=;
 b=ARVu/KFAd1D54pu2d6FZse4QaGPsKzg00EZXO+tFArfA8wFXMqRifaU7dMPagJNESG
 uQ8cPQdGYNaVwNIsLjiUFqWtybdBf2KCdNL88TJCVdHRNCCtu6T9/ry3JDkt8Cw9z0mQ
 qlxriAPBcr0CMSoNcJZwCCI+MljfHS77EuNpg37MfelddFq4VDpiXr6IyoxOdkiKq1Ee
 Gvgs6S+3Kj7QY5GayxfCluDWu0liKGGCGDO7X/q1w8nPMxRpjoTcZrUeWaSONKzq7Inn
 Hwp9cnVsDo//4/UE994j6aIgiNyfZjWE1VkYogT4hQrJNrjraNYCafHb/cGLDn7ljcRN
 wx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138344; x=1777743144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfCOgci2KjRyQNAd9VtT5VLhB2Mtt5RuvN3YGz7O3so=;
 b=Xx6hz3W0fcHYHPzSoq1LsjG1NFeZDStqmhARxjlDnn080iYIROKbnyC2xq8vfhA/Qs
 +bdCDub42UNx33PTrbOCA8KYMBlJlg3/OwMN3n1pHf2ZVIBkS0clqZDv+KVV1Ei469oM
 oDlmUSRlwBtB5IFkBtJVahy/r44ds68BTx6lmWafOsqvmLivpkjVv5hSZJWjc42ke1uS
 FETGCzhtSbyp2KAfSxIyjh8DRw2b5sPqiLZ0A/SnYBvLQCNVf+Ur9jAAtxJZQx5XIsTO
 XOeu6+VumzEXoG63ZRT6coLqIJuTECS2syxCN3+GI6sjBAzCHHj9rQG5UtkiCrUZ9cct
 HeBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G+/yW0AVYcIgsqo4P5Z7YlqTs9DxN6cyIhHqFgeB4GVUpk97oMGE2rDqyjoXPFWnDzkJN4AI=@lists.denx.de
X-Gm-Message-State: AOJu0YwxEuar0PmkixWJ/dFEpENzPr8JF6kdmrqyYsntx7benejNVqsi
 YR1RHWq59/uE5vvJHm8yZT1++svLh8VJ3ntyhTPEOMOHmYhvMus+ZJ8MYOFmgA==
X-Gm-Gg: AeBDietTUNi91atfdZEfDtruNP+k2j+lLSEAKLzlTHyvjcWOmYJ6xYr66whC3rwXseo
 qMdUw4Xp2jm7TZVvnHOhuZS1En5EAT8ADSr1LoNID7MhtcPLfyexXLeOjmTcW7qzHqwgmdGh5Zf
 jjAjc1W9A6TxioVZCZImB05o6w6s56bDNgVRc85TXjE9+HaWwUTreAmR4i1jqn5f873oH68+zQp
 RllwwELUdzKB2yWEetee/teKdm1brJA3Q2+7SFzsJA2YlaaHbdz16/qNv2jFupaBVb2T38IPD8x
 8YJjD9dNrNiRifb69kQLf/uhNsL7E7PvabRb5i42MRrGWCDLuAsx+2XBjy/g+5kka368TFXxsxT
 JLAcFQLTQID4d0LJ69jWOh+Xm+olIeMamJvWY5Wz277Ayg76SpARcZSTOSZGzOAnnH3f+DiO6sI
 c84MLBO9adCSjEvZ2KdgWR4NrQTGqyU+jx+IiSwoD7UF02FkofWOULPcYYFb5D4lyziOyP+/FFo
 hhEBIw77ptMxS62X9QySqZJYWXveT2kGccK2nbroHk=
X-Received: by 2002:a17:903:3c47:b0:2b0:afb4:7d41 with SMTP id
 d9443c01a7336-2b5f9ea4989mr354671215ad.10.1777104457308; 
 Sat, 25 Apr 2026 01:07:37 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm250916935ad.54.2026.04.25.01.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 01:07:36 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v4 0/3] phy: add common PHY polarity properties support
Date: Sat, 25 Apr 2026 16:06:46 +0800
Message-Id: <20260425080649.75688-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

