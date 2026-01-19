Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C949FCCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 10:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD7280B98;
	Mon, 19 Jan 2026 11:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vu630gwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B35683015; Mon, 19 Jan 2026 11:56:38 +0100 (CET)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2697A800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 11:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2ae2eb49b4bso8990023eec.0
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 02:56:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768820192; cv=none;
 d=google.com; s=arc-20240605;
 b=KVZh5h5Mddhakjh+KqiPolFH3IDXDXGqzhneJ2RHR+Y5RMfLZnB71NGam2iI5Dz8Dq
 JXm4mPUiGIN/u+CUWw3k8UyJkGZFDzkLPyTvxRQ8aprT37FmMPuESPo2NBob3pWljStF
 nWFMe0u6In6mHv9LYlv9mmKEXWOAGEcyL2U0c2RK+w1QOxLHwxw7ymKwCxqjPCvSG7m7
 aLw0JFCRsl1s3Wc6cxDY1bq/je3BxVOycCgGuHgmYTwmbVBmM7CBseJzFzYu9VcvD7Jh
 NKwuiyN1WWeReE4rwRjvQauV69Y+ML1tfwQWiyqPmv8FMl/Pl4ayV7qKmNuJPu5vFQrQ
 UVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=cVSyioCfsXNQbtsaP4eoL13SBHbiQHd9lZUU3jeS2F0=;
 fh=DxhmNZbDoSh5MCWzSZBKsZWvbznMZzP/fcQ85hnHTJo=;
 b=a1JHkxB95UANfHQK4qnHw24ThNlDN4MwDK0nXb50FCOXnAMKpM65TRLd2Iczi25S7R
 txXhBEeGeUyDQQwNwuUKjvqhgv2HvU1SyAEQBeFzeNDzXQoaH2EF+sWJPw6dHpauqqWG
 xXBIttngD7kkppcWEYruVqT+qnYvk6sD0T1LcWvX8Om6CZZLD85ZlkOk8u2BJhds3GMV
 ygauz63o8LqgPea6Tx0Y2zvfGMXo0izaUTZFvlpu0MfS3ksnzPqXfPru+SZxZMhe/vTi
 bkNCKZH0aJxoVuFkc6EJi3odaRpBFSl7hiVc9jXAfMcPWP/moj0NDdXWUj2t8QNnQClq
 937Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768820192; x=1769424992;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cVSyioCfsXNQbtsaP4eoL13SBHbiQHd9lZUU3jeS2F0=;
 b=Vu630gwFdSlslRXihrF3D1hbt2yPB20fUWxUWLgXnOdBAO6U4VO0doV0kEPY7wBRKH
 UuMSKFTyu3MBVOAhUVeEVrB5z6Jo41tBL+tDlG5LgQyp0RV/1EHfjbJBrAo2OQ4mmgae
 q3lsqj2hg4z3eJPZWCx9auwT7ChafYajNVfG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820192; x=1769424992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVSyioCfsXNQbtsaP4eoL13SBHbiQHd9lZUU3jeS2F0=;
 b=c+eYtYJrvqOGZxF1+zZq/R+4Ng3ugMfeph78GiAjtvL6Hswh4bP1UgH5Gf7ZR30/RL
 szcLrKJZxLg0Z9CGdG2xyFkIPnIYK1k1XRoUL1ciz4/8xXe6d37Q9dgFeVE60W/5sP2R
 iHZI2nQ9VPCUYyzyFgxl/phXrPZ+JvZCxMJ0GsxPEtdy/wvZMcypp0Ohm24ewsHZZhmq
 DXECL5nN/x2hem+pXHBZ6pVAqAq64hLoUBgIRMLsa6klBYOUq3eYFTx3RSaS98WP9hVH
 AV33usRpE94YV3b4i5IdeJSjozyljisIzuIiic1GK2Ak/F0/fJNOKbhgNkHg3B8jVW2M
 5t3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVib7brK8VGUTVWxITTzv71XvZbz6Cti1qmEGDuAMqR7vUiF4jikjhzv7QJXo1Az5GGE/nlIE4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyeh1/MSHs7Z5EWEQb1DcAejKHRpPd5vnXeGv7fKrZIInUdC+RN
 cxH60rGmuH8mOyY2u8Gvr3NQl5WGUdBxg8nn0piq3l7bNFX1wf4Hi7G655sRW8sZTxRSMH8AvBb
 t3dx1nZh85WiVlHY2iQaiqNoCkxXm+GeYi243FLiOvYJ3cBj8YGM+7UzF5A==
