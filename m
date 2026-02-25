Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07D4EFD23D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 10:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4660683D77;
	Wed, 25 Feb 2026 11:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="USY/krwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1E283D77; Wed, 25 Feb 2026 11:00:31 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D84882A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C74053F73D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772013629;
 bh=foFJffxgIhLk63yq+Ux6/UBGy9twaFstkwirNxAUSmU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=USY/krwGyya5sR+uBBFpRMSl400Cp1CRiNJrbJnitAVRBRhwgdv5dtvWogbXMxoJF
 CwrtT5t1sffNWkAHz8ZF1ENlg2KRrQD2f8RJoAs8pE5Jv59g69gBMJD1Z+IbjWIRz2
 6OqhXIm1R8QMdMcaCP2x2v7Ew4YLpVXnBS6gVcf7a/ELbMyRd1aznolCMGjt5nn4D0
 FvqQS1Ri7mBzTxVGDCjWhw12INiDOHGV/lJ5RjNWsrxe22Ba+YKTCX59XUFJfvWjqF
 y07vkPPcNHE6vq6ALIAFubiJY4yCkag+QHlGc9C/WmKYeOd0Hpf/CKsqdTUNcWKvju
 qODk9a6zESNNy6ftVmMdJvjJvA74tlfi57kzzcum2a9ctWwKa1L37zN8xPp6pNd7a3
 3nOupaEqBj7HXGA+kcxcHwywklWXaXJ5Vnz+ZTMj7smi1oxo7FiMQ78tvV6N5PUOH4
 lgO0jiJdDsIrKlwVPa+WlHzqcbPSdFR720UHu6m4k2sjtQrCmJp3PMHu13/bb2dzTU
 bdczo3dZHkx7CO8MAAtu/yIu6j4oPNSlXeLwpaLpueiqrhLirLimUETDcdp9dPUP1K
 Ry8VoMOqUNXwlmC/pFHWe+z0JU7mRGpkwaPQKh0RiVeL/gjtYBwXf4pQxvggXUqo+w
 lf6ilAD4duO+G5z8wMzU4GxU=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4376761037bso674985f8f.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 02:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772013629; x=1772618429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foFJffxgIhLk63yq+Ux6/UBGy9twaFstkwirNxAUSmU=;
 b=RuqCQzTVoaJBw2ErksbkZZ1IIFCfuCsWB/3PtIXKLooUATJ4pMq3EYuy3aYLf5ep1B
 KMPUrkKIKET7+HgLKrlEwcrtT9DDuplzqvpYHmIPaD/X8SfwpaArweHSlAZs+Jw1KG4b
 OPJs1DzV53TLHA4FLOPEcPbdUSD54Z4MFAuYADswRX/HY1kjkkC1hkCWMbyQyKRf/qyi
 7T5wxcpulGDBNIVJofngtfMyzqz8/2rAQFE3qFoR80KkDW8EK1OGQOKueBqEfqsodVgf
 vETSoEDWl5zt3VqTqxr1uy1t8xjlPs1EI+iROXv5edI/qzuFE5ZpXFFDMsJWwHsQlHnZ
 8jPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmXerJfWPzdCtV5YhY/PQFXl1jQwwhHN9fVNXTCkZUuwd5I1ywoBaUNqvTM95lgBVBm+724Ts=@lists.denx.de
X-Gm-Message-State: AOJu0YzNg4qhtuPxUoi/nzsJb/co4P120hHGEaPFbx0Mf4opF5GgfIsv
 A+UBiOdsJ7zW35iAR9VuPYgF7ITQYFIDzAVjzoxRwMUlLSPNN6q+xmCi0NVaKHNgzq3OBqkQQiY
 lxtLz7CEyLIWLnFRgaye4W28+ZeBkJkm1agmoUk4LaA3laeJ8GYFZNqnj0+RdvGEPHgRBLd/20f
 aXb8k=
X-Gm-Gg: ATEYQzyoF6BqbPOqdK6vkvnLzOXkERe6bESVV/eeE8Kg5vC/IAXoejPW9+04qCJDUZh
 gpBui1ED5x0++K/+LtszDbeDIQF+8aFMp7oyNVRwjvESVnIDOtA4723bR6QRJpL6l9lpCy0gnsn
 UWHTCmjb7DhBfIAljBGdk+iSRcaAWOBa5Nfyhi5hPYH/9MsNEC6faO2n+elZ/8zL5Sxw+tBSO6x
 G7m+z4crLbTmgXq8yy15RsrquKzl54Nih+2JNAixjgGiPhslWMZ7C6dtcq9zpvPA5Cmrrao8Ti7
 3nHNrCshXi3QRnEgCjjGpBocV94uInpf2fuau37JZchjANBU1K86OBcjfxOtgin5vUopp2nMtug
 jsD2+TDR27A6c8CyR0IycttZVPYIo08SjMIWCTxycoBOVEuP0yAvSicvVlH4zdcCIEMHNfnWJuX
 OCICbaD50tkiN5q2qMqR/YVG81SqPGdWg2RJFpmBC/YTPG
X-Received: by 2002:a05:600c:1591:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-483bd713cf5mr31016015e9.4.1772013627814; 
 Wed, 25 Feb 2026 02:00:27 -0800 (PST)
X-Received: by 2002:a05:600c:1591:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-483bd713cf5mr31015705e9.4.1772013627383; 
 Wed, 25 Feb 2026 02:00:27 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df90sm62473395e9.14.2026.02.25.02.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 02:00:25 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm: exynos: don't imply non-existent CONFIG_KEYBOARD
Date: Wed, 25 Feb 2026 11:00:23 +0100
Message-ID: <20260225100023.46116-1-heinrich.schuchardt@canonical.com>
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

Symbol CONFIG_KEYBOARD does not exist.
Don't imply it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/mach-exynos/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b084b7284aa..06448e875ef 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -34,7 +34,6 @@ config ARCH_EXYNOS5
 	imply CMD_HASH
 	imply CRC32_VERIFY
 	imply HASH_VERIFY
-	imply KEYBOARD
 	imply USB_ETHER_ASIX
 	imply USB_ETHER_RTL8152
 	imply USB_ETHER_SMSC95XX
-- 
2.51.0

