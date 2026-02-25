Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBECEFD239
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 09:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229CA8366F;
	Wed, 25 Feb 2026 10:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Uj8QVvE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B485183DCB; Wed, 25 Feb 2026 10:42:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B629E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6764B3F79D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772012559;
 bh=jgUG++JKgj3DBV5fgW8lmbup5dsbC67WtCGZTVljask=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Uj8QVvE05w5/gEkVscxnQKHwBdllLAuvMnP/EnfGfLCeh9ngFdmUgcNZl+w+01zr8
 9DmucyJgp1mqMT+GVjmO19I1e5sflRTPPIbcc/4Ef9AoHIXLmKciXrfkYF2zIHTxGY
 DKAC1vGn7CQL7kZNBYCT444hK483WPmeZrFhHhtLGu2jGjjgKbHzr/1s3K+JJhQ4ZV
 36hic495PtPFBBwPupY4lSFmxk/UJx98fTRSzpeEmjwTwVU/FknYnvGy6zvwgN71/h
 dEXgUdTmFPaDFWC5d3IdhWBiPlKZa99sIEZyJ/HgOnB68RwK8O7kJSCYEyPo6PJ4N/
 iI2S5Pv7fciVTQIWjuu8dCXYmB3cxwgQLQ9u2gO+KP9GOriqtdrp39uMnJTcIX4JGA
 yTwPyuNQBTv4/I/C8NFVArm2AcFS0CF4xh/4r2xrQGjOp4vMRgbLj/jUFtMOZJO9R3
 jMjKxlqeA/ieUHu563DeoMDCc8BKZmNcZc+5RhAGSr/B+kzH/Xwt8oL5uZjtNQz+QV
 ZG/FrKWHKrHQQRROT3JVaeM0JQyozh9vsjE7/CK8e4WVV5rz7psgSaSPpWTGiGFFd7
 YPjyGHtdAavheTGiaI/+jU5C4WNPZZLlYTS0aK+vREtMDy9ufuDUYo/l1PoBe4epFd
 aErWsJPVMufUM4450o5PHSPE=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4398ad5d81dso833608f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772012559; x=1772617359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgUG++JKgj3DBV5fgW8lmbup5dsbC67WtCGZTVljask=;
 b=O03kerq4eGzsrp40nUtm/NVxtPRYe+UjaUzBwY7vTiyMjSf0fd1LtAaaRTHAyneAjY
 5BQPBQQeo1d6hKnaoJFfZsR+RLOdXzqgWKqKNLfCSs3dw6iInP+/+EB1SQliTCBHsGbR
 7gDqHPgeZwmJGO2TXTauq0o2RvaMZlD2/txD9IWUTNoT83smaFdid176eVo2YtWOoNwi
 pPK6Uy3yoshv2x//CAW4CuX6V3TBt7Rx8dqAH8+NtTTrhFYINse5EhEkYKQzr4dYXCOY
 rx8SeVVAdFrRTFgAeXrIQbN796cjMZNb6ujeT7TDt7XbhUjjRIvX0ruTP6QuBzhAVmhA
 oqsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMPZnbDaYlzNkDaQk6wTBP0VATBk0nA0rGflTFtLm5R6jRvk0qUzljt3gyNmAKX1E3CpM20wU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6hc7uNZRq66cOJxF1aIRADhvSiSn59NMWShmblH1Sy8LPvPy0
 WugtiPVdfbDtzgowiUqgHCDYQtgKL0pVVoTUu2tNWgQBGgaNqnQ/LAM0A08AgqQolf4vy59ZEaF
 OQ/1hPJdPcM/xzASFXHVUxEGJgVOQuhhAPkED8jy83vTq/83eBvg5GPElxjN4y2m9zXLU1cY=
X-Gm-Gg: ATEYQzzvCS9uR0Dxi2RLTq3lXyZORmDXwwM9w8XM3APOQKnIEJojgadAA4lGGJpHI8u
 aXZr5RxkftdOtkbkP71b36Ajd8pNftyUqFII8kvkjlcT45BoGklBhoASGAksWbhqC93IJdGjB01
 SSJyGuFmjeL27sOcZoC98VdQkftX9JauqNEfCZMyqesF+bLq36Tci4qWSBgo6W0ZDuoL+wybkw7
 eePVVGMMnb5NIbdQwnjZCAlAYpbUQ02IMpfxdTFmhfZ2PInvmfU5zDwjWuAyQldE2JKyu6ORlnT
 OxCLitZTayakP2mmyBbRItq5br1kfTkeP6wW5pbFcHFsOw4rg/++7We9yT/butafyt4qmeic3yD
 f4/FGUmM2e39cG7igNC7+W3C8ll7PGLwGg6uV/40O+xsxt0SjagZ/eQMvE1Sy3UFxSvI+66foSj
 PpxwPKsk+hurEmMTMOCsjFVn7q/tTXTEiCOL+JQFfFT9Om
X-Received: by 2002:a05:6000:3108:b0:436:1989:46b7 with SMTP id
 ffacd0b85a97d-4398fa8a0b5mr2748980f8f.15.1772012558704; 
 Wed, 25 Feb 2026 01:42:38 -0800 (PST)
X-Received: by 2002:a05:6000:3108:b0:436:1989:46b7 with SMTP id
 ffacd0b85a97d-4398fa8a0b5mr2748939f8f.15.1772012558229; 
 Wed, 25 Feb 2026 01:42:38 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4bf89sm31156804f8f.29.2026.02.25.01.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:42:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: symbol CONFIG_DM_SOUND does not exist
Date: Wed, 25 Feb 2026 10:42:33 +0100
Message-ID: <20260225094233.44047-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The correct configuration symbol is CONFIG_SOUND.
But without CONFIG_SOUND_SANDBOX there will be no output.

Imply both CONFIG_SOUND and CONFIG_SOUND_SANDBOX on the sandbox.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4af0da2485f..f59fd80d0e2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -250,7 +250,8 @@ config SANDBOX
 	# Re-enable this when fully implemented
 	# imply VIRTIO_BLK
 	imply VIRTIO_NET
-	imply DM_SOUND
+	imply SOUND
+	imply SOUND_SANDBOX
 	imply PCI_SANDBOX_EP
 	imply PCH
 	imply PHYLIB
-- 
2.51.0

