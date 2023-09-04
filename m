Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1432C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F167486A1A;
	Mon,  4 Sep 2023 16:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7cLZ3Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BDE86A17; Mon,  4 Sep 2023 16:42:03 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE20869DF
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34ca860051fso5495695ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838519; x=1694443319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RaxjXNUHTjdDuRUZMQoTqRPVRbmzajePxkKSbrkchM=;
 b=h7cLZ3VwzJoKzI8WXqrhXp6ME9uUI7aiGuiRu1sQckCcqBZVAw0nMjrw5Su+l5+yrZ
 E44TXaaFzDYP+NvNz1wsvPB3SBKVFD3SEehFPvAM6zhsnWygnn0SkQhEVi6XKYfWK1Dz
 hcHs1zInYn0RoLA9PunRXuLStsk8fLJs8FLzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838519; x=1694443319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RaxjXNUHTjdDuRUZMQoTqRPVRbmzajePxkKSbrkchM=;
 b=TEySobAq11fCR6371Hjbo19UgIOpsfcnKOnPlXPr0q1zjTV+pfYQL8yBhKWWsrQXNP
 w1kR4yhqqQufVSfTnNMM5uQgTd9tiEUs0ND5LvxGb+wPDZtONG19CP88L4wnJFhNHH0L
 PPmK/aK4EoyInNqOB6oetVzuCWuVV33/baFaheIFmuwXnmVx1cU1kd91kdR6y4ur5Yq1
 crh+bbvLYAGTAZwHr8/BvElMH7foQKj4JJ6tytqlToTuteydzDP6/6PnhBMmrEqlP9ma
 u4Rk03iWAKg6A5uYXRImUuMWqErQyveQ5bMHFJLfkWua/7brfkwTlyjRykWwZ+/Be1FN
 0PvQ==
X-Gm-Message-State: AOJu0YxIDfIfc4ZPQY/JO+lqZ39pLJdQN2tYY8frQrpxL2uOeZzTghH/
 3RmFmkBbt4AbrHDbdm9feTaHnJZ3paJIaN+SYpw=
X-Google-Smtp-Source: AGHT+IFJ21nr/e5FR/P9c9j+9oErPb8Ltbsb4jTZmSkRs4zUeQ0RunhHogRO15WaDLdTWHwrTSZajw==
X-Received: by 2002:a92:c5ae:0:b0:346:7d1d:f97a with SMTP id
 r14-20020a92c5ae000000b003467d1df97amr9557386ilt.10.1693838519686; 
 Mon, 04 Sep 2023 07:41:59 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 18/20] boot: Join FDT_FIXUP_PARTITIONS with related options
Date: Mon,  4 Sep 2023 08:41:21 -0600
Message-ID: <20230904144131.2699824-19-sjg@chromium.org>
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

(no changes since v1)

 boot/Kconfig | 8 ++++++++
 lib/Kconfig  | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 08efecb13ef6..a7dcd6b0ae07 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1475,6 +1475,14 @@ config OF_STDOUT_VIA_ALIAS
 	  incorrect when used with device tree as this option does not
 	  exist / should not be used.
 
+config FDT_FIXUP_PARTITIONS
+	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
+	depends on CMD_MTDPARTS
+	help
+	  Allow overwriting defined partitions in the device tree blob
+	  using partition info defined in the 'mtdparts' environment
+	  variable.
+
 config FDT_SIMPLEFB
 	bool "FDT tools for simplefb support"
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index bfab2f3165a7..eb2b10161824 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -953,15 +953,6 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
-config FDT_FIXUP_PARTITIONS
-	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
-	depends on OF_LIBFDT
-	depends on CMD_MTDPARTS
-	help
-	  Allow overwriting defined partitions in the device tree blob
-	  using partition info defined in the 'mtdparts' environment
-	  variable.
-
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
-- 
2.42.0.283.g2d96d420d3-goog

