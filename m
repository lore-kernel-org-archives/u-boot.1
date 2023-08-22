Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF49AEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A1387273;
	Tue, 22 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GrZb3cG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6F287249; Tue, 22 Aug 2023 05:17:19 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B16286B88
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34bae82b2ffso13999335ab.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674234; x=1693279034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2p1gHCou9z8JL5lD8GXzPfYMgdzLiRQYgQ5L93UTzk=;
 b=GrZb3cG4L2JsORQseRgFpsurO6CPL+nJUXyjdsI1UexrHb7o/gNB/w6tZr70PUEJ4S
 DHvh3wx+5pqGHxO19/YUx4PY1rvvNp4ubGyV8Jemxjcf3tbfVNamxhdn/uepPlElY4MB
 eUsEp4FWUH2VQadctZ4giLOh2EsYL3vCN9IS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674234; x=1693279034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2p1gHCou9z8JL5lD8GXzPfYMgdzLiRQYgQ5L93UTzk=;
 b=IZEfuHxxi8WTOf546Lo5WLC2W2GQoonJ9SJNz62YOSeZibxvq5U/orW1HCxoP1jCjt
 4AF8t7H70b39MOVOWqOLc2azb8GlIx0LIUJWODdoCIj7zT7HyzOgCRsLE1Au2cpVBhaA
 uWsVX7T2qUVR5ktL4iYbiOb7SEcKhUo1QpDQkJ0iHv+RJQqUcqmDsOXfbK9BzrsK3Jos
 K1qIZrk9A6jbCwxwIK/ZH5q1uIyFC4SB/GEXqJXLp4X5V8+mGQYnDgZWU89cRecEcaPR
 2Z+aH4tobP+ou74ESe+zNr4reQscUDBlFBWfZmn602/Nh9mOQf0WmhbB8iHq4ZoTuGqq
 WLTQ==
X-Gm-Message-State: AOJu0Yzdbh4cLtdzPqHp7xze5qCzHHR8A1Va6pZ1ikQehBHTluU5NSuv
 lv/fMcgcLomljkRlopLLFY7H+UlySLHQYQsBG34=
X-Google-Smtp-Source: AGHT+IFFZS8fFlpxmPNIU2PSMvVbGZzxkeMK/2yGYlHRbyZ9CybIPnDh0JTWbhAVrwpw29mJDyWJkA==
X-Received: by 2002:a92:d14e:0:b0:349:8811:fc51 with SMTP id
 t14-20020a92d14e000000b003498811fc51mr10471133ilg.20.1692674233985; 
 Mon, 21 Aug 2023 20:17:13 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/14] initcall: Adjust the failure message and return value
Date: Mon, 21 Aug 2023 21:16:52 -0600
Message-ID: <20230822031705.1340941-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Move the failure message outside the loop, so it is easier to follow the
code. Avoid swallowing the error code - just pass it along.

Drop the initcall-list address from the output. This is confusing since
we show two addresses. Really it is only the function address which is
useful, since it can be looked up in the map, e.g. with:

   grep -A1 -B1 serial_init u-boot.map

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/initcall.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/initcall.c b/lib/initcall.c
index 81c5d2450735..0f74cef32f85 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -46,11 +46,13 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 		}
 
 		ret = func();
-		if (ret) {
-			printf("initcall sequence %p failed at call %p (err=%d)\n",
-			       init_sequence, (char *)func - reloc_ofs, ret);
-			return -1;
-		}
+	}
+
+	if (ret) {
+		printf("initcall failed at call %p (err=%dE)\n",
+		       (char *)func - reloc_ofs, ret);
+
+		return ret;
 	}
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

