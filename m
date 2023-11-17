Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C02C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645588708C;
	Fri, 17 Nov 2023 22:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bC6kFs4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C78B8004E; Fri, 17 Nov 2023 22:15:21 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3494B87208
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1ef9f1640a5so1314554fac.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700255713; x=1700860513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gH/9KjvTYRYGtYTpMMfkIwgFkayhAneehVlx+ELkbI=;
 b=bC6kFs4KeqD6OvXsmuxN2MNrGuK6gzaSTXjREfuh24A+wrrwWvLfYLU3thf+1WbiKG
 rOTc5IbKVa+wCivYKm4Z3TOYC3TtiPczRuAwfRPE23vm2PPsyv9Cnieov/r2DBJqZux6
 vcXRXlTvB2+HqR549JiF0W6s6Sxsu0tN87JmzOvmru8yoSGLciH1JmMc/hQjIPwIPPaJ
 PJDO8gY9rYsawI/kLFdu93758wcgbohQbP1P/P1wKfPRcd+WrcudPIxZ5AugdGBuaNV3
 H7MTx5t1OtYFvD4kJrQHBb75bemjAX2Vh920v9ahAEiJgHW6nL1cYLrFshs2ytwXdKv2
 m3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700255713; x=1700860513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gH/9KjvTYRYGtYTpMMfkIwgFkayhAneehVlx+ELkbI=;
 b=RRT7nO8AUam1n+rZ9LBdxm80h1PKkkBJksV1doquLS4BWHqO/yCiyh8FpZucHziZmi
 5reXZVAQrnPWPgiy1SAaRj7xhsYv5Vfg3jiSHMmf52WF6Y7ePG83woGY1SKohIxapURI
 T3JYxgunqfCZ1cQiUM4cEeRPCQ0QA8Dt7d269+Js86u6FQ3PgkOb7ELQ6nvklnJVZTpO
 9HZo7UZHTs15ofytXBiNhw/EOEq8jz0PkPCH9TilKd5mqr4LvfWq8lS05nMRgO7CCZiU
 osDIjjUgvu8t3MXSUmXlmX4dtHMDzPnFGTO+Kq0pIx78MBYQDAkkkXBNwIUHx7sf2UOr
 8sbg==
X-Gm-Message-State: AOJu0YyGF51VqZ10vQZpBflYUaFXm4uSV+1pVjNLpGCyQQEPbcdkJnKN
 boE9RnJkrMvBtVjn4RaZRct4o4rW1GI=
X-Google-Smtp-Source: AGHT+IFO1wAKCBQcppSbH9maT5VGTlU4c8CcCJHzmnhbGdAke7NW4qI5guXi8gZ75Piy/Z4bovC6hA==
X-Received: by 2002:a05:6870:9d85:b0:1f5:acca:43c4 with SMTP id
 pv5-20020a0568709d8500b001f5acca43c4mr437957oab.53.1700255713695; 
 Fri, 17 Nov 2023 13:15:13 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 zl3-20020a0568716d8300b001d6e9bb67d2sm415378oab.7.2023.11.17.13.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:15:13 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 4/4] doc: board: anbernic: Update rgxx3 to add new boards
Date: Fri, 17 Nov 2023 15:15:06 -0600
Message-Id: <20231117211506.1396929-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117211506.1396929-1-macroalpha82@gmail.com>
References: <20231117211506.1396929-1-macroalpha82@gmail.com>
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

Update the RGxx3 documentation to note that it now supports two new
non-Anbernic boards. Also update verbiage around panel detection to
note that it is no longer hard coded to the RG503.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 doc/board/anbernic/rgxx3.rst | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/doc/board/anbernic/rgxx3.rst b/doc/board/anbernic/rgxx3.rst
index 7d1beb423c..89cc4ee560 100644
--- a/doc/board/anbernic/rgxx3.rst
+++ b/doc/board/anbernic/rgxx3.rst
@@ -12,18 +12,24 @@ This allows U-Boot to boot the following Anbernic devices:
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

