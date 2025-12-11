Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD1FD43356
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 21:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ADB837F2;
	Thu, 11 Dec 2025 22:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j0W23AEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD66683837; Thu, 11 Dec 2025 19:32:09 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA218036B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 19:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-343774bd9b4so341678a91.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765477916; x=1766082716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CWbMlWvo/qRA1JhdIMMUxF2LxOCtIq4LqO8J1707wCM=;
 b=j0W23AElUR/D54SNvYRsZTw9pfYP3Q8+oERTaW9E8nfugAJtmkgpFuEKleeN+aFVz9
 uAukXk1uFAnllX8Hy5OGm+fnRldnWcMidkRmWXN/c4fDC35ZFo79w4A2/d+gzRUXfh8C
 v/NCzBphge1qsqA38EXp54lNPsiIvhBBL7yAggGXU5DLUbir69FkLG9jSmTN70QnKj8u
 4vBeNE6xzt7QWfBU5y94rsS4hGq0ftg/63PLZArh7dNOBnbqLQcGiwhDiFVmvdrBENDK
 g53LRN9PGvNxHro5K5VE9ym1lKAn0J2szXEtewPY2u6sBxEKSG8SIhcgYkRPlDd6aG7k
 4bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765477916; x=1766082716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWbMlWvo/qRA1JhdIMMUxF2LxOCtIq4LqO8J1707wCM=;
 b=Cjlxf1SqNO1L0v6+m/a/fXPa9BrF/iXcS0QZ7YpAWNB6oTkpFAc7GcCk3nfkP3hk6g
 PkdCfV8QDAILBJXrF4mG/Yi6v3d9XMSmHHlceyPzI6CUuIAF3dOFQAKOTHoOAP5hsXZZ
 MkSvWu0Yi+c3ueM9B2PSJNIA17Vuwfs76aIESh6GhXQDFNBgSAS7litcPD08xpPDEwxs
 S8t9Ou8HBbz4Q2791gEtXxKnKiJp9JNdos9LssA4VXI3mob8t3zQ5B78BGiOR545lpZH
 CY53rAwoak64zjEhHv3T2umZzMmuekS5EhB++qEJK8B3ArFNJRCypz8WN95q4nMdrHCz
 SlaA==
X-Gm-Message-State: AOJu0YzTHAoHzCXhFrNyd05IbSuAA25G+cNn8l9k8AVovSxu0f5NJW/z
 IixSdeiGBJMoIFM3J6tyQ4aFJOzq7949Dg0UWflZLCPa5nIEg53rpJoV
X-Gm-Gg: AY/fxX767vkO+X4lcS27NyWPSI6Jxo778m7o7Qd84Te29rzVW217Kxv4fbLHaowrsmB
 1yJagi+A21+v1/4i8tWDhTrOlLpDNWzdPthZF8VRFGzjJvpzmGBfQ624I0efIF/WLQNOwyz3T+K
 VxU1VolquUhXRD1rcGfruS6EH2qZ6d+NDiQY4dGlC/wXAC7qG/LweCcLuMlPxNsNeGYGtTFIkIF
 2b4/p5oM7OdzbvpbhB7VPAdh8w1gJfkEx6vtM4kYt9X25yh0D2yU245CXCABvwonhGAk2OkqaE2
 ow3C2W8GzCnfAmj/g4xmmTfNGWnKtn/ZL06nFZIlHU+kCtZv92v4XIdoUw/DfutBn1h1meoYMRv
 K+GggldsBW4XwsMsjDClnLnvOdbOxPsfiZZRSK4r1hYRmSqNxVUjgboCF2eqwEra+Cm5x1gd3sR
 kL3YpDp69ATebojRyA941VQgNnRIhXE3cPEfpq15K8N2qUjz5ROPDkFy7E9+UcWtMnAqbXq0m5+
 rQiy3ugirR5ZFIppS27cEBP
X-Google-Smtp-Source: AGHT+IG28a8Q5bEmnmENxkYTAFsDfNqTf2jhVBhnyFf0Olq5hUBDrTU4HarjxmTFeX0wL+RWE6NMfg==
X-Received: by 2002:a17:90b:2d08:b0:343:eb40:8e01 with SMTP id
 98e67ed59e1d1-34a728beb0dmr5899084a91.27.1765477915668; 
 Thu, 11 Dec 2025 10:31:55 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (14.250.194.35.bc.googleusercontent.com. [35.194.250.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34a9275474asm2563232a91.16.2025.12.11.10.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:31:55 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Ching-Chun (Jim) Huang" <jserv@ccns.ncku.edu.tw>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/bcd: optimize _bin2bcd() for improved performance
Date: Thu, 11 Dec 2025 18:31:30 +0000
Message-ID: <20251211183130.3442378-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Dec 2025 22:20:37 +0100
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

[ Upstream commit cbf164cd44e06c78938b4a4a4479d3541779c319 ]

The original _bin2bcd() function used / 10 and % 10 operations for
conversion.  Although GCC optimizes these operations and does not generate
division or modulus instructions, the new implementation reduces the
number of mov instructions in the generated code for both x86-64 and ARM
architectures.

This optimization calculates the tens digit using (val * 103) >> 10, which
is accurate for values of 'val' in the range [0, 178].  Given that the
valid input range is [0, 99], this method ensures correctness while
simplifying the generated code.

Link: https://lkml.kernel.org/r/20240812170229.229380-1-visitorckw@gmail.com
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[visitorckw@gmail.com: Adapt to bin2bcd() in include/bcd.h]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/bcd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/bcd.h b/include/bcd.h
index 9ecd328284e..289810b99b7 100644
--- a/include/bcd.h
+++ b/include/bcd.h
@@ -17,7 +17,9 @@ static inline unsigned int bcd2bin(unsigned int val)
 
 static inline unsigned int bin2bcd(unsigned int val)
 {
-	return (((val / 10) << 4) | (val % 10));
+	const unsigned int t = (val * 103) >> 10;
+
+	return (t << 4) | (val - t * 10);
 }
 
 #endif /* _BCD_H */
-- 
2.52.0.239.gd5f0c6e74e-goog

