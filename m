Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764831098787
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2A783CF3;
	Fri, 20 Mar 2026 15:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gWi8zY2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A5C83CF5; Fri, 20 Mar 2026 15:13:15 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15DE783CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4648447e29bso214940b6e.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774015992; x=1774620792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ckPL+cB0nqQZORWeSM+yG7mfoApFI2kETR938X8ks20=;
 b=gWi8zY2emfvmtVHvid+SF8AQxSVCb3cEDrW7CFhFeXHz3gdt//Xa6l+TGk5u0DQ+cJ
 fsfBI82lz+iSGeEM2hErCaIobwZXC2YCRZKOmJMcnu+NN4T31Rt8ab5kbYP+N2LR6Pum
 SVScYYb5Y08e4e0fDIBXH3MGXpRu3I/2Xri/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774015992; x=1774620792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ckPL+cB0nqQZORWeSM+yG7mfoApFI2kETR938X8ks20=;
 b=EdD3B1dy4B6kvCPn4hm5Wq4xi8aung4w6Bfgr61w1r9BVuYOy1lvUwpWI2i6q4rYPT
 66DxMImQ61whqRlaLPRz59B0fYmkNibzVGkNXp6kk9OMmfUAXNHTZt5CeuYlSr7fv77r
 fRl5OPO5yM2DmjD6MXe3EQlyH3Ie9No0H7CISjVtr2c4EMbbeLBgdGPHdTBi7RsDnDzQ
 py1T3U5QYRQ4h1Q+bY2L/8wYuGQkDhhIXLLHEYF48LLwPutwVCHuMVH3yCdy31gAp8yk
 LcufUloqJ2gtr+87T+AbX33N08FNIbn4H59xQXK9NUb1XjYRMolJc7pdj/EUq1fHsLXW
 IKEQ==
X-Gm-Message-State: AOJu0YxX5gp4XM7/Dn9d0a2fiVi3ivSrrPsj4CNnNPnNWyQ39w8jm1Xg
 Lv1sezTChaLN0ijWUL3biRfX4H1QVQSL3L4nt5CMkpjH7SnLEaHEzNHnGpZJCDfWDgEtQHQpWWe
 V936EpAw=
X-Gm-Gg: ATEYQzwMtzEiRj8/IrrbXyx6BWOBX+srCCamjvu6dfme5Cv1PZBVz0Zj3JkHR419gV8
 mFp3+2d8cYkbaxP20BIXM0jA/KcyasVDYIu9hvmYgkDOJeYZMh2de0oz+iHmQwupb9Z8iDWYJH4
 fxM2i03YiPbwldGFHfQBdjUFavhhdMmq6/f5/LIY/b2oUgvDuzOxB9d1lAsEsnL2I8sZqOoNNPB
 AKKlmvGoWe3eD4V/npCK56Rrzo4W81P/Wov5YZMp1ytSZeL8TXQTZCf+ev3mWO5kx3euHgxVytB
 9hwPcYsnq1UC6c3TD8iz67JXhilkhflQ5Tet3zQi3Zgqaxn+weMszl/sJfDClWQbe31TFIsC24B
 qC0WsuwmT1XKPHSZP2dtOgfH2GqGqtzkYWAhsoVmTICZFTucqrAK8ka7KxcdL7BPhkqOrZjoKpg
 war45695abYljkOK+h8qBhjAiTPp8EiTX9V2YmFTypvEnQ0SSVI5V8efYh2AUSqgEIrT7Nuk3Xe
 U0EpenbX8uGB/+rVipDJpLeOu37xyGCUaspxPV3en5Ng9jD/Rw=
X-Received: by 2002:a05:6808:1390:b0:467:25da:d44a with SMTP id
 5614622812f47-467e5fd8790mr1685837b6e.54.1774015991655; 
 Fri, 20 Mar 2026 07:13:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7efa5e2sm1372113b6e.14.2026.03.20.07.13.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:13:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2] sandbox: Add missing select's to the architecture symbol
Date: Fri, 20 Mar 2026 08:13:09 -0600
Message-ID: <20260320141309.3541047-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317012426.4162458-1-trini@konsulko.com>
References: <20260317012426.4162458-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issues around a number of
symbols that we select without making sure to also select their
prerequisite symbols. Add these missing symbols.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Add even more missing symbols
---
 arch/Kconfig | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9c48510a0646..4c4c070df87b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -190,33 +190,47 @@ config SANDBOX
 	select HAVE_SETJMP
 	select HAVE_INITJMP
 	select ARCH_SUPPORTS_LTO
+	select AXI
 	select BOARD_LATE_INIT
 	select BZIP2
 	select CMD_POWEROFF if CMDLINE
 	select DM
 	select DM_EVENT
 	select DM_FUZZING_ENGINE
-	select DM_GPIO if GPIO
+	select DM_GPIO
 	select DM_I2C
 	select DM_KEYBOARD
+	select DM_MAILBOX
+	select DM_RESET
 	select DM_SERIAL
 	select DM_SPI
 	select DM_SPI_FLASH
+	select GPIO
 	select GZIP_COMPRESSED
+	select I2C
 	select LZO
 	select MMC
 	select MTD
 	select OF_BOARD_SETUP
+	select OF_CONTROL
 	select PCI_ENDPOINT
+	select SANDBOX_RESET
 	select SPI
+	select SERIAL
 	select SUPPORT_OF_CONTROL
 	select SUPPORT_BIG_ENDIAN
 	select SUPPORT_LITTLE_ENDIAN
+	select SYSRESET
+	select SYSRESET_CMD_RESET
 	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
 	select SUPPORT_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
+	select TIMER
+	select SPL_TIMER if SPL
+	select TPL_TIMER if TPL
+	select VPL_TIMER if VPL
 	imply BITREVERSE
 	select BLOBLIST
 	imply LTO
-- 
2.43.0

