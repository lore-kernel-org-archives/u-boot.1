Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15919C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3042587B7C;
	Thu, 26 Oct 2023 20:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UYhC5NQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795DF875B8; Thu, 26 Oct 2023 20:31:53 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCCC87AFF
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-777745f1541so98534885a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345108; x=1698949908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OorPIuOVKVz9rFKT/jKzRAK0NZ0dSHPSox/T+J0xDbc=;
 b=UYhC5NQV9qTTCmKlQVx5Yz/ESO+5bP7BSXab3+8rNL9taaLNVS9w5V4CXb/G0fbXnL
 lgBlptu/yCQBjKd8W0Py/XEVqQJ943Vk5qZqQEo3WyMGmMgKL88tHiT0UnyTOXEQ3nmT
 qarP0/mqsOR6k5/q7bMJm1NlcX3DUUIWkMup8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345108; x=1698949908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OorPIuOVKVz9rFKT/jKzRAK0NZ0dSHPSox/T+J0xDbc=;
 b=C7+R7ytTP5lrZjx9ihOsTKL2VdCO0TUpQRtzIszvsS2zojiKgCZfJ2QV96mfepXulT
 gYIJ7nyb+czoiA1goPDzF/AThLIjIL++otmCGcb8UuPhrysruamhdzdNumwEiWRy9nh7
 EvUKT08KmE7N28G1I8iR4oDsFgXAwNKr8IYxdog6gOzt/V1g0B+oiPjq2m+3s2Fq++sI
 N3kpMwNQq4iELaarXT9YGt8e73FhF+zvU4HoEycRAsNKoEZA7a3baXj4M88mfM2J0rSI
 AZ7WllTYMNUcewMFQEegRFCyWVbB/y8F+D357xd+JSaF6Doq71E2hIVazT0XkIXeb0C8
 Fm3Q==
X-Gm-Message-State: AOJu0Yy1dTlXmTb189O0qY7xLlLG+mcByKiUadNwca64nwQ9rDtlWjCk
 3uQeuIajWRBKXqEf46IFdykbO5kqyHs91pS9qLzJPA==
X-Google-Smtp-Source: AGHT+IFT32FykFcxOKEnE9ncnCTW7eGaYVbCpTNxfm4elawc6s7bVhNpbxfS7r+ik6Skb/TtLvb6Rw==
X-Received: by 2002:a05:620a:29c6:b0:773:a83f:4170 with SMTP id
 s6-20020a05620a29c600b00773a83f4170mr123950qkp.63.1698345107918; 
 Thu, 26 Oct 2023 11:31:47 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 09/30] test: Make UNIT_TEST depend on CMDLINE
Date: Thu, 26 Oct 2023 14:31:17 -0400
Message-Id: <20231026183138.636948-9-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Many tests make some use of the command line, so require it for all test
code.

This could be teased apart, perhaps with a test flag indicating that it
uses the command line. Leave that for later.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index ca648d23376f..c3db727c58e3 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -2,6 +2,7 @@ menu "Testing"
 
 config UNIT_TEST
 	bool "Unit tests"
+	depends on CMDLINE
 	help
 	  Select this to compile in unit tests for various parts of
 	  U-Boot. Test suites will be subcommands of the "ut" command.
-- 
2.34.1

