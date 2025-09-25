Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2E4CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B24833ED;
	Thu, 25 Sep 2025 22:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="LBIeCUvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4641882A9E; Thu, 25 Sep 2025 22:52:02 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CC5834E1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62f0702ef0dso5321919a12.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758833519; x=1759438319; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nx05fhQxT6uAfj+9HbuvXQwBLDYe5dfWC3NpbbNiCAk=;
 b=LBIeCUvIK0sGjnKq/h9Y6GZ4Oe5ecZ628nk6WxkkgLWRRYaZ99uoVH6m2Pdbb/QHzU
 AGGzNFDsInsrbmIOVSP6iSLqWoUNer5q8Eup0ouCnEhqmQUystdw3KyUnYXhaqtF5x+5
 FmOFMht49pvFw1/ExfFJjMc0WLIYF3MQfw6QaTIaf5bc8xFIq+zFvvH7Lfft10DduZzh
 8x42Zv89RPdO5czG33fpWW7IYFAzeawfBIKVX+zNZaD74sG1BWMgr8Jg9H1IKvPqU32B
 o+AIs4It2r8AGMSzvUbXr3qXqboM7uQR/Xs9zdfCTZeijLbwl+LAIIq55my7PJygR0Il
 bguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833519; x=1759438319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nx05fhQxT6uAfj+9HbuvXQwBLDYe5dfWC3NpbbNiCAk=;
 b=QlcBlnHEz+CdaYIFBM0iCM9sBb15uq3NKx92jf5WJVJjYMaWCNgx6UZaa4ShUkDxMs
 zkYxYlwgDlhiW/c8ai5VkA9VslgmAymlRGxcYZzfZGZh/+ShTCc7b0I9AXcsGSHFJTyF
 I5j9yH/G7c1/b+YP3nhn9OaPyVmGYCjfwB/cvRtuzwwBEzz52oGojP6s7oD4XIQZ/VKB
 zIe6rpGwY5z356PwVc2qwX0nTidEb5itEmFlDpXgZPLpLRho46kmbSXHScU25SMTxmAH
 PRxxNsxNlscD6UWfrRKWA0TARM3Ry7pC5iNA+Y9CwQhy+jSCMsSXkPN8JmR6TFG1VFxN
 Ec8g==
X-Gm-Message-State: AOJu0YzhRolTPv9z3V2ZE/aeVmXEZWVq5op1q+EXiOnX99oBD3Dt3I/j
 hAtEIS9QZIGceFiIiSou9Uhlhb/nGRkhtHZW1+vdr8GBDN0eU6pnXv8VFY9VrQ==
X-Gm-Gg: ASbGncuizfvziv+AvHlnAqALxVIqMp2qKZYD7bPivKFHVN5peW3uuMX+wccO+6PD45G
 o5kpklbl+B/nek4Jv3YpP/cb8Lr9QUjjJy5yDNEOm/aauv0y4hgy00cCJPBIfzX2F2a1LNElClq
 WOLg9EnxJewsgnyYWr/TAdUVPIWCJu43vp6lvBXlF2T09EzV72FzWltMYgPMJ2mlGb53Fgkfuim
 uDughHJLrVlEv7e2zvxvSLCgtIOsSxH8eoC53PHUJyjr00FWOCuJ3boyNVGhA2tUfzhJnca8Gox
 Iny7tI9JrI52iYe6M+HbQi+6I6JqNmwCCwMzwlPAKzq7e1RdXFsFXE2gNekit2+IQTqUdxocxdk
 C45RemmzvdejcV946fsC7JgoreZi2g4VUI1E36Hyt+G59aWXTfQn+689K8RNEuUp9schMhfiqb5
 esotE=
X-Google-Smtp-Source: AGHT+IHE4I4QpXHX3O64nE9ssWlUtlx06e1/m5cYXC5GnLzXjMeNeenigzNv4r+MBLuQbdBuQuuBmA==
X-Received: by 2002:a17:907:7fa7:b0:b2a:47c9:8ff5 with SMTP id
 a640c23a62f3a-b354a8ad592mr432455766b.10.1758833518540; 
 Thu, 25 Sep 2025 13:51:58 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353e5d014csm229554366b.19.2025.09.25.13.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:57 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] spl: nand: initialize writesize for am335x
Date: Thu, 25 Sep 2025 22:51:50 +0200
Message-Id: <20250925205150.453502-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Initialize mtd->writesize in nand_init() as otherwise
nand_page_size() returns 0 and this affects NAND read
operations.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/mtd/nand/raw/am335x_spl_bch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c b/drivers/mtd/nand/raw/am335x_spl_bch.c
index 4b50f351d35..a77206d3815 100644
--- a/drivers/mtd/nand/raw/am335x_spl_bch.c
+++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
@@ -212,6 +212,8 @@ void nand_init(void)
 	if (nand_chip.select_chip)
 		nand_chip.select_chip(mtd, 0);
 
+	mtd->writesize = CONFIG_SYS_NAND_PAGE_SIZE;
+
 	/* NAND chip may require reset after power-on */
 	nand_command(0, 0, 0, NAND_CMD_RESET);
 }
-- 
2.34.1

