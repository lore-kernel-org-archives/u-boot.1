Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7418FC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 09:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A5583EF1;
	Mon,  4 Aug 2025 11:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f2zaJ9ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C02383F00; Mon,  4 Aug 2025 11:25:55 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FE683E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2400f746440so32190575ad.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754299551; x=1754904351;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UgUkYN+BQ1x3ru4jaxiYKB52gftWWFUiK8EwQM0HyyY=;
 b=f2zaJ9ravIvrUGtVTTmX8DRBukGaGjzjAXJ69XVs+wk59VSzIRBRfcA1DgQJxAxTvW
 Xmvdw17hW+nWtizeZXGHXvzddzx0b469uLfWkA79zxUbUc4O1Hlnd09Pru02Q5D9z1fp
 9MPtm54lW5bsbFHiwtSXIpjLz5X+PTQgEfchE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754299551; x=1754904351;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UgUkYN+BQ1x3ru4jaxiYKB52gftWWFUiK8EwQM0HyyY=;
 b=coVkqigw/Zxpsd65Mc7XhBWh1AUtk1nIgoMW66k+J4EEUWX8ViUkGRXAJ+HP+5Fz44
 RKBfl0QzX2bAJ8m/ko4YhoTwpzoupIM0Ky13yrlaj+XSJe5lQfOOrCXmfvX0pk7HF2FA
 B2R9Bo8mhYZIkc4MlcF5HHwNy0+03Puj/pv+ina1y/4MGVmwgKC4BfsvTJ20+Ablms2n
 nQe8qPToWEiasmuTwgPpcViHvu3IM/kcIgGapzobv9avbA5j0vbPL4r3X+81+4YYyvdc
 pqCA2rt8OnoAcqctTswMtYvjojRmPxsaosJCEsgE/CsxsAgvutIGAidn2P86LBpx8dsP
 a9Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy3fYWy+va3gal3LK1J5pgEQGuf0W8FzjyvzeCqyS3dWN1q2U82VG8eOQSuEpnnBOear19v+E=@lists.denx.de
X-Gm-Message-State: AOJu0YyYNgU3FOzdlA5cPZqGYgYT+6CbT8Ot4cFtdDEIkqNQkyMWoPlX
 CyjDpYXeN9lLuSWNh4fAqR/KV2xbS7pHfGstHi4MAUVoQ+Byu3ZjBJW4R3r08VYzlaj7IqTFqJT
 CyoslTTM69iVk38V2Ca42uLQKb26kNZaNhDUazrVDmA8M2eWRJndVYa8nr6A5O9M=
X-Gm-Gg: ASbGncu0TTZLi4Cau8BR1r24g1HtE/gw3o337H0ODjLAl+5FTS97H47KvNFowOhIpiW
 qlASUu2M51mDZ3/oSTCG7jtnVPlA2Kr+Cl7MbRqIoF6PZCUCvOajIZmzVrTgjDT2x0CgQ4kcRZM
 vWjExF2kqlcNNolYfp08Y2dXVwrIHWcNutcqMxewqfegxtvfW/Ltm5pD+W7Z4nIkYRbFYwr6BcU
 61GhYfn
X-Google-Smtp-Source: AGHT+IEN0xUwLr+hptlVtHNTb5w4g18/gTHRuE/Kj2V/oj2QJ0lFntD+bSn8BJBHB5ZQ6zAbYrxLdYasHsaZ+Ae40k8=
X-Received: by 2002:a17:903:2b10:b0:240:1bca:54 with SMTP id
 d9443c01a7336-2424701a079mr118560575ad.35.1754299550481; Mon, 04 Aug 2025
 02:25:50 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Aug 2025 11:25:38 +0200
X-Gm-Features: Ac12FXxZLx226cWd2L48HLk9ZsS0tuL1MqA3Z-oa-H1Wx7UiHKFDRN4j5dZKvBA
Message-ID: <CAOf5uwkN5cc79v8fcCva2tGie1vWi9Rkr=b=W-=n+efrKmesww@mail.gmail.com>
Subject: Pull request for u-boot-nand-03082025
To: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

The following changes since commit ae5711f881100f856ead1e76832c32b92dba93c7:

  Merge patch series "env: mtd: add the missing put_mtd_device()"
(2025-08-01 17:59:07 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
u-boot-nand-03082025

for you to fetch changes up to 8877bbe67a9be64f2735a45479df196cd22949aa:

  mtd: nand: raw: Remove unused octeontx_nand driver (2025-08-03 10:32:08
+0200)

This series address issues found by Andrew Goodbody and mostly drop driver
that are not
used by any board

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/27258

----------------------------------------------------------------
Andrew Goodbody (6):
      mtd: nand: pxa3xx: Free memory on error
      mtd: rawnand: stm32_fmc2: Ensure to return error code
      mtd: nand: sunxi: Free allocated memory on errors
      mtd: rawnand: cortina_nand: Fix -ENOMEM detection
      mtd: rawnand: denali: Remove always true test
      mtd: rawnand: mxs_nand: Ensure err is set for error path

Tom Rini (3):
      mtd: nand: raw: Remove unused lpc32xx_nand_slc driver
      mtd: nand: raw: Remove unused mxic_nand driver
      mtd: nand: raw: Remove unused octeontx_nand driver

 arch/arm/include/asm/arch-lpc32xx/config.h |   19 -
 drivers/mtd/nand/raw/Kconfig               |   31 +-
 drivers/mtd/nand/raw/Makefile              |    4 -
 drivers/mtd/nand/raw/cortina_nand.c        |   11 +-
 drivers/mtd/nand/raw/denali.c              |   10 +-
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c    |  587 --------
 drivers/mtd/nand/raw/mxic_nand.c           |  602 --------
 drivers/mtd/nand/raw/mxs_nand.c            |    6 +-
 drivers/mtd/nand/raw/octeontx_bch.c        |  422 ------
 drivers/mtd/nand/raw/octeontx_bch.h        |  131 --
 drivers/mtd/nand/raw/octeontx_bch_regs.h   |  167 ---
 drivers/mtd/nand/raw/octeontx_nand.c       | 2254
----------------------------
 drivers/mtd/nand/raw/pxa3xx_nand.c         |    1 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c     |    6 +-
 drivers/mtd/nand/raw/sunxi_nand.c          |   17 +-
 15 files changed, 33 insertions(+), 4235 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/lpc32xx_nand_slc.c
 delete mode 100644 drivers/mtd/nand/raw/mxic_nand.c
 delete mode 100644 drivers/mtd/nand/raw/octeontx_bch.c
 delete mode 100644 drivers/mtd/nand/raw/octeontx_bch.h
 delete mode 100644 drivers/mtd/nand/raw/octeontx_bch_regs.h
 delete mode 100644 drivers/mtd/nand/raw/octeontx_nand.c

-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
