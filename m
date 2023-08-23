Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4108C79F6B
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C52864C1;
	Wed, 23 Aug 2023 18:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bgpu6XL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F393586467; Wed, 23 Aug 2023 18:48:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F008F864C3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bd0c953fd9so3833078a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809286; x=1693414086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JQCCOiL9CY0VpvCGD3c1moaNFvFJAGXuLxmp7hknjU=;
 b=bgpu6XL6GPVaNtcbWGOUnOV4x8uuMwMagPDg0HO1DzBTlxd34dLSSw23Ra/p2V/hnB
 EixF2Xv1Lbtu185B2LQyfU0LbpK+DL0vVjiAW8QbH0WLclSf2HhNxqs+zWJBvtjG/Cij
 qAQEzbErAXORZxmbfAY/FDdyrwjHeMM3D2flnI/lcyFqpXlhWlcKtpuM89oSXoF10mtv
 WeW2phtralj8Qj26HomeXjRZQsmVaPwdvd95rc8+1HEhuY2OFHX5speyd0ItMEz5tGGb
 EvaGBliKCD1TvUGA66M/yiU+ORQGXG+TTida7iy13kGe/YtwM6+zr7vKLUBMCYuyYeAD
 rbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809286; x=1693414086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JQCCOiL9CY0VpvCGD3c1moaNFvFJAGXuLxmp7hknjU=;
 b=GOq4wdXJFGVzPR+plx4FlGkj2DiUGLYTm72OwhotN70HPzWJESsapwriS6ktP25n7p
 OV/7ghMngQHgmaFniwnUTAgt4dED8QWIJM8ulXu2IL1bMg8CEznaUf80NhOcL/kkP3cK
 xjP4XJ3knicOS5ci4mpjyteuTR4mTWB1Xxf91G8VO/5SFdt8T+0hU3Dr4U37mgyq87Ky
 A26F1VFRJt5LKDPvNRQLOdBykUENgZO5T83F69QS3zPiWeFWdPe1lmpRdt4ocz+mLLPR
 yqf+L7ner2lw1XEhFyaz5tWdzYvmv9rez573OI8EckFDBT86IuvznV2loyS/o/EMDnjV
 ExZA==
X-Gm-Message-State: AOJu0YzQ/CyePLaWkelBlVqU8ikvXPHL2CEGVn8nGQ2pKfo9Vl5Kpoo8
 j/VBMNpLB9HLMBMb61P9G77nM5JGRq0=
X-Google-Smtp-Source: AGHT+IFUl9PC+G7be2BATkDfSZWY1ZbMoHvqiWu0SI1vJ2h5WSRTCGVIFP7GbLbn7MWhNMcztM1uUA==
X-Received: by 2002:a05:6830:1690:b0:6b9:8feb:8337 with SMTP id
 k16-20020a056830169000b006b98feb8337mr12598114otr.9.1692809286021; 
 Wed, 23 Aug 2023 09:48:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v2 1/8] cmd: gpt: Remove confusing help text
Date: Wed, 23 Aug 2023 10:47:37 -0600
Message-Id: <20230823164755.2874792-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230823164755.2874792-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
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

This help text appears to be a fragment of the text shown when
CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 007a68eaa7..e6f7b0319a 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -1060,8 +1060,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	"      gpt_partition_name, gpt_partition_entry\n"
 	" gpt enumerate mmc 0\n"
 	"    - store list of partitions to gpt_partition_list environment variable\n"
-	" read <interface> <dev>\n"
-	"    - read GPT into a data structure for manipulation\n"
 	" gpt guid <interface> <dev>\n"
 	"    - print disk GUID\n"
 	" gpt guid <interface> <dev> <varname>\n"
-- 
2.33.0

