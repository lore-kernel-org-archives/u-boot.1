Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2478FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C9A84308;
	Tue, 17 Mar 2026 02:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IoTt3pOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897B683F9A; Tue, 17 Mar 2026 02:24:59 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA3E83F9A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4671cbce32bso1120475b6e.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710696; x=1774315496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WQYCGdeRCSUb7hd54k5fnBZKd+zegAo+eSpAAH6BJx4=;
 b=IoTt3pOAaOhBI4GLhWGnmOocy/oLx8rmxX84HPmPB+DfVRVbAE7tGg3wjXIFhZllKg
 +P1air7GKfzE0EvTNZ6jmw3zJHrOA42N4tE7STSalqkfYtivKoirwtKmHF8jf6dRRKN1
 xzrRC7gll9OUW3nd/Y9XygtPjwJiYLnLlPqAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710696; x=1774315496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQYCGdeRCSUb7hd54k5fnBZKd+zegAo+eSpAAH6BJx4=;
 b=lzU1dC7SDxRhd4vuXHwUNrYlzuY28WAina7M9NyqFWC49rdz90hG1lx5K6RfSfZON9
 3W46SoEgdZlx1jfOiqtFa5p7f6EmHEY7WYWOd0QV/uLT9CuZ+P8zJ/xo3aO2Ls25VaW9
 bm03ZE2HiwENfvYO0GBQamGwseQ4Qu0qLiVrPqXeZraGRDuzcPAac1HIcun8KGKQQyYb
 GOMc1WK26v7ZyNFUBGLOXN84oTorixos5s0rJL5ewzoyj5y+5bqlBhyLrFi5nJPxg3et
 OxnpoZLrEF06UKjTkL1X6UP9HjmuwUdvh5JfjZjflFvRMEGWxVx+va15/i5x7HU0I2kh
 nsDA==
X-Gm-Message-State: AOJu0Yyx+TWptAlmCDvilwrQb+3brkuoHjUNweHYjkGnd3f4JN8d65kx
 zKuaM8c1LT/I8E7E7l9gujFZOx+v6wBFNRzWVXvbHdstvH64ReQzHbThENeaKM4pAcQqh6nxjKF
 Gz1LHKAU=
X-Gm-Gg: ATEYQzzMSEPiVMmqHrU9M4z6qrEA/Iw5IlIpiijy5KWyn7IIwisHvSMrXsmplSeWL09
 AO+kH6SwN6xyOoLYcGexfgmW5tRw++Bqjl14/l1cJA8xPRjQsSWij9IvKhsIfI6K+yr2DbOt9Hn
 Up8h0fti1BbIsUlT2MR9NIBwAJ5LJkXVhKF582lzzhu7B55FTnNKOOnZ2/fUtTU1vbbHNzwNIK2
 aReqpDdNeWTgDEuVRgnkSSAQDqNw8TPZRxZRLO+0pztX+9KnDSf7BVHRaL+5eJkULntsMMhuxW9
 93qg8dh4buLRDMr95U0ZmQkAQFsDxjWNCfi2Rf5L9hTITVOvsWmWvCQtgIcvS2eI77kw5wawdUy
 U81AcEUOhRHupiTCzZ6AbFYRX5at9gsCsXYz5rzxmG2AoJnrSsTMy4PLMmfHPbW0T5WaxYS039H
 pk77K3ZxMAo+40oe74+3j56ZDp8LjnWr08hhRQvzmsg9CdczVefbkRDlahXUfdX3Ft/G0fPB6CY
 0rJere0QDRurmLfqGFEUBSkVgWcENWt06FognqZOASazzHlQpo=
X-Received: by 2002:a05:6808:6ecc:b0:467:2a6e:adad with SMTP id
 5614622812f47-467570374dbmr8166613b6e.11.1773710695870; 
 Mon, 16 Mar 2026 18:24:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342c1218sm10451822b6e.11.2026.03.16.18.24.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test: Correct dependencies for SPL_UNIT_TEST
Date: Mon, 16 Mar 2026 19:24:54 -0600
Message-ID: <20260317012454.4162754-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for SPL_UNIT_TEST. In order to test SPL_DM_DEVICE_REMOVE we also need to
have ensured that SPL_DM is enabled, so that that select as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index 24105c133049..14b5b0e2a9a4 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -15,6 +15,7 @@ config SPL_UNIT_TEST
 	bool "Unit tests in SPL"
 	depends on SPL
 	# We need to be able to unbind devices for tests to work
+	select SPL_DM
 	select SPL_DM_DEVICE_REMOVE
 	help
 	  Select this to enable unit tests in SPL. Most test are designed for
-- 
2.43.0

