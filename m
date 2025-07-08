Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0696C83F0A
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4710832F0;
	Tue,  8 Jul 2025 17:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNtpWcI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC49E83285; Tue,  8 Jul 2025 17:25:06 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB1683285
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae0e0271d82so914902966b.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751988304; x=1752593104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i1ZEDxATALSWycQ5Snokzw9olDl556jwvz6R6lByDLM=;
 b=BNtpWcI97pAbNalWSAfNmlNLaRO2Tn0f8Zjt7VaW7ndmTwv0JJza6f2H10ZaUL4ljT
 5DsrvDaeptftFkxHub0Uc4M8MLgLFY3rdO8YP26+Y42pLp0wHO66KqJZeWri0Hz66JaC
 d+GvEAY20cpLgQ8uC3yOp/jd4yJ/nT9PX3nchctKjTf7osYP6rzQkGt7Sm9yzGCsCTC0
 bXcZa5Oz8IDn76GHVYQR2R+NipbswULi12XM6jiNrPKkpMFIAq0YxM6cBszzO3ygEtHX
 +hrYBKiqIhH4xBv5LTI+uGN39GuTK4fcuVQoX05LLcl4PkRLmfL+OAB7hTchPivc9Ye8
 UHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988304; x=1752593104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1ZEDxATALSWycQ5Snokzw9olDl556jwvz6R6lByDLM=;
 b=QdGQMDGmttHcKOPWWA0os75MswqvgshKPajkC35U5YImay4E+nKhOefp5dVcGGzkOQ
 aijs+c3Voe8u8qEv1ssuV6VvCKlRPW7TAx04c+v8lYYxD475XQgLsku4BpJgb4Ct+1W+
 t7CvG50qysCShTBXkgnjdArxSLvwYvPqMd/Ip0P2IujsbYXHLMrQUH/K9DL4m2u0CoTe
 XGrBoeynl8c+bttRzEwPxBWIl7Ni3OQmnZ+4BFaFDUXFekM0/dt6D00nZgeuZ+zSN4pK
 N6LSJnyde1yre6lHjqHbaHUNbBcxzEb1NpyIYwyB+DZZqYoaUae4jLL7dl3g7FNEz4ma
 gZZg==
X-Gm-Message-State: AOJu0YwDqQnHCdRLiiwbTsof5PRH5NyOAK5zljCwcdUbZk65JRUUk1EU
 YB5hqDZ5i3lRiiyEqO7p4/t64TnbBIsfHasvQ64Tz6Ls6/YpR3BRon6RQpbp2Cxi
X-Gm-Gg: ASbGncuKh02MYMCbe97BMx+ttgUwssCaYQxKtNbQNFjwJCs4x+pzShGeZp6W29Zje9O
 XNt5SZz2Oz7KNc+Wph0Vfxv25A/b1Tc/EZIP/g/wX2pahwVSmis5nYdySOG+WtrvWP2uIzo+wN7
 q7Sk9iJWTy8gwQeehlBrtsWb/wGItVVNI1RH+1ExymbMkkj243ONHHF9lBC8/JX6PBE/Woz3ywS
 qGjojxr/Xcv1bF6M2iaScf52BI202+foYof27AcGSltVeG+wHcB6+t3iaqknL9oxwnmFhGGqTQ3
 m2tvfXxvq6LRkZw+fZh8I4w74/iiH/GdeqDSdJ9eKTRLGDXpZdp4R5Ouh/zNq06KWnwaUamcSAU
 =
X-Google-Smtp-Source: AGHT+IEyu3+eCbxvJf3aoK1cUwh5Zk19Mx8t6pOweMDzqP9bHDyUmhLoVxXSfoD625wWiTfkRZ7c/A==
X-Received: by 2002:a17:906:f592:b0:ad2:4b0c:ee8c with SMTP id
 a640c23a62f3a-ae6b06f28b1mr385469566b.35.1751988303579; 
 Tue, 08 Jul 2025 08:25:03 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm921950666b.10.2025.07.08.08.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 08:25:03 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v5 0/6] Improve user feedback in case of FPGA bitstream load
 failure
Date: Tue,  8 Jul 2025 17:24:45 +0200
Message-ID: <20250708152455.1214487-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:29:30 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The main motivation for this patch series is to make the `fpga *`
commands' return message more explicit because simply returning the
command usage without indicating the root cause is not helpful.

In addition, the sandbox_defconfig was amended to facilitate compiling
fpga-based sources and various style, compiler errors and warnings
have been fixed.

v5:
 * add new patch 5/6 to fix Wstrict-prototypes error, reported by clang
 * revert sprintf format to original in patch 1/6 zynqpl.c
 * remove Kconfig new dependency in patch 2/6, fixed upstream already

v4: https://lore.kernel.org/u-boot/20250705205710.792370-1-vtpieter@gmail.com/
 * make better use of prefixes in commit subjects
 * change patches' order to ensure no commit introduces compiler
 warnings or errors i.e. defconfig is now patch 5/5
 * add new patch 4/5 to remove compiler Werror=unused-function
 * add an additional Kconfig dependency to patch 2/5

v3: https://lore.kernel.org/all/20250626093519.115655-1-vtpieter@gmail.com/
 * enable FPGA configs in sandbox_defconfig instead of new one

v2: https://lore.kernel.org/all/20250626093519.115655-1-vtpieter@gmail.com/
 * use log_* instead of puts() which is now preferred
 * harmonize user feedback format; remove useless strings
 * add a sandbox_fpga_defconfig; amend fpga Kconfig
 * fix various compiler errors and warnings

v1: https://lore.kernel.org/all/20250626093519.115655-1-vtpieter@gmail.com/


Pieter Van Trappen (6):
  cmd: fpga: improve user feedback in case of bitstream load failure
  drivers: fpga: add Kconfig dependency
  drivers: fpga: correct compiler errors and warnings
  drivers: fpga: cleanup printf usage
  drivers: fpga: fix function declaration without a prototype
  configs: enable FPGA commands and drivers at sandbox_defconfig

 cmd/fpga.c                | 101 ++++++++++++++---------------
 configs/sandbox_defconfig |  20 ++++++
 drivers/fpga/ACEX1K.c     |   1 +
 drivers/fpga/Kconfig      |   1 +
 drivers/fpga/fpga.c       | 103 ++++++++++++-----------------
 drivers/fpga/ivm_core.c   |  13 ++--
 drivers/fpga/lattice.c    |   4 +-
 drivers/fpga/spartan2.c   |   1 +
 drivers/fpga/stratixII.c  | 132 ++++++++++++++++++--------------------
 drivers/fpga/stratixv.c   |   2 +-
 drivers/fpga/versalpl.c   |   1 -
 drivers/fpga/virtex2.c    |   2 +
 drivers/fpga/xilinx.c     |   2 +-
 drivers/fpga/zynqmppl.c   |   4 +-
 drivers/fpga/zynqpl.c     |   4 +-
 include/fpga.h            |   2 +-
 include/stratixII.h       |   6 +-
 17 files changed, 198 insertions(+), 201 deletions(-)


base-commit: 1323b480a6fc053475901a90bdaece2ddcc47310
prerequisite-patch-id: d13ffa9f16b79939ca26d5334d15c077c11427af
prerequisite-patch-id: cf4d9931473e7f673dad6a4e7c23fc3fe4678408
prerequisite-patch-id: e6885654262d1a9ddbb8d33e988be9c7c04a95cf
-- 
2.48.1

