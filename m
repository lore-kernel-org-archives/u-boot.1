Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AE9CFA775
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E0183700;
	Fri, 21 Nov 2025 11:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fnn8LP+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72959837F2; Fri, 21 Nov 2025 11:53:39 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A00833C6
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso8807215e9.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763722416; x=1764327216; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5EffH+Sdlivl77NvB6QbEq9ulL7FOo/UYqbb6ZD1auc=;
 b=fnn8LP+QsEWgUWKjTgJM+b45ng2DaMrfgdf+Lud/hamJX/Bqggk5o2YHiF8G+/zaWg
 i5KnBTRiveZHmBNRNMAayHHFVnkYqUFHuDjYKDSfbPHqoPdblBdl9ks6hrCUTBc3Zlmw
 Vtmpgm7lz2tELEr0rfkmW4zdqv+eIJub9/s5wlsUbOp5GolmBMig4HBHdE6R/Al98Ha0
 16yJYfztTcUdZDN1LmG0FsgISYIbDthWumhaxO29AZh8kh48Uv8cN9ecKRQZXUlQM9cz
 vdgv7TxREmgZGsLcZviDotoKIS/JMovJSUUN47VgTpsl0u2FwUUNvsaqhpBBXFJuUkHf
 4+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763722416; x=1764327216;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EffH+Sdlivl77NvB6QbEq9ulL7FOo/UYqbb6ZD1auc=;
 b=U3lpvckKjvoDT6wKHsQHIxn6DlAfYx0Bl387ci/Gc02x7wrnVH7ZGiCVHnUOT9VzM7
 DhfXWlMvooduafvA32QMlWXrqd1jxGOzwR2rOm1DP4VsveAgMA5venDXBM0HCvwivU4Y
 u5p5Q+X0L7Pq93QTYaq4jPxPwiLepZVi0lYoe9f2X0ZORTHMvnjzPX3GSnBp194iKMoJ
 49pffRtrui19mSU2FFPixKlndwjJIpSL5uU+7Mc4e71wrI+ZKw3iUUM2xpl58SIqO5Yh
 hyAEVVPhAeT52sIE2hzlEUUkgsn0qd6qmv0mrv+2rk0uLECT6ufdi1aBA7LYo/jluKOw
 PjEg==
X-Gm-Message-State: AOJu0Yyt6SPMhUBoCoCVFH1q1I8lqD8J5fpzOP62VnOaaKoUjha0qkFx
 VRTapzWOlcjcAwcHM5jjne1AsvFGt3Kl086oFslvB3d3hbRz7Y3A+/Xd/xKZqbTf/rl9d4yboKS
 /ioW/nYQ=
X-Gm-Gg: ASbGncuXxrLKV28Oou/RGk8V2mTmHFEcrAFkGnwJRCfNdS6E/ILxaSfuh1aIvTY2beA
 NgljcMl0Wfz4rKusYEu+fH7kNqzq/faAn7N8r5OFocEdYd2PDJEv5AOMPrKo0CIarJvJIbGyr5w
 ZYaQYelUJBm86ZBd/Nj9FIETIF2K9Xw6W8DazdxhXDubNDQd8/Ln7rUpCoyLDk23Kf3Mo3fGrUM
 RlC5ZsLqMk6V5A/0T/ib7JKN3lt8WD8VXdJ4a8kHNP/UbIswsP1OuJV8N+tPYWOu58rCOET7Crv
 sUMgWdMsp88qNnO3EynxCnvOmjoi9vEBHQHIAHLFWK7c6ADW0S1Ch0JZWtTJsqVn7uEqkcRWbzg
 OV5HpWNtqwGlq/0YRi31+nGLfuUqyZWpymgppvd8eigbMbHHTjll5kUHpu/qQBP5z1nRVywNkGp
 urOu/yW/OUODFnGSDI/r/+FcVMor4R3kQ=
