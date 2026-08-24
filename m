Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5FCC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87E2E60684;
	Mon, 24 Aug 2026 19:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SypZF6Y81Z6M; Mon, 24 Aug 2026 19:48:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787600907;
	bh=4X5sP/AApjLNWCTm08k9g9AIth4BXkNkT1YXNkVL5oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rbTba09RedayErlhfK4zac7Nbeq0mG8ZAGy/pqsZ4qQdFKhwu0X057x932aPVyG0I
	 ZrFHaikUaYT/PX5tvqrqhGW9t7ZZhWe+bwz60LPnNTJmiP71h4TmOrony0Ohm7wmRQ
	 aqPokz6pjCw89wwpfxdGBJ+MkUAOOS8jj+sgX/amL2Q30A3ZD0XuYSFxJu67HVZ5Jv
	 rq1fWFR4QWixthSZqgsmltVM2aqPr4lpXzpoHE6XeHXrWM+cuOOZC8DjQ1GvgIetg5
	 kge7l5ZNOIMnWe16PGj7M75RbHlaU+h4kKNtAs11Jph0yvQpSg6XBNUH+2IlwXj4tt
	 +zjGOCbWkOCoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2DC060618;
	Mon, 24 Aug 2026 19:48:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B8052FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D53C80D34
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxkAC15nGCgd for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:48:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=VbYcbfrT
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FF3F80D2C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:22 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4a40bcc8d69so3432781b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787600902; x=1788205702;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4X5sP/AApjLNWCTm08k9g9AIth4BXkNkT1YXNkVL5oc=;
 b=VbYcbfrTBm8OxkRIqA/Mwa+ZVteTJoutIFpOUsQh66gjFxnrscgekNbYWc7tidjtDf
 Ry/fwx9YY4/97l9Vs2GOvjxUFKPpi9Jnqmksofyqsa4Hb2cLAfcMeyIwUY1QA+ihU6bl
 FO32wSKiL2eIJeYq1rQLVT0V2MMXLCAOFcu4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787600902; x=1788205702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4X5sP/AApjLNWCTm08k9g9AIth4BXkNkT1YXNkVL5oc=;
 b=f8RU3ks01SUhQy5PH6ox38wWbZM8EaKCf2ieRk5u6rhPJ7BJtfxtocvbwGqrAmzhpb
 G5sYCDrGcI336CjSglIf8fexigR1d5BxcEe/Rr1TUOS5VmHr9tW2u2n71h+5iNaJWvQ1
 inbU3AtyVoxYnvF7zVrb2NCs6sjvoYMX+Y06MZrqOfqzO+xTSRux9FXERRIxPqlmWq+h
 KoURxm2ZbWr2lYkjwc0MG5GYAsH/ao9l3qpbMi8Qlr0J9XV39MeTSPNKM6lYtqI5cwDJ
 +5K7/eHDC3jC0sSkwHU2zXNyd4GStInu2GETWpf5IC2sCCnNdorDoTu9jVp9mwxbG4Mt
 lO/A==
X-Gm-Message-State: AFuF++m6koilU4t3BSu7jYwNZF7xoiLE3JalsL8Q4KEgftqFFjV9ItKX
 LV8b8W60acck/qAz242b8BV8nR0UW3izKWFWhbdgV8PdECKPp/i5HQ6qJewcB2X+lVwCfjnmAFD
 XycaAD3UbzPY5
