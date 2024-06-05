Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B7C27C55
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDA58831C;
	Wed,  5 Jun 2024 05:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RTDHpoSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C9C88379; Wed,  5 Jun 2024 05:26:47 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA028785E
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-374a6b5c504so10609385ab.2
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717558004; x=1718162804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNKShT409V6k+eS7f2S2ZDFqzG48CpzI0KNZ94lhFTM=;
 b=RTDHpoSNljLo3rl5pvGINB+FmS4FcAr6ddWRfrLCwFdKj/1bTrey85/e08DB+fZPE7
 WGu4qm3+mjkZZlL8grOIyLr7RWALpZDXmJxpQpB5rmhumoPFI3sRPKYCPjJpPI8z1vsv
 ASh1jZRdivdnIfNtfBNq9DhRAr9/fqUrLlico=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558004; x=1718162804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNKShT409V6k+eS7f2S2ZDFqzG48CpzI0KNZ94lhFTM=;
 b=OXOF/3P2RWyBElOC0mMIMPuuPjeimNwskOjc1MxTgnYv20PddP7LWzqnY4+PvmT5e4
 M1UwNAfYxp21hOaPCskhDi1k4yS243HmWAozjPy5XLeLn/uF0H4P9nNMLCJdgCJ8suFP
 8LybsQs2CdHQJWh+UG1kEiv8/n+U9scSUuoNV7eEkSwm1QjFP2niLgLW1NTyWbDKsW/J
 JBKWiWt0AExzrqWfejgJ5gkX14yBCyao5pIgB8chrHdcTEq8DGXj6VToRHWCUCCdJHzZ
 FpyM3/Qyd5F5Ikk/ecoXFSsX667k4C+0rigkhqW1xzq1+ZnDwGyyUUpfJ6RC6KP3zZAk
 BYaQ==
X-Gm-Message-State: AOJu0Ywn4IsrVrMtj3J8SRO7zSQj+FCmClVY8wU0Xss36OVtnPvs6y0v
 1CT4B21MBgOHthAOYkRjICRZhn8t+6pm4lMZ6d7BHkCm0reiEcG10JSekvBPj9F0fdBh+SJkI1i
 dsg==
X-Google-Smtp-Source: AGHT+IEQ58sA0whgDJkf0rZlAkazy9O9WE4wsBOdo0Yvmi25B0xqfJW91t2xauCCcsawd1NZCSEFOw==
X-Received: by 2002:a92:c26b:0:b0:374:ac3a:e32c with SMTP id
 e9e14a558f8ab-374b1eff03dmr14171135ab.16.1717558004201; 
 Tue, 04 Jun 2024 20:26:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 9/9] Revert "arm: am335x: Enable SPL_OF_CONTROL on some
 configs"
Date: Tue,  4 Jun 2024 21:25:21 -0600
Message-Id: <20240605032521.1142768-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
MIME-Version: 1.0
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

This is a partial revert which makes boneblack_vboot boot again.

This reverts commit f4b64e9736e73ceec14d51600bed9a8ac48f9fe8.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/am335x_boneblack_vboot_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
index d473a1a793b..3ec4abddd77 100644
--- a/configs/am335x_boneblack_vboot_defconfig
+++ b/configs/am335x_boneblack_vboot_defconfig
@@ -40,7 +40,6 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_DNS2=y
 CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.34.1

