Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C8CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD08803C6;
	Thu, 28 May 2026 15:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="fMF0urhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314268056B; Thu, 28 May 2026 07:21:13 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0670180398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 07:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1779945670; x=1780204870;
 bh=dsn9rW4ymwii47Iu93QT1fMIoF3wRApuuT+wlRXgKVI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fMF0urhsH4UaTeJQ75uylYnZnXRgGYDY7KAajjzCo718b61/+xVX603azmEBrwssV
 wR5B8/vGFuI1bz7DRZ96X1Rz58NzUkjX8rwI3PGweJtbM9sMgspfYqRFybcHSnJAGI
 zKLhbWggYhuMzfdR6w/EywC/+5oe3tKkWaMqckciypAWnU9SNCfpT6ru4yqNNtlZNd
 CNCwzhMdMsiPhiW6bwkHywa19Pf0nYwW25N/oCCa4IS+5TJ2yFTOOqhi1UNxO/N44A
 f+zFp7KLSse3ywxTjs8GSBM0CpgstQpex2XOsPyhE0RKFoaNZMjH0v2ftR3JICkpzZ
 V7GKSyuEVibwg==
Date: Thu, 28 May 2026 05:21:06 +0000
To: u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Brian Sune <briansune@gmail.com>, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>
Subject: [PATCH] arch: arm: force 4K page alignment in linker
Message-ID: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 9e92ce04207531337c813697e04b6c613d7889da
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 28 May 2026 15:30:21 +0200
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

Since 5c71f8110, the u-boot.elf produced by dragonboard410c_defconfig no
longer fits in the 1MiB aboot partition it is intended for.

To be precise, this issue occurs on toolchains that have a linker with a
COMMONPAGESIZE > 4K. Since u-boot is hardcoded for 4K granules, we
ensure that the linker doesn't try to align to anything larger than
that, otherwise we're just filling our ELFs with a bunch of useless
zeros.

Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/config.mk | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index a7eff84a267..bce9a31e966 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -112,6 +112,14 @@ endif
 # needed for relocation
 LDFLAGS_u-boot +=3D -pie
=20
+ifeq ($(CONFIG_ARM64),y)
+# U-Boot uses fixed 4K granules, so we force the linker to match.
+# Otherwise, we're subject to toolchain preferences, (e.g Fedora's
+# aarch64-linux-none toolchain selects 64K granules) and we end up wasting
+# a lot of space in ELFs with MMU_PGPROT enabled.
+LDFLAGS_u-boot +=3D -z common-page-size=3D0x1000 -z max-page-size=3D0x1000
+endif
+
 #
 # FIXME: binutils versions < 2.22 have a bug in the assembler where
 # branches to weak symbols can be incorrectly optimized in thumb mode

---
base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
change-id: 20260528-4k-page-alignment-6cb594a073b0

Best regards,
--=20
Sam Day <me@samcday.com>


