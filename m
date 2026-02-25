Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B77FD3779
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7AC883AA9;
	Wed, 25 Feb 2026 18:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZeHi2wpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DEA283D77; Wed, 25 Feb 2026 18:38:23 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B438003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41B883F743
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772041101;
 bh=/GK0utXERNA5aXCSHwfd7areEqLKsNXrVGnQYMfkz70=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZeHi2wpOozpP/4hteRwKw5BH85++QhKZO/tgOYc/83olBpFiye73YFlzlF85ruZ3m
 eMbEhOR+Tcsy+j1K8+8l7sDLm2PwDZWzBnU5BvpuIWRLdX4G8/f17Ria4Yvr0wcmGc
 a4cEGQRHBlRw4bIKuBCAEfQ/kx9f6bX5D6MLP9L8CgC/ntUkw5+YyYbJ6GdYH2KLOM
 AgHn4pL38vk7JGpkQsa35x3nW7iL2gswS5UT79cv8PNID+w/Z47A4ifCeSrafPWxHe
 ekXZQ64eCaDUebrDPR3p5qjgB6t8crSmOvDqqOqQ8QLkBY7fO1wjhmUQ3GfVVajy+Q
 jwVGI2enpBG7uFTZleHTWnyaBkISD0ZErMKNmabZPMh3V81D2bfPQGjXkyUXmHDedm
 KjPxpVvduHVsa0AQjLU5hQnA3MRwqc1imApeosn7J1nxy05kgNSSeO9l6yEujPmKiy
 wjg/OTPK8Kxk64q2U3k741ZOND/9MCh5kxeK531iKtDO9hjrn5+Fqrj6myUpWRNpYT
 mAeFbg4xTVFq9gWJZWJ+eKOkD8M9VmdtnG9/tIogOKOJAiOQVcraD8dxgfN0d8/FWe
 Rn0lF7ehXh0ZVTIGDOpOHvlc1nBFivlC9I5YoGsdEG6T/adpVIwTpd5xQX7oQZU+Fb
 yBq5jc2AlD17qgKgxdk+vVhw=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836c819456so158545e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041101; x=1772645901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GK0utXERNA5aXCSHwfd7areEqLKsNXrVGnQYMfkz70=;
 b=eC7ZXivCuaFgToHvmPKzsIDaFjBf0tbUms5TjY33APH1PH3e44JrdtMJEYP16dgAo2
 z7ljnU3Qo5obdIg32RLK6qETrn9UE4PhZgwDXYiLLW3DxQf5TB2zyKlGmud618s306KV
 FNtVuB6vi6CFynXh7ZayBZKAGrL2Pd/oSLALwcB3Od9Zx8ynooVHg8cys47KA+lZVPjM
 sVe+eY5ittdQsnb0qlkmEvUYXdCApJ6LUzwKgiu8hXG+0NVM1gRHOr3ATG2kVd0MIwiW
 QMzyM+IjCcMRPfoH74iBMDD4ZdBW+Xq1L57MEYEcBTfodqo/ap8bK8Duc3GqfnwImb4O
 FK6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ/Q0QT/ZOsmcXAJaXAKOcdh/ABn3wcvBU2q91ML9T1/1zbS3A1AOMWVIGdWGN2ePxvuanNjk=@lists.denx.de
X-Gm-Message-State: AOJu0YyLbPeZFiLJCwflcYVAexZlfS6aG8kEpXX4WrQHgCMOo/7XCbqv
 PZXNR3Ps96aBI8Sy9+gJ/xsnl3uNjPxFfGxK20AHCrgpkfmA2Hhh9u4r0BIIMgkGfvaAU02ogw7
 zOBGUd1k+EHHgnOIMmvJgdXKCRchWAAhyLTBeaLy3EctxK+GtBFMaNGwrkYr8mePhWM+gEdhkhi
 ipJUY=
X-Gm-Gg: ATEYQzxftcXRoCOLnMBNKEOCqMXviITPrqd8/C8SZJBvFQcxOeBkJ4rDIwW3FFOdDkX
 O/uVMYFAqa8iTvNezHiZOInqlRaqKJqfgrPlWTrb6KjkPkKDCuuPnGkr6ShYvFVEBe72xnjSJX0
 k4ALLXYb8kWvMI/1Qvcx/jf5MCk+711a3q96eCsXtUHh5B93AEWGtX+ZT5iYTZRlSeW++KH/nBf
 zhNMYYCvBb51CpnjSYjDDschYHywHTMFzrAqHsGl7/TYPARRCGp7a1ELZh0+c10EkJb+Z9xQTOh
 vUjWg8PT6fFFXAXCRVtlYAfa810S1+hsb3bBChJKxgfqbDRZ/fRf1VaKfUxgyO+Q4XIZhz5gro2
 qr1YdDeBSVzhRHKtWygk5I3ZVx+Dud2ypA01jKzbaswRYKvKbO6I5C1tyA8u5kDNrFk/wuU1ZS1
 TBg8WMf4CqI6SvDfz1AIJf3lCW1+ijMhlzj1si+bU7RK/G
X-Received: by 2002:a05:600c:6094:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-483a962f0c5mr267055775e9.22.1772041100882; 
 Wed, 25 Feb 2026 09:38:20 -0800 (PST)
X-Received: by 2002:a05:600c:6094:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-483a962f0c5mr267055205e9.22.1772041100415; 
 Wed, 25 Feb 2026 09:38:20 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd73ea7esm72374655e9.15.2026.02.25.09.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:38:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] sandbox: symbol CONFIG_DM_SOUND does not exist
Date: Wed, 25 Feb 2026 18:38:14 +0100
Message-ID: <20260225173815.86528-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Do not imply SOUND_SANDBOX.
	In a future patch we could let it default to y.
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4af0da2485f..bd0b54ae0fb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -250,7 +250,7 @@ config SANDBOX
 	# Re-enable this when fully implemented
 	# imply VIRTIO_BLK
 	imply VIRTIO_NET
-	imply DM_SOUND
+	imply SOUND
 	imply PCI_SANDBOX_EP
 	imply PCH
 	imply PHYLIB
-- 
2.51.0

