Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1926C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 01:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDBF811C1;
	Wed, 12 Mar 2025 02:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R2awYs4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B548169D; Wed, 12 Mar 2025 02:01:27 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4979811C1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 02:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-47677b77725so31799231cf.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741741229; x=1742346029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HjlHAwNA4iMYKpu4OSiU+qrAwW9VsKiGx9M2nhSDLSk=;
 b=R2awYs4jCUeDBK+93+tHZ498fG3ZcFysQhK/qgIMwXlixc/TJ7r52lDVXbWc89ZAJq
 tIZbAr6PxzewuljDu791zxWoaX51Zl8UqopBROAVjZHvYuzm7V0tZ8UqONMRnLvrMHTU
 HenSkNexwOuudG8vBEoG3VCt95R4kTZJ98cpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741741229; x=1742346029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjlHAwNA4iMYKpu4OSiU+qrAwW9VsKiGx9M2nhSDLSk=;
 b=GSN5IFQOq149Wuo8zKyPCqGpL5kXzHBfP/Natsx3+euDMsKZsLcq5lMvQrwF4ZbiK4
 1w63VhcNQZ0f/JC9ucDVKo6cNXU05+Nte3kZI9nWSnqmZzSK2skT6sRymlDJh4nmaFsd
 OORjHDD0D+33Zg6XYSaz9EsiI4kxcAON5JM9nm1AAatwk5vtKa/Mp7QvKSuFCTMARd/U
 Xn/Fw3x61nsmBRDxKaB0b15oQysR7Cn6c53qNEeV8Ss8B9ymBQbZYPL6ZIILuKFvHQH8
 dMN58MA+e29zkS3SqpqHXCa+ysD9LTPqOqdC7f8Ghbuvz/IP8JAoyHcAeRzCSIcqYuG5
 tZ2w==
X-Gm-Message-State: AOJu0Yw1JCuiReUgtCrTBt8MNX3VSNE/OOLrsf+dMs0cSPev0FoSHSNL
 6HXUBzIHx99zMvvsAPxQNZR1rlAzM1Z+muVI5WpvggfgixoiNg84lWqtMMsjoUE2BAPnyaGdOoS
 g
X-Gm-Gg: ASbGncuQXxE3gqfNiwFePq8xDPMHtm1fwqskDzpid6yjnJWwu7rKU41kHxWdkW1ayiB
 kc6CWG1qK5NcXRk7or9RNp9A3HZfv5J0zdxFyi+0mbEyL8UvuxgoyMm7GpVs6rB1pdkFlU4gRfR
 4TT5+ao00E7U/ej+MeX+puss4slrgSQ/OX0CSGCApCBKb7q0pR06XC6kFp1WuPiJU7o8BijH5a1
 hqGB5XjPmCF53Lqgua1B3s+rwqVYIJG1gmthNnLztmGU1APlpku33VFxs6HaMQQdhBDfZqAyYYj
 T08i7FYXXkyzUpyPaMn8ddtNQo4WuSBrnUZgJnnqFDIy1nbxpLHB7qc4nRo=
X-Google-Smtp-Source: AGHT+IFnxX73+2vr6bBPUWlxmbrPH7oaD6rh5MeviS6VmAJn/DO64mzJ9U1CiXPCU7uVxtAm6jTvRw==
X-Received: by 2002:a05:622a:11c1:b0:471:ba79:cf31 with SMTP id
 d75a77b69052e-47618b38f83mr315537261cf.49.1741741229269; 
 Tue, 11 Mar 2025 18:00:29 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c55e15e86csm227843985a.48.2025.03.11.18.00.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 18:00:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 3/3] doc/develop/codingstyle.rst: Expand to include
 CONFIG_IS_ENABLED and PHASE_
Date: Tue, 11 Mar 2025 19:00:20 -0600
Message-ID: <20250312010021.1671010-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312010021.1671010-1-trini@konsulko.com>
References: <20250312010021.1671010-1-trini@konsulko.com>
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

Expand the conditional compilation section to explain when to use
CONFIG_IS_ENABLED rather than IS_ENABLED and provide an example. Next,
note what the PHASE_ macro is supposed to be used for as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- New patch.
---
 doc/develop/codingstyle.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 7211e4e4eed1..3303fff165de 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -192,6 +192,23 @@ inside the block, and check it for correctness (syntax, types, symbol
 references, etc).  Thus, you still have to use an #ifdef if the code inside the
 block references symbols that will not exist if the condition is not met.
 
+In the case where a symbol may be referenced with an xPL-specific Kconfig
+symbol, use the CONFIG_IS_ENABLED macro instead, in a similar manner:
+
+.. code-block:: c
+
+	if (CONIG_IS_ENABLED(SOMETHING)) {
+		...
+	}
+
+When dealing with a Kconfig symbol that has both a normal name and one or more
+xPL-prefixed names, the Makefile needs special consideration as well. The
+PHASE\_ macro helps us in this situation thusly:
+
+.. code-block:: make
+
+        obj-$(CONFIG_$(PHASE_)SOMETHING) += something.o
+
 At the end of any non-trivial #if or #ifdef block (more than a few lines),
 place a comment after the #endif on the same line, noting the conditional
 expression used.  For instance:
-- 
2.43.0

