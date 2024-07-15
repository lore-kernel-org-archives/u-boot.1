Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BFFC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 20:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670EF887D3;
	Mon, 15 Jul 2024 22:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaxOBOBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156B588808; Mon, 15 Jul 2024 22:01:18 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B803881DB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 22:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52e9b9fb3dcso5721860e87.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721073675; x=1721678475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/b7bb8L949Xq6G6wWewkHSPFsDBGzHOkA+kG/EJ8/ZU=;
 b=SaxOBOBNowSukUPpYjS/w0R2x3JysX/MVGWd73XOoZ3LgaW5lQYzk0BXb2QPibYs1n
 +PA5pp+DmHxtXjWc63ciYYG98hKyNHsh+SPd/LuNrgfvImzwGRHOCRDJc5VqzuQ23Z+2
 z3qbLUbUc1exYKpcXpm7EJpD4E01hyDEipBiS9h7RTzvfdM00nyuewP7O6iZEnmJ1iHe
 GqLGyCt48bhQA3LvYd89iXjeGHhFQ2mFnIrdhaJidVSeQPeHWJPMZlO6NFCqBW5ZK5Xg
 vp5yBYwOprm9n0u1+FzszIx6my4zXD0cN1l2/aDkaNThpwek7rRIgXDTAlj7+x2puUp5
 IOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721073675; x=1721678475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/b7bb8L949Xq6G6wWewkHSPFsDBGzHOkA+kG/EJ8/ZU=;
 b=mEgKhKep7Pg962f362CZld2xN6/Trj/X7hyS9YEsgW182uOxPC1Zohmb6VAUBCQaFh
 vWcptqcPd4mJUaprowLu68YBkEjI/1/RCTS023IIt74BWvJnPvwjAspfh1W5NuX+77GZ
 /sUpl39xaTiKz45c6X0qwscgl6S1cJlccKyf4oVtkc7WfIgFbOYWMcubo73ZYa06qoy/
 2IU0AzyaZa3yrrDJy/MItZ7ljZRMgaHmMiS1Tc3TbW4JjrI/djG9p+J10t9Rpvm+xI+L
 YmPflfryisbA3i/mwd0RBXnNv7nT94Kn7/z5j200W5l3LBUPXf13Ix58Rgz2XEwODXYX
 3pfQ==
X-Gm-Message-State: AOJu0Yw+MkQu4PPpsNPph9icy5UV36B6wK8KgAMvWujEcv4co13PgRjx
 5dRWqKb+546LoR5Pcj42d055UhiNTan2qLPrDtNAemUbEdYxkgXhYHdMknU/
X-Google-Smtp-Source: AGHT+IGIC5QhL8zecQh/zmU8EwVpnf96xDC33EyLrar5WCL+xKRCArr1aKgUXNNtVK8hpjkUHJcNLw==
X-Received: by 2002:a05:6512:31d5:b0:52e:a008:8f42 with SMTP id
 2adb3069b0e04-52ede1d42d2mr378233e87.64.1721073674600; 
 Mon, 15 Jul 2024 13:01:14 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ed2532bdasm935299e87.231.2024.07.15.13.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 13:01:14 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] cmd: correct ELF-related commands dependencies
Date: Mon, 15 Jul 2024 23:01:10 +0300
Message-Id: <20240715200110.34230-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Enable BOOTM_ELF by default for all configs with LIB_ELF selected.
Use OF_LIBFDT as dependency for CMD_ELF_FDT_SETUP.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 cmd/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0cf0d8ad8ab..5d34282c196 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -324,7 +324,7 @@ config BOOTM_EFI
 config BOOTM_ELF
 	bool "Support booting ELF images"
 	depends on CMD_BOOTM && LIB_ELF
-	default n
+	default y if LIB_ELF
 	help
 	  Support booting ELF images via the bootm command.
 
@@ -500,8 +500,7 @@ config CMD_ELF
 config CMD_ELF_FDT_SETUP
 	bool "Flattened Device Tree setup in bootelf cmd"
 	depends on CMD_ELF
-	select LIB_LIBFDT
-	select LMB
+	select OF_LIBFDT
 	help
 	  Do FDT setup in bootelf command optionally by param -d, which
 	  allows to bring additional system info (e.g. /memory node) to
-- 
2.39.2

