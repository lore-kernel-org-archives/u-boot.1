Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE7C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 09:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971F083046;
	Mon,  7 Jul 2025 11:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1MQAzr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA03830B3; Mon,  7 Jul 2025 11:53:32 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54BD83043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 11:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a528243636so1573070f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751882010; x=1752486810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=PXl73i83e306+idLpvC2DikX9c1rwWnNu2DI5y84QaE=;
 b=k1MQAzr/oOLCNDbe4SHVVxv9omPmEAng9BQba18Pm3ugn8U/Ar2/8SdkwfdozLANeX
 o9WLszBubGww9p/ksgFBEFxrqJ1M7bBNRkaHY+EKL7+bAZjMjJj4E3hERebhpyLgdVdW
 zvcQKfhz1uMbMGzHK71XHAllx0x7H2HWG3Ohg5h8dYgvUrvnFQ88BrmwhBFL59ClB610
 GxuViOMdrVtVRGAu6WDVNBTvDmljHOCkMjYG7Pn1VrQm4cYbCeFLblw/f+tjZLSiE8tN
 ygGnmcfGl9sAfDnktA8O2qK1TxwUXSpAKFIxSyCRv8FLdwCmtBzfgtM6wZLd9G62VRbP
 m6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882010; x=1752486810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXl73i83e306+idLpvC2DikX9c1rwWnNu2DI5y84QaE=;
 b=B712/O/gSQV82m0rNEjTUu4p/DQFtlLj/vTRI+5khqDlrJAfShLngEYPixHA6xHEUt
 GG3zZRSoAECMnC66sbMSrzudyUxZIn30fJNrRpuIp1pM5o6GQ2s9zZgKjefTMKTXwxOy
 tudTV4uXmyns8c/OcyWDnZM3u8bdhnF9GE1z5klFDwZ0LgUb6v+PsRkx7P79Hrk0K6uS
 f3EmkzyJoUg5Nqim91tt1x6jdTHmHep/8Dzi2mz9y/K/Q3xAN290OXHvqc6yBhIgukdG
 7VeiMroekK7ufZctekT6cN/lGtQNdsYzkJqTT+q3jlnQWzirP4NGBrglWweAZo/ug9LB
 CBAw==
X-Gm-Message-State: AOJu0YynFNmVG5rAJEb6LjV3Fkh4TfXtY7XskjL3ycdbdiFaMctfWzAW
 t6K7Rn6TY+E7PLroBfOaadQE3ThFld1CTl652zyfy8M3TObrRTmA5OQgLpYjSLBH
X-Gm-Gg: ASbGncsZ4SFIujr+JFWui91J2DBBuB8KuBpEIBPZeQcNq6hXn+vnZZQ/uIkXw8BL/W2
 9eO2yeWksxPsgl28hi5//e13vZ8Swc+Dz4xR+9HG3YdJzfNmYUAl6sXdF7ekkSmkV0NK0hqbHgx
 Xn9YBD5/wmBfcKiHC+6y6JRwS6KywM/cf0Jf6a2ceH4TjH9qq/qIbvDXF/4xKUurr/YHdzOngWm
 XnhtXXHszRuZwSuvJWs2VYgdKl1HjY4K2CH0Ml6JR0TA3xC0s+r1bLfGRSOppHt3bZU8aPxqsBB
 HrijjZ8n0+JxxScFFEbhqWrJGz5O5v9vqJThWirHWvPSado02eNeZ+lAZKzE1w==
X-Google-Smtp-Source: AGHT+IHpm0eoIgOHaNSvRPGy/wsFbH7ovQZROJNseadP4ErcpeccYeTfVtTQTj7qWVkRJNNH/BZ0vg==
X-Received: by 2002:a5d:64e7:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3b49aa7dd72mr5122861f8f.47.1751882009487; 
 Mon, 07 Jul 2025 02:53:29 -0700 (PDT)
Received: from localhost ([2001:8a0:6a5a:6c00:eb29:af93:a639:c827])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454c041cd4asm52807665e9.28.2025.07.07.02.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 02:53:29 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Subject: [PATCH 0/1] efi: turn on EFI_DEBUG_SUPPORT for qemu arm and arm64
 target
Date: Mon,  7 Jul 2025 10:53:21 +0100
Message-Id: <20250707095322.30222-1-paulliu@debian.org>
X-Mailer: git-send-email 2.39.5
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

Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
CI build testing. With this commit, we are limiting its activation
to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
sufficient for our current needs.

Ying-Chun Liu (PaulLiu) (1):
  efi: turn on EFI_DEBUG_SUPPORT for qemu arm and arm64 target

 configs/qemu_arm64_defconfig | 1 +
 configs/qemu_arm_defconfig   | 1 +
 lib/efi_loader/Kconfig       | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.39.5

