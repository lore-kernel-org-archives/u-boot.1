Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782C3C47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F8A8794B;
	Tue,  2 Jan 2024 16:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9L7lOdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63536878DB; Tue,  2 Jan 2024 16:47:11 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ACE87923
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-594bea92494so3382722eaf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210427; x=1704815227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5CXCYUczBUQjKQamPloqkUsFz2d5ZVu36134TsC2t4=;
 b=H9L7lOduZcyMBHQfO3tjWHVgYOmhD4smrRImISCL/fCOtHkK4a24vKXiOBdqQiFYAq
 d5qx/LDgmjFgipVfLOjXatcTtOH2k+QfKBZcoqIbtqvNEyYSiruh7dJNFTVxA/YhxMn3
 kNMvzkjQQuYeuhki5Nw2G1xNu3cv3DnswNh8Epl2r+P5xgBCiSPloKZ5s59vSQapnl/D
 f2vjULMe7FE/ge9viRwJAP2XTU0Eu/VNUWnGqp2jSOBRxufxCMLl9dbYO2d4936fMduV
 qTcn4r1kJDDLz83ilmD0B4Z0mDuPnUDgdPfgUOv9X4zImo9fo2iHPXeOBrssxKF0WvsX
 3V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210427; x=1704815227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5CXCYUczBUQjKQamPloqkUsFz2d5ZVu36134TsC2t4=;
 b=eQlO8havFt97u1LZ+XxN6b+gRpO96xNHWv47VoSFjjRFndbN1QwJ7ouOZc+mmv0t9p
 tchh3CqOsRHK8uVYOgxTjMlvGguxTMex37Z9x+r0a06Z5/KZ7Q9JQ1hsUDg/2mG9Wnea
 Z7DZSbDvggh1aac98ar+H+PZBbYauoN40sx1MW/U4C0TRQ6FMeQq/msti124eLjpKlKB
 bbvaO73FCV3GXRkfKEM/5m3hzVMdXNOapfhQRtsjifuwzglcycFAwJSQt0+dMeuArNou
 coR9PpjpxW+rNPXab2f9yH2kmiYns+IQom/JCX4Kep5gNpj9r6XprcHz5gMa3+is02cK
 tWlg==
X-Gm-Message-State: AOJu0YwTyIXEH48TYASzmxD5AkD8ciGO7Xg0iCI+eSZXGeFHeisE8C+w
 wTKe9i7tZ/TnZyMB+xvJIWWbyvpTyGtyoA==
X-Google-Smtp-Source: AGHT+IG3P6LXnNFfsTkbEiW30t44RiGzB7zfFya0DQfFfkD2QJM+HK+/hMSG6xF+M+V6s+8aYYUy6w==
X-Received: by 2002:a4a:ab84:0:b0:595:e14c:6aee with SMTP id
 m4-20020a4aab84000000b00595e14c6aeemr562931oon.6.1704210427557; 
 Tue, 02 Jan 2024 07:47:07 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:06 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 7/7] doc: board: anbernic: Update rgxx3 to add new boards
Date: Tue,  2 Jan 2024 09:46:54 -0600
Message-Id: <20240102154654.191055-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102154654.191055-1-macroalpha82@gmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Update the RGxx3 documentation to note that it now supports the
RG-ARC-D, RG-ARC-S, Powkiddy RK2023, and Powkiddy RGB30. Also update
verbiage around panel detection to note that it is no longer hard coded
to the RG503.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 doc/board/anbernic/rgxx3.rst | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/doc/board/anbernic/rgxx3.rst b/doc/board/anbernic/rgxx3.rst
index 7d1beb423c..d159ed2f76 100644
--- a/doc/board/anbernic/rgxx3.rst
+++ b/doc/board/anbernic/rgxx3.rst
@@ -5,6 +5,8 @@ U-Boot for Anbernic RGxx3 Devices
 
 This allows U-Boot to boot the following Anbernic devices:
 
+ - Anbernic RG-ARC-D
+ - Anbernic RG-ARC-S
  - Anbernic RG353M
  - Anbernic RG353P
  - Anbernic RG353PS
@@ -12,18 +14,24 @@ This allows U-Boot to boot the following Anbernic devices:
  - Anbernic RG353VS
  - Anbernic RG503
 
+Additionally, the following very similar non-Anbernic devices are also
+supported:
+
+ - Powkiddy RGB30
+ - Powkiddy RK2023
+
 The correct device is detected automatically by comparing ADC values
 from ADC channel 1. In the event of an RG353V or RG353P, an attempt
 is then made to probe for an eMMC and if it fails the device is assumed
 to be an RG353VS or RG353PS. Based on the detected device, the
 environment variables "board", "board_name", and "fdtfile" are set to
 the correct values corresponding to the board which can be read by a
-boot script to boot with the correct device tree. If the board detected
-is not of type RG503 (which currently has only 1 panel revision) a
-panel detect is then performed by probing a "dummy" display on the DSI
-bus and then querying the display ID. The display ID is then compared
-to a table to get the known compatible string for use in Linux, and
-this string is saved as an environment variable of "panel".
+boot script to boot with the correct device tree. If a board is defined
+as requiring panel detection, a panel detect is then performed by
+probing a "dummy" display on the DSI bus and then querying the display
+ID. The display ID is then compared to a table to get the known
+compatible string for use in Linux, and this string is saved as an
+environment variable of "panel".
 
 FDT fixups are performed in the event of an RG353M to change the device
 name, or in the event the panel detected does not match the devicetree.
-- 
2.34.1

