Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A6109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1F883DA7;
	Wed, 25 Mar 2026 20:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T/3XuOOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226E083DA7; Wed, 25 Mar 2026 20:00:24 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8DE838BB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4be94eeacso107765a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465220; x=1775070020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EKa6DsIH6+k6xlcLOc9myq2sPxuUkr+jIfr8LXHyhKQ=;
 b=T/3XuOOsmykoYpuAi2ioU2q8hfAdwRgC4wqw60apurnSrkwbaeUTvpmaLIFba7tnt+
 FHjhzN0Bu1jA2PIEvAsUwnHmDxTrxPOvGxUodtSobvbUHO2/MErHEGfBv6SrbEBXbEUY
 BusYk40ciMZdNJ8HFJ2tRylHNlsBorms2luIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465220; x=1775070020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EKa6DsIH6+k6xlcLOc9myq2sPxuUkr+jIfr8LXHyhKQ=;
 b=APv9eBCGKuEPu6zQwRTAMZWLAJNboStF4A1k8UkR9R5jFLeN2z1J7Nx4AGJnzt67Nn
 +byv3n5h860/mNj5ujT8kcKWsn4ilY6PShfvK8aZEXUrJwxDIrq/UX0DgQN7PTfGvc4S
 /hzqhi7QrhnqWV/lCd6MOlfl/JPIsJzgZF02of/BZxur2uz8fuNgZOtkn9pa8ub0+EkS
 n7VW0Nlhg+U0EKEk0bzsLEB5TathWbCbzDKpNB98+9A0jLpO3YOVNY7UdSZnJYP8Y6Oj
 6LsbcM1mdBcOan4mr6wX5BFxkgPETr5wweSllNm3Xy+cwsdItw+wcp8IdapV+2ZA1qUw
 A5Pw==
X-Gm-Message-State: AOJu0YzOV2LFVpimqkLb/Y86hOt4h5gb8ydzu6ayBEbAB6P5JJ2GCOyS
 PMdO+TJP+j+U6Z9OXHEeII7kvJWAGkycai5Sn65M8/qPuyh7HU+/od6Jim9Mpe6E7+0OekosiDk
 Kz1/NMhE=
X-Gm-Gg: ATEYQzwM35RzFPlgK+roC8a2cNbouiZDkSWv7UbkWX2M83b3y+4CT5s4Ov640ehC/tb
 X60O4NOAo8POwYnTAbWjr65GNZKEMbXIE+7y+MfC6im38q3LMoWXBKrgioGJSM7wjmfjMVJWGyO
 57F7wXa+Q/t2xuriz1j47A3TU876e1hevg0Ow5xmV1giWPPEu5+3ZjXzgsdEAU3wN53irTJirF2
 8DYwv/oXfbq9N9QOA/ZDvQMKW3sQwCCtFr7qh2Hbr4YvGKf1Ux83ErdWB5i12tsjzUh8CEw8UAr
 xEfj7U5Gh6vAlG4M2knpN8imhBpiEG0ep3WKjtlrvPPGpmkk47bMNSrtVGga/2bH/6BMLiRXB7+
 9SQr8w6OBQgyuqEbl45Ud21dpYN76LFZ7T+DIsKyudNey9PMOarPS47nDx+7G/+na7cFUCs+vbj
 xf3Fd62VcE4IXQ9BTLDizmXFtyR7Lvr58xfMidwB3s/XyBqfDrpsYNW4VFtzLUT3lWRlwb/hbfH
 ie1TNIF6FPZqFBQk1XGCiJAGT5CEXc/s7ZC1SkInuog+KQmqjI=
X-Received: by 2002:a05:6830:81f6:b0:7d9:7ea8:7a4f with SMTP id
 46e09a7af769-7d9d677f5a4mr2525000a34.16.1774465220681; 
 Wed, 25 Mar 2026 12:00:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e723aef6sm411974a34.20.2026.03.25.12.00.19
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] arm: Remove redundant "xPL_SYS_MALLOC_F default y" entries
Date: Wed, 25 Mar 2026 13:00:19 -0600
Message-ID: <20260325190019.3428500-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The symbol SPL_SYS_MALLOC_F defaults to y when visible and
TPL_SYS_MALLOC_F defaults to y when visible and SPL_SYS_MALLOC_F is
enabled. Remove the places from Kconfig files that had unneccsary
"default y" for these options.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rockchip/rv1126/Kconfig | 3 ---
 arch/arm/mach-snapdragon/Kconfig      | 3 ---
 arch/arm/mach-socfpga/Kconfig         | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index 330b7df2312e..43eeaa9c4493 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -49,9 +49,6 @@ config TPL_LDSCRIPT
 config TPL_STACK
         default 0xff718000
 
-config TPL_SYS_MALLOC_F
-	default y
-
 config TPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fcef..d3de8693b5a8 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -17,9 +17,6 @@ config SYS_MALLOC_LEN
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
-config SPL_SYS_MALLOC_F
-	default y
-
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index aec0fb7b1c8e..fb98b6474425 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -31,9 +31,6 @@ config SPL_SIZE_LIMIT_PROVIDE_STACK
 config SPL_STACK_R_ADDR
 	default 0x00800000 if ARCH_SOCFPGA_GEN5
 
-config SPL_SYS_MALLOC_F
-	default y if ARCH_SOCFPGA_GEN5
-
 config SPL_SYS_MALLOC_F_LEN
 	default 0x800 if ARCH_SOCFPGA_GEN5
 
-- 
2.43.0