X-Gm-Gg: AR+sD12tQz0AQYDdncg+yk57ygkqcrP1jfy6m0aiUw/Lc6bcoLlvsK78uVIqpZH3wvu
 91CSECAMbZvVW9knxMJviQTD0pWJTo6bQlBFOAeMMjjRZVdbsjlT6v49akHTmHAxiskcdz+SxUN
 zG08OoGr5jNKvFbZ9K5284kenIAMhcME9dzVp3Fj8R6t8xkwjmlhfbhGrtsz415oxWmT43kiolp
 u2z/WEULlg6FNorCs0hBCWkOJT+AUUnEwB+SdjoU+dN0+J6vrVikYyASD2JIZiiGyqt2l1Zx3cm
 FjGIfPI//ZonqE3y1bAeOD990kwBrkj0K32P1BQnuDcAFZ/ZeCKq9yUo7AFj7kTD8vPrSM1S1ha
 Ootgied0e/y7Hx1VtJxTSCokO8pugERr5ags9i37UXVszaA+QaiwSAsVYxoKGG+/hOFPYrmTHpD
 Mb3f6FgkrhW2ZNhkUb8OfWZvJ8fkbP3ASnS0N0rDAi4mda7xh6aT4CR19N2uHg+7aEmMJtSKRk0
 8S/Cn9PzLEt4y2g1ufO5HZ0+0Zow/7goPgz4ZjD7XFlvj8f3+T9H2W73CumDLbEhzhSkI3SsuLe
 gKXdtAj32Hi4FpHGO4IMP5ewNr1Gr5sI2Q==
X-Received: by 2002:a05:6808:179a:b0:4b2:8d7b:41b8 with SMTP id
 5614622812f47-4b2ef430673mr27352996b6e.18.1787600901898; 
 Mon, 24 Aug 2026 12:48:21 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b32c6909b1sm4340077b6e.5.2026.08.24.12.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:48:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Feng <fenghua@phytium.com.cn>, Linus Walleij <linusw@kernel.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH v2 2/2] vexpress64: Correct CONFIG symbol logic around device
 tree passage
Date: Mon, 24 Aug 2026 13:44:02 -0600
Message-ID: <20260824194814.555634-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824194814.555634-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260824194814.555634-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When we don't have BLOBLIST_PASSAGE_MANDATORY enabled, then we're being
passed the device tree in some other manner, via OF_HAS_PRIOR_STAGE.
Correct our logic around which symbols are used to guard what is
generated / used and when.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
- Add Ilias and Raymond's tags

Cc: David Feng <fenghua@phytium.com.cn>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
---
 board/armltd/vexpress64/Kconfig      | 2 +-
 board/armltd/vexpress64/Makefile     | 2 ++
 board/armltd/vexpress64/vexpress64.c | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index 49c7fda0b83a..a988c7198498 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -31,7 +31,7 @@ choice
 config TARGET_VEXPRESS64_BASE_FVP
 	bool "Support Versatile Express ARMv8a FVP BASE model"
 	select VEXPRESS64_BASE_MODEL
-	imply OF_HAS_PRIOR_STAGE if !BLOBLIST
+	imply OF_HAS_PRIOR_STAGE
 
 config TARGET_VEXPRESS64_BASER_FVP
 	bool "Support Versatile Express ARMv8r64 FVP BASE model"
diff --git a/board/armltd/vexpress64/Makefile b/board/armltd/vexpress64/Makefile
index b0dd1d0af879..5f9dc2af930a 100644
--- a/board/armltd/vexpress64/Makefile
+++ b/board/armltd/vexpress64/Makefile
@@ -5,6 +5,8 @@
 
 obj-y	:= vexpress64.o
 
+ifeq ($(CONFIG_BLOBLIST_PASSAGE_MANDATORY),)
 obj-$(CONFIG_OF_HAS_PRIOR_STAGE)	+= lowlevel_init.o
+endif
 
 obj-$(CONFIG_TARGET_VEXPRESS64_JUNO)	+= pcie.o
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index d68da0e3d650..8b6b96d757d5 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -97,7 +97,7 @@ int dram_init_banksize(void)
  * Push the variable into the .data section so that it
  * does not get cleared later.
  */
-#ifdef CONFIG_OF_HAS_PRIOR_STAGE
+#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
 unsigned long __section(".data") prior_stage_fdt_address[2];
 #endif
 
@@ -150,7 +150,7 @@ static phys_addr_t find_dtb_in_nor_flash(const char *partname)
 }
 #endif
 
-#ifdef CONFIG_OF_HAS_PRIOR_STAGE
+#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
 /*
  * Filter for a valid DTB, as TF-A happens to provide a pointer to some
  * data structure using the DTB format, which we cannot use.
-- 
2.43.0

