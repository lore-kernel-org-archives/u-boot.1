Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDACE99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A118423C;
	Sat, 11 Apr 2026 09:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jEwoWYFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE76484154; Fri, 10 Apr 2026 15:58:48 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DED8416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d6144877aso20967981cf.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829525; x=1776434325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc6d6jriUzP78hbCPqkj8Cix2YelQeCkUK+GUtgCJnk=;
 b=jEwoWYFlqd0kReRzqP2Lz+1/Doc5rUxt+vt7N09o2UWa+63FtUsvjp8VTiWrNtDflj
 qCPEf/JlDWXU0xXlEGQ2Y5N4PRWjLsdPomvLF+INrHgds2+D6aNyB8bietdJiuF/YDOT
 Fw9ouZEQcqdAmjPSjlKiSG3cDBpn6LFbFLQ+sTbQn3/Op6X/LzoRxzRH7pBknA1Sjhrf
 EbFzgsGcva03Sz4Qb+dBLvbFPlcg5uKOiilk0SB/dOR10m12OrzpZV3DKb2Yryhn6IJA
 u9Ez21YK/B14VA0tzef2UoplfypXMpjbV7yWog2+nMhF1+Ra5DWYHynMTWyxwvl03zdS
 5hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829525; x=1776434325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bc6d6jriUzP78hbCPqkj8Cix2YelQeCkUK+GUtgCJnk=;
 b=rWJA3sO0WlAIIJR4LIHA/tkJwzHIgffoyRTm+tZMHoh8vF1FcLKz27Vq7ab1FJe8wk
 tPHhRa//TPWhnR7e6370SJ4k+/WyoODlP6u5F3Dt0KCmJmy+tWUvroVZTAO6GudTYai6
 LYWwlu1mc22RDlTh2iujwyMtTJphwePOxixBcPJ3ru1fj/KDZ/P07B3JYd5MJVvC/r2X
 xf/QA/cgRiPKOj3EJhmp3R/uxVi5zNTK9wOBHUtTd5ZDiuXKEyo8QpfoEylLk8C9GXOu
 hXs7kJH2WPeBIEkcfK7MAcHeVwvTNNp5ivATH73TgcbRKUIWeRPdtMqZAcvuSyBzTIEg
 G3qg==
X-Gm-Message-State: AOJu0Yymy/yfaZWxgPhgTCQxgIguhcnEnVAuEPwFVpsJgSRIap7cq3Bn
 Sh0QEYDWXvEjGC9qZRRleDsqXi27mVfHCXaZtaLyHBlJ2s52cw+BHPemzkcvUJVZ
X-Gm-Gg: AeBDiesZRPLfHf3yMWm8Q/9VWeHvTTkI2LOJ2zr8tBcHmyja9RLKlIG83wxnWR+E+rv
 TU0O3h02bansl9ceyEj1uPqGCyKBTGqH9L5bO6iFej22IvYjCpZCZs2rNr41jLY/Z8RgqIWp+8E
 1vgOL0kX5qyTag93eOu/iYu9VwCawME8/+3XEmpGKQqyqxTD3I2zOdpEjgXtgO5sGS6xqWgC6Lq
 paExYWHzhpRstwZ5tH4EDlhr0ZvGWGlKfC7YGQE60NlX8qLGPgsbfTgi48qgLHKpqrhEPuvsRvr
 bXrx6EtTIYhIYbIQnUeZAHtIUqfX3qBDZbVay/D5f6KHZ2GKF4e8TDiVZgLty68il3K3OeHvR4l
 Yg21gdXkaU+L0LfD+f0z542/t2yXtCi4j6NhnkhMH4j5u9k8Tvs8ctOvrpIH25cxKhh86PFRdso
 eLMD0YynfUjroRhLTxE3sELq7YoJR9ovl/Ow==
X-Received: by 2002:a05:622a:8c4:b0:50d:dd3a:73b4 with SMTP id
 d75a77b69052e-50ddd3a77ffmr21408141cf.37.1775829525471; 
 Fri, 10 Apr 2026 06:58:45 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:45 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 11/14] configs: sc5xx: Set default bootcmd to SPI boot
Date: Fri, 10 Apr 2026 09:58:06 -0400
Message-Id: <036010ac7fa9f231dfac2eedbb7e2a9c5e03f75c.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Align configs to use the same default bootcommand.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc589-ezkit_defconfig          | 2 +-
 configs/sc589-mini_defconfig           | 2 +-
 configs/sc594-som-ezkit-spl_defconfig  | 2 +-
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index a249fe8df7b..d8982f62d82 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -22,7 +22,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 25285695367..78b39b6dd73 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -20,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 89ef08c1a72..23951d0b5f1 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -15,7 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 9e907d31136..b4e71b5d2eb 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_BOOTCOMMAND="run spiboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
-- 
2.34.1

