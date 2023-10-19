Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044FCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9FB8747F;
	Thu, 19 Oct 2023 17:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HzqNj5TA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E2F8747F; Thu, 19 Oct 2023 17:01:32 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551F287448
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59e88a28b98so7912437b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727686; x=1698332486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/0n44yy2ftK4uX/Yr0zfrlRSSze7UY5xUsbdhotmXE=;
 b=HzqNj5TAyG0TR0pO50h/45f6ae2ZmmZZftAHdr2ykcssqp8j0Dw3MnxOjK31oZqMJL
 Kxgh4mf1qGy9XOLcOHcK1IgtD0V435mJyQEIYDwFdSK5YiKHzhEr6Zcr7y6lpwwUD6b9
 ivpzVGTudWaK8ml4h9+Uy2u8dLqGrDqwkr2Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727686; x=1698332486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/0n44yy2ftK4uX/Yr0zfrlRSSze7UY5xUsbdhotmXE=;
 b=Rl4eSt9qRqIfOANaSJ6t/mZqCtpEC80CvYrec30TJGkBZW+K1LQfyJcXtC218KN5uH
 CudVx5QHr6cxAh2m2RdFG0cRAeQbFqPQGbPXKO8L0RRQmylCOtADt5AUbNFZfyE7f4Sv
 RVQXnaQ7OsnTih6d827+evTuhPl9e0FuH/Bzpd3IEobRuWiULc0ov5d4nbyjy2aBR/4b
 C/jC0MLmT2oA8qDoIGM5WBH5xvlfK6GXaSpGibnrk078ducygXcJbrMH8VoLCb+PX9LR
 e8dDF83XzPWgw4SFxC0j4oLKSuuYGn3+6BHw8iwa9gQ7RUGj8LRApLG+XN8mAB+9HwRm
 8Yjw==
X-Gm-Message-State: AOJu0YyM3sC3v6e3EIZpLgFSKuwhhrgKy4iaSt+fwNDJuWHAZDcFvJOn
 aEmEPRNgoruUWcUIdWh7IfFQ5SpnIcgaD29DUJC9FQ==
X-Google-Smtp-Source: AGHT+IGBfdGNiY0x/Rqc0RMM/D/SBy8h0z8arwUY3ftWxCpYt6t9EJl55/iVfaoGxGfQ+OmsxcrBLg==
X-Received: by 2002:a05:690c:16:b0:5a7:fcaf:c1c0 with SMTP id
 bc22-20020a05690c001600b005a7fcafc1c0mr1467217ywb.8.1697727685911; 
 Thu, 19 Oct 2023 08:01:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 17/24] bootmeth_cros: Require bootm.o and bootm_os.o
Date: Thu, 19 Oct 2023 11:00:58 -0400
Message-Id: <20231019150105.714407-17-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

In order to use bootmeth_cros, at least on non-X86, we need to be able
to start any type of kernel that the "bootm" code paths can handle.  Add
these objects to the required list for this option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Makefile b/boot/Makefile
index ad608598d298..3fd048bb41ab 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootstd-uclass.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootmeth_cros.o
+obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-- 
2.34.1

