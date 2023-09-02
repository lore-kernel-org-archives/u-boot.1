Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC19C001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEEE867C3;
	Sat,  2 Sep 2023 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+ZTb5xE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2FB867B6; Sat,  2 Sep 2023 16:53:27 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A27AD86824
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-402be83929eso295915e9.3
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666404; x=1694271204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/rN6hpA6RUR8xcynsTbN4wgdal1KH5zv5tVJu4j/8A=;
 b=Z+ZTb5xExRCEED5GukbDlWtm3WCmZW3biAbsdVBbMQQgnU65yAlyXC9/fVoVeCDUFP
 UosWg0IV9lDoE0H4E94jXt8AebulhWeQwQCN9sTZ0BkMJSNhqvOJsqb3wMfV6Ee4pDIG
 pHc1FJoGG6XcunYJyA+bAutknvkQJckGkwsQvQbG0XCSzlqw6g0MMfGwDPezkAp+Y7Y6
 L8npO5mRalmjOPNie/sbAbtUn20Mc0Vx8QPWiooppS0FTf/Ny/grxHnGO4Xwfd5DXBdk
 3mVr0wimffyGmmb0oculQChU7J7ZzgPOfzDmIewUf3mO9UBWcvqoIiAdp1gGhWlnHSkD
 axKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666404; x=1694271204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/rN6hpA6RUR8xcynsTbN4wgdal1KH5zv5tVJu4j/8A=;
 b=b1sybVETQX7fA8XvuFcX3oe5dCNoqUJzGA73zEAIHZ0O8PwX4bt/8t4ULwuSCHgcmh
 t2y/jXy2K2F/YXExLBhAI9oBlaEQB8kY5POfF6n/takBKIsj09OgTPwvyQwCfOCKQz/3
 /ms0GgNf3RZXNfkFE/sqK0549jHhMVIyUn5e9UYOpUaTvDCJ9HRL8otV/ujRGCwNEmgV
 IqNsf6+4D2szh7oDeJPA8Aeh1dwxB1lvpf8+Pfso8fHIbACjqRWzEalJamnInIY1VXGG
 Uz0N0Icc9AaTFvFcN5yIMTRPfIefj0xKrC0MYDs2RT3k/eE9vEdlEVXXqiRheVuARMy7
 hPjQ==
X-Gm-Message-State: AOJu0Yw8z6Ui/OZNAjGpG7Yj9SlfSFuY6q4xlN2u8//Mu6jxDj8ltznu
 3Wieqw8am0wlqdgBML1kpbjg6HrWnWdPFzIn
X-Google-Smtp-Source: AGHT+IHuPAH+s3vDEUBeNHf+SHGGhgDmWY0xoWoMCdZYK1HUGj2hP/+rdG+D0BhoBBGogGXlA6bHCQ==
X-Received: by 2002:a5d:4683:0:b0:31c:3013:9fa5 with SMTP id
 u3-20020a5d4683000000b0031c30139fa5mr4243832wrq.59.1693666403896; 
 Sat, 02 Sep 2023 07:53:23 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:23 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 5/7] .gitignore: add compile_commands.json
Date: Sat,  2 Sep 2023 16:53:08 +0200
Message-ID: <20230902145310.107054-6-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902145310.107054-1-jmcosta944@gmail.com>
References: <20230902145310.107054-1-jmcosta944@gmail.com>
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

Add Clang's compilation database file (i.e. compile_commands.json) to
.gitignore, at the root of the repository.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 002f95de4f..261a1d6754 100644
--- a/.gitignore
+++ b/.gitignore
@@ -109,3 +109,6 @@ __pycache__
 
 # moveconfig database
 /moveconfig.db
+
+# Clang's compilation database file
+/compile_commands.json
-- 
2.41.0

