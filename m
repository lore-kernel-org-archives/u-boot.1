Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C28C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFD981E6C;
	Wed, 19 Mar 2025 15:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGFpmNvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D4081DCC; Wed, 19 Mar 2025 15:44:56 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA83810F4
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso134445555ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742395493; x=1743000293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L25HsIkNP3NKHwGpgHBd//4crcfN6Iq+voJYYWWNJ+I=;
 b=CGFpmNvH0dfT0+ScFw3fISDFJ6sAYWCgo/R4pwT9BCNGGUYpTvZfQS9xT9QnGyYvV7
 vrfeWzRTnDKDojIJ9BSrSJxQn0/Bg0qnjmGtB/WCeSZcUmGAv4Bj8fuQEgyOE0kMTqaD
 hc4NDbsPKMAu4Q9IIZFoFTIrrCh0tojPiW3HvrCBtX4Wny7CQ4ucdUBMDf0Vlus7ab5o
 48veFvIxSm4YQH3td4Zf8azE8XXfV5WSKAjCdZ1TDKUBJou6XkoMKylcshu7hQwDe87s
 HmDYqWTTRx4ZHpV8IlbVhnj603Ugc6mkh5C4uyhAVV/zFpwVJ3AmeKIOHumt1iSZC0qi
 B4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395493; x=1743000293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L25HsIkNP3NKHwGpgHBd//4crcfN6Iq+voJYYWWNJ+I=;
 b=B4woxaJnDGudfWzfrzIKRNOzS6WDzsjIlsr8/RkTJpkZD/bYXQEmTjGk0g3yQS4h4E
 psIVYgd/8+ErFA5kxcdHVYAyKZRC+gZozP9dgtqKwgM18d5HARx9p1O6W4xsD7CJ6t4y
 V6l1INja7sTIABBI37qNq81QJ840ArDipBpZX8f8thRhkQgupvr/cw9xrn8zAjoDWpSc
 bw5iGpkQ0yzHdxWv1fcaVj515IN/U/bsnnDzH8oXGSVwYEVGUr0OVbYEsp1Fln2518l5
 HKJAmPmAl2WB0ogLKK34kJs0mg4vvr1SV8F3fPT9WLzscyMjJqvhPmA2QM2Cn/7wGb6n
 d20w==
X-Gm-Message-State: AOJu0YyrndrIyIB9aqynj7BNNYRORr+m/NHSz7xSF+ksvg5PrKUdwOlA
 BgtXRGz6dh8/C72hXCzMkRJqJLu35ReWLo+85+QFBpJeLlUb1MSMehkfp/5QCKptWg==
X-Gm-Gg: ASbGncs4EZGfM8mUOn5yP7qdW2IY9lft0vQbz2TEKYP1zHAhpw/esRdgYQk+0dpxHLk
 +T73bTtK7qvjWuUhdZQgPGDCn1sjj5T3HScUsswA60uPNfnhPlPNKcpghtb/MNqt26It5+BWFC6
 wVArNoLu08hLHP0lNGf5oP31uij6o0Q0we5OvCgqsdwP/omwZ8JPDABQXe2XWlgr70QkNUxmhHi
 zCQVviAJmwZcNj5Jy4dn+1EWpOAvirtwd0ZsieYl5+Jn/m3fSSZYpowN0rJWhKx2Q5WPa18blUD
 PCgxG2m0iiTGA+KyMaGvKTrdZrtg7DlTjacFBjqjU6bfDPQGl3Iv5mh/ZQmt8EAo+g==
X-Google-Smtp-Source: AGHT+IGmg9uADMMzIW7/FopP3fuveeJIv/P43EaIk2KUhAiUf/V/D4MAPHu+qzXZ5zu+KfzjYJTHVw==
X-Received: by 2002:a17:902:d512:b0:224:2524:3047 with SMTP id
 d9443c01a7336-22649922f9dmr36210935ad.26.1742395492647; 
 Wed, 19 Mar 2025 07:44:52 -0700 (PDT)
Received: from adriano.. ([186.175.132.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba734esm114812915ad.141.2025.03.19.07.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:44:52 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 0/3]  Add initrd support to bootm EFI payloads
Date: Wed, 19 Mar 2025 11:44:58 -0300
Message-ID: <20250319144501.32277-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Next boot stages can acces an initrd via a handle with a specific device
path and an EFI_LOAD_FILE2_PROTOCOL installed on it. In U-Boot, this functionality
is currently only implemented when booting with the EFI boot manager. This series
implements this functionality also for the bootm command when the os is of EFI type,
e.g. when booting FIT images with an EFI kernel

Adriano Cordova (3):
  efi_loader: efi_load_initrd: provide a memory mapped initrd
  efi_loader: binary_run: register an initrd
  bootm: add support for initrd in do_bootm_efi

 boot/bootm_os.c                  |  4 +-
 cmd/bootefi.c                    |  2 +-
 include/efi_loader.h             |  4 +-
 lib/efi_loader/efi_bootbin.c     | 20 +++++++--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
 6 files changed, 84 insertions(+), 19 deletions(-)

-- 
2.48.1

