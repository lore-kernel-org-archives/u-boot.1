Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91073C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEB482EC6;
	Fri, 18 Apr 2025 10:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cGPZW3Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE8F830A0; Fri, 18 Apr 2025 10:15:39 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8376F82D57
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5499c5d9691so1987594e87.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744964137; x=1745568937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRFhT7WfMdhEOI9FLRMncMKgWxDpiHAsW6oVIaHa9HU=;
 b=cGPZW3BgJYmXsPgRdy7tUMbqClQiVGaamHTA9xeVAITjzGJPd1fWmoBBlBoVLhXqVi
 IwjzLa4BlqePhYD415OQile7OyQEyq65Isq2wYf3czstnFcVUuYJM9FIoxmyh97zlegF
 LYDMjvcZWnLYCtYuUm/W2i3s8qtYhUUDcmOl1/kovOQoH8LK9aJHeNY0X8Jq5/+8UnYJ
 U6ujf1Q1r7NoJ3Pr4HzVtXqVfp8KwO6rO0+rgEtjCo4BeLz5q2pBAC0jd+QcfZiLm7d1
 h6JMWBkwjD7ytS4ATxKmiJk7twSDhCQ2ziJ1LEONhRLHcJ2ZpYIywwuZLVeBoC4xZ/zx
 GWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744964137; x=1745568937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRFhT7WfMdhEOI9FLRMncMKgWxDpiHAsW6oVIaHa9HU=;
 b=S4jUwL0QtySb1uEOkMc99N98WTmsFHzw9tRofVOo9mIbe+NedcVUpYHj1ovgtsuf2p
 v9Mtd03Zt4JHieBqpDFncYMkqlSR+2e7guoCusJ8eSt3hoKbwrMkFzh67bu8tUgzvGYX
 75SsHYyjxF8JfZdLiks4Trc57oKqIlmQ7qaVOVIh5vh7an16rOJi4wLErQ39lnSpXjwd
 33N+DYqmg6DIrIgp9PiEfmUaa49xnXieyLFt6VMxKwL+gmu8cp9+phob9hHf5m7i845A
 j5JVrOs8OUrdkxtCMAE/rYYvedICAEpw7/ybDnMUuwU8FzceEYlb3eIVsaWTGj0hjwHN
 kmUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0rLfvHRQInlJ491kIKB1FdKhxhwq/gZxPTjT/p5f6orepK/jKY9eycw1TIgYKrTkKwsuEJaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxni4fPAIQt9gmvURtVamftLE1Kh8vepwxg2hGCl49jq0YAtZE2
 aQmP8bOsH5WZCwkFkiPlA9HjXzO/JhS5+T3piN/RQs0jiU8B5eBW
X-Gm-Gg: ASbGncv5nlHAYGCYBOXX48FIkXhoSllUSzygUQtatb5ByTXRGRvEYDXBB0Kmy/XejuP
 PTj70S5BxaUrvmiwCtNFSySEQi4xzyKtTf1r3SF/7zKWv7Nuv3RCOuxV1YRmwwlvCrvI5iJbcbL
 j2aALn4jy87p6/YiyXqqIKST94VALEpRU3/T91bJUFW1sLUWsawovgGcpmYfe69lEcAlBxRdIaN
 HC7TxatMzqjVxXl1iFZecNm4uELI6B1ywS4KxHeM1fABr74liBIm4Gwa33GXM2lobBACQnNiXYg
 y9S/9LYiJNwQA+uadL4SN3olUP+fBDZv2NLRNjP8H11bEqQMkQsElb0O3FlRDG6Gex3pgNQTFrG
 AWnpFpA/UIlsKvl4/Now=
X-Google-Smtp-Source: AGHT+IHtfwaTvQeFVSwfYF/NTYQfLhZxF6zK2DqVszlKsavuM9mPMHxwzQcgF+sgAcu3iAll1N55oQ==
X-Received: by 2002:a05:6512:ace:b0:549:86c8:1132 with SMTP id
 2adb3069b0e04-54d6e627893mr637217e87.17.1744964136547; 
 Fri, 18 Apr 2025 01:15:36 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e5e47d1sm127145e87.159.2025.04.18.01.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:15:35 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: ant.v.moryakov@gmail.com,
	u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: Fix handle leak in mmap_fdt function
Date: Fri, 18 Apr 2025 11:15:23 +0300
Message-Id: <20250418081526.11327-2-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418081526.11327-1-ant.v.moryakov@gmail.com>
References: <20250418081526.11327-1-ant.v.moryakov@gmail.com>
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

The handle 'ptr' is created at fit_common.c:91 by calling 
function 'mmap' and lost at fit_common.c:127: 
Added call of free for `ptr` if ptr != MAP_FAILED.

Trigger was found by the Svace static analyzer.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/fit_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index d1cde16c1c..135e105929 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -123,6 +123,7 @@ err:
 		close(fd);
 	if (delete_on_error)
 		unlink(fname);
+	free(ptr);
 
 	return -1;
 }
-- 
2.34.1
