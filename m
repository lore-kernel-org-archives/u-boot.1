Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8714C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 08:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C3E869F7;
	Mon, 12 Feb 2024 09:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lZ1lgTxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1B886D82; Mon, 12 Feb 2024 09:37:37 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209508573F
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 09:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8739A40590
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707727054;
 bh=yG1u/aQTs3uB9YBbzkVTowI458eNVEIUWdOtifOfs4s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lZ1lgTxHts3VYBIH4Og4LpFJJnWnhdZglYfCGhbRzym1FfPEqb7UGohgQGxhBWew6
 Ivfh248h2F+kCY4Odj+rTnRObpzdpjgyKXf03LHnhdtJr1PhvUnA0L0RhO/QIAPWWH
 LRYo5dcX9HwzJ0jI3HawOmu99vO2pjWGIlCq27wO/4tiSTfcmac4YyDF/6/O8c48Al
 cVwRHiCp/grUUWvRo02GmRBv2g+QTP0DrH92a1DKuKjrW5wD8nyeLO+XDv3s1ub7MC
 U1i5IciroOV/8tl/D8Av0nr95HNfGWhcIhPsbybRakW3w1LmvAOu7XtUZs2cP2wYQA
 qbnCLl5sv4lSw==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d0aafebedbso23812851fa.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 00:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707727054; x=1708331854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yG1u/aQTs3uB9YBbzkVTowI458eNVEIUWdOtifOfs4s=;
 b=rB27eC0h3gPeH1w/c09JATd98JT/T4RDF370V/cWXs1rvNPkNwmYWpoR3Golna+DWK
 ENgd9S7gjHC+YGsyvu3dAPILGDfWK8/Ao5RqzFDC9iVuVuiieEDgoQ02z6NdeF1Jttph
 dVo3qBXvVvyqRFjn/HgoaMEN+cmKMM4AKLd8jr7QT0ph2QZUsJFJpw1n4WH/fTPN7eeT
 TWKsNYo7AP6rmjGRW2VfsNqO3/ej/DIfS+JSLZkN/mVVwIZcZweRgSWDgXODi0NsWn3a
 ZgFxjFLmTqg6fReJ0M9x7u8fJhcvxDZTLLbM6RUPIwaOAcm9eX6DZgiB5rXHJfFS25qk
 V5yQ==
X-Gm-Message-State: AOJu0Yz2BjVJBO0q4xoBgZTIF9M7tjfRd2pMK7vGwKtRGQnLkzMTbfNT
 ZUbTzinBqvmn5Bd2Do6JmCUksZeaSRORBHrXTpURAcahmbss9OrJ2m0X8MdH5n/LiiYTsHk7hKN
 7wkrDWkFs6O4K9O7FX8M+bHkCkgZC/9t2UOJGIzhTmWjoibB2GkmspF5+z3Ta4/w/1e4=
X-Received: by 2002:a05:6512:313c:b0:511:751d:429c with SMTP id
 p28-20020a056512313c00b00511751d429cmr3679110lfd.8.1707727053987; 
 Mon, 12 Feb 2024 00:37:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+z2H+RH1JbAWXw7xIGTwdrhcT8MOVSYcNxNgKEd4v7eVZf6CpYx8w2dYJdsiuB+0ZdavSvA==
X-Received: by 2002:a05:6512:313c:b0:511:751d:429c with SMTP id
 p28-20020a056512313c00b00511751d429cmr3679104lfd.8.1707727053631; 
 Mon, 12 Feb 2024 00:37:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4uFML2MXnwYJp2LarACZUWEDnRdHtPayrWqDnE8ljv67YtewPqiI9ylHQyZBKYq8iWgxHYjhQwDQB1WtHlROz8xWRNEu9MnuPBTchi/J1EDI=
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b00410a843b57dsm4747073wmq.43.2024.02.12.00.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 00:37:33 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] sandbox: improve description of CONFIG_SANDBOX_CRASH_RESET
Date: Mon, 12 Feb 2024 09:37:30 +0100
Message-ID: <20240212083730.33956-1-heinrich.schuchardt@canonical.com>
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

Mentions that command line option --signal is needed to make use of this
configuration option.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/Kconfig | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 0ce77de2fcb..1c8353d6156 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -58,10 +58,15 @@ config SANDBOX_CRASH_RESET
 	bool "Reset on crash"
 	help
 	  If an illegal instruction or an illegal memory access occurs, the
-	  sandbox by default writes a crash dump and exits. If you set this
-	  flag, the sandbox is reset instead. This may be useful when running
-	  test suites like the UEFI self certification test which continue
-	  with the next test after a crash.
+	  sandbox exits with an error by default.
+
+	  If the u-boot binary is invoked with --signals (or -S), U-Boot will
+	  handle the signal writing a crash dump before exiting.
+
+	  If you additionally set the CONFIG_SANDBOX_CRASH_RESET flag, the
+	  sandbox is reset after writing the crash dump. This may be useful
+	  when running test suites like the UEFI self certification test which
+	  continue with the next test after a crash.
 
 config SANDBOX_BITS_PER_LONG
 	int
-- 
2.43.0

