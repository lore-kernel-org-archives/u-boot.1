Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12025FD3770
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B0B840E0;
	Wed, 25 Feb 2026 16:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kA6cskca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E74E840ED; Wed, 25 Feb 2026 16:54:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7155383F9A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2AB63FB70
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772034656;
 bh=NKCBoVPYsIETKZQLIB6MZQQX+ldiBETILGzb2h40hb8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kA6cskca1mJAzTYgWV+UubeCuVqrlm8QTVKyddce0tEA+e2hnD2u+A7lxUiwSEBEu
 HloWmtqH/85EnYUwQMfU8dpOwGo89zTVr3b5/IQ0UO0aXhJKwB3yE1v+R5FmhCmbZm
 7UN9s5TLe4EXajrSFUEIDwkgA1x0jhEyGlWNg3m+RXYXIAxadQumVbGyZP7N0GFadk
 W0HIhuwwl8WlKLY+ymExWzs0W6GbtFNpMDEDP3I7vWjXE6hUI9qnv0i9pIPD9tLi2t
 fEjSStpdOrkdkIfm8HqZ6du3kMVTyJSvi2X26K8JyWpADKXWixiyMk1SOL5PYVSmOJ
 JoR4cwja+OLrhAfK4iYyaAP4Vi/sPIBVhrEdoI13WMwEjqmK9pkXBb9DrMN+dwHwi7
 zvhETj8yxY+vcjYtv312ap3RDG/Rp+fW+kctyNQNCyyuiZ0+hnjqcmvDxe7Cs+xzQ6
 QjiltZxp54ORDIyguRDFML7pbfsZ8kS0cqSMzqY3txMP/XKTt5d8Zd8B9rfI6OTiiG
 9UAHj9aL/XAktoQVAtwHuIUjhi+hJMjRiPGmv30xW7hHWCF/0vQHibDVSxnWQxqCC+
 1OeZ81pZE9az03uRyXscS3V+tE7zq8KKVcIO3BkgtO8T/m7gjiO454H4x8CIs9iCO8
 LiwcNuEDkOEX/B8cpsRg651w=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cd6dfe6so34624735e9.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772034655; x=1772639455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKCBoVPYsIETKZQLIB6MZQQX+ldiBETILGzb2h40hb8=;
 b=WO2mYr3rrFKsSuaDaETeKBwJ9Q4SzJbwg10V7rDBeHyHq+hqoleZSrys+ayjiohi/H
 2cZfaOF4v6/r4XmJu3QRq2YJ3xqQ2PxLCLBPnIJXefHgil/P3FORd0Tre+ESgRBGUqwj
 9KX3OMbc5dosk9tzNekhezDf8O3+p7v70s9SC7RWuzg2oxxzeg+GOxCA5C2iRCK8K7UE
 UooSXzl/qaYcw9nwF/iWWI8pqA+VrwsH6N4qjEE1TK6wZXhNy44m2/JuNz6Qjd4agMQV
 j9hXxq3L+YBxy0DMfH4ercbc+UCD9aidVhskmLF9BMWRCZ6vO6efJOYLLHOHcbvxnHOO
 G4gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+y3mEJFJxcbQuXIMHeM74EWxn21ih7o5XWzEg6Cgfwa6n9duTjB3yVDZDQjVwEdMNoOHsWSI=@lists.denx.de
X-Gm-Message-State: AOJu0YztwYPZZAVipv2+xD/nerkUFU7PX8jbcxo/ovpb22BNwmltQlPX
 pV7ufMZxNiCVYoXcb3J12kLWAb5d8EswHhnss0SY5zP3BFkaxow73rh71mR4ecNRhBLWy9C5xF9
 51QD22I9xcYKSKA5peLA5zso/IwoHoBpleggFsLnG1OnDqs8TrXqe0hHl0KDcKIjkLMjLF/jFB/
 Lv8Wc=
X-Gm-Gg: ATEYQzwxqTogmngZ/yPSMwX6lDA2YUWSowTew2Mor/CwhV2f/ws1oRWlHJRKkbksuZL
 nyqkCe9K0pvG44Rkk3nbaOHv7/A+y8g3JKF89VTU/YY/aFyliqePi2ixoE0n0Ic+myOiy4LEHE6
 8MDGFLCK0xrj7sabucLGDc6SvYfI96x+CRy8PhRgcChAy+O9Dz8YMxYEbPiN2i+fB9hHxWUlcZh
 9OgYoMrLUEZk6Dqx6MobV6u+XI50huD4oO4HsFOA8/rbzOTg8Lhh1cKmIJJ9HJWAtkcCxBX8KVI
 6xzYx4CMfnpzLP+QWqqh4eG4D5tp6ePu0frPH/S2qdmyPqahW1homF7hXZFzvQ0eINlTOAPiIZI
 U4C68AuCoNKYzWRwXzL2PNwqA2gi4tJBSFnuUlrk0LKsWdo15h8vMVRHvvMejpHjINqSOjEUQ2x
 uTmtE8lEw6Ail8yiqtvfDjf1LYIqshBCcpyxPeKcIu9Vzh
X-Received: by 2002:a05:600c:3151:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-483c21aab65mr12087995e9.28.1772034655551; 
 Wed, 25 Feb 2026 07:50:55 -0800 (PST)
X-Received: by 2002:a05:600c:3151:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-483c21aab65mr12087715e9.28.1772034655133; 
 Wed, 25 Feb 2026 07:50:55 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcb9b97sm24200095e9.7.2026.02.25.07.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:50:54 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288
Date: Wed, 25 Feb 2026 16:50:50 +0100
Message-ID: <20260225155050.73841-1-heinrich.schuchardt@canonical.com>
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

Remove the reference to the non-existent symbol. As ROMs typically
come as powers of two there seems no need for this value.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 48b033e7e27..20896374810 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -319,7 +319,6 @@ config ROM_SIZE
 	default 0x200000 if UBOOT_ROMSIZE_KB_2048
 	default 0x400000 if UBOOT_ROMSIZE_KB_4096
 	default 0x800000 if UBOOT_ROMSIZE_KB_8192
-	default 0xc00000 if UBOOT_ROMSIZE_KB_12288
 	default 0x1000000 if UBOOT_ROMSIZE_KB_16384
 
 config HAVE_INTEL_ME
-- 
2.51.0

