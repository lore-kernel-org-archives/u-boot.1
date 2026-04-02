Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0A6D6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CCE84144;
	Thu,  2 Apr 2026 17:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BArrmI89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7FA839DF; Thu,  2 Apr 2026 17:29:09 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A504E84099
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8cb40149037so118677885a.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143745; x=1775748545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz/PrIKr78Lq5gz51kg7YWKzaG9j6PB5MtE7hX+/bxg=;
 b=BArrmI89VX9tG6zzIq92S2xhn7v1ltavdFxME8CxF6eGj0TYCnx8CLQ2gyoeCY99gs
 rhHM2dejmwuSqpobHtpVKBxVgTYIShQTpn5V5jGTbH0MkIHqmu6XkD1zjgp61TTYIfG/
 yNv650mhaMivdj/1RTB0LiR3+l5jSST5LWPDNGPQXxPfcxVgzd0pyQXPlq9yVi1T7YPp
 4b9RGbGdIP+yWyCA4s+7zskFu/0iIhf705isT3jdgooMcdZiTdXlFqEdHjCR4DJM1zMG
 jAjCZiV/+C83pyjvtcQ41dQasSwvN1lEgcTBMmzHkUZXQpT6VmRj/keiNK13JyTbBBlA
 d1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143745; x=1775748545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xz/PrIKr78Lq5gz51kg7YWKzaG9j6PB5MtE7hX+/bxg=;
 b=eU3mnIwikJ9YGOz2+GnurvAbsSCBBwy7mjMdk5ZE1K/D5y1m6IzQLqaFChbFK9kc0S
 GHsUs70fRx5aRSfPxvzpIX+02Rc88mBKdP3rV8dBQ64xajxRSgLy7G9cJZICWBN2s8K8
 jBJ7fTWy8UlutIMTR4JxzO8OiLMseb5aHW3aWfOKANEcjmPCIgaBclTYw9ulAHBTdbUY
 mK3SGvp/XF7i/U9KiNViSMR93F+9Yjg0RSEva6bx5kLFXRGi+UFohaqQHMGOEDnJ+dY8
 pc67jaxp00t66GWtkvDEUxiNxqjcgfLJ9FTWqDPjkZKzjRK/VgNeoCPzwK4ZsSpAQqpm
 UuRg==
X-Gm-Message-State: AOJu0YwtbOBgF8VUIM08axpQqQ5AqAyD8I/AyjtnXX7pG2cUWl6gmkoF
 Uv+NeCmo/sEEdXSMhR+1J5WEuECRYOhoT7DT1kT6oiRbzqII0o1Aqlpe8Iz6z1BU
X-Gm-Gg: ATEYQzyZz57yaqNo1GJY+zv6N6qKb0dI5k62gtRWfAjVv2T4n+lp68aLxlLYfG7FmmF
 S51kfDRQRqPmrkBGoUaKX1j/jUwg4fu/uluRaEPItUv9S09kjBd/6VwOvGjCdKlJCiyQjpY2/1R
 cnKSIHboWQvhVZhQOuX2tch8RlEfDzFhPYrxZ6NfnOU+7Mu8Ir2bcyldoHFhGV+/1kcvBPjbGMn
 W6tlPElW4qgjTu/S0vxy2j05VKrIeniQbI44Yx3vUqg+I5ASkmmMw5aJRWz9vL44qbYjkj3VVex
 RtR/LA17Ujo0gJjGXpUcp7c4nNRnac9DHLh7a5wNi9lIanHxT8EU32feu7qZHZyXQTId7hpLQoP
 ujMGMkkL9dmTPFzPg3aaffe6v0WAmGbMM4rvfvecJeoNpU+FsuccOMy9FhcvqEq0prPi5iD461B
 nWvbY+xOT6L74k9w6/48a2RiXDXvLjMv+Kqw==
X-Received: by 2002:a05:620a:1a1b:b0:8c6:ca70:68ac with SMTP id
 af79cd13be357-8d1b5bfa953mr1188391085a.46.1775143745044; 
 Thu, 02 Apr 2026 08:29:05 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:29:04 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 11/13] configs: sc5xx: Set default bootcmd to SPI boot
Date: Thu,  2 Apr 2026 11:28:34 -0400
Message-Id: <46458d07e0f8e039e893307d8c59d55ab76f1d4f.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Align configs to use the same default bootcommand.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc589-ezkit_defconfig          | 2 +-
 configs/sc589-mini_defconfig           | 2 +-
 configs/sc594-som-ezkit-spl_defconfig  | 2 +-
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index e4fe4db774f..fbf29ac32bb 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -22,7 +22,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index ebc9761607a..d812e6ec4fa 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -20,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index ef23b97b89c..cbed13bbf0d 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -15,7 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 05711b85824..9c3f400f8c5 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
-- 
2.34.1

