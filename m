Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A68BD4978E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF638916D;
	Mon,  2 Dec 2024 01:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S7bSz8A1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A0F893C4; Mon,  2 Dec 2024 01:13:14 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852BD89137
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2964645d2b7so2556060fac.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098391; x=1733703191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36RhsYHHiPlnpfS4pJhuv0VRX657D+kdN/dIQ6IqTvs=;
 b=S7bSz8A1ltdTY4ZDjxFczpi9UDqMSD+Dlm5oujdagz+zOIh3L3TCuYcVu8T75AORyg
 PWeXPHIwvT5mvZrz4xkeLgvvMHXzFpr0lyaGP9eZ+XaUW2Nh+DMxpoYPk+Qnn5Bm+VPB
 Dw+ejEPoYYxNYQ3UlnWJIWmJroTEa2mH34VVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098391; x=1733703191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36RhsYHHiPlnpfS4pJhuv0VRX657D+kdN/dIQ6IqTvs=;
 b=OypzI49g9poZ2YvFkN8N4618o1zz8tcRrke475s6ThACqSZZpHX+XpsHHaaqXu0/XS
 wOLJeWX5qM1C6vWcWH3AK6+r/OeBF5WrMYDAukKSQurE0He76YntCRcew4A6fgtXi0/O
 9ZceQfJlJontA+URj5M7iPj/19oFKteu/SqQ/WizlG8adxbGWI7O1Gd9SYEKxuZQ2SGZ
 /4La/lpPjdJYRe6eXgrSI+i8w6CK5TjIsz7U3GGPF84Nf718ceucLrlesAWGof879XjI
 Lu1a0XCaFXJJ9Udpp5xJzFSWtn8PiFqaY3mTL1hpKiMOUl9A3jumnUefrl3+/tpHWoRJ
 cPIg==
X-Gm-Message-State: AOJu0YzjdHdfDJSV6WxWIxHJ6NAF/RzuKDl82V7TIAbO7zNpp4vpLyEx
 G9s9cT9CE3BfbgrLE7H+LMohpDlr6JO3RfOgziv+ESFv3K1O/hNYWhqALM8exR24DKmTurwGAMo
 =
X-Gm-Gg: ASbGnctNTz0LyGtQqn4XancfKWJRfeSlH5gZ+DRzKk1sRjSpHAbg2SirNohsGFngHTr
 qzFtlfdNWhTJWUhzUd0YxttNPyCz8Hh//uq54g4uFnX1aR6NWklFGqfX35s/RXSC1G84k4rD9ME
 ltjjHD4CVkNr2wBkZJIi9kgbCj++mQytgiYhdKm0cpjavghseM+Qgdewb7j95bNREpxui3xhdZg
 qUtaPBYlfsIr+6ig/UudoW6M+f2nZYAjrUWk/Q+Bv0kJQ==
X-Google-Smtp-Source: AGHT+IHOHo1eJG3pHN/eVrEFM4Bj4mh7+zPwYPGmOkxDUHharlNpwqFGLSDpptXgYyKp5tJh0uw24w==
X-Received: by 2002:a05:6871:582c:b0:29e:4ba5:4ddc with SMTP id
 586e51a60fabf-29e4ba55b12mr3189233fac.24.1733098390756; 
 Sun, 01 Dec 2024 16:13:10 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:13:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 7/7] efi_loader: Add documentation for the EFI log
Date: Sun,  1 Dec 2024 17:12:43 -0700
Message-Id: <20241202001243.1283274-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
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

Add a note in the documentation about this feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase on efil series (memory address/pointers)

 doc/develop/uefi/uefi.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 48d6110b2ad..23d7dfc166d 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -1004,6 +1004,28 @@ This driver is only available if U-Boot is configured with::
     CONFIG_BLK=y
     CONFIG_PARTITIONS=y
 
+Logging
+-------
+
+The EFI subsystem supports logging of boot-services calls to a memory area. The
+log can then be shown using the ``efidebug log`` command. Note that only a few
+calls are logged at present.
+
+To enable this feature::
+
+    CONFIG_EFI_LOG=y
+    CONFIG_EFI_LOG_SIZE=0x4000
+    CONFIG_BLOBLIST_SIZE_RELOC=0x5000
+
+The bloblist size must be set to larger than the EFI size. For now the log size
+is fixed at the start.
+
+Logging is performed within the internal U-Boot functions, not at the
+boot-services interface. This makes it possible to log EFI calls made by U-Boot
+itself, such as memory allocations.
+
+See the :doc:`/usage/cmd/efidebug` (*log* subcommand) for more information.
+
 Miscellaneous
 -------------
 
-- 
2.34.1

