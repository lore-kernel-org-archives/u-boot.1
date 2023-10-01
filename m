Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86033E748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1563B870B7;
	Sun,  1 Oct 2023 12:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4WSLwYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D988870BB; Sun,  1 Oct 2023 12:00:51 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E46B870AE
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405497850dbso136160235e9.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154448; x=1696759248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/rN6hpA6RUR8xcynsTbN4wgdal1KH5zv5tVJu4j/8A=;
 b=d4WSLwYzY0rczk17UHF7lgtnSHqrOgfhwDBpvkRoxRDuCXGDjun0GDuJ8xQKy8ZZP4
 V3Za1vde/EQz6uXkU2RrzIyorYY4wktAN1TpwRqckBxE3VeSmk9klkcfITeVRNHJl+6i
 JdSCh/PshEXM1Bzun/LIZyAxQQOJ6WH/l79db0DfSHY1yNDmjNPL7USvOqhxrVgOVWJ0
 lWXHDtVR/5X4o+7u//LyJICGbUsLQuMAXM4qgmZ9MV81xci0ErtcgDpSxjPx35q08p4M
 XMCwUiZiEdB2Isz8iM+dmbkEVuA85mXQ7imTuTR1+ToddS3Iv0kOxbCfHi4eb87d8nzG
 cLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154448; x=1696759248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/rN6hpA6RUR8xcynsTbN4wgdal1KH5zv5tVJu4j/8A=;
 b=cEOFqBOpyFcGkO6Oo79H1/RfKOt7lSeHncRbmlZB0C6IeuX/aCEI/3Xc9G4RTHYKaa
 zS4FAp2fyT4G8eWVbHUw0y4dXrTLxTMO38tdluf6Peo4WqbdeCLB1y9f3GxAmaWKsttQ
 +9Sm9e+eF1IOLZpAyzYesB19cXdomvHPQ01V3b+uZ+beQq0fRTfwujKVFVJ/p+5KJPt2
 jIXSZMX8ulwmDyI3xetuvGwujrBMI6Yya64o2tW63A4RdMvfomQcjZ2FyEkMdtrI3rp4
 OxCMub/Ovq7rMoAiMKDpqvU97w4mvaFQnxO+6VbMnMgQtENXSIcj2B7mQV9Nza+h9nHO
 v4sw==
X-Gm-Message-State: AOJu0YwJsUF6XpJoIR+18Gn4IhUEYV7OLitimKFHPqfV+0U901aEkAvz
 TV6eDe9Fq3Ct+CnxbT3do/EGSRwUf2RCgZL0
X-Google-Smtp-Source: AGHT+IFXxjPkMxfQeit3xukWHz22VCZlDYbSWCX2EJq1iSHAsWjVvvsE+ejg+ssi/HmqpF8UEmiE7A==
X-Received: by 2002:a5d:5384:0:b0:31f:fa61:961b with SMTP id
 d4-20020a5d5384000000b0031ffa61961bmr7376271wrv.66.1696154448489; 
 Sun, 01 Oct 2023 03:00:48 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:47 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 5/8] .gitignore: add compile_commands.json
Date: Sun,  1 Oct 2023 12:00:33 +0200
Message-ID: <20231001100036.34936-6-jmcosta944@gmail.com>
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

