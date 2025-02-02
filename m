Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81C3C02190
	for <u-boot@archiver.kernel.org>; Sun,  2 Feb 2025 17:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915B8800CF;
	Sun,  2 Feb 2025 18:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8RPLULd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE0A8003E; Sun,  2 Feb 2025 18:05:51 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B258003E
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 18:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53f22fd6832so4020096e87.1
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738515949; x=1739120749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VZpLxSRWTa9fzZkltjnp72HX/h1eCfcq2bZvndVlc6E=;
 b=F8RPLULdaWV8uX9n+ckW/GeIlYTarqtbmB6pduugJm6Trd+dkKy3UA0uwm+Vff2kLl
 2mOZzwt78cq7jmHu9QWgK+27swpCtfGng8Ps3JB9bTYXj5B0fXXIvx5iXIQMoDeDYH6S
 xassUp/QvEwM7SEFSipJZf64kX5qU48mICkh0lvweVfL4B/YmzuON3uIkOyR3U3Xm9KO
 AlW13DHOZ3swDAXJ4UqX4W4NmQ8ZHNELCl1uHPbEitN+Q90/TNJKG672/kDdWDiaIwX6
 Ol74SPPUilfC8PxwIAKd64LeMkl7Tq7vYnbxksUJg3jSLq/6/ftMjMYLI5BZw3IcOchv
 UuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738515949; x=1739120749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZpLxSRWTa9fzZkltjnp72HX/h1eCfcq2bZvndVlc6E=;
 b=XHI0kCqbJS+GxJEezEO7BaISWJCJgZkBlv53JyrF/1BZLOnTpEeKRlol3heAmK/cbm
 8IciZhknfuF1lxXHm+lpT/sldfnH/c2RHTdHJDFrP66dQe4NQI8QaN0yNwxStXb1Gm7o
 usxVHRANuuyB9Mh9gGDB13R9NoNEbp05Ujp+uWO3DmdtXRW1km76vJfRiL63g26cdBjF
 stWp3MD7GcqMEHfqfXVLC0NQbsudy+iAXWeODX5+GgWju9IyUgcnbTpnDtCtQSf6coJE
 1MkZgR7s6j3QGj1euQUKMrVpHMSYfKrULV5pgA9M28y1U5AtEN6tZKQ8jAnRNwL2/FmG
 +Yjw==
X-Gm-Message-State: AOJu0YwZwxHrR70P1/vkwl9FG9t7d///cGlEo44MEoc4mcj8MDk+73yu
 /ab3uOJdZ6DZdCrAlWplg1mVAFI1LjpEx1ZBJr3S6gRPj4WCDAhQW9Czpg==
X-Gm-Gg: ASbGncvR9P26XhrEROWF4fchZCRoqLOWJK9pq5pE4F/IK6TstcgCEn88df60GqaLjw/
 +tJ9S6Fuu0DCSo4GKcLWaD2+L9cu8NKe2XLpqHH1/XeqvHgwf2fpUSkjq/bSU7k1T1J1u8nmZq8
 XVb42NJcGInZXZ1+opgfR66qcHxptzCZv7/4wNcc7v6g1RkxmTapRx1XGZ6tB0PLtcBr/f3Kd7l
 51eyO2VxFUa4JhaCbGw+tZTv6PaMEQvboM82olrg3DV+fyTWletd1jLXPPaBHWPJegNcjsuiTZR
 GYHDEggsbP5H73B2rC4YpYw=
X-Google-Smtp-Source: AGHT+IHjHVwlWWrBjCA9dqq7ulqW7wxT2p6NW7GQ/L8DOs2JYLBEm7iLMm5pfVHL3loyOjaZPEHKeg==
X-Received: by 2002:a19:f807:0:b0:543:e4a3:7c41 with SMTP id
 2adb3069b0e04-543e4c02e19mr4206754e87.29.1738515948698; 
 Sun, 02 Feb 2025 09:05:48 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543ebeb7a64sm1017154e87.165.2025.02.02.09.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 09:05:47 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: ublimage: Fix memory leak in parse_cfg_file()
Date: Sun,  2 Feb 2025 20:05:42 +0300
Message-Id: <20250202170542.2065434-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Feb 2025 18:16:01 +0100
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

Dynamic memory, referenced by 'line', is allocated at ublimage.c:159 
by calling function 'getline' and lost at ublimage.c:184.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/ublimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/ublimage.c b/tools/ublimage.c
index 8f9b58c798..a1bd807bfa 100644
--- a/tools/ublimage.c
+++ b/tools/ublimage.c
@@ -178,6 +178,7 @@ static uint32_t parse_cfg_file(struct ubl_header *ublhdr, char *name)
 					lineno, fld, &dcd_len);
 		}
 	}
+	free(line);
 	fclose(fd);
 
 	return dcd_len;
-- 
2.34.1

