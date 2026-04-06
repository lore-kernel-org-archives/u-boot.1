Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2DCF46C78
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D347783936;
	Mon,  6 Apr 2026 21:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euXJIWG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E6883EC6; Mon,  6 Apr 2026 21:21:18 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116368352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8a1e1817db6so43873446d6.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503274; x=1776108074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=La+TWJChpQPbBX8wsDqUMC3mnxOuTvDxLusz4p5xLMY=;
 b=euXJIWG1Rt9ajSumqJhw8uQcYdeKcEx5pMRxZXMRiYuGXsf6KMezRPWrMIk9OgDsAf
 Scrbi/E4Or6aVGNMFEuNrL+TZfvHccOrZGTTYf/kiIe6yYIEBBccVAAnMXAwFDea6p+W
 CibINXHD4i79q/bNKG3Bq/eb4bIjRLDj6h6PEb47fy16M1SnhQ9YZos0pURWCm+yJm41
 X14oL+EnVPz8Y89twgL/gNlWq8U5X5BHms7yhv4SZDqET/T/d03SiOzICtHDzPvbUR8x
 JrQuIU11X69tkwShJ+Gpk5OnD0HENLxA/w5VugtcO33sn5H3lRtY4Okz6+3DcFivcLir
 47jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503274; x=1776108074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=La+TWJChpQPbBX8wsDqUMC3mnxOuTvDxLusz4p5xLMY=;
 b=nj+6TxFT2KyGb83GKy7lERv6oeMEGwkSx8LCJ5h6ms+CcOaWFNkUCwc7P2wCoJBpi7
 NYkTq6L4DhRGIVB9z76JHpbLHDhAhQ2SIqkYtPqzpNI8jn1T9KY/iBJKD6AHKlv9AM1k
 R+kQegnJG0NLlzEzH0X1zEzrdZXNDM2gwoZHDSeNGMidYOTYJp4I1WLpABk6F6cnsEb4
 GhunLGcdV/30QexJBsRsDdTyMxM/zx9LdkS3s9vnLl6UoZGmfn8pHOeVBymuzoWbnycT
 oBuMLTLhw3s2CGnqvb2bIbIMIOqNXQ3skBYETzcff+sZrkCqomhS3bRuqmoTbHW0Ztss
 NVMg==
X-Gm-Message-State: AOJu0YwbSGNPDbElWRsWJLdHhqsNSWWnt4cvZXCcj2tgAX85QmXdMXgk
 +zlwDS+iFwe2xV5StQaxyTk+UMaKv3eK33ZWZRILChZNI+WM0GwGuVrr3q1hBDhQ
X-Gm-Gg: AeBDievvawZX+O0BMAMa0B+V4D353quyAgMU6gCpn/c4WQAzaMRhrrjgD80d4c9/npB
 w7hbYFfY9Db8zgWjoxZB6Lwu4jjAcCZdnvc0py6SL/AXr10YKSlbEmlq7n9cTcf5OgZsIkiMjJn
 JbpDA1OotTNzYX9fBzXHljToFSZWLcSBD9/Nph6Vd/EeESvmU6ZRxgOlCPs8nUXl4rR72SrmwEz
 yeeXQ+a9yShU5QeeViRvSoRTTMQw8SJZLMjnNnnSNa9HqTkDxQF6Cyu4aJIcHI3ESYn3WA6EX4o
 lalolkSWHDZgL20dknvi1OqolbH3yNlRfjq8ON8EfxYgE8O1mvusx/CsrgnavZcXYpJYiS0T+sv
 qC/YgsyKoLLGdfacmVppPwd887c/qtuSjAWQx7mOniJsEtrKjO8rzPl2PfmO8SoPx9yHPtcwGz4
 u6OJEDbF+qOmtQc1HEilLjw2LIS6BKEffF4Q==
X-Received: by 2002:a05:6214:202d:b0:89a:f0b:60e9 with SMTP id
 6a1803df08f44-8a7027a7dd6mr231350416d6.13.1775503274479; 
 Mon, 06 Apr 2026 12:21:14 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:13 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 00/13] sc5xx Environment Cleanup and Fixes
Date: Mon,  6 Apr 2026 15:06:02 -0400
Message-Id: <cover.1775499770.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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

This series performs a general cleanup of the default U-boot environment
for sc5xx boards, stemming from the decision to no longer store the
environment in the SPI flash. The environments for each board have been
edited to contain the minimum number of commands needed for all supported
boot modes to avoid confusion, and the default boot command synced to spi
for all boards that support it. The filesystem for the SPI flash has also
been changed from jffs2 to ubifs.

A bug with the Ethernet reset line on the sc594 has been fixed, and the
sc573 has been renamed from the EZKIT to the EZLITE to match the name of the
publically available board. EZKIT was only used internally before release.
Preliminary binman support for sc5xx boards has been removed as it was unused
and full support never added.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>

---
Changes in v3:
- Updated bootm load commands to use loadaddr instead of kernel_addr_r
---

Caleb Ethridge (12):
  configs: sc5xx: Do not store environment in SPI flash
  mach-sc5xx: Remove update commands from default environment
  mach-sc5xx: Update boot commands
  mach-sc5xx: Switch from tftp to wget
  mach-sc5xx: Add USB boot command
  mach-sc5xx: Remove preliminary binman support
  dts: sc594: Fix gige-reset line on EZKIT
  mach-sc5xx: sc573: Rename EZKIT board to EZLITE
  mach-sc5xx: Update image load address
  mach-sc5xx: Update SPI bootargs for ubifs
  configs: sc5xx: Set default bootcmd to SPI boot
  arm: sc5xx: remove LOADADDR and add kernel_addr_r

Ozan Durgut (1):
  arm: sc5xx: add missing boot env selectors

 arch/arm/dts/Makefile                         |   2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |   4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |   2 +-
 arch/arm/dts/sc5xx.dtsi                       |  41 -------
 arch/arm/mach-sc5xx/Kconfig                   |  47 +-------
 arch/arm/mach-sc5xx/init/dmcinit.c            |   2 +-
 board/adi/sc573-ezkit/sc573-ezkit.env         |  17 ---
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |   8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |   2 +-
 .../sc573-ezlite.c}                           |   0
 board/adi/sc573-ezlite/sc573-ezlite.env       |  12 +++
 board/adi/sc584-ezkit/sc584-ezkit.env         |   6 --
 board/adi/sc589-ezkit/sc589-ezkit.env         |   7 +-
 board/adi/sc589-mini/sc589-mini.env           |   7 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |   7 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |   6 --
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |   7 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  10 +-
 ...ezkit_defconfig => sc573-ezlite_defconfig} |   8 +-
 configs/sc584-ezkit_defconfig                 |  10 +-
 configs/sc589-ezkit_defconfig                 |  12 +--
 configs/sc589-mini_defconfig                  |  12 +--
 configs/sc594-som-ezkit-spl_defconfig         |   7 +-
 configs/sc594-som-ezlite-spl_defconfig        |   7 +-
 configs/sc598-som-ezkit-spl_defconfig         |   5 +-
 configs/sc598-som-ezlite-spl_defconfig        |   5 +-
 .../arm/adi/adi,sc5xx.yaml                    |   2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |   4 +-
 include/env/adi/adi_boot.env                  | 100 ++++++------------
 29 files changed, 81 insertions(+), 278 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (90%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

