Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F201C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96A9820F6;
	Thu, 30 Jan 2025 17:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGwXOCkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1594E80EC1; Thu, 30 Jan 2025 14:42:31 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357E080E9A
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so147125066b.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738244548; x=1738849348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2LyufiWgUdUqA3J7uo1BpwqxdmFoSLczzZ+IgXJ6C6U=;
 b=HGwXOCkM1skFxe7mgPA81pu1WMP7zE06SBegmRGY7SSggalCUmJrrQesJTHNSM2Hxr
 PIp54Y8daiN1v9qH82ZedQOZBgf+VSMiqPJNyjA0TalVC66dcIBVHNzydriqKISXq4PW
 RUsIWBO1nV3h5W/fYMM8/sRUd060pOt2gZtvHvWovFZaT+a+e+WxuZ/6jRCNn7Zd/r9g
 4O07io8q+i01HGV9l6SJOl4PxfHMaP+Yv1pa4QbkvwJEzPNPUtTJUibyY7NgNboQRr9S
 GBz6djTd9Nw6UC6RMe0zF+yjPrI4Yly2/sw570yn6eQ0R7WwvIV1FGYKPQA7l3jLwg30
 QyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738244548; x=1738849348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LyufiWgUdUqA3J7uo1BpwqxdmFoSLczzZ+IgXJ6C6U=;
 b=XY4lrDT5ha5UEqDC1xWFNxYMJlE33oO4YESu53+E4L1pT8lnedsQk1XzBscqKZZWi+
 DW3IaA+DIshTmgH3IIHMLn+Kj9MbUhKYdl0xcU555lPjcuDsLhaeb2xdfGeq3735p4HK
 KWCL1D1axU7SGonu0NO4OYV0bedePjgYjWszWOtrggZSCEwRPEnWgxjaCK8OeXl4bYtT
 hTmzIjzV9Y6QP8rtV10t8WMh4q/LI67MV05OfOABW50qOqw5X0Ta+23Wa812O9SUXdL5
 pOGC14UGEwu5s3jrgfQHREtUh5SPuk+AgaS68waRZUtgg/kp6+7WFkMaUQrq6IKBokHV
 y9dw==
X-Gm-Message-State: AOJu0YzE0IrtKqOzMlWePe18cH7TNu0hzM9YXDORg1ZNa64/dnX2xK2T
 J46oubVdTNZ1+eWi/PU/1vA3WIxP4tW2dugTxOWvlv7IID9k+WwKo2oY+/+Tduo=
X-Gm-Gg: ASbGnctFVYPiffkn4siR7dbCQt5qmZPchWfFAp0B3/2P8t/5grhuQoQLp3aCEqIQM6S
 dgncGkpcLgbmpXW2+nAr6eKHierK+Xt3xm1m7VPFFBkWDANdDPshmFVSAQ9cTtqO6FCABCglNK+
 myJB48FXBU9Swgp4YbKuNemmKgHRl2EMfgXfOWsO3p34g+HVTNqRxPKvWGvt5/Tauj+ICKkelPM
 sXCTegKQunZ+iquxFdD7J6KFhX+1SZ8unM+olNRSk0lBMSu7/0JH+NSy3Hrrv9j25v3DXa7Lp45
 dJE9ycIuELVmdunXpajGfQMY249xjOIapfttKZeTmudJoq5TjhjGhctVT1oVarLsNrNPIKdkAw=
 =
X-Google-Smtp-Source: AGHT+IGEo/gljnij2BCfHJ0QeIjU2iXzCZkT6whITGXyFxPojplETwy+UjXcy//Kgp0xL6+9eIYxkQ==
X-Received: by 2002:a17:907:72c4:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-ab6cfcb3b87mr728665466b.10.1738244546676; 
 Thu, 30 Jan 2025 05:42:26 -0800 (PST)
Received: from astra-student.rasu.local (109-252-118-237.nat.spd-mgts.ru.
 [109.252.118.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4f4ab84sm121281766b.62.2025.01.30.05.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 05:42:26 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: fix NULL_AFTER_DEREF in image-host.c
Date: Thu, 30 Jan 2025 16:42:43 +0300
Message-Id: <20250130134258.271298-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jan 2025 17:06:58 +0100
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

Report of the static analyzer:
1. NULL_AFTER_DEREF Pointer 'str', which is dereferenced at image-host.c:688 by calling function 'strdup', is compared to a NULL value at image-host.c:691.
2. NULL_AFTER_DEREF Pointer 'list', which is dereferenced at image-host.c:689, is compared to a NULL value at image-host.c:691.

Corrections explained:
1. Checking for NULL before using pointers: The if (!list || !str) check is now performed before calling strdup and realloc, which prevents null pointer dereferences.
2. Checking the result of strdup: strdup can return NULL if memory allocation fails. This also needs to be checked.
3. Checking the result of realloc: If realloc returns NULL, then memory has not been allocated and dup must be freed to avoid memory leaks.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov at gmail.com>

---
 tools/image-host.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 84095d760c..821c8db616 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -716,11 +716,21 @@ static int strlist_add(struct strlist *list, const char *str)
 {
 	char *dup;
 
+	if (!list || !str)
+		return -1;
+
 	dup = strdup(str);
+	if(!dup)
+		return -1;
+
 	list->strings = realloc(list->strings,
 				(list->count + 1) * sizeof(char *));
-	if (!list || !str)
-		return -1;
+	if (!list->strings)
+    {
+        free(dup);  
+        return -1;
+    }
+	
 	list->strings[list->count++] = dup;
 
 	return 0;
-- 
2.30.2

