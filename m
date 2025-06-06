Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6091C5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0653C82977;
	Fri,  6 Jun 2025 11:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gZlAwYMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9725382AF6; Fri,  6 Jun 2025 11:33:13 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B908828F8
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1497458f8f.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749202390; x=1749807190; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hbRMx7xO/WNYAupENoycBgd68Gu0KLorhIDOr5zS/jE=;
 b=gZlAwYMOKxW5uKddi9rOGeqyqppYejUVfZD7goT47MhKUIRltQ6+e8aEe9nLJu2F1d
 W8dMnH7PKWgUkE3vI7yDb3U7dIFIKIUk6VphQEXrsot0nO3uzFvM50UPHF6xOWaV2dtF
 A/yTMr4f7xJ3pgyyMtUB1KgPCZOunWcZ3Rl044lUxeIYyFmI2MryUg6KeP46OlbHGOPb
 SRNR7dz9Ym2qKE+7K2jviAaO5Bdwge9HShSsgIscrb1oa7QGW39inaXR6Vb2+h+gt4cz
 rllY8GI6fYnRV/TXiJZhrBaoErhPOAPRwe9thtVMaWmRwlZ/B26Yr/c3jTgpAS4JCAN6
 zhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202390; x=1749807190;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbRMx7xO/WNYAupENoycBgd68Gu0KLorhIDOr5zS/jE=;
 b=L7PQeZ4Y7uy+Oy+4PjQKUjcdBhNue2HYJ8p7dZ7zN5MB71pnYxNnPbaAb4Y7NTCdgs
 5rW9Xq5BVods/R/5p4U9u2VVUdTAVlqbXfVAoPId50nh+yNqECSR6hGZb8t5xNf1RvrQ
 86oR/q5azpX2u95V6ODXXb4xqctEG4r/svpznuFA+scSVRf79d+4e6zoIEJoEkufAUZF
 z8/GYb2nqdRMc/8A8rt040mCoxteFQGd/fT8qclnUmtXMDgHHJXxLpl7J/Vue92LWEca
 T+v3NWaS2HPm4+6/0WnUg0EKajy5k9wuuf9RyknogZFNRSquLSJz+mVxPonJ3PNQXpas
 4ptw==
X-Gm-Message-State: AOJu0YzNgGOUX2Oo2hiduJziAn7fP712S8j0guHjv7iIVsMUNKlnSJg9
 RGHoTBAEyMBtsJmwk1BZ4VuzeglHA8LwMNfcWVzh9TZGETrXy5w/BE+ZpXwWL4RfJLY=
X-Gm-Gg: ASbGncuPZR9RG9bbj3LwhHXQvn4yB/cNWDJCEAGqx+a58dXkxTRkztUxtVnpgMk7M/3
 RVWJU0Rubb8t2rq7gqy8MXlQ3SQoo90A1NqhjIg2pfs9nZkJBEcvmG22X5jziZjOdF1MjQoSYyM
 m5hdfWCsxJVS0fdpm3NLN03IbNVe0mPOm9ZFw78Foxy8LPmTseenAvm8VFL0MBJ+JzUBaNuU4U0
 GqWISzdNcCQozL0280WPxk+NCI+fKUs8ADHH7ERqehUSAek6WL/wIjspK5Y//l60no0/4uxbDOz
 3Nt13eEPph+i/cx2qpseVB1QVvXQPPtfmVA0qISb8xOMTj4fCd3vtZ9ITrzjM3DyVI35qsv+k3k
 nzBwRprw=
X-Google-Smtp-Source: AGHT+IFP9GdSnTSESymoP6h3BzhDmRlR5ZK2udz1n5aq3gU1IdWlD3Bo4MzBkErHEd1OIQF1zElcqg==
X-Received: by 2002:a05:6000:4011:b0:3a4:d898:3e2d with SMTP id
 ffacd0b85a97d-3a5318a0406mr2039352f8f.24.1749202390345; 
 Fri, 06 Jun 2025 02:33:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532452d7esm1302439f8f.85.2025.06.06.02.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 02:33:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFT v5 0/3] fastboot: add support for generic block
 flashing
Date: Fri, 06 Jun 2025 11:33:06 +0200
Message-Id: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANK1QmgC/23NTQ6CMBAF4KuQrq0pw7SAK1cewLgzLqA/0Egoa
 QnREO5uQ0zUSGb15mW+mUnQ3upADslMvJ5ssK6Pge8SItuqbzS1KmYCDDhDVtDRDVZSU4Wxdm6
 kdXenkusUpeIlAJJ4OHht7GNFr+R8upBbXLY2jM4/10cTrNXbLLfMCSijUuTCQKowRXPsbF95t
 3e+Wb0p+xiciU0ji4Yqsda8gNKg+DPwywDYNDAalcnjZIwLVD/Gsiwv/KGy+kIBAAA=
