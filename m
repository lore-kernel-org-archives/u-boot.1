Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8D6C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 05:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FCE8214A;
	Mon, 28 Apr 2025 07:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745818154;
	bh=2gQ6zeHMrnECVmW2u++uTw7Z2w4rGvsP4WYuYyaKtvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qrb6poWaM1zKziBlMbClAigRGg46Wr8AV9OhCVtshH/PELDCR9p/M10Hg8uMvqHgc
	 klYRCecFRlyH2IoH0lYn5mM1FaAvdEH0Eo0YmrUu6CT6SctTmV8Cf6WjZuZsSgYXhR
	 KsKnD/SX/FM+czDUw3tRa/6VJNQmMoJPFKS5DrYsDuwkB2T9XWWmsSx9r79fekiVfp
	 AfpK4guQcM99FsGkiPgGQ4+rxRLxFDfbJ46Kxq+TOlRqVrgp1bKd7OrhgQsOrB32wT
	 nhH++knkhdW9tthCLZnqEzuTqWDmlg59hSf3VIRnf7WdA5KKNsnQNpDp3XP0T+pU+6
	 2fgRlTkwXNb/w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E763820F6; Mon, 28 Apr 2025 07:29:12 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0158210A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Xkp/YFod"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 12C651026E03B; 
 Mon, 28 Apr 2025 07:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745818149; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=2gQ6zeHMrnECVmW2u++uTw7Z2w4rGvsP4WYuYyaKtvI=;
 b=Xkp/YFodWOPaeeKotTfpj6ICfRuGuNlmF69KCLXZEtkoohb5CrdezbpU+1g14rY2SYXT2V
 3sIqnPBNLeZP9rpgh5Qg9MLt23//b6o+Ev08DvZZ6r9Kt+sgt/CfEW7wzZPlcT/4sm+a4i
 ZU46CuQhfPCCobA2dcdSvEZ1qH5grPpU+pUYzV8L+paGRjSIIeTaWk9tCCui3AS3oni0Cw
 I7c0sBHYg3paZjBUnRGDa1KhPkCt0PUbafRn8oiFqvy6blrNswuFgCr6V5Bt4G+pGw3o7N
 sypw2qtQwYUiePWKipPAsONrSuWTUzecEaERlzUhz74Dxmf7mcZ7i7mCMrzaxA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 4/5] arm: imx8qxp: capricorn: move env offset settings
Date: Mon, 28 Apr 2025 07:28:56 +0200
Message-Id: <20250428052858.100083-5-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250428052858.100083-1-hs@denx.de>
References: <20250428052858.100083-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

move the ENV_OFFSET settings from common config settings file
configs/imx8qxp_capricorn.config to defconfig file for the
cxg3 board, as other imx8qxp based boards from siemens has
the environment on other offsets.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v2:
- new patch arm: imx8qxp: capricorn: move env offset settings
  in v2

 configs/capricorn_cxg3_defconfig | 2 ++
 configs/imx8qxp_capricorn.config | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 5f09ceee8bc..5689544c1d0 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -5,6 +5,8 @@ CONFIG_IDENT_STRING=" ##v01.06"
 
 CONFIG_ENV_SOURCE_FILE="capricorn_default"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_ENV_OFFSET=0x200000
+CONFIG_ENV_OFFSET_REDUND=0x202000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index 032cab63af8..463e584530f 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -10,8 +10,6 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x200000
-CONFIG_ENV_OFFSET_REDUND=0x202000
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_PART=2
 
-- 
2.20.1

