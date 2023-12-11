Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCAC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A4D877F4;
	Tue, 12 Dec 2023 00:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kGbOzRob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAB687773; Tue, 12 Dec 2023 00:21:58 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81222877CC
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b9e2a014e8so3379124b6e.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336896; x=1702941696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5CXCYUczBUQjKQamPloqkUsFz2d5ZVu36134TsC2t4=;
 b=kGbOzRoblO473UIJQPbR48U5KgChKJ/YSgvi72sMXUXpp8Ltgt/3W7daIj28S5J3Ve
 zYB16/V0GADO+fDGRcU1XhbS8pamL0kJH8WM8IsW1TWVLgwCGlDohNU3bs0Ztwom1Zx5
 6YFcQ+HQBNGbPwQhQOF7hAWepSkfb0UCcbUSQPVdHlRgQeBrcDXCrWS4UU5wQ6GYAxvt
 r5yUSWBdEqnQIMYbaiUPjIVrINDDGWtwHvib/n2M7bjkE/bGczsfuyE6WTDynxL0crmI
 YXtDbqE9o9TTVD8ays2YsEgPMTQ3qNlLYpd1pd9jZbqyzV6XA8aNkcdwE3FRxOM8182w
 8ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336896; x=1702941696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5CXCYUczBUQjKQamPloqkUsFz2d5ZVu36134TsC2t4=;
 b=ipuV6xuEhW5Azr3cRWdyTocaUnRGdSAeM5GQPKmswvf39kzPqpWCkZ7S2t7OC2hl8a
 uBPOed2m02CIMETUOYm6K8UP5WYFPhou9JN1LojvjrScDoUo2rNNpAeTf5QKlBIns/Na
 AL8MaVPj7U9jza2A4TJfV320lCEynv/yNNTQWMYbpEJWzlAVj1xNuubz8c6xALtSKuf9
 lrO0AkfU1LhbGz08dBcJXzxb5wAqmV3aXwcTK2hnuIhC+0O/95ReeiHb5ZO9BNIVLnnL
 5JMBrrfFoepzvmxx9IFTXzKRYKihWk1Ubm+ZhXLt3uFe6E0CNHpacCF5yZo55kjQ7mLb
 2gpg==
X-Gm-Message-State: AOJu0YzCsJlUG1g5kpjOtHsm5DYoKmdTUQgXlQ2WBg9eVMZJHDZBicQd
 8lNI15GIbRyB7NcHpn4dPEbHRqMCcGk=
X-Google-Smtp-Source: AGHT+IFIKCJhs/8v4oGGvzYo5DsKvQzApLOsBHOkMt6F1arc7d0sbQ3L9HkO1foRAfuIDauiUweo9Q==
X-Received: by 2002:a05:6808:2099:b0:3b9:e618:1861 with SMTP id
 s25-20020a056808209900b003b9e6181861mr6718081oiw.1.1702336895997; 
 Mon, 11 Dec 2023 15:21:35 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:35 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 7/7] doc: board: anbernic: Update rgxx3 to add new boards
Date: Mon, 11 Dec 2023 17:21:25 -0600
Message-Id: <20231211232125.171438-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