X-Change-ID: 20250408-topic-fastboot-blk-c5e14cd59224
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5LaSAAcgbDSlQb/0d4GlDYa/Uc1bKNAaP/mzDvD+CZU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoQrXUFgaTK0XMG/bjoYRkjGxE6VZqL9//curCO5v5
 HbFgmmeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaEK11AAKCRB33NvayMhJ0TIkEA
 CmD8a3RnxVdwb3ouUV7XsY0Od4559xM/Mh6Ld0CQ928NUr+uvIAnXy6SzDEd7Rc7ZGwOHgsOBJIODy
 kQe91OrvpXNMz8P7hq19CldGza3lJX/uJkmB+UqJRJA9BIUKfvlRtfwsCDF1AX1JF3rEzEYT+B7zHJ
 zh8c+F9X0MuERXhC7nAa3jLHwWf/SY4f6ibBiVolUnWJE9k6clVxx3oApGA2IsH26fu5LunvQShGvw
 fhtMxrP/CdrAdSllzZtSJ1zWU4fL+zFFh05kafCRTG40zODyeIvUbcJhV8xuJ370VtCVKS/Qk0tO9L
 33zOw/QDQZxU6opCgfdV5FzujpjPQ1IIowQCj6V/X2nSWX97ve9PB80acTM4AOM+P5IMml+bI9dbpg
 3rtAtF6YuaHNbVq3tyWj3q+ikwrOJdGY5ctHX9+icHTKl7YEEa5+RSgn8uuGcwgZ7cW5Zao1CSQAb0
 nRxZYVm5yRvK2ubUrRKaUTyzi38k6bgUpIE9FTLr3j/K9SHMJnFHmptPPNr8hL2idJuRb+MRIFtkQQ
 vDu4Jh8i83b+fCA1blvOO9imMyvseJCXmXnduVrT3SL8R1zPsM5ISEuSlpUg7Dyw+WBWogskPB7q83
 sUIoa50QmS4QC2OARnrmySXWf+10nKNjvlzZp7RDRZsd3ybxqNjFrKTRnSeg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

This serie permits using any block device as target
for fastboot by moving the generic block logic into
a common set of helpers and also use them as generic
backend.

The erase logic has been extended to support software
erase since only 2 block drivers exposes the erase
operation.

Tests are welcome to make sure this series doesn't
introduce any regressions on the emmc backend.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Removed BLK dependency on FASTBOOT_FLASH_MMC
- Removed BLK dependency on FASTBOOT_FLASH in patch 2
- Added back BLK dependency on FASTBOOT_FLASH in patch 3
- Rewrote FASTBOOT_FLASH_BLOCK_INTERFACE_ID help text with Tom suggestions
- Removed default for FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
- CI test run is fixed with FASTBOOT_FLASH_BLOCK_INTERFACE_ID default to 0
- Link to v4: https://lore.kernel.org/r/20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org

Changes in v4:
- Rebase on next
- Fixup Kconfig default values & description
- Link to v3: https://lore.kernel.org/r/20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org

Changes in v3:
- Move Kconfig/Makefile changes over the 2 patches
- Relicence to GPL2 with Dmitrii approval
- Move soft erase in a separate function
- Update help text of Kconfig BLOCK entries
- Add warning at init if MMC was selected with BLOCK backend
- Link to v2: https://lore.kernel.org/r/20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org

Changes in v2:
- Dropped applied virtio erase patch
- Reorganize patches, introducing helpers first, using them in mmc afterwards
- Added soft-erase logic
- Added move helpers to handle the partitions erase & flash from emmc
- Fixed const var on last patch
- Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/

---
Dmitrii Merkurev (3):
      fastboot: blk: introduce fastboot block flashing support
      fastboot: blk: switch emmc to use the block helpers
      fastboot: integrate block flashing back-end

 drivers/fastboot/Kconfig      |  29 +++-
 drivers/fastboot/Makefile     |   4 +-
 drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  22 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
 include/fb_block.h            | 105 ++++++++++++++
 8 files changed, 504 insertions(+), 205 deletions(-)
---
base-commit: bed3b33e732f2f2d9ce93801f7dbe09a02b52c3a
change-id: 20250408-topic-fastboot-blk-c5e14cd59224

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

