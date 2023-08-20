Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E16EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 19:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D4C86B86;
	Sun, 20 Aug 2023 21:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IYFAHr0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD4A86AF4; Sun, 20 Aug 2023 21:04:30 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592618684C
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 21:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fee769fd53so9872575e9.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692558265; x=1693163065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=IYFAHr0e8IPQCesrq938DlPi5+LNeGjXPYGJhZylq8awRIxbz3Vn3M8qVv14XhXIGt
 nNQmllqFL7Z9O/wA0uw80Etm2j0QRyQWFFTzigyJs9tJX0B6ZGKJxLG8o1xPPfgcjlrt
 CFmpR9xwSDWjoku1cj/WmnjBezWfTRhV1ktCtcnsRwwV2yqx9rQflkKmie6OefHfQuLo
 PCNZGUn5wh5c6H2AzPzJRdQ+QFLC54EGPPGCkxORaoHw13n1kW3wWRn8Gn4CEI0Z1GBE
 ogmjeAvuv+5NmPpO8XcgJXgBqmAX47Sfe/Shv96Tdu177mNakAfCGjYfM4aq8pbda3/E
 4VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692558265; x=1693163065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=kILTY7e7AckTbky2FoCkB/dbaxGnQTWbcZg9C9bBV6Ex/fwNUvAIpJexYezfT0x1+a
 r8d9cZ0VZi0R+pfGbLRV1NJNNpXfUHXvrkkF1JEl7DDZrXxmVBdwpFPZjb9EtQl3N+tv
 W3sY5g4DdgwlnB13Y9BtS2LeKh7XcQYjVaI4GpJipntRdp86n7QnhodaAZM9qI2cNkLY
 7Mb5ajPUg8MNnzEoK7DboBnfl44EcHoCjPwYA3nj24IvJN10gOeh5OcX32APi5zpRP2Q
 pQAOdJdqUTMKDv9cVi+Ec5wuMPuvYt/XrfdtWvYSIywC0m5OAgdJU8FT9temgOjjw7Mq
 jiNA==
X-Gm-Message-State: AOJu0YyKtNaUC1qFtOzrKGTJCUxpNo4ksZ4v9RJACjKH8juoChqJhOTZ
 nIEXGkHTPOT7CV1+lLLDCPQb2Ji2Ulm1vm8+
X-Google-Smtp-Source: AGHT+IEpIAaBFTk3mUYhl+TX/aiq/JviVja3wcGntsEoVUU2xpI1H/jvuhgKtFdq27BHhbc9mqeI5A==
X-Received: by 2002:a7b:cb99:0:b0:3fe:e7b2:c97f with SMTP id
 m25-20020a7bcb99000000b003fee7b2c97fmr2593681wmi.36.1692558265583; 
 Sun, 20 Aug 2023 12:04:25 -0700 (PDT)
Received: from fedora.. (cust-west-pareq2-46-193-56-152.wb.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm8253797wmc.20.2023.08.20.12.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 12:04:25 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v1 4/4] scripts/gen_compile_commands.py: add acknowledgments
Date: Sun, 20 Aug 2023 21:04:12 +0200
Message-ID: <20230820190412.21266-5-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820190412.21266-1-jmcosta944@gmail.com>
References: <20230820190412.21266-1-jmcosta944@gmail.com>
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

Add acknowledgments for porting and modifying the script. Of course, the
license, author, and copyright notice remain the same as in the original
script.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 63d036a773..1a9c49b34a 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -4,6 +4,7 @@
 # Copyright (C) Google LLC, 2018
 #
 # Author: Tom Roeder <tmroeder@google.com>
+# Ported and modified for U-Boot by Joao Marcos Costa <jmcosta944@gmail.com>
 #
 """A tool for generating compile_commands.json in U-Boot."""
 
-- 
2.41.0

