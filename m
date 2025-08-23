Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCD4CA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 19:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB74800D7;
	Sat, 23 Aug 2025 21:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lbrbZEqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E85480548; Sat, 23 Aug 2025 21:33:16 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF6180077
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 21:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24458272c00so35031325ad.3
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755977592; x=1756582392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=23Y8JX8Pt3+t+TYycvrlKBZ/QQqOJIAV2ULNxikZRq0=;
 b=lbrbZEqrx/q429kta6JSE77S0bsJmXAM2uwCuTaWbDXYg2R1Iv0xXF4zRsEM+r0A5h
 69p8tKBkqfWJyzgRbDWWXngUJ5wcxQ0LjHMcoaytreCMgp8U01JIkVMkn2Bsxx2QSe89
 KPdvPrAGLNqNn7WpemwAgMVwbkFOcTgNtfXc2p+huftV+isQBzj/NQFBgHKjrS4n9/yz
 B+Nn4PXL9RIZmgvybaIQKlQZ0t0DQ0KqmG8FEoxs+529KmIlv5T6/8Op+RLiS2DHAmu4
 tmlpqv3YTS9WHO/74EUOirh+Md8+mSOnAHMh7C0Pzn6RLIPsGfsPVPj05M9vHwUhhbnd
 BVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755977592; x=1756582392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=23Y8JX8Pt3+t+TYycvrlKBZ/QQqOJIAV2ULNxikZRq0=;
 b=X3RIxaiV9z4LCMshriIL4D9orUci8cgZzlYLFRfeQQri5tzMWJUmj8/Tq/pbC2bDda
 SVkAWYSJR5azU1eRCyMuqimdtm8/5OBUqWdWJmZTktfln/6BxCXeeeUojrbdzMH3MlCB
 PDPgXAmdJIxpZ69szTdj7riTU4J0nhoWBwnZLmUi0H7sE/Xvvo7l5t5nf2/1XzJguCeG
 Q8WJL1cgc9mnjqZigtfGtUgTd0NA6KbIdK/SvMHEtuJVqXvV0wEn7sOhKBkV3HstExVl
 qlXKSvGV27bh5LgBd4VCcq5Q5KEzAGfJNp+DFXiyrkXn7Y1Yc/21Y5/HlkT6XAYkkP7A
 B0LQ==
X-Gm-Message-State: AOJu0YzEeMQjYyAL53ZldNDY9CRIFoOg4QJ2KT3XPXvPLRPIWIQl2NX1
 YgO4JyM4YYDLgJ/EitomvBVh7wqGMEdQwfwfTLegscv2R/8gtR7SgZqlXKflrg==
X-Gm-Gg: ASbGncsj0xQa+LVCmzpuHqxqQ+KAyAGEwd/i6/MoRLytyU+Uj5Jul323EjiLIv2WXgp
 KoTRA1a0GnMp8O05nmZe3tJK9l9QA6A+Hbb+9kymMz78E399tAzVCouVQtV7iTDk9i91GhVpXUM
 Z2Voi+HWV3cO//Fq7T17pRSD69VZsmkk1/w0LbSGMvGsmvNhh+MCcJhrkSgTnqXrNqQC0P9uSFy
 cUo17IXZNCUwMrIaXePbMQOAg5C06T9ItO87G0XtSZK1bhFVR27DiNtjuG1SvJEL0K4yG30yznw
 F6b9j0Eqf15sG32qDbxX9sVGO9KksO9BHApnT3lRc2r6FnVlJjWtejuoUmHIrQdbhzuAg05HCuE
 bL4vJHCywDUFzUEuaJfUEzv197TlOaUiz+eyB
X-Google-Smtp-Source: AGHT+IGPL/nDaZiJ3bJGPE/pTmM5o57qpp2WhHLCGsbqV+noOZYoIHRI5zbeyLKkfC+lNVFDK9/uGA==
X-Received: by 2002:a17:902:cec2:b0:246:61c:a67d with SMTP id
 d9443c01a7336-2462efd6a06mr84593695ad.60.1755977591792; 
 Sat, 23 Aug 2025 12:33:11 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:720a:4760:f024:645c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2466887fc75sm27604395ad.105.2025.08.23.12.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 12:33:11 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250823
Date: Sat, 23 Aug 2025 16:33:07 -0300
Message-Id: <20250823193307.290885-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 94e690c44a03959c39f0f5a44a9b89c851af3b60:

  Merge patch series "bootstd: rauc: Fix segfault when scanning device with unsupported layout" (2025-08-21 15:05:15 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250823

for you to fetch changes up to cb5f3e4f5288f27c44753503ca6c75bd17d8a1f8:

  imx: imx93_{evk, frdm, qsb}: Fix conflict SPL early malloc address (2025-08-23 08:21:48 -0300)

u-boot-imx-master-20250823
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27447

- Fix the environment location when booting from USB on i.MX93.
- Fix env location when booting from USB on phycore-imx93.
- Fix conflict early SPL malloc address on imx93 boards.
----------------------------------------------------------------
João Paulo Gonçalves (1):
      arm: imx: imx9: soc: Fix env location when booting from USB

Primoz Fiser (1):
      board: phytec: phycore-imx93: Fix EEPROM bus mismatch in SPL

Ye Li (1):
      imx: imx93_{evk, frdm, qsb}: Fix conflict SPL early malloc address

 arch/arm/mach-imx/imx9/scmi/soc.c | 13 ++++++++++---
 arch/arm/mach-imx/imx9/soc.c      |  8 +++++++-
 board/phytec/phycore_imx93/spl.c  |  3 +--
 configs/imx93-phycore_defconfig   |  1 +
 include/configs/imx93_evk.h       |  4 ----
 include/configs/imx93_frdm.h      |  4 ----
 include/configs/imx93_qsb.h       |  4 ----
 7 files changed, 19 insertions(+), 18 deletions(-)