X-Google-Smtp-Source: AGHT+IG5ylKqRosjKb5BRJMStwKzZJWT9RlvkDPz7BX6eLq+4nL4DoW3d3UFkTUliBK6MoV5IEWvkg==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-477c114ed70mr24633295e9.24.1763722416400; 
 Fri, 21 Nov 2025 02:53:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de46cdsm80985285e9.8.2025.11.21.02.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 02:53:36 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFT v7 0/3] fastboot: add support for generic block
 flashing
Date: Fri, 21 Nov 2025 11:53:30 +0100
Message-Id: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKtEIGkC/3XPzWrDMAwA4FcpPs/FkSU72WmnPcDYrfTg+Kc1K
 3GxQ9goefeaMGhHMnSShD5JN1Z8jr6w192NZT/FEtNQE/2yY/ZshpPn0dWcgQASKFo+pmu0PJg
 y9imNvL98cUu+QeuoA0BWB6/Zh/i9oAf28f7JjrV4jmVM+WdZNMHS+jW7LXMCLrhVWgVoHDYY3
 i5xMDntUz4t3iQfBgm1achquA57Ty10AdXKwCcDYNPAapiga0hBCt3KoIeh/rmDqgFCkmy9pV7
 CylBPhhSbhqqGti44aQB1+/eXeZ7vtYjsa8oBAAA=
X-Change-ID: 20250408-topic-fastboot-blk-c5e14cd59224
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xfPj5eXXmQCU26G2QCcEHEuscxJr9fgxl5MB3r1pNBA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpIEStw2asvzzFm4OrFUBUx3UcHeobLee8B+UQnzmt
 9HoJH3eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaSBErQAKCRB33NvayMhJ0aj2D/
 9PL0kkSvGBpn9H1pUVfggAE3wbA8D0RnDWq3j4xUKgyIYU8CTVrsnrSG5VYkx4Jgmo2or8TSoy5XAo
 AEaRZzwjHbUyivbSL2SsNxKsGvpy3/Al0qKuhhMPJWn8dy7ltrmUeuzEJWseOoApcimHni83OlroF8
 DvxbJ7XH7KycMshJuKkL3F6Es1NfQ+DJXWJhf+EvyrSHCdOTwUiMI9V/akKzkTis306uYT5jimZOGq
 X3L356SXf5X2KDlzKGEvlFjG8HyUQL6GHf3dMeLYHJllcFhSwLis/vNxFL7MpDRFl+7H3Fgudi7hP0
 Dz23fn4t8FupPqwTwO3I75lvopH7pHpzy7KAUNi4qfWpr/Ji25b3E1uizc+ordUMJYmDYvXf6RmACz
 XvKVu28iid+9571DrEg5RTpW8n7/hafD/hXo1WTugiY5wiYZes/V1Axpy3CIzhPUj4HRAHpJWOtLo4
 087w9M4BxPe0cKdoZEgDAESPgTqOtPUAv2eVsoH+WfP/V54ZcSeeg7b0yaqYSvEN+NC4iWH0qg2LcP
 Z7QI+2CdkpzWz9f9yLGTiUkPM1X2vUE+8e1/b2ZKFFQtiwXHBe9jQhAgFLaaeGsqMlNYdU8rvjdRxj
 Miy/rLuYUt6lojzjGcaIXuy+AMoF1p0OflbQ9y4Z71xIH+NyV33JWyBGp7wQ==
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
Changes in v7:
- reordered includes
- used lbaint_t when possible and removed min_t and type casting
- rebased on next
- fixed typo in commit msg
- Link to v6: https://lore.kernel.org/r/20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org

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
 drivers/fastboot/fb_block.c   | 322 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  22 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
 include/fb_block.h            | 105 ++++++++++++++
 8 files changed, 505 insertions(+), 206 deletions(-)
---
base-commit: 8ff90aa64b730c3f511921d4ff79e9f64e625867
change-id: 20250408-topic-fastboot-blk-c5e14cd59224

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