X-Gm-Gg: AZuq6aIKFx1J54aLmwYSByUI/8/T3DvLp/1BoFHtlBruUDY+Ld5VXUQYbUIS/crnc75
 4neJx7sy5Q+RyA3/ShCx64CI7JKPgpmSJtahrx83xNVGnGTanT94iLkPmhjupyIlKeR0265G79/
 J/wZSJ5wtC2dq/THLY0LU8VY3TT9Z6eNyYvJ86JLOUHwQ93kkfAPRLZAe06przUSOw+2XDqaQJB
 HljkhdUR+mX0o9GfuZTI/wf5p/nYZCg8qvTbbrhWPA8kKGzrQcnYrklfT3k9bvI0YjVbKpC4pTN
 nXS69gawmipLCKCjMCAjKgYZuK4=
X-Received: by 2002:a05:693c:310a:b0:2b1:7910:b102 with SMTP id
 5a478bee46e88-2b6b414a8b3mr7773769eec.37.1768820192268; Mon, 19 Jan 2026
 02:56:32 -0800 (PST)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 19 Jan 2026 11:56:20 +0100
X-Gm-Features: AZwV_QiwRSyrOyLDboK-g98FI8F4M5_oIaXF8hrJvYlfdpM-3anJhGPaKR-4MQc
Message-ID: <CAOf5uwmKKn0v5Pj6Fso=BnUjXD+7gXS-JSfPRupcdwTVy+1y+A@mail.gmail.com>
Subject: Pull request for nand-13012026
To: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

The following changes since commit 6b2d05748cf3cd6ba417a96c00602b0122e10af6=
:

  Merge tag 'u-boot-imx-master-20260117' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-01-17
22:29:24 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git nand-13012=
026

for you to fetch changes up to 466dfbb6dd6b3743d74fa623fe63de0238ed09d6:

  mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings
(2026-01-19 10:25:16 +0100)

This series provides a comprehensive cleanup of the Allwinner (sunxi)
NAND controller drivers and
introduces full support for the H6 and H616 SoCs in both the main
U-Boot driver and the SPL.

The series successfully deduplicates register maps between
sunxi_nand.c and sunxi_nand_spl.c
while migrating to a capability-based architecture. This approach
allows the driver to handle
the H616's specific requirements=E2=80=94such as shifted register offsets f=
or
ECC/OOB, the removal of
512B ECC block support, and mandatory MBUS clock gating=E2=80=94without
breaking compatibility
for legacy A10/A23 devices.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/2903=
8


----------------------------------------------------------------
Richard Genoud (24):
      mtd: rawnand: sunxi: cosmetic: remove needless comment
      mtd: rawnand: sunxi_spl: fix pointer from integer without a cast
      mtd: rawnand: sunxi_spl: harmonize register defines with non spl file
      mtd: rawnand: sunxi_spl: cosmetic: use definitions from
linux/mtd/rawnand.h
      mtd: rawnand: sunxi: remove usage of struct sunxi_ccm_reg
      mtd: rawnand: sunxi: merge register definitions for sunxi_nand{, _spl=
}.c
      mtd: rawnand: sunxi: add per SoC capabilities
      mtd: rawnand: sunxi: move ECC_ERR_CNT register offset in SoC caps
      mtd: rawnand: sunxi: move USER_DATA register offset in SoC caps
      mtd: rawnand: sunxi: move ECC_PAT_FOUND register in SoC caps
      mtd: rawnand: sunxi: add has_ecc_block_512 capability
      mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC caps
      mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
      mtd: rawnand: sunxi_spl: add per SoC capabilities
      mtd: rawnand: sunxi: move NFC_RANDOM_EN register offset in SoC caps
      mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
      mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and NFC_ECC_PAT_FOUND
      mtd: rawnand: sunxi_spl: increase max_oobsize for 2KiB pages
      mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and NFC_RANDOM_SEED macros
      sunxi: clock: H6: add NAND controller clock registers
      clk: sunxi: Add MBUS Master Clock Gating Register
      mtd: rawnand: sunxi: add support for H6/H616 nand controller
      mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller
      mtd: rawnand: sunxi_spl: Fix cast to pointer from integer warnings

 arch/arm/include/asm/arch-sunxi/clock_sun4i.h      |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h  |  24 ++
 arch/arm/include/asm/arch-sunxi/clock_sun6i.h      |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h |   1 +
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h      |   2 +
 board/sunxi/board.c                                |  21 +-
 drivers/clk/sunxi/clk_h6.c                         |   2 +
 drivers/clk/sunxi/clk_h616.c                       |   2 +
 drivers/mtd/nand/raw/Kconfig                       |   3 +-
 drivers/mtd/nand/raw/sunxi_nand.c                  | 304 ++++++++++-------=
---
 drivers/mtd/nand/raw/sunxi_nand.h                  | 228 +++++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c              | 320 +++++++++++++----=
----
 12 files changed, 627 insertions(+), 282 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h
