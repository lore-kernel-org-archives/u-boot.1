Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A213CA0FF3
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E8F8676C;
	Fri,  1 Sep 2023 22:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOFjEFxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3326B86758; Fri,  1 Sep 2023 22:04:19 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9116286795
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso24475395e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598656; x=1694203456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=GOFjEFxGPH+KYJsQ5mX0sYe4dhTSTGoJwbj19Q0yJ8wEhFEHQjqN4mdXeHZFKYYhO+
 deYAI16nnKidAiRHm4Ru7DOdsZ6Tb/uFS9vEEGHjLBBpi2Xuw1gYmmbe/yEWZJRrNjcr
 b0SnnxeAckm1NA8P0NdQSjvz+nLtqI1b1mPEUIZA+oA3MPgxMx07AZDPzny0N6Yyasnu
 5ctzyFWByKzchVVyjHNFbh37KC6ZvYNnpo4CXXistcIaxh8INiw06kOEhNIB1M6tnyVM
 tlk2961KSjAbWoO2LeKa9jOYtgrT6BIFzTu4GZTfz9YVoCxgGlhHpitRtG/ngdAMAgAn
 WT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598656; x=1694203456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=R+JMR85FusjIb/9xMnFDgb7l/ro8NqLBOEWcGzLEmp+hwm0YwAs7qwao7LqxEpaEmx
 muMKv5jP1kQVAmdIicPONMzHQ9mcrgZj329vvb+uk2xlkOgfw9QwjRrK/RHvW9xiQOzz
 F0vam36kLCUqZJhqpQ11AbzwHBzwKlUGpO2FbsjbNRMjnQ4/3jC/hV0LBbpQgDfNZWG3
 Ple9nN6aXbEmOirwM/7I4N9FdTGY+R71toTrRUa9IK/+2zn6X2o1gm6SbX4jkahU5+/Z
 ie88+FWUgSTXtFtYLrTX0191/+waSfGa6Q+EtCHkruX3AdLsbj6C9fs/2uZWDbQOHGpE
 TLtg==
X-Gm-Message-State: AOJu0YySSb8Zguh9FaAeM/vgYRASar7S/huJ8WsMFFl02K/nbJe+5GHe
 /Ktfmt3uZug2j8REZ3JdKO7TORd7Xu579rn1
X-Google-Smtp-Source: AGHT+IFhZxf7YmwXP3NVvXBCyFueTyrVrfChLo6Wk0krZK4dMkWFMiTRsIPmqBzjTTgR1JR6qXlCkw==
X-Received: by 2002:adf:ebcd:0:b0:313:eaf5:515 with SMTP id
 v13-20020adfebcd000000b00313eaf50515mr2498452wrn.6.1693598655828; 
 Fri, 01 Sep 2023 13:04:15 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:15 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 4/6] scripts/gen_compile_commands.py: add acknowledgments
Date: Fri,  1 Sep 2023 22:03:51 +0200
Message-ID: <20230901200353.90290-5-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901200353.90290-1-jmcosta944@gmail.com>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
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

