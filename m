Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815C8C36014
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 06:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412D081F4D;
	Wed,  2 Apr 2025 08:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6gdlsmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C7E80584; Wed,  2 Apr 2025 08:27:10 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E83B81F4D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 08:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224341bbc1dso107576275ad.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743575226; x=1744180026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2NowRzm+xEc/miqb9dFZgJD0dX3+OBLoj94ZdV/Kpg=;
 b=J6gdlsmPA/gOXP6b1+yy8NZdNXTR8AqHvi7qyb5EuUMIKVhJ+SIzoItxc3WEk77SRD
 Vk8r1IlMNSHl1x5ZkYP1vE17GFzvvtDZtJCAXloryHKecUy7szqf6V5kEV9Ap678gySo
 PuqPLuYFDMcQEQkLk6AXUqhKZFCrVDLZbyn8T+8ZlLBOkCRvk7PpMr37xRm4t7VJZ1gQ
 wbaO4E26UmWMdlqRix0HlSCQedsn1q/fZykGqt7mjO9XCjILzaJxWYI4n6RQS5itx5qw
 KrUl36OmaaylBwxg2JKwzimA19QO4UU0MMyIW/iZTyy2wZY2uoLF5JKtMDC79bkvVhuY
 9DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743575226; x=1744180026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2NowRzm+xEc/miqb9dFZgJD0dX3+OBLoj94ZdV/Kpg=;
 b=g+NkePwpxV0Em7kVyC/1kdzOmVhfD2uqxgnmYs9qgyVxemJ8P1Z3erTSdLTSbkf97N
 Mdb67EmmMiQda+i2vyvhdAcz2+fe97ipAHScno5H4Uw9//udXkWCep5W9UdW2qTE/ZyT
 JSd8u+bfuy2j83RGbsORCwwcNRnEcLG2RK090zN7OTNAN+yL8U75liPMqDhp0TE+z7Ig
 AVdASESNBBH4hmc2+o156Mb3S2LgZuIgBcePZQ4Nl2AJbBwF3aV/3h63KEd7gSynHEUm
 IjKrzt33+3l9aJrbl+CmaJxmzNBNq/6jb7piYScfJC0gg7OtfhScnVhApOxnQ2VnVLEz
 Ogag==
X-Gm-Message-State: AOJu0YwjGRTW0j701exYDyFTEiXN0t7kRSQItalRlWmpdFqmYb0glGxb
 og0/1KTRqRCb6JuKXgidnvFVJfuaxgZQmiPjIHKyKnbc1Kj6iuhR5JYngQ==
X-Gm-Gg: ASbGncusq1Z5aY+2iiD8mswuFTjS4Lf9PKQoOQX23q6O0U9NnjcVb2RffNlR52MHWU7
 MurzQo7rhp6k/mxvMwtGpFnSBEPdwQuiHnvNKwlnOieqJdEfNM46UmCNP7GSvvysEELPQjCF/fM
 sLF/dLJDosdPsaShpTE4lCMwd8aWqHXn2FuN70JJVn6JgK08ter6PfZS0n1Fq70DfsrSbYAYM9+
 JQIQby/kzmVohXPfMmpDlxiWdhxbLKSOY3y6qVudwdwqirTjQMomAlPpSMICZMiS9RTWibK1E7+
 tWjiQ/QYjCSHE2nZo8W2vqj18pHmWXbT7Vh2GpoBUUmWUia8NzfieZGVNxZ0UsQp6mqPaRTtha/
 nQKlKH9IEYQxKGGEFEcdlximrFlHGU8Ogua+/uQ==
X-Google-Smtp-Source: AGHT+IGRbBENr+6xMkuDrvek/bQtR3T8Tfr9xPyLw5YlZL7e1F568ImlLdEzJ0+kOgzpB1yRc5nS2w==
X-Received: by 2002:a05:6a21:8cc7:b0:1f5:56fe:b437 with SMTP id
 adf61e73a8af0-200e4cc66e4mr2047369637.32.1743575226427; 
 Tue, 01 Apr 2025 23:27:06 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b8acdb4sm9115661a12.59.2025.04.01.23.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 23:27:05 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH 1/2] mtd: spi-nor-ids: Add support for S28HL256T
Date: Wed,  2 Apr 2025 15:26:40 +0900
Message-Id: <35b35e43c3d397509ad4ee0f1a12d948cdd3f093.1743575001.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
References: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Infineon S28HL256T is 3.0V, 256Mb Flash device with Octal interface.
It has the same functionalities with S28HS256T.

Link:https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c9484..a500fff4775 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -414,6 +414,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
 		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_S28HX_T
+	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
-- 
2.34.1

