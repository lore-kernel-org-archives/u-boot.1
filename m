Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A327C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EC68305C;
	Mon,  7 Jul 2025 12:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mczqGRrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55577830C8; Mon,  7 Jul 2025 12:04:36 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E3A83046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so2679563f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751882673; x=1752487473; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8cytq5rs0mDgZG34Xj2PmhHSbw5FJKdbEuG/EzdjTHc=;
 b=mczqGRrNCbK1WmTjOmm3xU2c4KVd8i6GkuCa7itVF18lWD9NkYwXQS9TbHS32wYgiJ
 n1OvlSp07HBh9lAisZHYwC8vwPFC6pdDLgAr6pgvyY4qWAGuhB13XyAIxMnmiNFn8/jt
 rKvOic/Tou47NcWKTu66i7SOlyopFvLuPFCImUVqfhrA1PuZA53ppHS8RQrJtjqjIzhg
 Fz8/8ZfGLkjRZqNuuWIdzJeVp6pJWlQcw5P9q7G+VvBU1VB18EMgS3hbVYpXPEcPg/k5
 oBCn3qUFxhPz+iC/ZA564MAM+emWTQZaQMLScfU22OY6xWobhxH+hXf7Zuhu0HDGggxn
 ENmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882673; x=1752487473;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cytq5rs0mDgZG34Xj2PmhHSbw5FJKdbEuG/EzdjTHc=;
 b=DvBIyDpBuw00N0kFAqYiwdGstzgBd2mu4As97guG0hw/uxrk2tYTm0bdnc7Q5r6Ecz
 cQUmanQwii20GCy7hzwcF7wqvOVFd3SbR/fOtkUtfFTlyH91Mh+WcHvrFF8SHlG5T3mp
 UjZLhopcUm/NqGQLTnZ+Ie7wqrM34GoP998FHomqvUiJ4WI8E6uLbQPmR22P7vJPwmGK
 k3iInNeKj3JgB4Q8RJ3Qq5+XeCKbjrTPmopBQhwqIY+38WLlgZdzrHxJ91YQWjL+54vY
 JaI/8kt6jCC035zhfmNXRCT9bNghrKOWNIokMrV1KtzYd+R6pXA6Neahl4efuQOLdSFx
 QV/Q==
X-Gm-Message-State: AOJu0YyIEZcdZuGxZLd9zt9phZOG9fg9jaAr418niByNjPZTxoMGQiNT
 S0jhCYHOkksK1lYfwjhhyiRnsESQ2uH/E5DQlUokZW4Ig/GToTHwAnPuZ2Bws0zA2FM=
X-Gm-Gg: ASbGncuot/353HVnO5fE/DIFkucpRLPSMjYz/ug1j10SGTofMfUOZ4mU7VkLWbkQC7u
 89Un+qB/FCHPFfySzfmQwUE1rJIftFEZyi5vGCgb/4ormL7YvNryhF9UbdBq8pY6kqblXkI63eC
 lb62Myw9y23eFHt0MwpNV2WeZf8KBRk8Dj3g3s5r3k4O4YFsmZdGMSA5YHC4HWOn1qB53OShKlS
 AgYXoqxguZC6kA176vtAzy2lQ0JGvgmSEkcLLsoDmBaI1fYuOXa/3+lqGwrAl9D7NWkNhur6b40
 jF/NSjMagjy1Zzy5dEzV/0rjB9q8zlpKOtuYHVJvaqHscCZ95C+SFB+zVq53Gu3N1RkhpzgSeyt
 /pK4emnCJ+VIJ9g==
X-Google-Smtp-Source: AGHT+IHpEz4+2ZQlTqGt9+A2WsVeVLNjIoMpc0wm1Ot3UD2j+dmR0DoGhAejLCLZamYsbdKyDOL0sQ==
X-Received: by 2002:a05:6000:18ab:b0:3a4:eb7a:2cda with SMTP id
 ffacd0b85a97d-3b49660bfbdmr9831446f8f.30.1751882673324; 
 Mon, 07 Jul 2025 03:04:33 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a6fasm9468540f8f.81.2025.07.07.03.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 03:04:32 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 07 Jul 2025 11:04:29 +0100
Subject: [PATCH v2] ofnode: NULL check bootscr_flash_size before
 dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-ofnode_fix-v2-1-2e529f21ba7a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKyba2gC/22NSw6CMBCGr0JmbU0fIODKexhiCkxhEm3NlBAN4
 e62rF1+/3ODiEwY4VpswLhSpOAT6FMBw2z9hILGxKClrmQtjQjOhxEfjj5CNyVepMLS6BZSobc
 RRc/WD3OuvGxckLPxZkz54+XeJZ4pLoG/x+mqsvp3f1VCiaE2rTYGXV81tyd5y+EceIJu3/cf9
 wrKUL4AAAA=
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Move the NULL check of bootscr_flash_size to before the first time it is
dereferenced to avoid any possible segment violations.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Refactor to coalesce duplicate assignments of *bootscr_flash_offset
- Link to v1: https://lore.kernel.org/r/20250703-ofnode_fix-v1-1-c739233efb58@linaro.org
---
 drivers/core/ofnode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 26e014d5c53..e040e3f2806 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1961,6 +1961,12 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 	ofnode uboot;
 
 	*bootscr_flash_offset = 0;
+
+	if (!bootscr_flash_size) {
+		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
+		return -EINVAL;
+	}
+
 	*bootscr_flash_size = 0;
 
 	uboot = ofnode_path("/options/u-boot");
@@ -1979,12 +1985,6 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 	if (ret)
 		return -EINVAL;
 
-	if (!bootscr_flash_size) {
-		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
-		*bootscr_flash_offset = 0;
-		return -EINVAL;
-	}
-
 	return 0;
 }
 

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-ofnode_fix-284e601e4329

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

