Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B4FC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E10A8657C;
	Thu, 24 Aug 2023 10:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irPvM0pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B44E86565; Thu, 24 Aug 2023 10:09:14 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1920180842
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fefe898f76so17342335e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692864551; x=1693469351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vamulpfRC7gbTffuILaPuxBgbqjFuA8QXPDlYxXMhUY=;
 b=irPvM0pbiJ57stxMiBAoH+YwJyHV2CABtmLcKsfM2o2wr1QUs+QOnEGehvG+OJd3w7
 42w6xisQdQNisotcCu1B6C6MSSbm0xDkZvIYMfVAfo1hTTCK2IJmNwDvPu238F5eInJb
 J1ta3RsaD+WT7DbxZ48wwwTPuJnztxFirr253owku7ub2h59eO5SN/xStU467P1AL6Ne
 up365f5HtGPJF/7nQUQMy6TB6k+/8hWLdOV9dh2jrXRB/fSY/0qBKC1o6AwufMWHktko
 RuPT+QC/MrcXSFqhMfDJp/vV4DDVYe6WFDkWZz2htlxK+FOqsXe6RaWj04dlkOY+jDGg
 uX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692864551; x=1693469351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vamulpfRC7gbTffuILaPuxBgbqjFuA8QXPDlYxXMhUY=;
 b=PpAM5TVqHDk8Lx8om22TRzl2J4KzrDXPcXZumE/JsaORqvAGTY4/+U4NlMTY3qB7iK
 ocStZu60Q2BX4XNNdOMg9bIxOz8yvIAPOlTwgxiam1SgFYNNF74zngKsqVXuGJoLo6D+
 AAml3ZiOTYYvsqtTwoMgCwmosknQuoOuC5wF0OwZ7bT6wvzYJ5F6fPSrMQrjc3quPDDr
 R1ctv2bKDoiijGQopYt8EADNOaam+YwGGHibvadjAMHFRW9E4dYKdVyOY+lJdEJegD8B
 CZr7ytNYCMxXDMgqMoQMada3y5pBKc2UShYDaww3klIIPsnVPHNHc313QoO4s6/M6LHN
 nfCg==
X-Gm-Message-State: AOJu0YzGr8SixpiLm+wR5q4X8N8NFm3lslRS6mIOIdKTqjX8DzvtYvLs
 I6Tn0+zTxDNjIXyrYykO9qhmU1vfN7kruw==
X-Google-Smtp-Source: AGHT+IGvXb8voq+8aiSMMRCIZge4nTJy2yWE+WBt/IqtJX4ZqO4pK604lX0bQefnJp83RgJAMh8FSQ==
X-Received: by 2002:a5d:6282:0:b0:31a:c6ef:5edc with SMTP id
 k2-20020a5d6282000000b0031ac6ef5edcmr9857728wru.12.1692864551349; 
 Thu, 24 Aug 2023 01:09:11 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:8b32:37a2:413:27e3])
 by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b0030ae53550f5sm21282602wrm.51.2023.08.24.01.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:09:10 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1 1/2] verdin-am62: add u-boot update wrappers
Date: Thu, 24 Aug 2023 10:08:49 +0200
Message-Id: <20230824080850.1755724-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add update_tiboot3, update_tispl and update_uboot wrappers to update
R5 SPL, A53 SPL and A53 U-boot respectively.

Usage example:
> tftpboot ${loadaddr} tiboot3-am62x-gp-verdin.bin
> run update_tiboot3

> tftpboot ${loadaddr} tispl.bin
> run update_tispl

> tftpboot ${loadaddr} u-boot.img
> run update_uboot

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 include/configs/verdin-am62.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/configs/verdin-am62.h b/include/configs/verdin-am62.h
index 7990ea831022..91fc0f03a81a 100644
--- a/include/configs/verdin-am62.h
+++ b/include/configs/verdin-am62.h
@@ -46,10 +46,20 @@
 	"fdt_board=dev\0" \
 	"setup=setenv setupargs console=tty1 console=${console},${baudrate} " \
 		"consoleblank=0 earlycon=ns16550a,mmio32,0x02800000\0" \
-	"update_uboot=askenv confirm Did you load flash.bin (y/N)?; " \
+	"update_tiboot3=askenv confirm Did you load tiboot3.bin (y/N)?; " \
 		"if test \"$confirm\" = \"y\"; then " \
 		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
 		"${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x0 " \
+		"${blkcnt}; fi\0" \
+	"update_tispl=askenv confirm Did you load tispl.bin (y/N)?; " \
+		"if test \"$confirm\" = \"y\"; then " \
+		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
+		"${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x400 " \
+		"${blkcnt}; fi\0" \
+	"update_uboot=askenv confirm Did you load u-boot.img (y/N)?; " \
+		"if test \"$confirm\" = \"y\"; then " \
+		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
+		"${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x1400 " \
 		"${blkcnt}; fi\0"
 
 #endif /* __VERDIN_AM62_H */
-- 
2.34.1

