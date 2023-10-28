Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7071EC4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 22:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A95287794;
	Sun, 29 Oct 2023 00:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LWEI1f4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BFE8779C; Sun, 29 Oct 2023 00:57:34 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B698775C
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 00:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778999c5ecfso243912885a.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698533850; x=1699138650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RbuDGf+ket1MmVPUMTmZx1+oCEOX4DTW0O5XtlWc+nc=;
 b=LWEI1f4O6hQbVx3sEdix0sRPZU+zpTKp1+tdwS/+JJ/mwns9si/70lXwUETFvtwQmh
 +WecihzewANI0rl1VrzL+j+D4JW10SVq8PRibl+MKJxcaCfHrPk6AoHUT7jQ/VfIsTT9
 a7KOCO817r+PbvLEXazRaHsmI2OMJ8pDSieXxqUMXmBGYl/zqR+xiDdmfRTpjrVLJvsS
 lMgqSBG9c1ZNEUU0vUenNgYcmHspQ41T3Q7zf7f+1mT/ULuYC6YkZGwYxJ7JYBbJ8Avh
 RoW2rZBUBvlc9FWtnq0MgE/GhG8fzqNC104j6n5QBteoMoTsiJfp4+6E9jeFTxAqzYKu
 J7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698533850; x=1699138650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbuDGf+ket1MmVPUMTmZx1+oCEOX4DTW0O5XtlWc+nc=;
 b=adZJLJfS6fh3jitvsBPBjxPYhLTVtzQrVNYMEHwOgcypH9E35q0gefIV9w9B+zMHUe
 1FC2LbFmrswhIcmWwLoiq+gOohU3YXjxHSPoQuo8C19E+LnvK/mcHwrTTZzfXfw+eUjW
 JhYL7XzFShRO+gEFxI1+EJUGrHkXT8ZYYKButwBZSa3GzucgZMxSVOBW/80GzcISDTvk
 GCn45V8lhXTb0JbWgOH/DW8T6QbN+nJ/A4Dl60K3z6lo34PhhHpfe1ZWxshVlyQU5F0f
 IzvZGc59Ml3EwXe2I4rw9YbxNkz5e6bfRcOGmoedQWYB5c6ucqYoHbCZCQ749OGczriU
 RYQQ==
X-Gm-Message-State: AOJu0YyWm+oqhmJ3DSa+QJd/HQESVacOn4h38XNjM9gPN0cwFy98tFLU
 011S1MzYbQk5YGrJyY5mCQA=
X-Google-Smtp-Source: AGHT+IEFqcAMo4EONw4koUFr/Bt2lVQ4qi5gpBSJthr/4Vf9HfT74aH0fuIqYomRyzrxZ6m8XsyArw==
X-Received: by 2002:a05:620a:27ca:b0:770:9e5b:e1e7 with SMTP id
 i10-20020a05620a27ca00b007709e5be1e7mr5756014qkp.62.1698533849817; 
 Sat, 28 Oct 2023 15:57:29 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 r29-20020a05620a03dd00b00767da9b6ae9sm1923825qkm.11.2023.10.28.15.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 15:57:29 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] test: eth: Don't crash if env_get returns NULL
Date: Sat, 28 Oct 2023 18:57:27 -0400
Message-Id: <20231028225727.1046361-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

env_get can return NULL if it fails to find the variable. Check its result
before using it.

Fixes: 6d9764c2a87 ("dm: test: Add a new test case against dm eth codes for NULL pointer access")
Fixes: df33fd28897 ("test: eth: Add test for ethernet addresses")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 test/dm/eth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/test/dm/eth.c b/test/dm/eth.c
index d05d2a9abe1..bb3dcc6b954 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -263,12 +263,16 @@ static int dm_test_eth_act(struct unit_test_state *uts)
 
 	/* Prepare the test scenario */
 	for (i = 0; i < DM_TEST_ETH_NUM; i++) {
+		char *addr;
+
 		ut_assertok(uclass_find_device_by_name(UCLASS_ETH,
 						       ethname[i], &dev[i]));
 		ut_assertok(device_remove(dev[i], DM_REMOVE_NORMAL));
 
 		/* Invalidate MAC address */
-		strncpy(ethaddr[i], env_get(addrname[i]), 17);
+		addr = env_get(addrname[i]);
+		ut_assertnonnull(addr);
+		strncpy(ethaddr[i], addr, 17);
 		/* Must disable access protection for ethaddr before clearing */
 		env_set(".flags", addrname[i]);
 		env_set(addrname[i], NULL);
@@ -312,12 +316,16 @@ static int dm_test_ethaddr(struct unit_test_state *uts)
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
 		char addrname[10];
+		char *env_addr;
 
 		if (i)
 			snprintf(addrname, sizeof(addrname), "eth%daddr", i + 1);
 		else
 			strcpy(addrname, "ethaddr");
-		ut_asserteq_str(addr[i], env_get(addrname));
+
+		env_addr = env_get(addrname);
+		ut_assertnonnull(env_addr);
+		ut_asserteq_str(addr[i], env_addr);
 	}
 
 	return 0;
-- 
2.37.1

