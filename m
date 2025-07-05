Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0420FC83F05
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 03:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433A582F14;
	Sun,  6 Jul 2025 05:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BVjUCsRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B4482A76; Sat,  5 Jul 2025 22:57:22 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1293809A5
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 22:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60c51860bf5so3089223a12.1
 for <u-boot@lists.denx.de>; Sat, 05 Jul 2025 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751749039; x=1752353839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8Yg5WgKZ8QyP6UsQuxbmePntxgoUxH/UreFhDW4ftM=;
 b=BVjUCsRpZ8M/Xi31EarFCuFVTWP736WGLeL0zOhjj83Pcylhqnu4BGGu0XdhF70JN7
 FN2KDegljKwgCU7AaYSeE3ThvtKQfpib5JTshPrJQmw9RX+4r4Y6Amj+869ESefyMOyR
 1+Kryzh2c02cqDcPOG0g2468JDMbv4jLo7FoQsfbHR126X3y9KMZE1oa2/Xmg/mF/fZB
 RbZsR1VQ+eyUOAjoVoXbppeQeuC5z2S9xjxobT4HTz32sJFKtfA1/EXldRn4AeCSK/r3
 FAqOCZaKx91A0LjO5HPscfJqyc7CYNP/DxVLjy2NqbOa0Lc1Im/26Ye/JYVPQ+CfH9oL
 pYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751749039; x=1752353839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8Yg5WgKZ8QyP6UsQuxbmePntxgoUxH/UreFhDW4ftM=;
 b=IWWx2XkN7xN8Xg8+5r6IUYmMdEsTuFAh2eEaGYJwdmJg+BVQl13/cVLKojc5PAz4A3
 G9CwyLVwDIZF2ZAaDHbgD4m7CtsDpNrdhfMEY2rdhz+0hsfL0KoPgdKoN5QfYejm+w6Z
 LN5MYG9wabi5VdcDCT6M5uJI8Y8ijH6wzV4B41PLNgaV04B5XvAgXVPyKbx/86uFo/s2
 DfKEnP2jRuDkhucpVaZimcjA8XEy8nnK3FALSDiFTIp9gMqBFCcFSUO6+kHJTjppSsAX
 gKH+GupPUeMGfWXX3srCJ9Z4u/ozh7yQNSlapPVDUvt87FAD2ljtqYJjlwBG5+fdoKR4
 d4+A==
X-Gm-Message-State: AOJu0YyMhJCyDeedOXnJ7R1S/UfaBBrqsPLoUq/jriAMxPFWLklfWGU4
 4RTy9BhcSRZ4AvgK2oAaNrkeync6T0z5CSmOoAOOI3pWy+BMRsJoq9kWpZHKf0DEdS8=
X-Gm-Gg: ASbGncsKz3gPP5X+tXoKYYPkDOe2Wb0D0dBr5aPctkTLasY2hJ8uJPVtV+3ziNdaR8M
 WPv7B5CRYNbjJGQLQ1+Jq7DlwrKCXKpUqd4KZ4ruTAZ3h4r8dT9tz/ZiPGEBceLScOfGJSYDBO+
 R5TK9e8WK52ulYEdvC4ytXMIbpFIjleXAULNbh+MVCG10mHGgWzZSN0BhNC1UOXKXV4YrlYgrjL
 4KztdF4Sakca3lvNADbb0N6PZpg3LxgzwXP6j1pOe7xl8PJGB+Z7IwWx03z1jjuQ3wyiXNWcl6w
 6UhTTG0+wIIbG7Lp2x8RnPJ+EqkWOobHxUUz9dmPHcJ+uLt+SYBMFCCj3Xi8ls5v
X-Google-Smtp-Source: AGHT+IHgAuE/3HdxtT/37XBKwqgk7kDKpkJa4W4iRZcjdU4CeSHJtGxVAOLRfld0bWqj790loUnRwQ==
X-Received: by 2002:a17:907:d23:b0:ae0:a245:2fef with SMTP id
 a640c23a62f3a-ae4107e1322mr341653066b.20.1751749039191; 
 Sat, 05 Jul 2025 13:57:19 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f51sm399423666b.8.2025.07.05.13.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jul 2025 13:57:18 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v4 0/5] Improve user feedback in case of FPGA bitstream load
 failure
Date: Sat,  5 Jul 2025 22:57:01 +0200
Message-ID: <20250705205710.792370-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Jul 2025 05:50:01 +0200
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

v4:
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

Pieter Van Trappen (5):
  cmd: fpga: improve user feedback in case of bitstream load failure
  drivers: fpga/firmware: add Kconfig dependencies
  drivers: fpga: correct compiler errors and warnings
  drivers: fpga: cleanup printf usage
  configs: enable FPGA commands and drivers at sandbox_defconfig

 cmd/fpga.c                | 101 ++++++++++++++---------------
 configs/sandbox_defconfig |  20 ++++++
 drivers/firmware/Kconfig  |   1 +
 drivers/fpga/ACEX1K.c     |   1 +
 drivers/fpga/Kconfig      |   1 +
 drivers/fpga/fpga.c       | 103 ++++++++++++------------------
 drivers/fpga/ivm_core.c   |   1 +
 drivers/fpga/lattice.c    |   4 +-
 drivers/fpga/spartan2.c   |   1 +
 drivers/fpga/stratixII.c  | 131 +++++++++++++++++---------------------
 drivers/fpga/stratixv.c   |   2 +-
 drivers/fpga/versalpl.c   |   1 -
 drivers/fpga/virtex2.c    |   2 +
 drivers/fpga/xilinx.c     |   2 +-
 drivers/fpga/zynqmppl.c   |   4 +-
 drivers/fpga/zynqpl.c     |   4 +-
 include/fpga.h            |   2 +-
 include/stratixII.h       |   6 +-
 18 files changed, 192 insertions(+), 195 deletions(-)


base-commit: 7598b469c16d97128d9c22839b06d94c5c331a7e
-- 
2.48.1

