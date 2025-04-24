Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2FAC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8028056A;
	Thu, 24 Apr 2025 14:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EFBccosw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D40806FC; Thu, 24 Apr 2025 14:13:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F0C80194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E30B33F86C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496805;
 bh=owyivrzYnbK//Mz7/hN1GsElFQqGxAFOzgv+VYSAxgQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=EFBccoswQRQ67Ycn+daBkWEnYnsrttyuJRGMBGiNGql80M7H4TE6YCnDMhOTgq+8H
 jfXWfa/smWDg9kPND1mX7P4rhAjLEh4cq+3/OL2q2gvowseXCumZ//GX8WefOX3Wxv
 CKeXDlu15lOYnF2mRd1VFDvTBS2x1cMU3smZ0NMkYfewIQcwgK88UFCbP8SwiKwGqK
 0Q72XC+q/ukCxlLLw1yfInO6Qcn6CT9k92o1qIvU/nvdJpCL+xM8yvoDVAgzJtY1t6
 F0cTF+2M6jmKNjnXHNePnDNvbDZ9faR9ZjOAjpv8xW9emApb23El6ViE741a1ac4Ip
 xq/egNCa3bZOg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so6013655e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496801; x=1746101601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owyivrzYnbK//Mz7/hN1GsElFQqGxAFOzgv+VYSAxgQ=;
 b=LJjXTmCU+MC7wQ2JyUwg/RHlpjUDYHr90z1koZUUegDViScGApJL4XYQ13sz12pALW
 5nuhOslWA9o7VT9/mr5sqy7cnKgst3Ryb5fqD6xEneEtDGSIdGFc5ss59GB+FBT5cqQC
 etTUTNXm0bzlhDPA2QlkkSnKpz5/ZkMKVa484k/4vVTRC7JBRqt1javpQaZiPedJXJFc
 hAAVHEo7z1olvhBru8hwWBmyAA8YRevE1RzTo0XDEg3VmJF90ZNWZlmCtXqeNESSvnES
 MBfhRBXE5uzbpZK0mStdFgbsFPV2mtLYQAW8FFUWouBd+sGdqG9l1zNOXo7WdkiWndht
 vm8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl6CWB0CAXGKP9jRWsaZiKP/ufG/GdPmk+wevh4IJjIFa7WVeaeSWPIvOuankOGzdyNcis8b4=@lists.denx.de
X-Gm-Message-State: AOJu0YzUbgzg8EKw000USDyKslC0GLlUHbg6au3G0rrBAUOwMdxavxrh
 drbO0gxWlMuO+05rXSKv6OQO+Nh8JR6uz8j+HRfI9BinskCr6W4yVJyx+QsQF2+WXQq7YyvmtB0
 EpNe4cDX5lGlypYsXBvYIxfckXrWUm4ki9PBTbMugSTbkMgWS3xzY8hGXSNZ7YBP89iM=
X-Gm-Gg: ASbGncvTAdyU21cE4jA/hxFL8m/NDXBPCTi1/Qs1ly51PA9mBhtBdoLeg0OD3MYt/oR
 SC8sT28lcALzgMA3d+nWMVh1X3DKf8RbvdNx2YkrtO7k1sqUMJpQLGynMYTuYt+mdWZS37+4lVr
 hB0Cb4cNOZVSLlUSccTvATmt91zM3bw3bugiKk/sVqDW37rRoPNy31AdUG5bvspBdac/PyKKnNJ
 LY96V5k0QlMrUFbUg+7gV/mH/Tl2LzPVvubrHoAuuSYhyGKIlzvANbh+WEG/TBimwGYGFwF1e9a
 MDuP6UoyQVtIV7W07TdKS1a1BSyG98mhTNnRTRz+yqc9Yjc2lxNF444prsgtVST1lsZz1PMnocP
 gX3LhanlYzgL9aA==
X-Received: by 2002:a05:6000:2485:b0:39e:e588:6745 with SMTP id
 ffacd0b85a97d-3a06cfa7872mr1954684f8f.46.1745496801536; 
 Thu, 24 Apr 2025 05:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGySUl1PCaW8fZENJ5qLwlF3RSy69759LMXeRCImHvKBZMoxXwEaaWpvyWhoAZm+5hEm9V6Dg==
X-Received: by 2002:a05:6000:2485:b0:39e:e588:6745 with SMTP id
 ffacd0b85a97d-3a06cfa7872mr1954664f8f.46.1745496801194; 
 Thu, 24 Apr 2025 05:13:21 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:20 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 0/8] board: starfive: DeepComputing FML13V01
Date: Thu, 24 Apr 2025 14:13:07 +0200
Message-ID: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

We use starfive_visionfive2_defconfig for supporting JH7110 based boards.

The DeepComputing Framework motherboard is a new JH7110 device with
upstream kernel support since v6.13.

Add support and documentation for the board.

v4:
	Correct the description of booting from eMMC on JH7110 boards.
v3:
	Rebase upon Milk-V Mars CM removal patch
v2:
	Rebase upon orgin/next
	Carve out common documentation of JH7110 boards
	Drop patch for binman config - not needed anymore
	Add information about the debug UART

Heinrich Schuchardt (8):
  configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
  riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
  board: starfive: DeepComputing FML13V01 fdt selection
  board: starfive: spl: support DeepComputing FML13V01
  doc: add DeepComputing FML13V01 documentation
  doc: starfive: use consistent formatting
  doc: starfive: use jh7110_common.rst
  doc: jh7110: describe debug UART

 .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |   7 ++
 board/starfive/visionfive2/spl.c              |   5 +-
 .../visionfive2/starfive_visionfive2.c        |   6 +-
 configs/starfive_visionfive2_defconfig        |   2 +-
 doc/board/starfive/deepcomputing_fml13v01.rst |  80 ++++++++++++++
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/jh7110_common.rst          | 103 ++++++++++++++++++
 doc/board/starfive/milk-v_mars.rst            |  18 +--
 doc/board/starfive/pine64_star64.rst          |  26 +----
 doc/board/starfive/visionfive2.rst            |  47 +-------
 10 files changed, 215 insertions(+), 80 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
 create mode 100644 doc/board/starfive/jh7110_common.rst

-- 
2.48.1

