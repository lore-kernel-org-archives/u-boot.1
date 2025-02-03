Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1493C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5154D80207;
	Mon,  3 Feb 2025 18:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jg0wgVlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95093800D7; Mon,  3 Feb 2025 17:50:15 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9586C80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so4919089e87.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738601412; x=1739206212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CxH/x6qBWBAnuqDnDS7MObuH1Kkci+l9fM4Uq3fBBSk=;
 b=Jg0wgVlw8OM/E+wvun+vvYYGKrGZmKiVwryCARH8CrG6G8lZT8BuRvWCdXG16T3nsv
 /ny5dMnhj8r+FsBov6jzQr9Z2z/BzVOCFNZ7vNRO5PXHK5TaMGfqr6O6Emp6RZzmvO57
 OxFHCKWuZF1EHn507ePJNEby9kSz9FQlnE8YRD/ytyL5A3smXiYV5/ipXdMu1rDyAufE
 tfICE/CcCls5Bqek+MLIWsKd/PVeccF1NT1ynMuupn7lckOa7KrZRkE+t/0avlC5kvdH
 N2IaqfsCBS5039+eaiMxPfopTSTsUCOLp0HFHskETzA/Z48H7amL0bhudNG3IKRcx4NH
 rIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601412; x=1739206212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CxH/x6qBWBAnuqDnDS7MObuH1Kkci+l9fM4Uq3fBBSk=;
 b=QQJKd21qzXeXRfu3ZhzYQqdVvTzyNcCJXqj57CkdaUAQreUtdRJQgPlSEtmkIfqkwU
 soLbdwvhzjOKY2tOpnsOFaVQXkH/z8L5gk+8R4zIsDhNwPsEZQd0VCbzknjLYhhquMZD
 bnwnGgtecZGlS0aUXPeVZRPZc8sJFC2OpOr0+1NW/W/kgJ+/tLACd73+ebIHVtImRBjm
 FGdpA1w9AwY6JrAkCQvOiNgvKVWiO84C2srC2/uREOW5OA9sosFozxGlgLSX2b8q5JOI
 lO5A/ofQHzjl2KVK033syhZ8C5k+ugqo+Ac3sDARfozSWVwULT8ZAfcP/HOYH9tWpE/b
 XmhQ==
X-Gm-Message-State: AOJu0Yz2zBgZmd30bF1+/TofYd69ZRrHjM2l+4yGlbTZAA1nhO2bwUIG
 owaacTX7+Y2SUP0reJIceYCr0TBBLpEKcLh1HDyvn23wuU4qWIbTQUXd4w==
X-Gm-Gg: ASbGncvFDYJNrwjIA3VaZI0xA904bfKNisey4G1/xEnY8vryFdJF8q9lZGu7kr13d6L
 dnRsKl0QDy6DvHe8a2ynKNrCIQg9ztAPNZ3TuB5j7Gk2HLMrirZHnfWkzvugC9I+Gn+Ze7F2gUN
 VeLuz3EuFHvdgVQrTH4zmoX8kATgUPgHGx2aGP/Tl/rlPPbtimbupgvCcrjB42CYjucUIdpwdlU
 YO+hEvCx9Kt0AKa7qFhcGDZq58OWSQW5PkWAbUtjvDYFDHcxosITD8MKDF8c/PmQwZiazblwK8g
 aQ2EHsITKZXxdQGHJfVsxUk=
X-Google-Smtp-Source: AGHT+IGzooXFKrq8JTW2rw/ktZ0u2e3C64HC54OkfCPovu7ADe7WUv8qmTrQW5HLlKFLHbVnUK9ouA==
X-Received: by 2002:ac2:44a1:0:b0:53e:39e6:a1c2 with SMTP id
 2adb3069b0e04-543e4c36cccmr6145782e87.44.1738601412314; 
 Mon, 03 Feb 2025 08:50:12 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543ebeb0b7asm1349306e87.119.2025.02.03.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:50:11 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] scripts: Fix potential null-deref
Date: Mon,  3 Feb 2025 19:50:08 +0300
Message-Id: <20250203165008.4088496-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Feb 2025 18:29:30 +0100
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

After having been compared to a NULL value at menu.c:799, 
pointer 'sym' is dereferenced at menu.c:812.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 scripts/kconfig/menu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 0fe7f3255a..c823719dfd 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -809,8 +809,10 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 			}
 		}
 	}
-	for_all_prompts(sym, prop)
-		get_prompt_str(r, prop, head);
+	if (sym) {
+		for_all_prompts(sym, prop)
+			get_prompt_str(r, prop, head);
+	}
 
 	prop = get_symbol_prop(sym);
 	if (prop) {
-- 
2.34.1

