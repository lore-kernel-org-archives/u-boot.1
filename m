Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60786C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17C98076E;
	Thu, 23 Jan 2025 23:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gpw1qbj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4A3806DC; Thu, 23 Jan 2025 23:07:38 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BA780087
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5fa2685c5c0so617967eaf.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737670053; x=1738274853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JOFogTAFrt1VyD3x0NoYEjIS1S12YG/Pp9Ic1zjwwJM=;
 b=gpw1qbj1pNgR90NHvWpoIi3zeI6RV+WG6G6CbiKVaiRFltA3J4l2FdCdtDv2jvGV42
 qW9wOTCotBbUv82RH+JJK48Tttmaw/JrkKi8KAI+nUIyTEP749IDRbZ7y5fsB6JV6i3v
 GDECvbPMRRqJrPY0toPlBzgBtTwtrmj5TKkfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670053; x=1738274853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOFogTAFrt1VyD3x0NoYEjIS1S12YG/Pp9Ic1zjwwJM=;
 b=TD+1ejZH+KPOiQs0PFLP0nMWLK1WzXLrjJ6dsarep6dYx+xW6/fyrrX4/Ka1owsKlH
 DEZbSE0cAGndVDynjLopc0K/keUHolcXI9PB9vkQMDcyaBiffWDJT/OTv8cIbDPjlo9D
 ZXCBNvA8wj80iHv6eR3jhmo9ag42ssZN4kEBP/Kq8kDvfi43+r9CZf3/OPogR0CjqGII
 TrwBLTQIkAk4PPo3wG3YP4wV5rc6Zhaw3TGONQ7lQU4Nw9vQ63rAOZdupS7B3a2FNnfp
 fJl2J6NP0KoshV3SygRjbYDM9+NqiLZ3w8Oqqdgy0F1qU9qEk0b3fBnZJ5bcDInCgbQ7
 rnKQ==
X-Gm-Message-State: AOJu0Yzz9C9J52L+9pJrWSPASI+v9PTULabOA3hd/plE3dzucMuObI0i
 LJ41vMwy2YSTFdyENkhIVugpDjYduehQ431QnItrSDUgzAUjJoemsGz92v8EyplQqqqCfF7O6fk
 =
X-Gm-Gg: ASbGncuYESox0VQk0TrpwaADxpn8cnqjv80Ht+wDNWl6iB9mRN9FoC2BQQPWjt9ZsBt
 4h4oHjN7rR4HmYRdZf95NIVNf07OWRVeUWNe1DsDpgV9STHhw4pMHU/3/rzBRn0SmUWRnj/Xh8/
 xSV+35vW+5QuBFA1PuIj7MRiaHTVPWtjjhQC/IadeC030pdf1TAamz9iJmiyli1onta4q4HzCJB
 EPaLiL+OH451fPxfwIwHE2lHm38sy08aFNldsN2lLYY2qdhmTURN1Rb9djFQIYQFyP0o2Moyny/
 Ow1xYrLERP+YBNomPss4b1XPEFao4a3lJBbadupvCw==
X-Google-Smtp-Source: AGHT+IGmz83WIWUvqUauCJy5B+L8fLO39+z2AwbfZcGyFl256Q0UIJfvIXRnGW23cVFtXKYQwqUpcA==
X-Received: by 2002:a05:6820:3097:b0:5fa:73ed:de8 with SMTP id
 006d021491bc7-5fa73ed1293mr6358415eaf.6.1737670053401; 
 Thu, 23 Jan 2025 14:07:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-724ecda47bbsm143136a34.2.2025.01.23.14.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 14:07:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 0/5] efi: Start to chip away at the EFI workaround
Date: Thu, 23 Jan 2025 15:07:19 -0700
Message-ID: <20250123220726.412396-1-sjg@chromium.org>
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

At present there is a function, efi_set_bootdev(), which is used in
various places to tell the EFI loader which device a file came from.

With bootstd, this information is available in the bootflow.

This little series provides a way for bootstd to provide the bootflow to
the EFI loader, so that it is able to select the correct paths.

For now only the EFI bootmeth is updated.

Changes in v5:
- Rename the parameters
- Drop the image->image_ptr rename
- Rename _efi_binary_run() to efi_binary_run_dp()
- Rebase on earlier changes
- Rebase on earlier change

Changes in v3:
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

Simon Glass (5):
  efi_loader: Update efi_run_image() to accept image and device path
  efi_loader: Add a version of efi_binary_run() with more parameters
  efi_loader: Move the fallback code from efi_run_image()
  efi_loader: Pass in the required parameters from EFI bootmeth
  bootmeth_efi: Support PXE booting

 boot/bootmeth_efi.c          |  64 +-----------
 include/efi_loader.h         |  10 ++
 lib/efi_loader/efi_bootbin.c | 189 +++++++++++++++++++++++++++--------
 3 files changed, 160 insertions(+), 103 deletions(-)

-- 
2.43.0

