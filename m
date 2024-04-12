Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3FBC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DEF8803B;
	Fri, 12 Apr 2024 16:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fG6rSmbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055AB881A8; Fri, 12 Apr 2024 16:23:23 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA36D87F1F
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78d6bc947aeso56847785a.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712931799; x=1713536599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ffBO++1BY9kDiNDWJbJBRwrbxVqm2bUH/PoCceFsoFQ=;
 b=fG6rSmbUJAv32Hzrzdwg74LDcO/wGricP65mfH7K90dEYDBH+OdqEUPgIKz7BRcogo
 rEN5xBmdqFIEkNNu+fw+U9IuwH+ERAWiWCthi6Baeh3r4w1eUGf1lNxY6IWwEf/jWjPW
 oMZ/DWYroDqJlXi6bIAVnyJSUfZM9AXVfcDmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712931799; x=1713536599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ffBO++1BY9kDiNDWJbJBRwrbxVqm2bUH/PoCceFsoFQ=;
 b=j5x7aZWGm+B+6NMAqWgCQWyFLW4prsWCPJjMrKGDc0grt85JG/XNLjdCTEi2jt+TEk
 uQxJjY7jX+76vJx4o7MfGH52KVpOa7GAHyqpWj2IBQLiD9TQKTMlnfKafAFDrSqX5Nsd
 fpml4xa5RTOVEIfxiA3qj+wiZoEG/djSh6tSYlCa4fvO7l334wSHxT0nKluZyr1qv4Ue
 gUjbBDTnx5lQTsajzUUooSQE9gS1Ob8C/CQgdlMAsDzhefFhQ8rsZSuvVZnCgnyFxWHv
 QRBc9qJYJyMkfPIICqT7I7izATE3PpTo+FPu5DuIU1A0hPzsbzlqrRv5heKu/0WIlV4T
 fVdQ==
X-Gm-Message-State: AOJu0YwjzsR770cvcoCxhEz72luTxSZmCuRqv8ooYEWOZREtA+lr8pJ4
 Xtewc3YUBe1O4lzZcM1CXybOlHrtuTkA5s7jF336vPrdiNIjqP4wLViECDXQm52c8y4YS4pF2PS
 zXPg=
X-Google-Smtp-Source: AGHT+IGZBKuJxxuVvuj8tGoKwtcfZQA2nYFQTXCF7MjgrnvSpu8se4iumQXnzzlDTiLrafnx7zHMZQ==
X-Received: by 2002:a05:622a:24b:b0:434:3ee2:8e3c with SMTP id
 c11-20020a05622a024b00b004343ee28e3cmr2940242qtx.29.1712931799533; 
 Fri, 12 Apr 2024 07:23:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 v8-20020ac87488000000b004365ff9a977sm2201219qtq.28.2024.04.12.07.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:23:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc/sphinx: Bump idna to 3.7
Date: Fri, 12 Apr 2024 08:23:17 -0600
Message-Id: <20240412142317.966448-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

While we unlikely to have an issue with CVE-2024-3651, it is simple
enough to bump our version of idna to receive the fix, do so.

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 840c6cedfde4..5b4df36804b5 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -3,7 +3,7 @@ Babel==2.14.0
 certifi==2023.11.17
 charset-normalizer==3.3.2
 docutils==0.20.1
-idna==3.6
+idna==3.7
 imagesize==1.4.1
 Jinja2==3.1.3
 MarkupSafe==2.1.3
-- 
2.34.1

