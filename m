Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCCDE65D0A
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AC3896FB;
	Fri, 22 Nov 2024 01:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dz22YL7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435F6894AE; Fri, 22 Nov 2024 01:31:16 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B62C896FA
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2124ccf03edso15362285ad.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235472; x=1732840272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvXdSE271U+p1rlkM2PYkDAO6VN1lwWGhaj7Ygulstk=;
 b=Dz22YL7qbTF3U4w8jHECH1yElovD2xL59psntMBaEdulY6vL5SE1vO0qNyzjr1nuLK
 z+0VTtQoF9cK+CnBMV3pAZKNgwkdAJLbcI5ZkuC81n2fIxjY9bt9K58g6/mKKxU3Vusj
 yznA4mTSA9+MkhH4E6VwjO+yl6kyxyCmGs3raSih34DWAJeS8UWDMsta7B3x9qJ6qYId
 zRh8Yt4QCFqaNV+GyU2wF46hB468dHf9t0NXIMQgL3Ch4JbcHyItEmw0xwg4qy7pAIW2
 8f1kr3IVFYzbgMztUT2Mwt3yP6n0Q7gPPxIbJs861pSlF3G8hwpZzpPpln8kW9NG7T1/
 Pr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235472; x=1732840272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvXdSE271U+p1rlkM2PYkDAO6VN1lwWGhaj7Ygulstk=;
 b=UvEacr7agtVMh5A+NFN5/mVGUA4omHw/P5LS3wOvFhHumuHc4bjGF2n7lLb9bA54Gk
 OoCTkjdKv46J4wnalLM9poNB8yry8feZA8wc2InGy8M0JfUr1IcgDTu5BPewTB1GI6cn
 Nv5+zDkLSnWpJuityGY1Aous/18Gd2C9UbuuclEZ3x1PztfO9O/IdWuSUxzIJ+wOdLKW
 F3jDg4aiWp9+ILlvQbXTBbKjMDMDtRT8WGPkoRIEoogyb/wQydf/5csjrd22f2wqwYY5
 z8i8nxGx4Prv2KXYfPFD6V1C1B4m2IWTR0U9FFlDAC/TcVG+4GD3MSSvw6gFuEU+c/dN
 LZyQ==
X-Gm-Message-State: AOJu0YyWtZeTtvTLLdTMnbkqTqaKpoOnlUAoARvMjQmuC85Dt8OrEjM1
 hcPoKVP80e/MX5PKKdYgh7LFVxrX40zLH71IJmWCvd+H9TAqyRAqQwSUKii7
X-Gm-Gg: ASbGnctyqjXTHnHn52wsNJSrGN6ePq4IWB+mXIAicy48QKc4+yxZKZWKwJOz9Ddcvji
 +UCM0ay8KjGbE58MsJYBQ+5Cf6SelUtese1ns8aZp/NWRF82Wns0rpTMbhCU14VgFYDR5DvCBNa
 hSdsHy7D51kCz5pQ/5lZFxX/+qHCn2Bp6ocaOx6k51PiBOoCXauLhqY0P9myrQRsguFCpt5weQG
 M/uCMqH358yu5E/oIi/oIF+C0FsbvZEb8KsLVjMvLR82F1pPGhrtr096wlKNgi0
X-Google-Smtp-Source: AGHT+IHvqgFR39Kw1k7AxzlU3VK6KEhjiX7Zgzr797hOpILVcMIvaiKawIKAZL06We6VUA9mUdZPpg==
X-Received: by 2002:a17:902:ec8e:b0:211:a6d:85e8 with SMTP id
 d9443c01a7336-2129f81f20emr10572535ad.39.1732235472279; 
 Thu, 21 Nov 2024 16:31:12 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:11 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] arm: mvebu: x240: Use default baudrate table
Date: Fri, 22 Nov 2024 13:30:15 +1300
Message-ID: <20241122003058.270163-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122003058.270163-1-judge.packham@gmail.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
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

Remove CFG_SYS_BAUDRATE_TABLE as there's no reason not to use the
defaults defined via config_fallbacks.h.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 include/configs/x240.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/x240.h b/include/configs/x240.h
index 3601df588d56..bc66e4e3c8e6 100644
--- a/include/configs/x240.h
+++ b/include/configs/x240.h
@@ -11,9 +11,6 @@
 /* additions for new ARM relocation support */
 #define CFG_SYS_SDRAM_BASE   0x200000000
 
-#define CFG_SYS_BAUDRATE_TABLE   { 9600, 19200, 38400, 57600, \
-				      115200, 230400, 460800, 921600 }
-
 /* Default Env vars */
 
 #define BOOT_TARGET_DEVICES(func) \
-- 
2.47.0

