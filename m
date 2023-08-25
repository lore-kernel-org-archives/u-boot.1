Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302E7C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014FC86AE8;
	Fri, 25 Aug 2023 21:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r5Zc30c6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01D886AED; Fri, 25 Aug 2023 21:38:40 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EE1586AE8
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1cca0a1b3c7so822040fac.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992316; x=1693597116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JQCCOiL9CY0VpvCGD3c1moaNFvFJAGXuLxmp7hknjU=;
 b=r5Zc30c6IcRiNe7hcxB1K0Feb2r0o2t9uZ4F3Ikk27A4QwbwwFCOkUtW2Ptk2Sq5lM
 LHTGQ0xW1J8wYsz1c0FPC839RaHjOM5Tv48ilZ0ZQv7LTZkuK+x/Y+dWAL4BasKz99gx
 vdvPxc5Jp7F9BEkeWt669fVpyEikpmoWzj8SEXoGp910vgW9FagnNDEzWV2thEiKxPD6
 nYWVDivu3erPLijm6uoBNuH9hbB9X+knNyAKp249PClPd6EQK3qZ8g8kG7uBVJShQs2G
 MA0zOpo8aWrseeQ42iwxFlrTZmuoyOxIzk/hEdatxOhIsttbq9TXosCYODvKO0H7Z7H+
 NvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992316; x=1693597116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JQCCOiL9CY0VpvCGD3c1moaNFvFJAGXuLxmp7hknjU=;
 b=F+3kEgEo1zmSxmr3PnSVA6TI2s9G6R/QMIYAeqyJ8oS0QrgRyFOgCO53xckAhR0HiY
 4DzDCovGuMy6LVNCxOMDHpcDwAu58vuZHAuH//D4QkQnHCsUmQvbX5mhdSZ1sjW8fsZE
 xcdeCHX9jmXDFsmW2quf+z5RUu/fUZ5ByTAmTvhThitfB8Jx+V3ir8+eFH2ZMMjeLRiR
 wYI0401o0Opuy+cbnhxDqy4aKk/Y8/xcPnvPZdS1rV9G0YdFHr5TQ4LeYaHGDc0CqEdM
 0oOTEnTi+GPYa9NIJDsZSjJbTEukHbk7NEQm0GM/rBP+rXDPjiDXycM2FnPyWtGqMmm8
 Xayw==
X-Gm-Message-State: AOJu0Ywy87Z7mEnjXuNSyUUfPgjGz94rNMGhiLDocLKoBQzSM/8nIorN
 E2AhuE0LgM/eR/r7zfzQEupax0wRvW8=
X-Google-Smtp-Source: AGHT+IFnX6RwmV4Y1MVbpq7rLICu7cKq1iAJk+kle1W85XnxF3bJoD9Sgfffafj5J4KZQMIsQADIhw==
X-Received: by 2002:a05:6870:ac29:b0:1bc:c06b:9a80 with SMTP id
 kw41-20020a056870ac2900b001bcc06b9a80mr4374212oab.3.1692992316268; 
 Fri, 25 Aug 2023 12:38:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:35 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v3 1/8] cmd: gpt: Remove confusing help text
Date: Fri, 25 Aug 2023 13:38:17 -0600
Message-Id: <20230825193830.2753640-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230825193830.2753640-1-JPEWhacker@gmail.com>
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
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

