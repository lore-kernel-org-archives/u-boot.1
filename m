Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D9BCF34B7
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C4783F69;
	Wed, 19 Nov 2025 15:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mGKUjDm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2882283F56; Wed, 19 Nov 2025 15:50:35 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0959383EDE
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3e3dac349easo4051211fac.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563832; x=1764168632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gR3ddU4g+uN4KX4qcSUMkXUYgmm6Rz3PjskNnLDQqFM=;
 b=mGKUjDm42HI86s6ZsNT4ZbuvbUiP3FnowOGkt3nDWJ0fXBkI/lnU05odhSbfTte+Pb
 HooJHUaVBD2tkSGfV9mR4bWbVfSXQOM1R+iU8uP9ue7m1AETqU1k+mIGgzLMj180mJXd
 bNY2NZExMxXueDexFQ6uY+PidsK2K3emU799Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563832; x=1764168632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR3ddU4g+uN4KX4qcSUMkXUYgmm6Rz3PjskNnLDQqFM=;
 b=XZZVb6whEFUY453eNjtWQPiZFw9dwbYlUGIg2+HO6IuzPGm7yEASSVL3A1c197uwtM
 p1DQM08uvWCxypnWdhW32gQzijnJk4y83KH2P+6UUe5qpLxkAsXYuu6qG+2ePd/jyE6l
 cj88hQT4FAwiurgMf99h6JLZ6X3766O1AljO48ctyPi+PXvd0Ph6ZcdmZ41pF2D9GbpJ
 YoDuBkg1jlRcbeT7/jhd/SUi8jWuDDseeCR+0c7DNA44DFOjCfiUp+RZK9UEESSXkXC9
 ZqfxbS0njjqM5IQvZh1fUOVlxAL5sMOsrf1tIi/6Jmd4L+27fNlcrLox/qiO9X4YmjFk
 9VwA==
X-Gm-Message-State: AOJu0YwoJiwy3qTA/yJDe/5R/u+k/AXszT5wFgoOXYknKHUeVE6vYqEd
 SRDjA/GVxMaODBiAQn1RQScakfOamsubU4z7ZxEPpHAA6tYXpboc5mlwm+0OoUdSPcogt/04vvv
 PwVY+xRSOYA==
X-Gm-Gg: ASbGncvIOBUi109aNc7ssgG5cIHPZuZg3CmAVs+73SXKcfM9NY8ZyhEeaw504uXaz9i
 0AqxyX2EvzSCJIs//wUayjoXLtUjejenRG5NPocyenjrkC7eXds/zOjhoM0AvJL2aSAylaYHcIR
 3OKh8BjCXll7ZmGkMWvGi/GooQqCDaR0yW4jS4b/NhuShCnS3n1tDenvKAguOQnV+rtF4fPZ4ad
 wOv/UBFg6HHS92hqLE/A4gUwio0PKNlPv3CK3Kjn9qou6/STGcM8bc5OFjSgEApuxAUo5z1sZZr
 s8krsDl9gcSbdyMOQhdNqk+TFObPdF7Nf2lq59lq+UCQcWZrRRZwcFaie3KBUmrvW3JBWihGeL/
 PxWGlGBY+VWPR3hEupT8A8zKNrwz6KRrJkwheSnSroKKN9ypQQ7sGPobJNDkU9zKbrRwN0EoAzm
 QiBoNCCoGXQ2co9pRXW9phsy6S9Lukp4bzsz/uBJ7trPmOfHl3C6WPpvcGra2+BLM=
X-Google-Smtp-Source: AGHT+IGPw28hKwuFzTNee1iVCVjLgBrZcwgxtfXKMtq5Vq7JlG+JE15wyZ5PlHjbdO7L0cFUKy0Xxg==
X-Received: by 2002:a05:6870:e996:b0:399:58c2:2e5b with SMTP id
 586e51a60fabf-3e86918a45fmr10850126fac.51.1763563831789; 
 Wed, 19 Nov 2025 06:50:31 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851d64d3dsm8264479fac.0.2025.11.19.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx8qxp_mek: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:30 -0600
Message-ID: <20251119145030.842143-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/imx8qxp_mek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/imx8qxp_mek.h b/include/configs/imx8qxp_mek.h
index abc3603bacf5..846b422b0f26 100644
--- a/include/configs/imx8qxp_mek.h
+++ b/include/configs/imx8qxp_mek.h
@@ -29,7 +29,6 @@
 	"panel=NULL\0" \
 	"console=ttyLP0\0" \
 	"fdt_addr=0x83000000\0"			\
-	"fdt_high=0xffffffffffffffff\0"		\
 	"boot_fdt=try\0" \
 	"fdt_file=undefined\0" \
 	"initrd_addr=0x83800000\0"		\
-- 
2.43.0

