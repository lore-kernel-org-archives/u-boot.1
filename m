Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA2DC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D39879E2;
	Wed,  6 Mar 2024 15:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Vx24hYVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4B1879E2; Wed,  6 Mar 2024 15:44:36 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53434877AF
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D0583F0F8
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709736273;
 bh=OR46eL2GHmgsOJ5FwuvRqspf6WKo71Eq6ha+IP6CE2Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Vx24hYVuBin/WoS1PhyypGR85NziNew//HsCmlNtTWVupW+TP+y5dpfz1sCboQkOO
 n4h/BSTiG5Xd6n9QQ2FhwQXLb4utIB4mye0uirggoj4VOEy92oO2zlvJhOdXZjfzvC
 T0oYh0l+q4p6RhmNryCDVaG1+2XBhTKeCzwhCCxVGgVgIKj3+pEaiS3B0zdJ7LfK+f
 KVG3a19x7+Jjfr7Qh3IlP+BBN9t/NCANpiGenAYz5stAbJNZMMZ7qvfkvXGeUDzigR
 /c+fXYH5gY6ljdaEwCP1bL17WtsOWpW0LDpFzFEA6pAwkSy/f4v04WGWRsf2WMpXZs
 bQGmgMY8C3nkw==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5670ee87ca4so1077524a12.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 06:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736273; x=1710341073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OR46eL2GHmgsOJ5FwuvRqspf6WKo71Eq6ha+IP6CE2Q=;
 b=kDWHhvd/L/ipnRLY409qSsz9/4JBqZfXhRHHGcFz4g/CnooCziz+oAfQoftcNs82AK
 qI1Hpw5jpAUrS4pwDppTyd43HEN7Phy+RW85/SKZeWjxCuOeX9I48GJG32VAsc/ZQLto
 pGvihJ6+DX17G51uRwYYjm7rYEwzUm1hnwLZfXJ2/0BPYm3QoUsfM5jTn/K+cI0Px8hB
 BYk3IBH7JkyIix7GrGSw5Mb3xdWUovf4/A4RXo9wS+LM6GaUE6mybpth50sLbYfbSLlb
 ET5zlb55rJ5677Dwhdh44xStfak5ulF8HRamwk+pBscE90TOY2r3wb7H4eF+qYC7Qru9
 vJSw==
X-Gm-Message-State: AOJu0Yx/Rk0lOpxzAXBmMUhtQON1584qojNCmbIPhrUSJm+8Z9RW0PYU
 OPAxU3pkXKlCWTQcyAKhjSO6uD9teCnsrCsrlcP8Wlc7SB6JlPziioh7yEpwYn5ElkIWlKR6W/y
 i+3gAp6Rcx7lHMfgKcKOkOVhjWpM5PdyCgdlF/95m2CE8PMjHbaW/LDO/36+HuP7jt/xES+Fejo
 I=
X-Received: by 2002:a50:c943:0:b0:566:bfd7:4c3b with SMTP id
 p3-20020a50c943000000b00566bfd74c3bmr10959813edh.30.1709736273026; 
 Wed, 06 Mar 2024 06:44:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVgvJZpFf0sOPfhp4mHqUy7m0PZ5MVuR0+ugxtV/taXnElnHwKAJROMCAS8+mML34SSkeDUg==
X-Received: by 2002:a50:c943:0:b0:566:bfd7:4c3b with SMTP id
 p3-20020a50c943000000b00566bfd74c3bmr10959805edh.30.1709736272638; 
 Wed, 06 Mar 2024 06:44:32 -0800 (PST)
Received: from workstation5.. ([2a00:20:9:393f:a428:922c:8eea:8ca7])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a056402240100b0056671c5c1a1sm7076807eda.80.2024.03.06.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:44:32 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd: sbi: Correctly display unknown implementation IDs
Date: Wed,  6 Mar 2024 15:44:02 +0100
Message-ID: <20240306144402.175957-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

For an unknown implementation ID an output like

    SBI 1.0Unknown implementation ID 16777216
    Extensions:
      sbi_set_timer
      ...

was shown. The number 16777216 is not the implementation ID.

* Show the correct number
* Use a hexadecimal output format
* Add a missing line feed

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index 9daf0e247ad..87f7966f06b 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -99,7 +99,7 @@ static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
 			}
 		}
 		if (i == ARRAY_SIZE(implementations))
-			printf("Unknown implementation ID %ld", ret);
+			printf("\nUnknown implementation ID 0x%x", impl_id);
 	}
 	printf("\nMachine:\n");
 	ret = sbi_get_mvendorid(&mvendorid);
-- 
2.43.0

