Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A3CFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E429084506;
	Sat, 25 Apr 2026 22:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oZ2n7QjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E695684372; Sat, 25 Apr 2026 21:05:46 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5165784319
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso88441031cf.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777143943; x=1777748743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KyFsCb70j6TgE4jAlzSskjkl83Xvf7mf1Coo4RWLFF8=;
 b=oZ2n7QjMHRK1e+lekBe+CWZjJW8H8BfKrnNhXD0t8bJs/Cs73a5dRKwQoC+cXHCya/
 kv8DrA8GFayI4c3gd2xFY9UsHuk/PLquudCO5rbTvfjZP3m7znbMKpTiAIGSI6306PUL
 ECjqwAMT7lUyz0+Fhu4SskJtamdAmAyg32Jq+9NNmWnEAqmlReLV5jBdsZ1OiPEmMIKI
 xYYZhRPB8XRwhthNPTPWvXNZBRiJnXfC6NIkgtYoLUDE62KW9Xr30RSAqSK75nGBiYqv
 XLLTcKtKfLs/yePQZg/FPixpDDOMXIbv20CUfoF0VXnxF7GaKJIr+RM1crAY6+03SdHr
 8lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777143943; x=1777748743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyFsCb70j6TgE4jAlzSskjkl83Xvf7mf1Coo4RWLFF8=;
 b=hoJUaODBc5NJF0MUl5fgZ5GnUk4Xdk8S5Yhz7XcVqhantusccqrdoHeUScIyixlSC7
 EwVVVKabDA+cVCkaht06Pp2a/BXbzSfRwaY7Z4ke+bTX+UvsiBugkkqqW5u3XwRWrvX+
 kLyXrkVoCm2XqZ/z7XLJ6YqKtlWruMyPEJRQYgBGCPQENNB2kX2HTEj56+pxaYaDHbqd
 dFBxhAhFIyYFZtopDs5HnBkfENW/+yoJX7eCq+oocgd/0MgiElLF91d9mHrU0zeeW8kE
 DfZAlDJbjeipNWeQFA+kq2o0pcdUrvg8LbqgVPceLEERV3WprURRvhJP//Q0yyCTvkFT
 3i4A==
X-Gm-Message-State: AOJu0YzDEQoe3nkkrGSVzse8izN1nn3Ow1yofkZgvt5nWPglTfwEWEx+
 gopeDuYKmSdL+G2stc31/JuGpmrmB2M+o3tJIotqlYFNqundw07k/txjontHRLeP
X-Gm-Gg: AeBDiesun//g/paC2s5IiCYgnuLjgsnZh3WmFLfOO8LEXUt7/ey+SGWTzNqXOv2h1IV
 eBS+6oBZfXxxxk3WCbta+OP+RFPwcLHscT2t7fFdkuTzNiiaqWh0qng2FilKlyqdnvAwIFlrexD
 33A6mY7NTe0URHtV4dSN9dS4Ks0ZOTfTDP3Eb5iwCO2FoSVHzHkH1o2fuIuhLR46EMw8UB0JDc5
 AirRCAURXxbuk9K8jVtd9uj1XcdHoIuq2qN3zyVoFKFFsbtTd2O/i71fvsVxgxf8ZTKfrUluskg
 fLKqLWUd6SOj/qZ4R4cziGrhZv1hSUl8illieRfQvarinDucD+8+BNXpVz+npnYN8muiwz5RMrF
 Jc47fk4Hr1itxp0sdlgYHc1i8hHRPEURbsnJy5g+JZkPuYQDWdS4LRT8olhHzlvh1dPGOH0FpWZ
 +sCemqUboVVzuuOBGUZR1c/bq/QOAsJz0YUfL48nnIzRj0
X-Received: by 2002:a05:6214:29e7:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8b0282f35b5mr385235326d6.3.1776954303122; 
 Thu, 23 Apr 2026 07:25:03 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:02 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 00/15] sc5xx Environment Cleanup and Fixes
Date: Thu, 23 Apr 2026 10:24:35 -0400
Message-Id: <cover.1776949417.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

Changes in v5:
- Updated several commit messages for clarity
- Corrected load addresses for sc594-ezlite
- Added sc584-ezkit to USB support
- Removed now unused Kconfig options including SC5XX_FITIMAGE_OFFSET

Caleb Ethridge (14):
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
  arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r
  mach-sc5xx: Remove unused image offset Kconfig options

Ozan Durgut (1):
  arm: sc5xx: add missing boot env selectors

 arch/arm/dts/Makefile                         |   2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |   4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |   2 +-
 arch/arm/dts/sc5xx.dtsi                       |  41 -------
 arch/arm/mach-sc5xx/Kconfig                   |  71 +-----------
 arch/arm/mach-sc5xx/init/dmcinit.c            |   2 +-
 board/adi/sc573-ezkit/sc573-ezkit.env         |  17 ---
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |   8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |   2 +-
 .../sc573-ezlite.c}                           |   0
 board/adi/sc573-ezlite/sc573-ezlite.env       |  16 +++
 board/adi/sc584-ezkit/sc584-ezkit.env         |   9 +-
 board/adi/sc589-ezkit/sc589-ezkit.env         |   9 +-
 board/adi/sc589-mini/sc589-mini.env           |   9 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |   9 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |   8 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |   9 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  14 ++-
 ...ezkit_defconfig => sc573-ezlite_defconfig} |   9 +-
 configs/sc584-ezkit_defconfig                 |  10 +-
 configs/sc589-ezkit_defconfig                 |  12 +-
 configs/sc589-mini_defconfig                  |  12 +-
 configs/sc594-som-ezkit-spl_defconfig         |   7 +-
 configs/sc594-som-ezlite-spl_defconfig        |   7 +-
 configs/sc598-som-ezkit-spl_defconfig         |   5 +-
 configs/sc598-som-ezlite-spl_defconfig        |   5 +-
 .../arm/adi/adi,sc5xx.yaml                    |   2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |   4 +-
 include/env/adi/adi_boot.env                  | 104 +++++-------------
 29 files changed, 106 insertions(+), 303 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (88%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

