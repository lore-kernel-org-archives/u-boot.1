Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B489FCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41BE80FA1;
	Tue, 19 Aug 2025 17:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QiX9yGEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A1A82E37; Tue, 19 Aug 2025 17:40:35 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BE4809A5
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74382015df5so1010520a34.3
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755618032; x=1756222832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6BJPnbDr68DNh0ofJ4M2YnFsN1Xljh5gBxGvsdAX4zs=;
 b=QiX9yGEupnQpLHx/Z5E252d6JKgbnruTT90faLB+bHWorg9AiwXTQ7eSwkGXPCw3dx
 YdxZ0Sf7GqK5OsZbl9BD7jz1fS1KJ9jwVkCNwVgEYOZgd/iJA5Ilhv7bZ8w0vj1pQ2v2
 /ZZpNpCvryCGHBV3nQsO15jY+pfL2+6qpKHUIAl+7qNAPOPdNwoMAAwIzWHAJvhCyCiB
 138idLO5ZPl8BXWJdjc9WrTSFxgVBHlUm87u8TZ9p0fBXMSdMWAw/pTtKdWEFtPVNQgJ
 6fEjuMN12thMKLB3H1Pk+3TBrz5GWHv3gEdvnai20NpcXAOvTr3W7RB9LwcxPyvCa3tI
 BskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618032; x=1756222832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BJPnbDr68DNh0ofJ4M2YnFsN1Xljh5gBxGvsdAX4zs=;
 b=wi9jYjMwx7EdUF9gXMgEktVYGKUj4E4xyMeAwrf6voOT8/xXX9OiMY5kKS+fJK1pT9
 HfHfcnaL2kBSvcwK+USDqk3TTQwT8NsvcCJlFfbigFl449UUUKJajLgQnxAC8pkSJ3le
 VEDPCMeu67Qw95EfiIG/8/sGAJzdmaIZS8IDmgER9LxqnGWKXuQTYGbLfyYBkSzjhBQY
 riCaYu/7hLfOL1vP9Js2EEGKJvYb7bQcjesWSAW1wFOIheABQiABRcgPM9UqA/dBIs8E
 iYd33wX6n6oUwEuG2Vy+2/A0D0NyUs15vNTzoatyDDGb4xniQCu/iQI7Qu5RfXbiwrjc
 xmJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtSN+XTZG+tk+Z2EjO29Ol2s+BKGhcaTb5GrxxSLafSKjMtqrR7aS6vNCE8lS08kxtu9acR6A=@lists.denx.de
X-Gm-Message-State: AOJu0YxUf1U6cOpZsP3y88ZE9qcpSBb94gtcLYIdS140D47C19+qJhci
 ceoVNzJf1mvrLqekuaG8fTMTAWxZNbryFvRtltJC8f0z057TAojcmbaL
X-Gm-Gg: ASbGncueVh6ZjrE426zlxPNau48QkcrB1zTTHCaRTuxd6reofLVIGZ94VIKPJ/H6tpR
 ZlG62rnXqrMDiYazZ0y8cOcwEMrGNKBJtiJQwhR+D6qWSDrVGWscTR1des+hzLJHLMkrKtpomJE
 p40qHwQMZnVvJ6pPrv7Mo4Cv92CniLce0jv2xtKX+Akw3wzVOWrNUr4XVS9Z6C4zFOE166vuSKN
 NXRuWB2qLBEU/6EbgNbIb9vGGuJS92pyFgFt1otN2tgckoX0gXVjOQnP1fAbTmLfDicWXAH3RK8
 J6wRKgcWhby2u0JUWiZqPOPlt3C8rpsJvrXQtjXGZBR779tefOhSaPxFRpDbQdqgKnIBkFubyp3
 ApKCeNx+MhFB21tGdjTiQvXjup4SqR2bi6dkCE7OHt1JSSQ==
X-Google-Smtp-Source: AGHT+IFAwiX2ilAvJDfHsIOdHkLZ8omR2KLaaoHqR/dhJ8wmHTS64H57H8T6pp8k2yjsOEQlZvQ9HA==
X-Received: by 2002:a05:6808:2195:b0:434:97b:5eb9 with SMTP id
 5614622812f47-436cdd1b21amr1739143b6e.28.1755618031798; 
 Tue, 19 Aug 2025 08:40:31 -0700 (PDT)
Received: from cypher.home.roving-it.com.com ([4.31.143.193])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-435ed2054fcsm2323107b6e.31.2025.08.19.08.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:40:31 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 1/2] p3450: reduce size of Jetson Nano u-boot.bin
Date: Tue, 19 Aug 2025 16:40:13 +0100
Message-ID: <20250819154025.604784-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The Jetson Nano contains all it's firmware on a 4Mb SPI
flash, the allocated size in that flash for U-Boot is
753664 bytes so we need to ensure the u-boot.bin doesn't
exceed that else it will fail.

Add a BOARD_SIZE_LIMIT and drop a few large, and somewhat
esoteric, options to bring us back under that limit.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 configs/p3450-0000_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/p3450-0000_defconfig b/configs/p3450-0000_defconfig
index a002178b7fb..518ed6b37a2 100644
--- a/configs/p3450-0000_defconfig
+++ b/configs/p3450-0000_defconfig
@@ -14,6 +14,8 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="tegra210-p3450-0000"
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=753664
 CONFIG_TEGRA210=y
 CONFIG_TARGET_P3450_0000=y
 CONFIG_TEGRA_GPU=y
@@ -24,8 +26,14 @@ CONFIG_SYS_PBSIZE=2089
 CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SYS_PROMPT="Tegra210 (P3450-0000) # "
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_CMD_IMI is not set
+# CONFIG_CRC32_VERIFY is not set
 CONFIG_CMD_DFU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_GO is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-- 
2.50.1

