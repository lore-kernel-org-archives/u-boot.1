Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1A0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5765086940;
	Sun, 12 Nov 2023 21:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hv1LxhXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260E887103; Sun, 12 Nov 2023 21:55:25 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C96386903
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a66ff282baso94905539f.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699822520; x=1700427320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mU7nk+W3X9qQdY7/brpjYW/DSHoXXZ/e7rf07wzhgas=;
 b=Hv1LxhXk1sBhogfd0SSrmXlHeq301s9pxVCYOuyVwaGqPLLaBRFgUXYYecmrMUrhVq
 2cmzC2e1Z0wCfDQWKK3ivKNpb5heFyvSk6pEhYHIcqwOXr6KQSwkOeOrLAs6y4Unpkwt
 mN3QvgiwiXuqZ9pYHCpigin+GxLwinISyJUYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699822520; x=1700427320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mU7nk+W3X9qQdY7/brpjYW/DSHoXXZ/e7rf07wzhgas=;
 b=JelOQgIgmTitUsIl+ugT8Yhi1RnOuUVKDvXOkutTgpQmznUyMsG5D5JS6IyjVSLk7q
 s2C3IdvLNGJDuM42sPZgzG3urXRh/zczOFLf9Us2Qm0A4zZvAMX2fxUuShekS4yTSbk2
 JjlZ8ViBfc7mwDFR3p/GWsYncWbERUQk7/IfTpJWLx9MSG5I9YJ9NRds+8jnpsslXQZa
 DafahyUUj9awWXL31muWRIr4riL3VtvdnSZkGHtD5ty5e8X5rLWNPvGTdpYy9UncLSbw
 CMnPsvMCiGrJwut6QptQHJFd8HkJSYf0nLVAdtodXxQdr0QwgOKn1uVL2N+q22HdPP2Q
 CCcg==
X-Gm-Message-State: AOJu0YwWAX69WDMot2BjuCA6zcYPCBMI1/jjGC2l4oPb64lcwkRQ/cVG
 BTtTniTfb2rzW+tzVOCkXgARwiY/C/PA91P7eHBaIw==
X-Google-Smtp-Source: AGHT+IE3mAu9nVW1zkki10ItPLpuf4ixmClNcaLGsyDy5Tuq9Fsezmuqc+lkvItkNG77CC41GiYIJg==
X-Received: by 2002:a5e:aa1a:0:b0:79f:88af:500c with SMTP id
 s26-20020a5eaa1a000000b0079f88af500cmr4550697ioe.4.1699822519803; 
 Sun, 12 Nov 2023 12:55:19 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a056602210c00b007b01c6a57d5sm1079641iox.15.2023.11.12.12.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:55:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 0/3] efi: Minor improvements for the EFI app
Date: Sun, 12 Nov 2023 13:55:08 -0700
Message-ID: <20231112205516.183410-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

This series collects a few fixes and improvements useful when booting
U-Boot as an EFI app.

Changes in v2:
- Drop duplicate acpi_xsdt patch
- Put the board_early_init_r code into board/

Simon Glass (3):
  efi: Collect the ACPI tables in the app
  efi: Correct display of table GUIDs
  efi: Avoid using dm_scan_other()

 board/efi/efi-x86_app/Makefile  |   5 +
 board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++++++
 cmd/efi_common.c                |   4 +-
 configs/efi-x86_app64_defconfig |   1 +
 lib/efi/efi_app.c               | 199 +++----------------------------
 5 files changed, 227 insertions(+), 187 deletions(-)
 create mode 100644 board/efi/efi-x86_app/Makefile
 create mode 100644 board/efi/efi-x86_app/efi_app.c

-- 
2.42.0.869.gea05f2083d-goog

