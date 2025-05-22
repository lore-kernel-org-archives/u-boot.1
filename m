Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8F9C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 12:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEA783043;
	Thu, 22 May 2025 14:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GD3orGIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FCC830AF; Thu, 22 May 2025 14:37:11 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BBAD83043
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 14:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so52939845e9.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747917428; x=1748522228; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X/8ytW68GaAN0e0NZH8ZhU0CFHCKb1sKMDwRTIb+Kk8=;
 b=GD3orGICctsDh5IaZumDGeQepo28VAHgFnBX28IRG3op0SNKBjNtH93Lm8hS391jxY
 g6/tSdXENt3JsVGL7IKqJjZf6GvE5NRExsQ8/s4onftRr4gwH1c45M4DmtvYuCI/GEfv
 txw1vXDR2VApWehqGboy1l+PZcQvH3P8M2ucsTvAErrJCDH131vvPKeVRoa38X0O5fzr
 lwarL3EA5KeaV0iwLWsVNQZdj+A/vD4yLsugJC57TDo/DT92bhlmijgZvD3oCVFJIHKm
 2zzWUdHJS1MpGJo2efBTQB/lXxgbNtJL7hfChIxT9DFjIHxjHcex5UMD8ybDhhINUeL2
 b6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747917428; x=1748522228;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/8ytW68GaAN0e0NZH8ZhU0CFHCKb1sKMDwRTIb+Kk8=;
 b=iyXCmQl7ePetsKH2ZkIzE9XKTGya1hxpTP2fyg6ciVmQ4E5y4sAoRptsbk2uTLJQ35
 BachS+ek/Lp//PK+G+iWpiDWSpa2nWDIjFGEQMiTYrVs/eSzB2RCn2rFSjHsCL8IdFnI
 riH+g4mApDoDUodVXJuX+P0ZfjET+KQSW92slJMDh83YdLoL6pHpEpy0jAG634ZYIXCs
 crIfPmjyBXDSMr8wnofQMrjRyvqIW6c/obl0J4NqkEULw44oGtvxQd2X+D4aXQTSlqW1
 q+zaDCpFBBFkRlNBtHua2El0D7/PF/VxaPbKVAxKnSFXPo22H4fK3wgAbi9oyoqXjHzw
 vKcw==
X-Gm-Message-State: AOJu0YwFcUY+PrtWTPfBNynUr74IskRbcKHgvjDmjNqSneRjXxRmK+f9
 bxX4Yib/Q/6dyRyVkFgPbfnlCQzxiSwr4FEozkO2bgKUFnMY8QU8mcM6URyVEoiaTjw=
X-Gm-Gg: ASbGnctwByMsI4rk44g+GWocXqgEAIAS9K7ijr+LXHig1hmlqP+fbnp6NdlHWQqSHPa
 UQATVbBezwoZXgYo5f+ijQ3ytYabJXTPuzizJR+qpqClLI82OWW9QqnEco/WfjP/kXksUcsXy3W
 j/5XjfNiZ7wkYLTBJDHUfXmNuESqG0SdEKZsy+eBS696dwUktH5osQMM8e3kS2QaA2NHojorND/
 Xt8Kpi4X9JarLHR6wSgRZ1evODgPc8moUzSh9wFJX1n+F/sAWfLfn7pUzJw/j1oSiQA/Haa+WzH
 Bl+I7d9+aKZChoYnkdVMPGSsv6hGP6OgKYgFYQo0foEc07Zg6hhLYBI26pqfQ/+vwc9yTD3a
X-Google-Smtp-Source: AGHT+IGNVOcwDGQ9EXF3rysR1YccFKUvcGORvY2Zsv+7nh5x7EXdV4UkyhhF5M3pLWEoKscSbpY1aw==
X-Received: by 2002:a05:600c:a418:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-445198425a6mr146484745e9.5.1747917427870; 
 Thu, 22 May 2025 05:37:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38145eesm102271045e9.26.2025.05.22.05.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 05:37:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFT v4 0/3] fastboot: add support for generic block
 flashing
Date: Thu, 22 May 2025 14:37:04 +0200
Message-Id: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAaL2gC/23NTQrCMBAF4KuUrI2k0yQ2rlx5AHEnLtr81GBpS
 hKCUnp3QxBE6PLNY763oKC91QEdqwV5nWywbsqB7iokH900aGxVzggIMEJJi6ObrcSmC7F3LuJ
 +fGLJdE2lYgKAovw4e23sq6A3dDlf0T0fHzZE599lKEGpvqbYMhNggiU/cAO1ojU1p9FOnXd75
 4fipeZnMMI3jSYbStBesxaEofzPWNf1A8TiAfz+AAAA
X-Change-ID: 20250408-topic-fastboot-blk-c5e14cd59224
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fQZA54iwhjtiNW9DRTrO4Ucbw0SITUFWsPvkvBAkUBY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoLxpxJ+sxBGLXNulxDUHMQjDzqu4xs14BTNYlqLh5
 kS7X2FCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaC8acQAKCRB33NvayMhJ0dcGEA
 CKkwEr00o+fkShaiSQSJ+Itl1Mns2SzA87NKGeW+Mr5S5f5qVlZ2hz896+6XL0uDdzWRLRxyRYXOu+
 zevSvTYpM14DRBVut7pc8YwYvdKia0jm/lWIvXRN4PB0GuDQ5aoQ6bIOqBfO5X+Sq0L8s229tQTYsx
 zg4WLD0bPVEX2AkvAW2RPil7Z6bwMNd3dAV1YR00nz7WZLgTgN6CbdHLzxXxOd+59IMXUMMARBuNsm
 7+11eR2SEWfUXaQEzQTHW3Zz2rNRowpWWyV2aX2N9lwVNDvsVMaiorHfXR1vH2k6dfLsB1vIwXRNZD
 KNudY4xcy6IQ4/oVxzHccF6tY8YRo3kkwmTcqVQzIhz5qqOWw2Ux8ZvSMFS3bnS5s3kRS1LzfEFKTN
 z+oD6zaYO7wgOwtiNAgCoTH2UmU31ABB4XQ5p3bxyJWSY+aynlxkFEOmcgHKCOyo4WQYpJ04iURwe8
 RJBNEdsdMbQc/cgoxaxRp4H4cmC0uioV1vUIXWla+9oSlffbTldjWMESnf3hjymzYM7BCQHg4ujEC+
 gInhJGukO1hjkMPCerKnMVrrvAsrq65I/X48FOQn8vkhxUyS/tUqqFfBJ1qblH4pMba27f73CvsfHd
 hm9LJlaSeVFPgpZTzfc47thnpS30UkTMYY8GCdjHe7HiCdacPxPFADAwk99w==
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

 drivers/fastboot/Kconfig      |  33 ++++-
 drivers/fastboot/Makefile     |   4 +-
 drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  22 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
 include/fb_block.h            | 105 ++++++++++++++
 8 files changed, 507 insertions(+), 206 deletions(-)
---
base-commit: 0bc9b288fab3d9d143066db71299a4c047be38b9
change-id: 20250408-topic-fastboot-blk-c5e14cd59224

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

