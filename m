Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92097C282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 07:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797528142E;
	Tue,  4 Mar 2025 08:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="gec1VXEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB06281426; Tue,  4 Mar 2025 08:03:44 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123B180FD8
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 08:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 77D613FE3B; Tue,  4 Mar 2025 07:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741071822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYWiLWQkBfEzA7GGTyOHThTtSZO/j3NXHTEzdNXyrRo=;
 b=gec1VXEzmhVZqs3J/9lP87A8CzZ5VcnAbqRtscike1t0aAd0z7HHP7TTyIgmxfsX4tFsn1
 m6vTASDgFvtuzf9RorXi9VVFYWiW8CJME1nsRhsgzhS/Hsd7jlyo7X54VvUWGrgAKOloAR
 RkHHW54szvMAt2t1aWMyV346g8TGXWp9JQFCEkId/vKA9T//dgljLTNSpnsg5ACDS19kGL
 G/L2JOX3Mxi0UyH8duopCkToby6JnEsen2ngiC/Q2UmT3HODDfcltZVryiltKcSXj6RSJE
 4PON8u13AJnPWW+I7E8nhSTLXm3Wcq41gMKxDVo98ocvLaA786xIqkw4QC+Elg==
From: Huan Zhou <me@per1cycle.org>
Date: Tue, 04 Mar 2025 15:03:30 +0800
Subject: [PATCH 4/4] Add reset config options for k1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-reset-k1-v1-4-dc9510ff1113@per1cycle.org>
References: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
In-Reply-To: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741071809; l=1012;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=Imm6BQijUOxO1aMuXyBdXSqjIp93YrZhK+aZSZWvbN8=;
 b=bdaju3GeGG/XKohxfSsezs9FeLyjQY+lLlp0MV8MmuAa6m7e84ow+bYzJ/ukIvNtLdl2LIXyJ
 IW4gy0RDRL2AhDt2zjbAfld0NWLOvtATDiJ+dwIFy62LmHDE7R7EwnM
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add RESET_SPACEMIT_K1 option in config
---
 arch/riscv/cpu/k1/Kconfig     | 1 +
 configs/bananapi-f3_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index d9cd8dce96426bb4cbe9ff38385a4c66116fe341..14201df80f2c0bf304225ef6d8dc8e72ff508815 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -13,6 +13,7 @@ config SPACEMIT_K1
 	imply RISCV_ACLINT if RISCV_MMODE
 	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
 	imply CMD_CPU
+	imply DM_RESET
 	imply SPL_CPU
 	imply SPL_OPENSBI
 	imply SPL_LOAD_FIT
diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index 0f12db3db848badda1fc7192aeb0190ac22a269d..7483f128baea9d8971efc9ed166aa042ec32d908 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -18,3 +18,4 @@ CONFIG_HUSH_PARSER=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_RESET_SPACEMIT_K1=y

-- 
2.39.5

