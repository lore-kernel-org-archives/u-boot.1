Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55740C001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 16:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D65988343;
	Wed, 17 Apr 2024 18:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BbZLc3Ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF51F87D8E; Wed, 17 Apr 2024 18:24:39 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30B5884A2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 18:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a52582ecde4so454040166b.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713371077; x=1713975877;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I15PECeAyl3y4ERABnISrGLlF5Xo0CNfGThBUsH1RZk=;
 b=BbZLc3Oked+9Ifx24JAvoGu9dDTrpvKeSBvmlaH6J4Pz+HPLGAwa553R41Wp3VykEu
 H9nQcNg7njeSmRS4QKEAos1xgSyXjp8O6EHYgFsECiPQj3vKjlN7YgarJKK+ufgUN2j6
 BYh1C6lyPVzOdOWQcah8sY2lJU1wDVEbCe/mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713371077; x=1713975877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I15PECeAyl3y4ERABnISrGLlF5Xo0CNfGThBUsH1RZk=;
 b=VwE2ZwehrfNXDWlG5Q0gNcS095Xk00JmOE/7eoHWuI0JdIoGclpfFBc4TUXSY/F//w
 FPKlsqydbtVzAHRB6NLJok/N/5j7WKTLlTWw1LcfCuf5XDOmJQ68rxMeypbOoCnfz1SV
 Af7ZMZaJLPaOwP8VMWZOcD7lIkrih6cipwusdVmMo6bvYY11WqKNsXIkT4pe4IKGrMLy
 wEIbB6rSTjTQ7PpizIRdbSzQZ1ChtOIpkS2Fh2tnAUr9aKZLcc5hKDUKJmEpYIPOGxfi
 iSyjGYOpHFEnjK8FiCNsBm1bl/4jfE0hJmikkdEV4ZuJx9WwlQI31zgJRDNe6AhCULos
 2Vpw==
X-Gm-Message-State: AOJu0YxvUyIlAFHLbrDQUkTEmwy+emdhVtZE9UBfbEJh2x0n0y7YH90d
 F1x/efNczFO1A47qEHWnBJA9sJDC/jlDDbXATUmq4bkokQzeowTeayqX5vh9KyQuHUWfyOvRIlK
 fSjU=
X-Google-Smtp-Source: AGHT+IHjgBg0KryRSDvEeZnRI1K3Bed/gCtHws7E35r+tDGdP8134OdnE1ele1vypSdm/a6PZfZHaw==
X-Received: by 2002:a17:906:3e17:b0:a55:612b:cca0 with SMTP id
 k23-20020a1709063e1700b00a55612bcca0mr6825eji.27.1713371077004; 
 Wed, 17 Apr 2024 09:24:37 -0700 (PDT)
Received: from andrea-amarula.ipgroup.local (212-57-59-66.xdsl.deanconnect.nl.
 [212.57.59.66]) by smtp.gmail.com with ESMTPSA id
 og50-20020a1709071df200b00a51ba0be887sm8315112ejc.192.2024.04.17.09.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 09:24:36 -0700 (PDT)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, flavia.caforio@amarulasolutions.com,
 Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Subject: [PATCH] .gitignore: Add files produced by TI platform
Date: Wed, 17 Apr 2024 18:24:34 +0200
Message-Id: <20240417162434.524878-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Apr 2024 18:32:31 +0200
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

Add files produced by compilation of TI platforms:

*.ti-secure(-rom)
*.map
*-board-config
custMpk.pem
*.bin_*
*.fit
*.itb
tispl.bin_unsigned

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
---
 .gitignore | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index be137040a2..870c3f1819 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 *.a
 *.asn1.[ch]
 *.bin
+*.bin[_.]*
 *.cfgout
 *.cover
 *.dtb
@@ -17,23 +18,27 @@
 *.dtb.S
 *.elf
 *.exe
+*.fit
 *.gcda
 *.gcno
 *.i
 *.img
+*.itb
 *.lex.c
 *.lst
+*.map
 *.mod.c
 *.mbx
 *.o
 *.o.*
 *.order
 *.patch
+*.pem
 *.s
 *.su
 *.swp
 *.tab.[ch]
-
+*.ti-*
 # Build tree
 /build*
 
-- 
2.34.1

