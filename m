Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE2AD3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB29A89102;
	Mon, 28 Oct 2024 17:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DnkYFKVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D269E890EC; Mon, 28 Oct 2024 17:48:51 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8891890DF
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so31378476d6.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730134128; x=1730738928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDOKWZ1C5+CrTgKL+R0gJpclQoitbInGJ7FaNz5OYF0=;
 b=DnkYFKVBzsDMtN8v6YaB70tMSCwrLR0zJXgvPQA53HBOqbaM0AOhridFxeMMTcaV5+
 jPwdcTJ7uUnyaRi3/3qDbjD7siXV5ebNPEXEKSkNCzke6GHiB9KJy5re3OTuAJ21btyF
 ZQojUeRWLxuONj+vTLTM9K6qekKLle7WNJvjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134128; x=1730738928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDOKWZ1C5+CrTgKL+R0gJpclQoitbInGJ7FaNz5OYF0=;
 b=r+i1sOpI5ljHXL3c6C9rbI81mbZfkONFEHXmoH88tm3nUWbYmxdaGqYwEBIct/t8qW
 +t3oK5VZ6IH7lNKvAXyozhXb4zpD7CKkckmFFaeu4DF+xlZeYIET2g44gH7nkH6fnqR1
 3YGwtIFnAbVTRVVxNXYfJr4sXipCpYB8Qb0YBygoDbQlKrLYPU1WCqaoFNpP/AD0hQ1H
 UcGAdZ7m9YlnniJVvRwK14YCw4Gu4+HqcAPV3nZXHAkCAB3jp6sPWBfe7G/DlZ8IYsQe
 jxzBuFEJWqh20mBFsYhlva6gE/7QXUXJ4IZ5wDKjPHRgg68rFXrFtKK7zctglz8tCgZP
 VjrA==
X-Gm-Message-State: AOJu0YwL5w1f69UX6n1FLY3ufbPbeesGLMSQ8TzfPmHDchF/73yBlOMm
 t7Np96xKyS9bBkq9E7YuTbq9UCqM00ggoLJ+32DcPP5yg4C9yrB1lthVnimLl2aR8FTKjKl1+Kj
 fRHY=
X-Google-Smtp-Source: AGHT+IEFFTz8lv83Kn5D2kL/13X1vmRdfAuWmIYft8NiHzJ7K8glwNP+VHdif+mBlWZhBfhV80/7Jg==
X-Received: by 2002:a05:6214:588e:b0:6cc:51f:6c31 with SMTP id
 6a1803df08f44-6d18567cf7fmr120931166d6.5.1730134128676; 
 Mon, 28 Oct 2024 09:48:48 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a8455sm34254486d6.32.2024.10.28.09.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:48:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] test/lib/uuid: Make lib_test_dynamic_uuid depend on
 SANDBOX
Date: Mon, 28 Oct 2024 10:48:44 -0600
Message-ID: <20241028164844.2308549-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028164844.2308549-1-trini@konsulko.com>
References: <20241028164844.2308549-1-trini@konsulko.com>
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

The dynamic UUID test checks for the sandbox specific capsule UUID to be
used, so we can only perform this test on sandbox currently.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/lib/uuid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index d00e9563a472..55ef9e7454d7 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -84,6 +84,7 @@ static int lib_test_uuid_bits(struct unit_test_state *uts)
 LIB_TEST(lib_test_uuid_bits, 0);
 #endif
 
+#ifdef CONFIG_SANDBOX
 struct dynamic_uuid_test_data {
 	const char *compatible;
 	const u16 *images[4];
@@ -159,3 +160,4 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
 }
 
 LIB_TEST(lib_test_dynamic_uuid, 0);
+#endif
-- 
2.43.0

