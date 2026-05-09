Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77D5CD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B2684E44;
	Sat,  9 May 2026 02:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="Qg8lqgq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3085C84E0E; Sat,  9 May 2026 02:04:59 +0200 (CEST)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C052684E12
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so3054242c88.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285095; x=1778889895;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOOOJHJoM4inmNkwtyC2WAs7dBgxbZt9YObuCsRK6FM=;
 b=Qg8lqgq3IC1lR9VCqxy0gbn0dP4Vcel1ftnOvXqvPszmwbSTmaRe6AsT5Gqax1dhtI
 7F1IHTJXEVCvJbBc9EoYlWDltBR3IfUlQocEu5iYXlbSgEcDb5Cjlz/pNR0VsI4wscfn
 EI6j6ckUW1BFnSMr8sTh86wwKCWMMl2/u3MiFOu2U4Ea32FscLGzrRAU0gHHlBIKmOAk
 x2XqWPjo29dLjCBK7Da9YwXp9j7npYcsqPdO3o+lwmV6YWsjstA+a66JJDUbWId5iXvs
 OqFo2tHqqSf4ODYVOqpwWKqjov50nbg//NrSaMaWReCLVavGUNkb/aCKFdMeC+R5bPSM
 OuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285095; x=1778889895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eOOOJHJoM4inmNkwtyC2WAs7dBgxbZt9YObuCsRK6FM=;
 b=QK3+pdmtKUhloOGUVoFcgKr0g16SabtDKKfzVrap4bOao3SZGJvw69YEk017OJrh+D
 p2Zf9kLPUc1Ma1iK0tEzZtGnRkpt4297t4VpCyUTxUgvxRNIIDTJbbeSHIx/LC5ot+eX
 yDDa3JjHYpNCWguCpGrq3WKJVPVkLVxow9XJlSudtyuUpbGSIuXt9UcGgRgc4HBD3SGM
 98kn9i4L7CuqKHKa319MaqvJO3u9KTRqvGH/mOZdyLJY6coorbKlJxiFbObpVOo3Cndd
 4vCr6EUXDOCFBIdkyCZb8B79mTjqEeIPUGfBzLZEqoLqQ0MRtI25nkTnzybYjxJc/N3M
 Wpag==
X-Gm-Message-State: AOJu0YzbxrCnk8bv5u3dODQsGdHYBc7rt65Kh/H1ao8ywekGNcAEI8CV
 Wg85MUNnRnAfK2wL34eSSyLyjUA+zuvYyiy+/EnNCqnw0OT5MK4vafEDW4q46KMDpwIk4RkBwZh
 u4ZXU
X-Gm-Gg: AeBDiev8Q6BhIxkATTFFjdFAVBMPLuM9nAzHzmIPi77nV5m+s4/iqXlFflnZT9DxeOM
 RH2Cgvrwez8D209Sek0dGgvZTDXtb2ra6gyFoR8LkPKb/ptAF2b6G3bkx7uhiCFSnbxLe/r5zYn
 nIPrzG9b4BZ7qDXpfxkDmM+Mzt+OnhSQvjRRpZ3QMbPBLHz/51MApXMwCrafMxEdQjw+qHN2OBF
 abxxwsx0a3ZZIjsXkowJtwomO9/M6aY6VGGFpBkWTO0CaFpoBLJosH2oi2DzOs36vWc3KjWEpRM
 ih3bCDhm26LGpjhsj9upt0UCTw25jXMro4m0gVFxgQRMdawoDxHr9CLhbBkSPByBe5NKp122N64
 R0nTVDdl4iLPIEBpoDKYzUByC2noz7U4R7ILmOjqUvPJc2LaPbzipYDL2kByZCVq88PGkIffEUZ
 bz2Ut0jdzO4Ti8M8SFo0oln50qRhnU3Ppoz3N2d/6cteFaJ9xcSCDkRzlkMzI30b1GgqCMd2Vwf
 s0TQ0ScEkNiUX/iPbRhkg==
X-Received: by 2002:a05:7023:b09:b0:128:d5bd:3557 with SMTP id
 a92af1059eb24-1323aa56f97mr4283401c88.4.1778285094807; 
 Fri, 08 May 2026 17:04:54 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:54 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 12/12] configs: enable wolfTPM in rpi_4_defconfig
Date: Fri,  8 May 2026 17:04:19 -0700
Message-ID: <72defd14df7e4e5a1946fb2f5507c17819ca7fc4.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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

From: Aidan <aidan@wolfssl.com>

Enable SPI, TPM, and wolfTPM support in the Raspberry Pi 4 default
configuration for out-of-the-box TPM 2.0 support with Infineon
SLB9670/9672 TPM HATs.

SPI support:
  CONFIG_SPI, CONFIG_DM_SPI, CONFIG_BCM2835_SPI, CONFIG_CMD_SPI
  Enables the BCM2835 hardware SPI driver. Soft SPI is disabled
  since the hardware driver is used.

TPM and wolfTPM:
  CONFIG_TPM, CONFIG_TPM_V2, CONFIG_CMD_TPM: core TPM support
  CONFIG_TPM_WOLF: wolfTPM library integration
  CONFIG_CMD_WOLFTPM: wolfTPM command backend for tpm2
  CONFIG_WOLFTPM_SLB9672: Infineon SLB9672 chip support
  WOLFTPM_LINUX_DEV disabled: uses native wolfTPM TIS layer with
  direct SPI communication rather than U-Boot's TPM driver model

Logging:
  CONFIG_LOG with level 7 (DEBUG) to enable log_debug() output
  from wolfTPM commands.

Testing:
  CONFIG_UNIT_TEST, CONFIG_CONSOLE_RECORD, CONFIG_HEXDUMP for
  running the wolfTPM C unit test suite.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 configs/rpi_4_defconfig | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index 8362242b97f..22280d9b70e 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -69,4 +69,31 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
-# CONFIG_HEXDUMP is not set
+# HEXDUMP enabled for unit tests
+
+# SPI support (hardware SPI - matches Linux tpm-slb9670 overlay)
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_BCM2835_SPI=y
+# CONFIG_SOFT_SPI is not set
+CONFIG_CMD_SPI=y
+
+# TPM and wolfTPM support
+CONFIG_TPM=y
+CONFIG_TPM_V2=y
+CONFIG_CMD_TPM=y
+CONFIG_TPM_WOLF=y
+# CONFIG_WOLFTPM_LINUX_DEV is not set
+CONFIG_WOLFTPM_SLB9672=y
+CONFIG_CMD_WOLFTPM=y
+
+# Logging (debug level to see log_debug output)
+CONFIG_LOG=y
+CONFIG_LOGLEVEL=7
+CONFIG_LOG_MAX_LEVEL=7
+CONFIG_LOG_DEFAULT_LEVEL=7
+
+# Unit testing support
+CONFIG_UNIT_TEST=y
+CONFIG_CONSOLE_RECORD=y
+CONFIG_HEXDUMP=y
-- 
2.47.3

