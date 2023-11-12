Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E76BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE8886DA2;
	Sun, 12 Nov 2023 16:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ApnRCfDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BE986F89; Sun, 12 Nov 2023 16:58:25 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548C886CB1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a683bd610dso133762739f.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699804699; x=1700409499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YBqsnwddSiSnTB4tut24423HrfW6LbgVk8NIGhJRqHY=;
 b=ApnRCfDgE7zq04HNNk6HahJn4rZI4PiUCHnAjg7Qr1eB4ObmAnftJarGlh5PYmT+Wi
 mMqIkhYR62K05gPQ9YPs0T6hQ69GfmS51FgSFhONJvHNpKI7fxjkNLDd5c5FLrvGklUe
 eTK65TP8uFMU2/I3XIM9t9EcMFn96AkkMd9Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699804699; x=1700409499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YBqsnwddSiSnTB4tut24423HrfW6LbgVk8NIGhJRqHY=;
 b=HnwNb0MwwvDlvYKBvRBtLO/LvofBsVfaQGcHihPoO0mFEgQfpJ7HGYyEAJl58WZTT5
 cx+2q5u39yi9BrAWqoQb3j6aZ2LB41flqlAZYj3UmoZrU3B8wQEgfn+xT+7OGvEbI1Q7
 JalSzxDwztkGp3pPaYehbFYgFeu8nLgF6y2poMOCdGRO0auZ6fENIZ/nrruefRjkYi5W
 40ieslEwDqz1XEcky9xezItHcaoOkL0pWVEWxpX5lrkk2AI7BxakolsUgXEPOGJWVWUs
 D23nAEmNazywnnVCfB3qMmEiJtG8YSYGxVu/7OYO9pwRXcm9kVOPWF1gckisC6dW2rpb
 C2AQ==
X-Gm-Message-State: AOJu0YwCJXSmmJT7E2jY5lu0Qv5lMTcxq6FsKXNKp7FxIHsGqr7bvImI
 lpd9MZLAc2ta6lrLi8Mz/KtmyG8N/SHZQISEt+IFGA==
X-Google-Smtp-Source: AGHT+IGlYacxBVw2T7ieAq8O7MjexMAtC58S07Q89sUKkP+Kf9s5rxdHFXiD0LXSEWEIoYYF5fYDPg==
X-Received: by 2002:a5d:9a98:0:b0:7a9:b1c9:665a with SMTP id
 c24-20020a5d9a98000000b007a9b1c9665amr5253531iom.6.1699804699497; 
 Sun, 12 Nov 2023 07:58:19 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056638348b00b0042b37dda71asm1065843jal.136.2023.11.12.07.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:58:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 0/4] efi: Minor improvements for the EFI app
Date: Sun, 12 Nov 2023 08:58:01 -0700
Message-ID: <20231112155808.135585-1-sjg@chromium.org>
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


Simon Glass (4):
  acpi: Use __packed with struct acpi_xsdt
  efi: Collect the ACPI tables in the app
  efi: Correct display of table GUIDs
  efi: Avoid using dm_scan_other()

 cmd/efi_common.c                |  4 +---
 configs/efi-x86_app64_defconfig |  1 +
 include/acpi/acpi_table.h       |  2 +-
 lib/efi/efi_app.c               | 29 +++++++++++++++++++++++------
 4 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

