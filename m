Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6192EE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA96A80655;
	Thu,  9 Jan 2025 16:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nAhEHcRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1121280601; Thu,  9 Jan 2025 16:02:56 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BCA806DB
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ab37d98dd4so2591235ab.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434971; x=1737039771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K+d4KHfw5VV9JfaLNbiQZPjs2k1k4yTnUZC4re1MIhY=;
 b=nAhEHcRJy6b9aDgGgCt6wmzKE3+sZmxklRLMhP8OfWplZfCzyVndEZOKkd6i163LFN
 Gi+q/fOt8CYJJhF982Bu78bea+GQcvA+U+GjSWC3mrjZZ67ZKFbozkBa/nUotmrTz1+n
 kbgE279fsOqvdvRhF8uGSKtTNi31B4KZhKK+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434971; x=1737039771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K+d4KHfw5VV9JfaLNbiQZPjs2k1k4yTnUZC4re1MIhY=;
 b=WsBg1SdtrSC1IOWOdDksh+CaA2qPfQm+im1rjNGz3VuUpC63iSbifgf9vh9jw6QXKq
 qoSckCP5iGkCE32VGqATIJ96XcGNCgqmpmJkUUKehbMWzn8WJWy4q2qaHPsLowpYYWky
 2p8fMFMrNJ4Y1Ij290Xd+ni0nhXdiEE0eNBnJKpGrPQCRwXBU8+Vokuq0yc22404pbIS
 ArDTP33VOA496wPldQT2ZphJc1keufvd/07+XCH6HKUNUvKTmdmZxUEHurP9y8isZccu
 XlY0Cl+UPbXpFM/LWOYusehCmyD65Y44/eyx8/wN5obg/og6PRHn2azCvRVnF+rloPn+
 9zww==
X-Gm-Message-State: AOJu0YyZvD0ebKqC84HVPE8rdLTCoDrsRH2aj2OSYMB6IBP+SO1d9GWJ
 MYx2NzLxdfiOaX3Q6tQkjJ00T7LI3ravdJco/QXmBGcLytG/j6aOq2wG9jz6JEs7uEYhGTDvHLA
 =
X-Gm-Gg: ASbGncsMpV+aer19UUG5DJlTqlAzw1JgyP/fhP8xbthrhwaUiDkEv9zTgaeL/wWZaSd
 g9dp6ONObOMrFqiVXsmYKbLmyz0advxSjqZwS323zx+fwFae9IGgHptcPRr9M/vj7LnHdSyEFYk
 J9smsu5sXN6eY80X7OV+Ofs5jnnQ9sSq7FO8nUKeLXQh6Lk4FreWrQlzENTFfDJPwZF16jqNp8T
 TSWgl9Q8fZ5cChrgfNmYk8rvZglaqFwoD0tRNNuzpF6q3u/Bv/hyDiijC/a51WsOOnKXLB+R+3f
 cey9I7LYwKvWvYUNcg==
X-Google-Smtp-Source: AGHT+IF9a+rMO0a5Sk9y43Q4ZnsosBzx5AQ8veGnt9KJwjUiGSP5/EK945XESf8c9QNuHvoYyXI2rQ==
X-Received: by 2002:a05:6e02:1c8e:b0:3ce:3016:fbc3 with SMTP id
 e9e14a558f8ab-3ce3a8882c6mr51719865ab.14.1736434971226; 
 Thu, 09 Jan 2025 07:02:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:02:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 0/7] efi: Start to chip away at the EFI workaround
Date: Thu,  9 Jan 2025 08:02:37 -0700
Message-Id: <20250109150244.141173-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

At present there is a function, efi_set_bootdev(), which is used in
various places to tell the EFI loader which device a file came from.

With bootstd, this information is available in the bootflow.

This little series provides a way for bootstd to provide the bootflow to
the EFI loader, so that it is able to select the correct paths.

For now only the EFI bootmeth is updated.

Changes in v4:
- Update calculate_paths() comment
- Mention the NETDEVICES problem

Changes in v3:
- Make calculate_paths() static and add a comment
- Rename efi_binary_run_() to _efi_binary_run()
- Add new patch to support PXE booting
- Rebase on Tom's tree (i.e. without the pointers/addresses series)
  https://patchwork.ozlabs.org/project/uboot/list/?series=436241

Changes in v2:
- Adjust argument ordering for efi_run_image()
- Use efi_loader tag instead of efi
- Drop unnecessary path removal
- Fix 'require' typo
- Move calculation of dev-name into a separate function

Simon Glass (7):
  efi_loader: Refactor device and image paths into a function
  efi_loader: Make efi_run_image() static
  efi_loader: Update efi_run_image() to accept image and device path
  efi_loader: Add a version of efi_binary_run() with more parameters
  efi_loader: Move the fallback code from efi_run_image()
  efi_loader: Pass in the required parameters from EFI bootmeth
  bootmeth_efi: Support PXE booting

 boot/bootmeth_efi.c          |  64 +-------
 include/efi_loader.h         |  10 ++
 lib/efi_loader/efi_bootbin.c | 276 ++++++++++++++++++++++++++---------
 3 files changed, 218 insertions(+), 132 deletions(-)

-- 
2.34.1

