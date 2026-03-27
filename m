Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDEA10F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384A584109;
	Fri, 27 Mar 2026 17:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JF46sMd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7F683F14; Fri, 27 Mar 2026 14:52:02 +0100 (CET)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41AD78394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso181677685a.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619518; x=1775224318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uunLc8p3og5SZfkhAb1uVJY3UlbV2BsCCntq+hcHFM=;
 b=JF46sMd2JiAN09cUpS+/DHv6dv1thuUlMHBZl/PE1NIw6+rc77lErzR5mmRKkDs4QU
 C42yKx71fdoVkMVi/Rj+hdl7kywWBrTmsHDISS0fw4ajVeJ1lDQrueDs6LEXLJsm/Mi6
 A5LvFpbzH9Z3cg5HcdoREZsq/Uh2SLODaIjS+w6+rtIG6oDiiRUvr1TnZ8/zpt2NsUZh
 Qka2YsSn9MtnvBOwSGy4R9RtkDF3b2ojGZczLh785taK8mlQzczNcDRgu3AEL5ttzIuu
 P7c+C6iq/LP05Z64nmFH+hTewJEhVXyYBTQVixQRio3ynqPLTP1ZBLzvCLVgmsTacxAZ
 BFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619518; x=1775224318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4uunLc8p3og5SZfkhAb1uVJY3UlbV2BsCCntq+hcHFM=;
 b=cOgHGqZfCoRS+uVh3+l5Vss0G1NzjnAvsypCqOeqAwC9w7sb7B1Gsn9htyBOkZ7mfO
 WzC83EabH8WRKukSp+HNsn/agLtH+F/RbJMCYmCFG6Ug7d4ZJY54ouR8dQbUgeequz7R
 m9bBN+EppdmgOUPqUzx2OwVk07jOedi+mj3PVWsbJL4J7zaYns0K5jAERl0IythsVbao
 /j72srIo+/eZIqvmR8AwSwuy076z//0+WTJka30dp4gytUZrkU+ZW4vXYmo3Z+ZYyKoy
 T0EOVq4LsaEM1j7f8sSGTxIl0jGDU4cR0XFsodWm40SWTDDfxJ2poCC+rsjFjJ8WDOVI
 8Usw==
X-Gm-Message-State: AOJu0Yz/TymXkK4VydvjRr9/42RPWLSBOBsyVKjxBwupfaA9W3z4jxOD
 XGbBf0jlFLzclwAVwVyloWLmCTu6YMcF86CqQGyEZSVYLQ8ZJiGdagPLquXCHUG9
X-Gm-Gg: ATEYQzy6wF3CSuJQJ2vh4J3Tjza5v9H3Qp20/cOjRiaMUfUWjbp1w9YkIZBcvwpfvcl
 tzT+voKStmLKqsYmxt0rdEupA0Uhdk4M6UfoxULYSO5t7+dmFwFmf1ywIHLx9kT6vFLA9lcuH3v
 Vo3enOPc4UdM1nqg9uS2r2dCGAsmBTx1Hp9tyx1GbKbra7m4b0DdK6vm8JpXTDj9HLAo9JRELlF
 LEtYCVU38MwkJqTi0krc7rcJL0THO6dAvwbZO5tWk8qnOZriztsXiOppwE/TIfwelnyk7IRWFdO
 lSHCzzAWzfOHZzrk2+4L+b2DCKAmi5TOhzpP85T+gHpqUnGMTF09fx3sDVTI1szIU0UW/Bd7Znu
 GS+swW5Fsukgr+DoKNjTlg76FO+NN0crGEAjh2ZIHUq5wKovy7OlAWp3zJB3bwhrF8h97JRRhat
 94cEv028ySEpiiaNn4gKIm5mNB/WP/v/O/6qWmLXCIGNbS
X-Received: by 2002:a05:620a:2944:b0:8cd:8ee3:5004 with SMTP id
 af79cd13be357-8d01c61bc17mr309978485a.27.1774619517953; 
 Fri, 27 Mar 2026 06:51:57 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:57 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 11/13] configs: sc5xx: Set default bootcmd to SPI boot
Date: Fri, 27 Mar 2026 09:49:26 -0400
Message-Id: <4a656c30daf693bec78aeeb1821cd5d678f2286e.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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
index 42942eb7517..f42ee15fbed 100644
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
index e03d647d4d1..b2249ac14d8 100644
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
index e576c56909d..4aaace6ad39 100644
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
index 7a021ad345c..e1842089588 100644
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

