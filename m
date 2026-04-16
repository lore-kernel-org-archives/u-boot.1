Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773EEF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C9284366;
	Fri, 17 Apr 2026 14:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AfOiPBkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B326841F2; Thu, 16 Apr 2026 17:20:06 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94918840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8a3342d301aso80532686d6.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352797; x=1776957597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vrbHaSJrmwR49ssyplLKJ1OzYQwSvymM6cfJ+7kjR9o=;
 b=AfOiPBkkxXndtPFdMhldx7IfDvxsoQ6xfGY/zSQImuKyGOUykq/Dw/jdzBFtN61mRf
 JqC8YlEAmQz6V1Z2Lmhv74dmsltwqGnw9v8EMImiSC5pqQ/ZYnbNYOsKrKQYTZO6X+OZ
 0Wuv6SLO43rDm6/RwJB6YxcO+su3gOXUQBVgTMuusyWJ0H9mjyB4TOxnNibB5Q0qSxZG
 xX66nW4U8IdnvP7C6EssHPvORoHhyfbap3qfKCo8yU7z8dDKccKyWAsFYIQp9k2SEPhQ
 EAV0lh4nvZHd9xe7SHHnApxyX/M7tC4gcFvr05ZtpLR2FS1U2F61PMpc8VHIlZk7W3YF
 2DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352797; x=1776957597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrbHaSJrmwR49ssyplLKJ1OzYQwSvymM6cfJ+7kjR9o=;
 b=Qcgtttks4rD5vPcAeD0B7P6iuhWziMi+zzf1SNI1GPlXZD667+CEcyESEk2xRiEKbX
 fpIGbrfhEtrmpIkoVronse/jSUEGsQ2a0xCIUE+Y9G/nA0RKji3pm7o8mtyNaeyXOPBW
 3FMOSJy+CzwiuB6H8Ie/O0/FCijmXmXgB97q9SgK8MhrMal1MLTNxS5bHrkdvPsJbMin
 MSJb6PLiKBWyso4whJdSJgeJDIwOUx+LjJLrjyrQ73TOrAlK3ilYgpz/H0Elq7x0NPg4
 BHiiQWT1HeZM8hIqiDPoidVHT0oQcWvuHqPmkmEPOCgwb/jmKiE9srVSa5SFw6fMcw2a
 hiJg==
X-Gm-Message-State: AOJu0Yzb0b1WwYROw2DF+iqluLi6cieU4F0XZqbsDg6ppcvE3gnzX5p/
 rz6mDyZ14A3IcqOw3Laxp14fDoYua2Mpr+rxUK/gI0HzNNvX4ESfzaD2UKa/L53U
X-Gm-Gg: AeBDieuvKxYNIAjY8+f9JpC21D+mHWs01D2mR68mh13P8jnS93No3rOYW1HRUv5rrNL
 ukm1D/bWE6sEOa5xonMLcltWVF6vx3q0NNHiPjLc8P4gyMDROyecgD817eU3hdyGtoe4RRIXuZ4
 uQZbpoylEvnhj+Xr3FiwiNoeBGwLyqInosb2JNmetN/6QQz6KPLNs6ytfb4uCtfy4yD8/I3qTzZ
 FHF9kNuipajTUEC6zyCQgk3EPXs3brZ8HOccObeSRx+jl9q6igJZBfzIWjzDUIY3v5nEKqUK93X
 iF/aMRjF796rq9GqyrLR/XNcQJyl5fo11YSzTDDBUA8ROQ4SDnnbPSrSK+YtvudqV/75ETc4nce
 ipoL7efVoM7wI0hQv3v92no2HPrBDa+AKrHa+fhpWhNH7La4VL7cp9PlyblnTQMPgk0g3vSGYfe
 DPV77L7wujDrPC3aEQIEv/QPbdc2EVlgW7wQ==
X-Received: by 2002:a0c:e004:0:b0:89c:4f7f:8479 with SMTP id
 6a1803df08f44-8ac861562e2mr377004536d6.6.1776352797153; 
 Thu, 16 Apr 2026 08:19:57 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:19:56 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 00/14] sc5xx Environment Cleanup and Fixes
Date: Thu, 16 Apr 2026 11:19:35 -0400
Message-Id: <cover.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

Caleb Ethridge (13):
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
  arm: sc5xx: Remove SC5XX_LOADADDR
  arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and initrd_addr

Ozan Durgut (1):
  arm: sc5xx: add missing boot env selectors

 arch/arm/dts/Makefile                         |  2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |  4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |  2 +-
 arch/arm/dts/sc5xx.dtsi                       | 41 --------
 arch/arm/mach-sc5xx/Kconfig                   | 47 +--------
 arch/arm/mach-sc5xx/init/dmcinit.c            |  2 +-
 board/adi/sc573-ezkit/sc573-ezkit.env         | 17 ----
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |  8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |  2 +-
 .../sc573-ezlite.c}                           |  0
 board/adi/sc573-ezlite/sc573-ezlite.env       | 16 +++
 board/adi/sc584-ezkit/sc584-ezkit.env         |  8 +-
 board/adi/sc589-ezkit/sc589-ezkit.env         |  9 +-
 board/adi/sc589-mini/sc589-mini.env           |  9 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  9 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  8 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  9 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env | 14 ++-
 ...ezkit_defconfig => sc573-ezlite_defconfig} | 11 +--
 configs/sc584-ezkit_defconfig                 | 10 +-
 configs/sc589-ezkit_defconfig                 | 12 +--
 configs/sc589-mini_defconfig                  | 12 +--
 configs/sc594-som-ezkit-spl_defconfig         |  7 +-
 configs/sc594-som-ezlite-spl_defconfig        |  7 +-
 configs/sc598-som-ezkit-spl_defconfig         |  5 +-
 configs/sc598-som-ezlite-spl_defconfig        |  5 +-
 .../arm/adi/adi,sc5xx.yaml                    |  2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |  4 +-
 include/env/adi/adi_boot.env                  | 98 ++++++-------------
 29 files changed, 106 insertions(+), 274 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (87%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

