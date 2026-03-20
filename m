Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928001098783
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7BE083CEA;
	Fri, 20 Mar 2026 14:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YSfM/ONr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213F683D71; Fri, 20 Mar 2026 13:52:19 +0100 (CET)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029CE83CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-89a05955720so19054976d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011136; x=1774615936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xuOecnpWLzgfDuDrI+Mb5Cjkni6iM2EzM/8tWpDtR8A=;
 b=YSfM/ONrgIgO+43Srz0htpTsAIA9ppa7tIJiPYPMjn4lFhNRDPEfJSLldjRV808UTH
 9Qvt6x1Xy19qrrNAHZgk0u6HtFxVH+OyYk1WFRRjlv/B1kA79D1DlSpd77SRNcmaj+MV
 gZlpMhmtNNmBb0+ZJluccnILqmgS+V8jDf4uuY8pqelMb6xOcgAFK1j72XTISYEneRcA
 v1JbAZcCQoP5/q0lFyZ/OzJR32a3YvsyBKKPS0ftN/E9hIR70BM4hnuUEH34tauhYVoG
 tBqGBVXf6QvJQqqdQ/cKQUeDC4xxEzLuL+E9ZhabU67fyhcTEH/zdhvfjBjygTv43auq
 J2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011136; x=1774615936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xuOecnpWLzgfDuDrI+Mb5Cjkni6iM2EzM/8tWpDtR8A=;
 b=tQpK0ydvzpOsLHtyG05IemIlOSPRv+dQaxYQIYqqZsT50zkcLkYCCBb92x4rqp/xG0
 kAQEQdfIjT6p5ECSzVli/1x6S3kaSsYIDrn/O1XnoZm0o/1SDqarhCWE4G9akv1qj7fF
 2zx0sG7B/wu+RnuC1rTSG8j4HnAPmpWHuwYEo0K/kvz2vfpe8oL8PydOtczHoP09dR3g
 SJufM8Iy2ANKGeXdPqy/PtglDF6f17i7BjRRjHibP3/ZDgJLeKGjGclfKPuyKMUL4aL4
 WiETwvc/z56SIA2K0H3Uq9Lq19b/QwUtI95OihfpV0jI80M6kGrWlaTH+X3smS9uRLcc
 oYMw==
X-Gm-Message-State: AOJu0YyKau12Wf19RuEHYJEUWC9dnl6ocN9QIiSm6fxHq9My7LnBKz1Q
 YP+Inz8sWxcqLOxHWEF8qwcrL3kysFBh6DWLQpiioA3xWm6WVdvcribsaX8JQYB872+fJg==
X-Gm-Gg: ATEYQzwlhIYNE6cGXKs+B3LZQS9LvFOfsa1Q+IZ8geotIL8nJfKBLbY1yVCG6/2pQ2R
 S4W/aVq5Rmot2Thj0Udii+k1wBUu5pZQ5Tg9dEL0+kSVjTvXjLi8r+7egkPaAGMTqQ5ihYqU/2C
 skuWmyKG6/7LT0DYdVG+DzyeQX8txNT80Dj6X8ZVgaTJxEuxAY5giYiohLqJKJ+suTOL13rsEbq
 gthDZ1vD2pUtxEcwSiawsKvu48Mobx6R5a4tRGWFwr0MisJGU4SO+q9fCRx7zlRcyF0wiAAe4JW
 V0kclyYgd3nxq1Yggc5EfwRjgitkW6h1cVM5KQNXCkQqjD4VtFtqg9AQ1EAPWW6tlR+3RoEMN5z
 L06VIDMITA83jqMW+aXy/r4mki8oWktaodHcQmeAC6q2Ap30WUY0w1mije1WcpGOpvo1YiqnISy
 Y7I8Zc6paT1J5UG7anppbgontyf8/viuzqGw==
X-Received: by 2002:ad4:5749:0:b0:89a:2fe7:91c9 with SMTP id
 6a1803df08f44-89c859b5269mr43832746d6.1.1774011135579; 
 Fri, 20 Mar 2026 05:52:15 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:15 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <jcethrid@gmail.com>
Subject: [PATCH 00/11] sc5xx Environment Cleanup and Fixes
Date: Fri, 20 Mar 2026 08:50:15 -0400
Message-Id: <cover.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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

Caleb Ethridge (11):
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

 arch/arm/dts/Makefile                         |  2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |  4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |  2 +-
 arch/arm/dts/sc5xx.dtsi                       | 41 ---------
 arch/arm/mach-sc5xx/Kconfig                   | 41 +--------
 arch/arm/mach-sc5xx/init/dmcinit.c            |  2 +-
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |  8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |  2 +-
 .../sc573-ezlite.c}                           |  0
 .../sc573-ezlite.env}                         |  7 +-
 board/adi/sc584-ezkit/sc584-ezkit.env         |  6 +-
 board/adi/sc589-ezkit/sc589-ezkit.env         |  7 +-
 board/adi/sc589-mini/sc589-mini.env           |  7 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  7 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  6 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  7 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  6 +-
 ...ezkit_defconfig => sc573-ezlite_defconfig} | 10 +--
 configs/sc584-ezkit_defconfig                 |  8 +-
 configs/sc589-ezkit_defconfig                 | 10 +--
 configs/sc589-mini_defconfig                  | 10 +--
 configs/sc594-som-ezkit-spl_defconfig         |  8 +-
 configs/sc594-som-ezlite-spl_defconfig        |  8 +-
 configs/sc598-som-ezkit-spl_defconfig         |  5 +-
 configs/sc598-som-ezlite-spl_defconfig        |  6 +-
 .../arm/adi/adi,sc5xx.yaml                    |  2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |  4 +-
 include/env/adi/adi_boot.env                  | 83 +++++--------------
 28 files changed, 73 insertions(+), 236 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env} (52%)
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (88%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

