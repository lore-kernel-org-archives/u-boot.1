Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE6C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F4180FBC;
	Tue, 25 Feb 2025 00:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TxhNPgBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C33C80F7B; Tue, 25 Feb 2025 00:07:03 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2EB80F12
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d2b3811513so16453835ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438419; x=1741043219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=TxhNPgBRpfxFV4yRNe6D+T+j622RsYa4pAf4HrtI7Qmft/qR94gOjKgOL2pAGtH2gp
 TWpUoKe++CKnLS19FoRcstDba7TxeGpGyTZs4u3nSMp/eZnG9z+3FwUMZNZdmCwOBg6y
 GZohqSiftSxRzYklTpw8oby79+jkVsfdOjFVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438419; x=1741043219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=PFE9KTUXlFJocov8B98y3MAhe2w3dj1BZfi41LqLSLYrwuCLy1ZC01a2OSqpyWsTvU
 BX+oo3nky1leOkGdyWxWtvuu+Gbh3JR+cgN2UZHKpEL3m2CxViQJOLXfe6q8b0L57jYH
 RuteWOwCEI4NhtZiu93aexw6jl/6g19P8E0a2gD2aX289iWeQq5BefbvObcQn1Oye0wG
 7KnvEzv010L74RdVj29GK1wNGawI5SannqK7NcE3ZqNtfyQvJv83JAW/rpxtusZszlG3
 jdJ5ibjEpsT/l5/fK4ctR6zAgFs1VWbk0CN5Jw422y4zuskSf4OaUl4qriDeR1jxaJha
 u9+g==
X-Gm-Message-State: AOJu0YyQ+tgDnGqiuBdIgM2hkE2hlLYUCOA7DidtvKG919VMs5Okn2Yt
 fXwSWSPuvCnhG2eeofKICvZ28uuWgVkllm71UfMFjre44R8yq/0YTmMWjlMYpr0swEgASqBgy/0
 =
X-Gm-Gg: ASbGncvmpSW7u1pYzT0nyaRXyQ2mDDjRWNgjuzjg1VKe7eKpjLF/jRds6Q+81cz5DUN
 FUihd2Fy5RhxkbtMOV0nOOMkDV0PqmU2mSoa4NEj5KlkYt+pWFbx+8eFnNOTfyV4bKJkWJRo/pW
 iv2g4DfN9+CxMe9aihgOqexHqt1/0QvQ3kEQwcRlSQwGclc3ZrNIup39aO7U/oujZgbIGh2D0BZ
 vGyNqzXrTFcIEcLZvBj+YICusshY5+wBrQ89NzKGn5S68Nn/Kr7iK6gUKkmpokylk/mN+eMbl/y
 Z8TM/5tJTXmt7R/+tNcgx7ysOLaFT5Ew/xXlFuevNosXt/XHwIfpp3rNouXbg7A=
X-Google-Smtp-Source: AGHT+IESzZuQ3xV1xK6PEf28VTHcQqfUJM+ii6gDMG9whtArFN0CXpZoszcI9vr/2XP8ZVa2fuTVFA==
X-Received: by 2002:a05:6e02:1066:b0:3d1:54ce:a8f9 with SMTP id
 e9e14a558f8ab-3d2c027290emr172917405ab.10.1740438418802; 
 Mon, 24 Feb 2025 15:06:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:06:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 02/44] x86: qemu: Switch to bochs display
Date: Mon, 24 Feb 2025 16:05:51 -0700
Message-ID: <20250224230640.2665206-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

The vesa display is widely used on hardware, but it is a bit of a pain
with QEMU. It requires executing option ROMs, which either doesn't work
with kvm, or is difficult to do in a kvm/QEMU-friendly way.

THe bochs display is probably better anyway, so switch to that. It works
fine with kvm as it doesn't need an option ROM.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

(no changes since v2)

Changes in v2:
- Redo commit message

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index af275e8ce8f..ff2a192ee7d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -83,9 +83,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 0b0e10c795f..ee5b150e062 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,9 +62,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

