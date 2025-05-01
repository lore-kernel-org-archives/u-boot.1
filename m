Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5631CC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 11:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11CC80EFB;
	Thu,  1 May 2025 13:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZnE2dQBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F351F8056A; Thu,  1 May 2025 13:10:22 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36C08081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 13:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso66405439f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 04:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746097819; x=1746702619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJ6axVopDS+JnVZKZnNMj73hDvGNxScKtEG5SQFWxEk=;
 b=ZnE2dQBJwy0Pi793rQsmV/6FsCBbYxuGXPNk+sJ8UjG4k4E04+QIhEtsLay8Uv9ZC4
 iDcJ3QRDMs70SWZXHJmUMdrifm0gf871zLamagUkZj9sefbfz/XVZ9LmXYR2rfIj75UI
 kjw81T9l8PabPbBf9QwXOLDD0mWlKcUez05P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746097819; x=1746702619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJ6axVopDS+JnVZKZnNMj73hDvGNxScKtEG5SQFWxEk=;
 b=VhrwBi3m4/nwYpEw5y13x010bFyXG+7tLhaMBrPh41ZeAAhXXX92woHCyv2WWsRP/l
 AXHOKQe2HL4o3gOXfEf1WIcjCm4dhj9897o2fCMvOcp3ruhzvmh5EHLyIWSfqBQ23p6y
 TtPC0NT3oZ9bmAwQzWVjNdJCToCGCgImizlAdIx74UOrtODneyM4ii67WxWeUcHeEDMg
 kRmKOmRPqdwcrh0W9AZzPaj53shwy1puXgTIvIjLP54RJPGgh09dCgROs0CKZoMg8EF4
 D5lN1uFQqq+kShYof93+B3RuEj+bAeLuabYXGnsEIYs3L1WPzigGRzYn+bjh/87LfVii
 3JEw==
X-Gm-Message-State: AOJu0YydO1iJViqvEvBGqU99S/FRH14K0lKZkaMRP5oiX+KRR3PKpHzc
 8JKvsAlkYMpMHud7RKjW+Qq7j06BV8fIYKUPacEx7w9w6+QXDIXXIt//BO02uAsFiv0wqH6v/Uk
 =
X-Gm-Gg: ASbGncsFuYFgaIadY0qOemCr1pdo5rouqSNBCGE+/lw93GZ88La4RVE+4YK2iE9jSWx
 xbyWkoGm3xyVd/5GqdzbzhyKvk/SgmZRJeVMHBS6A/AnIM5x8GmXe7ysUnbwiY5jCfDqTmmwNQ/
 HzZaBV21IQ40X+TNoG9W4VEBi0o2cmXFRNFW9jE42bNB3DEULORbMdiY1uhPuF1fQjLnwntvBCc
 Luiot2brh5Tf2XsilUqrcwqX7uIWj7ZWYqQtB8wukJPIBljsTrwy4I5kjtrelv9aOUz2yg9cyYm
 QaOKoffNGZ6rzLyICO4916UrLjz8oJ80qDHZro9vMIz+agV8R5Dp1ZScZ2KTuJe6yyjJApmmiDO
 o+F9wOr1WX4jo
X-Google-Smtp-Source: AGHT+IHzwwzSiLUkR3KiIIlVgirx7X71rEPuuBkeVyxAYUk/MJVruoQv0Qz1SaWNP9vpedne3MWHtQ==
X-Received: by 2002:a92:d08b:0:b0:3d9:2992:671b with SMTP id
 e9e14a558f8ab-3d970aa4638mr16264395ab.4.1746097818923; 
 Thu, 01 May 2025 04:10:18 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e77924sm875915ab.20.2025.05.01.04.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 04:10:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/2] test: Add a test for strim()
Date: Thu,  1 May 2025 05:10:09 -0600
Message-ID: <20250501111012.705638-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501111012.705638-1-sjg@chromium.org>
References: <20250501111012.705638-1-sjg@chromium.org>
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

This function trims whitespace from the start and end of a string. Add a
test for it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Bring in strim() update from Linux and adjust tests

 test/lib/string.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/test/lib/string.c b/test/lib/string.c
index 8d22f3fd68f..d039f209a8c 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -221,3 +221,40 @@ static int lib_memdup(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_memdup, 0);
+
+static int lib_strim(struct unit_test_state *uts)
+{
+	char buf[BUFLEN], *p;
+
+	strcpy(buf, "abc");
+	ut_asserteq_str("abc", strim(buf));
+
+	/* leading space */
+	strcpy(buf, " abc");
+	ut_asserteq_str("abc", strim(buf));
+
+	/* multiple leading spaces */
+	strcpy(buf, "  abc");
+	ut_asserteq_str("abc", strim(buf));
+
+	/* multiple internal spaces */
+	strcpy(buf, "  a   bc");
+	ut_asserteq_str("a   bc", strim(buf));
+
+	/* with trailing space */
+	strcpy(buf, "  a   bc ");
+	ut_asserteq_str("a   bc", strim(buf));
+
+	/* with multiple trailing spaces */
+	strcpy(buf, "  a   bc   ");
+	ut_asserteq_str("a   bc", strim(buf));
+
+	/* with only spaces */
+	strcpy(buf, "     ");
+	p = strim(buf);
+	ut_asserteq_ptr(p, buf);
+	ut_asserteq_str("", p);
+
+	return 0;
+}
+LIB_TEST(lib_strim, 0);
-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: schn2
