Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2C0F53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E4084236;
	Mon, 16 Mar 2026 19:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="j3TEcJRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A8F84181; Mon, 16 Mar 2026 19:15:49 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CC584180
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so4246400a34.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684945; x=1774289745;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXHt3isqsaX4EjNRSDd8F/hUc3GVZGtqDYXnFRxw5sg=;
 b=j3TEcJRFY7M6tw+zjaGvCQ6Pdb4juvq21PHSmmWTras7g6aoh0mL3TusIjEtJGcRrj
 vK9W1ZZvbG97QJK+7DXkl3yL8J+Jhu36UF82AEoTdCB+AOoneXReyFAmYaKnZ+exqUwC
 8KOEdCqrN2GR5IGsSIK7gLtB1Vb+/mdMCd4EakHH3ope2kZKyC0Hmelrgl5y+Vf/qnHa
 Q7Nw3KzgTdXh9fi0W4vu6xs9GuZazT1QYeRqvQe/HwmBG4Uv41GtnNHydF3HyVulcewm
 QFyqKyYkpy3HcJpiw0nkCY1XFk8WRCJgAFFOrr2+vysp6zFdimp4av/TUav/fZrYBppo
 BIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684945; x=1774289745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kXHt3isqsaX4EjNRSDd8F/hUc3GVZGtqDYXnFRxw5sg=;
 b=mIfahqNoRvpZ+nW9C5MhQIkiaatttZ6nW66aCAogHZRyAyThgSnvn9s1/5dHGyIXFZ
 eAk9iqDR8Ylgornx1StWUspp17lTsif1QpzUn2rZNMrm2SvrsioZem5g7A/yrmJeuWp0
 7gdHbGId2lJu1SXOCqKaIfshE2gh+ezCAPDUzKUqLslnlsxzIDX/XHsDgSQYeX/49lWu
 bR7vKjkvEgkDed7mg7LKCYnm7w13WRuc1llSQemD6xEYMoNm20JpPssW4vP4sDtn6cwN
 TdJqTPtkAmJAuHwNsW49DoU8GrJ3eJ5kT8OkzWpuslN5mc/pRiwEtPOfWmYnHs5zqXS+
 UvtQ==
X-Gm-Message-State: AOJu0YxvSria2s/WYshdR+zIeQyyYz0lRpDjZPdIzUIPho0Mh7Wq6fer
 9WAtLM2ldhinTJzr2pHiGvldRinEVDUlt+SBl/+W1Gdu3Yl9fLfJ4tygbfYYuCeX1g7L87u0XeF
 34Gxsqb0=
X-Gm-Gg: ATEYQzzow8+zX/jm5Y9+GK2mopyBTlU25m/oAOMItdyYraXXe3y7YjT6Mn+0qYRfTfG
 3mFM+i7ZHdO5S5d993gLz3P71y0tlxNgcI3J9J1tUM5ktz+3c0egj3Dr2r7oq0phbPYn7s6T9OG
 OulHQQOh7xtNUYiliRM8c7ccmRe/IJYaPESeU2XWVnvpqQGxjYUJwJns04FEHVN7xyJAYslq5Sp
 mmZvln3is2I00vBAH4REAfphhzuzWy4CCnjfd61PBBInFTYh6DyG0LwG0ZKp4TetNyi8BNh6abw
 MXES5qF/CtFeH5nphDJzzzVdv85C9+EUykExM7U78T7U37/9AJ7u/AHgBz+SPrwyhDvNad0nIjy
 GdONZpR8gKyZphSWCOuG+afCvvNpZfVCHuMVYmqCWAOliQDG/LGCb19rS8mn8ZPsFkXwdsxLGeF
 f5kXP3BX9HQtged7/7HvEoIw==
X-Received: by 2002:a05:6830:6d12:b0:7d7:4b31:fc0a with SMTP id
 46e09a7af769-7d78242a640mr8661182a34.6.1773684945048; 
 Mon, 16 Mar 2026 11:15:45 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm12426758a34.18.2026.03.16.11.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:44 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 12/12]
 configs: enable wolfTPM in rpi_4_defconfig
Date: Mon, 16 Mar 2026 11:14:41 -0700
Message-ID: <20260316181447.2986278-13-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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
2.43.0

