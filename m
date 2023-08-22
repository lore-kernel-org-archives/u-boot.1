Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CFEEE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9331B87267;
	Tue, 22 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HZX5Im3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E33871C8; Tue, 22 Aug 2023 05:17:17 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BD8871BD
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79194701ce9so136946639f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674233; x=1693279033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFQlrwSwwn8d0Kyr3tdpyvTRAkR5d0wwfMIAqGoInlk=;
 b=HZX5Im3a4evZ7U7UnqeqmSuAhN6wxnMqJW4OrTYe7LI4+tzRD0nPyscS/F3oCi0bwK
 4GMyNnKar67EC6ns7GiZXBWmKaBb9F6AD9YGox7xl/Tg1TL9uP8ryHKtstztJBFukeYw
 3WEL91DAWkngbPKwkdxpjk3hKDRNF0sTEEKlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674233; x=1693279033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFQlrwSwwn8d0Kyr3tdpyvTRAkR5d0wwfMIAqGoInlk=;
 b=JEc7RZJLw8V0rV8yUgtsL42vhsPMjM02GaUKATpj7QJXajgGF5noUNbFsaShHJorZ5
 6+P/gx7bodUYGjjyETvjSTlzbiTxKYqzcal/5Pt22VRmdY6X62Jebta2MHp07NnYxi/N
 Ypy5cxP0nAeii3tgnhjSm9suiXZtEeyKuhjZMuxAqxRYsqDGkjut5ejpFHwtRz2dWjnw
 Fc4EUs9nbMz/HDBdOfA5ixUtnLvo1ORUQPX5I41JhNf01jF35Yy9HdTcWYxqfjDVMXk7
 Oh6XbuBesj3iNshx9+BNqWjJTk61g3tDW4ZElLYp3PLSzeoO+pDmCJlsn89dKYcesQGq
 tzkg==
X-Gm-Message-State: AOJu0YzID63Csrt4DUHImXUYu2VxnsxwmmBs0uNz+b2Wmf89b4LIcLGZ
 tF55wDdnnpZ3gBBbPwkYBGGE1jskK1uqBUvN+kw=
X-Google-Smtp-Source: AGHT+IHQWcfw3qkRsFyL5G67mRb2SmEjypQtYzgec7j5t8EN0ibuO5BV87Q79TRgQN3WXm+NqKO9Aw==
X-Received: by 2002:a5d:9e04:0:b0:791:3791:527b with SMTP id
 h4-20020a5d9e04000000b007913791527bmr9920838ioh.14.1692674233219; 
 Mon, 21 Aug 2023 20:17:13 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/14] initcall: Adjust the loop logic
Date: Mon, 21 Aug 2023 21:16:51 -0600
Message-ID: <20230822031705.1340941-5-sjg@chromium.org>
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

Use a variable to hold the function, so we don't need to repeat the
pointer access each time. Rename the init pointer to 'ptr' since we only
refer to it in the for() statement now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/initcall.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/initcall.c b/lib/initcall.c
index 89a68b2444fe..81c5d2450735 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -33,25 +33,25 @@ static ulong calc_reloc_ofs(void)
 int initcall_run_list(const init_fnc_t init_sequence[])
 {
 	ulong reloc_ofs = calc_reloc_ofs();
-	const init_fnc_t *init_fnc_ptr;
+	const init_fnc_t *ptr;
+	init_fnc_t func;
+	int ret = 0;
 
-	for (init_fnc_ptr = init_sequence; *init_fnc_ptr; ++init_fnc_ptr) {
-		int ret;
-
-		if (reloc_ofs)
+	for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
+		if (reloc_ofs) {
 			debug("initcall: %p (relocated to %p)\n",
-			      (char *)*init_fnc_ptr - reloc_ofs,
-			      (char *)*init_fnc_ptr);
-		else
-			debug("initcall: %p\n", (char *)*init_fnc_ptr - reloc_ofs);
+			      (char *)func - reloc_ofs, func);
+		} else {
+			debug("initcall: %p\n", (char *)func - reloc_ofs);
+		}
 
-		ret = (*init_fnc_ptr)();
+		ret = func();
 		if (ret) {
 			printf("initcall sequence %p failed at call %p (err=%d)\n",
-			       init_sequence,
-			       (char *)*init_fnc_ptr - reloc_ofs, ret);
+			       init_sequence, (char *)func - reloc_ofs, ret);
 			return -1;
 		}
 	}
+
 	return 0;
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

