Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A1CE7A8B
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 00:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E0586BE5;
	Mon, 25 Sep 2023 02:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q9Cv/HWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0203682BBF; Mon, 25 Sep 2023 00:30:46 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A9786AE6
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 00:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharth.prabukumar@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77421a47db6so151245785a.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695594642; x=1696199442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RAKN+Xj6ArB6lr74jApbke7gxvdBN28RKpdAZa/nO84=;
 b=Q9Cv/HWHj644bXPoGOAvZkuERPCkPRxw1FzJjNeTvUDvtamF3JrRNea5ORkVs+9bn9
 YFSxFQKRYPti4soxsUcstUaYpsm3hHNHcpfn4MnRaXRPmY5Or+mt4QBSjQ5eJh5Fb6ms
 Dubr7O0k2uidiS44zfygeSIoGNN+lndm+tb60rUxOTQyzMx3EmWNI6m0+CKWjn6+HI8W
 2tlyU03yOvsyaajS0WgyML3TeF9mJv44CiRP4NtLp8STlzb///Nw1SNnfB1HgUJwjH1z
 J9K1imqNOJ8RN6NBgWgi3zhHmfQB2U7/u0GN6U3kXAdTXCwB6rMUMP/POs9yVLDDarjD
 Om/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695594642; x=1696199442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RAKN+Xj6ArB6lr74jApbke7gxvdBN28RKpdAZa/nO84=;
 b=HC+nfaw6zVeKDDHbN3g9ixzeydHKZAHmQiu49jghQSZJQde/gZrJ2AnDzKXMyYJHKN
 zInUu8TMuHH6pgBOTOFMtADZ3PohinwQCbB9wNrFCWGCpY86lMAKi8djB6Z78FYPxuUW
 LF5bT/sr3iuas885U9pnYzD1zfyr+TRA/e28wbbsCer/p2n1SaMyaPbu3KDpE/S7xE3U
 zmhgDaObpysN0fu6ZklmZWm81dr133kF1XdwG5b2Vk7v4VYyRzyR+CGiTEExJQ0Tmr1s
 oRTleJxbV+ULnPeHX0MtbxIFMS0eS7Jdyb9esELIiSSWZbrIHTND2MCUnD0Ky5d8GnMf
 CbKg==
X-Gm-Message-State: AOJu0YyGXmrQdjL02a4iema2ccPiHlCqry2uHEJlt4XeLbuHDg0Ln4na
 4rFsV9SL/UuhfIHrOnFWYz1nhaSkuaTUKw==
X-Google-Smtp-Source: AGHT+IEMU7a5nFZkLGHa/GP8o/J4wshUuJOUuKqjTpT0AJIvG2QqEDCj5VZ6/unkCtKSDDxh/6Dw4A==
X-Received: by 2002:a05:620a:222a:b0:774:15ef:5deb with SMTP id
 n10-20020a05620a222a00b0077415ef5debmr4053425qkh.35.1695594642147; 
 Sun, 24 Sep 2023 15:30:42 -0700 (PDT)
Received: from sid-ThinkPad-L390.lan
 (2603-7080-c100-c786-533e-9c45-37c6-24c0.res6.spectrum.com.
 [2603:7080:c100:c786:533e:9c45:37c6:24c0])
 by smtp.gmail.com with ESMTPSA id
 27-20020a05620a071b00b007659935ce64sm3293784qkc.71.2023.09.24.15.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 15:30:41 -0700 (PDT)
From: Sidharth Prabukumar <sidharth.prabukumar@gmail.com>
To: u-boot@lists.denx.de
Cc: Sidharth Prabukumar <sidharth.prabukumar@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] power: mp5416: Fix LDO SVAL for MP5416 PMIC
Date: Sun, 24 Sep 2023 18:30:22 -0400
Message-Id: <20230924223022.313107-1-sidharth.prabukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Sep 2023 02:53:48 +0200
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

The MP5416 PMIC's LDO set-value formula is incorrect. This patch fixes
it by using the correct formula.

Signed-off-by: Sidharth Prabukumar <sidharth.prabukumar@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/power/mp5416.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/power/mp5416.h b/include/power/mp5416.h
index dc096fed3f..4326baaa42 100644
--- a/include/power/mp5416.h
+++ b/include/power/mp5416.h
@@ -32,7 +32,7 @@ enum {
 #define MP5416_VSET_SW3_GVAL(x) ((((x) & 0x7f) * 12500) + 600000)
 #define MP5416_VSET_SW4_GVAL(x) ((((x) & 0x7f) * 25000) + 800000)
 #define MP5416_VSET_LDO_GVAL(x) ((((x) & 0x7f) * 25000) + 800000)
-#define MP5416_VSET_LDO_SVAL(x) ((((x) & 0x7f) * 25000) + 800000)
+#define MP5416_VSET_LDO_SVAL(x) (((x) - 800000) / 25000)
 #define MP5416_VSET_SW1_SVAL(x) (((x) - 600000) / 12500)
 #define MP5416_VSET_SW2_SVAL(x) (((x) - 800000) / 25000)
 #define MP5416_VSET_SW3_SVAL(x) (((x) - 600000) / 12500)
-- 
2.34.1

