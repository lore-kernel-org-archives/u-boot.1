Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1636FC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06EF829B2;
	Tue, 29 Apr 2025 15:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bsBrwHH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA0D8277D; Tue, 29 Apr 2025 15:27:20 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66258215B
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af6a315b491so5787696a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745933235; x=1746538035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QbU+nVG/JxUXC99/4+wlNBplgEivsCl6ypKt+hw0MjE=;
 b=bsBrwHH9aVe8cTJrZOdD06vtyJnBKltb2qu7zerjCDqGw/XLop+vJi8OtVF5xe6qFH
 umzzdGObvIm2sAa3rsA7Nkzc87I+QShPgpYwm+O4m4diDhQV7Hm+j30cSqFJzeXFUOVB
 mSQmAroRWstQxLxS5ineLWPAltBAQM4edY8XFiK0Y0H+Mz3gYxPCRhA9Cll5OGIU3IdG
 rxRyqfGQDyGBLK6wb2fALfvJuhq4iaVlQt5Yg557GShyhSxgu45Hebp3orUbd14BKf6i
 bQVPDjWSs8n/rcocZz0ioLy0QTF9qrGr4+67VDHvUgXzrz7qNoulNypcDR66w5CtTtud
 DEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933235; x=1746538035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbU+nVG/JxUXC99/4+wlNBplgEivsCl6ypKt+hw0MjE=;
 b=izbsNGXbmI65SC40PXJ+n95fwAjW//VOK9SeHnjPq2lnGOhh04Bt2+zqEXEjP2b0w5
 u0yTp2gDI43ZXitbaSqjbqEMF2ZkqV0lEGj5Zpc+enQRTY9ysBIsRcqZ5fxa0ZzVHj9B
 wMT9lp89ayZYVXSvuMrWf/hyQYHbp/HwT68zZICideBISC8EIEZTNvFSYgtqN5/LDqPt
 0ZdyLOmnwAus+qJjjAL+JNcsDk6ubIo4LpjNiLKSj5ix9kc4ddP1Vd3JlFAt90JhXbWL
 hluilGjZBOJSZPLfscuKVaRxVUuJ7mmL+XJjEK88Pk9aLp8xZ+rcLDENB8GciqjYniPp
 wcXA==
X-Gm-Message-State: AOJu0YwA+u1N5lbpYN7I3KzO1GlR26bdgZQAYPBbN/15aF+A7XhPNULH
 EMlTKwPVkT45b0DLjKVtzbc2GqTRLDvEq7uy4/GUhGQbuAQ6/M9SR/MMFG4HIhs=
X-Gm-Gg: ASbGnctgnDv++L1sdfIlt3vXhDYjv9pl28NMdmCBVw3v+EYMD+vSA/duKAIHRHSA7Cx
 kGfVUwqQtZjmdizY2E0TKIyUzjMTs0IL2BSq+1pl3yc48fSDbdHcdqpomRkG2G2DwzW+z4V8wgk
 eXiZTlFf69LCtVSRqKVDW1gINUGgtmW11matOD3AVLj2u//I54rtpLXPuiCDgBokOfIoa/d+JLZ
 khYcIRWmv9/OFZlCJEhRpFVJ/bmAVfT6++ruhbMDinWmasJMovQjaclzUoiZfD0IYGLrxjL2HC+
 mmcmqA5D4GcjfMf1O3sh3NwqaK+6dhVLuMytjhvH1dGwgSGEUQ==
X-Google-Smtp-Source: AGHT+IGivXsPLsGex5XOoRS2HzD99sxNmlywzTpkVvV7lV6TYm+puAvHhMmGukWKegZx8MeBXYqANw==
X-Received: by 2002:a05:6a20:d490:b0:1f5:9d5d:bcdd with SMTP id
 adf61e73a8af0-2046a3ed5b1mr18179745637.1.1745933235197; 
 Tue, 29 Apr 2025 06:27:15 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded711sm8892333a12.66.2025.04.29.06.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:27:14 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 0/2] Fix initrd loading in efi_bootbin
Date: Tue, 29 Apr 2025 09:27:54 -0400
Message-ID: <20250429132756.2105309-1-adriano.cordova@canonical.com>
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

This series consists on a couple of fixes for initrd loading when
booting an EFI binary. First patch fixes
36835a9105c ("efi_loader: binary_run: register an initrd"),
second one fixes a small typo on efi_binary_run_dp. Patches are sent
together as the typo propagates to the first patch.

Adriano Cordova (2):
  efi_loader: bootbin: do not load an initrd if none is provided
  efi_loader: fix typo initd_sz to initrd_sz

 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootbin.c |  9 ++-------
 lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.48.1

