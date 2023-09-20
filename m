Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2BFCE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E98686CBC;
	Wed, 20 Sep 2023 05:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AnZfrKc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662DE86CAD; Wed, 20 Sep 2023 05:00:50 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EEC86BF7
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fcc860911so12982375ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178847; x=1695783647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwRCm87ZwaGswPGVhohl6DiWkGkG+nVckgolaU4ZKM4=;
 b=AnZfrKc1E0H24abKeS/bmYyTZz1cPdAihfUNvw4QogNO0PYVNextCbE/oSTJFbXw6s
 kVV4yWdBP/o6gcBB2U6NrM0IswkTiSVqpxZ/IRbQ6z+HUBzbrvCoX1dc0fQTTD9vGGUE
 LY8wN3pzGWk1yzU8UJ0WhR2n1GtN7apxrPyNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178847; x=1695783647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwRCm87ZwaGswPGVhohl6DiWkGkG+nVckgolaU4ZKM4=;
 b=W9ir3YgXwt1dzyB/ftsDOT1tZ3Jo6S7FGPIulxE75P3r1tD2Hj38in1oTOdfuAPtdn
 F8O88Vq+uve/kEcNiHjEzRCzi5cLZZfgsZKEOSOyb1eYhEb/szZLT18PzxlS8HrTkcxt
 cs/iZvRYeuoS108MsLtAsnDKhf/GmSXfwZAB+TQIvuCYztr/0aY2DbPBDvqtIVPEAEQF
 DtGQDAvv1M++8n+LjmRRQLFrINGQftm8dTiVYkZTVnbege2jftsEQ/yDvVLTof+LhbZQ
 H4kt8AgjRlu2a6u8+SyrxDaL60xlpajUPEiBboBFlD4LfU8Q9Zfrv1107ZdkM8Vi5P6j
 nibQ==
X-Gm-Message-State: AOJu0YzDMQWWKm0BQRTtDUQxgoFSJbftFQbTwjhLDqD2H/FLoD5lZD0w
 X1Ok9l89gjk55H3TeFEHs3d9VQ/YyDgV0dWamWQ=
X-Google-Smtp-Source: AGHT+IEBvC1p7nAD9hDGMm49dMyXFvbtRXwMfjswGZ39pp4Gis63cB5DPjM6PeLMPkNnuiRyAyKVjg==
X-Received: by 2002:a05:6e02:d0d:b0:34b:aebd:a512 with SMTP id
 g13-20020a056e020d0d00b0034baebda512mr1421532ilj.14.1695178846982; 
 Tue, 19 Sep 2023 20:00:46 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 18/20] x86: doc: Update summaries and add links
Date: Tue, 19 Sep 2023 21:00:19 -0600
Message-ID: <20230920030027.1385833-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

Refresh the summary information so it is more up-to-date. Add links to
the coreboot and slimbootloader docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/arch/x86/x86.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index ef6970b88a59..e75b5a73ffc0 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -11,9 +11,9 @@ including supported boards, build instructions, todo list, etc.
 Status
 ------
 U-Boot supports running as a `coreboot`_ payload on x86. So far only Link
-(Chromebook Pixel) and `QEMU`_ x86 targets have been tested, but it should
-work with minimal adjustments on other x86 boards since coreboot deals with
-most of the low-level details.
+(Chromebook Pixel), Brya (Alder Lake Chromebook) and `QEMU`_ x86 targets have
+been tested, but it should work with minimal adjustments on other x86 boards
+since coreboot deals with most of the low-level details.
 
 U-Boot is a main bootloader on Intel Edison board.
 
@@ -31,12 +31,14 @@ are supported:
    - Link (Chromebook Pixel)
    - Minnowboard MAX
    - Samus (Chromebook Pixel 2015)
+   - Coral (Apollo Lake Chromebooks circa 2017)
    - QEMU x86 (32-bit & 64-bit)
 
 As for loading an OS, U-Boot supports directly booting a 32-bit or 64-bit
 Linux kernel as part of a FIT image. It also supports a compressed zImage.
 U-Boot supports loading an x86 VxWorks kernel. Please check README.vxworks
-for more details.
+for more details. Finally, U-Boot can boot Linux distributions with a UEFI
+interface.
 
 Build Instructions for U-Boot as BIOS replacement (bare mode)
 -------------------------------------------------------------
@@ -700,9 +702,10 @@ for details of EFI support in U-Boot.
 
 Chain-loading
 -------------
-U-Boot can be chain-loaded from another bootloader, such as coreboot or
-Slim Bootloader. Typically this is done by building for targets 'coreboot' or
-'slimbootloader'.
+U-Boot can be chain-loaded from another bootloader, such as
+:doc:`../../board/coreboot/index` coreboot or
+:doc:`../../board/intel/slimbootloader`. Typically this is done by building for
+targets 'coreboot' or 'slimbootloader'.
 
 For example, at present we have a 'coreboot' target but this runs very
 different code from the bare-metal targets, such as coral. There is very little
-- 
2.42.0.459.ge4e396fd5e-goog

