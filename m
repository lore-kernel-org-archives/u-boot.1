Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B68EC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8311386A2F;
	Mon,  4 Sep 2023 16:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bikEVIYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E502D86A26; Mon,  4 Sep 2023 16:42:07 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A6A86A21
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so66578539f.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838524; x=1694443324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m16kTpsYUROUn98xajOhn7OP6c18+C4xJMCSNzrKc/I=;
 b=bikEVIYp1h96Mj/fIagEfzfAk0wdIEip2N269QI89NoIkDaMzDgmD814MREWKeHZYT
 agRGBlSPIelgy0mvM7Bu2A4ths1D/sUSantWfhCH8ACarXndHuWbxpTBxrlt4pSSd5lN
 aWapOock4yEK+AGSOSeVNt+/awRPn58aADudI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838524; x=1694443324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m16kTpsYUROUn98xajOhn7OP6c18+C4xJMCSNzrKc/I=;
 b=OWq3Nn25N7oItLcpbVM6IKfzqVMPBi16aQ2okmCSYHy3j4veFfJq3tyEntVGsiL+nl
 zrisky7T7Qx53skA9KO2RjRl2bwtkPtuXz2cWhTzhPDJyDsCNjeWF8bEkpbMpgCerpgT
 zNRZyqq/4ZcfauZuXzHhcxn9oHlzqH7FpKhcxD5U9kHdLH2+aZucBNXxtI3hmkvSZmIX
 zbbXnICZhtrosRBZDPLg6rg/++wfgP9YsEQ8m0sVumSEdQ/1kHBv4YSAemwt5LbHXO2d
 pCcWoyg25mHV4oQ2PpS0RUNxX07uSaDV+M5XK56yuutRLVgzkPdjNZ/CVGstLyel0M5u
 v0Vg==
X-Gm-Message-State: AOJu0YzrWoz4TZVt7xKVcekXa0IAlNe4f8Veq+c1o4Bo2uJYDWx/4iAS
 PFD9tdsWNH4360s89vpSVehjsunGx3AGv21sUNo=
X-Google-Smtp-Source: AGHT+IFoUW4BSG2iG/Dsm0vXtZF8hwWI3pNri2bOY0bfHMcpmhYy4y6AGp+qkQPC9mkEtr8cLjSXgg==
X-Received: by 2002:a05:6e02:1be9:b0:34f:1e9c:45d7 with SMTP id
 y9-20020a056e021be900b0034f1e9c45d7mr581461ilv.31.1693838523875; 
 Mon, 04 Sep 2023 07:42:03 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:42:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 20/20] boot: Join ARCH_FIXUP_FDT_MEMORY with related options
Date: Mon,  4 Sep 2023 08:41:23 -0600
Message-ID: <20230904144131.2699824-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

Move this to be with the other devicetree-fixup options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'

 boot/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e8bc7dfddc77..bd2e4aed3dd8 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config ARCH_FIXUP_FDT_MEMORY
-	bool "Enable arch_fixup_memory_banks() call"
-	default y
-	help
-	  Enable FDT memory map syncup before OS boot. This feature can be
-	  used for booting OS with different memory setup where the part of
-	  the memory location should be used for different purpose.
-
 config CHROMEOS
 	bool "Support booting Chrome OS"
 	help
@@ -1490,6 +1482,14 @@ config FDT_SIMPLEFB
 	  the presence of the simple frame buffer with associated reserved
 	  memory
 
+config ARCH_FIXUP_FDT_MEMORY
+	bool "Enable arch_fixup_memory_banks() call"
+	default y
+	help
+	  Enable FDT memory map syncup before OS boot. This feature can be
+	  used for booting OS with different memory setup where the part of
+	  the memory location should be used for different purpose.
+
 endmenu
 
 endif # OF_LIBFDT
-- 
2.42.0.283.g2d96d420d3-goog

