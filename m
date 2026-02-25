Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8415FFD377A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0902382A9E;
	Wed, 25 Feb 2026 18:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Si0B5Z/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D19983642; Wed, 25 Feb 2026 18:52:39 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB458003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E15273F520
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772041956;
 bh=dYlysv0ym54TpV7yq+kDk0Wer8tbcLtVLmzN+GD2+eE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Si0B5Z/jTf8eY3g0WnwNANRPXzActa5LUwTcbLsAaBUkmuN5yo3psS1pOmomhqxNG
 2tViQO+UdJYlrUrfjB2NJ32nvjQu6uNRv/5pAJJ0ckIcxRcxcCodjJmUMyplLLLZhn
 J7U//y/Gg8kXulf3Chth3VSGFE7ESn3loNEKB3d08l4aIeJhCiNGWldcKwNW48uiVY
 g1EVGZHYlT3NN769uQmTCVGG28GJEVBThElVG0ABIDJ5cxBWZkENqGc6FfCvmXu7Av
 9zTUoeYqM2UvOcmbP7aOHyuu8efDvp5COdTUIuBLDSIrJ16F5aiA1Ad4XMOnUxlaDL
 +NWoIVPkJtAcD10vUUviv+oVy4Qxu2sf3m5/yqD/5CG8rUiAiqMQJbrsKOxUYU2LCb
 H8nbRgpfBs5fQA2IB5hkeAmkWn57AyDPaFYEZWsy06CxDeta3K+rgmb6kv3kiMFDJI
 iDZLCEHxXyhj7Pbj3Eamaj5Dc8x+kzHPEjETThpZMZsZSotsfT+50+66+f6HtYl+lF
 Mq76vNtmyCe2R5BWo8lKiBsjxO1Db+qQexLwPknr1SU3FOW8hYGkb+ffvFO+sYcami
 TJxWBkU9s0+AQEnyjyuFW6Oo2xpqAR9bptvfpBhAMK5e3tJgPETXWcvDtEV//WcgTW
 thFI5WElKK9Qq8VQ2/yMTL1M=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435add03f12so2819592f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041956; x=1772646756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYlysv0ym54TpV7yq+kDk0Wer8tbcLtVLmzN+GD2+eE=;
 b=Yx9oJl3izmV3I4MiqSRDkaGHrOYSF9ErPke6Tb3gLSgtUi2f8V3FpDg9zFfn0Pa8Ru
 NfG6cUT5IlLE+jclj0mmMqt0MAGTrnNL2lj+ZULMB5IeTGGfLIcuc3SLqmT7pqMlh2Dw
 Ok+k3FtHyD+7oFcxopJgkGIqlRXFXIcDYXEfFXJMxqM1FSbj8x76ctIso4qIWnZbHijh
 riLTebwYtg0GJOx50kypgbGM53Bqm8c9TL0xagv9Kq4LYYzfoCNFi86LX/EudXvnnqXw
 1ITg2+PnBwd14ny8/ABpnXHf1hHlSLjodNFMIGnTJmz0vUCNxyI36+zX6bSJh60tsklF
 vXqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAg5d2R58ESrD6OnfnSNbHprz23Q/2R/nUiUJDTgm6mZU+5YKhQGcfZ8TnACVyDn4sun0p2R8=@lists.denx.de
X-Gm-Message-State: AOJu0YwXhLP3Osm7v27OM7YMlOnBOOgdANcYrBobeLTXA9okijmpHoD0
 i7jbmF3Dfc0TzO5Vdo3gLr+2NpyhbKHfN6RfCInkj9bQrALoQFe5rehdC+AcbFWXlcLAIsBptkz
 OPF+yDe1x7E2vQeumjbmyT2p8k54M/Aeib6MQZig2veQ43Gi6BtOTPwk8UIBhg/3SvOm5SNs=
X-Gm-Gg: ATEYQzwh/Bc/d1qS1HP3ddHk5wzmdkqaRq5CiUbNPoVtCg3IPcwkECTRtxbRsYaM1YV
 AoRrAVmhGloqp8TNpr5jlBT/JSvuNCXnkS0f0smU9dxraD3LMQsJjjiVLAdYaiwmTUxCs0m589x
 8mPmQPXQBh8PsA4XhUeJRS+0EfsBK9cehufQGs++Ty476JyYHMiNb7zJScq0Z/yMPYnUmAXBJK2
 kY5TQGLG3wU20Zu/1BgfFgNVBnfBzxMh8eX97zt1XPHJ+Gg32Z3fZDVvGPZoMtSiras9AkBsK+M
 sJZS2VvnH2J4rODlpeG+jip4kT3WOVmGq01tcvc9cYZhUP4Upm32JluQMktMCAQb9+wR6Q1U2bk
 fddTG5kSbLM4jvPVRLx99OD90G/OB4gKc+6fBwNujxH1GP1K24f6CFGxIAFN1bOffJCt9A4T2JH
 FgAaZdeOpzSyAdd7OS5WcHXlnIR6d6G+CUsKiJZL3+/foq
X-Received: by 2002:a05:6000:2283:b0:437:6629:9b82 with SMTP id
 ffacd0b85a97d-439943060camr2312699f8f.52.1772041956431; 
 Wed, 25 Feb 2026 09:52:36 -0800 (PST)
X-Received: by 2002:a05:6000:2283:b0:437:6629:9b82 with SMTP id
 ffacd0b85a97d-439943060camr2312675f8f.52.1772041956070; 
 Wed, 25 Feb 2026 09:52:36 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439941a2d34sm2134690f8f.38.2026.02.25.09.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:52:35 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't
 exist
Date: Wed, 25 Feb 2026 18:52:29 +0100
Message-ID: <20260225175229.88858-1-heinrich.schuchardt@canonical.com>
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

Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_CLINT.

MPFS boards neither use SPL nor do they run main U-Boot in M-mode.
So we don't need CONFIG_(SPL_)ACLINT either.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Describe why ACLINT is not relevant here.
---
 arch/riscv/cpu/mpfs/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
index bcf1ede818b..8054313d182 100644
--- a/arch/riscv/cpu/mpfs/Kconfig
+++ b/arch/riscv/cpu/mpfs/Kconfig
@@ -6,8 +6,6 @@ config MICROCHIP_MPFS
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply SIFIVE_CLINT if RISCV_MMODE
-	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
-- 
2.51.0

