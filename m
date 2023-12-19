Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA13C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C460E86FF4;
	Tue, 19 Dec 2023 15:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F1XRnb8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA4A87282; Tue, 19 Dec 2023 15:27:39 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF70186FF4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35fb38747c7so8195775ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702996055; x=1703600855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aA9bBg/iQen62Zam6H5geFkp5aniGmGOK2O7fP51Wbw=;
 b=F1XRnb8Zu5JgPZXTr/unVsd6G7uktyiP6NZuqoJEm6RE2OF5rwFXm7lNPEAODsv+EW
 7OmPNry5C5vjT0YJcLx4RJycCwS5egM3btMooEmoWDHbO3/gxyECBusxGdiMIEedHTRp
 2SoZx+Ms8E1vpPlbvbbbCooYYkbwXk3xHZx6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702996055; x=1703600855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aA9bBg/iQen62Zam6H5geFkp5aniGmGOK2O7fP51Wbw=;
 b=NeJ9v7hu2BBobHx/u9C1VaYy824dbis6G0VqyM3IgvkRRKK+LvFbvHHhMNwjY7fC3u
 CWLh39DD21/lQ9EX5C/bXiFFziML0hnG/GMT7A+lSz/aPqEV3Ymi5BY3gmPgfbtLdBCk
 itzncAONvsJQ+w2FbmQZUNKp+2mxQ+FRBqvjAy7COk3K/mgMO+BA5Mjdc8XDJnBB/Z71
 Sg9coZoV3Ya/uXvPUoROGW66HO03Xt76wjdPDUUNnp6naiRDFFZops6+0tx4O8VtTzHu
 wtqYODI7nPKTWAF51idqALpw5axaM+/7qDluMigpLhu34NQZ0OOP78M602lKrRaDB02N
 +d8g==
X-Gm-Message-State: AOJu0Yyq/qqFc7E4a+SnoirCQRtGxO+yuXD6TrcN7xuVvXeGXEKq0D5Q
 NGBP0v+iZ+Fm3IV22c8nACebC12lNuZqzxnij6DUIA==
X-Google-Smtp-Source: AGHT+IHRXAwQMUkv1hprjoFsNDockVbqmazCcxnGiQwnYaTixgkkxwm9mr5holBWmmxjUgnpiiVhqw==
X-Received: by 2002:a05:6e02:1609:b0:35c:8f50:acd3 with SMTP id
 t9-20020a056e02160900b0035c8f50acd3mr31127947ilu.18.1702996055446; 
 Tue, 19 Dec 2023 06:27:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a92db52000000b0035fb79100cesm803195ilq.59.2023.12.19.06.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:27:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 0/1] efi: Minor improvements for the EFI app
Date: Tue, 19 Dec 2023 07:27:18 -0700
Message-ID: <20231219142731.2389788-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

Changes in v4:
- Create a new file inside lib/efi instead of board/

Changes in v2:
- Drop duplicate acpi_xsdt patch
- Put the board_early_init_r code into board/

Simon Glass (1):
  efi: Avoid using dm_scan_other()

 configs/efi-x86_app64_defconfig |   1 +
 lib/efi/Makefile                |   2 +-
 lib/efi/efi_app.c               | 187 -----------------------------
 lib/efi/efi_app_init.c          | 205 ++++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 188 deletions(-)
 create mode 100644 lib/efi/efi_app_init.c

-- 
2.43.0.472.g3155946c3a-goog

