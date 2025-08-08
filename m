Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A2AC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FE2846F0;
	Fri,  8 Aug 2025 14:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7WKWYS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6354B846F9; Fri,  8 Aug 2025 14:52:32 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00C3846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76b8d289f73so2054246b3a.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657548; x=1755262348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/xe7O8lhQQU7dOHOfqiqafpxBgEEEpgC4Ll8Lqn7Zlo=;
 b=M7WKWYS57LfO6MMKLLjpU5OJoQjY88dr/6nJfRWbIcWl2/wIrmA94w0QuJdrfUii0d
 jQ88Hyb0noOh8nlfi8PANi5+8h8rHTlOUnQOzmysYS0JvJIgkO8BG0Pgxh7KV3yp/IG0
 DjHA5yc/bdlZj8xOxsr3TR5rKOinBJQTPh6jpXqo+kgRTwxF+JSUZibRNPTqbsHktm3k
 jJUxZWZpSUR1DNTezeoloKycjqdW8oNkODbo6Vn15OtzC5Xjx6D9ZNbWO0VK8sESFVOt
 Nqhzrx5KO+eP8KCRGyJPLPHha8atUzvOT4LwC3StWKVnNHjggZ0TZ/rP9KQJc0Lq6qEO
 ExPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657548; x=1755262348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xe7O8lhQQU7dOHOfqiqafpxBgEEEpgC4Ll8Lqn7Zlo=;
 b=GGGJ+Yh0TgHBC/SqbhH6xjaid4apYN7OJN+mYdrPSRtPD+VXCXSJmt8j4F8NlMzLit
 CAdXfkzjXfLiXC3vSVqiFdYlkZomiT3k6UOe/CSpSXIl2reR67t4t863A/8jlzaRC2ti
 gadM5qAJw5hThgGNFHUHVT3B3PG1GUwXcj+ctavRN4qk6eFw5WiVOOyL5aDxJvj76FrQ
 uS+TNHoUXtr+yd7TUV8Sak8JKVGAmibcxgle0oEnbikBIN+hUNcztqVUu8Pb4EK+nzXN
 /tYsGm+lRFecH2QfNaV3GVOW1JhMp8C9z70Dr3QLpP5Qt/FiJ7eiA3H1WSaK7YI9UFh2
 WTVg==
X-Gm-Message-State: AOJu0Yy2ixh2XMiWplETcvzWKCb+X/Ev39gx+LgGSFJXvAOfL1IEFzOy
 sDV92/AdArkxbl2N05KJy6DUITNmjyv0hMXQvdzzfZ/sJC0tBWMPsrIn
X-Gm-Gg: ASbGncvo4AdQkti4tj52BPh2J55F9XYkd/tCSGaW5CnjPR6K8uRpd0FElbw3kd34Mz2
 tH4L6bU5tcm/hmohz3zHUXMyyiMreloFieWNdZRliHXkVEfRazhJj0sLHNW7tAosEjJXzcxn+p/
 wcxAg1T/s+5Hgq0oDO7US54iyhxfwjRQw7X6oe7gnXb8bpkf/dmEXtRclF4y6Un7Lc0uEA6b5xS
 1Rgcl/XednLGpRWqT7YfcuBa1ECijwFB7//bSwwN512sU1n0MM4srrEcYdwSO46KGMKj4bLQgfy
 L36+q7kP8QcW9b35aCDpR5HsA2+bklIwsOTOn6DqgLiXwwgUMOlu9KOiZWForsA0QE5szaBbdHu
 ut5PoRpHAOM2k6eHFCxT49ZsgU4jZ4leZhiU=
X-Google-Smtp-Source: AGHT+IEHPdUh3hoeFNUXNVpAw4ZQ6yXE3NhIxTyLwHi055xzq4c6hQr03KWQ5ZKCStT7n80ZXFLWIg==
X-Received: by 2002:a05:6a00:2e89:b0:76b:f6ef:9729 with SMTP id
 d2e1a72fcca58-76c461c81a1mr4523564b3a.21.1754657548099; 
 Fri, 08 Aug 2025 05:52:28 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a98:a013:5d17:288e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c09adf8efsm11962300b3a.68.2025.08.08.05.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 05:52:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250808
Date: Fri,  8 Aug 2025 09:52:23 -0300
Message-Id: <20250808125223.325211-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 3526f990b77fca1c933f1d8b24eb9385010a05bf:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-08-06 16:07:17 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250808

for you to fetch changes up to b6e2cfca1a6fd10c8f12016a40d690d2ec61796c:

  board: phytec: phycore-imx93: Add VOLT_LOW_DRIVE frequency fixup (2025-08-08 08:28:06 -0300)

u-boot-imx-master-20250808
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27314

- Several Smatch reported fixes.
- Enable the temperature command on imx8ulp-evk.
- Fix mx8mm_fracpll_tbl.
- Make optee packaging optional for imx8m.
- Reuse and export low_drive_freq_update() on imx9.
- Enable USB OTG ID pin pull up in SPL on dh-imx6.
----------------------------------------------------------------
Andrew Goodbody (4):
      clk: imx: Free pll on error path
      cpu: imx8_cpu: Provide default temperatures
      imx: scu_api: Remove unnecessary NULL check
      net: fec_mxc: Set error code on error exit

David Zang (1):
      imx8ulp_evk: Enable temperature command

Marek Vasut (1):
      ARM: imx6: dh-imx6: Enable USB OTG ID pin pull up in SPL

Peng Fan (1):
      imx8m: clock: Correct imx8mm_fracpll_tbl

Primoz Fiser (2):
      imx9: soc: Reuse and export low_drive_freq_update()
      board: phytec: phycore-imx93: Add VOLT_LOW_DRIVE frequency fixup

Yannic Moog (1):
      dts: imx8m{m,n,p,q}: Make optee packaging optional

 arch/arm/dts/imx8mm-u-boot.dtsi            |  7 +------
 arch/arm/dts/imx8mn-u-boot.dtsi            |  7 +------
 arch/arm/dts/imx8mp-u-boot.dtsi            |  7 +------
 arch/arm/dts/imx8mq-u-boot.dtsi            |  7 +------
 arch/arm/include/asm/arch-imx9/sys_proto.h |  1 +
 arch/arm/mach-imx/imx8m/clock_imx8mm.c     | 12 ++++++------
 arch/arm/mach-imx/imx9/soc.c               | 29 ++++++-----------------------
 board/dhelectronics/dh_imx6/dh_imx6_spl.c  |  6 +++++-
 board/phytec/phycore_imx93/phycore-imx93.c |  9 +++++++++
 configs/imx8ulp_evk_defconfig              |  1 +
 drivers/clk/imx/clk-pll14xx.c              |  1 +
 drivers/cpu/imx8_cpu.c                     |  4 ++++
 drivers/misc/imx8/scu_api.c                |  3 +--
 drivers/net/fec_mxc.c                      |  1 +
 14 files changed, 39 insertions(+), 56 deletions(-)
