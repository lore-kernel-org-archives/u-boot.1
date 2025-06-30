Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37584C8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43DC809A5;
	Mon, 30 Jun 2025 17:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qwB7X8aH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEAD882E40; Mon, 30 Jun 2025 17:20:06 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613A98003E
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so3011799f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751296801; x=1751901601; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=++q8iSZfMUzmAJaE8/mJyxsWvNS6F24570hR/YOg7rM=;
 b=qwB7X8aHdrhXamYTeXGzWfDNBl/fBnHWlYUWOSwvWbNBDzH5c4z4k8tesolAzbDamR
 7vtzUQcUtlz6Y5UdGQU7gMU69wzy5a/C/6ZGuVgUgobcTyKMxG20TpSz5i1aX5Wdqrw0
 dNTgfIIE8yAzgmYFKihyTcLHggxS0DVCqfyAS8sJjBhmZWkTgji/7hEtkFGkiMGORRb9
 yUFawqTu41NVXI6KywGx97vuHx7BkzbXF2ax5C521RgKYm83FZLBl5q2qtOlGFjLl5RB
 9XCX5jP2HPZJEYukgPZCnGdvX1zf/RTOrzfAZ+Qr+S3rUGi0ZBSICBphNSsXqjVxPK/D
 09qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296801; x=1751901601;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=++q8iSZfMUzmAJaE8/mJyxsWvNS6F24570hR/YOg7rM=;
 b=TFEgcuUrKTg36Cl/QGwAI5fFqsCM1bqpStPmt8rawjBpO6bV9GAaIH2uD18JegFzU9
 rZ+q74ATzIuaJB6LdF6n+KiHLFtMKcqnGj8sD8BsUhSNXerZqyQQ/F6BaJ0e9Ep5zCQW
 OtqEM3mwXMJgE0Lw5X7gledY5lH75ZxphvwSDy016J38A8IoOsPUspmDgmEcej2qwpm8
 Rn4yAUtdM0z1Lm9RFMMkGiw0ByxScJEYUJENZPa5mnwTte1DssVKp0fxMduSC3+WeTo5
 A0X0PNPSXNa76XlHJ0N7TQr49IF7+j7kpDtH2AHLrlIpR24ICvTdKgjxunzbX0MfCWjX
 lvCA==
X-Gm-Message-State: AOJu0YxlKMHNnWPyvrXJmVO9/0P3H8EPqWOfe9D4j+xRRoKYAIcXQTSg
 viIWSxD9R8OQvnUBhAAxzGcIFd3/4NFhfQOp6lveWuOVB7pJKeKg+s0kTStxbhuNgHo=
X-Gm-Gg: ASbGncvd6EmSD+unshXgtcGJZOf063QctYBxU+MTWSdp0XxZCFgzhEz2zGTGZmLZ9yN
 cjW84DWvnQnmLc9Fbv7A29ImMhWxox+QHpOh7tk/ztbvwBJcYNH4i1sP7+92eZdTR9E6xKCDCJJ
 Ci6SOLx4y2Ur7U/eccxoK77OKqi9bZnJ0aZF0RofaboxWsS/xO+P1D6YUhkF+cKITuSCCElCjDo
 xghUbUJTEshafWkIVP+OplYXanzOIGrUjHeKwzK8AJyYNA8InQSI1bmPyH0AOtdqCa0oYH1VdIP
 M/bmIPuPjIgYJjqndmatMoQl2Fw/TzwiI82yaQd50pGg+rgoKTequnsbjc2y5nTYDW0P7ZweJ/V
 Jhb5/Zi9lxoF8cq7nCQ==
X-Google-Smtp-Source: AGHT+IGbt6YcMtmyg0Er+nGJ2DyV+Pw6XOEkOx89nBlBe+alpwICg6I1ln1DfN/0uBMketOEf2tpGw==
X-Received: by 2002:a05:6000:4188:b0:3a5:8934:4959 with SMTP id
 ffacd0b85a97d-3a6f316239amr11357202f8f.27.1751296800686; 
 Mon, 30 Jun 2025 08:20:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad03asm170432295e9.23.2025.06.30.08.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:20:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFT v6 0/3] fastboot: add support for generic block
 flashing
