Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B832D6AAE6
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAFD83CF5;
	Thu,  2 Apr 2026 17:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pieVXRum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F366E83D8A; Thu,  2 Apr 2026 17:28:53 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33BE80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8cfc5941028so180510085a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143730; x=1775748530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bVqKjvjwRWcHD8b5LVZRk6PeDMMYXq0vGxktQ77CAZA=;
 b=pieVXRum14Hmz2q9W6qhBGPFGfkyyEgPPZSMSIAqwB/QjJOuxNcqGfHC8MGIi5RLrV
 PeRSFvohrmW9a15sgOr10+doN3I5Qc90Frd8MA0AmoO8KJnK+LlVyib6YI6j8HrBUnfv
 lJ3t4vYavk7E89KX6DsWpPystD7gDaCtqJ2Tz24ABJllXwp8//ksg94EBnpQlGylPlbl
 6iH44iQb7mKiRfJ9unIst9AFomXjVQ0OZpspruHb1rHFzRcbpzjFOA7ZeDY4yFtBhMBr
 UA2iOysLwJx14KUfxeqr/gXia4J+HBFHAm8Mn5H07A8VJsV0IAx6/rG8Wk0DomKcVGBg
 Jf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143730; x=1775748530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVqKjvjwRWcHD8b5LVZRk6PeDMMYXq0vGxktQ77CAZA=;
 b=W0N5hZvLCOPwocTzO5Oo8UEHNRhOOa2IMaFQfgewrIOSHXiX5zlIAaYufGTSZjETn8
 Ih1dkFt2kAACSbN/cmH3nvxtxsF5w00b5KSIx0IHRBp7R0Cc4/RahEZg2ktLbgY+LQhh
 7SAP84F0JSOQEAhQ1sR1rZ2BVNb5y3yfODekLyengURdRxXPJy6tuwRM6dK1lYs+505F
 gLg6QeEgmxHOVRPnYXWB5fW9P63WDaAJTO2QkauW3W3EJY401cOJPB8+ZePpbefprjGk
 H0leUHq++6Qn1KoCLFRG6HzW1CZIWD2BnJnKITybDJRGyK7MX6vrNsI4sY52qh3v3XjI
 D07g==
X-Gm-Message-State: AOJu0YziBsoqxSdDvU/EaAWJezpgpZK2Z8YPQD2JcprnzpJ7VLn9nHXY
 MYMeO/c5gX4BAOzIC3pnnomtfgQt8bc1/8bowhMmuajqhH/sFAgYOmo3MdCjfm9J
X-Gm-Gg: ATEYQzwOF3HuuaInECVVuMvSN3x5OJx2zKsY5IpzYpP5rk+Fxc8AB5khZUf0KKSnJUL
 cGA/Ce/7J3xJVGqVFLjhgA2NOi6ytBW7GuqClKdbyHxtbUr2JuVXAG2KFpndWpqiAsTMVEDO0xQ
 WoxIJ543OzHzRTrnQnRp8kIbByKLoL2AxsxD7ccEBMM/bxV8gHKFN0HAYFB3p7m7kBtRYAO+Sy9
 7g8W4N8bD9686xtG53seYKQ3Fs7QDwm/hi2d+RiFhhapCYz4MDQIpGf8HbDEuaU9q9AXfVeYv1U
 vLXPU5uuSNL93u1MtWWnVk8PJRNaO0Jp1NGbojd1PeYFwcym3aySNauQcIMeLb50P3qI/YQ7tYB
 ZwTO/yUgj+8kagDAz9OKFclzjeToXy+j05ABoOBwAhy+SIdTPiuVSl4F74+BOePljVpyqTrKsyQ
 AyqC2yyu3doIeGzOQiO1n7/ctS1sN4wXrpOQ==
X-Received: by 2002:a05:620a:1721:b0:8cf:d289:d0d6 with SMTP id
 af79cd13be357-8d1b5aa6f48mr1186641285a.14.1775143730318; 
 Thu, 02 Apr 2026 08:28:50 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:50 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 00/13] sc5xx Environment Cleanup and Fixes
Date: Thu,  2 Apr 2026 11:28:23 -0400
Message-Id: <cover.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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
Changes in v2:
- Added commit fixing missing boot env selectors for sc598 EZLITE
- Updated load commands to use kernel_addr_r
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
  arm: sc5xx: remove LOADADDR and use kernel_addr_r

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

