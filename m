Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D20C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD44F81D0B;
	Fri, 14 Mar 2025 17:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXZ38G9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FEDF80ECC; Fri, 14 Mar 2025 17:20:04 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCDA80ECC
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so359528266b.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741969201; x=1742574001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KCBJ0YJphCs4OpqzShRN6VHAegzZakjheFYI72q30Sw=;
 b=OXZ38G9nH3A68OVAHWqWJd76KNcIkn3l27T1M4NSJEkow1IBc2o0gk4s7J5EIvsz6b
 vZiXrGHOIwkO/KAPJsoHppiMX+6rycoN0akIbBQ/UwvRjRqbEjq+YdF8HyFfWRc2mhYv
 gG/Nlln/+HdIu34Ax4zP3pEzyB70I8cN/qYt9SK8Y1sjIBm+Vpv1W4u3dm0ezFyv1/8g
 DEdwCNkD6phwlukTgBKTUy8Dg5ReC3agrHePQ+jwhcu+o9F27Jk1QndvdaskGP52XHGi
 a28U50ZFtBKGx4ysymgMkAZbdOwwch7WQoy2j4Di+mZ1h0JNRnVQ12Zuxuh5OVxvnRbU
 zP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741969201; x=1742574001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCBJ0YJphCs4OpqzShRN6VHAegzZakjheFYI72q30Sw=;
 b=l/eeZ1NLwGh8znP3/L5gonUhUwP0b0pk8TVmcfXiR7d3oVYsGbTbtby2RgALSNGt+Q
 h2b0s6b9AMG3xz0U7nLFkxYxZH66Kg6gNoNFLDULcW8vrYdrcg5kBaOj5t1AnSk52IBd
 sPACF7LBbJDnnYat4RD3b6IKhpWWIRVYGbpeF9mgcLqWXNSAKp+KndIBktyJaQve2oIL
 gv8IUrDvug3nZKS7sQRA1/20KKFfGzyjD8SxmBFpFhAGugs+RIK7jdwUZnhUMLI5z2Am
 nSZFl3coCdMcer3qdx+7oZnM0dvmdCO/M4XaGNoty2LWjEjsrKPZBMAGp8/dMPgR4SFe
 ErOg==
X-Gm-Message-State: AOJu0YwhjgzjLsbpcXXRRy85W+RhZMkRcQSyrQNA6dfM5E8YzTCt34/T
 MZ1X1t8878no46IZDAF6RYXDR6o7EHJ35e9JyBqQaCBCIp7ewl0iFZYw7w==
X-Gm-Gg: ASbGncvZtSi3u6rLaW6v2gI+YDDLB/nocrGQsmeYbLWgZIg3Ax8FQrPVWip2uHXoSmC
 LC7c2Lsi0yXSBBkJXWiYuZ35B/dQhZbSuvpgln2bpmw1INEP513+frvLF5ccn3pvISvGybeSVV2
 z0Lhl3h8XA3C7O88ualr5d0FW+5pcKHHetCZL26WD0oBDIbXJx4UFXc09tlfyTNPu90sSpbMw71
 wSpoDUdCBkMxMIPo7bQbIzK4h8pD72JiccNihAJmiJu9X6ROULKTytD1wbnTgfLvceJfVGulXzw
 agqZxzHcYvDXRtaK/RDXBHDvYAcA016O9Lz2
X-Google-Smtp-Source: AGHT+IH61+qfZ8jzjcI0CcKOREblLreBvcHZ7pzPAUT+mYL2zsOL1ablDno5oDuIEcB/7xy8QoLCQQ==
X-Received: by 2002:a17:907:8687:b0:ac2:806e:bb55 with SMTP id
 a640c23a62f3a-ac3301774bdmr316994466b.19.1741969201341; 
 Fri, 14 Mar 2025 09:20:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3149cfbbesm244680366b.100.2025.03.14.09.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:20:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] board: tegra30: ouya: add basic support for Ouya Game
 Console
Date: Fri, 14 Mar 2025 18:19:48 +0200
Message-ID: <20250314161951.37357-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The Ouya microconsole is build on Nvidia Tegra 3 (T33) SoC, featuring a
quad-core 1.7 GHz ARM Cortex-A9 CPU and a ULP GeForce GPU, paired with 1GB
of DDR3 RAM and 8GB of internal flash storage.

---
Changes in v2:
- fixed EMMC, removed restrictions
- removed redundant configurations
---

Svyatoslav Ryhel (1):
  board: ouya: add Ouya Game Console support

 arch/arm/dts/Makefile               |    1 +
 arch/arm/dts/tegra30-ouya.dts       | 2063 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig |    5 +
 board/ouya/ouya/Kconfig             |   12 +
 board/ouya/ouya/MAINTAINERS         |    8 +
 board/ouya/ouya/Makefile            |   11 +
 board/ouya/ouya/ouya-spl.c          |   41 +
 board/ouya/ouya/ouya.c              |   21 +
 board/ouya/ouya/ouya.env            |   12 +
 configs/ouya_defconfig              |   86 ++
 doc/board/index.rst                 |    1 +
 doc/board/ouya/index.rst            |    9 +
 doc/board/ouya/ouya.rst             |  123 ++
 include/configs/ouya.h              |   23 +
 include/env/nvidia/prod_upd.env     |    5 +-
 15 files changed, 2419 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/tegra30-ouya.dts
 create mode 100644 board/ouya/ouya/Kconfig
 create mode 100644 board/ouya/ouya/MAINTAINERS
 create mode 100644 board/ouya/ouya/Makefile
 create mode 100644 board/ouya/ouya/ouya-spl.c
 create mode 100644 board/ouya/ouya/ouya.c
 create mode 100644 board/ouya/ouya/ouya.env
 create mode 100644 configs/ouya_defconfig
 create mode 100644 doc/board/ouya/index.rst
 create mode 100644 doc/board/ouya/ouya.rst
 create mode 100644 include/configs/ouya.h

-- 
2.43.0

