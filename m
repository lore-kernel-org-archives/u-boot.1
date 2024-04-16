Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A2DC04FFF
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E0488452;
	Tue, 16 Apr 2024 21:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="srbvz2Ad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B9A88437; Tue, 16 Apr 2024 21:01:54 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D036E8843A
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b7d2de292so8287726d6.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294106; x=1713898906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZ+O4oFRapotddgFYDIT+Osj7pv6jf0IShf2QhU9Hk4=;
 b=srbvz2AdOgZXAYRAqLYmOCio26AmN7PwUzrvggORHQtED86MbnCURmjBdZGXt58A3e
 +2sMU10NyHYRP9VOr5qQIA39ILLZW6mHYUuUdj9ZeFk8j58zBEEvLdCLDljIwSX5WTP7
 Vt3V7JGIb9sTFYxKLr62Z4aiuHMtARWV3NywPqRKjCZNw0f9Ngt2cdLI+DKpDtULA4wb
 6dkwIjOukUj6Ag1+oBmwhKamWRfJN+hyCxGEgEZfesJLCI04ZN3B3SzUpx4aSCarumF3
 2isRzmGq9ds8D0SEPlKmeRpHZillzsVSP2IBA2L4r8vB9tgVyAINpCTELSArC8X6VbRn
 dJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294106; x=1713898906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZ+O4oFRapotddgFYDIT+Osj7pv6jf0IShf2QhU9Hk4=;
 b=J/t8N7HLNEq/Wcdiy1XtB6JkWbg7w5mrT2hC8qA6NUtCHzKWIS5OZK9vsHQ5oY/J8D
 j4i+acL+aKeQQscqEPRLzaFRXmNpAZ4GiSNpncEHDbekHQf7u6MV3ce6oT1K2So8ORKs
 fpfswkk7zt0SqCLnL8oQzVj9KYMpsCH4I++Ug2Q38ZATBecTCRALPC64SAzfDYFJosed
 NGoKADuJ8mK/AGXj2iIZplSLW5rpthPzsekEf4Ob4sQaguU4JDJJvzLb3jb8UQBB9GQi
 cKh5J7cyMliiCICDxYVFE388kWPdkKPZ5gaPgiMMFHe/BQL0nSH9x5TcpGMqp2/1ndyY
 kXPA==
X-Gm-Message-State: AOJu0YxLZeq9ALJuzJwBuouJqIThDA6P7rsr2rP5en0ZwEC/CjYVI02l
 G6lSpX/aPf3LuvapK6hcA63R+ymqBb7E+U4uDmsu2IdS+744eVBOscJmd/mx4bvVHuty7zisYya
 W
X-Google-Smtp-Source: AGHT+IFUYyfREr9eJv4weSDELkSR/1Q74LzhcxWHaQt5HLvoXiFk22JaqjvvqdCJ0C9U4a/Y6oFeqw==
X-Received: by 2002:ad4:44af:0:b0:69b:bcc7:f823 with SMTP id
 n15-20020ad444af000000b0069bbcc7f823mr4876440qvt.14.1713294106441; 
 Tue, 16 Apr 2024 12:01:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:46 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 07/23] efi_loader: remove redundant hash includes
Date: Tue, 16 Apr 2024 12:00:03 -0700
Message-Id: <20240416190019.81016-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
and u-boot/sha512.h

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/efi_loader/efi_signature.c | 1 -
 lib/efi_loader/efi_tcg2.c      | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index f338e73275..184eac8cdd 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -17,7 +17,6 @@
 #include <linux/oid_registry.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/rsa.h>
-#include <u-boot/sha256.h>
 
 const efi_guid_t efi_guid_sha256 = EFI_CERT_SHA256_GUID;
 const efi_guid_t efi_guid_cert_rsa2048 = EFI_CERT_RSA2048_GUID;
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b07e0099c2..ac056dcfc5 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -19,9 +19,6 @@
 #include <tpm-v2.h>
 #include <tpm_api.h>
 #include <u-boot/hash-checksum.h>
-#include <u-boot/sha1.h>
-#include <u-boot/sha256.h>
-#include <u-boot/sha512.h>
 #include <linux/unaligned/be_byteshift.h>
 #include <linux/unaligned/le_byteshift.h>
 #include <linux/unaligned/generic.h>
-- 
2.25.1

