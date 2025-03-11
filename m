Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0049C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D57881760;
	Tue, 11 Mar 2025 18:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZvIlUKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2188168B; Tue, 11 Mar 2025 18:55:49 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3B380F92
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30613802a59so64260111fa.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715746; x=1742320546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIqIsvHLm42ZN5Yl+l/Kl25EHa/MeiRprz7j8zN4bDg=;
 b=BZvIlUKHWVRs55+QgaDLARUwPni9aIHOByb2baM74eYgAtYsplq7cefEdTEPQkzCes
 QNHa+Wp7tUSDTwjfujWY2XLhb4SbKV8P3rPf4RkOEkjHWTp286EI7QJCtb5hhCVFpGEK
 Xit12piaiCQPyHHpWdpoWBkj8CgGKWjLxrN+8Il/8cH4iljwN6koeJRnbV2TQ/1hEKMG
 9YH/ZYC3iTWOKnlZkmmOhS3xaAYhRRromt6un7AkBSpFSO9hjQCPm2ozesGyJRTG0yLQ
 pQ4eVn/KQIE+Yg64I7IUM5qZMsVxPituzrAexO8gkatDyNsBDdyaHM2sEoxLzxTS7AzI
 6Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715746; x=1742320546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIqIsvHLm42ZN5Yl+l/Kl25EHa/MeiRprz7j8zN4bDg=;
 b=oY8By7pts4or+6oQeEqk0IF0MKyLtEie9SQXY4qqtp0kBYLCdofKu+I58wfQfqPyFe
 kR+2CU6BZG86DDSScqPfF5IvBf6Am2vm35KKIg9AFQhDGa4IzLDsHl3x8rwHmXrbo7cT
 SOIm5j0VP+BkfGBnVMnv0xMKiFO/Nd0248LZmlQSrryL5bKuYbPGwXUqwFoRODhXmRVF
 gW8m5lpBjJ2yrrUj+ngBh+l+YWO7HeES8BVzSheduA9LGO6zrwM3qIhS5BXexS7G4glx
 b6CZcpLsuO6TUgiKWVFNp3xxr4DlsRcrOKbmVr3ztOUvlHPuZV8oADBG8AOyKZKOITTz
 7TRg==
X-Gm-Message-State: AOJu0YzxN8Cb1/ZV153k82vawLuH3w8KElUv+NT5dmtY3MvWc9WzLBCF
 NpvLPpZY3djMHXKF9RKivic5PrsTUPcr/BDfirAWiA6K9aYetId3
X-Gm-Gg: ASbGncvyaLwU1jfjyhvesgBSTgElbBjaBVfKtvyaVapmU3uu0JzSRisE/ayxvBm0gOa
 TljCMLKkUHtJ1j50sZmy2YqrXogpNzbyj27/dw6cZC3GePImPJ+RHUTSLzwS0oouxR6WqwiaWQR
 O3XBlg8xppQuixNl3YzTvjo663PqKt1p8nxaM6fBwtX5qr8YdOFcj1sluYEnKYihBT42h1eEauZ
 mHu30c8NZUS8BXdfOKr81w6dJy33TICoJBmVuvDv+dwlCO3+OsGtirbIeiavq5jMETWauOAty84
 4p8BdjMULDwpFefgfwrKrgVzYsOPk7f/z+qN
X-Google-Smtp-Source: AGHT+IG+U1iCJ8EB+4K6lLAyEg1s7SOTOjpr53Iy10/EYYwDVjFAbQkNnlyHyb6yq2w78a5JZxBHzQ==
X-Received: by 2002:a2e:b5c8:0:b0:308:ec25:9004 with SMTP id
 38308e7fff4ca-30bf462ce45mr50739011fa.35.1741715746019; 
 Tue, 11 Mar 2025 10:55:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/6] configs: transformer: add 3 second delay before power
 off
Date: Tue, 11 Mar 2025 19:55:17 +0200
Message-ID: <20250311175522.120018-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311175522.120018-1-clamor95@gmail.com>
References: <20250311175522.120018-1-clamor95@gmail.com>
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

Introduce a 3-second delay and an informational message during boot to
enhance user experience.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/transformer_t20_defconfig | 2 +-
 configs/transformer_t30_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index b69366581a4..6f823ec720e 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -21,7 +21,7 @@ CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2085
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index c5f0bc2a613..9d63755533a 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -21,7 +21,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.43.0

