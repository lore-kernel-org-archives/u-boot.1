Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89291CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 22:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD13F8820D;
	Thu, 28 Mar 2024 23:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uIkP2GIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C660B87D43; Thu, 28 Mar 2024 23:29:56 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6D78820C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 23:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e675181ceaso875329a34.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711664993; x=1712269793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqiti0bNe3BX+VY7a+1ktOo3ZCQegloD5+euTZJ86L8=;
 b=uIkP2GIOtyMrMuTa21Ju8eBBvWVmMnf8FkO1t3r63tn1IJkTABiPp3f+3XZpCD73b/
 YLUZbBBx0H2n4DVC64JQkGL25+njpLY5lOmK8n5PamMnifHgf5lvDy3a9yett3PD9bOI
 1WlD5nTnOFM9D/0Nf9aORFc9BJVbyJSq7AhHp2fE6KPSUNr79oQgsblvQoBagbKuqG78
 o524knfo3HhUFtjwUrLmdS4vIgPS4wJiW4ZFOHMlTAY9LTedr53xmVkiiC9zU3Q0vy8w
 +UnzQR4fk5MRcMVuqwNA8xo7zMmOMHY2mcH93G0wsoMvPzaAo/1U0Bwpy+0CzuV9AA8r
 wH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711664993; x=1712269793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqiti0bNe3BX+VY7a+1ktOo3ZCQegloD5+euTZJ86L8=;
 b=b/ssidGw03HY2cfw5QOtVjmBx26onou1m18yJSeW6E0RhOrneUklQq01Bf8LiVpitf
 Sn3hHrc/FN68IBNqoLYWt+ZQFUBFJv9dRx+YCfF/sMgOTRZVOt/iv8A2wsAGJRZoflJ7
 j1LuSriybOx/4mew3sh6LNe1fh/n8rSKvJR7KN8B72jQnCC0Gw7M2b7GNqFZZlit7C0b
 VM7qZDN8UIvMmnOLH9qA7AuxWUBYGXImGzpwwm8fgEhz4qShKkKDMK0EvB5fLlcM/grm
 LvzWEqBt4/ablfDJ1nB4sq62Nnm8Yv+OSt0+0ycAWyPIT9P9MooegzZDiaHvE2IcvbB5
 HR5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQuXJoqhRTHiKW29OfBunf1Irb0+JcAp4FoXti//t5746gAZ/xlTkTCPpF2khrN/36FKTUw/7+3jW4DTPnBDz05A4vxA==
X-Gm-Message-State: AOJu0Yzhl4q60AUdAE7cOdRGgdEiIObRB7u1T6/sXK8tnMzavJ42vR4N
 JrIPjx7flpSKRXs8NbJhHt4jS0xfrvWIzIwHRSK16UENOX8biwa7C0kN29vwJxyEJK1Em7O7089
 m
X-Google-Smtp-Source: AGHT+IH6dAnGQuTJ4vG51erYrfNZbKXahuk3dMBfaiBlQQcAz8DlaZQnrurs6NYCRtDfBvHeLVTBzA==
X-Received: by 2002:a05:6870:51b:b0:221:91dd:6ea6 with SMTP id
 j27-20020a056870051b00b0022191dd6ea6mr536482oao.58.1711664993084; 
 Thu, 28 Mar 2024 15:29:53 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 fs14-20020a056870f78e00b0022273a66aadsm610497oab.34.2024.03.28.15.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 15:29:52 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, Steve Rae <steve.rae@raedomain.com>,
 Petr Kulhavy <brain@jikos.cz>,
 Richard Retanubun <RichardRetanubun@RugggedCom.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] part: efi: Treat unused partition type GUID as a valid
 case
Date: Thu, 28 Mar 2024 17:29:51 -0500
Message-Id: <20240328222951.11431-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328222951.11431-1-semen.protsenko@linaro.org>
References: <20240328222951.11431-1-semen.protsenko@linaro.org>
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

Some platforms use the "unused" (all-zero) GUID as a partition type GUID
to make some partitions hidden from the OS. For example, Samsung phones
and other devices often have GPT partition tables like that, created by
their "gpt_builder" tool [1]. All partitions with FILESYS=0 value
(second column in [2] file) will be created in a way that:
  1. Partition type GUID will be all-zero ("unused")
  2. Attributes[48:49] bits will be set to 0 (whereas non-zero values
     mean the partition is visible to the OS: 1=raw, 2=ext4, 3=f2fs)

Although it's true that Linux kernel verifies the partition type GUID to
be non-zero (in block/partitions/efi.c, is_pte_valid() function), where
its U-Boot counterpart code was borrowed from originally, in case of
U-Boot we want to handle partitions with "unused" GUIDs the same way as
any other valid partitions, to allow the user to interact with those
(e.g. list partitions using "part list", be able to flash those via
fastboot, etc).

[1] https://gitlab.com/Linaro/96boards/e850-96/tools/gpt/
[2] https://gitlab.com/Linaro/96boards/e850-96/tools/gpt/-/blob/master/gpt_layout

Fixes: 07f3d789b9be ("Add support for CONFIG_EFI_PARTITION (GUID Partition Table)")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 disk/part_efi.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 4ce9243ef25c..6b138abae0a6 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -1166,28 +1166,17 @@ static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
  */
 static int is_pte_valid(gpt_entry * pte)
 {
-	efi_guid_t unused_guid;
+	/*
+	 * NOTE: Do not check unused (zero) GUIDs here, it's considered a valid
+	 * case in U-Boot.
+	 */
 
 	if (!pte) {
 		log_debug("Invalid Argument(s)\n");
 		return 0;
 	}
 
-	/* Only one validation for now:
-	 * The GUID Partition Type != Unused Entry (ALL-ZERO)
-	 */
-	memset(unused_guid.b, 0, sizeof(unused_guid.b));
-
-	if (memcmp(pte->partition_type_guid.b, unused_guid.b,
-		sizeof(unused_guid.b)) == 0) {
-
-		log_debug("Found an unused PTE GUID at 0x%08X\n",
-			  (unsigned int)(uintptr_t)pte);
-
-		return 0;
-	} else {
-		return 1;
-	}
+	return 1;
 }
 
 /*
-- 
2.39.2