Date: Mon, 30 Jun 2025 17:19:56 +0200
Message-Id: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByrYmgC/3XOzQrCMAwH8FeRnq10aVI3T558APEmHrZ+aFFWa
 cdQZO9uGYKKk5z+CfklD5Zs9Dax1ezBou198qHNQc1nTJ/q9mi5NzkzEEACRcm7cPWauzp1TQg
 dby5nrskWqA1VAMjy4jVa528jumfbzY4dcvPkUxfifTzUwzh6mdWU2QMXXKulclAYLNCtL76tY
 1iEeBy9Xr4NEmrSkNkwFTaWSqgcqh8DPwyASQOzUbtlLilIofkx6G2oP39QNkBIkqXV1Ej4MoZ
 heAK07c5BhgEAAA==
X-Change-ID: 20250408-topic-fastboot-blk-c5e14cd59224
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3191;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SpRPPnHnQbBNMvAd9bQEsl9kpvlS1pJsT9d+SbwO+cs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoYqsejgNHAbm2sgDDaQE0Km3+UKrkkAy+u8/GlKcn
 zO+CVx6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaGKrHgAKCRB33NvayMhJ0fcSD/
 99aakWsDP2HfikkXKCtazQh9KQiYxZv6wtOH6Kw+++Poy+J3DfJHLVIPfKI+YdNqlM6cnJLcs4as+B
 pKTOtJVGLUG0uRFLkNqlUH8n7ijwgdYLF1MpJRNs8bkpWl6kDQitWGNzJ05sMKBah0edQA1RvEJGE0
 Bo3xlFY8275iNWExcCunf1fDEu2QFDH/TGlerAeBAThU+ISrEcw+6zQ0JZNkNP+PTT0oVb17H4Vm4f
 AtdF+LTNk4Tc2p4NFXgEAZitk6rp7bd/AOX6DnBZCv2EXK0RzzsB2spiQsBob5pkSOzuIb+/0esnOh
 R9NH/9lcH1DV/rypHObUOoyh8tkKDE3d8/gzC/M97WY7RZlfz7XaPsVI4qc5HzdgjjpEcpVjhyw4at
 vY4wAShsHDhIPnDuPeakjf/PORTRVz98LIDh/f3JBlFc24b0DjansCzxYASqEdpf6cJt7TW+CyhKul
 8WODww+Lycxrqu84OOHrZvjgt85Zcd9/Dh6xV2AWLBCKv3Mrb069kp8mob5I7qOHRbxoEJ0q1bXnI2
 b/eG0wNGDQDPT3miyjWQemezJvYKC2bLTYNdVEV7/05k9n1rvQR3FTMJ22qKd0mGQAAh21HXpz9srA
 OlmFETqi2ET6dSwcEiEV+VajRcWEMlCg+x+be/9yM2tRBdzWjClTsQl5/AMw==
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

Before and after patchset:
$ tools/qconfig.py -f FASTBOOT ARCH_SUNXI BLK ~FASTBOOT_FLASH
 1 matches
 CHIP

The CHIP board disables MMC and had FASTBOOT_BLK disabled to
save memory, but adding the BLK dependency made FASTBOOT_FLASH_BLOCK
enabled on boards that didn't want FASTBOOT_FLASH enabled at all.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v6:
- Fix BLK dependency that can affect SUNXI board with MMC/NAND disabled
- Link to v5: https://lore.kernel.org/r/20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org

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

 drivers/fastboot/Kconfig      |  32 ++++-
 drivers/fastboot/Makefile     |   4 +-
 drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  22 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
 include/fb_block.h            | 105 ++++++++++++++
 8 files changed, 506 insertions(+), 206 deletions(-)
---
base-commit: f2220962f9cb1366bfc003ec2cc5650499c68895
change-id: 20250408-topic-fastboot-blk-c5e14cd59224

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

