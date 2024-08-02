Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019B1C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 12:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B298688B91;
	Fri,  2 Aug 2024 14:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="eAuMDY5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E99E88AD3; Fri,  2 Aug 2024 11:31:34 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D8C88BC5
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 11:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ef2d582e31so93345371fa.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722591088; x=1723195888;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+95PjGsvHO1UqqLRAAhiijaufIuJqsbCzns3GwskDEg=;
 b=eAuMDY5B+JZVSUj2c3jGSTKL9omkLnkYgqRPizae8NCYixJk7vBZHlL7OD9aKUEHpO
 yrlWDglWD1t8Z5a3tOl775gc985TetH+OZ0j4a/sIM4wooYA9ItQRhAs2XpkpzJ2GUd4
 3BBnPhUZ0H3wgkEJGH+VpkRdYOCN6CAVPiYX50OvJMbRtkYIolVPztEj6vSRVTXTSMuI
 MYKMdXkoww9meRw0mJi+Vgs09FrtA12izluqMGjoSVSSooYoVBJPdjOQiB2ApT8PrnUH
 YinGgzTgYGHYRhW+B7I7LrZCqtV041oipUgbVdC2FJFQzzxksxNW5kxIc4pWatVaNRiZ
 HWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722591088; x=1723195888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+95PjGsvHO1UqqLRAAhiijaufIuJqsbCzns3GwskDEg=;
 b=mpq8wWKPcnSuSjNShBakSQC/7Z22zESXUDmHZxixGCGQ9oITMbSuXDWW/PPRLI5CZJ
 LCkqsXvPWabNj9iM6GhXGmf9U6vAJlyOZ1LhjKPv7YVz1QKa39BZ7ZgkoebCnCQCQ2lT
 nAxR358FF0Eph4RSL0VVWUISWTc9Fvy3tQL3eNSSLNY72aomN7c4GqGmw44YvDB1CH1y
 jGcpEhmOoUK5MvNR4DHBZzperLQyMCwFHonw7AgnHgWocfOHQZZVRUdccbw4S+F11u2e
 j+EtzPkKBZNqqDIXFA0Rdjwy5awcQF0Sk5Wr+woGeqoKm9hef9MlATTxvgHLR1p0FcKw
 DEvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf6YUOyRGAksg4xOKpn2e3B5LqT3ArnKhdnvoY8ThND8JDsIKn/+qaqzCowsviSMrf/D/srD2ZIBFY8xjjV7Rsitujsw==
X-Gm-Message-State: AOJu0YzdQOlTeaAxH6+bw3/akAbIeMA0rou+Tp4jTKkfhiwiBzybaOCp
 LVfH89RlZxzeOdq81Pv2E2AEI9qjXkcDKpaX4t1B1FvhWzmSWepNL0VQBrbAGe0=
X-Google-Smtp-Source: AGHT+IGm9/MmUoyuZyK4dsQVSEYymjcv/A/NYIT8v14ozLSdNiyfKal9ODHyURT7/mkSduwQSssB5g==
X-Received: by 2002:a2e:8747:0:b0:2ef:2cbc:9074 with SMTP id
 38308e7fff4ca-2f15aabcb76mr20485601fa.21.1722591087911; 
 Fri, 02 Aug 2024 02:31:27 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42824130e43sm83671905e9.0.2024.08.02.02.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 02:31:27 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH] dm: core: Show device sequence instead in dm_dump_tree()
Date: Fri,  2 Aug 2024 11:28:12 +0200
Message-ID: <20240802092820.917450-2-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802092820.917450-1-admin@hifiphile.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 14:54:36 +0200
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

Currently uclass index is shown in DM tree dump which ignores alias
sequence numbering. The result could be confusing since these 2 numbers
could be different. Show device sequence number instead as it's more
meaningful.

Also update documentation to use sequence number.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 doc/usage/cmd/dm.rst | 7 +++----
 drivers/core/dump.c  | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
index 7651507937..196b22d137 100644
--- a/doc/usage/cmd/dm.rst
+++ b/doc/usage/cmd/dm.rst
@@ -112,9 +112,8 @@ This shows the full tree of devices including the following fields:
 uclass
     Shows the name of the uclass for the device

-Index
-    Shows the index number of the device, within the uclass. This shows the
-    ordering within the uclass, but not the sequence number.
+Seq
+    Shows the sequence number of the device, within the uclass.

 Probed
     Shows `+` if the device is active
@@ -366,7 +365,7 @@ dm tree
 This example shows the abridged sandbox output::

     => dm tree
-    Class     Index  Probed  Driver                Name
+    Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
     root          0  [ + ]   root_driver           root_driver
     demo          0  [   ]   demo_shape_drv        |-- demo_shape_drv
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 5ec30d5b3c..5cbaa97fa3 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -40,7 +40,7 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
 	/* print the first 20 characters to not break the tree-format. */
 	printf(CONFIG_IS_ENABLED(USE_TINY_PRINTF) ? " %s  %d  [ %c ]   %s  " :
 	       " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass->uc_drv->name,
-	       dev_get_uclass_index(dev, NULL),
+	       dev->seq_,
 	       flags & DM_FLAG_ACTIVATED ? '+' : ' ', dev->driver->name);

 	for (i = depth; i >= 0; i--) {
@@ -129,7 +129,7 @@ void dm_dump_tree(char *dev_name, bool extended, bool sort)
 {
 	struct udevice *root;

-	printf(" Class     Index  Probed  Driver                Name\n");
+	printf(" Class     Seq    Probed  Driver                Name\n");
 	printf("-----------------------------------------------------------\n");

 	root = dm_root();
--
2.45.2

