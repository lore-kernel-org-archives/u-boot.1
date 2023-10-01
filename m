Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907EDE748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51FB870C1;
	Sun,  1 Oct 2023 12:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EOtfyjgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC41870B2; Sun,  1 Oct 2023 12:00:50 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5F6870A8
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32483535e51so3513857f8f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154447; x=1696759247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=EOtfyjgoD1GM/8aeiu5tncAxuSDurz0UVSzdkFWPjtmNXmCV6/ZxKDkXlSFgjclbTB
 nGwaRfJH4KfXIq4WyIbfIaJN/4CA4WTZ8QmwlJIDgSgKtyiAxwb9P4OUg5xI816p+SIT
 v5Nxljy60+VmiJGcaCkUT41R33TkThepT0/5f7qUssyuYFTib5tJ37mEP8Xs3rOMvWdf
 Ozzs4niM6aJ4Cfjax+2SC+DROez3CVmgx037anLekKTe/QaknPc1pSgREdemebHPIgBr
 xvOenATu7najNDZaZqOlhjxmMM9DFNN7piUvAPfrNA7OmHuqv2OGyggcWIq/eQg+NiL5
 UvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154447; x=1696759247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nquaMTUkKEj9f0VDmD18sTp9HY+/Vhfo0qP8M2hbUps=;
 b=dkCF0QDOHpl7FU+Ul9X1MGpbrmySQJT1imqMUV0HXvmdNrcpZGDxx84zmnPYYgJnWJ
 ZpYUOykNfVPd+e3ANJUd9TJwLh0NqE4G4n3IKLvY0a5q1h4+cihDg6jlC79LMjobmNI1
 8c58q9CUqv6x2m70pt4B+06FBUvvZmnw01dDvk9lc/jP/bCjy2CZYU4HA3l5yjCGXn4c
 UlnSZEv+E059g5K7ZEy177hdSLZJ/K8jjOhGHVPY2rOAWYKowYOgpyMnNZ6YzumPp0OB
 jUrhKPaGTT9XWtS5UduSoPaiMhSlRHXguN3UO1dNiV/lrcqi2D+CmQXuK72IsKZUA9+6
 bYfw==
X-Gm-Message-State: AOJu0YwG+6Ch8VtiDzp2uIqbJ98NrUk+f82BTiufde0rXhpNgpR/mdOO
 TWBZMAEMpBAmY+qRD8lGND3A2Exsc+gmOlic
X-Google-Smtp-Source: AGHT+IFRx6ZOsJzKwkPVsoqmTNKeBZ92rpMKsbCbJiGlV5falaZARlm6ojN+ZdKvWOfuig6ZLNwEmw==
X-Received: by 2002:a5d:63cb:0:b0:319:6e3f:d5f0 with SMTP id
 c11-20020a5d63cb000000b003196e3fd5f0mr8307876wrw.44.1696154447574; 
 Sun, 01 Oct 2023 03:00:47 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:47 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 4/8] scripts/gen_compile_commands.py: add acknowledgments
Date: Sun,  1 Oct 2023 12:00:32 +0200
Message-ID: <20231001100036.34936-5-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
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

