Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E988D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B081F89D18;
	Thu, 28 Nov 2024 15:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MFifhSYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB0A89D16; Thu, 28 Nov 2024 15:36:55 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D53289D1A
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fc1f1748a3so546407a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732804611; x=1733409411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DCy098iPxpFCsZ5xzQJHtVc0LXUAWgnk3DaV7fywLSg=;
 b=MFifhSYseYR92gwS5Dp85GwIj+KUYAi0VkfrV7U6b9YapIUbUnmPtT6+B9yfXIgQjG
 wt6Bax9K0wnkAeKLqTA2JVNL+/XrPQ5bgo1SorhoZfidNcWBCwUyJ0/UUCRuip3RcCvv
 J86r2ymWwN3eDZApKuPDValsiYMjMjWv5/7airrHOnX63lUEwXGiDQrL+jdwPUac1MQv
 CzQKl41PHq72gXakAP/qcRuy5iEFa1ZcUW6Qpg5B6/PduRT/gFeQ0PHVQECtMN1QqzrB
 99RqRerlm6hrNMWr0pLC0mxL8Vr+WCS4m0jIUkzsPqPUv0oU/4lBtg+DjiWunZEbguj4
 xSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732804611; x=1733409411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCy098iPxpFCsZ5xzQJHtVc0LXUAWgnk3DaV7fywLSg=;
 b=aZsxJhhx1pOVnHLLGvS+/pmGG31W3QSuDZDEzcywQk1BWNlnFy0Y1MbnR+pqqZH1T6
 tb2+t+dOejiUfkeJGEIvyGzx2lxeYJlZCBYrWxfdn46ksVRwtIQMP2m9Pb7/g9DY+3ws
 CUmtQrJaJzUFDYjt+WDItW4JkbGtptUbFEl4KzELXnz/RFo/+GrOx9cDMorjH8IMlMS4
 5qOQg+wxjGxO9kM6KTCm1l1s24pl9QeuEMsmMVhJjmvjVokpnN0E8Fo0mBNXGJDwbPze
 yNVJ+DuFRd2N2ahREm5bUn2XN9aL8a060UDxgnSVHM2Rki+bSDUMAXRCT/p5sXRMsZBB
 54DQ==
X-Gm-Message-State: AOJu0Yya77XNWHLJjaudqsnjY0KlZy/qE6w1z1S1zlYhmX7Hg9XPRHYv
 hTmJZ3EKUZKF1cOEkTE/Uo84PFw8LNXIArywMpwZJltZsIE9oqOcYt/r9lmiXpU=
X-Gm-Gg: ASbGncuvafbhrMdqVL6hUwkASd5+CGwQ2CcRudCKL1x0zMgSmOMgNd4wgSM2VUHplGv
 r8PlleFUYQoEHPxGU5KcA903Jv6cxonIa+MsSVehN0rzoVMl+STUWHF/rg3I32H8qkvfxQFP3DH
 pQ447QQp4vRJ/Gn+FAvGasM9hiTCjqzIirFNG47MPKe7rb7aRg0TC638liVXRtEfmteXZUk8KIb
 wjsgervjgrEEWiqVfAY6yKfS7TvvlE67CzFzVKElo8=
X-Google-Smtp-Source: AGHT+IFQSry86XO1I+cmwRiJj24ROMfmqvz6Jbsh1ueGPt+buf78nVsl/khQd5eXcnStNF7V1XPdew==
X-Received: by 2002:a17:90b:17c3:b0:2ea:5823:c141 with SMTP id
 98e67ed59e1d1-2ee08ea02a9mr10304743a91.16.1732804611299; 
 Thu, 28 Nov 2024 06:36:51 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2b2a2ddcsm1518322a91.37.2024.11.28.06.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:36:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] lwip: wget: process legacy url with strncpy
Date: Thu, 28 Nov 2024 11:36:42 -0300
Message-ID: <20241128143642.590143-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

    Commit 356011f ("lwip: fix code style issues") changed two strncpy calls to
    strlcpy calls in the function net/lwip/wget.c:parse_legacy_args, but this
    breaks the correct parsing of a legacy url. strlcpy expects the size of the
    destination buffer, not of the amount of bytes to be copied, and it will stop
    when the buffer ends or when a null is found, but here we want to copy a
    specific amount of bytes and there is no null at the end of that specific
    amount of bytes. The change is reverted here. Optionally, all the calls to
    strlcpy(,,n) could be changed to strlcpy(,,n+1).
    Fixes: 356011f ("lwip: fix code style issues")

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/lwip/wget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 83ae8a6d15..af48d741a4 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -180,7 +180,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 
 	if (rem < n)
 		return -1;
-	strlcpy(p, server, n);
+	strncpy(p, server, n);
 	p += n;
 	rem -= n;
 	if (rem < 1)
@@ -191,7 +191,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 	n = strlen(path);
 	if (rem < n)
 		return -1;
-	strlcpy(p, path, n);
+	strncpy(p, path, n);
 	p += n;
 	rem -= n;
 	if (rem < 1)
-- 
2.43.0

