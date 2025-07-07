Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADF3C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9585581D5D;
	Mon,  7 Jul 2025 06:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gyeu7IY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3418182958; Mon,  7 Jul 2025 02:22:09 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111B281D5D
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 02:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40af40aeef6so925875b6e.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751847726; x=1752452526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=696/eq1CGwh72in3PdeElMJzjKvGsVIqukx9KliDy5Y=;
 b=gyeu7IY1LqhHLyMmrHn6FtgZ13NXGsKf3kAa7s8G6EDEzpXOjiiwlwjwRM2nu0ZdiI
 XdU88sCnAjunVFwTxp1NrBctaruVAeXiLp7FMTmZGwD6sroDFUYQo3sy0aq1nvUMFeGC
 U/lFGKHRk8de5j4uU56WFR93FAJxP/Y622Ebqs+eJQX6T79YQ41Na1NTBJpeZ6hyWbKn
 7K2Yy33xmUMPoTnihLbii8FyIFAikaDxJBzracmHg7b0QCWnAWY831RDXgJ/QmKHtkIu
 4ffgGvvAzt+u1lkr++9X2lppVeVkkMe6qtrmNv13rCT2EhG416xnhq93PQFnsE2Q8JQ0
 qlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751847726; x=1752452526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=696/eq1CGwh72in3PdeElMJzjKvGsVIqukx9KliDy5Y=;
 b=dHD14AOTw1dyPYNADYsPh3m5kco8k8HLb/n/lBvOMgNoXQH4BZPArWf33AtYPrRC/n
 9NMCJcG+iR5elguM+R2oYEhhT1hzh4TqL5ZHhlZr8CbBVDM1aG/yY2iVsE1YoQf+szB0
 FhXvHWeXNViHnOlKaI3ODN1k9INlQOgzxRSQOHc/zJG5xO15crZT+gzIIftOaTY23uNX
 117j/DJss52yyxBECvzy191IBUo9m9MGf2GUuAoS3Tz6SzD/nK9obqNn5zujOvWkN0ML
 N7ft8fP0N1zFXr5mnf3lx2NUiKWks8fA7l5rQwtMDxCIa4LEG0HRvtbXTl/XukZvxG7t
 OpHA==
X-Gm-Message-State: AOJu0Yw1u82ENUoITNovoX0cOVr1GjMZ3WE+Xr7ap7lLgwBZi2F62Ixo
 wdx5pexsH7zAmR4hAO+B1RFN72nNFhYHzrBu6Xc4wV7ueDqUDzQF6FrML+9O5K4/kkk=
X-Gm-Gg: ASbGncvtZsWH7rRdXb3PLleM+Eedv79WaYctVEj819lILgrb4FXER1oGGcPKogKtxOb
 IozLaL4yifee72UcKrewnjgBNSKvAOjbhH43ggaeBihGzu2bB/yqSZJzoKTjBVOAYprYePAAXsp
 RKm80uGraym31VWai+VLjjNazEm2Dt1GF1jZib2y8bMEqnsvCxsKkG4+egUERAQl4cAPDFdQ/wQ
 cZwewHEBIAwl5eGjVuvyWizgT9VaV9d9VPs6m+h6cSJz4+pqwU7by6mA1PLVbz8JyyTTLmJBoGj
 CKnZR2/UBpIl1KZ+c+3qRAZZGG/J2OYdMPz08AgMvvGkMt6nFlKT3GmS38u1peNhmuOZHS9S9hK
 J+AUR3jCLGXD4r+aa3svpPYUwXSSqzDEGrA606KI=
X-Google-Smtp-Source: AGHT+IGJfbRQDYOGatAE79L/ShglkS2so/H+lAfFGeQhN8C3ayUlPARbrxaQnRJ8QoPV60TKJAor/A==
X-Received: by 2002:a05:6808:1986:b0:40a:ca13:14df with SMTP id
 5614622812f47-40d2dcfa963mr4895275b6e.32.1751847725567; 
 Sun, 06 Jul 2025 17:22:05 -0700 (PDT)
Received: from dva-Latitude-E6440.lan (syn-024-027-011-011.res.spectrum.com.
 [24.27.11.11]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02ac77e9sm1095213b6e.36.2025.07.06.17.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 17:22:05 -0700 (PDT)
From: David Zang <davidzangcs@gmail.com>
To: u-boot@lists.denx.de
Cc: David Zang <davidzangcs@gmail.com>
Subject: [PATCH] Fix autoboot countdown printing wrong
Date: Sun,  6 Jul 2025 19:22:01 -0500
Message-Id: <20250707002201.62932-1-davidzangcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Jul 2025 06:23:08 +0200
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

Originally when bootdelay >99, the countdown breaks. Setting bootdelay
at 101 or bigger will trigger this error.

Signed-off-by: David Zang <davidzangcs@gmail.com>
---
 common/autoboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/autoboot.c b/common/autoboot.c
index 0a254498d40..e39f4a32f95 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -410,7 +410,7 @@ static int abortboot_single_key(int bootdelay)
 			udelay(10000);
 		} while (!abort && get_timer(ts) < 1000);
 
-		printf("\b\b\b%2d ", bootdelay);
+		printf("\rHit any key to stop autoboot: %1d\033[K", bootdelay);
 	}
 
 	putc('\n');
-- 
2.34.1

